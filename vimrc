" An example for a vimrc file.
"
" Maintainer: a18ccms <a18ccms@gmail.com>
" Last change: 2010 03 12
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc
 
call pathogen#infect()

set history=50   " keep 50 lines of command line history
set showcmd   " display incomplete commands
 
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
\ | wincmd p | diffthis
 
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
set lines=35
set columns=120
set clipboard+=unnamed
set iskeyword+=_,$,@,%,#,-
set linespace=0
set wildmenu

filetype on
filetype plugin on
filetype indent on
 
syntax on
 
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'

highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White
 
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set cmdheight=2
set backspace=2
set whichwrap+=<,>,h,l
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set shortmess=atI
set report=0
set noerrorbells
set fillchars=vert:\ ,stl:\ ,stlnc:\
 
set showmatch
set matchtime=5
set ignorecase
set hlsearch
set incsearch
set scrolloff=3
set novisualbell
 
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
set laststatus=2
 
set formatoptions=tcrqn
set autoindent
set smartindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nowrap
set smarttab
 
if has("autocmd")
   autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
   autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
   autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o
   autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
   autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
endif " has("autocmd")
 
"设置Java代码的自动补全
au FileType java setlocal omnifunc=javacomplete#Complete
 
let mapleader = "."
imap <leader>; <C-X><C-O>
 
map <F4> :NERDTree<CR>
map <F5> :call CompileRun()<CR>
map <C-F5> :call Debug()<CR>
map <F6> :call Run()<CR>
 
"设置代码格式化快捷键F3
map <F3> :call FormartSrc()<CR>
 
"设置tab操作的快捷键，绑定:tabnew到<leader>t，绑定:tabn, :tabp到<leader>n,
"<leader>p
map <leader>t :tabnew<CR>
map <leader>n :tabn<CR>
map <leader>p :tabp<CR>
 
"使用<leader>e打开当前文件同目录中的文件
if has("unix")
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif
 
"定义CompileRun函数，用来调用进行编译和运行
func CompileRun()
exec "w"
"C程序
if &filetype == 'c'
exec "!del %<.exe"
exec "!gcc % -o %<.exe"
exec "!%<.exe"
elseif &filetype == 'cpp'
exec "!del %<.exe"
exec "!g++ % -o %<.exe"
exec "!%<.exe"
"Java程序
elseif &filetype == 'java'
exec "!del %<.class"
exec "!javac %"
exec "!java %<"
endif
endfunc
"结束定义CompileRun
 
"定义Run函数，用来调用进行编译和运行
func Run()
exec "w"
"C程序
if &filetype == 'c'
exec "!%<.exe"
elseif &filetype == 'cpp'
exec "!%<.exe"
"Java程序
elseif &filetype == 'java'
exec "!java %<"
endif
endfunc
"结束定义Run
 
"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!del %<.exe"
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'cpp'
exec "!del %<.exe"
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
"Java程序
exec "!del %<.class"
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunc
"结束定义Debug
"定义FormartSrc()
func FormartSrc()
exec "w"
"C程序,Perl程序,Python程序
if &filetype == 'c'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'cpp'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'py'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
"Java程序
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
exec "e! %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'html'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
 
elseif &filetype == 'htm'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
 
endif
endfunc
"结束定义FormartSrc
 
au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

au FileType html set textwidth=0
 
" 用空格键来开关折叠
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
 
" highlight files
au BufRead,BufNewFile *.as set filetype=actionscript
au BufRead,BufNewFile *.json set filetype=json
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

; multi-segment executable file template.
  ; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
     include 'emu8086.inc'
     

data segment
 
    conn4 db ' ' ,' ',' ',' ',' ',' ',' '
          db ' ' ,' ',' ',' ',' ',' ',' '
          db ' ' ,' ',' ',' ',' ',' ',' '
          db ' ' ,' ',' ',' ',' ',' ',' '
          db ' ' ,' ',' ',' ',' ',' ',' '
          db ' ' ,' ',' ',' ',' ',' ',' '
          len equ ($-conn4)
         CHA DB 88     
         WIN DB 0  
            ll_ dw 35
            countt dw 0       
         
           DASH DB "    |$"   
           DASHAT DB "--------------$"     
           
           NL DB 10,13,"$"
                   
    NUM DB "1|2|3|4|5|6|7|$"
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0) 
    
ends

code segment
start:
; set segment registers:

       mov ax, data
    mov ds, ax
    mov es, ax  

     CALL DISP
  ST:  
  
  
  CALL CHANGE_X       

 CALL CHECK_INP  
     CKI:
 
  call disp 
              
      
  CALL is_win
  returnTo:   
  
   is_w_inn:  
   
   
  
  
   
  
 JMP ST   
 
 ;;;;;;;;;;;;;;;;;;;;;;;
     is_win proc
          mov ax, data
    mov ds, ax
    mov es, ax  

    call row_check
    call column_check
    call Diagonal_Check
    call above_Diagonal
    call rev_diagonal
    call above_rev_diagonal
    ret 
    is_win endp   
     
  
; In check row function start to compare each cell with its next one in next position (in same
;  row) if adjacent items became 4 items in this case this message is printed
;  PRINT THE WINNER IS !!::' and print the winner either X or O .
;  In case if first row is checked without no player is win the counter jump to next row and
;  repeat this process.

    
    row_check proc                 
                     ;;;;;;;ROW CHECK   
                     
                    
    MOV DI,(LEN)  
    UPP:
    MOV WIN ,0                 
    SUB DI,7
    MOV SI,DI    
    CMP SI,0         
    JL EXT
    MOV CX,6
    WINL:  
    MOV AL,CONN4[SI]
    MOV BL,  CONN4[(SI+1)]  
    CMP AL,032
    JE Spac     
    CMP bl,al
    JE INCW  
    SKIP:
    MOV WIN,0  
     CHISWIN:  
         INC SI
    LOOP WINL       
     
     JMP UPP  
   
     SPAC:
     INC countt
     CMP countt ,4
     jge ext
     jmp skip 
     
       
    INCW:    

   
    INC WIN
    CMP WIN,3
    JE WINNER
    JMP CHISWIN
   
    
    WINNER:                  
    PRINTN
    PRINT 'THE WINNER IS !!::'
    CMP CHA,088
    JE PX
    PRINT 'O'
    HLT
    PX:
    PRINT 'X'
    HLT
       
    
   
    EXT:
    ret        
    
 row_check endp     
  
 ;;;;;;;;;;;;;;;;;;;;;;;;;;   
 
 
 
 
 
;  In check column function start to compare each cell with its next one in column its index+7 (in same column) 
;if adjacent items became 4 items in this case this message is printed 
; PRINT  'THE WINNER IS !!::'   and print the winner either X or O .
; In case if first column is full without no player is win the counter jump to next column and repeat this operation 

 
 
 
 column_check PROC 
    
                 ;;;;;; Column Check
                    
    MOV SI,LEN  
    coulm dw len   
    mov coulm ,len
    U:          
    dec coulm
    MOV WIN ,0
    mov si,coulm 
    CMP SI,35
    JL EXiiT
    MOV CX,5
   
    WINll:  
    MOV AL,CONN4[SI]
    MOV BL,  CONN4[(SI-7)]  
    CMP AL,032
    JE SKIPP       
    CMP bl,al
    JE INCREMENT  
   
    MOV WIN,0  

     isWIN:  
         sub si,7
               
                 
    LOOP WINll       
   
      SKIPP:  
     JMP U  
     
     
       
    INCREMENT:    

   
    INC WIN
    CMP WIN,3
    JE WINNER
    JMP isWIN
   
                
    
   
    EXiiT:
    ret 

  column_check endp     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    

;In diagonal check user start to check cell that has diagonals items greater than or equal 4
; first start from last row and check all its above diagonals to decrease index (-6 ) when
; start from bottom to access all diagonal items above start cell ,and increase index by 8
; when start from top to access all diagonal items where bottom of start cell, check next cell
; and its diagonals every time start to check if items is completed to 4 or not if is completed
; 4 in this case player that enter this will win else repeat this function even one player is win.

Diagonal_Check proc 
   
   mov ll_ , len
   mov countt , 0
   sub ll_, 7    
 ll_2:
 
    inc ll_
                 
    mov win,0    
    mov si,ll_   
    cmp countt ,3
    jg exit_1
    inc countt
    mov cx,6
    sub cx,countt
  
    ll:
       mov al,conn4[si]
       mov bl,conn4[(si-6)]  
       cmp al,032
       je sk
       cmp al,bl
       je inccer
       sk:
       mov win,0  
       iw:   
       sub si,6
       
           
    
       loop ll
    
    jmp ll_2
      
      
     inccer:
      inc win
      cmp win,3
      je  WINNER
      jmp iw 
      
  exit_1:
  ret
 
 Diagonal_Check endp     
                  
  ;;;;                                                        
 above_Diagonal proc
 
     mov ll_ , len
     mov countt , 0
     
    
 ll_3:
 
    sub ll_,7
                 
    mov win,0    
    mov si,ll_   
    cmp countt ,3
    jg  exit_2
    inc countt
    mov cx,6
    sub cx,countt
  
    lll:
       mov al,conn4[si]
       mov bl,conn4[(si-6)]  
       cmp al,032
       je skk
       cmp al,bl
       je inccer2
       skk:
       mov win,0  
       iw2:   
       sub si,6
       
           
    
       loop lll
    
    jmp ll_3
                   
       
  inccer2:
      inc win
      cmp win,3
      je  WINNER
      jmp iw2
                
   exit_2:
   ret     
 above_Diagonal endp    
 ;;;;;;;;;;;;;;  
 
 ;In reverse diagonal check user start to insert item into last cell in first column and start to
; increase index +8 ( si + 8 ) to insert next value in column and every time start to check if
; items is completed to 4 or not if is completed 4 in this case player that inter this will win
; else repeat this function even one player is win .
          
 rev_diagonal proc
     
   mov ll_ , 0
   mov countt , 0    
 ll_4:
 
    inc ll_
                 
    mov win,0    
    mov si,ll_   
    cmp countt ,3
    jg exit_3
    inc countt
    mov cx,6
    sub cx,countt
  
    llll:
       mov al,conn4[si]
       mov bl,conn4[(si+8)]  
       cmp al,032
       je skp
       cmp al,bl
       je inccer3
       skp:
       mov win,0  
       iw3:   
       add si,8
       
           
    
       loop llll
    
    jmp ll_4
      
      
     inccer3:
      inc win
      cmp win,3
      je  WINNER
      jmp iw3  
              
    exit_3:
    ret 
rev_diagonal endp
 
      ;;;           
above_rev_diagonal proc

   
     mov ll_ , 0  
     mov countt,0
    
    
 ll_5:
                  
    mov win,0    
    mov si,ll_
    
    inc countt  
    cmp countt ,3
    jg  exit_4
    mov cx,6      
    sub cx,countt
    
  
    lll1:
       mov al,conn4[si]
       mov bl,conn4[(si+8)]  
       cmp al,032
       je skp1
       cmp al,bl
       je inccer4
       skp1:
       mov win,0  
       iw4:   
       add si,8
       
    
       loop lll1
      
       add ll_,7 
    jmp ll_5
                   
       
  inccer4:
      inc win
      cmp win,3
      je  WINNER
      jmp iw4
                
             
                
    EXITI:    
    mov al,0
    jmp is_w_inn
    
    exit_4:
    ret 
above_rev_diagonal endp
    
          
;;;;;;;;;;;;;;;;;;;;;;;  

;In this function the player is changed to make another player play.

CHANGE_X proc 
           
   cmp cha,79
    Jne CHx
    CMP CHA,88
    Jne CHo
    
    
    CHO:    
    mov CHA,88
    JMP exi
    CHX:   
    MOV CHA,79
   
    EXI:
    ret
    
    print cha     
 change_x endp         
;;;;;;;;;;;;;;;;;;;;;;;  

;In check input function user start to enter a value from 1 to 7 into column and if input is valid
; (from 1 to 7) value added into column if it is complete print message “COULMN IS FULL” then call
; is_end function to check if all column are full then print “NO ONE WON” and stop the program if
; not take another input from the user and repeat this process till someone win or is_end function is
; true in these two cases program will stop 

CHECK_INP PROC
    CHIN:                              
    PRINTN
    PRINT 'ENTER X-COULMN PLEASE::',0

    MOV AH, 1
    INT 21H 
    CMP AL,(56)
    JGE MSGISNV  
    CMP AL,(48)   
    JLE MSGISNV
    SUB AX,049
    MOV SI,(LEN)  
    MOV AH,0
    ADD SI,AX 
    UP:
    SUB SI,7     
    
    CMP SI,0
    JL MSGISFULL
    CMP CONN4[SI],032      
    JNE UP    
    mov al,cha
    
    MOV CONN4[SI],al
    JMP XT         
    MSGISFULL:
   PRINTN
    PRINT 'COULMN IS FULL!!'   
      call is_endd   
  
    JMP CHIN    
    MSGISNV:
    PRINTN
    PRINT 'PLEASE ENTER A VALID COLUMN!!'   
    JMP CHIN
          
          XT:
          RET 
          CHECK_INP endp
;;;;;;;;;;;;;;;;;;;;;;;;    

;in end function both player X and O add items into all columns founded even it complete
;and no one won and print this message .
;print '!!NO ONE WON!!'

is_endd proc
    mov cx,len
mov si,0;
 co db 0
is_end: 

    isend:
  cmp conn4[si],032 
  je incr
   
   bk:     
   inc si
 loop isend
  
     jmp msgfull
    
 incr:
 inc co
 RET 
  
  msgfull:
  mov si,0
 ; mov cx,msgisend_len

   pr:
  print '!!NO ONE WON!!'

  hlt
  

  is_endd endp         
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
 
 ;in display function table 6*7 (2d array) is printed to start to enter inputs into array.
 disp proc
CALL    CLEAR_SCREEN    
mov si,0
mov cx,len 
mov ax,0
mov bl,0 

CALL NEW_LINE    
     c db 0      
     D DB 1
      mov si,0 
     mov c,0 
     
CALL NEW_LINE
CALL NEW_LINE
     CALL DASP
dis:      
             
    
      
    hi:      
      
    mov ah,0eh   
    mov al,conn4[si]

    int 10H 
    PUSH AX 
    MOV AH,2
    MOV DX, '|'
    INT 21H
    POP AX 
      
    
      cmp C,6
       je endl              
        
                inc si
                 INC C        
            
            LD: 
     
              
         
    loop hi                     

       PUSH AX
    lea dx, DASHAT
    mov ah, 9
    int 21h   
    POP AX       
    
CALL NEW_LINE
                CALL DASP     
          PUSH AX      
  
    
    lea dx, NUM
    mov ah, 9
    int 21h      
    POP AX   
CALL NEW_LINE
     JMP EX   
 
     ex: 
    RET
     ret 
      endl: 
           CALL NEW_LINE        
   CALL DASP
           
           MOV C,0 
           INC SI
         
            jmp LD
       
    hlt      
    
    
       disp endp
 
    DASP PROC
        PUSH AX 
    lea dx, DASH
    mov ah, 9
    int 21h    
    POP AX 
    RET
    dasp endp  
    NEW_LINE PROC
        PUSH AX  
        LEA DX,NL
        MOV AH,9
        INT 21H
       POP AX
       ret   
       new_line endp 
       
 ENDS                                   
   
   define_print_string 
   DEFINE_CLEAR_SCREEN




            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.


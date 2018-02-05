Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeBEOSH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:18:07 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41230 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBEOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:18:02 -0500
X-Google-Smtp-Source: AH8x226o4AYaqHAn/M/4x1c55pxocJYv6uV8/LA75M+yUnhXuKiqTAVf8LupiEYEEEKx3AsiVN7JbusUaKOlfj9IkQI=
MIME-Version: 1.0
In-Reply-To: <b24d41d767554cd5bdbd7cd4fc83d30c@AcuMS.aculab.com>
References: <20180202153240.1190361-1-arnd@arndb.de> <aa6e25c7-dc55-a5bf-39cb-8b9453604111@oracle.com>
 <1eddce614f604c518b9bf238a2f92e4b@AcuMS.aculab.com> <CAK8P3a0z72S6mY7Q7RBJ_EMCbF9DOi+RdVaUEsB_qo+rGurQ1g@mail.gmail.com>
 <b24d41d767554cd5bdbd7cd4fc83d30c@AcuMS.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 15:18:00 +0100
X-Google-Sender-Auth: BW4mqc7dgiMWfY-xAiekcXh4vSA
Message-ID: <CAK8P3a3pVqfuJ57eDndTTajFQchVUoas3=YcDW64xLLgvjbz4Q@mail.gmail.com>
Subject: Re: [PATCH] xen: hypercall: fix out-of-bounds memcpy
To: David Laight <David.Laight@aculab.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:58 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
>> Sent: 05 February 2018 12:37
> ....
>> > Are the EVTCHNOP_xxx values dense?
>> > In which case an array is almost certainly better than the switch statement.
>>
>> They are, yes. PHYSDEVOP_xxx are also consecutive by start at '4'.
>> Dan made the same comment earlier, and I replied that my I had
>> considered it but went for the more failsafe route. I also verified my
>> assumption now that gcc in fact is smart enough to turn this
>> into a table by itself:
>
> I've never spotted that optimisation, must be fairly new.

Indeed, I checked again and found that most compilers have a
less efficient jump table based version, the output I posted was
from gcc-8, this is what I get with gcc-4.8 through gcc-7:

xen_event_channel_op_compat:
        pushq   %r13    #
        pushq   %r12    #
        pushq   %rbp    #
        pushq   %rbx    #
        movl    $-38, %ebx      #, <retval>
        subq    $32, %rsp       #,
# /git/arm-soc/drivers/xen/fallback.c:14:       switch (cmd) {
        cmpl    $9, %edi        #, cmd
# /git/arm-soc/drivers/xen/fallback.c:10:       struct evtchn_op op =
{ .cmd = cmd, };
        movq    $0, 8(%rsp)     #, MEM[(struct evtchn_op *)&op + 4B]
        movq    $0, 16(%rsp)    #, MEM[(struct evtchn_op *)&op + 4B]
        movq    $0, 24(%rsp)    #, MEM[(struct evtchn_op *)&op + 4B]
        movl    %edi, 4(%rsp)   # cmd, op.cmd
# /git/arm-soc/drivers/xen/fallback.c:14:       switch (cmd) {
        ja      .L1     #,
        movl    %edi, %eax      # cmd, cmd
        jmp     *.L4(,%rax,8)   #
        .section        .rodata
        .align 8
        .align 4
.L4:
        .quad   .L9
        .quad   .L9
        .quad   .L9
        .quad   .L5
        .quad   .L5
        .quad   .L6
        .quad   .L7
        .quad   .L7
        .quad   .L7
        .quad   .L5
        .text
.L7:
# /git/arm-soc/drivers/xen/fallback.c:31:               len =
sizeof(struct evtchn_alloc_unbound);
        movl    $8, %r12d       #, len
.L3:
# /git/arm-soc/drivers/xen/fallback.c:49:       memcpy(&op.u, arg, len);
        leaq    8(%rsp), %r13   #, tmp98
        movq    %r12, %rdx      # len,
        movq    %rsi, %rbp      # arg, arg
        movq    %r13, %rdi      # tmp98,
        call    __memcpy        #
# /git/arm-soc/drivers/xen/fallback.c:50:       rc = _hypercall1(int,
event_channel_op_compat, &op);
        leaq    4(%rsp), %rdi   #, tmp104
#APP
# 50 "/git/arm-soc/drivers/xen/fallback.c" 1
        call hypercall_page+512 #
# 0 "" 2
# /git/arm-soc/drivers/xen/fallback.c:51:       memcpy(arg, &op.u, len);
#NO_APP
        movq    %r12, %rdx      # len,
        movq    %r13, %rsi      # tmp98,
        movq    %rbp, %rdi      # arg,
# /git/arm-soc/drivers/xen/fallback.c:50:       rc = _hypercall1(int,
event_channel_op_compat, &op);
        movl    %eax, %ebx      # __res.7_3, <retval>
# /git/arm-soc/drivers/xen/fallback.c:51:       memcpy(arg, &op.u, len);
        call    __memcpy        #
.L1:
# /git/arm-soc/drivers/xen/fallback.c:54: }
        addq    $32, %rsp       #,
        movl    %ebx, %eax      # <retval>,
        popq    %rbx    #
        popq    %rbp    #
        popq    %r12    #
        popq    %r13    #
        ret
.L5:
# /git/arm-soc/drivers/xen/fallback.c:25:               len =
sizeof(struct evtchn_close);
        movl    $4, %r12d       #, len
        jmp     .L3     #
.L9:
# /git/arm-soc/drivers/xen/fallback.c:16:               len =
sizeof(struct evtchn_bind_interdomain);
        movl    $12, %r12d      #, len
        jmp     .L3     #
.L6:
# /git/arm-soc/drivers/xen/fallback.c:37:               len =
sizeof(struct evtchn_status);
        movl    $24, %r12d      #, len
# /git/arm-soc/drivers/xen/fallback.c:38:               break;
        jmp     .L3     #
        .size   xen_event_channel_op_compat, .-xen_event_channel_op_compat
        .p2align 4,,15

which isn't all that bad, but gets slightly worse when you compile with
-mindirect-branch=thunk-extern, the total size now grows from 474
bytes with gcc-8 to 525 bytes with gcc-7+retpoline.

        Arnd

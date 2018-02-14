Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162909AbeBNT1W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:27:22 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33375 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162787AbeBNT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:27:18 -0500
X-Google-Smtp-Source: AH8x224nEc72bO5JooUoN6dBtsGmHzVNcsIRryyJwTEl+pmIzNQS6/CnCfNTMQG+OrMrvPKU7iybHPqRXPGArob/5so=
MIME-Version: 1.0
In-Reply-To: <20180214190629.GA21426@isilmar-4.linta.de>
References: <20180214182113.27247-1-linux@dominikbrodowski.net>
 <20180214182113.27247-4-linux@dominikbrodowski.net> <CAMzpN2iVuN-KkJMikdA0m+zsv66gTpLQS-b7eww6HfogCx1jZg@mail.gmail.com>
 <20180214190629.GA21426@isilmar-4.linta.de>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 14 Feb 2018 14:27:17 -0500
Message-ID: <CAMzpN2g4zmCyo183-n7KKAoeMa-ctmcn5YequZOGEYDydQ+EpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] x86/entry/64: move switch_to_thread_stack to
 interrupt helper function
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 2:06 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Wed, Feb 14, 2018 at 01:57:15PM -0500, Brian Gerst wrote:
>> On Wed, Feb 14, 2018 at 1:21 PM, Dominik Brodowski
>> <linux@dominikbrodowski.net> wrote:
>> > We can also move the SWAPGS and the switch_to_thread_stack to the
>> > interrupt helper function. As we do not want call depths of two,
>> > convert switch_to_thread_stack to a macro. However, as entry_64_compat.S
>> > expects switch_to_thread_stack to be a function, provide a wrapper for
>> > that, which leads to some code duplication if CONFIG_IA32_EMULATION is
>> > enabled. Therefore, the size reduction differs slightly:
>> >
>> > With CONFIG_IA32_EMULATION enabled (-0.13k):
>> >    text    data     bss     dec     hex filename
>> >   16897       0       0   16897    4201 entry_64.o-orig
>> >   16767       0       0   16767    417f entry_64.o
>> >
>> > With CONFIG_IA32_EMULATION disabled (-0.27k):
>> >    text    data     bss     dec     hex filename
>> >   16897       0       0   16897    4201 entry_64.o-orig
>> >   16622       0       0   16622    40ee entry_64.o
>> >
>> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>> > ---
>> >  arch/x86/entry/entry_64.S | 65 ++++++++++++++++++++++++++---------------------
>> >  1 file changed, 36 insertions(+), 29 deletions(-)
>> >
>> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> > index 3046b12a1acb..b60a3b692ca9 100644
>> > --- a/arch/x86/entry/entry_64.S
>> > +++ b/arch/x86/entry/entry_64.S
>> > @@ -536,6 +536,31 @@ END(irq_entries_start)
>> >         decl    PER_CPU_VAR(irq_count)
>> >  .endm
>> >
>> > +/*
>> > + * Switch to the thread stack.  This is called with the IRET frame and
>> > + * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
>> > + * space has not been allocated for them.)
>> > + */
>> > +.macro DO_SWITCH_TO_THREAD_STACK
>> > +       pushq   %rdi
>> > +       /* Need to switch before accessing the thread stack. */
>> > +       SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
>> > +       movq    %rsp, %rdi
>> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>> > +       UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
>> > +
>> > +       pushq   7*8(%rdi)               /* regs->ss */
>> > +       pushq   6*8(%rdi)               /* regs->rsp */
>> > +       pushq   5*8(%rdi)               /* regs->eflags */
>> > +       pushq   4*8(%rdi)               /* regs->cs */
>> > +       pushq   3*8(%rdi)               /* regs->ip */
>> > +       pushq   2*8(%rdi)               /* regs->orig_ax */
>> > +       pushq   8(%rdi)                 /* return address */
>> > +       UNWIND_HINT_FUNC
>> > +
>> > +       movq    (%rdi), %rdi
>> > +.endm
>> > +
>> >  /*
>> >   * Interrupt entry/exit.
>> >   *
>> > @@ -543,10 +568,17 @@ END(irq_entries_start)
>> >   *
>> >   * Entry runs with interrupts off.
>> >   */
>> > +/* 8(%rsp): ~(interrupt number) */
>> >  ENTRY(interrupt_helper)
>> >         UNWIND_HINT_FUNC
>> >         cld
>> >
>> > +       testb   $3, CS-ORIG_RAX+8(%rsp)
>> > +       jz      1f
>> > +       SWAPGS
>> > +       DO_SWITCH_TO_THREAD_STACK
>> > +1:
>> > +
>> >         PUSH_AND_CLEAR_REGS save_ret=1
>> >         ENCODE_FRAME_POINTER 8
>> >
>> > @@ -579,12 +611,6 @@ END(interrupt_helper)
>> >         .macro interrupt func
>> >         cld
>> >
>> > -       testb   $3, CS-ORIG_RAX(%rsp)
>> > -       jz      1f
>> > -       SWAPGS
>> > -       call    switch_to_thread_stack
>> > -1:
>> > -
>> >         call    interrupt_helper
>> >
>> >         call    \func   /* rdi points to pt_regs */
>> > @@ -853,33 +879,14 @@ apicinterrupt IRQ_WORK_VECTOR                     irq_work_interrupt              smp_irq_work_interrupt
>> >   */
>> >  #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
>> >
>> > -/*
>> > - * Switch to the thread stack.  This is called with the IRET frame and
>> > - * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
>> > - * space has not been allocated for them.)
>> > - */
>> > +#if defined(CONFIG_IA32_EMULATION)
>> > +/* entry_64_compat.S::entry_INT80_compat expects this to be an ASM function */
>> >  ENTRY(switch_to_thread_stack)
>> >         UNWIND_HINT_FUNC
>> > -
>> > -       pushq   %rdi
>> > -       /* Need to switch before accessing the thread stack. */
>> > -       SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
>> > -       movq    %rsp, %rdi
>> > -       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>> > -       UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
>> > -
>> > -       pushq   7*8(%rdi)               /* regs->ss */
>> > -       pushq   6*8(%rdi)               /* regs->rsp */
>> > -       pushq   5*8(%rdi)               /* regs->eflags */
>> > -       pushq   4*8(%rdi)               /* regs->cs */
>> > -       pushq   3*8(%rdi)               /* regs->ip */
>> > -       pushq   2*8(%rdi)               /* regs->orig_ax */
>> > -       pushq   8(%rdi)                 /* return address */
>> > -       UNWIND_HINT_FUNC
>> > -
>> > -       movq    (%rdi), %rdi
>> > +       DO_SWITCH_TO_THREAD_STACK
>> >         ret
>> >  END(switch_to_thread_stack)
>> > +#endif
>> >
>> >  .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
>> >  ENTRY(\sym)
>> > --
>> > 2.16.1
>> >
>>
>> Move the macro to calling.h, and inline it into the compat entry.
>
> That certainly sounds possible, but makes the macro more complex: Inlining
> means that the offsets need to be reduced by -8. But we need the current
> offset for the call from interrupt_helper. So such a change might make the
> code less readable.
>
> Thanks,
>         Dominik

It would probably be better to just open code it then, without the
return address handling.

--
Brian Gerst

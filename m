Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeBMMlN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:41:13 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34699 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:41:11 -0500
X-Google-Smtp-Source: AH8x224uCcdXS6zmQ6wlKRCK4Qo93qlFbeObHj1Hcu4aQXVWGvpw9p+98VAdOmkNGGbwSlq3Q1P24Q==
Date: Tue, 13 Feb 2018 13:41:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 8/7] TESTING_ONLY x86/entry: reduce static footprint
 of idtentry
Message-ID: <20180213124106.ycilgvmkwv2mrjt6@gmail.com>
References: <20180211104949.12992-1-linux@dominikbrodowski.net>
 <20180211104949.12992-9-linux@dominikbrodowski.net>
 <20180212093742.6tj57fh7zagio3yj@gmail.com>
 <CA+55aFwLTF3EtaQ4OpDv2UM41J=EU7gfemv=eVq+uQi31-usSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwLTF3EtaQ4OpDv2UM41J=EU7gfemv=eVq+uQi31-usSg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Feb 12, 2018 at 1:37 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Ok, so this does not look _that_ complicated, and the .text savings are
> > significant:
> 
> Honestly, I think we should do it. 3kB of assembly code is noticeable.
> 
> Also, that patch actually allows more cleanups and simplifications.
> Look at the "interrupt" macro, which is used by 'apicinterrupt3', and
> has a number of uses that way.
> 
> That code could be unified a lot, right now it does:
> 
>         testb   $3, CS-ORIG_RAX(%rsp)
>         jz      1f
>         SWAPGS
>         call    switch_to_thread_stack
> 1:
> 
>         ALLOC_PT_GPREGS_ON_STACK
>         SAVE_C_REGS
>         SAVE_EXTRA_REGS
>         ENCODE_FRAME_POINTER
> 
>         testb   $3, CS(%rsp)
>         jz      1f
> 
>         /*
>          * IRQ from user mode.
>          *
>          * We need to tell lockdep that IRQs are off.  We can't do this until
>          * we fix gsbase, and we should do it before enter_from_user_mode
>          * (which can take locks).  Since TRACE_IRQS_OFF idempotent,
>          * the simplest way to handle it is to just call it twice if
>          * we enter from user mode.  There's no reason to optimize this since
>          * TRACE_IRQS_OFF is a no-op if lockdep is off.
>          */
>         TRACE_IRQS_OFF
> 
>         CALL_enter_from_user_mode
> 
> 1:
>         ENTER_IRQ_STACK old_rsp=%rdi
>         /* We entered an interrupt context - irqs are off: */
>         TRACE_IRQS_OFF
> 
> and *all* of that could be in a helper function rather than be
> duplicated. and the apicinterrupt3 macro should end up just expanding
> to
> 
>         callq helper
>         pushq $~(\num)
>         callq \fn
>         jmp ret_from_intr
> 
> instead of expanding to all that code.
> 
> But that would require that same "save_ret" logic.
> 
> So it's not just the idtentry cases that can use this trick.
> 
> I admit that the trick isn't pretty, but it's not *horribly* ugly either.

Ok, agreed!

Dominik, could you please do this on top latest tip:master? I have applied all the 
other patches. Note that patch #8 now conflicts with recent annotation fixes.

Thanks,

	Ingo

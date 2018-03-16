Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCPRqM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:46:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34406 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeCPRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:46:10 -0400
Date: Fri, 16 Mar 2018 18:45:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316174529.GG5852@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:22:29AM -0700, Linus Torvalds wrote:
> The reason we do that
> 
>         printk(KERN_DEFAULT "CR2: %016lx\n", address);
> 
> is because WE ARE NOT PRINTING OUT THE CURRENT CR2 REGISTER!

Whoopsie!

Doh, __show_regs() reads CR2 again and there's a big fat window
in-between...

> This is really damn important.
> 
> The "address" register contains the CR2 value as it was read *very*
> early in the page fault case, before we enabled interrupts, and before
> we did various random things that can cause further page faults and
> change CR2!
> 
> So the executive summary that does __show_regs() may end up showing
> something completely different than the actual faulting address,
> because we might have taken a vmalloc-space exception in the meantime,
> for example.
> 
> Do *NOT* get rid of that thing.

Reverted.

> You're better off getting rid of the CR2 line from __show_regs(),
> because it can be dangerously confusing. It's not actually part of the
> saved register state at all, it's something entirely different. It's
> like showing the current eflags rather than the eflags saved on the
> faulting stack.

Yeah, __show_regs() goes and gets a bunch of registers at the time
__show_regs() runs. Which is ok for those which don't change in between
but CR2 is special.

We probably could improve that situation by having a struct fault_regs
or so wrapping pt_regs and adding a bunch of fields like CR2 etc. Fault
handlers would then populate fault_regs at fault time while we're atomic
and then hand this struct down to the printing path.

The printing path would fill out the rest and this way we won't have any
of that monkey business anymore.

Thoughts?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeCPRkv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:40:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751576AbeCPRku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:40:50 -0400
Date: Fri, 16 Mar 2018 12:40:49 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316174049.3dj3hsau5y4ukbd4@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:22:29AM -0700, Linus Torvalds wrote:
> On Fri, Mar 16, 2018 at 4:48 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Thu, Mar 15, 2018 at 02:01:32PM -0500, Josh Poimboeuf wrote:
> >> no_context() has the following line, right before it calls oops_end():
> >>
> >>       /* Executive summary in case the body of the oops scrolled away */
> >>       printk(KERN_DEFAULT "CR2: %016lx\n", address);
> >>
> >> I think that line can now be removed, since the executive summary
> >> __show_regs() will include CR2.
> >
> > Good idea. Done.
> 
> NOOOO!
> 
> Guys, %cr2 CAN AND DOES CHANGE!
> 
> The reason we do that
> 
>         printk(KERN_DEFAULT "CR2: %016lx\n", address);
> 
> is because WE ARE NOT PRINTING OUT THE CURRENT CR2 REGISTER!

Good point.  I missed the fact that no_context() isn't printing the
current CR2.

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
> 
> You're better off getting rid of the CR2 line from __show_regs(),
> because it can be dangerously confusing. It's not actually part of the
> saved register state at all, it's something entirely different. It's
> like showing the current eflags rather than the eflags saved on the
> faulting stack.

True, it's probably best to remove it.  The only time we need CR2's
value is presumably when it would have already been printed in
no_context(), and so it primarily just adds confusion as you said.

-- 
Josh

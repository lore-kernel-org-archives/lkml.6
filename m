Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeCPSih (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:38:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750876AbeCPSig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:38:36 -0400
Date: Fri, 16 Mar 2018 13:38:35 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316183835.2nntffoj7qottgk7@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <CA+55aFwmi38uJyir_e_TTDObBGg55WsTB_0AqcVHzgU=+Fy=ag@mail.gmail.com>
 <20180316174529.GG5852@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316174529.GG5852@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 06:45:29PM +0100, Borislav Petkov wrote:
> > You're better off getting rid of the CR2 line from __show_regs(),
> > because it can be dangerously confusing. It's not actually part of the
> > saved register state at all, it's something entirely different. It's
> > like showing the current eflags rather than the eflags saved on the
> > faulting stack.
> 
> Yeah, __show_regs() goes and gets a bunch of registers at the time
> __show_regs() runs. Which is ok for those which don't change in between
> but CR2 is special.
> 
> We probably could improve that situation by having a struct fault_regs
> or so wrapping pt_regs and adding a bunch of fields like CR2 etc. Fault
> handlers would then populate fault_regs at fault time while we're atomic
> and then hand this struct down to the printing path.
> 
> The printing path would fill out the rest and this way we won't have any
> of that monkey business anymore.
> 
> Thoughts?

It would be nice if we could save *all* the printed registers before
they get a chance to change, but I don't know how feasible that is.
Some of the registers change in entry code, like CR3 and GS.

-- 
Josh

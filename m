Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeBGUY4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:24:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754154AbeBGUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:24:55 -0500
Date: Wed, 7 Feb 2018 21:24:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Rudolf Marek <r.marek@assembler.cz>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207202435.GB19536@pd.tnic>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:43:37AM -0800, Linus Torvalds wrote:
> We could just also decide that the only thing that the modrm bytes of
> UD0 actually *affect* is how the CPU might act for a page-crossing
> instruction.
> 
> Because I think that's the only semantic difference: if it's a
> page-crosser, the instruction could take a page fault before raising
> the #UD.
> 
> Is there any other decode issue we might want to look out for?

Yes, AMD doesn't do UD0 with a ModRM:

"UD0 0F FF Raise an invalid opcode exception"

And I don't know about the other x86 vendors; what fun they've had with
the UD*.

I guess we should make sure the following bytes are a valid insn.

Btw Rudolf had experimented with this, CCed, and he showed that on Intel
you get a SIGSEGV for a page crosser with UD1 and SIGILL on AMD.

I guess you can get the same with UD0 apparently.

> Anyway, then we'd make the rule be:
> 
>  - we promise to always pad up the following bytes (our extra warning
> information etc) so that we never have a missing page afterwards (this
> is presumably practically speaking already the case). It might still
> be a page-crossing instruction, but we won't take a page fault in
> kernel space (due to it being at the end of some text sectoin or
> whatever that changes the NX bit or due to DEBUG_PAGEALLOC having
> unmapped the next page).

Yeah, I guess we can control the bytes there.

>  - we special-case the decoder so that we don't get this warning

That's easy - the decoder should simply say to upgrade objdump.

> and then we just ignore the issue entirely.
> 
> Hmm?

Sounds like a plan but with those things the devil's in the detail.
Nothing sounds too nasty now, though.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

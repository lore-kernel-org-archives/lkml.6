Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeBGTnk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:43:40 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43018 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBGTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:43:38 -0500
X-Google-Smtp-Source: AH8x227I3P5BPwKxtufmnVtSI5eOS9pOpmKa85hXRbesaFbxkLQ9sdSo3VX77gWIaO1yv4/CTeL/qVTR87IHJ3HwF+Q=
MIME-Version: 1.0
In-Reply-To: <20180207192816.GA19536@pd.tnic>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic> <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net> <20180207192816.GA19536@pd.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 11:43:37 -0800
X-Google-Sender-Auth: nMPgJJRsZQcXEGH73XA8_J4T6as
Message-ID: <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 11:28 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Feb 07, 2018 at 08:14:51PM +0100, Peter Zijlstra wrote:
>> Then someone went and wrecked it.
>
> Yeah, note says UD0 didn't eat a ModRM byte on old CPUs. But then that
> changed too. Fun stuff changing insn encoding underway.
>
> So if we opt for adding a ModRM byte, could a 0x90 NOP work so that it
> doesn't shit itself on those old CPUs?

We could just also decide that the only thing that the modrm bytes of
UD0 actually *affect* is how the CPU might act for a page-crossing
instruction.

Because I think that's the only semantic difference: if it's a
page-crosser, the instruction could take a page fault before raising
the #UD.

Is there any other decode issue we might want to look out for?

Anyway, then we'd make the rule be:

 - we promise to always pad up the following bytes (our extra warning
information etc) so that we never have a missing page afterwards (this
is presumably practically speaking already the case). It might still
be a page-crossing instruction, but we won't take a page fault in
kernel space (due to it being at the end of some text sectoin or
whatever that changes the NX bit or due to DEBUG_PAGEALLOC having
unmapped the next page).

 - we special-case the decoder so that we don't get this warning

and then we just ignore the issue entirely.

Hmm?

              Linus

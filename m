Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EABC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1837920865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1837920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeKYMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:04:52 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56286 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeKYMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:04:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 66B082238B;
        Sat, 24 Nov 2018 20:14:59 -0500 (EST)
Date:   Sun, 25 Nov 2018 12:15:07 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Kars de Jong <jongk@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
In-Reply-To: <alpine.LNX.2.21.1811212129520.275@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1811250953120.10@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au> <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com> <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
 <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com> <alpine.LNX.2.21.1811211917270.275@nippy.intranet> <CAMuHMdVexpeYVSBMXFwu5cYt3d=w9U48m_fNTuK5awhBNnsW_A@mail.gmail.com> <alpine.LNX.2.21.1811212032550.275@nippy.intranet>
 <CAMuHMdVzamshSdhDAnxdzq=YiQMvDhrE03UmJxHJLHr6g=u44Q@mail.gmail.com> <alpine.LNX.2.21.1811212129520.275@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, I wrote:

> On Wed, 21 Nov 2018, Geert Uytterhoeven wrote:
> 
> > > This suggests that either 0 or N (the latched value) would result 
> > > from a read from the counter immediately following an interrupt. Who 
> > > can say which? Just have to try it. The answer should allow us to 
> > > avoid the risk of a clocksource that jumps forwards and backwards.
> > 
> > The code in amiga_gettimeoffset() does:
> > 
> >         ticks = hi << 8 | lo;
> > 
> >         if (ticks > jiffy_ticks / 2)
> >                 /* check for pending interrupt */
> >                 if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
> >                         offset = 10000;
> > 
> 
> That _suggests_ that there's no interrupt when ticks == 0.
> 
> But look what happens next:
> 
> >         ticks = jiffy_ticks - ticks;
> > 
> >         ticks = (10000 * ticks) / jiffy_ticks;
> > 
> >         return (ticks + offset) * 1000;
> 
> If (hi << 8 | lo) == 0, and you set offset = 10000, then the return 
> value would be maximal.
> 
> Let's immediately call this function again. This time (hi << 8 | lo) == 
> N. Let's add the offset again. I'm afraid the clock just jumped 
> backwards.
> 
> So the logic you quoted has a rationale which is unrelated to the 
> question.
> 

I've learned that emulators like MAME [1] and VICE [2] have used a 
reverse-engineered description of the CIA called "A Software Model of the 
CIA6526" by Wolfgang Lorenz and an accompanying test suite [3].

That document says, "When the counter has reached zero, it is reloaded 
from the latch as soon as there is another clock waiting in the pipeline. 
In phase 2 mode, this is always the case. This explains why you are 
reading zeros in cascaded mode only (2-2-2-1-1-1-0-0-2) but not in phase 2 
mode (2-1-2)."

I think this is a good argument that a zero count will never be observed 
by reading the counter register. Hence, it seems that this conditional in 
the v3 patch,

	if (msb > 0)

is redundant and should be removed.

It could be reverted to,

	if (ticks > jiffy_ticks / 2)

which is intended to reduce the number of calls to cia_set_irq() but 
assumes low interrupt latency (below 5 ms).

Maybe the timer interrupt has a sufficiently high priority and latency is 
low? Maybe cia_set_irq() is really expensive?

I don't know the platform well enough so I'm inclined to revert. We can 
benchmark gettimeofday syscalls on elgar but is that hardware 
representative of other relevant models?

[1] 
https://github.com/mamedev/mame/commit/e2ed0490520f538c346c8bdaa9084bcbc43427cb

[2]
http://vice-emu.sourceforge.net/vice_9.html

[3]
https://www.commodore.ca/manuals/funet/cbm/documents/chipdata/cia6526.zip

-- 

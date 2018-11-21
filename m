Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7CEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF1F20831
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF1F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeKUTPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:15:06 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57980 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbeKUTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:15:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4267722D7F;
        Wed, 21 Nov 2018 03:41:25 -0500 (EST)
Date:   Wed, 21 Nov 2018 19:41:30 +1100 (AEDT)
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
In-Reply-To: <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811211917270.275@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au> <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com> <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
 <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Wed, Nov 21, 2018 at 12:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > On atari, the 68901 counts down to 0x01 and raises an interrupt. On 
> > mac, the 6522 counts down to 0xFFFF then raises an interrupt. No idea 
> > about amiga (Geert?) -- this has to be handled correctly to get a 
> > monotonic clocksource. I'll fix this in v3 (where the information is 
> > available).
> 
> The docs state that the CIA generates on interrupt on underflow, so I 
> guess that's the same behavior as the 6522 VIA.
> 

Difficult to say. The sequence varies from one implementation to another. 
Let's ignore the MSB and LSB and pretend it's one register:

MC68901: N, N-1, N-2, ..., 2, 1, N, N-1, N-2, ...
MC6840:  N, N-1, N-2, ..., 2, 1, 0, N, N-1, N-2, ...
SY6522:  N, N-1, N-2, ..., 2, 1, 0, 0xFFFF, N, N-1, N-2, ...

Now the question is, when the timer asserts its interrupt, and the count 
register is fetched immediately, what value does it have?

For the MC68901, you get 1. For the SY6522, you get 0xFFFF. For MC6840, as 
far as I can tell, you'd get 0.

I'll add some code to my github repo to find out what happens with CIA.

> Unfortunately the 24-bit ("TOD") counters in the two CIAs run from HSYNC 
> resp. VSYNC, which depends on the video mode, and thus can't be used as 
> a monotonic clock source.
> 

Is that because of video mode changes? Could the clocksource be 
unregistered before the mode change and then re-registered at a different 
frequency afterwards?

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC823C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4340B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4340B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKUJpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:45:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50234 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKUJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:45:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 653E5281BE;
        Tue, 20 Nov 2018 18:13:41 -0500 (EST)
Date:   Wed, 21 Nov 2018 10:13:46 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Kars de Jong <jongk@linux-m68k.org>
cc:     geert@linux-m68k.org, philb@gnu.org, schwab@linux-m68k.org,
        arnd@arndb.de, schivers@csc.com.au, tglx@linutronix.de,
        daniel.lezcano@linaro.org, schmitzmic@gmail.com,
        john.stultz@linaro.org, linus.walleij@linaro.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
In-Reply-To: <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au> <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Kars de Jong wrote:

> Op ma 19 nov. 2018 om 02:10 schreef Finn Thain <fthain@telegraphics.com.au>:
> >
> > hp300_gettimeoffset() never checks the timer interrupt flag and will
> > fail to notice when the timer counter gets reloaded. That means the
> > clock could jump backwards.
> >
> > Remove this code and leave this platform on the 'jiffies' clocksource.
> > Note that this amounts to a regression in clock precision. However,
> > adopting the 'jiffies' clocksource does resolve the monotonicity issue.
> >
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> > hp300_gettimeoffset() cannot be used in a clocksource conversion
> > unless it can be made monotonic. I can't fix this without knowing the
> > details of the timer implementation, such as the relationship between
> > the timer count and the interrupt flag.
> 
> I don't really like this regression...
> 

Me neither...

I'll see if I can write a conversion patch based on the information you've 
provided. Can you test it?

> According to NetBSD sources, there are 3 timers in the chip (originally 
> an MC6840 PTM).

Thanks for the tip. I will examine the datasheet for the 6840.

I'll also take another look at the NetBSD code.

> Timer 1 is used as the system timer, timer 3 runs at the same rate and 
> is unused on Linux (on NetBSD it is used as the statistics/profiling 
> timer), and timer 3 is connected to timer 2 so you can make a 32-bit 
> timer out of the two timers together (also unused on Linux).
> 
> Timers 1 counts down at 25 MHz.

You mean, 250 kHz, right? The code in mainline programs the timer for 2500 
cycles, hoping to get 10 ms. That is, 250 cycles per ms.

> The interrupt flag is set when the counter reaches 0 after which it is 
> automatically reloaded and starts counting down again.
> 

Thanks.

On atari, the 68901 counts down to 0x01 and raises an interrupt. On mac, 
the 6522 counts down to 0xFFFF then raises an interrupt. No idea about 
amiga (Geert?) -- this has to be handled correctly to get a monotonic 
clocksource. I'll fix this in v3 (where the information is available).

-- 

> > ---
> >  arch/m68k/hp300/time.c | 19 -------------------
> >  1 file changed, 19 deletions(-)
> 

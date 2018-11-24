Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF59C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F3920868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F3920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeKXNzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:55:31 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56486 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeKXNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:55:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6442C27813;
        Fri, 23 Nov 2018 22:08:41 -0500 (EST)
Date:   Sat, 24 Nov 2018 14:08:49 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
In-Reply-To: <9035c015-85ef-6d14-d12c-f1d5002ee49a@gmail.com>
Message-ID: <alpine.LNX.2.21.1811241357040.317@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au> <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com> <mvmk1l8m5hg.fsf@linux-m68k.org>
 <9035c015-85ef-6d14-d12c-f1d5002ee49a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018, Michael Schmitz wrote:

> 
> Am 20.11.2018 um 23:02 schrieb Andreas Schwab:
> > On Nov 20 2018, Linus Walleij <linus.walleij@linaro.org> wrote:
> > 
> > > Yes you already see the same as I see: this chip MK68901 has no less 
> > > than four timers. I bet the kernel is just using one of them, out of 
> > > habit.
> > 
> > Note that not all timers can be used freely.  Some of them are 
> > hardwired to generate the clock for the serial interfaces.
> 
> Timer A is used by the DMA sound driver - no workaround possible there.
> 
> Timer B is used by the framebuffer driver, but it's used only once to 
> reprogram the screen base address at driver init. This one could 
> potentially be used after framebuffer init to improve the clocksource 
> accuracy.
> 

I don't think it would make a good clocksource as MFP timers are all 8 
bits wide. It could be used as a clock event device in the course of a 
GENERIC_CLOCKEVENTS conversion (discussed elsewhere in this thread), 
though the longest timed interrupt inverval would be only 21 ms.

-- 

> Timer D is already used to generate timer interrupts used to poll the 
> ROM port network card / USB adapters. This timer is initialized early in 
> the boot process, which prevents using the MFP UART as serial console 
> (something that I hadn't properly considered before). I'll send a patch 
> for that. I'll also consider using timer B or timer C interrupts instead 
> to poll ROM port hardware.
> 
> There are no serial drivers anymore that could use the MFP UART 
> hardware, so that point is somewhat moot at present.
> 
> Cheers,
> 
> 	Michael
> 
> > Andreas.
> > 
> 

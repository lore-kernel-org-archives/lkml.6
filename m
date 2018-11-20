Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E4C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2F20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeKTT2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:28:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56812 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKTT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:28:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D3B8329FDD;
        Tue, 20 Nov 2018 04:00:26 -0500 (EST)
Date:   Tue, 20 Nov 2018 20:00:32 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        schwab@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        schivers@csc.com.au, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/14] m68k: mac: Convert to clocksource API
In-Reply-To: <CACRpkdZdJDYaOi1HeMiS2hkjOf0gjQphGXy-Ka+m=1LbDCXPfA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811201925020.258@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <c235d0b21a648d329668f1ab436161c09d96e875.1542589838.git.fthain@telegraphics.com.au> <CACRpkdZdJDYaOi1HeMiS2hkjOf0gjQphGXy-Ka+m=1LbDCXPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Linus Walleij wrote:

> On Mon, Nov 19, 2018 at 2:22 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > Add a platform clocksource by adapting the existing arch_gettimeoffset
> > implementation.
> >
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> 
> As noted for the Amiga CIA (which is pretty much a sibling to this MOS 
> 6522 VIA) this chip also has two counters and could use one as 
> clocksource and the other as clock event.
> 
> Again I bet this is just using one timer out of habit.
> 
> It will be an easy feat to make a clean clocksource+clock event for this 
> hardware as well once this refactoring is complete.
> 

Right. Both timer 1 and timer 2 have a timed interrupt mode, and either 
could probably serve as a clock event device or a clocksource. Some Mac 
models have a second VIA with two more timers, but not all.

(As clock event devices, the longest interval you can program is about 83 
ms. As 783360 Hz, 16-bit clocksources, they wrap about 12 times every 
second.)

If you use one timer as a clock event device and the other as a 
clocksource, there are no timers left to run the existing 
timer_interrupt() handler. So this arrangement would require 
GENERIC_CLOCKEVENTS=y, right?

Then, wouldn't all relevant platforms have to support 
GENERIC_CLOCKEVENTS=y, if a single binary was to support all of those 
platforms?

-- 

> Yours,
> Linus Walleij
> 

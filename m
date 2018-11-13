Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E7E20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeKNHz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:55:27 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39324 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:55:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 11192272BD;
        Tue, 13 Nov 2018 16:55:09 -0500 (EST)
Date:   Wed, 14 Nov 2018 08:55:37 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in
 arch_gettimeoffset
In-Reply-To: <20181113092012.GI30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au> <20181112083422.GA19695@infradead.org> <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:

> On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
> > 
> > You could remove the old arch_gettimeoffset API without dropping any 
> > platforms.
> > 
> > If no-one converts a given platform to the clocksource API it would mean 
> > that the default 'jiffies' clocksource will get used on that platform.
> > 
> > Clock resolution and timer precision would be degraded, but that might not 
> > matter.
> > 
> > Anyway, if someone who has this hardware is willing to test a clocksource 
> > API conversion, they can let me know and I'll attempt that patch.
> 
> There's reasons why that's not appropriate - such as not having two
> separate timers in order to supply a clocksource and separate clock
> event.
> 
> Not all hardware is suited to the clocksource + clockevent idea.
> 

Sorry, I don't follow.

AFAIK, clocksources and clock event devices are orthogonal concepts. There 
are platforms with !ARCH_USES_GETTIMEOFFSET && !GENERIC_CLOCKEVENTS (and 
every other combination).

A clocksource read method just provides a cycle count, and in this sense 
arch_gettimeoffset() is equivalent to a clocksource.

If these two arm platforms have an existing clock event device which 
somehow precludes any new clocksources, why doesn't that also render 
arch_gettimeoffset() impossible?

-- 

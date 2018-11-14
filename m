Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777C6223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mo/GYNGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777C6223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeKNSAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:00:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39518 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbeKNSAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gKAm+hZi8QmG+hqYicP+JQsQtrnx3P40GhHigLRRN4E=; b=mo/GYNGlsfIe3MJdFnZ37cO1Q
        7SqFNFdyD3IxftrgfYzEXFkJN+ujZ1mGe88CG0GJSYnxCTeiE7EJUlYaB7NUtn+n77chSXGJJBoig
        loyQbr3TrVxzBRBCJM79/B+Cfx6/XHHeRyLDKmJWul8gbO/KaMrYml42CWWC0KIRaaADk=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42228)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMq46-0004Fl-Pj; Wed, 14 Nov 2018 07:58:22 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMq44-0004Bg-1b; Wed, 14 Nov 2018 07:58:20 +0000
Date:   Wed, 14 Nov 2018 07:58:17 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Message-ID: <20181114075817.GQ30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:35:29PM +1300, Michael Schmitz wrote:
> So we'd still have to use jiffies + interpolation from the current timer
> rundown counter as clocksource (since that will be monotonous and won't
> wrap)?
> 
> The way Finn did the clocksource for m68k, the clocksource counter does
> behave as it should (monotonous, doesn't wrap) at least so far as I've
> tested. Using the same timer for clocksource and clock events will degrade
> timekeeping based on timer events to jiffies resolution, as you point out.
> That would already have been the case before, so no gain in resolution.

... and that is where you are wrong.

RPC, for example, has gettimeofday() resolution of 500ns.  Removing
gettimeoffset() will result in a resolution of 1/HZ since there is
no longer any interpolation between interrupts.

> Other timekeeping would have worked at higher resolution before
> (interpolating through arch_gettimeoffset) just the same as now
> (interpolating through clocksource reads). Finn's clocksource read code
> essentially is arch_gettimeoffset under a new name.

Where is this code - all I've seen is code adding IRQ exclusion in
the gettimeoffset method.  If some other solution is being proposed,
then it's no good beating about the bush - show the damn code, and
then that can be considered.

However, what has been said in this thread is basically "remove the
gettimeoffset method", which is _not_ acceptable, it will cause
gettimeofday() on these platforms to lose resolution, which is a
user visible REGRESSION, plain and simple.

If what is actually meant is "we have a replacement for gettimeoffset"
then, and I'm sure we all know this, there needs to be a patch
proposed showing what is being proposed, rather than waffling around
the issue.

> Are you saying that's not possible on arm, because the current timer rundown
> counter can't be read while the timer is running?
> 
> If I were to run a second timer at higher rate for clocksource, but keeping
> the 10 ms timer as clock event (could easily do that by using timer D on
> Atari Falcon) - how would that improve my timekeeping? Clock events still
> only happen 10 ms apart ...

Ah, I think you're talking about something else.

You seem to be talking about what happens when time keeping interrupts
happen.

I'm talking about the resolution of gettimeofday() and the other
interfaces that are used (eg) for packet capture timestamping and
the like - the _user_ visible effects of the timekeeping system.

With the existing implementation, all these have better-than-jiffy
resolution - in the case of RPC, that's 500ns, rather than 10ms
which would be the case without gettimeoffset().  Removing
gettimeoffset() as Finn has proposed without preserving that
resolution is simply completely unacceptable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

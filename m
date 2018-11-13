Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70813C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBD721582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YUGCgx5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBD721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbeKNJod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:44:33 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34230 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeKNJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVDuuYcTohWhbiVlfJpAvAa+kHxWzDwlbFRZKUtc/qk=; b=YUGCgx5QTyOZwrK/VLGpQ4OSn
        +Q0j4L9FViLwv/ycdhjLvYeTTU4fHM12nZGp02/uLq3UB9kTSO5m1lTVjIKsDWvdHA85Y6dNCM+T3
        ZHN4F3gLSbF/xjyCHcUFeunso0nimQ5LOC3juNYwXKOGuNlDKBge8/WVR1d+fFciKQTY8=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:49766)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMiLO-0002HB-N6; Tue, 13 Nov 2018 23:43:42 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMiLK-00087H-Of; Tue, 13 Nov 2018 23:43:38 +0000
Date:   Tue, 13 Nov 2018 23:43:36 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Message-ID: <20181113234336.GP30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 08:55:37AM +1100, Finn Thain wrote:
> On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:
> 
> > On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
> > > 
> > > You could remove the old arch_gettimeoffset API without dropping any 
> > > platforms.
> > > 
> > > If no-one converts a given platform to the clocksource API it would mean 
> > > that the default 'jiffies' clocksource will get used on that platform.
> > > 
> > > Clock resolution and timer precision would be degraded, but that might not 
> > > matter.
> > > 
> > > Anyway, if someone who has this hardware is willing to test a clocksource 
> > > API conversion, they can let me know and I'll attempt that patch.
> > 
> > There's reasons why that's not appropriate - such as not having two
> > separate timers in order to supply a clocksource and separate clock
> > event.
> > 
> > Not all hardware is suited to the clocksource + clockevent idea.
> > 
> 
> Sorry, I don't follow.
> 
> AFAIK, clocksources and clock event devices are orthogonal concepts. There 
> are platforms with !ARCH_USES_GETTIMEOFFSET && !GENERIC_CLOCKEVENTS (and 
> every other combination).
> 
> A clocksource read method just provides a cycle count, and in this sense 
> arch_gettimeoffset() is equivalent to a clocksource.

A clocksource provides a cycle counter that monotonically changes and
does not wrap between clockevent events.

A clock event is responsible for providing events to the system when
some work is needing to be done, limited by the wrap interval of the
clocksource.

Each time the clock event triggers an interrupt, the clocksource is
read to determine how much time has passed, using:

	count = (new_value - old_value) & available_bits
	nanosecs = count * scale >> shift;

If you try to combine the clocksource and clockevent because you only
have a single counter, and the counter has the behaviour of:
- counting down towards zero
- when reaching zero, triggers an interrupt, and reloads with N

then this provides your clockevent, but you can't use this as a clock
source, because each time you receive an interrupt and try to read the
counter value, it will be approximately the same value.  This means
that the above calculation fails to register the correct number of
nanoseconds passing.  Hence, this does not work.

Also note where I said above that the clock event device must be able
to provide an interrupt _before_ the clocksource wraps - clearly with
such a timer, that is utterly impossible.

The simple solution is to not use such a counter as the clocksource,
which means you fall back to using the jiffies clocksource, and your
timekeeping has jiffy resolution - so 10ms, or possibly 1ms if you
want a 1kHz timer interval.  For most applications, that's simply way
to coarse, as was realised in the very early days of Linux.

If only there was a way to interpolate between timer interrupts...
which is exactly what arch_gettimeoffset() does, and is a historical
reminant of the pre-clocksource/clockevent days of the kernel - but
it is the only way to get better resolution from this sort of setup.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

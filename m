Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470C2224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f5y1M3El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470C2224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeKMTRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:17:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51530 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeKMTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JHTF+YLgdj1PtG9j9n0BfGIqaZn5MXxRBHxRAKlnHRA=; b=f5y1M3ElUrr/lgUz627h7c169
        tc99J2eosmkHImv2suEQY01BE/Dm+7QVTdvGpFQ1MDfEiTYwEOp1vXbVE/UayW3PmBmZUEF2picmf
        VUVXWOS3tEl8hc+fvq4isYXuGjDQKsMXsbOh0+m+yBeA8jGx/pI4+afE5D493oAUpEQh8=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39398)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMUrw-00074Z-Gq; Tue, 13 Nov 2018 09:20:24 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMUrq-0007GQ-5d; Tue, 13 Nov 2018 09:20:18 +0000
Date:   Tue, 13 Nov 2018 09:20:13 +0000
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
Message-ID: <20181113092012.GI30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
> On Mon, 12 Nov 2018, Christoph Hellwig wrote:
> 
> > On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> > > Implementations of arch_gettimeoffset are generally not re-entrant and 
> > > assume that interrupts have been disabled. Unfortunately this 
> > > pre-condition got broken in v2.6.32.
> > > 
> > > Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > 
> > This looks like a sensible fix for -stable backporting.  But with m68k
> > converted over it might be time for these two arm platforms to either
> > be converted to the clocksource API or to be dropped..
> > 
> 
> You could remove the old arch_gettimeoffset API without dropping any 
> platforms.
> 
> If no-one converts a given platform to the clocksource API it would mean 
> that the default 'jiffies' clocksource will get used on that platform.
> 
> Clock resolution and timer precision would be degraded, but that might not 
> matter.
> 
> Anyway, if someone who has this hardware is willing to test a clocksource 
> API conversion, they can let me know and I'll attempt that patch.

There's reasons why that's not appropriate - such as not having two
separate timers in order to supply a clocksource and separate clock
event.

Not all hardware is suited to the clocksource + clockevent idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

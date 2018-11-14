Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D34208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O586R77W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D34208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbeKNWI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:08:28 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42332 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeKNWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LFTqnV1S4JIKuBgB4a5qr9LQZA4sbsJFMIl8z6BIsUA=; b=O586R77W5PI5CBZuEGU83N1RJ
        PCV1I4eleHO10StVCe0PoCe3ru4foyyAchLQ05jb2MnpovmhuqaFpCDo+ja16JL4+pQ+PjFjp0lUS
        +cXM/3fzioo7Uea9JmAv0jAHyM3F8g1OeNC96MNLEUAHzIxxsyTvy0lzyvYQQXWZuU46A=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57870)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gMtuz-0005Dh-Q5; Wed, 14 Nov 2018 12:05:13 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gMtus-0006To-14; Wed, 14 Nov 2018 12:05:06 +0000
Date:   Wed, 14 Nov 2018 12:05:00 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Finn Thain <fthain@telegraphics.com.au>,
        John Stultz <john.stultz@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Message-ID: <20181114120500.GE6567@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> Implementations of arch_gettimeoffset are generally not re-entrant
> and assume that interrupts have been disabled. Unfortunately this
> pre-condition got broken in v2.6.32.

To me, it looks way worse than what you think.

The original code sequence before conversion to arch_gettimeoffset()
was:

1. lock (inc. disabling IRQs)
2. read gettimeoffset correction
3. add offset to current xtime
4. unlock

This means there is no chance for a timer interrupt to happen between
reading the current offset and adding it to the current kernel time.
If the timer does roll over, then the interrupt will remain pending,
so the whole "read offset and add to xtime" is one atomic block and
we can use the pending interrupt to indicate whether the timer has
rolled over and apply the appropriate offset correction.

With the arch_gettimeoffset() code, that changes:

1. read clocksource (which will be jiffies)
2. compute clocksource delta
3. increment nanoseconds
4. add gettimeoffset correction

If we receive a timer interrupt part-way through this, for example,
between 2 and 3, then jiffies will increment (via do_timer()) and the
interrupt will be cleared.  This means that the check in
ioc_timer_gettimeoffset() for a pending interrupt, for example, will
be false, and we will not know that an interrupt has happened.

So, unless I'm missing something, commit 5cfc8ee0bb51 well and truely
broke the accuracy of timekeeping on these platforms, and will result
in timekeeping spontaneously jumping backwards.  I had been wondering
why NTP had become less stable on EBSA110, but never investigated.

However, that still does not justify blowing away this functionality
without replacement, as Finn has been proposing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

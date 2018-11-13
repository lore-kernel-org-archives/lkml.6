Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12835C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D7221780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D7221780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeKMNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:34:48 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47724 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeKMNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:34:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id AB7AC29DCE;
        Mon, 12 Nov 2018 22:38:34 -0500 (EST)
Date:   Tue, 13 Nov 2018 14:39:00 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in
 arch_gettimeoffset
In-Reply-To: <20181112083422.GA19695@infradead.org>
Message-ID: <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au> <20181112083422.GA19695@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Christoph Hellwig wrote:

> On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> > Implementations of arch_gettimeoffset are generally not re-entrant and 
> > assume that interrupts have been disabled. Unfortunately this 
> > pre-condition got broken in v2.6.32.
> > 
> > Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> This looks like a sensible fix for -stable backporting.  But with m68k
> converted over it might be time for these two arm platforms to either
> be converted to the clocksource API or to be dropped..
> 

You could remove the old arch_gettimeoffset API without dropping any 
platforms.

If no-one converts a given platform to the clocksource API it would mean 
that the default 'jiffies' clocksource will get used on that platform.

Clock resolution and timer precision would be degraded, but that might not 
matter.

Anyway, if someone who has this hardware is willing to test a clocksource 
API conversion, they can let me know and I'll attempt that patch.

-- 

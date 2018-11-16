Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD612087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OH4PCB6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD612087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbeKQEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:00:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51950 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeKQEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b7hWjW+ASDnZALRbgpHv3ZOe1DrqF+1GQ0BFOMVNONA=; b=OH4PCB6qRvhTdhLpQmhar6HGf
        lOOWxqQEijrPjnTVomESt7PzhcA7Hfis0xmtvfp66ykFJ+FrbTK6FutD1sZ24aRrr/KEa0vgvhqpH
        TbtiAXiwxhqOv+kqnYcyICQROKBCdy/+lbjVtCp3d8qFxk+RVqLQuygdAisFR17UJW5AI=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:53825)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gNiD8-0001Lu-6y; Fri, 16 Nov 2018 17:47:18 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gNiD0-0004sD-CU; Fri, 16 Nov 2018 17:47:10 +0000
Date:   Fri, 16 Nov 2018 17:47:06 +0000
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
Message-ID: <20181116174705.GY30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 03:12:17PM +1100, Finn Thain wrote:
> The thread went way off-topic when Christoph took the opportunity to 
> suggest the removal of RPC and EBSA110. That doesn't interest me.

I suspect that is the right solution - I've been trying to get 4.19
to boot on my RPC and it's proving very difficult for several reasons,
not limited to the HDD seeming to be throwing the odd disk error, as
well as the kernel being rather large (a 4.19 kernel is 2.7M compressed
as opposed to 2.6.29 being 1.2M compressed for the equivalent
configuration.)

Given that memory on the RPC is not contiguous, that probably means
an uncompressed kernel overflows the size of the first memory bank,
so there's probably no hope for modern kernels to boot on the machine.

The EBSA110 is probably in a similar boat - I don't remember whether it
had 16MB or 32MB as the maximal amount of memory, but memory was getting
tight with some kernels even running a minimalist userspace.

So, it's probably time to say goodbyte to the kernel support for these
platforms.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

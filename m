Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D1DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF520864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FJPfyhRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FF520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406352AbeKWDzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:55:15 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37948 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404684AbeKWDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hoO6/bnacYC8/MkzPcJd6G3v7999DnuUioAiONoYoGw=; b=FJPfyhRqAyGtK5kPHw/CRDtFd
        8H3Zi1PvyPi1IMz6fZYCAFdqInQ0cd2p1H+1dMQnOw9ce1VnO+x8QuFfAwy0j9L1Zx5dX3nEBNJwP
        K62KQwHm9bad2c9T5xIdjRyCRtHZBQEsfFjthZFlSDrOnN+faek2wzrfqIwDo9gQ2BOl4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:35707)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPsZ2-000396-2o; Thu, 22 Nov 2018 17:14:52 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPsYz-0003q7-5L; Thu, 22 Nov 2018 17:14:49 +0000
Date:   Thu, 22 Nov 2018 17:14:47 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181122171446.GJ30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:09:47AM -0800, Linus Torvalds wrote:
> On Thu, Nov 22, 2018 at 9:07 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > I'm afraid that won't work very well - 32 bit platforms with 64-bit
> > addresses (LPAE) would have dma_addr_t as a 64-bit value, which
> > wouldn't fit into an unsigned long.
> 
> Good point. So we'd have to have a special IS_DMA_ERR() function that
> takes a dma_addr_t and checks the same "is it the top 4095 values".

No problem with that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

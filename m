Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333AC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEE320820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KVJNTbQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEE320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503596AbeKWVqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:46:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50016 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409527AbeKWVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=89SqnHUBJVH4SSnKUE4heYWz1CsGLkG6HBlKxGrfh/A=; b=KVJNTbQS2hUtz95SILo5ri8mn
        iYpIGO/Ejif/JzFxeVJbC82mrI9oMsim9ui/yoP02AMLqmPd8Z7xQWSEhWMQ8JRSEirpOdKrfXzbR
        WPcxmHRXCL6bWt+MzQ39fOf3akIOAhjvrP6adMyIfW2qYUkicay8b1g46hKF7415dbOa8=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:48266)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gQ9Dl-0007YV-NJ; Fri, 23 Nov 2018 11:02:02 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gQ9Dh-0005kq-Ow; Fri, 23 Nov 2018 11:01:57 +0000
Date:   Fri, 23 Nov 2018 11:01:55 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181123110155.GR30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <20181123104918.GE1586@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123104918.GE1586@8bytes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:49:18AM +0100, Joerg Roedel wrote:
> On Thu, Nov 22, 2018 at 05:52:15PM +0000, Robin Murphy wrote:
> > Unfortunately, with things like the top-down IOVA allocator, and 32-bit
> > systems in general, "the top 4095" values may well still be valid addresses
> > - we're relying on a 1-byte mapping of the very top byte of memory/IOVA
> > space being sufficiently ridiculous that no real code would ever do that,
> > but even a 4-byte mapping of the top 4 bytes is within the realms of the
> > plausible (I've definitely seen the USB layer make 8-byte mappings from any
> > old offset within a page, for example).
> 
> But we can easily work around that by reserving the top 4k of the first
> 4GB of IOVA address space in the allocator, no? Then these values are
> never returned as valid DMA handles.

Yuck.  So, if we have a 4GB non-PAE 32-bit system, or a PAE system
where we have valid memory across the 4GB boundary and no IOMMU,
we have to reserve the top 4K page in the first 4GB of RAM?

Linus' IS_DMA_ERR() solution is way more preferable, but unfortunately
it still falls short, because it knocks out the top 4K of every DMA
capable bus.

A DMA capable bus may involve some translation of the address (eg, by
simple offsetting) which means that we'd need to potentially knock out
multiple pages from the page allocator for each of those pages that
correspond to the top 4K of any DMA capable bus.  Knowing that at the
right time at boot will be fun!  It also sounds wasteful to me.

Rather than inventing magic cookies like this, I'd much rather we
sanitised the API so that we have functions that return success or
an error code, rather than trying to shoe-horn some kind of magic
error codes into dma_addr_t and subtly break systems in the process.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

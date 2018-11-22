Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07643C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1CB20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PZ4hq4h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1CB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbeKWEqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:46:07 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38586 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeKWEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N4CV8ysM1JNoWjV3SiM6rmjmtwJouHiteGJ0+jJ/54c=; b=PZ4hq4h1B0TRfePfQtDBNFoa0
        SMzuGYNOVNxZfLYs2Yxum8f/zfTnfCGvqNFNEkUckQrTyZ9VnGeZR25qXlbkJ1OMM//oQu0E2jduc
        iuE4fveWoQSvJ2FkhFpPDXtxRbm5LLUVadUIuCDhqqDHRSxzQOZIdJ29sL1phZkuYeAJY=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:54339)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPtM3-0003NI-RV; Thu, 22 Nov 2018 18:05:32 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPtM0-0004NA-Fv; Thu, 22 Nov 2018 18:05:28 +0000
Date:   Thu, 22 Nov 2018 18:05:26 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     robin.murphy@arm.com, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        joro@8bytes.org, the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org, jdmason@kudzu.us,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181122180526.GL30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:55:25AM -0800, Linus Torvalds wrote:
> On Thu, Nov 22, 2018 at 9:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Unfortunately, with things like the top-down IOVA allocator, and 32-bit
> > systems in general, "the top 4095" values may well still be valid
> > addresses -
> 
> Ugh.
> 
> > The only immediate benefit I can see is that we could distinguish cases
> > like the first which can never possibly succeed, and thus callers could
> > actually give up instead of doing what various subsystems currently do
> > and retry the exact same mapping indefinitely on the apparent assumption
> > that errors must be transient.
> 
> No, the big immediate benefit of allowing "return -EINVAL" etc is
> simply legibility and error avoidance.
> 
> It's basically how pretty much all the rest of the kernel returns
> errors, so not only is it very obvious, it's also what people do
> without even thinking.. So it would be good to work.

An alternative idea would be to migrate away from the
dma_map_single() and dma_map_page() interfaces that return a
dma_addr_t, and instead have them return an error code or zero
on success.

I've thought for some time that our DMA interfaces aren't particularly
friendly, especially after we had the stuff with PCI DMA which migrated
its way into the DMA API:

DEFINE_DMA_UNMAP_ADDR
DEFINE_DMA_UNMAP_LEN
dma_unmap_*

When coupled that with the requirement that dma_unmap_*() should be
called with the same parameters as dma_map_*(), I wonder why we never
did:

struct dma_map_state {
	dma_addr_t dma_addr;
	whatever's needed;
}

int dma_map_single(struct device *dev, struct dma_map_state *state,
		   void *cpu, size_t len, enum dma_data_direction dir);
void dma_unmap_single(struct device *dev, struct dma_map_state *state);

note the simpler unmap API, which inherently guarantees that the
parameters to the map could be carried over to the unmap - without
our many driver authors having to think about it.

That also paves the way for dma_map_single() to return an error code
or zero.

However, I fear that boat sailed long ago - but maybe its worth
thinking along these lines if we want to sanitise the API now?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

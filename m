Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D39C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6A2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC6A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIGKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:10:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:37288 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIGKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:10:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w98MuS0K005214;
        Mon, 8 Oct 2018 17:56:30 -0500
Message-ID: <a0b5a36fa34c2707d829ff47fb7ebb3adf0d78b2.camel@kernel.crashing.org>
Subject: Re: [PATCH] dma-direct: document the zone selection logic
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 09:56:28 +1100
In-Reply-To: <20181008070327.GA3134@lst.de>
References: <20181001201016.32639-1-hch@lst.de>
         <20181001201016.32639-2-hch@lst.de> <20181008070327.GA3134@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 09:03 +0200, Christoph Hellwig wrote:
> Ben, does this resolve your issues with the confusing zone selection?

The comment does make things a tad clearer yes :)

Thanks !

Cheers,
Ben.

> On Mon, Oct 01, 2018 at 01:10:16PM -0700, Christoph Hellwig wrote:
> > What we are doing here isn't quite obvious, so add a comment explaining
> > it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  kernel/dma/direct.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index ba6f5956a291..14b966e2349a 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> >  	else
> >  		*phys_mask = dma_to_phys(dev, dma_mask);
> >  
> > -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> > +	/*
> > +	 * Optimistically try the zone that the physicall address mask falls
> > +	 * into first.  If that returns memory that isn't actually addressable
> > +	 * we will fallback to the next lower zone and try again.
> > +	 *
> > +	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
> > +	 * zones.
> > +	 */
> >  	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> >  		return GFP_DMA;
> >  	if (*phys_mask <= DMA_BIT_MASK(32))
> > -- 
> > 2.19.0
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> ---end quoted text---


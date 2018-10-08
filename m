Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BBC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCC02087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCC02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeJHONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:13:42 -0400
Received: from verein.lst.de ([213.95.11.211]:46038 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHONm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:13:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6650668C73; Mon,  8 Oct 2018 09:03:27 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:03:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: document the zone selection logic
Message-ID: <20181008070327.GA3134@lst.de>
References: <20181001201016.32639-1-hch@lst.de> <20181001201016.32639-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001201016.32639-2-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, does this resolve your issues with the confusing zone selection?

On Mon, Oct 01, 2018 at 01:10:16PM -0700, Christoph Hellwig wrote:
> What we are doing here isn't quite obvious, so add a comment explaining
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ba6f5956a291..14b966e2349a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>  	else
>  		*phys_mask = dma_to_phys(dev, dma_mask);
>  
> -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +	/*
> +	 * Optimistically try the zone that the physicall address mask falls
> +	 * into first.  If that returns memory that isn't actually addressable
> +	 * we will fallback to the next lower zone and try again.
> +	 *
> +	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
> +	 * zones.
> +	 */
>  	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>  		return GFP_DMA;
>  	if (*phys_mask <= DMA_BIT_MASK(32))
> -- 
> 2.19.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

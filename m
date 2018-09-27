Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4492BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C5B2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbeLOJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:20:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:45911 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeLOJUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:20:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8R1VIxf006416;
        Wed, 26 Sep 2018 20:31:20 -0500
Message-ID: <1cc6fe2f60baa1aae28a143320378622edbd3284.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Sep 2018 11:31:18 +1000
In-Reply-To: <20180920185247.20037-3-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
         <20180920185247.20037-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-20 at 20:52 +0200, Christoph Hellwig wrote:
> This is somewhat modelled after the powerpc version, and differs from
> the legacy fallback in use fls64 instead of pointlessly splitting up the
> address into low and high dwords and in that it takes (__)phys_to_dma
> into account.

This looks like it will be usable if/when we switch powerpc to
dma/direct.c

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-direct.h |  1 +
>  kernel/dma/direct.c        | 21 ++++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 86a59ba5a7f3..b79496d8c75b 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -55,6 +55,7 @@ static inline void dma_mark_clean(void *addr, size_t size)
>  }
>  #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
>  
> +u64 dma_direct_get_required_mask(struct device *dev);
>  void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		gfp_t gfp, unsigned long attrs);
>  void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index c954f0a6dc62..81b73a5bba54 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -53,11 +53,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>  	return true;
>  }
>  
> +static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> +		phys_addr_t phys)
> +{
> +	if (force_dma_unencrypted())
> +		return __phys_to_dma(dev, phys);
> +	return phys_to_dma(dev, phys);
> +}
> +
> +u64 dma_direct_get_required_mask(struct device *dev)
> +{
> +	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
> +
> +	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
> +}
> +
>  static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	dma_addr_t addr = force_dma_unencrypted() ?
> -		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
> -	return addr + size - 1 <= dev->coherent_dma_mask;
> +	return phys_to_dma_direct(dev, phys) + size - 1 <=
> +			dev->coherent_dma_mask;
>  }
>  
>  void *dma_direct_alloc_pages(struct device *dev, size_t size,
> @@ -296,6 +310,7 @@ const struct dma_map_ops dma_direct_ops = {
>  	.unmap_page		= dma_direct_unmap_page,
>  	.unmap_sg		= dma_direct_unmap_sg,
>  #endif
> +	.get_required_mask	= dma_direct_get_required_mask,
>  	.dma_supported		= dma_direct_supported,
>  	.mapping_error		= dma_direct_mapping_error,
>  	.cache_sync		= arch_dma_cache_sync,


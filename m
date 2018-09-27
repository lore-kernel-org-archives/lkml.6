Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418EC216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418EC216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeI0Ua4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:30:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0Ua4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:30:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 904BF7A9;
        Thu, 27 Sep 2018 07:12:28 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BD03F5BD;
        Thu, 27 Sep 2018 07:12:27 -0700 (PDT)
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
Date:   Thu, 27 Sep 2018 15:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920185247.20037-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/18 19:52, Christoph Hellwig wrote:
> This is somewhat modelled after the powerpc version, and differs from
> the legacy fallback in use fls64 instead of pointlessly splitting up the
> address into low and high dwords and in that it takes (__)phys_to_dma
> into account.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h |  1 +
>   kernel/dma/direct.c        | 21 ++++++++++++++++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 86a59ba5a7f3..b79496d8c75b 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -55,6 +55,7 @@ static inline void dma_mark_clean(void *addr, size_t size)
>   }
>   #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
>   
> +u64 dma_direct_get_required_mask(struct device *dev);
>   void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		gfp_t gfp, unsigned long attrs);
>   void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index c954f0a6dc62..81b73a5bba54 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -53,11 +53,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>   	return true;
>   }
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

I think that may as well just use __fls64() - it seems reasonable to 
assume max_dma > 0. Otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +}
> +
>   static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   {
> -	dma_addr_t addr = force_dma_unencrypted() ?
> -		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
> -	return addr + size - 1 <= dev->coherent_dma_mask;
> +	return phys_to_dma_direct(dev, phys) + size - 1 <=
> +			dev->coherent_dma_mask;
>   }
>   
>   void *dma_direct_alloc_pages(struct device *dev, size_t size,
> @@ -296,6 +310,7 @@ const struct dma_map_ops dma_direct_ops = {
>   	.unmap_page		= dma_direct_unmap_page,
>   	.unmap_sg		= dma_direct_unmap_sg,
>   #endif
> +	.get_required_mask	= dma_direct_get_required_mask,
>   	.dma_supported		= dma_direct_supported,
>   	.mapping_error		= dma_direct_mapping_error,
>   	.cache_sync		= arch_dma_cache_sync,
> 

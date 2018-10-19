Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A94ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5282087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5282087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJTAwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:52:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbeJTAwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:52:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0915080D;
        Fri, 19 Oct 2018 09:45:16 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85543F71D;
        Fri, 19 Oct 2018 09:45:14 -0700 (PDT)
Subject: Re: [PATCH 08/10] swiotlb: don't dip into swiotlb pool for coherent
 allocations
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-9-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <79603703-c93c-aa14-dc73-bbf6cd49499c@arm.com>
Date:   Fri, 19 Oct 2018 17:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 09:02, Christoph Hellwig wrote:
> All architectures that support swiotlb also have a zone that backs up
> these less than full addressing allocations (usually ZONE_DMA32).
> 
> Because of that it is rather pointless to fall back to the global swiotlb
> buffer if the normal dma direct allocation failed - the only thing this
> will do is to eat up bounce buffers that would be more useful to serve
> streaming mappings.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c |   6 +--
>   include/linux/swiotlb.h     |   5 --
>   kernel/dma/swiotlb.c        | 105 +-----------------------------------
>   3 files changed, 5 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 8d91b927e09e..eee6cfcfde9e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -112,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   		return addr;
>   	}
>   
> -	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
> +	ptr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
>   	if (!ptr)
>   		goto no_mem;
>   
> @@ -133,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>   	return coherent_ptr;
>   
>   no_map:
> -	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, ptr, *dma_handle, attrs);
>   no_mem:
>   	return NULL;
>   }
> @@ -151,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
>   			return;
>   		vunmap(vaddr);
>   	}
> -	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, swiotlb_addr, dma_handle, attrs);
>   }
>   
>   static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index f847c1b265c4..a387b59640a4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -67,11 +67,6 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
>   
>   /* Accessory functions. */
>   
> -void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t flags, unsigned long attrs);
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs);
> -
>   extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   				   unsigned long offset, size_t size,
>   				   enum dma_data_direction dir,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4d7a4d85d71e..475a41eff3dc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -622,78 +622,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>   	}
>   }
>   
> -static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
> -		size_t size)
> -{
> -	u64 mask = DMA_BIT_MASK(32);
> -
> -	if (dev && dev->coherent_dma_mask)
> -		mask = dev->coherent_dma_mask;
> -	return addr + size - 1 <= mask;
> -}
> -
> -static void *
> -swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		unsigned long attrs)
> -{
> -	phys_addr_t phys_addr;
> -
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		goto out_warn;
> -
> -	phys_addr = swiotlb_tbl_map_single(dev,
> -			__phys_to_dma(dev, io_tlb_start),
> -			0, size, DMA_FROM_DEVICE, attrs);
> -	if (phys_addr == SWIOTLB_MAP_ERROR)
> -		goto out_warn;
> -
> -	*dma_handle = __phys_to_dma(dev, phys_addr);
> -	if (!dma_coherent_ok(dev, *dma_handle, size))
> -		goto out_unmap;
> -
> -	memset(phys_to_virt(phys_addr), 0, size);
> -	return phys_to_virt(phys_addr);
> -
> -out_unmap:
> -	dev_warn(dev, "hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
> -		(unsigned long long)dev->coherent_dma_mask,
> -		(unsigned long long)*dma_handle);
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -			DMA_ATTR_SKIP_CPU_SYNC);
> -out_warn:
> -	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
> -		dev_warn(dev,
> -			"swiotlb: coherent allocation failed, size=%zu\n",
> -			size);
> -		dump_stack();
> -	}
> -	return NULL;
> -}
> -
> -static bool swiotlb_free_buffer(struct device *dev, size_t size,
> -		dma_addr_t dma_addr)
> -{
> -	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
> -
> -	WARN_ON_ONCE(irqs_disabled());
> -
> -	if (!is_swiotlb_buffer(phys_addr))
> -		return false;
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -				 DMA_ATTR_SKIP_CPU_SYNC);
> -	return true;
> -}
> -
>   static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> @@ -928,39 +856,10 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
>   	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>   }
>   
> -void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t gfp, unsigned long attrs)
> -{
> -	void *vaddr;
> -
> -	/* temporary workaround: */
> -	if (gfp & __GFP_NOWARN)
> -		attrs |= DMA_ATTR_NO_WARN;
> -
> -	/*
> -	 * Don't print a warning when the first allocation attempt fails.
> -	 * swiotlb_alloc_coherent() will print a warning when the DMA memory
> -	 * allocation ultimately failed.
> -	 */
> -	gfp |= __GFP_NOWARN;
> -
> -	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
> -	if (!vaddr)
> -		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
> -	return vaddr;
> -}
> -
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs)
> -{
> -	if (!swiotlb_free_buffer(dev, size, dma_addr))
> -		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
> -}
> -
>   const struct dma_map_ops swiotlb_dma_ops = {
>   	.mapping_error		= dma_direct_mapping_error,
> -	.alloc			= swiotlb_alloc,
> -	.free			= swiotlb_free,
> +	.alloc			= dma_direct_alloc,
> +	.free			= dma_direct_free,
>   	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
>   	.sync_single_for_device	= swiotlb_sync_single_for_device,
>   	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
> 

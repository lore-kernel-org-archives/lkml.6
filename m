Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A24C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D32064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeJBUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:45:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbeJBUpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:45:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4625218A;
        Tue,  2 Oct 2018 07:01:45 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BCF43F5A0;
        Tue,  2 Oct 2018 07:01:44 -0700 (PDT)
Subject: Re: [PATCH v2] dma-debug: Check for drivers mapping invalid addresses
 in dma_map_single()
To:     Stephen Boyd <swboyd@chromium.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181001215337.13358-1-swboyd@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <62816605-0cc9-3743-e98c-682bf7996c6c@arm.com>
Date:   Tue, 2 Oct 2018 15:01:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001215337.13358-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/18 22:53, Stephen Boyd wrote:
> I recently debugged a DMA mapping oops where a driver was trying to map
> a buffer returned from request_firmware() with dma_map_single(). Memory
> returned from request_firmware() is mapped into the vmalloc region and
> this isn't a valid region to map with dma_map_single() per the DMA
> documentation's "What memory is DMA'able?" section.
> 
> Unfortunately, we don't really check that in the DMA debugging code, so
> enabling DMA debugging doesn't help catch this problem. Let's add a new
> DMA debug function to check for a vmalloc address or an invalid virtual
> address and print a warning if this happens. This makes it a little
> easier to debug these sorts of problems, instead of seeing odd behavior
> or crashes when drivers attempt to map the vmalloc space for DMA.
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1:
>   * Update code to check for invalid virtual address too
>   * Rename function to debug_dma_map_single()
> 
>   include/linux/dma-debug.h   |  8 ++++++++
>   include/linux/dma-mapping.h |  1 +
>   kernel/dma/debug.c          | 16 ++++++++++++++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index a785f2507159..30213adbb6b9 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
>   
>   extern int dma_debug_resize_entries(u32 num_entries);
>   
> +extern void debug_dma_map_single(struct device *dev, const void *addr,
> +				 unsigned long len);
> +
>   extern void debug_dma_map_page(struct device *dev, struct page *page,
>   			       size_t offset, size_t size,
>   			       int direction, dma_addr_t dma_addr,
> @@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
>   	return 0;
>   }
>   
> +static inline void debug_dma_map_single(struct device *dev, const void *addr,
> +					unsigned long len)
> +{
> +}
> +
>   static inline void debug_dma_map_page(struct device *dev, struct page *page,
>   				      size_t offset, size_t size,
>   				      int direction, dma_addr_t dma_addr,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d23fc45c8208..99ccba66c06a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -231,6 +231,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +	debug_dma_check_single(dev, ptr, size);

Ahem...

With that (and below) fixed so that it actually compiles,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	addr = ops->map_page(dev, virt_to_page(ptr),
>   			     offset_in_page(ptr), size,
>   			     dir, attrs);
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index c007d25bee09..0f34bce82a62 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1312,6 +1312,22 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
>   #endif
>   }
>   
> +void debug_dma_check_single(struct device *dev, const void *addr,
> +			    unsigned long len)
> +{
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	if (!virt_addr_valid(addr))
> +		err_printk(dev, NULL, "DMA-API: device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
> +			   addr, len);
> +
> +	if (is_vmalloc_addr(addr))
> +		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
> +			   addr, len);
> +}
> +EXPORT_SYMBOL(debug_dma_check_single);
> +
>   void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>   			size_t size, int direction, dma_addr_t dma_addr,
>   			bool map_single)
> 

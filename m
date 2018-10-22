Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58FEC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1FA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1FA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeJWBa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:30:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJWBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:30:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A835F80D;
        Mon, 22 Oct 2018 10:11:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69C983F5D3;
        Mon, 22 Oct 2018 10:11:06 -0700 (PDT)
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-10-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
Date:   Mon, 22 Oct 2018 18:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 09:02, Christoph Hellwig wrote:
> Handle architectures that are not cache coherent directly in the main
> swiotlb code by calling arch_sync_dma_for_{device,cpu} in all the right
> places from the various dma_map/unmap/sync methods when the device is
> non-coherent.
> 
> Because swiotlb now uses dma_direct_alloc for the coherent allocation
> that side is already taken care of by the dma-direct code calling into
> arch_dma_{alloc,free} for devices that are non-coherent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 475a41eff3dc..52885b274368 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -21,6 +21,7 @@
>   
>   #include <linux/cache.h>
>   #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>   #include <linux/mm.h>
>   #include <linux/export.h>
>   #include <linux/spinlock.h>
> @@ -677,6 +678,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
>   	}
>   
> +	if (!dev_is_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)

Nit: other parts of the file are already using the "!(...)" style rather 
than "(...) == 0".

> +		arch_sync_dma_for_device(dev, phys, size, dir);
> +
>   	return dma_addr;
>   }
>   
> @@ -696,6 +701,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>   
>   	BUG_ON(dir == DMA_NONE);
>   
> +	if (!dev_is_dma_coherent(hwdev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
>   	if (is_swiotlb_buffer(paddr)) {
>   		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
>   		return;
> @@ -732,15 +741,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
>   
>   	BUG_ON(dir == DMA_NONE);
>   
> -	if (is_swiotlb_buffer(paddr)) {
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
> +	if (is_swiotlb_buffer(paddr))
>   		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
> -		return;
> -	}
>   
> -	if (dir != DMA_FROM_DEVICE)
> -		return;
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
> +		arch_sync_dma_for_device(hwdev, paddr, size, dir);
>   
> -	dma_mark_clean(phys_to_virt(paddr), size);
> +	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
> +		dma_mark_clean(phys_to_virt(paddr), size);
>   }

All these "if"s end up pretty hard to follow at first glance :(

I had a quick play at moving the cache maintenance here out into the 
callers, which comes out arguably looking perhaps a little cleaner (only 
+1 source line overall, and actually reduces text size by 32 bytes for 
my build), but sadly I can't really see any way of doing the equivalent 
for map/unmap short of duplicating the whole 3-line arch_sync_*() block, 
which just makes for a different readability problem. As you mentioned 
on patch #7, I guess this really is just one of those things which has 
no nice solution, so cosmetics aside,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

FWIW, below is my "cleanup" attempt (diff on top of the 
swiotlb-noncoherent.3 branch).

Robin.

----->8-----
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 52885b274368..43ee29969fdd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -741,23 +741,24 @@ swiotlb_sync_single(struct device *hwdev, 
dma_addr_t dev_addr,

  	BUG_ON(dir == DMA_NONE);

-	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
-		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
-
-	if (is_swiotlb_buffer(paddr))
+	if (is_swiotlb_buffer(paddr)) {
  		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
+		return;
+	}

-	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
-		arch_sync_dma_for_device(hwdev, paddr, size, dir);
+	if (dir != DMA_FROM_DEVICE)
+		return;

-	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
-		dma_mark_clean(phys_to_virt(paddr), size);
+	dma_mark_clean(phys_to_virt(paddr), size);
  }

  void
  swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
  			    size_t size, enum dma_data_direction dir)
  {
+	if (!dev_is_dma_coherent(hwdev))
+		arch_sync_dma_for_cpu(hwdev, dma_to_phys(hwdev, dev_addr),
+				      size, dir);
  	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
  }

@@ -766,6 +767,9 @@ swiotlb_sync_single_for_device(struct device *hwdev, 
dma_addr_t dev_addr,
  			       size_t size, enum dma_data_direction dir)
  {
  	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
+	if (!dev_is_dma_coherent(hwdev))
+		arch_sync_dma_for_device(hwdev, dma_to_phys(hwdev, dev_addr),
+					 size, dir);
  }

  /*
@@ -828,31 +832,28 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, 
struct scatterlist *sgl,
   * The same as swiotlb_sync_single_* but for a scatter-gather list, 
same rules
   * and usage.
   */
-static void
-swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
-		int nelems, enum dma_data_direction dir,
-		enum dma_sync_target target)
+void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sgl,
+			int nelems, enum dma_data_direction dir)
  {
  	struct scatterlist *sg;
  	int i;

  	for_each_sg(sgl, sg, nelems, i)
-		swiotlb_sync_single(hwdev, sg->dma_address,
-				    sg_dma_len(sg), dir, target);
+		swiotlb_sync_single_for_cpu(hwdev, sg->dma_address,
+					    sg_dma_len(sg), dir);
  }

  void
-swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			int nelems, enum dma_data_direction dir)
-{
-	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
-}
-
-void
-swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sgl,
  			   int nelems, enum dma_data_direction dir)
  {
-	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i)
+		swiotlb_sync_single_for_device(hwdev, sg->dma_address,
+					       sg_dma_len(sg), dir);
  }

  /*

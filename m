Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeEaRZG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:25:06 -0400
Received: from foss.arm.com ([217.140.101.70]:44052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755721AbeEaRZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:25:04 -0400
Subject: Re: [PATCH 1/2] dma-coherent: Add one parameter to save available
 coherent memory
To: Baolin Wang <baolin.wang@linaro.org>, hch@lst.de,
        m.szyprowski@samsung.com
Cc: gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org
References: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d02b2e1-dd1c-af2a-e980-29aef4aa0c00@arm.com>
Date: Thu, 31 May 2018 18:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 06:55, Baolin Wang wrote:
> It is incorrect to use mem->size to valid if there are enough coherent
> memory to allocate in __dma_alloc_from_coherent(), since some devices
> may mark some occupied coherent memory by dma_mark_declared_memory_occupied().
> 
> So we can introduce one 'avail' parameter to save the available device
> coherent memory, to valid if we have enough coherent memory for the device
> to allocate.

We already have dma_mem->size stored for other reasons, so there's 
little harm in using it for a rough sanity check to short-circuit the 
odd allocation which cannot possibly succeed, but adding machinery 
purely for the sake an ever-so-slightly more accurate, but still far 
from exhaustive, check doesn't really seem worth it.

Even if size <= dma_mem->avail there's still no guarantee that the 
allocation will actually succeed, so what benefit does the explicit 
accounting provide?

Robin.

> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   drivers/base/dma-coherent.c |   11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index 597d408..ce19832 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -18,6 +18,7 @@ struct dma_coherent_mem {
>   	unsigned long	*bitmap;
>   	spinlock_t	spinlock;
>   	bool		use_dev_dma_pfn_offset;
> +	int		avail;
>   };
>   
>   static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
> @@ -73,6 +74,7 @@ static int dma_init_coherent_memory(
>   	dma_mem->device_base = device_addr;
>   	dma_mem->pfn_base = PFN_DOWN(phys_addr);
>   	dma_mem->size = pages;
> +	dma_mem->avail = pages;
>   	dma_mem->flags = flags;
>   	spin_lock_init(&dma_mem->spinlock);
>   
> @@ -141,6 +143,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
>   					dma_addr_t device_addr, size_t size)
>   {
>   	struct dma_coherent_mem *mem = dev->dma_mem;
> +	int order = get_order(size);
>   	unsigned long flags;
>   	int pos, err;
>   
> @@ -151,7 +154,9 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
>   
>   	spin_lock_irqsave(&mem->spinlock, flags);
>   	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
> -	err = bitmap_allocate_region(mem->bitmap, pos, get_order(size));
> +	err = bitmap_allocate_region(mem->bitmap, pos, order);
> +	if (!err)
> +		mem->avail -= 1 << order;
>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>   
>   	if (err != 0)
> @@ -170,7 +175,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   
>   	spin_lock_irqsave(&mem->spinlock, flags);
>   
> -	if (unlikely(size > (mem->size << PAGE_SHIFT)))
> +	if (unlikely(size > (mem->avail << PAGE_SHIFT)))
>   		goto err;
>   
>   	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);
> @@ -182,6 +187,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   	 */
>   	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
>   	ret = mem->virt_base + (pageno << PAGE_SHIFT);
> +	mem->avail -= 1 << order;
>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>   	memset(ret, 0, size);
>   	return ret;
> @@ -244,6 +250,7 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>   
>   		spin_lock_irqsave(&mem->spinlock, flags);
>   		bitmap_release_region(mem->bitmap, page, order);
> +		mem->avail += 1 << order;
>   		spin_unlock_irqrestore(&mem->spinlock, flags);
>   		return 1;
>   	}
> 

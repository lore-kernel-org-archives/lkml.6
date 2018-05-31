Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeEaNEx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:04:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755134AbeEaNEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:04:51 -0400
Subject: Re: [PATCH 5/7] iommu/dma: add support for non-strict mode
To: Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <65cfe2f9-eb23-d81c-270e-ae80e96b6009@arm.com>
Date: Thu, 31 May 2018 14:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 08:42, Zhen Lei wrote:
> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>     capable call domain->ops->flush_iotlb_all to flush TLB.
> 2. Define a new iommu capable: IOMMU_CAP_NON_STRICT, which used to indicate
>     that the iommu domain support non-strict mode.
> 3. During the iommu domain initialization phase, call capable() to check
>     whether it support non-strcit mode. If so, call init_iova_flush_queue
>     to register iovad->flush_cb callback.
> 4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>     -->iommu_dma_free_iova. Use iovad->flush_cb to check whether its related
>     iommu support non-strict mode or not, and call IOMMU_DOMAIN_IS_STRICT to
>     make sure the IOMMU_DOMAIN_UNMANAGED domain always follow strict mode.

Once again, this is a whole load of complexity for a property which 
could just be statically encoded at allocation, e.g. in the cookie type.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++---
>   include/linux/iommu.h     |  3 +++
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4e885f7..2e116d9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -55,6 +55,7 @@ struct iommu_dma_cookie {
>   	};
>   	struct list_head		msi_page_list;
>   	spinlock_t			msi_lock;
> +	struct iommu_domain		*domain;
>   };
>   
>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
> @@ -64,7 +65,8 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>   	return PAGE_SIZE;
>   }
>   
> -static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
> +static struct iommu_dma_cookie *cookie_alloc(struct iommu_domain *domain,
> +					     enum iommu_dma_cookie_type type)
>   {
>   	struct iommu_dma_cookie *cookie;
>   
> @@ -73,6 +75,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>   		spin_lock_init(&cookie->msi_lock);
>   		INIT_LIST_HEAD(&cookie->msi_page_list);
>   		cookie->type = type;
> +		cookie->domain = domain;
>   	}
>   	return cookie;
>   }
> @@ -94,7 +97,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   	if (domain->iova_cookie)
>   		return -EEXIST;
>   
> -	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
> +	domain->iova_cookie = cookie_alloc(domain, IOMMU_DMA_IOVA_COOKIE);
>   	if (!domain->iova_cookie)
>   		return -ENOMEM;
>   
> @@ -124,7 +127,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   	if (domain->iova_cookie)
>   		return -EEXIST;
>   
> -	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
> +	cookie = cookie_alloc(domain, IOMMU_DMA_MSI_COOKIE);
>   	if (!cookie)
>   		return -ENOMEM;
>   
> @@ -261,6 +264,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	return ret;
>   }
>   
> +static void iova_flush_iotlb_all(struct iova_domain *iovad)

iommu_dma_flush...

> +{
> +	struct iommu_dma_cookie *cookie;
> +	struct iommu_domain *domain;
> +
> +	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
> +	domain = cookie->domain;
> +
> +	domain->ops->flush_iotlb_all(domain);
> +}
> +
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -276,6 +290,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   		u64 size, struct device *dev)
>   {
> +	const struct iommu_ops *ops = domain->ops;
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	unsigned long order, base_pfn, end_pfn;
> @@ -313,6 +328,11 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>   
> +	if (ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) {
> +		BUG_ON(!ops->flush_iotlb_all);
> +		init_iova_flush_queue(iovad, iova_flush_iotlb_all, NULL);
> +	}
> +
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
>   EXPORT_SYMBOL(iommu_dma_init_domain);
> @@ -392,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>   	/* The MSI case is only ever cleaning up its most recent allocation */
>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>   		cookie->msi_iova -= size;
> +	else if (!IOMMU_DOMAIN_IS_STRICT(cookie->domain) && iovad->flush_cb)
> +		queue_iova(iovad, iova_pfn(iovad, iova),
> +				size >> iova_shift(iovad), 0);
>   	else
>   		free_iova_fast(iovad, iova_pfn(iovad, iova),
>   				size >> iova_shift(iovad));
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 39b3150..01ff569 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -87,6 +87,8 @@ struct iommu_domain_geometry {
>   				 __IOMMU_DOMAIN_DMA_API)
>   
>   #define IOMMU_STRICT		1
> +#define IOMMU_DOMAIN_IS_STRICT(domain)	\
> +		(domain->type == IOMMU_DOMAIN_UNMANAGED)
>   
>   struct iommu_domain {
>   	unsigned type;
> @@ -103,6 +105,7 @@ enum iommu_cap {
>   					   transactions */
>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_NON_STRICT,		/* IOMMU supports non-strict mode */

This isn't a property of the IOMMU, it depends purely on the driver 
implementation. I think it also doesn't matter anyway - if a caller asks 
for lazy unmapping on their domain but the IOMMU driver just does strict 
unmaps anyway because that's all it supports, there's no actual harm done.

Robin.

>   };
>   
>   /*
> 

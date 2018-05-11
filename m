Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeEKNCJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:02:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752394AbeEKNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:02:07 -0400
Subject: Re: [PATCH v1 8/9] iommu: Introduce iotlb_sync_map callback
To: Dmitry Osipenko <digetx@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-9-digetx@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <da823a61-5bda-042b-c61f-d0d98f9b6e6f@arm.com>
Date: Fri, 11 May 2018 14:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508181700.5169-9-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 19:16, Dmitry Osipenko wrote:
> Introduce iotlb_sync_map() callback that is invoked in the end of
> iommu_map(). This new callback allows IOMMU drivers to avoid syncing
> on mapping of each contiguous chunk and sync only when whole mapping
> is completed, optimizing performance of the mapping operation.

This looks like a reasonable compromise - for users of 
IO_PGTABLE_QUIRK_TLBI_ON_MAP we can leave the implicit add_flush() in 
place for each individual map call, but at least move the sync() out to 
this callback, which should still be beneficial overall.

Modulo one possible nit below,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/iommu/iommu.c | 8 ++++++--
>   include/linux/iommu.h | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d2aa23202bb9..39b2ee66aa96 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1508,13 +1508,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>   int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> +	const struct iommu_ops *ops = domain->ops;
>   	unsigned long orig_iova = iova;
>   	unsigned int min_pagesz;
>   	size_t orig_size = size;
>   	phys_addr_t orig_paddr = paddr;
>   	int ret = 0;
>   
> -	if (unlikely(domain->ops->map == NULL ||
> +	if (unlikely(ops->map == NULL ||
>   		     domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
> @@ -1543,7 +1544,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>   			 iova, &paddr, pgsize);
>   
> -		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
> +		ret = ops->map(domain, iova, paddr, pgsize, prot);
>   		if (ret)
>   			break;
>   
> @@ -1552,6 +1553,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		size -= pgsize;
>   	}
>   
> +	if (ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);

Is it worth trying to skip this in the error case when we're just going 
to undo it immediately?

Robin.

> +
>   	/* unroll mapping in case something went wrong */
>   	if (ret)
>   		iommu_unmap(domain, orig_iova, orig_size - size);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee6eb31..5224aa376377 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -206,6 +206,7 @@ struct iommu_ops {
>   	void (*flush_iotlb_all)(struct iommu_domain *domain);
>   	void (*iotlb_range_add)(struct iommu_domain *domain,
>   				unsigned long iova, size_t size);
> +	void (*iotlb_sync_map)(struct iommu_domain *domain);
>   	void (*iotlb_sync)(struct iommu_domain *domain);
>   	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
>   	int (*add_device)(struct device *dev);
> 

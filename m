Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeEWMwC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:52:02 -0400
Received: from foss.arm.com ([217.140.101.70]:54656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeEWMv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:51:58 -0400
Subject: Re: [PATCH 1/1] iommu/dma: fix trival coding style mistake
To: Zhen Lei <thunder.leizhen@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1527055369-13192-1-git-send-email-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b4086d30-035e-ae47-0c2f-b537c5481e9e@arm.com>
Date: Wed, 23 May 2018 13:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527055369-13192-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 07:02, Zhen Lei wrote:
> No functional changes.

What's the mistake?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ddcbbdb..4e885f7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	LIST_HEAD(resv_regions);
>   	int ret = 0;
> 
> +	if (!dev)
> +		return 0;

Logically, it makes no sense at all to call this function without a 
valid device; doing the check in init_domain was a deliberate decision 
to reflect that. This isn't a cleanup path shared by multiple callers 
where the "accept NULL for simplicity" argument might apply.

> +
>   	if (dev_is_pci(dev))
>   		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
> 
> @@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   		hi = iova_pfn(iovad, region->start + region->length - 1);
>   		reserve_iova(iovad, lo, hi);
> 
> -		if (region->type == IOMMU_RESV_MSI)
> +		if (region->type == IOMMU_RESV_MSI) {
>   			ret = cookie_init_hw_msi_region(cookie, region->start,
>   					region->start + region->length);
> -		if (ret)
> -			break;
> +			if (ret)
> +				break;
> +		}

Why? ret is already initialised appropriately, and the coding style even 
says that going beyond 3 levels of indentation is undesirable...

Robin.

>   	}
>   	iommu_put_resv_regions(dev, &resv_regions);
> 
> @@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
> 
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> -	if (!dev)
> -		return 0;
> 
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
> --
> 1.8.3
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

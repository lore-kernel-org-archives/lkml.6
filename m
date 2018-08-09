Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9447E21CF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9447E21CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeHINKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:10:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51976 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHINKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE33418A;
        Thu,  9 Aug 2018 03:46:36 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601283F5D4;
        Thu,  9 Aug 2018 03:46:35 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] iommu/dma: add support for non-strict mode
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-3-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e57298b0-66ec-b97c-1b36-b35bb3e1f20a@arm.com>
Date:   Thu, 9 Aug 2018 11:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533558424-16748-3-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 13:27, Zhen Lei wrote:
> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>     capable call domain->ops->flush_iotlb_all to flush TLB.
> 2. During the iommu domain initialization phase, base on domain->non_strict
>     field to check whether non-strict mode is supported or not. If so, call
>     init_iova_flush_queue to register iovad->flush_cb callback.
> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>     put off iova freeing.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 23 +++++++++++++++++++++++
>   drivers/iommu/iommu.c     |  1 +
>   include/linux/iommu.h     |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ddcbbdb..213e62a 100644
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
> @@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	return ret;
>   }
> 
> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
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
> @@ -308,6 +320,14 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
> 
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> +
> +	if (domain->non_strict) {
> +		BUG_ON(!domain->ops->flush_iotlb_all);
> +
> +		cookie->domain = domain;

cookie->domain will only be non-NULL if domain->non_strict is true...

> +		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
> +	}
> +
>   	if (!dev)
>   		return 0;
> 
> @@ -390,6 +410,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>   	/* The MSI case is only ever cleaning up its most recent allocation */
>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>   		cookie->msi_iova -= size;
> +	else if (cookie->domain && cookie->domain->non_strict)

...so we don't need to re-check non_strict every time here.

> +		queue_iova(iovad, iova_pfn(iovad, iova),
> +				size >> iova_shift(iovad), 0);
>   	else
>   		free_iova_fast(iovad, iova_pfn(iovad, iova),
>   				size >> iova_shift(iovad));
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 63b3756..7811fde 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1263,6 +1263,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> 
>   	domain->ops  = bus->iommu_ops;
>   	domain->type = type;
> +	domain->non_strict = 0;
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee..0a0fb48 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -88,6 +88,7 @@ struct iommu_domain_geometry {
> 
>   struct iommu_domain {
>   	unsigned type;
> +	int non_strict;

bool?

Robin.

>   	const struct iommu_ops *ops;
>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>   	iommu_fault_handler_t handler;
> --
> 1.8.3
> 
> 

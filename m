Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23DDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97252206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97252206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeIRWnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:20 -0400
Received: from foss.arm.com ([217.140.101.70]:48204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbeIRWnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB46015AD;
        Tue, 18 Sep 2018 10:09:48 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D19F3F5BD;
        Tue, 18 Sep 2018 10:09:48 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7D53A1AE1396; Tue, 18 Sep 2018 18:10:07 +0100 (BST)
Date:   Tue, 18 Sep 2018 18:10:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v7 2/6] iommu/dma: Add support for non-strict mode
Message-ID: <20180918171007.GJ16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Sep 14, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>    capable call domain->ops->flush_iotlb_all to flush TLB.
> 2. During the iommu domain initialization phase, base on domain->non_strict
>    field to check whether non-strict mode is supported or not. If so, call
>    init_iova_flush_queue to register iovad->flush_cb callback.
> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>    -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>    put off iova freeing, and omit iommu_tlb_sync operation.

Hmm, this is basically just a commentary on the code. Please could you write
it more in terms of the problem that's being solved?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: convert raw boolean to domain attribute]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
>  include/linux/iommu.h     |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 511ff9a1d6d9..092e6926dc3c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -55,6 +55,9 @@ struct iommu_dma_cookie {
>  	};
>  	struct list_head		msi_page_list;
>  	spinlock_t			msi_lock;
> +
> +	/* Only be assigned in non-strict mode, otherwise it's NULL */
> +	struct iommu_domain		*domain;
>  };
>  
>  static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
> @@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	return ret;
>  }
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

Can we rely on this function pointer being non-NULL? I think it would
be better to call iommu_flush_tlb_all(cookie->domain) instead.

> +}
> +
>  /**
>   * iommu_dma_init_domain - Initialise a DMA mapping domain
>   * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -275,6 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	unsigned long order, base_pfn, end_pfn;
> +	int attr = 1;

Do we actually need to initialise this?

Will

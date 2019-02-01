Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682A320870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfBAOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:47:21 -0500
Received: from foss.arm.com ([217.140.101.70]:60990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfBAOrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:47:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C18280D;
        Fri,  1 Feb 2019 06:47:21 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0153F589;
        Fri,  1 Feb 2019 06:47:18 -0800 (PST)
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
Date:   Fri, 1 Feb 2019 14:47:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
> includes unconditionally so users can rely on it, and add a missing
> comment describing the #else cpp statement.  Last but not least include
> <linux/errno.h> instead of the asm version, which is frowned upon.

I think the __KERNEL__ and asm/errno.h slip-ups are things I 
cargo-culted from the arch code as a fresh-faced noob yet to learn the 
finer details, so ack for those parts. The forward-declarations, though, 
were a deliberate effort to minimise header dependencies and compilation 
bloat for includers who absolutely wouldn't care, and specifically to 
try to avoid setting transitive include expectations since they always 
seem to end up breaking someone's config somewhere down the line. 
Admittedly this little backwater is hardly comparable to the likes of 
the sched.h business, but I'm still somewhat on the fence about that 
change :/

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-iommu.h | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index e760dc5d1fa8..65aa888c2768 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -16,15 +16,13 @@
>   #ifndef __DMA_IOMMU_H
>   #define __DMA_IOMMU_H
>   
> -#ifdef __KERNEL__
> -#include <linux/types.h>
> -#include <asm/errno.h>
> -
> -#ifdef CONFIG_IOMMU_DMA
> +#include <linux/errno.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/iommu.h>
>   #include <linux/msi.h>
> +#include <linux/types.h>
>   
> +#ifdef CONFIG_IOMMU_DMA
>   int iommu_dma_init(void);
>   
>   /* Domain management interface for IOMMU drivers */
> @@ -74,11 +72,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -#else
> -
> -struct iommu_domain;
> -struct msi_msg;
> -struct device;
> +#else /* CONFIG_IOMMU_DMA */
>   
>   static inline int iommu_dma_init(void)
>   {
> @@ -108,5 +102,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   }
>   
>   #endif	/* CONFIG_IOMMU_DMA */
> -#endif	/* __KERNEL__ */
>   #endif	/* __DMA_IOMMU_H */
> 

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7792075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7792075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeIFQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:55:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbeIFQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12AB97A9;
        Thu,  6 Sep 2018 05:20:17 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039BD3F575;
        Thu,  6 Sep 2018 05:20:15 -0700 (PDT)
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b2161b3e-6dbe-3e83-baaa-185e8679bc7d@arm.com>
Date:   Thu, 6 Sep 2018 13:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827084711.23407-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> There is no reason to leave the per-device dma_ops around when
> deconfiguring a device, so move this code from arm64 into the
> common code.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/include/asm/dma-mapping.h | 5 -----
>   arch/arm64/mm/dma-mapping.c          | 5 -----
>   include/linux/dma-mapping.h          | 5 ++++-
>   3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index b7847eb8a7bb..0a2d13332545 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -39,11 +39,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			const struct iommu_ops *iommu, bool coherent);
>   #define arch_setup_dma_ops	arch_setup_dma_ops
>   
> -#ifdef CONFIG_IOMMU_DMA
> -void arch_teardown_dma_ops(struct device *dev);
> -#define arch_teardown_dma_ops	arch_teardown_dma_ops
> -#endif
> -
>   /* do not use this function in a driver */
>   static inline bool is_device_dma_coherent(struct device *dev)
>   {
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 072c51fb07d7..cdcb73db9ea2 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -862,11 +862,6 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   		 dev_name(dev));
>   }
>   
> -void arch_teardown_dma_ops(struct device *dev)
> -{
> -	dev->dma_ops = NULL;
> -}
> -
>   #else
>   
>   static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1423b69f3cc9..eafd6f318e78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -664,7 +664,10 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>   #endif
>   
>   #ifndef arch_teardown_dma_ops
> -static inline void arch_teardown_dma_ops(struct device *dev) { }
> +static inline void arch_teardown_dma_ops(struct device *dev)
> +{
> +	dev->dma_ops = NULL;
> +}
>   #endif
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> 

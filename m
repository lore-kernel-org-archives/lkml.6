Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C60C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71FB2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIKPWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:22:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeIKPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:22:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6B418A;
        Tue, 11 Sep 2018 03:23:33 -0700 (PDT)
Received: from [10.1.215.19] (unknown [10.1.215.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0856E3F557;
        Tue, 11 Sep 2018 03:23:31 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm-nommu: don't define arch_teardown_dma_ops
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-2-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <8ae006ad-0aff-bab3-2c16-be1696d58b5f@arm.com>
Date:   Tue, 11 Sep 2018 11:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180827084711.23407-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> We can just use the default implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/dma-mapping.h | 2 ++
>  arch/arm/mm/dma-mapping-nommu.c    | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 8436f6ade57d..965b7c846ecb 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -100,8 +100,10 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			       const struct iommu_ops *iommu, bool coherent);
>  
> +#ifdef CONFIG_MMU
>  #define arch_teardown_dma_ops arch_teardown_dma_ops
>  extern void arch_teardown_dma_ops(struct device *dev);
> +#endif
>  
>  /* do not use this function in a driver */
>  static inline bool is_device_dma_coherent(struct device *dev)
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f448a0663b10..aa7aba302e76 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -237,7 +237,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  	set_dma_ops(dev, dma_ops);
>  }
> -
> -void arch_teardown_dma_ops(struct device *dev)
> -{
> -}
> 

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks
Vladimir

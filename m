Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70F218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfBAOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:22:51 -0500
Received: from foss.arm.com ([217.140.101.70]:60670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfBAOWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:22:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D3780D;
        Fri,  1 Feb 2019 06:22:49 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE763F59C;
        Fri,  1 Feb 2019 06:22:48 -0800 (PST)
Subject: Re: [PATCH 01/19] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-2-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
Date:   Fri, 1 Feb 2019 14:22:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Add a Kconfig symbol that indicates an architecture provides a
> arch_dma_prep_coherent implementation, and provide a stub otherwise.
> 
> This will allow the generic dma-iommu code to it while still allowing
> to be built for cache coherent architectures.

I've been pondering this for a while now, and I still can't really come 
up with a case where arch_dma_prep_coherent() would need to behave 
differently from arch_sync_dma_for_device(..., DMA_BIDIRECTIONAL). I 
wonder if we could just save ourselves this little bit of complexity by 
using that instead...

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              | 1 +
>   arch/csky/Kconfig               | 1 +
>   include/linux/dma-noncoherent.h | 6 ++++++
>   kernel/dma/Kconfig              | 3 +++
>   4 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d366127..ae3f581a9bcc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -13,6 +13,7 @@ config ARM64
>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>   	select ARCH_HAS_DMA_COHERENT_TO_PFN
>   	select ARCH_HAS_DMA_MMAP_PGPROT
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 398113c845f5..8b84d4362ff6 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -1,5 +1,6 @@
>   config CSKY
>   	def_bool y
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 69b36ed31a99..9741767e400f 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
>   }
>   #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
>   
> +#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
>   void arch_dma_prep_coherent(struct page *page, size_t size);
> +#else
> +static inline void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +}
> +#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
>   
>   #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index ca88b867e7fe..541128a32c5d 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -29,6 +29,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>   config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>   	bool
>   
> +config ARCH_HAS_DMA_PREP_COHERENT
> +	bool
> +
>   config ARCH_HAS_DMA_COHERENT_TO_PFN
>   	bool
>   
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeC1PMx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:12:53 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54741 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeC1PMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:12:51 -0400
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sebott@linux.vnet.ibm.com" <sebott@linux.vnet.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] dma-mapping: don't clear GFP_ZERO in dma_alloc_attrs
Thread-Topic: [PATCH] dma-mapping: don't clear GFP_ZERO in dma_alloc_attrs
Thread-Index: AQHTxpm0Ohq39fhgq0eJ/kMWcZgH36Pln7kA
Date: Wed, 28 Mar 2018 15:12:47 +0000
Message-ID: <1522249966.2593.14.camel@synopsys.com>
References: <20180328133535.17302-1-hch@lst.de>
         <20180328133535.17302-2-hch@lst.de>
In-Reply-To: <20180328133535.17302-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <39D21B2E5947E541869FC01EB34E3DE5@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2SFCw3c025381

Adding linux-snps and linux-arch mailing lists.

> Revert the clearing of __GFP_ZERO in dma_alloc_attrs and move it to
> dma_direct_alloc for now.  While most common architectures always zero dma
> cohereny allocations (and x86 did so since day one) this is not documented
> and at least arc and s390 do not zero without the explicit __GFP_ZERO
> argument.
This patch fixed Ethernet issues on ARC HSDK.
https://www.spinics.net/lists/kernel/msg2762054.html

Tested-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> Fixes: 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")
> Reported-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> Reported-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/dma-mapping.h | 8 ++------
>  lib/dma-direct.c            | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index eb9eab4ecd6d..12fedcba9a9a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -518,12 +518,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
>  
> -	/*
> -	 * Let the implementation decide on the zone to allocate from, and
> -	 * decide on the way of zeroing the memory given that the memory
> -	 * returned should always be zeroed.
> -	 */
> -	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM | __GFP_ZERO);
> +	/* let the implementation decide on the zone to allocate from: */
> +	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
> 
>  	if (!arch_dma_alloc_attrs(&dev, &flag))
>  		return NULL;
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index 1277d293d4da..c0bba30fef0a 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -59,6 +59,9 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	struct page *page = NULL;
>  	void *ret;
>  
> +	/* we always manually zero the memory once we are done: */
> +	gfp &= ~__GFP_ZERO;
> +
>  	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
>  	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>  		gfp |= GFP_DMA;

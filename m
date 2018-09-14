Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0741A204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0741A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeINSi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:38:28 -0400
Received: from foss.arm.com ([217.140.101.70]:33404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeINSi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:38:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2AC818A;
        Fri, 14 Sep 2018 06:23:58 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1123F703;
        Fri, 14 Sep 2018 06:23:57 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
Date:   Fri, 14 Sep 2018 14:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/18 16:17, Wolfram Sang wrote:
> While sanitizig the pointer for dma_ops on teardown, do the same for
> dma_parms, too. Rename the function to have a more generic name.

Upon closer inspection, it looks like there are some cases (at least PCI 
and MFD) where dma_parms is installed by the parent/bus at device 
creation, and therefore remains valid and *would* be expected to persist 
across the child device's driver unbinding and rebinding - seems this is 
more complex than I first thought, sorry.

Robin.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   arch/arm/mm/dma-mapping.c   | 2 +-
>   include/linux/dma-mapping.h | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 466b0242e8af..bcf77bc0423f 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2399,5 +2399,5 @@ void arch_teardown_dma_ops(struct device *dev)
>   	if (dev->archdata.dma_ops_setup)
>   		arm_teardown_iommu_dma_ops(dev);
>   
> -	generic_teardown_dma_ops(dev);
> +	generic_teardown_dma(dev);
>   }
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 020512cb7f0e..6a2d8779b1d8 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -663,12 +663,13 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>   				      bool coherent) { }
>   #endif
>   
> -static inline void generic_teardown_dma_ops(struct device *dev)
> +static inline void generic_teardown_dma(struct device *dev)
>   {
>   	dev->dma_ops = NULL;
> +	dev->dma_parms = NULL;
>   }
>   #ifndef arch_teardown_dma_ops
> -#define arch_teardown_dma_ops generic_teardown_dma_ops
> +#define arch_teardown_dma_ops generic_teardown_dma
>   #endif
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> 

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598DCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72C20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B72C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeIFQtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:49:41 -0400
Received: from foss.arm.com ([217.140.101.70]:44462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeIFQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74EA47A9;
        Thu,  6 Sep 2018 05:14:28 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B42E3F575;
        Thu,  6 Sep 2018 05:14:25 -0700 (PDT)
Subject: Re: [PATCH 2/4] dma-mapping: remove dma_configure
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e61f09e1-5a1f-2010-2a7e-63e1ba2d505c@arm.com>
Date:   Thu, 6 Sep 2018 13:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827084711.23407-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> There is no good reason for this indirection given that the method
> always exists.

And indeed with the way it works these days we don't really want 
dma_configure() to look like something which can be called from anywhere.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/base/dd.c           |  8 +++++---
>   include/linux/dma-mapping.h |  6 ------
>   kernel/dma/mapping.c        | 10 ----------
>   3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index edfc9f0b1180..65128cf8427c 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -480,9 +480,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   	if (ret)
>   		goto pinctrl_bind_failed;
>   
> -	ret = dma_configure(dev);
> -	if (ret)
> -		goto dma_failed;
> +	if (dev->bus->dma_configure) {
> +		ret = dev->bus->dma_configure(dev);
> +		if (ret)
> +			goto dma_failed;
> +	}
>   
>   	if (driver_sysfs_add(dev)) {
>   		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1db6a6b46d0d..1c6c7c09bcf2 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -754,14 +754,8 @@ dma_mark_declared_memory_occupied(struct device *dev,
>   #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
>   
>   #ifdef CONFIG_HAS_DMA
> -int dma_configure(struct device *dev);
>   void dma_deconfigure(struct device *dev);
>   #else
> -static inline int dma_configure(struct device *dev)
> -{
> -	return 0;
> -}
> -
>   static inline void dma_deconfigure(struct device *dev) {}
>   #endif
>   
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index d2a92ddaac4d..25607ceb4a50 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -328,16 +328,6 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
>   }
>   #endif
>   
> -/*
> - * enables DMA API use for a device
> - */
> -int dma_configure(struct device *dev)
> -{
> -	if (dev->bus->dma_configure)
> -		return dev->bus->dma_configure(dev);
> -	return 0;
> -}
> -
>   void dma_deconfigure(struct device *dev)
>   {
>   	of_dma_deconfigure(dev);
> 

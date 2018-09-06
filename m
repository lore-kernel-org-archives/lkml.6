Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96ABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D012075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D012075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeIFQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:54:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbeIFQy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:54:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C57817A9;
        Thu,  6 Sep 2018 05:19:15 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34553F575;
        Thu,  6 Sep 2018 05:19:14 -0700 (PDT)
Subject: Re: [PATCH 3/4] dma-mapping: remove dma_deconfigure
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <401fcbc4-bcb2-66b3-1440-9db6051b9805@arm.com>
Date:   Thu, 6 Sep 2018 13:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827084711.23407-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> This goes through a lot of hooks just to call arch_teardown_dma_ops.
> Replace it with a direct call instead.

Agreed. We originally had the deconfigure() hooks for symmetry in case 
there might need to be some firmware-specific state to tear down, but 
with the benefit of a couple of years' hindsight now it really doesn't 
look like that's ever likely to be necessary.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/acpi/arm64/iort.c   |  2 +-
>   drivers/acpi/scan.c         | 10 ----------
>   drivers/base/dd.c           |  4 ++--
>   drivers/of/device.c         | 12 ------------
>   include/acpi/acpi_bus.h     |  1 -
>   include/linux/acpi.h        |  2 --
>   include/linux/dma-mapping.h |  6 ------
>   include/linux/of_device.h   |  3 ---
>   kernel/dma/mapping.c        |  6 ------
>   9 files changed, 3 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 08f26db2da7e..2a361e22d38d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1428,7 +1428,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	return 0;
>   
>   dma_deconfigure:
> -	acpi_dma_deconfigure(&pdev->dev);
> +	arch_teardown_dma_ops(&pdev->dev);
>   dev_put:
>   	platform_device_put(pdev);
>   
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e1b6231cfa1c..56676a56b3e3 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1469,16 +1469,6 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>   }
>   EXPORT_SYMBOL_GPL(acpi_dma_configure);
>   
> -/**
> - * acpi_dma_deconfigure - Tear-down DMA configuration for the device.
> - * @dev: The pointer to the device
> - */
> -void acpi_dma_deconfigure(struct device *dev)
> -{
> -	arch_teardown_dma_ops(dev);
> -}
> -EXPORT_SYMBOL_GPL(acpi_dma_deconfigure);
> -
>   static void acpi_init_coherency(struct acpi_device *adev)
>   {
>   	unsigned long long cca = 0;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 65128cf8427c..169412ee4ae8 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -539,7 +539,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   	goto done;
>   
>   probe_failed:
> -	dma_deconfigure(dev);
> +	arch_teardown_dma_ops(dev);
>   dma_failed:
>   	if (dev->bus)
>   		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> @@ -968,7 +968,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>   			drv->remove(dev);
>   
>   		device_links_driver_cleanup(dev);
> -		dma_deconfigure(dev);
> +		arch_teardown_dma_ops(dev);
>   
>   		devres_release_all(dev);
>   		dev->driver = NULL;
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5957cd4fa262..c7fa5a9697c9 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -170,18 +170,6 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>   }
>   EXPORT_SYMBOL_GPL(of_dma_configure);
>   
> -/**
> - * of_dma_deconfigure - Clean up DMA configuration
> - * @dev:	Device for which to clean up DMA configuration
> - *
> - * Clean up all configuration performed by of_dma_configure_ops() and free all
> - * resources that have been allocated.
> - */
> -void of_dma_deconfigure(struct device *dev)
> -{
> -	arch_teardown_dma_ops(dev);
> -}
> -
>   int of_device_register(struct platform_device *pdev)
>   {
>   	device_initialize(&pdev->dev);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ba4dd54f2c82..53600f527a70 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -595,7 +595,6 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
>   int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   		       u64 *size);
>   int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
> -void acpi_dma_deconfigure(struct device *dev);
>   
>   struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
>   					   u64 address, bool check_children);
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index de8d3d3fa651..af4628979d13 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -831,8 +831,6 @@ static inline int acpi_dma_configure(struct device *dev,
>   	return 0;
>   }
>   
> -static inline void acpi_dma_deconfigure(struct device *dev) { }
> -
>   #define ACPI_PTR(_ptr)	(NULL)
>   
>   static inline void acpi_device_set_enumerated(struct acpi_device *adev)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1c6c7c09bcf2..1423b69f3cc9 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -753,12 +753,6 @@ dma_mark_declared_memory_occupied(struct device *dev,
>   }
>   #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
>   
> -#ifdef CONFIG_HAS_DMA
> -void dma_deconfigure(struct device *dev);
> -#else
> -static inline void dma_deconfigure(struct device *dev) {}
> -#endif
> -
>   /*
>    * Managed DMA API
>    */
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 165fd302b442..8d31e39dd564 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -58,7 +58,6 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>   int of_dma_configure(struct device *dev,
>   		     struct device_node *np,
>   		     bool force_dma);
> -void of_dma_deconfigure(struct device *dev);
>   #else /* CONFIG_OF */
>   
>   static inline int of_driver_match_device(struct device *dev,
> @@ -113,8 +112,6 @@ static inline int of_dma_configure(struct device *dev,
>   {
>   	return 0;
>   }
> -static inline void of_dma_deconfigure(struct device *dev)
> -{}
>   #endif /* CONFIG_OF */
>   
>   #endif /* _LINUX_OF_DEVICE_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 25607ceb4a50..3540cb399bd2 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -327,9 +327,3 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
>   	vunmap(cpu_addr);
>   }
>   #endif
> -
> -void dma_deconfigure(struct device *dev)
> -{
> -	of_dma_deconfigure(dev);
> -	acpi_dma_deconfigure(dev);
> -}
> 

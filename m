Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1612CC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E12084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfBANxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:53:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730265AbfBANxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:53:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AEE280D;
        Fri,  1 Feb 2019 05:53:17 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD473F59C;
        Fri,  1 Feb 2019 05:53:14 -0800 (PST)
Subject: Re: [PATCH 03/18] net: caif: pass struct device to DMA API functions
To:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1cafba51-b652-5457-0dd7-77d64264c85e@arm.com>
Date:   Fri, 1 Feb 2019 13:53:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201084801.10983-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 08:47, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Also use the proper Kconfig symbol to check for DMA API availability.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/net/caif/caif_spi.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
> index d28a1398c091..b7f3e263b57c 100644
> --- a/drivers/net/caif/caif_spi.c
> +++ b/drivers/net/caif/caif_spi.c
> @@ -73,35 +73,37 @@ MODULE_PARM_DESC(spi_down_tail_align, "SPI downlink tail alignment.");
>   #define LOW_WATER_MARK   100
>   #define HIGH_WATER_MARK  (LOW_WATER_MARK*5)
>   
> -#ifdef CONFIG_UML
> +#ifdef CONFIG_HAS_DMA

#ifndef, surely?

Robin.

>   
>   /*
>    * We sometimes use UML for debugging, but it cannot handle
>    * dma_alloc_coherent so we have to wrap it.
>    */
> -static inline void *dma_alloc(dma_addr_t *daddr)
> +static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
>   {
>   	return kmalloc(SPI_DMA_BUF_LEN, GFP_KERNEL);
>   }
>   
> -static inline void dma_free(void *cpu_addr, dma_addr_t handle)
> +static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
> +		dma_addr_t handle)
>   {
>   	kfree(cpu_addr);
>   }
>   
>   #else
>   
> -static inline void *dma_alloc(dma_addr_t *daddr)
> +static inline void *dma_alloc(struct cfspi *cfspi, dma_addr_t *daddr)
>   {
> -	return dma_alloc_coherent(NULL, SPI_DMA_BUF_LEN, daddr,
> +	return dma_alloc_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, daddr,
>   				GFP_KERNEL);
>   }
>   
> -static inline void dma_free(void *cpu_addr, dma_addr_t handle)
> +static inline void dma_free(struct cfspi *cfspi, void *cpu_addr,
> +		dma_addr_t handle)
>   {
> -	dma_free_coherent(NULL, SPI_DMA_BUF_LEN, cpu_addr, handle);
> +	dma_free_coherent(&cfspi->pdev->dev, SPI_DMA_BUF_LEN, cpu_addr, handle);
>   }
> -#endif	/* CONFIG_UML */
> +#endif	/* CONFIG_HAS_DMA */
>   
>   #ifdef CONFIG_DEBUG_FS
>   
> @@ -610,13 +612,13 @@ static int cfspi_init(struct net_device *dev)
>   	}
>   
>   	/* Allocate DMA buffers. */
> -	cfspi->xfer.va_tx[0] = dma_alloc(&cfspi->xfer.pa_tx[0]);
> +	cfspi->xfer.va_tx[0] = dma_alloc(cfspi, &cfspi->xfer.pa_tx[0]);
>   	if (!cfspi->xfer.va_tx[0]) {
>   		res = -ENODEV;
>   		goto err_dma_alloc_tx_0;
>   	}
>   
> -	cfspi->xfer.va_rx = dma_alloc(&cfspi->xfer.pa_rx);
> +	cfspi->xfer.va_rx = dma_alloc(cfspi, &cfspi->xfer.pa_rx);
>   
>   	if (!cfspi->xfer.va_rx) {
>   		res = -ENODEV;
> @@ -665,9 +667,9 @@ static int cfspi_init(struct net_device *dev)
>   	return 0;
>   
>    err_create_wq:
> -	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> +	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
>    err_dma_alloc_rx:
> -	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
> +	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
>    err_dma_alloc_tx_0:
>   	return res;
>   }
> @@ -683,8 +685,8 @@ static void cfspi_uninit(struct net_device *dev)
>   
>   	cfspi->ndev = NULL;
>   	/* Free DMA buffers. */
> -	dma_free(cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> -	dma_free(cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
> +	dma_free(cfspi, cfspi->xfer.va_rx, cfspi->xfer.pa_rx);
> +	dma_free(cfspi, cfspi->xfer.va_tx[0], cfspi->xfer.pa_tx[0]);
>   	set_bit(SPI_TERMINATE, &cfspi->state);
>   	wake_up_interruptible(&cfspi->wait);
>   	destroy_workqueue(cfspi->wq);
> 

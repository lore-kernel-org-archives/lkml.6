Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeDUTcP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 15:32:15 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:21075 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753158AbeDUTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 15:32:14 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 21 Apr 2018 21:32:13 +0200
X-ME-IP: 90.55.212.125
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 10/15] ata: pata_pxa: remove the dmaengine compat need
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <20180402142656.26815-11-robert.jarzmik@free.fr>
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 21 Apr 2018 21:32:11 +0200
In-Reply-To: <20180402142656.26815-11-robert.jarzmik@free.fr> (Robert
        Jarzmik's message of "Mon, 2 Apr 2018 16:26:51 +0200")
Message-ID: <87sh7oxsn8.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
>
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Bartlomiej, could I have your ack please ?

Cheers.

--
Robert

PS: The submitted patch
> ---
>  drivers/ata/pata_pxa.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index f6c46e9a4dc0..e8b6a2e464c9 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -25,7 +25,6 @@
>  #include <linux/libata.h>
>  #include <linux/platform_device.h>
>  #include <linux/dmaengine.h>
> -#include <linux/dma/pxa-dma.h>
>  #include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/completion.h>
> @@ -180,8 +179,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	struct resource *irq_res;
>  	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct dma_slave_config	config;
> -	dma_cap_mask_t mask;
> -	struct pxad_param param;
>  	int ret = 0;
>  
>  	/*
> @@ -278,10 +275,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  
>  	ap->private_data = data;
>  
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -	param.prio = PXAD_PRIO_LOWEST;
> -	param.drcmr = pdata->dma_dreq;
>  	memset(&config, 0, sizeof(config));
>  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>  	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> @@ -294,8 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	 * Request the DMA channel
>  	 */
>  	data->dma_chan =
> -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						 &param, &pdev->dev, "data");
> +		dma_request_slave_channel(&pdev->dev, "data");
>  	if (!data->dma_chan)
>  		return -EBUSY;
>  	ret = dmaengine_slave_config(data->dma_chan, &config);

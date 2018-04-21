Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDUTaW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 15:30:22 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:38103 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753158AbeDUTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 15:30:21 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 21 Apr 2018 21:30:20 +0200
X-ME-IP: 90.55.212.125
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Samuel Ortiz <samuel@sortiz.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] net: irda: pxaficp_ir: remove the dmaengine compat need
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <20180402142656.26815-10-robert.jarzmik@free.fr>
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 21 Apr 2018 21:30:19 +0200
In-Reply-To: <20180402142656.26815-10-robert.jarzmik@free.fr> (Robert
        Jarzmik's message of "Mon, 2 Apr 2018 16:26:50 +0200")
Message-ID: <87wox0xsqc.fsf@belgarion.home>
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
Samuel, could I have your ack please ?

Cheers.

--
Robert

PS: The submitted patch
> ---
>  drivers/staging/irda/drivers/pxaficp_ir.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/irda/drivers/pxaficp_ir.c b/drivers/staging/irda/drivers/pxaficp_ir.c
> index 2ea00a6531f9..9dd6e21dc11e 100644
> --- a/drivers/staging/irda/drivers/pxaficp_ir.c
> +++ b/drivers/staging/irda/drivers/pxaficp_ir.c
> @@ -20,7 +20,6 @@
>  #include <linux/clk.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/dma/pxa-dma.h>
>  #include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/sched/clock.h>
> @@ -735,9 +734,7 @@ static void pxa_irda_shutdown(struct pxa_irda *si)
>  static int pxa_irda_start(struct net_device *dev)
>  {
>  	struct pxa_irda *si = netdev_priv(dev);
> -	dma_cap_mask_t mask;
>  	struct dma_slave_config	config;
> -	struct pxad_param param;
>  	int err;
>  
>  	si->speed = 9600;
> @@ -757,9 +754,6 @@ static int pxa_irda_start(struct net_device *dev)
>  	disable_irq(si->icp_irq);
>  
>  	err = -EBUSY;
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -	param.prio = PXAD_PRIO_LOWEST;
>  
>  	memset(&config, 0, sizeof(config));
>  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> @@ -769,15 +763,11 @@ static int pxa_irda_start(struct net_device *dev)
>  	config.src_maxburst = 32;
>  	config.dst_maxburst = 32;
>  
> -	param.drcmr = si->drcmr_rx;
> -	si->rxdma = dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						     &param, &dev->dev, "rx");
> +	si->rxdma = dma_request_slave_channel(&dev->dev, "rx");
>  	if (!si->rxdma)
>  		goto err_rx_dma;
>  
> -	param.drcmr = si->drcmr_tx;
> -	si->txdma = dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -						     &param, &dev->dev, "tx");
> +	si->txdma = dma_request_slave_channel(&dev->dev, "tx");
>  	if (!si->txdma)
>  		goto err_tx_dma;

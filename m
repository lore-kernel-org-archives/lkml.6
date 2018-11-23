Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E65C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1377E20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="KfZxZgpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1377E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410169AbeKXDEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:04:08 -0500
Received: from mail-sender220.upb.ro ([141.85.13.220]:32976 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391108AbeKXDEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:04:08 -0500
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id 050D8B560087;
        Fri, 23 Nov 2018 18:19:13 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id DE17FB560084;
        Fri, 23 Nov 2018 18:19:12 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro DE17FB560084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1542989952;
        bh=ScBOo8yrdfmrXzp2z+nbIXolqSVz4o9uW6/StjHyT/M=;
        h=Message-ID:From:To:Date:Mime-Version;
        b=KfZxZgpusPCRtjAC0yH4KVWDhmPadAWXPyBdWlPGXWp1LpiNGNZjD25mXVePYuQe1
         IYc8dY5PfsnxHVAzq3JAWaox1A/p9jZp/bSqFPuuOgx/CKQqhGiDn8EKCI0vshMW4I
         15kdyBYsiTFzI8yvqdNn63GmG5VcP7nThkNaDs6k=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E9fRIwjnNamd; Fri, 23 Nov 2018 18:19:12 +0200 (EET)
Received: from asus-rog (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id B5129B560060;
        Fri, 23 Nov 2018 18:19:12 +0200 (EET)
Message-ID: <0ae5847b34b070ed51eca2b55c4b473b4e47da73.camel@upb.ro>
Subject: Re: [PATCH 3/3] spi: at91-usart: add DMA support
From:   Radu Nicolae Pirea <radu_nicolae.pirea@upb.ro>
To:     Robin Murphy <robin.murphy@arm.com>, richard.genoud@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.co, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Date:   Fri, 23 Nov 2018 18:19:05 +0200
In-Reply-To: <fe367c1a-700d-c6e3-6b09-ded1a47f2475@arm.com>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
         <20181121112732.15690-4-radu_nicolae.pirea@upb.ro>
         <fe367c1a-700d-c6e3-6b09-ded1a47f2475@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 17:38 +0000, Robin Murphy wrote:
> On 21/11/2018 11:27, Radu Pirea wrote:
> > This patch adds support for DMA. Transfers are done with dma only
> > if
> > they are longer than 16 bytes in order to achieve a better
> > performance.
> > DMA setup introduces a little overhead and for transfers shorter
> > than 16
> > bytes there is no performance improvement.
> > 
> > Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
> > ---
> >   drivers/spi/spi-at91-usart.c | 223
> > ++++++++++++++++++++++++++++++++++-
> >   1 file changed, 221 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-
> > usart.c
> > index 0b07c746453d..4d908afeaec9 100644
> > --- a/drivers/spi/spi-at91-usart.c
> > +++ b/drivers/spi/spi-at91-usart.c
> > @@ -8,9 +8,12 @@
> >   
> >   #include <linux/clk.h>
> >   #include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-direction.h>
> 
> It looks rather odd to include this from a driver that isn't
> otherwise 
> touching anything from linux/dma-mapping.h.
> 
> >   #include <linux/interrupt.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> > +#include <linux/of_platform.h>
> >   #include <linux/of_gpio.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> > @@ -58,6 +61,8 @@
> >   
> >   #define US_INIT \
> >   	(US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO | US_MR_WRDBT)
> > +#define US_DMA_MIN_BYTES       16
> > +#define US_DMA_TIMEOUT         (msecs_to_jiffies(1000))
> >   
> >   /* Register access macros */
> >   #define at91_usart_spi_readl(port, reg) \
> > @@ -71,14 +76,19 @@
> >   	writeb_relaxed((value), (port)->regs + US_##reg)
> >   
> >   struct at91_usart_spi {
> > +	struct platform_device  *mpdev;
> >   	struct spi_transfer	*current_transfer;
> >   	void __iomem		*regs;
> >   	struct device		*dev;
> >   	struct clk		*clk;
> >   
> > +	struct completion	xfer_completion;
> > +
> >   	/*used in interrupt to protect data reading*/
> >   	spinlock_t		lock;
> >   
> > +	phys_addr_t		phybase;
> > +
> >   	int			irq;
> >   	unsigned int		current_tx_remaining_bytes;
> >   	unsigned int		current_rx_remaining_bytes;
> > @@ -87,8 +97,184 @@ struct at91_usart_spi {
> >   	u32			status;
> >   
> >   	bool			xfer_failed;
> > +	bool			use_dma;
> >   };
> >   
> > +static void dma_callback(void *data)
> > +{
> > +	struct spi_controller   *ctlr = data;
> > +	struct at91_usart_spi   *aus = spi_master_get_devdata(ctlr);
> > +
> > +	at91_usart_spi_writel(aus, IER, US_IR_RXRDY);
> > +	aus->current_rx_remaining_bytes = 0;
> > +	complete(&aus->xfer_completion);
> > +}
> > +
> > +static bool at91_usart_spi_can_dma(struct spi_controller *ctrl,
> > +				   struct spi_device *spi,
> > +				   struct spi_transfer *xfer)
> > +{
> > +	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
> > +
> > +	return aus->use_dma && xfer->len >= US_DMA_MIN_BYTES;
> > +}
> > +
> > +static int at91_usart_spi_configure_dma(struct spi_controller
> > *ctlr,
> > +					struct at91_usart_spi *aus)
> > +{
> > +	struct dma_slave_config slave_config;
> > +	struct device *dev = &aus->mpdev->dev;
> > +	phys_addr_t phybase = aus->phybase;
> > +	dma_cap_mask_t mask;
> > +	int err = 0;
> > +
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> > +
> > +	ctlr->dma_tx = dma_request_slave_channel_reason(dev, "tx");
> > +	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
> > +		if (IS_ERR(ctlr->dma_tx)) {
> > +			err = PTR_ERR(ctlr->dma_tx);
> > +			goto at91_usart_spi_error_clear;
> > +		}
> > +
> > +		dev_dbg(dev,
> > +			"DMA TX channel not available, SPI unable to
> > use DMA\n");
> > +		err = -EBUSY;
> > +		goto at91_usart_spi_error_clear;
> > +	}
> > +
> > +	ctlr->dma_rx = dma_request_slave_channel_reason(dev, "rx");
> > +	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
> > +		if (IS_ERR(ctlr->dma_rx)) {
> > +			err = PTR_ERR(ctlr->dma_rx);
> > +			goto at91_usart_spi_error;
> > +		}
> > +
> > +		dev_dbg(dev,
> > +			"DMA RX channel not available, SPI unable to
> > use DMA\n");
> > +		err = -EBUSY;
> > +		goto at91_usart_spi_error;
> > +	}
> > +
> > +	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > +	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > +	slave_config.dst_addr = (dma_addr_t)phybase + US_THR;
> > +	slave_config.src_addr = (dma_addr_t)phybase + US_RHR;
> > +	slave_config.src_maxburst = 1;
> > +	slave_config.dst_maxburst = 1;
> > +	slave_config.device_fc = false;
> > +
> > +	slave_config.direction = DMA_DEV_TO_MEM;
> > +	if (dmaengine_slave_config(ctlr->dma_rx, &slave_config)) {
> > +		dev_err(&ctlr->dev,
> > +			"failed to configure rx dma channel\n");
> > +		err = -EINVAL;
> > +		goto at91_usart_spi_error;
> > +	}
> > +
> > +	slave_config.direction = DMA_MEM_TO_DEV;
> > +	if (dmaengine_slave_config(ctlr->dma_tx, &slave_config)) {
> > +		dev_err(&ctlr->dev,
> > +			"failed to configure tx dma channel\n");
> > +		err = -EINVAL;
> > +		goto at91_usart_spi_error;
> > +	}
> > +
> > +	aus->use_dma = true;
> > +	return 0;
> > +
> > +at91_usart_spi_error:
> > +	if (!IS_ERR_OR_NULL(ctlr->dma_tx))
> > +		dma_release_channel(ctlr->dma_tx);
> > +	if (!IS_ERR_OR_NULL(ctlr->dma_rx))
> > +		dma_release_channel(ctlr->dma_rx);
> > +	ctlr->dma_tx = NULL;
> > +	ctlr->dma_rx = NULL;
> > +
> > +at91_usart_spi_error_clear:
> > +	return err;
> > +}
> > +
> > +static void at91_usart_spi_release_dma(struct spi_controller
> > *ctlr)
> > +{
> > +	if (ctlr->dma_rx)
> > +		dma_release_channel(ctlr->dma_rx);
> > +	if (ctlr->dma_tx)
> > +		dma_release_channel(ctlr->dma_tx);
> > +}
> > +
> > +static void at91_usart_spi_stop_dma(struct spi_controller *ctlr)
> > +{
> > +	if (ctlr->dma_rx)
> > +		dmaengine_terminate_all(ctlr->dma_rx);
> > +	if (ctlr->dma_tx)
> > +		dmaengine_terminate_all(ctlr->dma_tx);
> > +}
> > +
> > +static int at91_usart_spi_dma_transfer(struct spi_controller
> > *ctlr,
> > +				       struct spi_transfer *xfer)
> > +{
> > +	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
> > +	struct dma_chan	 *rxchan = ctlr->dma_rx;
> > +	struct dma_chan *txchan = ctlr->dma_tx;
> > +	struct dma_async_tx_descriptor *rxdesc;
> > +	struct dma_async_tx_descriptor *txdesc;
> > +	dma_cookie_t cookie;
> > +
> > +	rxdesc = dmaengine_prep_slave_sg(rxchan,
> > +					 xfer->rx_sg.sgl,
> > +					 xfer->rx_sg.nents,
> > +					 DMA_FROM_DEVICE,
> 
> Ah, this argument should be a dma_transfer_direction, not a 
> dma_data_direction (confusing I know, but they belong to different 
> APIs). I assume you mean DMA_DEV_TO_MEM here...

Hi Robin,

I hoped I used the correct values here, but it seems not.

Thanks. I will fix.

> 
> > +					 DMA_PREP_INTERRUPT |
> > +					 DMA_CTRL_ACK);
> > +	if (!rxdesc)
> > +		goto at91_usart_spi_err_dma;
> > +
> > +	txdesc = dmaengine_prep_slave_sg(txchan,
> > +					 xfer->tx_sg.sgl,
> > +					 xfer->tx_sg.nents,
> > +					 DMA_TO_DEVICE,
> 
> ...and DMA_MEM_TO_DEV here.
> 
> Robin.
> 
> > +					 DMA_PREP_INTERRUPT |
> > +					 DMA_CTRL_ACK);
> > +	if (!txdesc)
> > +		goto at91_usart_spi_err_dma;
> > +
> > +	/* Disable RX interrupt */
> > +	at91_usart_spi_writel(aus, IDR, US_IR_RXRDY);
> > +
> > +	rxdesc->callback = dma_callback;
> > +	rxdesc->callback_param = ctlr;
> > +
> > +	cookie = rxdesc->tx_submit(rxdesc);
> > +	if (dma_submit_error(cookie))
> > +		goto at91_usart_spi_err_dma;
> > +
> > +	cookie = txdesc->tx_submit(txdesc);
> > +	if (dma_submit_error(cookie))
> > +		goto at91_usart_spi_err_dma;
> > +
> > +	rxchan->device->device_issue_pending(rxchan);
> > +	txchan->device->device_issue_pending(txchan);
> > +
> > +	return 0;
> > +
> > +at91_usart_spi_err_dma:
> > +	/* Enable RX interrupt if submission of any of descriptors
> > fails
> > +	 * and fallback to PIO
> > +	 */
> > +	at91_usart_spi_writel(aus, IER, US_IR_RXRDY);
> > +	at91_usart_spi_stop_dma(ctlr);
> > +
> > +	return -ENOMEM;
> > +}
> > +
> > +static unsigned long at91_usart_spi_dma_timeout(struct
> > at91_usart_spi *aus)
> > +{
> > +	return wait_for_completion_timeout(&aus->xfer_completion,
> > +					   US_DMA_TIMEOUT);
> > +}
> > +
> >   static inline u32 at91_usart_spi_tx_ready(struct at91_usart_spi
> > *aus)
> >   {
> >   	return aus->status & US_IR_TXRDY;
> > @@ -221,6 +407,8 @@ static int at91_usart_spi_transfer_one(struct
> > spi_controller *ctlr,
> >   				       struct spi_transfer *xfer)
> >   {
> >   	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
> > +	unsigned long dma_timeout = 0;
> > +	int ret = 0;
> >   
> >   	at91_usart_spi_set_xfer_speed(aus, xfer);
> >   	aus->xfer_failed = false;
> > @@ -230,8 +418,25 @@ static int at91_usart_spi_transfer_one(struct
> > spi_controller *ctlr,
> >   
> >   	while ((aus->current_tx_remaining_bytes ||
> >   		aus->current_rx_remaining_bytes) && !aus->xfer_failed)
> > {
> > -		at91_usart_spi_read_status(aus);
> > -		at91_usart_spi_tx(aus);
> > +		reinit_completion(&aus->xfer_completion);
> > +		if (at91_usart_spi_can_dma(ctlr, spi, xfer) &&
> > +		    !ret) {
> > +			ret = at91_usart_spi_dma_transfer(ctlr, xfer);
> > +			if (ret)
> > +				continue;
> > +
> > +			dma_timeout = at91_usart_spi_dma_timeout(aus);
> > +
> > +			if (WARN_ON(dma_timeout == 0)) {
> > +				dev_err(&spi->dev, "DMA transfer
> > timeout\n");
> > +				return -EIO;
> > +			}
> > +			aus->current_tx_remaining_bytes = 0;
> > +		} else {
> > +			at91_usart_spi_read_status(aus);
> > +			at91_usart_spi_tx(aus);
> > +		}
> > +
> >   		cpu_relax();
> >   	}
> >   
> > @@ -350,6 +555,7 @@ static int at91_usart_spi_probe(struct
> > platform_device *pdev)
> >   	controller->transfer_one = at91_usart_spi_transfer_one;
> >   	controller->prepare_message = at91_usart_spi_prepare_message;
> >   	controller->unprepare_message =
> > at91_usart_spi_unprepare_message;
> > +	controller->can_dma = at91_usart_spi_can_dma;
> >   	controller->cleanup = at91_usart_spi_cleanup;
> >   	controller->max_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
> >   						US_MIN_CLK_DIV);
> > @@ -381,7 +587,17 @@ static int at91_usart_spi_probe(struct
> > platform_device *pdev)
> >   	aus->spi_clk = clk_get_rate(clk);
> >   	at91_usart_spi_init(aus);
> >   
> > +	aus->phybase = regs->start;
> > +
> > +	aus->mpdev = to_platform_device(pdev->dev.parent);
> > +
> > +	ret = at91_usart_spi_configure_dma(controller, aus);
> > +	if (ret)
> > +		goto at91_usart_fail_dma;
> > +
> >   	spin_lock_init(&aus->lock);
> > +	init_completion(&aus->xfer_completion);
> > +
> >   	ret = devm_spi_register_master(&pdev->dev, controller);
> >   	if (ret)
> >   		goto at91_usart_fail_register_master;
> > @@ -394,6 +610,8 @@ static int at91_usart_spi_probe(struct
> > platform_device *pdev)
> >   	return 0;
> >   
> >   at91_usart_fail_register_master:
> > +	at91_usart_spi_release_dma(controller);
> > +at91_usart_fail_dma:
> >   	clk_disable_unprepare(clk);
> >   at91_usart_spi_probe_fail:
> >   	spi_master_put(controller);
> > @@ -458,6 +676,7 @@ static int at91_usart_spi_remove(struct
> > platform_device *pdev)
> >   	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> >   	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
> >   
> > +	at91_usart_spi_release_dma(ctlr);
> >   	clk_disable_unprepare(aus->clk);
> >   
> >   	return 0;
> > 


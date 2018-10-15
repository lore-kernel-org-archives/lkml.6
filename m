Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B5DC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27420853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VwIznnIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeJOQHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:07:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52288 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:07:31 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9F8NEv1031197;
        Mon, 15 Oct 2018 03:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539591794;
        bh=Ie50erxmUSDKibryDLgzWKbBL1IxD9BkgUIVrlCWM4I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VwIznnITt74hJ6zjHPnS0+cY29iQB0QogfEBavx+Usqw/EQTlc9by+amfZSabKrF8
         wtCryzosqZkc9K7SZbNsOxV5t3tjSLsmMFemUvuaqK3roxxeXvNskbWiskooxXrJxq
         LZAzRsEgO91t23Ir8tes5dHv+AsjLu6zZMG7OMmk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F8NEfk019337;
        Mon, 15 Oct 2018 03:23:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 03:23:14 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 03:23:14 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F8NBZP015159;
        Mon, 15 Oct 2018 03:23:12 -0500
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
To:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
Date:   Mon, 15 Oct 2018 13:53:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015063829.26978-4-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 October 2018 12:08 PM, Vignesh R wrote:
> Add support to use McSPI controller as SPI slave. In slave mode, DMA TX
> completion does not mean entire data has been shifted out as data might
> still be stuck in FIFO waiting for master to clock the bus. Therefore,
> add an IRQ handler for slave mode to know when entire data in FIFO has
> been shifted out.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 138 ++++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 88469bb22235..f024c3fc3679 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -127,6 +127,7 @@ struct omap2_mcspi_regs {
>  };
>  
>  struct omap2_mcspi {
> +	struct completion	txdone;
>  	struct spi_master	*master;
>  	/* Virtual base address of the controller */
>  	void __iomem		*base;
> @@ -136,6 +137,7 @@ struct omap2_mcspi {
>  	struct device		*dev;
>  	struct omap2_mcspi_regs ctx;
>  	int			fifo_depth;
> +	bool			slave_aborted;
>  	unsigned int		pin_dir:1;
>  };
>  
> @@ -275,19 +277,23 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
>  	}
>  }
>  
> -static void omap2_mcspi_set_master_mode(struct spi_master *master)
> +static void omap2_mcspi_set_mode(struct spi_master *master)
>  {
>  	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
>  	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
>  	u32 l;
>  
>  	/*
> -	 * Setup when switching from (reset default) slave mode
> -	 * to single-channel master mode
> +	 * Choose master or slave mode
>  	 */
>  	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> -	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST | OMAP2_MCSPI_MODULCTRL_MS);
> -	l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
> +	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST);
> +	if (spi_controller_is_slave(master)) {
> +		l |= (OMAP2_MCSPI_MODULCTRL_MS);
> +	} else {
> +		l &= ~(OMAP2_MCSPI_MODULCTRL_MS);
> +		l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
> +	}
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  
>  	ctx->modulctrl = l;
> @@ -356,6 +362,20 @@ static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
>  	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
>  }
>  
> +static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,
> +				     struct completion *x)
> +{
> +	if (spi_controller_is_slave(mcspi->master)) {
> +		if (wait_for_completion_interruptible(x) ||
> +		    mcspi->slave_aborted)
> +			return -EINTR;
> +	} else {
> +		wait_for_completion(x);
> +	}
> +
> +	return 0;
> +}
> +
>  static void omap2_mcspi_rx_callback(void *data)
>  {
>  	struct spi_device *spi = data;
> @@ -505,7 +525,12 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
>  	dma_async_issue_pending(mcspi_dma->dma_rx);
>  	omap2_mcspi_set_dma_req(spi, 1, 1);
>  
> -	wait_for_completion(&mcspi_dma->dma_rx_completion);
> +	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
> +	if (ret || mcspi->slave_aborted) {
> +		dmaengine_terminate_sync(mcspi_dma->dma_rx);
> +		omap2_mcspi_set_dma_req(spi, 1, 0);
> +		return 0;
> +	}
>  
>  	for (x = 0; x < nb_sizes; x++)
>  		kfree(sg_out[x]);
> @@ -604,14 +629,37 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  	rx = xfer->rx_buf;
>  	tx = xfer->tx_buf;
>  
> -	if (tx != NULL)
> +	mcspi->slave_aborted = false;
> +	reinit_completion(&mcspi_dma->dma_tx_completion);
> +	reinit_completion(&mcspi_dma->dma_rx_completion);
> +	reinit_completion(&mcspi->txdone);
> +	if (tx) {
> +		/* Enable EOW IRQ to know end of tx in slave mode */
> +		if (spi_controller_is_slave(spi->master))
> +			mcspi_write_reg(spi->master,
> +					OMAP2_MCSPI_IRQENABLE,
> +					OMAP2_MCSPI_IRQSTATUS_EOW);
>  		omap2_mcspi_tx_dma(spi, xfer, cfg);
> +	}
>  
>  	if (rx != NULL)
>  		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
>  
>  	if (tx != NULL) {
> -		wait_for_completion(&mcspi_dma->dma_tx_completion);
> +		int ret;
> +
> +		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
> +		if (ret || mcspi->slave_aborted) {
> +			dmaengine_terminate_sync(mcspi_dma->dma_tx);
> +			omap2_mcspi_set_dma_req(spi, 0, 0);
> +			return 0;
> +		}
> +
> +		if (spi_controller_is_slave(mcspi->master)) {
> +			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
> +			if (ret || mcspi->slave_aborted)
> +				return 0;
> +		}
>  
>  		if (mcspi->fifo_depth > 0) {
>  			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
> @@ -1068,6 +1116,36 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
>  		gpio_free(spi->cs_gpio);
>  }
>  
> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
> +{
> +	struct omap2_mcspi *mcspi = data;
> +	u32 irqstat;
> +
> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
> +	if (!irqstat)
> +		return IRQ_NONE;
> +
> +	/* Disable IRQ and wakeup slave xfer task */
> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
> +		complete(&mcspi->txdone);
> +
> +	return IRQ_HANDLED;

You need to have the:

pm_runtime_get_sync();

/* access registers */

pm_runtime_mark_last_busy();
pm_runtime_put_autosuspend();

sequence here. I think thats also missing from the dma callbacks.
Probably working by chance today.

Thanks,
Sekhar

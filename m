Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D910ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406C921486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="egl9OBHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406C921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJSUfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:35:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44170 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=skBLtbnBUNHPT/44Qxn+Grh2rK3KjRp/0O8RZDPIWWs=; b=egl9OBHMMNvf
        s2fectRtzej4795K0GeKmcDhNP03ZIgwzB0VN6VoDIpSyswY2TLMEwJahmeE2LJSrg1kXDf/Uf9Yl
        If79qL0JP3BYHQZ/9h13FX5bo+08PuieB8KJeXk6MKED2gsNgPOH1U8ahpwJQtHA3BqFky1u8hPRa
        MF4SA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTuS-00004r-45; Fri, 19 Oct 2018 12:29:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D29B31122548; Fri, 19 Oct 2018 13:29:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: omap2-mcspi: Add slave mode support" to the spi tree
In-Reply-To:  <20181015063829.26978-4-vigneshr@ti.com>
Message-Id: <20181019122943.D29B31122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:29:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: omap2-mcspi: Add slave mode support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d5fcf8715cdd453b17078a6e3dfbcf26610572be Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Mon, 15 Oct 2018 12:08:29 +0530
Subject: [PATCH] spi: omap2-mcspi: Add slave mode support

Add support to use McSPI controller as SPI slave. In slave mode, DMA TX
completion does not mean entire data has been shifted out as data might
still be stuck in FIFO waiting for master to clock the bus. Therefore,
add an IRQ handler for slave mode to know when entire data in FIFO has
been shifted out.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 138 ++++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 88469bb22235..f024c3fc3679 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -127,6 +127,7 @@ struct omap2_mcspi_regs {
 };
 
 struct omap2_mcspi {
+	struct completion	txdone;
 	struct spi_master	*master;
 	/* Virtual base address of the controller */
 	void __iomem		*base;
@@ -136,6 +137,7 @@ struct omap2_mcspi {
 	struct device		*dev;
 	struct omap2_mcspi_regs ctx;
 	int			fifo_depth;
+	bool			slave_aborted;
 	unsigned int		pin_dir:1;
 };
 
@@ -275,19 +277,23 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 	}
 }
 
-static void omap2_mcspi_set_master_mode(struct spi_master *master)
+static void omap2_mcspi_set_mode(struct spi_master *master)
 {
 	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	u32 l;
 
 	/*
-	 * Setup when switching from (reset default) slave mode
-	 * to single-channel master mode
+	 * Choose master or slave mode
 	 */
 	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
-	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST | OMAP2_MCSPI_MODULCTRL_MS);
-	l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+	l &= ~(OMAP2_MCSPI_MODULCTRL_STEST);
+	if (spi_controller_is_slave(master)) {
+		l |= (OMAP2_MCSPI_MODULCTRL_MS);
+	} else {
+		l &= ~(OMAP2_MCSPI_MODULCTRL_MS);
+		l |= OMAP2_MCSPI_MODULCTRL_SINGLE;
+	}
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 
 	ctx->modulctrl = l;
@@ -356,6 +362,20 @@ static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
 }
 
+static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,
+				     struct completion *x)
+{
+	if (spi_controller_is_slave(mcspi->master)) {
+		if (wait_for_completion_interruptible(x) ||
+		    mcspi->slave_aborted)
+			return -EINTR;
+	} else {
+		wait_for_completion(x);
+	}
+
+	return 0;
+}
+
 static void omap2_mcspi_rx_callback(void *data)
 {
 	struct spi_device *spi = data;
@@ -505,7 +525,12 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	dma_async_issue_pending(mcspi_dma->dma_rx);
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
-	wait_for_completion(&mcspi_dma->dma_rx_completion);
+	ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_rx_completion);
+	if (ret || mcspi->slave_aborted) {
+		dmaengine_terminate_sync(mcspi_dma->dma_rx);
+		omap2_mcspi_set_dma_req(spi, 1, 0);
+		return 0;
+	}
 
 	for (x = 0; x < nb_sizes; x++)
 		kfree(sg_out[x]);
@@ -604,14 +629,37 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 	rx = xfer->rx_buf;
 	tx = xfer->tx_buf;
 
-	if (tx != NULL)
+	mcspi->slave_aborted = false;
+	reinit_completion(&mcspi_dma->dma_tx_completion);
+	reinit_completion(&mcspi_dma->dma_rx_completion);
+	reinit_completion(&mcspi->txdone);
+	if (tx) {
+		/* Enable EOW IRQ to know end of tx in slave mode */
+		if (spi_controller_is_slave(spi->master))
+			mcspi_write_reg(spi->master,
+					OMAP2_MCSPI_IRQENABLE,
+					OMAP2_MCSPI_IRQSTATUS_EOW);
 		omap2_mcspi_tx_dma(spi, xfer, cfg);
+	}
 
 	if (rx != NULL)
 		count = omap2_mcspi_rx_dma(spi, xfer, cfg, es);
 
 	if (tx != NULL) {
-		wait_for_completion(&mcspi_dma->dma_tx_completion);
+		int ret;
+
+		ret = mcspi_wait_for_completion(mcspi, &mcspi_dma->dma_tx_completion);
+		if (ret || mcspi->slave_aborted) {
+			dmaengine_terminate_sync(mcspi_dma->dma_tx);
+			omap2_mcspi_set_dma_req(spi, 0, 0);
+			return 0;
+		}
+
+		if (spi_controller_is_slave(mcspi->master)) {
+			ret = mcspi_wait_for_completion(mcspi, &mcspi->txdone);
+			if (ret || mcspi->slave_aborted)
+				return 0;
+		}
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1068,6 +1116,36 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
+static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
+{
+	struct omap2_mcspi *mcspi = data;
+	u32 irqstat;
+
+	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
+	if (!irqstat)
+		return IRQ_NONE;
+
+	/* Disable IRQ and wakeup slave xfer task */
+	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
+	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
+		complete(&mcspi->txdone);
+
+	return IRQ_HANDLED;
+}
+
+static int omap2_mcspi_slave_abort(struct spi_master *master)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
+	struct omap2_mcspi_dma *mcspi_dma = mcspi->dma_channels;
+
+	mcspi->slave_aborted = true;
+	complete(&mcspi_dma->dma_rx_completion);
+	complete(&mcspi_dma->dma_tx_completion);
+	complete(&mcspi->txdone);
+
+	return 0;
+}
+
 static int omap2_mcspi_transfer_one(struct spi_master *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *t)
@@ -1234,10 +1312,20 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma =
+		&mcspi->dma_channels[spi->chip_select];
+
+	if (!mcspi_dma->dma_rx || !mcspi_dma->dma_tx)
+		return false;
+
+	if (spi_controller_is_slave(master))
+		return true;
+
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
-static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
+static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
@@ -1254,7 +1342,7 @@ static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
-	omap2_mcspi_set_master_mode(master);
+	omap2_mcspi_set_mode(master);
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
@@ -1329,11 +1417,12 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 
-	master = spi_alloc_master(&pdev->dev, sizeof *mcspi);
-	if (master == NULL) {
-		dev_dbg(&pdev->dev, "master allocation failed\n");
+	if (of_property_read_bool(node, "spi-slave"))
+		master = spi_alloc_slave(&pdev->dev, sizeof(*mcspi));
+	else
+		master = spi_alloc_master(&pdev->dev, sizeof(*mcspi));
+	if (!master)
 		return -ENOMEM;
-	}
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
@@ -1345,6 +1434,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
+	master->slave_abort = omap2_mcspi_slave_abort;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
 	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
@@ -1396,15 +1486,31 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
 	}
 
+	status = platform_get_irq(pdev, 0);
+	if (status == -EPROBE_DEFER)
+		goto free_master;
+	if (status < 0) {
+		dev_err(&pdev->dev, "no irq resource found\n");
+		goto free_master;
+	}
+	init_completion(&mcspi->txdone);
+	status = devm_request_irq(&pdev->dev, status,
+				  omap2_mcspi_irq_handler, 0, pdev->name,
+				  mcspi);
+	if (status) {
+		dev_err(&pdev->dev, "Cannot request IRQ");
+		goto free_master;
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
 
-	status = omap2_mcspi_master_setup(mcspi);
+	status = omap2_mcspi_controller_setup(mcspi);
 	if (status < 0)
 		goto disable_pm;
 
-	status = devm_spi_register_master(&pdev->dev, master);
+	status = devm_spi_register_controller(&pdev->dev, master);
 	if (status < 0)
 		goto disable_pm;
 
-- 
2.19.0.rc2


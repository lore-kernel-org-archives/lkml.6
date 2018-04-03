Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDCPpP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:45:15 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:49640 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeDCPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:45:03 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v3 6/6] spi: sun6i: add DMA transfers support
Date: Tue,  3 Apr 2018 18:44:49 +0300
Message-Id: <20180403154449.2443-7-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5762EF02E88E7EF74840FE9263A247D7779C26A50B4EE702F725E5C173C3A84C3A1C30C8AFC676C8B9DA152596D0BA7FB6A58BF81F659395FC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491727495271F58E824348D1FC7163900CF6069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA transfers are now available for sun6i and sun8i SoCs.
The DMA mode is used automatically as soon as requested
transfer length is more than FIFO length.

Changes in v3:
1) Debug log enhancements.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 331 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 294 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 2fa9d6e..7f41871 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -14,6 +14,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -55,17 +57,20 @@
 
 #define SUN6I_FIFO_CTL_REG		0x18
 #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK	0xff
-#define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS	0
+#define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS	0
+#define SUN6I_FIFO_CTL_RF_DRQ_EN		BIT(8)
 #define SUN6I_FIFO_CTL_RF_RST			BIT(15)
 #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK	0xff
-#define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS	16
+#define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_POS	16
+#define SUN6I_FIFO_CTL_TF_DRQ_EN		BIT(24)
 #define SUN6I_FIFO_CTL_TF_RST			BIT(31)
+#define SUN6I_FIFO_CTL_DMA_DEDICATE		BIT(9)|BIT(25)
 
 #define SUN6I_FIFO_STA_REG		0x1c
 #define SUN6I_FIFO_STA_RF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_RF_CNT_BITS		0
+#define SUN6I_FIFO_STA_RF_CNT_POS		0
 #define SUN6I_FIFO_STA_TF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_TF_CNT_BITS		16
+#define SUN6I_FIFO_STA_TF_CNT_POS		16
 
 #define SUN6I_CLK_CTL_REG		0x24
 #define SUN6I_CLK_CTL_CDR2_MASK			0xff
@@ -135,7 +140,7 @@ static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
 
-	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
+	reg >>= SUN6I_FIFO_STA_TF_CNT_POS;
 
 	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
@@ -148,7 +153,7 @@ static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
 	/* See how much data is available */
 	reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
 	reg &= SUN6I_FIFO_STA_RF_CNT_MASK;
-	cnt = reg >> SUN6I_FIFO_STA_RF_CNT_BITS;
+	cnt = reg >> SUN6I_FIFO_STA_RF_CNT_POS;
 
 	if (len > cnt)
 		len = cnt;
@@ -177,6 +182,15 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
 	}
 }
 
+static bool sun6i_spi_can_dma(struct spi_master *master,
+			      struct spi_device *spi,
+			      struct spi_transfer *tfr)
+{
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+
+	return tfr->len > sspi->fifo_depth;
+}
+
 static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
@@ -208,6 +222,9 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	struct spi_master *master = spi->master;
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 
+	if (master->can_dma)
+		return SUN6I_MAX_XFER_SIZE;
+
 	return sspi->fifo_depth;
 }
 
@@ -268,16 +285,187 @@ static int sun6i_spi_wait_for_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static void sun6i_spi_dma_callback(void *param)
+{
+	struct spi_master *master = param;
+
+	dev_dbg(&master->dev, "DMA transfer complete\n");
+	spi_finalize_current_transfer(master);
+}
+
+static int sun6i_spi_dmap_prep_tx(struct spi_master *master,
+				  struct spi_transfer *tfr,
+				  dma_cookie_t *cookie)
+{
+	struct dma_async_tx_descriptor *chan_desc = NULL;
+
+	chan_desc = dmaengine_prep_slave_sg(master->dma_tx,
+					    tfr->tx_sg.sgl, tfr->tx_sg.nents,
+					    DMA_TO_DEVICE,
+					    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!chan_desc) {
+		dev_err(&master->dev,
+			"Couldn't prepare TX DMA slave\n");
+		return -EIO;
+	}
+
+	chan_desc->callback = sun6i_spi_dma_callback;
+	chan_desc->callback_param = master;
+
+	*cookie = dmaengine_submit(chan_desc);
+	dma_async_issue_pending(master->dma_tx);
+
+	return 0;
+}
+
+static int sun6i_spi_dmap_prep_rx(struct spi_master *master,
+				  struct spi_transfer *tfr,
+				  dma_cookie_t *cookie)
+{
+	struct dma_async_tx_descriptor *chan_desc = NULL;
+
+	chan_desc = dmaengine_prep_slave_sg(master->dma_rx,
+					    tfr->rx_sg.sgl, tfr->rx_sg.nents,
+					    DMA_FROM_DEVICE,
+					    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!chan_desc) {
+		dev_err(&master->dev,
+			"Couldn't prepare RX DMA slave\n");
+		return -EIO;
+	}
+
+	chan_desc->callback = sun6i_spi_dma_callback;
+	chan_desc->callback_param = master;
+
+	*cookie = dmaengine_submit(chan_desc);
+	dma_async_issue_pending(master->dma_rx);
+
+	return 0;
+}
+
+static int sun6i_spi_transfer_one_dma(struct spi_device *spi,
+				      struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	dma_cookie_t tx_cookie = 0,rx_cookie = 0;
+	enum dma_status status;
+	int ret;
+	u32 reg, trig_level = 0;
+
+	dev_dbg(&master->dev, "Using DMA mode for transfer\n");
+
+	/* Disable interrupts */
+	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
+
+	reg = sun6i_spi_read(sspi, SUN6I_FIFO_CTL_REG);
+
+	if (sspi->tx_buf) {
+		ret = sun6i_spi_dmap_prep_tx(master, tfr, &tx_cookie);
+		if (ret)
+			goto out;
+
+		reg |= SUN6I_FIFO_CTL_TF_DRQ_EN;
+
+		trig_level = sspi->fifo_depth;
+		reg &= ~SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK;
+		reg |= (trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_POS);
+	}
+
+	if (sspi->rx_buf) {
+		ret = sun6i_spi_dmap_prep_rx(master, tfr, &rx_cookie);
+		if (ret)
+			goto out;
+
+		reg |= SUN6I_FIFO_CTL_RF_DRQ_EN;
+
+		trig_level = 1;
+		reg &= ~SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK;
+		reg |= (trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS);
+	}
+
+	/* Enable Dedicated DMA requests */
+	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
+			reg | SUN6I_FIFO_CTL_DMA_DEDICATE);
+
+	/* Start transfer */
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
+
+	ret = sun6i_spi_wait_for_transfer(spi, tfr);
+	if (ret)
+		goto out;
+
+	if (sspi->tx_buf && (status = dma_async_is_tx_complete(master->dma_tx,
+			tx_cookie, NULL, NULL))) {
+		dev_warn(&master->dev,
+			"DMA returned completion status of: %s\n",
+			status == DMA_ERROR ? "error" : "in progress");
+	}
+	if (sspi->rx_buf && (status = dma_async_is_tx_complete(master->dma_rx,
+			rx_cookie, NULL, NULL))) {
+		dev_warn(&master->dev,
+			"DMA returned completion status of: %s\n",
+			status == DMA_ERROR ? "error" : "in progress");
+	}
+
+out:
+	if (ret) {
+		dev_dbg(&master->dev, "DMA channel teardown\n");
+		if (sspi->tx_buf)
+			dmaengine_terminate_sync(master->dma_tx);
+		if (sspi->rx_buf)
+			dmaengine_terminate_sync(master->dma_rx);
+	}
+
+	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
+
+	return ret;
+}
+
+static int sun6i_spi_transfer_one_pio(struct spi_device *spi,
+				      struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	unsigned int trig_level;
+	int ret;
+
+	/* Disable DMA requests */
+	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG, 0);
+
+	/*
+	 * Setup FIFO interrupt trigger level
+	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
+	 * value used in old generation of Allwinner SPI controller.
+	 * (See spi-sun4i.c)
+	 */
+	trig_level = sspi->fifo_depth / 4 * 3;
+	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
+			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_POS));
+
+	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
+
+	/* Enable the interrupts */
+	sun6i_spi_set(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC |
+					       SUN6I_INT_CTL_RF_RDY);
+
+	/* Start transfer */
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
+
+	ret = sun6i_spi_wait_for_transfer(spi, tfr);
+
+	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
+
+	return ret;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
-	unsigned int start, end, tx_time;
-	unsigned int trig_level;
+	unsigned int mclk_rate, div;
 	unsigned int tx_len = 0;
-	int ret = 0;
 	u32 reg;
 
 	/* A zero length transfer never finishes if programmed
@@ -285,10 +473,15 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	if (!tfr->len)
 		return 0;
 
-	/* Don't support transfer larger than the FIFO */
-	if (tfr->len > sspi->fifo_depth)
+	if (tfr->len > SUN6I_MAX_XFER_SIZE)
 		return -EMSGSIZE;
 
+	if (!master->can_dma) {
+		/* Don't support transfer larger than the FIFO */
+		if (tfr->len > sspi->fifo_depth)
+			return -EMSGSIZE;
+	}
+
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -300,16 +493,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
 			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
 
-	/*
-	 * Setup FIFO interrupt trigger level
-	 * Here we choose 3/4 of the full fifo depth, as it's the hardcoded
-	 * value used in old generation of Allwinner SPI controller.
-	 * (See spi-sun4i.c)
-	 */
-	trig_level = sspi->fifo_depth / 4 * 3;
-	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
-			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
-
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
@@ -364,22 +547,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
-	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
-
-	/* Enable the interrupts */
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
-					 SUN6I_INT_CTL_RF_RDY);
-
-	/* Start the transfer */
-	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
-
-	/* Wait for completion */
-	ret = sun6i_spi_wait_for_transfer(spi, tfr);
-
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
+	if (sun6i_spi_can_dma(master, spi, tfr))
+		return sun6i_spi_transfer_one_dma(spi, tfr);
 
-	return ret;
+	return sun6i_spi_transfer_one_pio(spi, tfr);
 }
 
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
@@ -409,6 +580,77 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static int sun6i_spi_dma_setup(struct platform_device *pdev,
+			       struct resource *res)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct dma_slave_config dma_sconf;
+	int ret;
+
+	master->dma_tx = dma_request_slave_channel_reason(&pdev->dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA TX channel\n");
+		ret = PTR_ERR(master->dma_tx);
+		goto out;
+	}
+
+	dma_sconf.direction = DMA_MEM_TO_DEV;
+	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr = res->start + SUN6I_TXDATA_REG;
+	dma_sconf.dst_maxburst = 1;
+	dma_sconf.src_maxburst = 1;
+
+	ret = dmaengine_slave_config(master->dma_tx, &dma_sconf);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure DMA TX slave\n");
+		goto err_rel_tx;
+	}
+
+	master->dma_rx = dma_request_slave_channel_reason(&pdev->dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA RX channel\n");
+		ret = PTR_ERR(master->dma_rx);
+		goto err_rel_tx;
+	}
+
+	dma_sconf.direction = DMA_DEV_TO_MEM;
+	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.src_addr = res->start + SUN6I_RXDATA_REG;
+	dma_sconf.src_maxburst = 1;
+	dma_sconf.dst_maxburst = 1;
+
+	ret = dmaengine_slave_config(master->dma_rx, &dma_sconf);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure DMA RX slave\n");
+		goto err_rel_rx;
+	}
+
+	/* don't set can_dma unless both channels are valid*/
+	master->can_dma = sun6i_spi_can_dma;
+
+	return 0;
+
+err_rel_rx:
+	dma_release_channel(master->dma_rx);
+err_rel_tx:
+	dma_release_channel(master->dma_tx);
+out:
+	master->dma_tx = NULL;
+	master->dma_rx = NULL;
+	return ret;
+}
+
+static void sun6i_spi_dma_release(struct spi_master *master)
+{
+	if (master->can_dma) {
+		dma_release_channel(master->dma_rx);
+		dma_release_channel(master->dma_tx);
+	}
+}
+
 static int sun6i_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -530,6 +772,16 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
+	ret = sun6i_spi_dma_setup(pdev, res);
+	if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			/* wait for the dma driver to load */
+			goto err_free_master;
+		}
+		dev_warn(&pdev->dev,
+			"Unable to setup DMA channels: DMA transfers disabled\n");
+	}
+
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
@@ -556,14 +808,19 @@ err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun6i_spi_runtime_suspend(&pdev->dev);
 err_free_master:
+	sun6i_spi_dma_release(master);
 	spi_master_put(master);
 	return ret;
 }
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
+	sun6i_spi_dma_release(master);
+
 	return 0;
 }
 
-- 
2.16.2

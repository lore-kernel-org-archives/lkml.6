Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeC2S7r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:59:47 -0400
Received: from fallback8.mail.ru ([94.100.181.110]:33454 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751096AbeC2S7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:59:42 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 6/6] spi: sun4i: add DMA transfers support
Date: Thu, 29 Mar 2018 21:59:07 +0300
Message-Id: <20180329185907.27281-7-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-7FA49CB5: 0D63561A33F958A5E7E84BCB95474281A67B693F76D0AEE7DAEEB0EBE06ADAE4725E5C173C3A84C3ADE50F0DA4A4E48C543E21D87CF4EB9D33F64B4C514AF25EC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491726089F99AD00C497D854B64B38880758069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA transfers are now available for sun4i-family SoCs.
The DMA mode is used automatically as soon as requested
transfer length is more than FIFO length.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun4i.c | 291 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 271 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fc913d4..9928af7 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -14,6 +14,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -39,6 +41,7 @@
 #define SUN4I_CTL_CPHA				BIT(2)
 #define SUN4I_CTL_CPOL				BIT(3)
 #define SUN4I_CTL_CS_ACTIVE_LOW			BIT(4)
+#define SUN4I_CTL_DMA_DEDICATED			BIT(5)
 #define SUN4I_CTL_LMTF				BIT(6)
 #define SUN4I_CTL_TF_RST			BIT(8)
 #define SUN4I_CTL_RF_RST			BIT(9)
@@ -58,6 +61,8 @@
 #define SUN4I_INT_STA_REG		0x10
 
 #define SUN4I_DMA_CTL_REG		0x14
+#define SUN4I_CTL_DMA_RF_READY			BIT(0)
+#define SUN4I_CTL_DMA_TF_NOT_FULL		BIT(10)
 
 #define SUN4I_WAIT_REG			0x18
 
@@ -169,6 +174,13 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 	}
 }
 
+static bool sun4i_spi_can_dma(struct spi_master *master,
+			      struct spi_device *spi,
+			      struct spi_transfer *tfr)
+{
+	return tfr->len > SUN4I_FIFO_DEPTH;
+}
+
 static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(spi->master);
@@ -208,6 +220,11 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 {
+	struct spi_master *master = spi->master;
+
+	if (master->can_dma)
+		return SUN4I_MAX_XFER_SIZE;
+
 	return SUN4I_FIFO_DEPTH;
 }
 
@@ -235,6 +252,160 @@ static int sun4i_spi_wait_for_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static void sun4i_spi_dma_callback(void *param)
+{
+	struct spi_master *master = param;
+
+	dev_dbg(&master->dev, "DMA transfer complete\n");
+	spi_finalize_current_transfer(master);
+}
+
+static int sun4i_spi_dmap_prep_tx(struct spi_master *master,
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
+	chan_desc->callback = sun4i_spi_dma_callback;
+	chan_desc->callback_param = master;
+
+	*cookie = dmaengine_submit(chan_desc);
+	dma_async_issue_pending(master->dma_tx);
+
+	return 0;
+}
+
+static int sun4i_spi_dmap_prep_rx(struct spi_master *master,
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
+	chan_desc->callback = sun4i_spi_dma_callback;
+	chan_desc->callback_param = master;
+
+	*cookie = dmaengine_submit(chan_desc);
+	dma_async_issue_pending(master->dma_rx);
+
+	return 0;
+}
+
+static int sun4i_spi_transfer_one_dma(struct spi_device *spi,
+				      struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	dma_cookie_t tx_cookie = 0, rx_cookie = 0;
+	enum dma_status status;
+	int ret;
+	u32 reg = 0;
+
+	dev_dbg(&master->dev, "Using DMA mode for transfer\n");
+
+	if (sspi->tx_buf) {
+		ret = sun4i_spi_dmap_prep_tx(master, tfr, &tx_cookie);
+		if (ret)
+			goto out;
+
+		reg |= SUN4I_CTL_DMA_TF_NOT_FULL;
+	}
+
+	if (sspi->rx_buf) {
+		ret = sun4i_spi_dmap_prep_rx(master, tfr, &rx_cookie);
+		if (ret)
+			goto out;
+
+		reg |= SUN4I_CTL_DMA_RF_READY;
+	}
+
+	sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, reg);
+
+	/* Dedicated DMA requests */
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_DMA_DEDICATED);
+
+	/* Start transfer */
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
+
+	/* Wait for completion */
+	ret = sun4i_spi_wait_for_transfer(spi, tfr);
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
+
+		if (sspi->tx_buf)
+			dmaengine_terminate_sync(master->dma_tx);
+		if (sspi->rx_buf)
+			dmaengine_terminate_sync(master->dma_rx);
+	}
+
+	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+
+	return ret;
+}
+
+static int sun4i_spi_transfer_one_pio(struct spi_device *spi,
+				      struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	/* Explicit disable DMA requests */
+	sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
+	sun4i_spi_unset(sspi, SUN4I_CTL_REG, SUN4I_CTL_DMA_DEDICATED);
+
+	/* Fill the TX FIFO */
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+
+	/* Enable transfer complete irq */
+	sun4i_spi_set(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
+
+	/* Start transfer */
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
+
+	ret = sun4i_spi_wait_for_transfer(spi, tfr);
+
+	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
+
+	return ret;
+}
+
 static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -242,13 +413,22 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div;
 	unsigned int tx_len = 0;
-	int ret = 0;
 	u32 reg;
 
-	/* We don't support transfers larger than FIFO depth */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
+	/* A zero length transfer never finishes if programmed
+	   in the hardware */
+	if (!tfr->len)
+		return 0;
+
+	if (tfr->len > SUN4I_MAX_XFER_SIZE)
 		return -EMSGSIZE;
 
+	if (!master->can_dma) {
+		/* Don't support transfer larger than the FIFO */
+		if (tfr->len > SUN4I_FIFO_DEPTH)
+			return -EMSGSIZE;
+	}
+
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -335,22 +515,10 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len));
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
 
-	/*
-	 * Fill the TX FIFO
-	 */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
-
-	/* Enable transfer complete interrupt */
-	sun4i_spi_set(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
-
-	/* Start the transfer */
-	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
-
-	ret = sun4i_spi_wait_for_transfer(spi, tfr);
-
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
+	if (sun4i_spi_can_dma(master, spi, tfr))
+		return sun4i_spi_transfer_one_dma(spi, tfr);
 
-	return ret;
+	return sun4i_spi_transfer_one_pio(spi, tfr);
 }
 
 static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
@@ -363,8 +531,7 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 
 	/* Transfer complete */
 	if (status & SUN4I_INT_CTL_TC) {
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,
-				SUN4I_INT_CTL_TC);
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
 		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
 		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
@@ -413,6 +580,76 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int sun4i_spi_dma_setup(struct device *dev,
+			       struct resource *res)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct dma_slave_config dma_sconf;
+	int ret;
+
+	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		dev_err(dev, "Unable to acquire DMA TX channel\n");
+		ret = PTR_ERR(master->dma_tx);
+		goto out;
+	}
+
+	dma_sconf.direction = DMA_MEM_TO_DEV;
+	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr = res->start + SUN4I_TXDATA_REG;
+	dma_sconf.dst_maxburst = 1;
+	dma_sconf.src_maxburst = 1;
+
+	ret = dmaengine_slave_config(master->dma_tx, &dma_sconf);
+	if (ret) {
+		dev_err(dev, "Unable to configure DMA TX slave\n");
+		goto err_rel_tx;
+	}
+
+	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		dev_err(dev, "Unable to acquire DMA RX channel\n");
+		ret = PTR_ERR(master->dma_rx);
+		goto err_rel_tx;
+	}
+
+	dma_sconf.direction = DMA_DEV_TO_MEM;
+	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconf.src_addr = res->start + SUN4I_RXDATA_REG;
+	dma_sconf.src_maxburst = 1;
+	dma_sconf.dst_maxburst = 1;
+
+	ret = dmaengine_slave_config(master->dma_rx, &dma_sconf);
+	if (ret) {
+		dev_err(dev, "Unable to configure DMA RX slave\n");
+		goto err_rel_rx;
+	}
+
+	/* don't set can_dma unless both channels are valid*/
+	master->can_dma = sun4i_spi_can_dma;
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
+static void sun4i_spi_dma_release(struct spi_master *master)
+{
+	if (master->can_dma) {
+		dma_release_channel(master->dma_rx);
+		dma_release_channel(master->dma_tx);
+	}
+}
+
 static int sun4i_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -475,6 +712,15 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
+	ret = sun4i_spi_dma_setup(&pdev->dev, res);
+	if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			/* wait for the dma driver to load */
+			goto err_free_master;
+		}
+		dev_warn(&pdev->dev, "DMA transfer not supported\n");
+	}
+
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
@@ -501,14 +747,19 @@ err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
 err_free_master:
+	sun4i_spi_dma_release(master);
 	spi_master_put(master);
 	return ret;
 }
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = platform_get_drvdata(pdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
+	sun4i_spi_dma_release(master);
+
 	return 0;
 }
 
-- 
2.16.2

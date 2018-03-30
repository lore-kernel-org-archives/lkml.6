Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeC3MvC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:51:02 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:37048 "EHLO smtp58.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3Mu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:50:59 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 3/6] spi: sun6i: restrict transfer length in PIO-mode
Date: Fri, 30 Mar 2018 15:50:44 +0300
Message-Id: <20180330125047.13936-4-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125047.13936-1-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
Authentication-Results: smtp58.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A51B8C93763DBCA0D826FD46E76099F7CD7F5E42990F99D6EB725E5C173C3A84C30584FF81F342DA07BE8AA6CEE2C329A633F64B4C514AF25EC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917073C6333C09018E9E446065F77D7F605069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to handle 3/4 empty/full interrupts as
the maximum supported transfer length in PIO mode is
128 bytes for sun6i- and 64 bytes for sun8i-family SoCs.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 61 ++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 78acc1f..4db1f20 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -207,7 +207,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN6I_MAX_XFER_SIZE - 1;
+	struct spi_master *master = spi->master;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+
+	return sspi->fifo_depth;
 }
 
 static int sun6i_spi_prepare_message(struct spi_master *master,
@@ -250,13 +253,18 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
-	unsigned int trig_level;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
 
-	if (tfr->len > SUN6I_MAX_XFER_SIZE)
-		return -EINVAL;
+	/* A zero length transfer never finishes if programmed
+	   in the hardware */
+	if (!tfr->len)
+		return 0;
+
+	/* Don't support transfer larger than the FIFO */
+	if (tfr->len > sspi->fifo_depth)
+		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
@@ -270,17 +278,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
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
-			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
-			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
-
 
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	/*
@@ -342,12 +339,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	/* Fill the TX FIFO */
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
-	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
-					 SUN6I_INT_CTL_RF_RDY);
-	if (tx_len > sspi->fifo_depth)
-		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
+	/* Enable transfer complete interrupt */
+	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC);
 
 	/* Start the transfer */
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -376,7 +369,9 @@ out:
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
 	struct sun6i_spi *sspi = dev_id;
-	u32 status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
+	u32 status;
+
+	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
 
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
@@ -386,28 +381,6 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* Receive FIFO 3/4 full */
-	if (status & SUN6I_INT_CTL_RF_RDY) {
-		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
-		/* Only clear the interrupt _after_ draining the FIFO */
-		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_RDY);
-		return IRQ_HANDLED;
-	}
-
-	/* Transmit FIFO 3/4 empty */
-	if (status & SUN6I_INT_CTL_TF_ERQ) {
-		sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
-
-		if (!sspi->len)
-			/* nothing left to transmit */
-			sun6i_spi_disable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
-
-		/* Only clear the interrupt _after_ re-seeding the FIFO */
-		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TF_ERQ);
-
-		return IRQ_HANDLED;
-	}
-
 	return IRQ_NONE;
 }
 
-- 
2.16.2

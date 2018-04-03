Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeDCP3R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:29:17 -0400
Received: from smtp54.i.mail.ru ([217.69.128.34]:56098 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbeDCP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:13 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 2/6] spi: sun4i: restrict transfer length in PIO-mode
Date: Tue,  3 Apr 2018 18:29:01 +0300
Message-Id: <20180403152905.1524-3-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5C5F1A375E31CFE67FD153644D6503B584944821BD68A5976725E5C173C3A84C3A1C30C8AFC676C8BE05AEED214505ADB42F54486E6D6388DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849178F89E4B4913BFFC4ED2FA081347DF743069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to handle the 3/4 FIFO empty interrupt
as the maximum supported transfer length in PIO mode
is 64 bytes.
As long as a problem was reported previously with filling FIFO
on A10s we want to stick with 63 bytes depth.

Changes in v2:
1) Restored processing of 3/4 FIFO full interrupt.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun4i.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 4141003..08fd007 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -22,7 +22,12 @@
 
 #include <linux/spi/spi.h>
 
-#define SUN4I_FIFO_DEPTH		64
+/*
+ * FIFO length is 64 bytes
+ * But filling the FIFO fully might cause a timeout
+ * on some devices, for example on spi2 on A10s
+ */
+#define SUN4I_FIFO_DEPTH		63
 
 #define SUN4I_RXDATA_REG		0x00
 
@@ -202,7 +207,7 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN4I_FIFO_DEPTH - 1;
+	return SUN4I_FIFO_DEPTH;
 }
 
 static int sun4i_spi_transfer_one(struct spi_master *master,
@@ -216,11 +221,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	int ret = 0;
 	u32 reg;
 
-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_MAX_XFER_SIZE)
-		return -EMSGSIZE;
-
-	if (tfr->tx_buf && tfr->len >= SUN4I_MAX_XFER_SIZE)
+	/* We don't support transfers larger than FIFO depth */
+	if (tfr->len > SUN4I_FIFO_DEPTH)
 		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
@@ -313,17 +315,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/*
 	 * Fill the TX FIFO
-	 * Filling the FIFO fully causes timeout for some reason
-	 * at least on spi2 on A10s
 	 */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
 	/* Enable the interrupts */
 	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC |
 					 SUN4I_INT_CTL_RF_F34);
-	/* Only enable Tx FIFO interrupt if we really need it */
-	if (tx_len > SUN4I_FIFO_DEPTH)
-		sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
 
 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -371,20 +368,6 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* Transmit FIFO 3/4 empty */
-	if (status & SUN4I_INT_CTL_TF_E34) {
-		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
-
-		if (!sspi->len)
-			/* nothing left to transmit */
-			sun4i_spi_disable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
-
-		/* Only clear the interrupt _after_ re-seeding the FIFO */
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TF_E34);
-
-		return IRQ_HANDLED;
-	}
-
 	return IRQ_NONE;
 }
 
-- 
2.16.2

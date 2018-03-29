Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeC2Xpt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:45:49 -0400
Received: from fallback15.m.smailru.net ([94.100.179.50]:33738 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbeC2Xpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:45:47 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
Date: Thu, 29 Mar 2018 21:59:03 +0300
Message-Id: <20180329185907.27281-3-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-7FA49CB5: 0D63561A33F958A5808026E8F35135DFA67B693F76D0AEE7AE2D8F02E624B458725E5C173C3A84C37C6C241D9975906405FC18484F73151C2686C055BC15B7FBC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849175D128B15B3A338D252E7ABDB9AAFF65C069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5026E996FA3219A4D2FDD9E4B5C530923AA8830A63C202843462275124DF8B9C9A939490BDF5DFC32E5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005631A4012884FA163B4833B1CCD152E7B02CAF0DDCCCCC7F801144500E45144ED5FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to handle 3/4 empty/full interrupts
as the maximum supported transfer length in PIO mode
is 64 bytes for sun4i-family SoCs. As long as a
problem was reported previously with filling FIFO
on A10s then we stick with 63 bytes depth.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun4i.c | 50 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 4141003..2a49c22 100644
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
@@ -313,17 +315,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	/*
 	 * Fill the TX FIFO
-	 * Filling the FIFO fully causes timeout for some reason
-	 * at least on spi2 on A10s
 	 */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
+	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
-	/* Enable the interrupts */
-	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC |
-					 SUN4I_INT_CTL_RF_F34);
-	/* Only enable Tx FIFO interrupt if we really need it */
-	if (tx_len > SUN4I_FIFO_DEPTH)
-		sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TF_E34);
+	/* Enable the transfer complete interrupt */
+	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC);
 
 	/* Start the transfer */
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -363,28 +359,6 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* Receive FIFO 3/4 full */
-	if (status & SUN4I_INT_CTL_RF_F34) {
-		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
-		/* Only clear the interrupt _after_ draining the FIFO */
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_RF_F34);
-		return IRQ_HANDLED;
-	}
-
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

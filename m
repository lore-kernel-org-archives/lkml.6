Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDCP3h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:29:37 -0400
Received: from smtp54.i.mail.ru ([217.69.128.34]:34306 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbeDCP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:16 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 5/6] spi: sun4i: introduce register set/unset helpers
Date: Tue,  3 Apr 2018 18:29:04 +0300
Message-Id: <20180403152905.1524-6-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A599C85922B24F2F2EFD153644D6503B5897EC0D2FCC39F5ED725E5C173C3A84C3A1C30C8AFC676C8B00932676BA91E3DEC96613F75B7D048DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849172D9EF3D5532EE6439962E812D144211F069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helper functions were added in order to set/unset
specified flags in registers.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun4i.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 9d1bc20..d81d31c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -107,29 +107,29 @@ static inline void sun4i_spi_write(struct sun4i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
+static inline void sun4i_spi_set(struct sun4i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
-
-	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+	u32 reg = sun4i_spi_read(sspi, addr);
 
-	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
+	reg |= val;
+	sun4i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun4i_spi_enable_interrupt(struct sun4i_spi *sspi, u32 mask)
+static inline void sun4i_spi_unset(struct sun4i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	u32 reg = sun4i_spi_read(sspi, addr);
 
-	reg |= mask;
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+	reg &= ~val;
+	sun4i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun4i_spi_disable_interrupt(struct sun4i_spi *sspi, u32 mask)
+static inline u32 sun4i_spi_get_tx_fifo_count(struct sun4i_spi *sspi)
 {
-	u32 reg = sun4i_spi_read(sspi, SUN4I_INT_CTL_REG);
+	u32 reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
 
-	reg &= ~mask;
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
+	reg >>= SUN4I_FIFO_STA_TF_CNT_BITS;
+
+	return reg & SUN4I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
@@ -256,13 +256,12 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	/* Clear pending interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_STA_REG, ~0);
 
+	/* Reset FIFOs */
+	sun4i_spi_set(sspi, SUN4I_CTL_REG,
+		      SUN4I_CTL_RF_RST | SUN4I_CTL_TF_RST);
 
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 
-	/* Reset FIFOs */
-	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			reg | SUN4I_CTL_RF_RST | SUN4I_CTL_TF_RST);
-
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
@@ -342,12 +341,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
 	/* Enable the interrupts */
-	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC |
-					 SUN4I_INT_CTL_RF_F34);
+	sun4i_spi_set(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
+					       SUN4I_INT_CTL_RF_F34);
 
 	/* Start the transfer */
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
 
 	ret = sun4i_spi_wait_for_transfer(spi, tfr);
 
-- 
2.16.2

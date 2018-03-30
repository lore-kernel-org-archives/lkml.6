Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeC3Mvr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:51:47 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:37238 "EHLO smtp58.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeC3MvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:51:02 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 5/6] spi: sun6i: introduce register set/unset helpers
Date: Fri, 30 Mar 2018 15:50:46 +0300
Message-Id: <20180330125047.13936-6-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125047.13936-1-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
Authentication-Results: smtp58.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5AB25AEB6506C525A26FD46E76099F7CD2FC233A19F196D28725E5C173C3A84C30584FF81F342DA07158F85BCCB133A2BBA6625F88748EAEFC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849176DB535D4334AC0DE048CC1BBC53CF8E5069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helper functions were added in order to update registers
easily.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 210cef9..18f9344 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -115,29 +115,29 @@ static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
+static inline void sun6i_spi_set(struct sun6i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
-
-	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
+	u32 reg = sun6i_spi_read(sspi, addr);
 
-	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
+	reg |= val;
+	sun6i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun6i_spi_enable_interrupt(struct sun6i_spi *sspi, u32 mask)
+static inline void sun6i_spi_unset(struct sun6i_spi *sspi, u32 addr, u32 val)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
+	u32 reg = sun6i_spi_read(sspi, addr);
 
-	reg |= mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	reg &= ~val;
+	sun6i_spi_write(sspi, addr, reg);
 }
 
-static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
+static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
+	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
 
-	reg &= ~mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
+
+	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
@@ -299,18 +299,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
 			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
 
-
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUN6I_TFR_CTL_DHB;
+		sun6i_spi_unset(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
 	else
-		reg |= SUN6I_TFR_CTL_DHB;
-
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+		sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_DHB);
 
 
 	/* Ensure that we have a parent clock fast enough */
@@ -361,11 +357,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable transfer complete interrupt */
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC);
+	sun6i_spi_set(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
 
 	/* Start the transfer */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
 
 	/* Wait for completion */
 	ret = sun6i_spi_wait_for_transfer(spi, tfr);
-- 
2.16.2

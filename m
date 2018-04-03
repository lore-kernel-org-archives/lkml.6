Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDCPpF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:45:05 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:49430 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752397AbeDCPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:45:00 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v3 5/6] spi: sun6i: introduce register set/unset helpers
Date: Tue,  3 Apr 2018 18:44:48 +0300
Message-Id: <20180403154449.2443-6-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A537C7BB0BF297BE1A840FE9263A247D77CA372C53EC9176C4725E5C173C3A84C3A1C30C8AFC676C8B1A771AA41596296142F54486E6D6388DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917467990E338ED3B3CCAEEB02C4D640132069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helper functions were added in order to set/unset
specified flags in registers.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 0912404..2fa9d6e 100644
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
@@ -310,18 +310,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
 			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
 
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
@@ -376,8 +372,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 					 SUN6I_INT_CTL_RF_RDY);
 
 	/* Start the transfer */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
+	sun6i_spi_set(sspi, SUN6I_TFR_CTL_REG, SUN6I_TFR_CTL_XCH);
 
 	/* Wait for completion */
 	ret = sun6i_spi_wait_for_transfer(spi, tfr);
-- 
2.16.2

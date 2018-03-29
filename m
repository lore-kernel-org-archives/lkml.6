Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeC2S7m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:59:42 -0400
Received: from fallback5.mail.ru ([94.100.181.253]:54398 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751151AbeC2S7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:59:38 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 5/6] spi: sun4i: introduce register set/unset helpers
Date: Thu, 29 Mar 2018 21:59:06 +0300
Message-Id: <20180329185907.27281-6-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-7FA49CB5: 0D63561A33F958A55778B6CBB183EA6FA67B693F76D0AEE7F409322A2F59C95C725E5C173C3A84C3ADE50F0DA4A4E48C53333C6F2D013B24463FC242DBD691A6C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917D3AC8FC500FE72F639A6197812DC186E069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helper functions were added in order to update
registers easily.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun4i.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 4f24e12..fc913d4 100644
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
@@ -341,12 +340,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 */
 	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
 
-	/* Enable the transfer complete interrupt */
-	sun4i_spi_enable_interrupt(sspi, SUN4I_INT_CTL_TC);
+	/* Enable transfer complete interrupt */
+	sun4i_spi_set(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
 
 	/* Start the transfer */
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
+	sun4i_spi_set(sspi, SUN4I_CTL_REG, SUN4I_CTL_XCH);
 
 	ret = sun4i_spi_wait_for_transfer(spi, tfr);
 
-- 
2.16.2

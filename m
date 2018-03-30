Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeC3HX3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:23:29 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:44158 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbeC3HXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:23:00 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 5/6] spi: sun6i: introduce register set/unset helpers
Date: Fri, 30 Mar 2018 10:22:42 +0300
Message-Id: <20180330072243.19368-6-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5A5969E41730D17C3BC0A8B6031D50A00B79BB70FD94E84F6725E5C173C3A84C39D7D3120FB43BDE306D2D1B0C00C8F8E57739F23D657EF2BB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DB48C21F01D89DB561574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917F8FEBC106A3C9308647CABC7898F18DD069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helper functions were added in order to update
registers easily.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fc43752..a6e6812 100644
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
+
+	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
 
-	reg &= ~mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
+	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
 
 static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
@@ -357,11 +357,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
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

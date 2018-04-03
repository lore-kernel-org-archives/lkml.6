Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeDCP35 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:29:57 -0400
Received: from smtp54.i.mail.ru ([217.69.128.34]:56282 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeDCP3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:15 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 4/6] spi: sun4i: use completion provided by SPI core driver
Date: Tue,  3 Apr 2018 18:29:03 +0300
Message-Id: <20180403152905.1524-5-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5867E4A37E9E76722FD153644D6503B58FCF18621794CBE6A725E5C173C3A84C3A1C30C8AFC676C8BEF7DAE5A97A36F010B02670E5FEECA50C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849176801F7B5D7DB7549E951D1E194969133069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as the completion already provided by the SPI core
then there is no need to waste extra-memory on this.
Also a waiting function was added to avoid code duplication.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun4i.c | 62 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 899e956..9d1bc20 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -92,8 +92,6 @@ struct sun4i_spi {
 	struct clk		*hclk;
 	struct clk		*mclk;
 
-	struct completion	done;
-
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
@@ -213,13 +211,36 @@ static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN4I_FIFO_DEPTH;
 }
 
+static int sun4i_spi_wait_for_transfer(struct spi_device *spi,
+				       struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	unsigned int start, end, tx_time;
+	unsigned int timeout;
+
+	/* calc required timeout from given speed & len values */
+	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
+	start = jiffies;
+	timeout = wait_for_completion_timeout(&master->xfer_completion,
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
+	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
+			 jiffies_to_msecs(end - start), tx_time);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int sun4i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
-	unsigned int start, end, tx_time;
+	unsigned int mclk_rate, div;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
@@ -228,7 +249,6 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	if (tfr->len > SUN4I_FIFO_DEPTH)
 		return -EMSGSIZE;
 
-	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -329,22 +349,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
 
-	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
-	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
-	end = jiffies;
-	if (!timeout) {
-		dev_warn(&master->dev,
-			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
-			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-			 jiffies_to_msecs(end - start), tx_time);
-		ret = -ETIMEDOUT;
-		goto out;
-	}
-
+	ret = sun4i_spi_wait_for_transfer(spi, tfr);
 
-out:
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
 
 	return ret;
@@ -352,14 +358,18 @@ out:
 
 static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 {
-	struct sun4i_spi *sspi = dev_id;
-	u32 status = sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
+	struct spi_master *master = dev_id;
+	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	u32 status;
+
+	status = sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
 
 	/* Transfer complete */
 	if (status & SUN4I_INT_CTL_TC) {
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
+		sun4i_spi_write(sspi, SUN4I_INT_STA_REG,
+				SUN4I_INT_CTL_TC);
 		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
-		complete(&sspi->done);
+		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
 	}
 
@@ -456,7 +466,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
-			       0, dev_name(&pdev->dev), sspi);
+			       0, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -476,8 +486,6 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	init_completion(&sspi->done);
-
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
-- 
2.16.2

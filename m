Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeDCPpx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:45:53 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:49298 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeDCPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:44:59 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v3 4/6] spi: sun6i: use completion provided by SPI core
Date: Tue,  3 Apr 2018 18:44:47 +0300
Message-Id: <20180403154449.2443-5-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403154449.2443-1-ssuloev@orpaltech.com>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A505A817744D892096840FE9263A247D77F6CCE0BD96863144725E5C173C3A84C3A1C30C8AFC676C8B8FCF3E344E8F691A2219AA581D1B0840C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917604D420E97150EFE5351951060103B38069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as the completion is already provided by the SPI core
then there is no need to waste extra-memory on this.
Also a waiting function was added to avoid code duplication.

Changes in v2:
1) Fixed issue with passing an invalid argument into devm_request_irq()
function.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi-sun6i.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index c09ad10..0912404 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -99,8 +99,6 @@ struct sun6i_spi {
 	struct clk		*mclk;
 	struct reset_control	*rstc;
 
-	struct completion	done;
-
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
@@ -246,6 +244,30 @@ static int sun6i_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int sun6i_spi_wait_for_transfer(struct spi_device *spi,
+				       struct spi_transfer *tfr)
+{
+	struct spi_master *master = spi->master;
+	unsigned int start, end, tx_time;
+	unsigned int timeout;
+
+	/* smart wait for completion */
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
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -267,7 +289,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	if (tfr->len > sspi->fifo_depth)
 		return -EMSGSIZE;
 
-	reinit_completion(&sspi->done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -358,21 +379,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
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
+	/* Wait for completion */
+	ret = sun6i_spi_wait_for_transfer(spi, tfr);
 
-out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
 	return ret;
@@ -380,7 +389,8 @@ out:
 
 static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 {
-	struct sun6i_spi *sspi = dev_id;
+	struct spi_master *master = dev_id;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
 	u32 status;
 
 	status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
@@ -389,7 +399,7 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
 		sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
-		complete(&sspi->done);
+		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
 	}
 
@@ -496,7 +506,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
-			       0, dev_name(&pdev->dev), sspi);
+			       0, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -518,8 +528,6 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	init_completion(&sspi->done);
-
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
-- 
2.16.2

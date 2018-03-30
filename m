Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeC3MwH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:52:07 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:36904 "EHLO smtp58.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbeC3Mu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:50:57 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 1/6] spi: sun6i: coding style/readability improvements
Date: Fri, 30 Mar 2018 15:50:42 +0300
Message-Id: <20180330125047.13936-2-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125047.13936-1-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
Authentication-Results: smtp58.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5E38A14485A1D41EB26FD46E76099F7CD1C50E35CC54CC232725E5C173C3A84C3EBF4D8D28E8B6903ED2F9B9BFAFF19550555CCFDA08FA3FAC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917C63AC967F29A4BB76A903DEFD0FF3972069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor changes to fulfill the coding style and improve
the readability of the code.

Changes in v2:
1) Fixed issue with misplacing a piece of code that requires access
to the transfer structure into sun6i_spi_prepare_message() function
where the transfer structure is not available.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8533f4e..88ad45e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -88,8 +88,12 @@
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
 
+#define SUN6I_SPI_MODE_BITS		(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+#define SUN6I_SPI_MAX_SPEED_HZ		100000000
+#define SUN6I_SPI_MIN_SPEED_HZ		3000
+
 struct sun6i_spi {
-	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
@@ -189,6 +193,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	else
 		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
 
+	/* We want to control the chip select manually */
+	reg |= SUN6I_TFR_CTL_CS_MANUAL;
+
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 }
 
@@ -197,6 +204,39 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static int sun6i_spi_prepare_message(struct spi_master *master,
+				     struct spi_message *msg)
+{
+	struct spi_device *spi = msg->spi;
+	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	u32 reg;
+
+	/*
+	 * Setup the transfer control register: Chip Select,
+	 * polarities, etc.
+	 */
+	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+
+	if (spi->mode & SPI_CPOL)
+		reg |= SUN6I_TFR_CTL_CPOL;
+	else
+		reg &= ~SUN6I_TFR_CTL_CPOL;
+
+	if (spi->mode & SPI_CPHA)
+		reg |= SUN6I_TFR_CTL_CPHA;
+	else
+		reg &= ~SUN6I_TFR_CTL_CPHA;
+
+	if (spi->mode & SPI_LSB_FIRST)
+		reg |= SUN6I_TFR_CTL_FBS;
+	else
+		reg &= ~SUN6I_TFR_CTL_FBS;
+
+	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+
+	return 0;
+}
+
 static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
@@ -235,27 +275,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
 			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
 
-	/*
-	 * Setup the transfer control register: Chip Select,
-	 * polarities, etc.
-	 */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-
-	if (spi->mode & SPI_CPOL)
-		reg |= SUN6I_TFR_CTL_CPOL;
-	else
-		reg &= ~SUN6I_TFR_CTL_CPOL;
-
-	if (spi->mode & SPI_CPHA)
-		reg |= SUN6I_TFR_CTL_CPHA;
-	else
-		reg &= ~SUN6I_TFR_CTL_CPHA;
-
-	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUN6I_TFR_CTL_FBS;
-	else
-		reg &= ~SUN6I_TFR_CTL_FBS;
 
+	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
@@ -265,11 +286,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN6I_TFR_CTL_DHB;
 
-	/* We want to control the chip select manually */
-	reg |= SUN6I_TFR_CTL_CS_MANUAL;
-
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
+
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
 	if (mclk_rate < (2 * tfr->speed_hz)) {
@@ -442,12 +461,24 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	struct resource	*res;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
 	}
 
+	master->max_speed_hz = SUN6I_SPI_MAX_SPEED_HZ;
+	master->min_speed_hz = SUN6I_SPI_MIN_SPEED_HZ;
+	master->num_chipselect = 4;
+	master->mode_bits = SUN6I_SPI_MODE_BITS;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->set_cs = sun6i_spi_set_cs;
+	master->prepare_message = sun6i_spi_prepare_message;
+	master->transfer_one = sun6i_spi_transfer_one;
+	master->max_transfer_size = sun6i_spi_max_transfer_size;
+	master->dev.of_node = pdev->dev.of_node;
+	master->auto_runtime_pm = true;
+
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
@@ -466,26 +497,14 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
-			       0, "sun6i-spi", sspi);
+			       0, dev_name(&pdev->dev), sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
 	}
 
-	sspi->master = master;
 	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
 
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->set_cs = sun6i_spi_set_cs;
-	master->transfer_one = sun6i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun6i_spi_max_transfer_size;
-
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
@@ -525,7 +544,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register SPI master\n");
+		dev_err(&pdev->dev, "Couldn't register SPI master\n");
 		goto err_pm_disable;
 	}
 
-- 
2.16.2

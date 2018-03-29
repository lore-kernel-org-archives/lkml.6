Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeC2XFr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:05:47 -0400
Received: from fallback11.m.smailru.net ([94.100.179.26]:56100 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbeC2XFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:05:44 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 3/6] spi: sun4i: coding style/readability improvements
Date: Thu, 29 Mar 2018 21:59:04 +0300
Message-Id: <20180329185907.27281-4-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-7FA49CB5: 0D63561A33F958A5A9AF803299D5B4BBA67B693F76D0AEE747CB27B903A3BD78725E5C173C3A84C37C6C241D99759064B52414FA72E65BCF0555CCFDA08FA3FAC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917E656F18E0F8C6675174EF47DBBB97F1B069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A557E1F21B1BEB3E480A4A71B57A46300009A17C1F181AE78D462275124DF8B9C9A939490BDF5DFC32E5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005631A4012884FA16352B0F6778DC341102C3CC47308AF9E1099F868C671225E395FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor changes to fulfill the coding style and
improve the readability.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun4i.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 2a49c22..2d716f1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -83,8 +83,11 @@
 #define SUN4I_FIFO_STA_TF_CNT_MASK		0x7f
 #define SUN4I_FIFO_STA_TF_CNT_BITS		16
 
+#define SUN4I_SPI_MAX_SPEED_HZ		100 * 1000 * 1000
+#define SUN4I_SPI_MIN_SPEED_HZ		3 * 1000
+#define SUN4I_SPI_MODE_BITS		(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
 struct sun4i_spi {
-	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
@@ -409,12 +412,23 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	struct resource	*res;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun4i_spi));
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
 	}
 
+	master->max_speed_hz = SUN4I_SPI_MAX_SPEED_HZ;
+	master->min_speed_hz = SUN4I_SPI_MIN_SPEED_HZ;
+	master->num_chipselect = 4;
+	master->mode_bits = SUN4I_SPI_MODE_BITS;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->set_cs = sun4i_spi_set_cs;
+	master->transfer_one = sun4i_spi_transfer_one;
+	master->max_transfer_size = sun4i_spi_max_transfer_size;
+	master->dev.of_node = pdev->dev.of_node;
+	master->auto_runtime_pm = true;
+
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 
@@ -433,24 +447,12 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
-			       0, "sun4i-spi", sspi);
+			       0, dev_name(&pdev->dev), sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
 	}
 
-	sspi->master = master;
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->set_cs = sun4i_spi_set_cs;
-	master->transfer_one = sun4i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun4i_spi_max_transfer_size;
-
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
-- 
2.16.2

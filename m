Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeECNjq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:39:46 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:9146 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeECNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:38:45 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Mark Brown <broonie@kernel.org>
CC: Sunny Luo <sunny.luo@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] spi: meson-axg: support MAX 80M clock
Date: Thu, 3 May 2018 21:36:42 +0000
Message-ID: <20180503213645.20694-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503213645.20694-1-yixun.lan@amlogic.com>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunny Luo <sunny.luo@amlogic.com>

The SPICC controller in Meson-AXG is capable of running at 80M clock.
The ASIC IP is improved and the clock is actually running higher than
previous old SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 5c82910e3480..8489f4c9f465 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -9,11 +9,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
@@ -34,7 +36,6 @@
  *   to have a CS go down over the full transfer
  */
 
-#define SPICC_MAX_FREQ	30000000
 #define SPICC_MAX_BURST	128
 
 /* Register Map */
@@ -120,6 +121,10 @@
 #define SPICC_BURST_MAX	16
 #define SPICC_FIFO_HALF 10
 
+struct meson_spicc_data {
+	unsigned int			max_speed_hz;
+};
+
 struct meson_spicc_device {
 	struct spi_master		*master;
 	struct platform_device		*pdev;
@@ -127,6 +132,7 @@ struct meson_spicc_device {
 	struct clk			*core;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
+	const struct meson_spicc_data	*data;
 	u8				*tx_buf;
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
@@ -517,6 +523,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc->pdev = pdev;
 	platform_set_drvdata(pdev, spicc);
 
+	spicc->data = (const struct meson_spicc_data *)
+		of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spicc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spicc->base)) {
@@ -567,11 +576,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
 	master->transfer_one = meson_spicc_transfer_one;
 
-	/* Setup max rate according to the Meson GX datasheet */
-	if ((rate >> 2) > SPICC_MAX_FREQ)
-		master->max_speed_hz = SPICC_MAX_FREQ;
-	else
-		master->max_speed_hz = rate >> 2;
+	/* Setup max rate according to the Meson datasheet */
+	master->max_speed_hz = min_t(unsigned int, rate >> 1,
+			spicc->data->max_speed_hz);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (!ret)
@@ -597,9 +604,23 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_spicc_data meson_spicc_gx_data = {
+	.max_speed_hz	= 30000000,
+};
+
+static const struct meson_spicc_data meson_spicc_axg_data = {
+	.max_speed_hz	= 80000000,
+};
+
 static const struct of_device_id meson_spicc_of_match[] = {
-	{ .compatible = "amlogic,meson-gx-spicc", },
-	{ .compatible = "amlogic,meson-axg-spicc", },
+	{
+		.compatible	= "amlogic,meson-gx-spicc",
+		.data		= &meson_spicc_gx_data,
+	},
+	{
+		.compatible = "amlogic,meson-axg-spicc",
+		.data		= &meson_spicc_axg_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.17.0

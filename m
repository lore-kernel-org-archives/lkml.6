Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeCPWVe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:21:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44852 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:21:32 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] spi: jcore: disable clock on remove
Date: Sat, 17 Mar 2018 01:21:18 +0300
Message-Id: <1521238878-27159-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not disable ref_clk on remove.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/spi/spi-jcore.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index dafed6280df3..68cac15ff54a 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -38,6 +38,7 @@ struct jcore_spi {
 	unsigned int speed_reg;
 	unsigned int speed_hz;
 	unsigned int clock_freq;
+	struct clk   *clk;
 };
 
 static int jcore_spi_wait(void __iomem *ctrl_reg)
@@ -143,7 +144,6 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *res;
 	u32 clock_freq;
-	struct clk *clk;
 	int err = -ENODEV;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct jcore_spi));
@@ -183,10 +183,10 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	 * requested rate. If the clock is omitted, 50 MHz is assumed.
 	 */
 	clock_freq = 50000000;
-	clk = devm_clk_get(&pdev->dev, "ref_clk");
-	if (!IS_ERR_OR_NULL(clk)) {
-		if (clk_enable(clk) == 0)
-			clock_freq = clk_get_rate(clk);
+	hw->clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (!IS_ERR_OR_NULL(hw->clk)) {
+		if (clk_enable(hw->clk) == 0)
+			clock_freq = clk_get_rate(hw->clk);
 		else
 			dev_warn(&pdev->dev, "could not enable ref_clk\n");
 	}
@@ -199,7 +199,7 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	/* Register our spi controller */
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
-		clk_disable(clk);
+		clk_disable(hw->clk);
 		goto exit;
 	}
 
@@ -212,6 +212,19 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int jcore_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct jcore_spi *hw;
+
+	master = platform_get_drvdata(pdev);
+	hw = spi_master_get_devdata(master);
+
+	clk_disable(hw->clk);
+
+	return 0;
+}
+
 static const struct of_device_id jcore_spi_of_match[] = {
 	{ .compatible = "jcore,spi2" },
 	{},
@@ -220,6 +233,7 @@ MODULE_DEVICE_TABLE(of, jcore_spi_of_match);
 
 static struct platform_driver jcore_spi_driver = {
 	.probe = jcore_spi_probe,
+	.remove	= jcore_spi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = jcore_spi_of_match,
-- 
2.7.4

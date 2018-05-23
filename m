Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeEWQJg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:09:36 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43344 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEWQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:09:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="14275990"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC: <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] mtd: atmel-quadspi: add suspend/resume hooks
Date: Wed, 23 May 2018 19:08:48 +0300
Message-ID: <1527091728-19895-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement suspend/resume hooks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 6c5708bacad8..85d7610fb920 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -737,6 +737,28 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int atmel_qspi_suspend(struct device *dev)
+{
+	struct atmel_qspi *aq = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(aq->clk);
+
+	return 0;
+}
+
+static int atmel_qspi_resume(struct device *dev)
+{
+	struct atmel_qspi *aq = dev_get_drvdata(dev);
+
+	clk_prepare_enable(aq->clk);
+
+	return atmel_qspi_init(aq);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
+			 atmel_qspi_resume);
 
 static const struct of_device_id atmel_qspi_dt_ids[] = {
 	{ .compatible = "atmel,sama5d2-qspi" },
@@ -749,6 +771,7 @@ static struct platform_driver atmel_qspi_driver = {
 	.driver = {
 		.name	= "atmel_qspi",
 		.of_match_table	= atmel_qspi_dt_ids,
+		.pm	= &atmel_qspi_pm_ops,
 	},
 	.probe		= atmel_qspi_probe,
 	.remove		= atmel_qspi_remove,
-- 
2.7.4

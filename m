Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeFDIqq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:46:46 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:35696 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeFDIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:46:44 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="14820780"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC: <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
Date: Mon, 4 Jun 2018 11:46:33 +0300
Message-ID: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement suspend/resume hooks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP

 drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 6c5708bacad8..ceaaef47f02e 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused atmel_qspi_suspend(struct device *dev)
+{
+	struct atmel_qspi *aq = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(aq->clk);
+
+	return 0;
+}
+
+static int __maybe_unused atmel_qspi_resume(struct device *dev)
+{
+	struct atmel_qspi *aq = dev_get_drvdata(dev);
+
+	clk_prepare_enable(aq->clk);
+
+	return atmel_qspi_init(aq);
+}
+
+static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
+			 atmel_qspi_resume);
 
 static const struct of_device_id atmel_qspi_dt_ids[] = {
 	{ .compatible = "atmel,sama5d2-qspi" },
@@ -749,6 +769,7 @@ static struct platform_driver atmel_qspi_driver = {
 	.driver = {
 		.name	= "atmel_qspi",
 		.of_match_table	= atmel_qspi_dt_ids,
+		.pm	= &atmel_qspi_pm_ops,
 	},
 	.probe		= atmel_qspi_probe,
 	.remove		= atmel_qspi_remove,
-- 
2.7.4

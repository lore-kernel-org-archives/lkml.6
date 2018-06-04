Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeFDMGL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:06:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47313 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752413AbeFDMGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:06:06 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: sunxi: fix possible race condition
Date: Mon,  4 Jun 2018 14:05:40 +0200
Message-Id: <20180604120540.5782-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sunxi.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index dadbf8b324ad..21865d3d8fe8 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -445,6 +445,10 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 	chip->dev = &pdev->dev;
 
+	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(chip->rtc))
+		return PTR_ERR(chip->rtc);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	chip->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(chip->base))
@@ -481,11 +485,12 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	writel(SUNXI_ALRM_IRQ_STA_CNT_IRQ_PEND, chip->base +
 			SUNXI_ALRM_IRQ_STA);
 
-	chip->rtc = rtc_device_register("rtc-sunxi", &pdev->dev,
-			&sunxi_rtc_ops, THIS_MODULE);
-	if (IS_ERR(chip->rtc)) {
+	chip->rtc->ops = &sunxi_rtc_ops;
+
+	ret = rtc_register_device(chip->rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "unable to register device\n");
-		return PTR_ERR(chip->rtc);
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "RTC enabled\n");
@@ -493,18 +498,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_rtc_remove(struct platform_device *pdev)
-{
-	struct sunxi_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(chip->rtc);
-
-	return 0;
-}
-
 static struct platform_driver sunxi_rtc_driver = {
 	.probe		= sunxi_rtc_probe,
-	.remove		= sunxi_rtc_remove,
 	.driver		= {
 		.name		= "sunxi-rtc",
 		.of_match_table = sunxi_rtc_dt_ids,
-- 
2.17.1

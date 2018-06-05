Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeFEOSc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:18:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48169 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbeFEOSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:18:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: mrst: switch to devm functions
Date: Tue,  5 Jun 2018 16:18:17 +0200
Message-Id: <20180605141817.317-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm managed functions to simplify error handling and device
removal

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mrst.c | 45 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index fcb9de5218b2..097a4d4e2aba 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -45,7 +45,6 @@ struct mrst_rtc {
 	struct rtc_device	*rtc;
 	struct device		*dev;
 	int			irq;
-	struct resource		*iomem;
 
 	u8			enabled_wake;
 	u8			suspend_ctrl;
@@ -329,24 +328,22 @@ static int vrtc_mrst_do_probe(struct device *dev, struct resource *iomem,
 	if (!iomem)
 		return -ENODEV;
 
-	iomem = request_mem_region(iomem->start, resource_size(iomem),
-				   driver_name);
+	iomem = devm_request_mem_region(dev, iomem->start, resource_size(iomem),
+					driver_name);
 	if (!iomem) {
 		dev_dbg(dev, "i/o mem already in use.\n");
 		return -EBUSY;
 	}
 
 	mrst_rtc.irq = rtc_irq;
-	mrst_rtc.iomem = iomem;
 	mrst_rtc.dev = dev;
 	dev_set_drvdata(dev, &mrst_rtc);
 
-	mrst_rtc.rtc = rtc_device_register(driver_name, dev,
-				&mrst_rtc_ops, THIS_MODULE);
-	if (IS_ERR(mrst_rtc.rtc)) {
-		retval = PTR_ERR(mrst_rtc.rtc);
-		goto cleanup0;
-	}
+	mrst_rtc.rtc = devm_rtc_allocate_device(dev);
+	if (IS_ERR(mrst_rtc.rtc))
+		return PTR_ERR(mrst_rtc.rtc);
+
+	mrst_rtc.rtc->ops = &mrst_rtc_ops;
 
 	rename_region(iomem, dev_name(&mrst_rtc.rtc->dev));
 
@@ -359,23 +356,27 @@ static int vrtc_mrst_do_probe(struct device *dev, struct resource *iomem,
 		dev_dbg(dev, "TODO: support more than 24-hr BCD mode\n");
 
 	if (rtc_irq) {
-		retval = request_irq(rtc_irq, mrst_rtc_irq,
-				0, dev_name(&mrst_rtc.rtc->dev),
-				mrst_rtc.rtc);
+		retval = devm_request_irq(dev, rtc_irq, mrst_rtc_irq,
+					  0, dev_name(&mrst_rtc.rtc->dev),
+					  mrst_rtc.rtc);
 		if (retval < 0) {
 			dev_dbg(dev, "IRQ %d is already in use, err %d\n",
 				rtc_irq, retval);
-			goto cleanup1;
+			goto cleanup0;
 		}
 	}
+
+	retval = rtc_register_device(mrst_rtc.rtc);
+	if (retval) {
+		retval = PTR_ERR(mrst_rtc.rtc);
+		goto cleanup0;
+	}
+
 	dev_dbg(dev, "initialised\n");
 	return 0;
 
-cleanup1:
-	rtc_device_unregister(mrst_rtc.rtc);
 cleanup0:
 	mrst_rtc.dev = NULL;
-	release_mem_region(iomem->start, resource_size(iomem));
 	dev_err(dev, "rtc-mrst: unable to initialise\n");
 	return retval;
 }
@@ -390,20 +391,10 @@ static void rtc_mrst_do_shutdown(void)
 static void rtc_mrst_do_remove(struct device *dev)
 {
 	struct mrst_rtc	*mrst = dev_get_drvdata(dev);
-	struct resource *iomem;
 
 	rtc_mrst_do_shutdown();
 
-	if (mrst->irq)
-		free_irq(mrst->irq, mrst->rtc);
-
-	rtc_device_unregister(mrst->rtc);
 	mrst->rtc = NULL;
-
-	iomem = mrst->iomem;
-	release_mem_region(iomem->start, resource_size(iomem));
-	mrst->iomem = NULL;
-
 	mrst->dev = NULL;
 }
 
-- 
2.17.1

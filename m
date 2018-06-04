Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeFDMIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:08:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47578 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFDMIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:08:01 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: mrst: switch to devm_rtc_allocate_device
Date: Mon,  4 Jun 2018 14:07:42 +0200
Message-Id: <20180604120742.6084-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_rtc_allocate_device/rtc_device_unregister to allow for
further improvements.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mrst.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index fcb9de5218b2..a3c528f7e833 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -341,12 +341,11 @@ static int vrtc_mrst_do_probe(struct device *dev, struct resource *iomem,
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
 
@@ -365,14 +364,21 @@ static int vrtc_mrst_do_probe(struct device *dev, struct resource *iomem,
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
+		goto cleanup1;
+	}
+
 	dev_dbg(dev, "initialised\n");
 	return 0;
 
 cleanup1:
-	rtc_device_unregister(mrst_rtc.rtc);
+	free_irq(rtc_irq, mrst->rtc);
 cleanup0:
 	mrst_rtc.dev = NULL;
 	release_mem_region(iomem->start, resource_size(iomem));
@@ -397,7 +403,6 @@ static void rtc_mrst_do_remove(struct device *dev)
 	if (mrst->irq)
 		free_irq(mrst->irq, mrst->rtc);
 
-	rtc_device_unregister(mrst->rtc);
 	mrst->rtc = NULL;
 
 	iomem = mrst->iomem;
-- 
2.17.1

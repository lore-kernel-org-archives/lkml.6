Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeESIrJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:47:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752140AbeESIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:47:05 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: mxc_v2: fix possible race condition
Date: Sat, 19 May 2018 10:46:46 +0200
Message-Id: <20180519084647.32313-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
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
 drivers/rtc/rtc-mxc_v2.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 9e14efb990b2..4cc121a41fe0 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -343,6 +343,12 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(pdata->rtc))
+		return PTR_ERR(pdata->rtc);
+
+	pdata->rtc->ops = &mxc_rtc_ops;
+
 	clk_disable(pdata->clk);
 	platform_set_drvdata(pdev, pdata);
 	ret =
@@ -354,15 +360,11 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pdata->rtc =
-	    devm_rtc_device_register(&pdev->dev, pdev->name, &mxc_rtc_ops,
-				     THIS_MODULE);
-	if (IS_ERR(pdata->rtc)) {
+	ret = rtc_register_device(pdata->rtc);
+	if (ret < 0)
 		clk_unprepare(pdata->clk);
-		return PTR_ERR(pdata->rtc);
-	}
 
-	return 0;
+	return ret;
 }
 
 static int mxc_rtc_remove(struct platform_device *pdev)
-- 
2.17.0

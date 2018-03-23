Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCWJRJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:17:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752065AbeCWJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:37 -0400
X-UUID: a5281715ca594469a7afcf657bbbf669-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 09/16] rtc: mediatek: convert to use device managed functions
Date: Fri, 23 Mar 2018 17:15:06 +0800
Message-ID: <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.488800-8.000000-10
X-TMASE-MatchedRID: Bo0EIJTmAYwbZUQXhYPYzBWCVBr+Ay98rrEvQogcy/HJYIv7y0tu9odn
        WXaFnj+FK6Y65q1qYVzEZ6BVQgY6ZsnUsvxvsR6SA9lly13c/gGy4iyjvVWToqfnINz0/CVc+1B
        ysa1PtqTojJgGHGYSus6fanhSwWkxBC/qhcduELrJ1E/nrJFED7qGBW9J0YqjZj0yUhVrMqujxY
        yRBa/qJcFwgTvxipFajoczmuoPCq3QevkfvkSaMU9lVlbTD5khMU9dzAbNCaFu7A0Qr9G+CeJ2p
        3yVhAuLQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.488800-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use device managed operation to simplify error handling, reduce source
code size, and reduce the likelyhood of bugs, and remove our removal
callback which contains anything already done by device managed functions.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index cefb83b..bfc5d6f 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -14,6 +14,7 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
@@ -328,10 +329,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	ret = request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
+	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -340,30 +341,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
-					   &mtk_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "mt6397-rtc",
+						&mtk_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		dev_err(&pdev->dev, "register rtc device failed\n");
 		ret = PTR_ERR(rtc->rtc_dev);
-		goto out_free_irq;
+		return ret;
 	}
 
 	return 0;
-
-out_free_irq:
-	free_irq(rtc->irq, rtc->rtc_dev);
-
-	return ret;
-}
-
-static int mtk_rtc_remove(struct platform_device *pdev)
-{
-	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(rtc->rtc_dev);
-	free_irq(rtc->irq, rtc->rtc_dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -405,7 +391,6 @@ static struct platform_driver mtk_rtc_driver = {
 		.pm = &mt6397_pm_ops,
 	},
 	.probe	= mtk_rtc_probe,
-	.remove = mtk_rtc_remove,
 };
 
 module_platform_driver(mtk_rtc_driver);
-- 
2.7.4

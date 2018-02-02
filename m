Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBBVq0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:46:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51016 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBBVqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:46:16 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] rtc: gemini/ftrtc010: disable clk on error paths in ftrtc010_rtc_probe()
Date: Sat,  3 Feb 2018 00:45:57 +0300
Message-Id: <1517607957-5664-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrtc010_rtc_probe() leaves clks enabled in case of errors.
The patch adds proper disabling code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/rtc/rtc-ftrtc010.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index af8d6beae20c..67a0aadf488c 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -147,33 +147,52 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(rtc->extclk);
 		if (ret) {
 			dev_err(dev, "failed to enable EXTCLK\n");
-			return ret;
+			goto err_pclk;
 		}
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_extclk;
+	}
 
 	rtc->rtc_irq = res->start;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (!res) {
+		ret = -ENODEV;
+		goto err_extclk;
+	}
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
-	if (!rtc->rtc_base)
-		return -ENOMEM;
+	if (!rtc->rtc_base) {
+		ret = -ENOMEM;
+		goto err_extclk;
+	}
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
-		return ret;
+		goto err_extclk;
 
 	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
 					   &ftrtc010_rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		goto err_extclk;
+	}
+
+	return 0;
+
+err_extclk:
+	if (!IS_ERR(rtc->extclk))
+		clk_disable_unprepare(rtc->extclk);
+err_pclk:
+	if (!IS_ERR(rtc->pclk))
+		clk_disable_unprepare(rtc->pclk);
+	return ret;
 }
 
 static int ftrtc010_rtc_remove(struct platform_device *pdev)
-- 
2.7.4

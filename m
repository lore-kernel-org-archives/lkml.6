Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDZC7n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:59:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36076 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeDZC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:59:41 -0400
X-Google-Smtp-Source: AB8JxZqf/uzN0qtkQARX3qczeUL+hqbRapTKBlkEhXZ/Pp0GPOwX5Rrn8pFud84fBcHOnl+LR2cpyA==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: sprd: Change to use devm_rtc_allocate_device()
Date: Thu, 26 Apr 2018 10:58:44 +0800
Message-Id: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch, changing to use devm_rtc_allocate_device()
that can allow driver to set 'range_max' and 'range_min' for the RTC
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 00d87d1..ac86322 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -600,6 +600,10 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 		return rtc->irq;
 	}
 
+	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
+
 	rtc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, rtc);
 
@@ -626,10 +630,12 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					    &sprd_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc))
-		return PTR_ERR(rtc->rtc);
+	rtc->rtc->ops = &sprd_rtc_ops;
+	ret = rtc_register_device(rtc->rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register rtc device\n");
+		return ret;
+	}
 
 	device_init_wakeup(&pdev->dev, 1);
 	return 0;
-- 
1.7.9.5

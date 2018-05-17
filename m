Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQUxc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:53:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39490 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeEQUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:53:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: ls1x: switch to rtc_register_device
Date: Thu, 17 May 2018 22:53:25 +0200
Message-Id: <20180517205327.29150-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ls1x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index de86f9fabc11..609bd1d013f0 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -173,15 +173,15 @@ static int ls1x_rtc_probe(struct platform_device *pdev)
 	while (readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_TTS)
 		usleep_range(1000, 3000);
 
-	rtcdev = devm_rtc_device_register(&pdev->dev, "ls1x-rtc",
-					&ls1x_rtc_ops , THIS_MODULE);
-	if (IS_ERR(rtcdev)) {
-		ret = PTR_ERR(rtcdev);
-		goto err;
-	}
+	rtcdev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtcdev))
+		return PTR_ERR(rtcdev);
 
 	platform_set_drvdata(pdev, rtcdev);
-	return 0;
+	rtcdev->ops = &ls1x_rtc_ops;
+
+	return rtc_register_device(rtcdev);
+
 err:
 	return ret;
 }
-- 
2.17.0

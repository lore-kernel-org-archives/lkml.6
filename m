Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeEQUxe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:53:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39493 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeEQUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:53:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: ls1x: remove useless label and goto
Date: Thu, 17 May 2018 22:53:26 +0200
Message-Id: <20180517205327.29150-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517205327.29150-1-alexandre.belloni@bootlin.com>
References: <20180517205327.29150-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling in ls1x_rtc_probe used to release resources but since
it is using devm functions, it only returns a value. Make the code clearer
by returning directly instead of using goto.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ls1x.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 609bd1d013f0..8aa3f223621c 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -148,15 +148,13 @@ static int ls1x_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev;
 	unsigned long v;
-	int ret;
 
 	v = readl(SYS_COUNTER_CNTRL);
 	if (!(v & RTC_CNTR_OK)) {
 		dev_err(&pdev->dev, "rtc counters not working\n");
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
-	ret = -ETIMEDOUT;
+
 	/* set to 1 HZ if needed */
 	if (readl(SYS_TOYTRIM) != 32767) {
 		v = 0x100000;
@@ -165,7 +163,7 @@ static int ls1x_rtc_probe(struct platform_device *pdev)
 
 		if (!v) {
 			dev_err(&pdev->dev, "time out\n");
-			goto err;
+			return -ETIMEDOUT;
 		}
 		writel(32767, SYS_TOYTRIM);
 	}
@@ -181,9 +179,6 @@ static int ls1x_rtc_probe(struct platform_device *pdev)
 	rtcdev->ops = &ls1x_rtc_ops;
 
 	return rtc_register_device(rtcdev);
-
-err:
-	return ret;
 }
 
 static struct platform_driver  ls1x_rtc_driver = {
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeESIrK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:47:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41266 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752193AbeESIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:47:05 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: mxc_v2: let the core handle rtc range
Date: Sat, 19 May 2018 10:46:47 +0200
Message-Id: <20180519084647.32313-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519084647.32313-1-alexandre.belloni@bootlin.com>
References: <20180519084647.32313-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RTC is a 32-bit second counter.

This also solves an issue where mxc_rtc_set_alarm() can return with the
lock taken.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mxc_v2.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
index 4cc121a41fe0..24ca74ca632a 100644
--- a/drivers/rtc/rtc-mxc_v2.c
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -165,11 +165,6 @@ static int mxc_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	time64_t time = rtc_tm_to_time64(tm);
 	int ret;
 
-	if (time > U32_MAX) {
-		dev_err(dev, "RTC exceeded by %llus\n", time - U32_MAX);
-		return -EINVAL;
-	}
-
 	ret = mxc_rtc_lock(pdata);
 	if (ret)
 		return ret;
@@ -248,11 +243,6 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	if (time > U32_MAX) {
-		dev_err(dev, "Hopefully I am out of service by then :-(\n");
-		return -EINVAL;
-	}
-
 	writel((u32)time, pdata->ioaddr + SRTC_LPSAR);
 
 	/* clear alarm interrupt status bit */
@@ -348,6 +338,7 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->rtc);
 
 	pdata->rtc->ops = &mxc_rtc_ops;
+	pdata->rtc->range_max = U32_MAX;
 
 	clk_disable(pdata->clk);
 	platform_set_drvdata(pdev, pdata);
-- 
2.17.0

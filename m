Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeEaJTG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:19:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45894 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeEaJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:19:03 -0400
X-Google-Smtp-Source: ADUXVKKlnuZTBeqntIT85yP7VYZq0EFiQ8N/bpAjoQbXsyperwPoVZqlDwLdgOrSXtxJA+lqM+uW+Q==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH] rtc: sprd: Add new RTC power down check method
Date: Thu, 31 May 2018 17:18:08 +0800
Message-Id: <ea3bed8a6cb9493a7b0162f144de8a5ee4f06777.1527757194.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the new method to check if RTC was powered down, which
is more solid. Since we have introduced power control and power status
registers, and we just check if the power status is the default value
(0x96), if yes that means the RTC has been powered down. Meanwhile We
can set the power control register to be one valid value to change
the power status to indicate RTC device is valid now.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |   47 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 6a3876e..deea5c3 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -35,6 +35,8 @@
 #define SPRD_RTC_DAY_ALM_VALUE		0x4c
 #define SPRD_RTC_SPG_VALUE		0x50
 #define SPRD_RTC_SPG_UPD		0x54
+#define SPRD_RTC_PWR_CTRL		0x58
+#define SPRD_RTC_PWR_STS		0x5c
 #define SPRD_RTC_SEC_AUXALM_UPD		0x60
 #define SPRD_RTC_MIN_AUXALM_UPD		0x64
 #define SPRD_RTC_HOUR_AUXALM_UPD	0x68
@@ -86,7 +88,13 @@
 
 /* SPG values definition for SPRD_RTC_SPG_UPD register */
 #define SPRD_RTC_POWEROFF_ALM_FLAG	BIT(8)
-#define SPRD_RTC_POWER_RESET_FLAG	BIT(9)
+
+/* power control/status definition */
+#define SPRD_RTC_POWER_RESET_VALUE	0x96
+#define SPRD_RTC_POWER_STS_CLEAR	GENMASK(7, 0)
+#define SPRD_RTC_POWER_STS_SHIFT	8
+#define SPRD_RTC_POWER_STS_VALID	\
+	(~SPRD_RTC_POWER_RESET_VALUE << SPRD_RTC_POWER_STS_SHIFT)
 
 /* timeout of synchronizing time and alarm registers (us) */
 #define SPRD_RTC_POLL_TIMEOUT		200000
@@ -383,7 +391,6 @@ static int sprd_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct sprd_rtc *rtc = dev_get_drvdata(dev);
 	time64_t secs = rtc_tm_to_time64(tm);
-	u32 val;
 	int ret;
 
 	ret = sprd_rtc_set_secs(rtc, SPRD_RTC_TIME, secs);
@@ -391,27 +398,20 @@ static int sprd_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return ret;
 
 	if (!rtc->valid) {
-		/*
-		 * Set SPRD_RTC_POWER_RESET_FLAG to indicate now RTC has valid
-		 * time values.
-		 */
-		ret = regmap_update_bits(rtc->regmap,
-					 rtc->base + SPRD_RTC_SPG_UPD,
-					 SPRD_RTC_POWER_RESET_FLAG,
-					 SPRD_RTC_POWER_RESET_FLAG);
+		/* Clear RTC power status firstly */
+		ret = regmap_write(rtc->regmap, rtc->base + SPRD_RTC_PWR_CTRL,
+				   SPRD_RTC_POWER_STS_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_read_poll_timeout(rtc->regmap,
-					       rtc->base + SPRD_RTC_INT_RAW_STS,
-					       val, (val & SPRD_RTC_SPG_UPD_EN),
-					       SPRD_RTC_POLL_DELAY_US,
-					       SPRD_RTC_POLL_TIMEOUT);
-		if (ret) {
-			dev_err(rtc->dev, "failed to update SPG value:%d\n",
-				ret);
+		/*
+		 * Set RTC power status to indicate now RTC has valid time
+		 * values.
+		 */
+		ret = regmap_write(rtc->regmap, rtc->base + SPRD_RTC_PWR_CTRL,
+				   SPRD_RTC_POWER_STS_VALID);
+		if (ret)
 			return ret;
-		}
 
 		rtc->valid = true;
 	}
@@ -562,15 +562,16 @@ static int sprd_rtc_check_power_down(struct sprd_rtc *rtc)
 	u32 val;
 	int ret;
 
-	ret = regmap_read(rtc->regmap, rtc->base + SPRD_RTC_SPG_VALUE, &val);
+	ret = regmap_read(rtc->regmap, rtc->base + SPRD_RTC_PWR_STS, &val);
 	if (ret)
 		return ret;
 
 	/*
-	 * If the SPRD_RTC_POWER_RESET_FLAG was not set, which means the RTC has
-	 * been powered down, so the RTC time values are invalid.
+	 * If the RTC power status value is SPRD_RTC_POWER_RESET_VALUE, which
+	 * means the RTC has been powered down, so the RTC time values are
+	 * invalid.
 	 */
-	rtc->valid = (val & SPRD_RTC_POWER_RESET_FLAG) ? true : false;
+	rtc->valid = val == SPRD_RTC_POWER_RESET_VALUE ? false : true;
 	return 0;
 }
 
-- 
1.7.9.5

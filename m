Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeBUVXl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:23:41 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46897 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbeBUU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 003/100] rtc: cmos: let the core handle invalid time
Date: Wed, 21 Feb 2018 21:54:58 +0100
Message-Id: <20180221205635.31314-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the rtc to a valid time when the time is invalid is a bad practice,
because then userspace doesn't know it shouldn't trust the RTC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-cmos.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b8ec6009171a..d98ad4874d8b 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1262,8 +1262,6 @@ MODULE_DEVICE_TABLE(of, of_cmos_match);
 static __init void cmos_of_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct rtc_time time;
-	int ret;
 	const __be32 *val;
 
 	if (!node)
@@ -1276,16 +1274,6 @@ static __init void cmos_of_init(struct platform_device *pdev)
 	val = of_get_property(node, "freq-reg", NULL);
 	if (val)
 		CMOS_WRITE(be32_to_cpup(val), RTC_FREQ_SELECT);
-
-	cmos_read_time(&pdev->dev, &time);
-	ret = rtc_valid_tm(&time);
-	if (ret) {
-		struct rtc_time def_time = {
-			.tm_year = 1,
-			.tm_mday = 1,
-		};
-		cmos_set_time(&pdev->dev, &def_time);
-	}
 }
 #else
 static inline void cmos_of_init(struct platform_device *pdev) {}
-- 
2.16.1

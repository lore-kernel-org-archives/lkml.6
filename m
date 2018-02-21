Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeBUVFU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:05:20 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47078 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 081/100] rtc: omap: stop validating rtc_time in .set_time and .set_alarm
Date: Wed, 21 Feb 2018 21:56:16 +0100
Message-Id: <20180221205635.31314-82-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always validating the rtc_time struct before calling
.set_time or .set_alarm. It is not necessary to do it again.
Also, rtc_time_to_tm never generates an invalid rtc_tm (it can be out of
range though).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index e53cb27f4118..39086398833e 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -273,9 +273,6 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 /* this hardware doesn't support "don't care" alarm fields */
 static int tm2bcd(struct rtc_time *tm)
 {
-	if (rtc_valid_tm(tm) != 0)
-		return -EINVAL;
-
 	tm->tm_sec = bin2bcd(tm->tm_sec);
 	tm->tm_min = bin2bcd(tm->tm_min);
 	tm->tm_hour = bin2bcd(tm->tm_hour);
-- 
2.16.1

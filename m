Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeBYISY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 03:18:24 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:55692 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 03:18:22 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <28c82eebf04a5b4a371e3ab24c2dcbee>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: zyw@rock-chips.com, briannorris@google.com, dianders@google.com,
        jwerner@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH] rtc: cros-ec: return -ETIME when refused to set alarms in the past
Date: Sun, 25 Feb 2018 16:18:02 +0800
Message-Id: <20180225081802.8965-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a check in __rtc_set_alarm() to return -ETIME when the alarm
is in the past.

Since accessing a Chrome OS EC based rtc is a slow operation, we should
do that check again inside of the EC rtc driver's .set_alarm() callback.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/rtc/rtc-cros-ec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index f0ea6899c731..ee0062e2d222 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -188,6 +188,10 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (alarm_time < 0 || alarm_time > U32_MAX)
 		return -EINVAL;
 
+	/* Don't set an alarm in the past. */
+	if ((u32)alarm_time <= current_time)
+		return -ETIME;
+
 	if (!alrm->enabled) {
 		/*
 		 * If the alarm is being disabled, send an alarm
@@ -196,11 +200,7 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		alarm_offset = EC_RTC_ALARM_CLEAR;
 		cros_ec_rtc->saved_alarm = (u32)alarm_time;
 	} else {
-		/* Don't set an alarm in the past. */
-		if ((u32)alarm_time < current_time)
-			alarm_offset = EC_RTC_ALARM_CLEAR;
-		else
-			alarm_offset = (u32)alarm_time - current_time;
+		alarm_offset = (u32)alarm_time - current_time;
 	}
 
 	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
-- 
2.11.0

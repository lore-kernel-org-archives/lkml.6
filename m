Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeB0CuR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:50:17 -0500
Received: from regular1.263xmail.com ([211.150.99.132]:33926 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0CuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:50:16 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <5d8b5fb0ab401602e5c8e847dbac03a4>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: zyw@rock-chips.com, briannorris@google.com, dianders@google.com,
        jwerner@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [RESEND PATCH v3] rtc: cros-ec: return -ETIME when refused to set alarms in the past
Date: Tue, 27 Feb 2018 10:50:03 +0800
Message-Id: <20180227025003.8823-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since accessing a Chrome OS EC based rtc is a slow operation, there is a
race window where if the alarm is set for the next second and the second
ticks over right before calculating the alarm offset.

In this case the current driver is setting a 0-second alarm, which would
be considered as disabling alarms by the EC(EC_RTC_ALARM_CLEAR).

This breaks, e.g., hwclock which relies on RTC_UIE_ON ->
rtc_update_irq_enable(), which sets a 1-second alarm and expects it to
fire an interrupt.

So return -ETIME when the alarm is in the past, follow __rtc_set_alarm().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3:
Fix alarm time comparing.

Changes in v2:
Rewrite commit message as Brian suggested.
Check alarm time only when that alarm is enabled.

 drivers/rtc/rtc-cros-ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index f0ea6899c731..bf7ced095c94 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -197,10 +197,10 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		cros_ec_rtc->saved_alarm = (u32)alarm_time;
 	} else {
 		/* Don't set an alarm in the past. */
-		if ((u32)alarm_time < current_time)
-			alarm_offset = EC_RTC_ALARM_CLEAR;
-		else
-			alarm_offset = (u32)alarm_time - current_time;
+		if ((u32)alarm_time <= current_time)
+			return -ETIME;
+
+		alarm_offset = (u32)alarm_time - current_time;
 	}
 
 	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
-- 
2.11.0

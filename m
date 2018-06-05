Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeFEVSW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:18:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58382 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbeFEVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:17:54 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: ensure rtc_set_alarm fails when alarms are not supported
Date: Tue,  5 Jun 2018 23:09:14 +0200
Message-Id: <20180605210914.8054-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605210914.8054-1-alexandre.belloni@bootlin.com>
References: <20180605210914.8054-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using RTC_ALM_SET or RTC_WKALM_SET with rtc_wkalrm.enabled not set,
rtc_timer_enqueue() is not called and rtc_set_alarm() may succeed but the
subsequent RTC_AIE_ON ioctl will fail. RTC_ALM_READ would also fail in that
case.

Ensure rtc_set_alarm() fails when alarms are not supported to avoid letting
programs think the alarms are working for a particular RTC when they are
not.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index ffcfe6319466..7cae46c6b9bf 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -442,6 +442,11 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 {
 	int err;
 
+	if (!rtc->ops)
+		return -ENODEV;
+	else if (!rtc->ops->set_alarm)
+		return -EINVAL;
+
 	err = rtc_valid_tm(&alarm->time);
 	if (err != 0)
 		return err;
-- 
2.17.1

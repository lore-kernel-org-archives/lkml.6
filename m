Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeBVBQ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:16:29 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:55489 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751413AbeBVBQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:16:28 -0500
From: Justin Chen <justin.chen@broadcom.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Justin Chen <justin.chen@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] rtc: brcmstb-waketimer: Set wktmr prescaler
Date: Wed, 21 Feb 2018 17:15:55 -0800
Message-Id: <1519262155-15580-1-git-send-email-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW default is one tick per second, however instead of assuming this,
lets make sure the waketimer is actually one tick per second before
arming the alarm.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 796ac79..46116b7 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -60,6 +60,10 @@ static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
 {
 	brcmstb_waketmr_clear_alarm(timer);
 
+	/* Make sure we are actually counting in seconds */
+	writel_relaxed(BRCMSTB_WKTMR_DEFAULT_FREQ,
+			timer->base + BRCMSTB_WKTMR_PRESCALER);
+
 	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
 }
 
-- 
2.7.4

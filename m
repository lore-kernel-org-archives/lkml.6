Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeBZULR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:11:17 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41248 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750814AbeBZULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:11:16 -0500
From: Justin Chen <justin.chen@broadcom.com>
To: linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Justin Chen <justin.chen@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2] rtc: brcmstb-waketimer: Set wktmr prescaler
Date: Mon, 26 Feb 2018 12:09:58 -0800
Message-Id: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW default is one tick per second, however instead of assuming this,
lets make sure the waketimer is actually one tick per second before
arming the alarm.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 796ac79..231b2f7 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -60,6 +60,9 @@ static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
 {
 	brcmstb_waketmr_clear_alarm(timer);
 
+	/* Make sure we are actually counting in seconds */
+	writel_relaxed(timer->rate, timer->base + BRCMSTB_WKTMR_PRESCALER);
+
 	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
 }
 
-- 
2.7.4

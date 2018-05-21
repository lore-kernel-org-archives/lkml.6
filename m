Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeEUQmk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:42:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44528 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbeEUQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:42:37 -0400
X-Google-Smtp-Source: AB8JxZrp5gm1juOBEdM5yhnghkTWWIdlPhSCPyOzdfnyO2bKWtGOkpxRrUe3f9+lnwu/ek9e3N/2fg==
From: Brian Norris <briannorris@chromium.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] rtc: report time-retrieval errors when updating alarm
Date: Mon, 21 May 2018 09:42:22 -0700
Message-Id: <20180521164222.149896-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__rtc_read_time() can fail (e.g., if the RTC uses an unreliable medium).
When it does, we don't report the error, but instead calculate a
1-second alarm based on the potentially-garbage 'tm' (in practice,
__rtc_read_time() zeroes out the time first, so it's likely to still be
all 0).

Let's propagate the error instead.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/rtc/interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7cbdc9228dd5..a4bdd8b5fe2e 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -555,7 +555,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		struct rtc_time tm;
 		ktime_t now, onesec;
 
-		__rtc_read_time(rtc, &tm);
+		err = __rtc_read_time(rtc, &tm);
+		if (err)
+			goto out;
 		onesec = ktime_set(1, 0);
 		now = rtc_tm_to_ktime(tm);
 		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
-- 
2.17.0.441.gb46fe60e1d-goog

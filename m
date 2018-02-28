Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935184AbeB1Vu5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:50:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52971 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935042AbeB1Vu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:50:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: fix rtc_time64_to_tm for 3477
Date: Wed, 28 Feb 2018 22:50:53 +0100
Message-Id: <20180228215053.17498-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current correction for leap years will fail in 3477. 3476-12-31 being
3477-01-00 because this is 366 leap years after 1970 and 3477 isn't a leap
year.

Fix that by looping over until days is positive or zero.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
index ad5bb21908e5..4a3c0f3aab14 100644
--- a/drivers/rtc/rtc-lib.c
+++ b/drivers/rtc/rtc-lib.c
@@ -65,7 +65,7 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 	days -= (year - 1970) * 365
 		+ LEAPS_THRU_END_OF(year - 1)
 		- LEAPS_THRU_END_OF(1970 - 1);
-	if (days < 0) {
+	while (days < 0) {
 		year -= 1;
 		days += 365 + is_leap_year(year);
 	}
-- 
2.16.2

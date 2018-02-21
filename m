Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBUU5N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:57:13 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46903 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBUU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:04 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 005/100] rtc: stk17ta8: let the core handle invalid time
Date: Wed, 21 Feb 2018 21:55:00 +0100
Message-Id: <20180221205635.31314-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning a valid time when the time is invalid is a bad practice, because
then userspace is not able to react on the information. Also, it doesn't
make sense to return epoch because it is already the default time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-stk17ta8.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index b670e44306a8..c66ec6ae233c 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -129,10 +129,6 @@ static int stk17ta8_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* year is 1900 + tm->tm_year */
 	tm->tm_year = bcd2bin(year) + bcd2bin(century) * 100 - 1900;
 
-	if (rtc_valid_tm(tm) < 0) {
-		dev_err(dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, tm);
-	}
 	return 0;
 }
 
-- 
2.16.1

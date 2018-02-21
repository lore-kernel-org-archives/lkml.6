Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBUVXk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:23:40 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46899 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBUU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 004/100] rtc: rs5c348: let the core handle invalid time
Date: Wed, 21 Feb 2018 21:54:59 +0100
Message-Id: <20180221205635.31314-5-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rs5c348.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 9a306983aaba..f2de8b17e7e3 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -135,11 +135,6 @@ rs5c348_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_year = bcd2bin(rxbuf[RS5C348_REG_YEAR]) +
 		((rxbuf[RS5C348_REG_MONTH] & RS5C348_BIT_Y2K) ? 100 : 0);
 
-	if (rtc_valid_tm(tm) < 0) {
-		dev_err(&spi->dev, "retrieved date/time is not valid.\n");
-		rtc_time_to_tm(0, tm);
-	}
-
 	return 0;
 }
 
-- 
2.16.1

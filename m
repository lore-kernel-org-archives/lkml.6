Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeEQUeX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:34:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39019 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbeEQUdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:47 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/7] rtc: rx8581: error out when time invalid
Date: Thu, 17 May 2018 22:33:30 +0200
Message-Id: <20180517203331.24504-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error when the date is unreliable because the battery is low.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 0a70f1ac5cc2..53644bb271af 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -109,6 +109,12 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return -EIO;
 	}
 
+	if (data & RX8581_FLAG_VLF) {
+		dev_warn(dev,
+			"low voltage detected, date/time is not reliable.\n");
+		return -EINVAL;
+	}
+
 	do {
 		/* If update flag set, clear it */
 		if (data & RX8581_FLAG_UF) {
@@ -136,10 +142,6 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		}
 	} while (data & RX8581_FLAG_UF);
 
-	if (data & RX8581_FLAG_VLF)
-		dev_info(dev,
-			"low voltage detected, date/time is not reliable.\n");
-
 	dev_dbg(dev, "%s: raw data is sec=%02x, min=%02x, hr=%02x, "
 		"wday=%02x, mday=%02x, mon=%02x, year=%02x\n",
 		__func__,
-- 
2.17.0

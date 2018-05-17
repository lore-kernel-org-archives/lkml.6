Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEQUdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:33:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39012 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQUdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:44 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/7] rtc: rx8581: switch to rtc_register_device
Date: Thu, 17 May 2018 22:33:25 +0200
Message-Id: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 32caadf912ca..c64911a08531 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -286,16 +286,13 @@ static int rx8581_probe(struct i2c_client *client,
 		rx8581->write_block_data = rx8581_write_block_data;
 	}
 
-	rx8581->rtc = devm_rtc_device_register(&client->dev,
-		rx8581_driver.driver.name, &rx8581_rtc_ops, THIS_MODULE);
-
-	if (IS_ERR(rx8581->rtc)) {
-		dev_err(&client->dev,
-			"unable to register the class device\n");
+	rx8581->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rx8581->rtc))
 		return PTR_ERR(rx8581->rtc);
-	}
 
-	return 0;
+	rx8581->rtc->ops = &rx8581_rtc_ops;
+
+	return rtc_register_device(rx8581->rtc);
 }
 
 static const struct i2c_device_id rx8581_id[] = {
-- 
2.17.0

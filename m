Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeEQUeX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:34:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39017 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQUdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:47 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/7] rtc: rx8581: remove useless indirection
Date: Thu, 17 May 2018 22:33:28 +0200
Message-Id: <20180517203331.24504-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx8581_get_datetime and rx8581_set_datetime are only used after casting dev
to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 171ee241bd2f..a91fbb86a110 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -93,8 +93,9 @@ static int rx8581_write_block_data(const struct i2c_client *client, u8 command,
  * In the routines that deal directly with the rx8581 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
  */
-static int rx8581_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char date[7];
 	int data, err;
 	struct rx8581 *rx8581 = i2c_get_clientdata(client);
@@ -164,8 +165,9 @@ static int rx8581_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int rx8581_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int data, err;
 	unsigned char buf[7];
 	struct rx8581 *rx8581 = i2c_get_clientdata(client);
@@ -242,16 +244,6 @@ static int rx8581_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return rx8581_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return rx8581_set_datetime(to_i2c_client(dev), tm);
-}
-
 static const struct rtc_class_ops rx8581_rtc_ops = {
 	.read_time	= rx8581_rtc_read_time,
 	.set_time	= rx8581_rtc_set_time,
-- 
2.17.0

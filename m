Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBUVF0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:05:26 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47061 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeBUU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:53 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 077/100] rtc: isl12022: remove useless indirection
Date: Wed, 21 Feb 2018 21:56:12 +0100
Message-Id: <20180221205635.31314-78-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isl12022_get_datetime and isl12022_set_datetime are only used after casting
dev to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-isl12022.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 46093cd13d5e..fa5c15d45070 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -104,8 +104,9 @@ static int isl12022_write_reg(struct i2c_client *client,
  * In the routines that deal directly with the isl12022 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
  */
-static int isl12022_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	uint8_t buf[ISL12022_REG_INT + 1];
 	int ret;
 
@@ -152,8 +153,9 @@ static int isl12022_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int isl12022_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct isl12022 *isl12022 = i2c_get_clientdata(client);
 	size_t i;
 	int ret;
@@ -228,16 +230,6 @@ static int isl12022_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return isl12022_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return isl12022_set_datetime(to_i2c_client(dev), tm);
-}
-
 static const struct rtc_class_ops isl12022_rtc_ops = {
 	.read_time	= isl12022_rtc_read_time,
 	.set_time	= isl12022_rtc_set_time,
-- 
2.16.1

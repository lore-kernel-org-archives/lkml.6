Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeBUU6U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:20 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47094 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeBUU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:05 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 100/100] rtc: pcf85063: remove useless indirection
Date: Wed, 21 Feb 2018 21:56:35 +0100
Message-Id: <20180221205635.31314-101-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcf85063_get_datetime and pcf85063_set_datetime are only used after casting
dev to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 6ad4511d7ee1..3558433e8787 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -81,8 +81,9 @@ static int pcf85063_start_clock(struct i2c_client *client, u8 ctrl1)
 	return 0;
 }
 
-static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int pcf85063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int rc;
 	u8 regs[7];
 
@@ -117,8 +118,9 @@ static int pcf85063_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int pcf85063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int rc;
 	u8 regs[7];
 	u8 ctrl1;
@@ -172,16 +174,6 @@ static int pcf85063_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int pcf85063_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return pcf85063_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int pcf85063_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return pcf85063_set_datetime(to_i2c_client(dev), tm);
-}
-
 static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.read_time	= pcf85063_rtc_read_time,
 	.set_time	= pcf85063_rtc_set_time
-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBUU6T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:19 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47095 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeBUU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:05 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 098/100] rtc: max6900: remove useless indirection
Date: Wed, 21 Feb 2018 21:56:33 +0100
Message-Id: <20180221205635.31314-99-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max6900_i2c_read_time and max6900_i2c_set_time are only used after casting
dev to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-max6900.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index 84f06106f5ba..ab60f13fa3ef 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -139,8 +139,9 @@ static int max6900_i2c_write_regs(struct i2c_client *client, u8 const *buf)
 	return -EIO;
 }
 
-static int max6900_i2c_read_time(struct i2c_client *client, struct rtc_time *tm)
+static int max6900_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	int rc;
 	u8 regs[MAX6900_REG_LEN];
 
@@ -165,9 +166,9 @@ static int max6900_i2c_clear_write_protect(struct i2c_client *client)
 	return i2c_smbus_write_byte_data(client, MAX6900_REG_CONTROL_WRITE, 0);
 }
 
-static int
-max6900_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
+static int max6900_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	u8 regs[MAX6900_REG_LEN];
 	int rc;
 
@@ -193,16 +194,6 @@ max6900_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 	return 0;
 }
 
-static int max6900_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return max6900_i2c_read_time(to_i2c_client(dev), tm);
-}
-
-static int max6900_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return max6900_i2c_set_time(to_i2c_client(dev), tm);
-}
-
 static const struct rtc_class_ops max6900_rtc_ops = {
 	.read_time = max6900_rtc_read_time,
 	.set_time = max6900_rtc_set_time,
-- 
2.16.1

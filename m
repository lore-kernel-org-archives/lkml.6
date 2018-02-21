Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeBUU64 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:58:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47092 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeBUU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:58:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 096/100] rtc: rs5c372: remove useless indirection
Date: Wed, 21 Feb 2018 21:56:31 +0100
Message-Id: <20180221205635.31314-97-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rs5c372_get_datetime and rs5c372_set_datetime are only used after casting
dev to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rs5c372.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index ae7fa4324b0a..c5038329058c 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -207,8 +207,9 @@ static unsigned rs5c_hr2reg(struct rs5c372 *rs5c, unsigned hour)
 	return bin2bcd(hour);
 }
 
-static int rs5c372_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	int		status = rs5c_get_regs(rs5c);
 
@@ -237,8 +238,9 @@ static int rs5c372_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int rs5c372_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct rs5c372	*rs5c = i2c_get_clientdata(client);
 	unsigned char	buf[7];
 	int		addr;
@@ -304,17 +306,6 @@ static int rs5c372_get_trim(struct i2c_client *client, int *osc, int *trim)
 }
 #endif
 
-static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return rs5c372_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int rs5c372_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return rs5c372_set_datetime(to_i2c_client(dev), tm);
-}
-
-
 static int rs5c_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
-- 
2.16.1

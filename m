Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBYWPH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 17:15:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbeBYWPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 17:15:04 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: m41t80: remove useless indirection
Date: Sun, 25 Feb 2018 23:15:00 +0100
Message-Id: <20180225221500.28242-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m41t80_get_datetime and m41t80_set_datetime are only used after casting dev
to an i2c_client. Remove that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m41t80.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index f77320948fc4..ad03e2f12f5d 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -198,9 +198,9 @@ static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int m41t80_get_datetime(struct i2c_client *client,
-			       struct rtc_time *tm)
+static int m41t80_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -232,9 +232,9 @@ static int m41t80_get_datetime(struct i2c_client *client,
 	return 0;
 }
 
-/* Sets the given date and time to the real time clock. */
-static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int m41t80_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct m41t80_data *clientdata = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
@@ -297,16 +297,6 @@ static int m41t80_rtc_proc(struct device *dev, struct seq_file *seq)
 	return 0;
 }
 
-static int m41t80_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return m41t80_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int m41t80_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return m41t80_set_datetime(to_i2c_client(dev), tm);
-}
-
 static int m41t80_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -947,7 +937,7 @@ static int m41t80_probe(struct i2c_client *client,
 
 	if (rc >= 0 && rc & M41T80_ALHOUR_HT) {
 		if (m41t80_data->features & M41T80_FEATURE_HT) {
-			m41t80_get_datetime(client, &tm);
+			m41t80_rtc_read_time(&client->dev, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
 			dev_info(&client->dev,
 				 "Power Down at %04i-%02i-%02i %02i:%02i:%02i\n",
-- 
2.16.2

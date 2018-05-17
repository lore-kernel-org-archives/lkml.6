Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeEQUd6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:33:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39018 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeEQUds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:48 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/7] rtc: rx8581: remove useless declaration
Date: Thu, 17 May 2018 22:33:29 +0200
Message-Id: <20180517203331.24504-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx8581_driver forward declaration is useless, remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index a91fbb86a110..0a70f1ac5cc2 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -59,8 +59,6 @@ struct rx8581 {
 				u8 length, const u8 *values);
 };
 
-static struct i2c_driver rx8581_driver;
-
 static int rx8581_read_block_data(const struct i2c_client *client, u8 command,
 					u8 length, u8 *values)
 {
@@ -107,7 +105,7 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	 */
 	data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
 	if (data < 0) {
-		dev_err(&client->dev, "Unable to read device flags\n");
+		dev_err(dev, "Unable to read device flags\n");
 		return -EIO;
 	}
 
@@ -117,7 +115,7 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			err = i2c_smbus_write_byte_data(client,
 				RX8581_REG_FLAG, (data & ~RX8581_FLAG_UF));
 			if (err != 0) {
-				dev_err(&client->dev, "Unable to write device flags\n");
+				dev_err(dev, "Unable to write device flags\n");
 				return -EIO;
 			}
 		}
@@ -126,24 +124,23 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		err = rx8581->read_block_data(client, RX8581_REG_SC,
 			7, date);
 		if (err < 0) {
-			dev_err(&client->dev, "Unable to read date\n");
+			dev_err(dev, "Unable to read date\n");
 			return -EIO;
 		}
 
 		/* Check flag register */
 		data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
 		if (data < 0) {
-			dev_err(&client->dev, "Unable to read device flags\n");
+			dev_err(dev, "Unable to read device flags\n");
 			return -EIO;
 		}
 	} while (data & RX8581_FLAG_UF);
 
 	if (data & RX8581_FLAG_VLF)
-		dev_info(&client->dev,
+		dev_info(dev,
 			"low voltage detected, date/time is not reliable.\n");
 
-	dev_dbg(&client->dev,
-		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
+	dev_dbg(dev, "%s: raw data is sec=%02x, min=%02x, hr=%02x, "
 		"wday=%02x, mday=%02x, mon=%02x, year=%02x\n",
 		__func__,
 		date[0], date[1], date[2], date[3], date[4], date[5], date[6]);
@@ -156,7 +153,7 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon = bcd2bin(date[RX8581_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
 	tm->tm_year = bcd2bin(date[RX8581_REG_YR]) + 100;
 
-	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -172,7 +169,7 @@ static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	unsigned char buf[7];
 	struct rx8581 *rx8581 = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
 		__func__,
 		tm->tm_sec, tm->tm_min, tm->tm_hour,
@@ -195,49 +192,49 @@ static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	/* Stop the clock */
 	data = i2c_smbus_read_byte_data(client, RX8581_REG_CTRL);
 	if (data < 0) {
-		dev_err(&client->dev, "Unable to read control register\n");
+		dev_err(dev, "Unable to read control register\n");
 		return -EIO;
 	}
 
 	err = i2c_smbus_write_byte_data(client, RX8581_REG_CTRL,
 		(data | RX8581_CTRL_STOP));
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write control register\n");
+		dev_err(dev, "Unable to write control register\n");
 		return -EIO;
 	}
 
 	/* write register's data */
 	err = rx8581->write_block_data(client, RX8581_REG_SC, 7, buf);
 	if (err < 0) {
-		dev_err(&client->dev, "Unable to write to date registers\n");
+		dev_err(dev, "Unable to write to date registers\n");
 		return -EIO;
 	}
 
 	/* get VLF and clear it */
 	data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
 	if (data < 0) {
-		dev_err(&client->dev, "Unable to read flag register\n");
+		dev_err(dev, "Unable to read flag register\n");
 		return -EIO;
 	}
 
 	err = i2c_smbus_write_byte_data(client, RX8581_REG_FLAG,
 		(data & ~(RX8581_FLAG_VLF)));
 	if (err != 0) {
-		dev_err(&client->dev, "Unable to write flag register\n");
+		dev_err(dev, "Unable to write flag register\n");
 		return -EIO;
 	}
 
 	/* Restart the clock */
 	data = i2c_smbus_read_byte_data(client, RX8581_REG_CTRL);
 	if (data < 0) {
-		dev_err(&client->dev, "Unable to read control register\n");
+		dev_err(dev, "Unable to read control register\n");
 		return -EIO;
 	}
 
 	err = i2c_smbus_write_byte_data(client, RX8581_REG_CTRL,
 		(data & ~(RX8581_CTRL_STOP)));
 	if (err != 0) {
-		dev_err(&client->dev, "Unable to write control register\n");
+		dev_err(dev, "Unable to write control register\n");
 		return -EIO;
 	}
 
-- 
2.17.0

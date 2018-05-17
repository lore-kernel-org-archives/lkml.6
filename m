Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeEQUd5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:33:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39020 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbeEQUds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:48 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 7/7] rtc: rx8581: switch to regmap
Date: Thu, 17 May 2018 22:33:31 +0200
Message-Id: <20180517203331.24504-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to regmap to simplify handling block read/write.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 155 +++++++++++----------------------------
 1 file changed, 42 insertions(+), 113 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 53644bb271af..0e0546e5c541 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/bcd.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/log2.h>
 
@@ -51,42 +52,10 @@
 #define RX8581_CTRL_RESET	0x01 /* RESET bit */
 
 struct rx8581 {
-	struct i2c_client	*client;
+	struct regmap		*regmap;
 	struct rtc_device	*rtc;
-	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
-				u8 length, u8 *values);
-	s32 (*write_block_data)(const struct i2c_client *client, u8 command,
-				u8 length, const u8 *values);
 };
 
-static int rx8581_read_block_data(const struct i2c_client *client, u8 command,
-					u8 length, u8 *values)
-{
-	s32 i, data;
-
-	for (i = 0; i < length; i++) {
-		data = i2c_smbus_read_byte_data(client, command + i);
-		if (data < 0)
-			return data;
-		values[i] = data;
-	}
-	return i;
-}
-
-static int rx8581_write_block_data(const struct i2c_client *client, u8 command,
-					u8 length, const u8 *values)
-{
-	s32 i, ret;
-
-	for (i = 0; i < length; i++) {
-		ret = i2c_smbus_write_byte_data(client, command + i,
-						values[i]);
-		if (ret < 0)
-			return ret;
-	}
-	return length;
-}
-
 /*
  * In the routines that deal directly with the rx8581 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -95,7 +64,8 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char date[7];
-	int data, err;
+	unsigned int data;
+	int err;
 	struct rx8581 *rx8581 = i2c_get_clientdata(client);
 
 	/* First we ensure that the "update flag" is not set, we read the
@@ -103,11 +73,9 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	 * has been set, we know that the time has changed during the read so
 	 * we repeat the whole process again.
 	 */
-	data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
-	if (data < 0) {
-		dev_err(dev, "Unable to read device flags\n");
-		return -EIO;
-	}
+	err = regmap_read(rx8581->regmap, RX8581_REG_FLAG, &data);
+	if (err < 0)
+		return err;
 
 	if (data & RX8581_FLAG_VLF) {
 		dev_warn(dev,
@@ -118,28 +86,22 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	do {
 		/* If update flag set, clear it */
 		if (data & RX8581_FLAG_UF) {
-			err = i2c_smbus_write_byte_data(client,
-				RX8581_REG_FLAG, (data & ~RX8581_FLAG_UF));
-			if (err != 0) {
-				dev_err(dev, "Unable to write device flags\n");
-				return -EIO;
-			}
+			err = regmap_write(rx8581->regmap, RX8581_REG_FLAG,
+					  data & ~RX8581_FLAG_UF);
+			if (err < 0)
+				return err;
 		}
 
 		/* Now read time and date */
-		err = rx8581->read_block_data(client, RX8581_REG_SC,
-			7, date);
-		if (err < 0) {
-			dev_err(dev, "Unable to read date\n");
-			return -EIO;
-		}
+		err = regmap_bulk_read(rx8581->regmap, RX8581_REG_SC, date,
+				       sizeof(date));
+		if (err < 0)
+			return err;
 
 		/* Check flag register */
-		data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
-		if (data < 0) {
-			dev_err(dev, "Unable to read device flags\n");
-			return -EIO;
-		}
+		err = regmap_read(rx8581->regmap, RX8581_REG_FLAG, &data);
+		if (err < 0)
+			return err;
 	} while (data & RX8581_FLAG_UF);
 
 	dev_dbg(dev, "%s: raw data is sec=%02x, min=%02x, hr=%02x, "
@@ -167,7 +129,7 @@ static int rx8581_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	int data, err;
+	int err;
 	unsigned char buf[7];
 	struct rx8581 *rx8581 = i2c_get_clientdata(client);
 
@@ -192,55 +154,26 @@ static int rx8581_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[RX8581_REG_DW] = (0x1 << tm->tm_wday);
 
 	/* Stop the clock */
-	data = i2c_smbus_read_byte_data(client, RX8581_REG_CTRL);
-	if (data < 0) {
-		dev_err(dev, "Unable to read control register\n");
-		return -EIO;
-	}
-
-	err = i2c_smbus_write_byte_data(client, RX8581_REG_CTRL,
-		(data | RX8581_CTRL_STOP));
-	if (err < 0) {
-		dev_err(dev, "Unable to write control register\n");
-		return -EIO;
-	}
+	err = regmap_update_bits(rx8581->regmap, RX8581_REG_CTRL,
+				 RX8581_CTRL_STOP, RX8581_CTRL_STOP);
+	if (err < 0)
+		return err;
 
 	/* write register's data */
-	err = rx8581->write_block_data(client, RX8581_REG_SC, 7, buf);
-	if (err < 0) {
-		dev_err(dev, "Unable to write to date registers\n");
-		return -EIO;
-	}
+	err = regmap_bulk_write(rx8581->regmap, RX8581_REG_SC,
+				buf, sizeof(buf));
+	if (err < 0)
+		return err;
 
 	/* get VLF and clear it */
-	data = i2c_smbus_read_byte_data(client, RX8581_REG_FLAG);
-	if (data < 0) {
-		dev_err(dev, "Unable to read flag register\n");
-		return -EIO;
-	}
-
-	err = i2c_smbus_write_byte_data(client, RX8581_REG_FLAG,
-		(data & ~(RX8581_FLAG_VLF)));
-	if (err != 0) {
-		dev_err(dev, "Unable to write flag register\n");
-		return -EIO;
-	}
+	err = regmap_update_bits(rx8581->regmap, RX8581_REG_FLAG,
+				 RX8581_FLAG_VLF, 0);
+	if (err < 0)
+		return err;
 
 	/* Restart the clock */
-	data = i2c_smbus_read_byte_data(client, RX8581_REG_CTRL);
-	if (data < 0) {
-		dev_err(dev, "Unable to read control register\n");
-		return -EIO;
-	}
-
-	err = i2c_smbus_write_byte_data(client, RX8581_REG_CTRL,
-		(data & ~(RX8581_CTRL_STOP)));
-	if (err != 0) {
-		dev_err(dev, "Unable to write control register\n");
-		return -EIO;
-	}
-
-	return 0;
+	return regmap_update_bits(rx8581->regmap, RX8581_REG_CTRL,
+				 RX8581_CTRL_STOP, 0);
 }
 
 static const struct rtc_class_ops rx8581_rtc_ops = {
@@ -252,27 +185,23 @@ static int rx8581_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct rx8581	  *rx8581;
+	static const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.max_register = 0xf,
+	};
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)
-		&& !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
-		return -EIO;
-
 	rx8581 = devm_kzalloc(&client->dev, sizeof(struct rx8581), GFP_KERNEL);
 	if (!rx8581)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, rx8581);
-	rx8581->client = client;
-
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
-		rx8581->read_block_data = i2c_smbus_read_i2c_block_data;
-		rx8581->write_block_data = i2c_smbus_write_i2c_block_data;
-	} else {
-		rx8581->read_block_data = rx8581_read_block_data;
-		rx8581->write_block_data = rx8581_write_block_data;
-	}
+
+	rx8581->regmap = devm_regmap_init_i2c(client, &config);
+	if (IS_ERR(rx8581->regmap))
+		return PTR_ERR(rx8581->regmap);
 
 	rx8581->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(rx8581->rtc))
-- 
2.17.0

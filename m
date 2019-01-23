Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67842C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2351F217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="arHuYuf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfAWH1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:27:25 -0500
Received: from mout02.posteo.de ([185.67.36.66]:51701 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfAWH1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:27:23 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 1072E240102
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548228440; bh=ZfLilP1zRVHrukYt4PRsnOUe2H0fbBaCZtdQMRph0Rg=;
        h=From:To:Cc:Subject:Date:From;
        b=arHuYuf7agx1xlxi5SUa0W4LdOFVsiSbyQUmts/UwE9qMfexda0xlZ047t3XrrHY+
         9itabHkXjSHrZuHRVE/m5Hv1j8hKEqSWY4gHH4Z4rbEID2megLhXKshvJZEz+NEja2
         8BxPPKG3TXAPvJoHyvk+gap60kfgsLmyJxJFMW2P9Ec6FsWBgBAnx7FwOub3ZAy004
         VrFYtYaVedWtT3COx67OQClcosIPniJDXlSc4po1W5Tl4XVL8PItCoxioJNivusx0L
         8NC3+qGQLywFPMuunh/zskpxvQDYEMll2IxLmOxv8Q5fAd+t4nBOTpj6GuFN75bfAo
         sXDNxqLFLTR8w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43kxgq13qLz9rxN;
        Wed, 23 Jan 2019 08:27:19 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, chinyeow.sim.xt@renesas.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 2/2] Input: st1232 - add support for st1633
Date:   Wed, 23 Jan 2019 08:26:51 +0100
Message-Id: <20190123072651.31791-2-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123072651.31791-1-martink@posteo.de>
References: <20190123072651.31791-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Add support for the Sitronix ST1633 touchscreen controller to the st1232
driver.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/Kconfig  |   6 +-
 drivers/input/touchscreen/st1232.c | 130 +++++++++++++++++++++--------
 2 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 068dbbc610fc..7c597a49c265 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1168,11 +1168,11 @@ config TOUCHSCREEN_SIS_I2C
 	  module will be called sis_i2c.
 
 config TOUCHSCREEN_ST1232
-	tristate "Sitronix ST1232 touchscreen controllers"
+	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
 	depends on I2C
 	help
-	  Say Y here if you want to support Sitronix ST1232
-	  touchscreen controller.
+	  Say Y here if you want to support the Sitronix ST1232
+	  or ST1633 touchscreen controller.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 11ff32c68025..dc0288f37fda 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -18,18 +18,21 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
+#define ST1633_TS_NAME	"st1633-ts"
+
+enum {
+	st1232,
+	st1633,
+};
 
 #define MIN_X		0x00
 #define MIN_Y		0x00
-#define MAX_X		0x31f	/* (800 - 1) */
-#define MAX_Y		0x1df	/* (480 - 1) */
-#define MAX_AREA	0xff
-#define MAX_FINGERS	2
 
 struct st1232_ts_finger {
 	u16 x;
@@ -38,12 +41,24 @@ struct st1232_ts_finger {
 	bool is_valid;
 };
 
+struct st_chip_info {
+	u8	id;
+	u16	max_x;
+	u16	max_y;
+	u16	max_area;
+	u16	max_fingers;
+	u8	start_reg;
+};
+
 struct st1232_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	struct st1232_ts_finger finger[MAX_FINGERS];
 	struct dev_pm_qos_request low_latency_req;
 	int reset_gpio;
+	const struct st_chip_info *chip_info;
+	int read_buf_len;
+	u8 *read_buf;
+	struct st1232_ts_finger *finger;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts)
@@ -52,40 +67,35 @@ static int st1232_ts_read_data(struct st1232_ts_data *ts)
 	struct i2c_client *client = ts->client;
 	struct i2c_msg msg[2];
 	int error;
-	u8 start_reg;
-	u8 buf[10];
+	int i, y;
+	u8 start_reg = ts->chip_info->start_reg;
+	u8 *buf = ts->read_buf;
 
-	/* read touchscreen data from ST1232 */
+	/* read touchscreen data */
 	msg[0].addr = client->addr;
 	msg[0].flags = 0;
 	msg[0].len = 1;
 	msg[0].buf = &start_reg;
-	start_reg = 0x10;
 
 	msg[1].addr = ts->client->addr;
 	msg[1].flags = I2C_M_RD;
-	msg[1].len = sizeof(buf);
+	msg[1].len = ts->read_buf_len;
 	msg[1].buf = buf;
 
 	error = i2c_transfer(client->adapter, msg, 2);
 	if (error < 0)
 		return error;
 
-	/* get "valid" bits */
-	finger[0].is_valid = buf[2] >> 7;
-	finger[1].is_valid = buf[5] >> 7;
+	for (i = 0, y = 0; i < ts->chip_info->max_fingers; i++, y += 3) {
+		finger[i].is_valid = buf[i + y] >> 7;
+		if (finger[i].is_valid) {
+			finger[i].x = ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
+			finger[i].y = ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
 
-	/* get xy coordinate */
-	if (finger[0].is_valid) {
-		finger[0].x = ((buf[2] & 0x0070) << 4) | buf[3];
-		finger[0].y = ((buf[2] & 0x0007) << 8) | buf[4];
-		finger[0].t = buf[8];
-	}
-
-	if (finger[1].is_valid) {
-		finger[1].x = ((buf[5] & 0x0070) << 4) | buf[6];
-		finger[1].y = ((buf[5] & 0x0007) << 8) | buf[7];
-		finger[1].t = buf[9];
+			/* st1232 includes a z-axis / touch strength */
+			if (ts->chip_info->id == st1232)
+				finger[i].t = buf[i + 6];
+		}
 	}
 
 	return 0;
@@ -104,11 +114,14 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 		goto end;
 
 	/* multi touch protocol */
-	for (i = 0; i < MAX_FINGERS; i++) {
+	for (i = 0; i < ts->chip_info->max_fingers; i++) {
 		if (!finger[i].is_valid)
 			continue;
 
-		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, finger[i].t);
+		if (ts->chip_info->id == st1232)
+			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
+					 finger[i].t);
+
 		input_report_abs(input_dev, ABS_MT_POSITION_X, finger[i].x);
 		input_report_abs(input_dev, ABS_MT_POSITION_Y, finger[i].y);
 		input_mt_sync(input_dev);
@@ -142,12 +155,46 @@ static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
 		gpio_direction_output(ts->reset_gpio, poweron);
 }
 
+static const struct st_chip_info st_chip_info_table[] = {
+	[st1232] = {
+		.id = st1232,
+		.max_x = 0x31f, /* 800 - 1 */
+		.max_y = 0x1df, /* 480 -1 */
+		.max_area = 0xff,
+		.max_fingers = 2,
+		.start_reg = 0x12,
+	},
+	[st1633] = {
+		.id = st1633,
+		.max_x = 0x13f, /* 320 - 1 */
+		.max_y = 0x1df, /* 480 -1 */
+		.max_area = 0x00,
+		.max_fingers = 5,
+		.start_reg = 0x12,
+	},
+};
+
+static const struct of_device_id st1232_ts_dt_ids[] = {
+	{ .compatible = "sitronix,st1232", .data = &st_chip_info_table[st1232] },
+	{ .compatible = "sitronix,st1633", .data = &st_chip_info_table[st1633] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
+
 static int st1232_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct st1232_ts_data *ts;
+	struct st1232_ts_finger *finger;
 	struct input_dev *input_dev;
 	int error;
+	const struct of_device_id *match;
+
+	match = of_match_device(st1232_ts_dt_ids, &client->dev);
+	if (!match) {
+		dev_err(&client->dev, "unknown device model\n");
+		return -ENODEV;
+	}
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
@@ -163,6 +210,19 @@ static int st1232_ts_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
+	ts->chip_info = match->data;
+	ts->finger = devm_kzalloc(&client->dev,
+				  sizeof(*finger) * ts->chip_info->max_fingers,
+				  GFP_KERNEL);
+	if (!ts->finger)
+		return -ENOMEM;
+
+	/* allocate a buffer according to the number of registers to read */
+	ts->read_buf_len = ts->chip_info->max_fingers * 4;
+	ts->read_buf = devm_kzalloc(&client->dev, ts->read_buf_len, GFP_KERNEL);
+	if (!ts->read_buf)
+		return -ENOMEM;
+
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -192,9 +252,14 @@ static int st1232_ts_probe(struct i2c_client *client,
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(EV_ABS, input_dev->evbit);
 
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X, MAX_X, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
+	if (ts->chip_info->id == st1232)
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
+				     ts->chip_info->max_area, 0, 0);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
+			     MIN_X, ts->chip_info->max_x, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
+			     MIN_Y, ts->chip_info->max_y, 0, 0);
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, st1232_ts_irq_handler,
@@ -262,16 +327,11 @@ static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
 
 static const struct i2c_device_id st1232_ts_id[] = {
 	{ ST1232_TS_NAME, 0 },
+	{ ST1633_TS_NAME, 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
 
-static const struct of_device_id st1232_ts_dt_ids[] = {
-	{ .compatible = "sitronix,st1232", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
-
 static struct i2c_driver st1232_ts_driver = {
 	.probe		= st1232_ts_probe,
 	.remove		= st1232_ts_remove,
-- 
2.20.1


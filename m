Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F257ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6506A2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6506A2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeJQX7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:59:13 -0400
Received: from mail2.skidata.com ([91.230.2.91]:45071 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbeJQX7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:59:13 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 19:59:11 EDT
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="1732774"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 6/8] Input: sx8654 - add sx8650 support
Date:   Wed, 17 Oct 2018 14:51:14 +0200
Message-ID: <20181017125116.20077-7-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx8654 and sx8650 are quite similar, therefore add support for the
sx8650 within the sx8654 driver.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 193 +++++++++++++++++++++++++++++++++----
 1 file changed, 173 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index afa4da138fe9..4939863efbef 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -29,7 +29,7 @@
 
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -44,9 +44,11 @@
 #define I2C_REG_IRQSRC			0x23
 #define I2C_REG_SOFTRESET		0x3f
 
+#define I2C_REG_SX8650_STAT		0x05
+#define SX8650_STAT_CONVIRQ		0x80
+
 /* commands */
 #define CMD_READ_REGISTER		0x40
-#define CMD_MANUAL			0xc0
 #define CMD_PENTRG			0xe0
 
 /* value for I2C_REG_SOFTRESET */
@@ -58,6 +60,7 @@
 
 /* bits for RegTouch1 */
 #define CONDIRQ				0x20
+#define RPDNT_100K			0x00
 #define FILT_7SA			0x03
 
 /* bits for I2C_REG_CHANMASK */
@@ -71,14 +74,122 @@
 /* power delay: lower nibble of CTRL0 register */
 #define POWDLY_1_1MS			0x0b
 
+/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
+ * last PENIRQ after which we assume the pen is lifted.
+ */
+#define SX8650_PENIRQ_TIMEOUT		msecs_to_jiffies(10)
+
 #define MAX_12BIT			((1 << 12) - 1)
+#define MAX_I2C_READ_LEN		10 /* see datasheet section 5.1.5 */
+
+/* channel definition */
+#define CH_X				0x00
+#define CH_Y				0x01
+
+struct sx865x_data {
+	u8 cmd_manual;
+	u8 chan_mask;
+	u8 has_irq_penrelease;
+	u8 has_reg_irqmask;
+	irq_handler_t irqh;
+};
 
 struct sx8654 {
 	struct input_dev *input;
 	struct i2c_client *client;
 	struct gpio_desc *gpio_reset;
+
+	spinlock_t		lock; /* for input reporting from irq/timer */
+	struct timer_list	timer;
+
+	const struct sx865x_data *data;
 };
 
+static inline void sx865x_penrelease(struct sx8654 *ts)
+{
+	struct input_dev *input_dev = ts->input;
+
+	input_report_key(input_dev, BTN_TOUCH, 0);
+	input_sync(input_dev);
+}
+
+static void sx865x_penrelease_timer_handler(struct timer_list *t)
+{
+	struct sx8654 *ts = from_timer(ts, t, timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	sx865x_penrelease(ts);
+	spin_unlock_irqrestore(&ts->lock, flags);
+	dev_dbg(&ts->client->dev, "penrelease by timer\n");
+}
+
+static irqreturn_t sx8650_irq(int irq, void *handle)
+{
+	struct sx8654 *ts = handle;
+	struct device *dev = &ts->client->dev;
+	int len, i;
+	unsigned long flags;
+	u8 stat;
+	u16 x, y;
+	u8 data[MAX_I2C_READ_LEN];
+	u16 ch;
+	u16 chdata;
+	u8 readlen = hweight32(ts->data->chan_mask) * 2;
+
+	stat = i2c_smbus_read_byte_data(ts->client, CMD_READ_REGISTER
+						    | I2C_REG_SX8650_STAT);
+
+	if (!(stat & SX8650_STAT_CONVIRQ)) {
+		dev_dbg(dev, "%s ignore stat [0x%02x]", __func__, stat);
+		return IRQ_HANDLED;
+	}
+
+	len = i2c_master_recv(ts->client, data, readlen);
+	if (len != readlen) {
+		dev_dbg(dev, "ignore short recv (%d)\n", len);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	x = 0;
+	y = 0;
+	for (i = 0; (i + 1) < len; i++) {
+		chdata = data[i] << 8;
+		i++;
+		chdata += data[i];
+
+		if (unlikely(chdata == 0xFFFF)) {
+			dev_dbg(dev, "invalid qualified data @ %d\n", i);
+			continue;
+		} else if (unlikely(chdata & 0x8000)) {
+			dev_warn(dev, "hibit @ %d [0x%04x]\n", i, chdata);
+			continue;
+		}
+
+		ch = chdata >> 12;
+		if      (ch == CH_X)
+			x = chdata & MAX_12BIT;
+		else if (ch == CH_Y)
+			y = chdata & MAX_12BIT;
+		else
+			dev_warn(dev, "unknown channel %d [0x%04x]\n", ch,
+				 chdata);
+	}
+
+	input_report_abs(ts->input, ABS_X, x);
+	input_report_abs(ts->input, ABS_Y, y);
+	input_report_key(ts->input, BTN_TOUCH, 1);
+	input_sync(ts->input);
+	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
+
+	mod_timer(&ts->timer, jiffies + SX8650_PENIRQ_TIMEOUT);
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t sx8654_irq(int irq, void *handle)
 {
 	struct sx8654 *sx8654 = handle;
@@ -127,6 +238,22 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static const struct sx865x_data sx8650_data = {
+	.cmd_manual = 0xb0,
+	.has_irq_penrelease = 0,
+	.has_reg_irqmask = 0,
+	.chan_mask = (CONV_X | CONV_Y),
+	.irqh = sx8650_irq,
+};
+
+static const struct sx865x_data sx8654_data = {
+	.cmd_manual = 0xc0,
+	.has_irq_penrelease = 1,
+	.has_reg_irqmask = 1,
+	.chan_mask = (CONV_X | CONV_Y),
+	.irqh = sx8654_irq,
+};
+
 static int sx8654_reset(struct sx8654 *ts)
 {
 	int err;
@@ -182,13 +309,13 @@ static void sx8654_close(struct input_dev *dev)
 	disable_irq(client->irq);
 
 	/* enable manual mode mode */
-	error = i2c_smbus_write_byte(client, CMD_MANUAL);
+	error = i2c_smbus_write_byte(client, sx8654->data->cmd_manual);
 	if (error) {
 		dev_err(&client->dev, "writing command CMD_MANUAL failed");
 		return;
 	}
 
-	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, 0);
+	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, RATE_MANUAL);
 	if (error) {
 		dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
 		return;
@@ -221,6 +348,20 @@ static int sx8654_probe(struct i2c_client *client,
 	}
 	dev_dbg(&client->dev, "got GPIO reset pin\n");
 
+	sx8654->data = of_device_get_match_data(&client->dev);
+	if (!sx8654->data)
+		sx8654->data = (const struct sx865x_data *)id->driver_data;
+	if (!sx8654->data) {
+		dev_err(&client->dev, "invalid or missing device data\n");
+		return -EINVAL;
+	}
+
+	if (!sx8654->data->has_irq_penrelease) {
+		dev_dbg(&client->dev, "use timer for penrelease\n");
+		timer_setup(&sx8654->timer, sx865x_penrelease_timer_handler, 0);
+		spin_lock_init(&sx8654->lock);
+	}
+
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
@@ -248,29 +389,31 @@ static int sx8654_probe(struct i2c_client *client,
 	}
 
 	error = i2c_smbus_write_byte_data(client, I2C_REG_CHANMASK,
-					  CONV_X | CONV_Y);
+					  sx8654->data->chan_mask);
 	if (error) {
 		dev_err(&client->dev, "writing to I2C_REG_CHANMASK failed");
 		return error;
 	}
 
-	error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
-					  IRQ_PENTOUCH_TOUCHCONVDONE |
-						IRQ_PENRELEASE);
-	if (error) {
-		dev_err(&client->dev, "writing to I2C_REG_IRQMASK failed");
-		return error;
+	if (sx8654->data->has_reg_irqmask) {
+		error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
+						  IRQ_PENTOUCH_TOUCHCONVDONE |
+							IRQ_PENRELEASE);
+		if (error) {
+			dev_err(&client->dev, "writing I2C_REG_IRQMASK failed");
+			return error;
+		}
 	}
 
 	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH1,
-					  CONDIRQ | FILT_7SA);
+					  CONDIRQ | RPDNT_100K | FILT_7SA);
 	if (error) {
 		dev_err(&client->dev, "writing to I2C_REG_TOUCH1 failed");
 		return error;
 	}
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, sx8654_irq,
+					  NULL, sx8654->data->irqh,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					  client->name, sx8654);
 	if (error) {
@@ -292,18 +435,28 @@ static int sx8654_probe(struct i2c_client *client,
 
 #ifdef CONFIG_OF
 static const struct of_device_id sx8654_of_match[] = {
-	{ .compatible = "semtech,sx8654", },
-	{ .compatible = "semtech,sx8655", },
-	{ .compatible = "semtech,sx8656", },
-	{ },
+	{
+		.compatible = "semtech,sx8650",
+		.data = &sx8650_data,
+	}, {
+		.compatible = "semtech,sx8654",
+		.data = &sx8654_data,
+	}, {
+		.compatible = "semtech,sx8655",
+		.data = &sx8654_data,
+	}, {
+		.compatible = "semtech,sx8656",
+		.data = &sx8654_data,
+	}, {},
 };
 MODULE_DEVICE_TABLE(of, sx8654_of_match);
 #endif
 
 static const struct i2c_device_id sx8654_id_table[] = {
-	{ "semtech_sx8654", 0 },
-	{ "semtech_sx8655", 0 },
-	{ "semtech_sx8656", 0 },
+	{ .name = "semtech_sx8650", .driver_data = (long)&sx8650_data },
+	{ .name = "semtech_sx8654", .driver_data = (long)&sx8654_data },
+	{ .name = "semtech_sx8655", .driver_data = (long)&sx8654_data },
+	{ .name = "semtech_sx8656", .driver_data = (long)&sx8654_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
-- 
2.11.0


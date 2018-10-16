Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D520869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631D520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJPRN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:13:29 -0400
Received: from mail1.skidata.com ([91.230.2.99]:13164 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:13:29 -0400
X-IronPort-AV: E=Sophos;i="5.54,388,1534802400"; 
   d="scan'208";a="12888076"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 6/7] Input: sx8654 - add sx8650 support
Date:   Tue, 16 Oct 2018 11:22:48 +0200
Message-ID: <20181016092248.27288-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181016091653.26896-1-richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx8654 and sx8650 are quite similar, therefore add support for the
sx8650 within the sx8654 driver.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 186 ++++++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 622283b49d7c..33f7a0be4ef8 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -29,12 +29,13 @@
 
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/hrtimer.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -44,9 +45,11 @@
 #define I2C_REG_IRQSRC			0x23
 #define I2C_REG_SOFTRESET		0x3f
 
+#define I2C_REG_SX8650_STAT		0x05
+#define SX8650_STAT_CONVIRQ		BIT(7)
+
 /* commands */
 #define CMD_READ_REGISTER		0x40
-#define CMD_MANUAL			0xc0
 #define CMD_PENTRG			0xe0
 
 /* value for I2C_REG_SOFTRESET */
@@ -58,11 +61,12 @@
 
 /* bits for RegTouch1 */
 #define CONDIRQ				0x20
+#define RPDNT_100K			0x00
 #define FILT_7SA			0x03
 
 /* bits for I2C_REG_CHANMASK */
-#define CONV_X				0x80
-#define CONV_Y				0x40
+#define CONV_X				BIT(7)
+#define CONV_Y				BIT(6)
 
 /* coordinates rate: higher nibble of CTRL0 register */
 #define RATE_MANUAL			0x00
@@ -71,14 +75,110 @@
 /* power delay: lower nibble of CTRL0 register */
 #define POWDLY_1_1MS			0x0b
 
+/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
+ * last PENIRQ after which we assume the pen is lifted.
+ */
+#define SX8650_PENIRQ_TIMEOUT		(80 * 1100 * 1000)
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
+	struct hrtimer timer;
+
+	const struct sx865x_data *data;
 };
 
+static enum hrtimer_restart sx865x_penrelease_timer_handler(struct hrtimer *h)
+{
+	struct sx8654 *ts = container_of(h, struct sx8654, timer);
+
+	input_report_key(ts->input, BTN_TOUCH, 0);
+	input_sync(ts->input);
+	dev_dbg(&ts->client->dev, "penrelease by timer\n");
+
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t sx8650_irq(int irq, void *handle)
+{
+	struct sx8654 *ts = handle;
+	struct device *dev = &ts->client->dev;
+	int len, i, ret;
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
+	ret = hrtimer_try_to_cancel(&ts->timer);
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
+	hrtimer_start(&ts->timer, ktime_set(0, SX8650_PENIRQ_TIMEOUT),
+		      HRTIMER_MODE_REL);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t sx8654_irq(int irq, void *handle)
 {
 	struct sx8654 *sx8654 = handle;
@@ -127,6 +227,22 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
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
@@ -182,13 +298,13 @@ static void sx8654_close(struct input_dev *dev)
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
@@ -196,10 +312,30 @@ static void sx8654_close(struct input_dev *dev)
 }
 
 #ifdef CONFIG_OF
+static const struct of_device_id sx8654_of_match[] = {
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
+};
+MODULE_DEVICE_TABLE(of, sx8654_of_match);
+
 static int sx8654_get_ofdata(struct sx8654 *ts)
 {
 	struct device *dev = &ts->client->dev;
 	struct device_node *node = dev->of_node;
+	const struct of_device_id *of_id = of_match_device(sx8654_of_match,
+							   dev);
+	const struct sx865x_data *data = (struct sx865x_data *)of_id->data;
 	int err;
 
 	if (!node) {
@@ -207,6 +343,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
 		return 0;
 	}
 
+	ts->data = data;
+
 	ts->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (PTR_ERR(ts->gpio_reset) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
@@ -219,18 +357,11 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
 
 	return 0;
 }
-
-static const struct of_device_id sx8654_of_match[] = {
-	{ .compatible = "semtech,sx8654", },
-	{ .compatible = "semtech,sx8655", },
-	{ .compatible = "semtech,sx8656", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, sx8654_of_match);
 #else /* CONFIG_OF */
 static int sx8654_get_ofdata(struct sx8654 *ts)
 {
 	ts->gpio_reset = NULL;
+	ts->data = &sx8654_data;
 	return 0;
 }
 #endif /* CONFIG_OF */
@@ -258,6 +389,12 @@ static int sx8654_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (!sx8654->data->has_irq_penrelease) {
+		dev_dbg(&client->dev, "use timer for penrelease\n");
+		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		sx8654->timer.function = sx865x_penrelease_timer_handler;
+	}
+
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
@@ -284,29 +421,31 @@ static int sx8654_probe(struct i2c_client *client,
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
@@ -327,6 +466,7 @@ static int sx8654_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id sx8654_id_table[] = {
+	{ "semtech_sx8650", 0 },
 	{ "semtech_sx8654", 0 },
 	{ "semtech_sx8655", 0 },
 	{ "semtech_sx8656", 0 },
-- 
2.11.0


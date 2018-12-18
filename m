Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57923C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F420217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeLRIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:36:48 -0500
Received: from mail2.skidata.com ([91.230.2.91]:32226 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbeLRIgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:36:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539640800"; 
   d="scan'208";a="1873949"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <mark.rutland@arm.com>
CC:     <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <richard.leitner@skidata.com>
Subject: [RESEND PATCH v2 2/8] Input: sx8654 - add reset-gpio support
Date:   Tue, 18 Dec 2018 09:36:00 +0100
Message-ID: <20181218083606.25795-3-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181218083606.25795-1-richard.leitner@skidata.com>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sx8654 features a NRST input which may be connected to a GPIO.
Therefore add support for hard-resetting the sx8654 via this NRST.

If the reset-gpio property is provided the sx8654 is resetted via NRST
instead of the soft-reset via I2C.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 40 +++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index ed29db3ec731..238f56b1581b 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -33,6 +33,8 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -74,6 +76,7 @@
 struct sx8654 {
 	struct input_dev *input;
 	struct i2c_client *client;
+	struct gpio_desc *gpio_reset;
 };
 
 static irqreturn_t sx8654_irq(int irq, void *handle)
@@ -124,6 +127,27 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static int sx8654_reset(struct sx8654 *ts)
+{
+	int err;
+
+	if (ts->gpio_reset) {
+		gpiod_set_value_cansleep(ts->gpio_reset, 1);
+		udelay(2); /* Tpulse > 1µs */
+		gpiod_set_value_cansleep(ts->gpio_reset, 0);
+
+		return 0;
+	}
+
+	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
+	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
+					SOFTRESET_VALUE);
+	if (err)
+		return err;
+	else
+		return 0;
+}
+
 static int sx8654_open(struct input_dev *dev)
 {
 	struct sx8654 *sx8654 = input_get_drvdata(dev);
@@ -186,6 +210,17 @@ static int sx8654_probe(struct i2c_client *client,
 	if (!sx8654)
 		return -ENOMEM;
 
+	sx8654->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(sx8654->gpio_reset)) {
+		error = PTR_ERR(sx8654->gpio_reset);
+		if (error != -EPROBE_DEFER)
+			dev_err(&client->dev, "unable to get reset-gpio: %d\n",
+				error);
+		return error;
+	}
+	dev_dbg(&client->dev, "got GPIO reset pin\n");
+
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
@@ -206,10 +241,9 @@ static int sx8654_probe(struct i2c_client *client,
 
 	input_set_drvdata(sx8654->input, sx8654);
 
-	error = i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
-					  SOFTRESET_VALUE);
+	error = sx8654_reset(sx8654);
 	if (error) {
-		dev_err(&client->dev, "writing softreset value failed");
+		dev_err(&client->dev, "reset failed");
 		return error;
 	}
 
-- 
2.11.0


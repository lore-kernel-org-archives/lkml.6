Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8009C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A66B20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A66B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJPRNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:13:42 -0400
Received: from mail1.skidata.com ([91.230.2.99]:36789 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:13:42 -0400
X-IronPort-AV: E=Sophos;i="5.54,388,1534802400"; 
   d="scan'208";a="12888081"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 7/7] Input: sx8654 - use common of_touchscreen functions
Date:   Tue, 16 Oct 2018 11:23:10 +0200
Message-ID: <20181016092310.27346-1-richard.leitner@skidata.com>
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

of_touchscreen.c provides a common interface for a axis invertion and
swapping of touchscreens. Therefore use it in the sx8654 driver.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 33f7a0be4ef8..08b064f96b4e 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -36,6 +36,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/hrtimer.h>
+#include <linux/input/touchscreen.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -100,6 +101,7 @@ struct sx8654 {
 	struct i2c_client *client;
 	struct gpio_desc *gpio_reset;
 	struct hrtimer timer;
+	struct touchscreen_properties props;
 
 	const struct sx865x_data *data;
 };
@@ -168,8 +170,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
 				 chdata);
 	}
 
-	input_report_abs(ts->input, ABS_X, x);
-	input_report_abs(ts->input, ABS_Y, y);
+	touchscreen_report_pos(ts->input, &ts->props, x, y, false);
 	input_report_key(ts->input, BTN_TOUCH, 1);
 	input_sync(ts->input);
 	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
@@ -215,8 +216,8 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 		x = ((data[0] & 0xf) << 8) | (data[1]);
 		y = ((data[2] & 0xf) << 8) | (data[3]);
 
-		input_report_abs(sx8654->input, ABS_X, x);
-		input_report_abs(sx8654->input, ABS_Y, y);
+		touchscreen_report_pos(sx8654->input, &sx8654->props, x, y,
+				       false);
 		input_report_key(sx8654->input, BTN_TOUCH, 1);
 		input_sync(sx8654->input);
 
@@ -355,6 +356,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
 	}
 	dev_dbg(dev, "got GPIO reset pin\n");
 
+	touchscreen_parse_properties(ts->input, false, &ts->props);
+
 	return 0;
 }
 #else /* CONFIG_OF */
@@ -380,25 +383,11 @@ static int sx8654_probe(struct i2c_client *client,
 	sx8654 = devm_kzalloc(&client->dev, sizeof(*sx8654), GFP_KERNEL);
 	if (!sx8654)
 		return -ENOMEM;
-
 	sx8654->client = client;
 
-	error = sx8654_get_ofdata(sx8654);
-	if (error) {
-		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
-		return error;
-	}
-
-	if (!sx8654->data->has_irq_penrelease) {
-		dev_dbg(&client->dev, "use timer for penrelease\n");
-		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		sx8654->timer.function = sx865x_penrelease_timer_handler;
-	}
-
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
-
 	sx8654->input = input;
 
 	input->name = "SX8654 I2C Touchscreen";
@@ -414,6 +403,18 @@ static int sx8654_probe(struct i2c_client *client,
 
 	input_set_drvdata(sx8654->input, sx8654);
 
+	error = sx8654_get_ofdata(sx8654);
+	if (error) {
+		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
+		return error;
+	}
+
+	if (!sx8654->data->has_irq_penrelease) {
+		dev_dbg(&client->dev, "use timer for penrelease\n");
+		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		sx8654->timer.function = sx865x_penrelease_timer_handler;
+	}
+
 	error = sx8654_reset(sx8654);
 	if (error) {
 		dev_err(&client->dev, "reset failed");
-- 
2.11.0


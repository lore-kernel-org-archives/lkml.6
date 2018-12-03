Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B42145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ctOtaMPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLCKQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44261 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLCKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so11482684wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MX6hF1WvT6/jnjg/Hvxrw/jbX1gmvj02z43j9IhctPk=;
        b=ctOtaMPGCmFOsRrqLmlS+E6Vf5lZ8qOMRYKnnfunQTf7jPddBD4Q5tt6umguIojCEq
         svzBj6FKXHKdjaclTZh12ET5K/gRPnVZLmEl1EYH7z9QIKUQ5QYGqsHgSQVKfgyKZaqw
         BCRT0CB1J7fK1u+aQQ6PLGAMYUdPKWUF/rHVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MX6hF1WvT6/jnjg/Hvxrw/jbX1gmvj02z43j9IhctPk=;
        b=hlZTtERG8rEiIhwBHSYOwrQ80kMLFxXSoy7cpC8twgSdgb6HqmNaQ7vA21+I0oNLnW
         PlyXV8JxLi9lEQ5a/irR0+gy45pnzE3RFLpUfDyyCYUrSbEq/wn7JOhAGciDxpgqpjKd
         u8BSZCxfHe8zMOPgU00iDLKbS4Vrr5vgZaq7m8MOlK9+F+sqABt1OK7/BKM5FHDzgUDz
         CGAj9arb7NyHNGjbc+eg4YGQtV7OMQ15FEs1L0B8eldZ/Dltwf/ZdV6C8CZoCLBrgBfU
         Ypt7x5I/7I/loV2yGWHG82+gf2tEO0YEZtiKf3YzUi1UiSfrp7x5o//HynXAJhNeiX+0
         JVWQ==
X-Gm-Message-State: AA+aEWYxO8EbvqzQXIsLQfcoc0Ha5Y1HbTx/4vFtEf7vfupEopDQRfmc
        eXIdbmXuV4QGvxFD8PBTiATrjA==
X-Google-Smtp-Source: AFSGD/XZrkrloQ5/rvxj/0OMNRHVR0EheGpmH5OuudxmqmlBlo2LoDkZaoKHippBpsUviaxdeZIqzA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr9244659wrq.108.1543832161996;
        Mon, 03 Dec 2018 02:16:01 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:16:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 6/9] Input: goodix - Add vcc-supply regulator support
Date:   Mon,  3 Dec 2018 15:45:44 +0530
Message-Id: <20181203101547.16835-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcc-supply property is need for some Goodix CTP controller like GT5663
where 3.3V external pull-up regulator connected via controller VCC pin.

So, enable the regulator for those it attached the vcc-supply.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 39 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..7adcf1491609 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -47,6 +48,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *vcc;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -58,6 +60,7 @@ struct goodix_ts_data {
 
 #define GOODIX_GPIO_INT_NAME		"irq"
 #define GOODIX_GPIO_RST_NAME		"reset"
+#define GOODIX_VCC_CTP_NAME		"vcc"
 
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
@@ -525,12 +528,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 {
 	int error;
 	struct device *dev;
+	struct regulator *regulator;
 	struct gpio_desc *gpiod;
 
 	if (!ts->client)
 		return -EINVAL;
 	dev = &ts->client->dev;
 
+	regulator = devm_regulator_get(dev, GOODIX_VCC_CTP_NAME);
+	if (IS_ERR(regulator)) {
+		error = PTR_ERR(regulator);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vcc regulator: %d\n",
+				error);
+		return error;
+	}
+
+	ts->vcc = regulator;
+
 	/* Get the interrupt GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
@@ -786,25 +801,34 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	/* power the controller */
+	if (ts->vcc) {
+		error = regulator_enable(ts->vcc);
+		if (error) {
+			dev_err(&client->dev, "Controller fail to enable vcc\n");
+			return error;
+		}
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
 		if (error) {
 			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
+			goto error;
 		}
 	}
 
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-		return error;
+		goto error;
 	}
 
 	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
-		return error;
+		goto error;
 	}
 
 	ts->chip = goodix_get_chip_data(ts->id);
@@ -823,17 +847,22 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			return error;
+			goto error;
 		}
 
 		return 0;
 	} else {
 		error = goodix_configure_dev(ts);
 		if (error)
-			return error;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	if (ts->vcc)
+		regulator_disable(ts->vcc);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
-- 
2.18.0.321.gffc6fa0e3


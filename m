Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CACC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3268822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="AFqK/ni/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbeKNW6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:58:45 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:48362 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeKNW6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:58:44 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAECsstX003333
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 14 Nov 2018 23:55:25 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542200126; bh=SOuZ9MsvprAZ7Zn4mnsMnzF6RCPWRrUBfhOO9VO0smA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AFqK/ni/laMDfKWQGObIU4ILZYkvTlUJcYBP/SaQYD5g8aGrP9+O9SxNtVfeJLWVD
         2hb6zxs+/c2FzvHnbItEdIs9dMCe5bravWEahos9eKRbm6SwZUJEd/BEW+eQWRNkVP
         xT7oyWVTuKNch0yHys45RMAaKuCpmyr7wIZWHhCJP7NveGfRq8Kdyxr+8qX+X7LOrp
         Jj7e/IjESjtJxnn2c8ftKUIa+Xu5+VhBrVONXiS6KlNIJJ0ffuzcPGCwQ5CKjf8RFI
         n9Ht5SQ9/Z0q4g2ZD5L+HfC4okbUhh90kz9fi6HjJTDl1G97JINJEPuVs0CiJVAVwj
         YGXNeE9vEH7Wg==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v7 2/4] pps: descriptor-based gpio, capture-clear addition
Date:   Wed, 14 Nov 2018 23:54:30 +1100
Message-Id: <20181114125432.16044-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181114125432.16044-2-tom@aussec.com>
References: <20181114125432.16044-1-tom@aussec.com>
 <20181114125432.16044-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the GPIO access for the pps-gpio driver from the
integer based ABI to the descriptor based ABI.  It also adds
documentation for the device tree capture-clear option and
device tree capture-clear extraction.  The legacy device tree
entry for the GPIO pin is supported.

Signed-off-by: Tom Burkart <tom@aussec.com>
---
 drivers/pps/clients/pps-gpio.c | 124 ++++++++++++++++++++++++++++-------------
 include/linux/pps-gpio.h       |   3 +-
 2 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 333ad7d5b45b..aa8b8fb0e9ab 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -31,7 +31,8 @@
 #include <linux/slab.h>
 #include <linux/pps_kernel.h>
 #include <linux/pps-gpio.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>	/* GPIO descriptor ABI */
+#include <linux/gpio.h>			/* GPIO integer ABI */
 #include <linux/list.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -41,9 +42,11 @@ struct pps_gpio_device_data {
 	int irq;			/* IRQ used as PPS source */
 	struct pps_device *pps;		/* PPS source device */
 	struct pps_source_info info;	/* PPS source information */
+	struct gpio_desc *gpio_pin;	/* GPIO port descriptors */
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
+	bool legacy_int_gpio;		/* flag for which ABI to use */
+	unsigned int gpio_pin_int;	/* GPIO integer ABI */
 };
 
 /*
@@ -61,18 +64,87 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
-	rising_edge = gpio_get_value(info->gpio_pin);
+	if (info->legacy_int_gpio)
+		rising_edge = gpio_get_value(info->gpio_pin_int);
+	else
+		rising_edge = gpiod_get_value(info->gpio_pin);
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
 	else if (info->capture_clear &&
 			((rising_edge && info->assert_falling_edge) ||
-			 (!rising_edge && !info->assert_falling_edge)))
+			(!rising_edge && !info->assert_falling_edge)))
 		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
 
 	return IRQ_HANDLED;
 }
 
+static int pps_gpio_setup(struct platform_device *pdev)
+{
+	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
+	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	const char *gpio_label;
+	int ret;
+
+	if (pdata) {
+		data->gpio_pin_int = pdata->gpio_pin_int;
+		data->gpio_pin = pdata->gpio_pin;
+		gpio_label = pdata->gpio_label;
+
+		data->assert_falling_edge = pdata->assert_falling_edge;
+		data->capture_clear = pdata->capture_clear;
+	} else {
+		if (of_get_property(np, "gpios", NULL)) { /* integer GPIO */
+			data->legacy_int_gpio = true;
+
+			ret = of_get_named_gpio(np, "gpios", 0);
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"failed to get GPIO from device tree\n");
+				return ret;
+			}
+			data->gpio_pin_int = ret;
+			gpio_label = PPS_GPIO_NAME;
+
+		} else {	/* descriptor GPIO */
+			data->gpio_pin = devm_gpiod_get(&pdev->dev,
+				"pps",
+				GPIOD_IN);
+			if (IS_ERR(data->gpio_pin)) {
+				dev_err(&pdev->dev,
+					"failed to request PPS GPIO\n");
+				return PTR_ERR(data->gpio_pin);
+			}
+		}
+
+		if (of_get_property(np, "assert-falling-edge", NULL))
+			data->assert_falling_edge = true;
+
+		if (of_get_property(np, "capture-clear", NULL))
+			data->capture_clear = true;
+	}
+
+	/* GPIO setup */
+	if (data->legacy_int_gpio) {
+		ret = devm_gpio_request(&pdev->dev,
+			data->gpio_pin_int,
+			gpio_label);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request GPIO %u\n",
+				data->gpio_pin_int);
+			return ret;
+		}
+
+		ret = gpio_direction_input(data->gpio_pin_int);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to set pin as input\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static unsigned long
 get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 {
@@ -90,53 +162,26 @@ get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 static int pps_gpio_probe(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data;
-	const char *gpio_label;
 	int ret;
 	int pps_default_params;
-	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
 
 	/* allocate space for device info */
 	data = devm_kzalloc(&pdev->dev, sizeof(struct pps_gpio_device_data),
 			GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-
-	if (pdata) {
-		data->gpio_pin = pdata->gpio_pin;
-		gpio_label = pdata->gpio_label;
-
-		data->assert_falling_edge = pdata->assert_falling_edge;
-		data->capture_clear = pdata->capture_clear;
-	} else {
-		ret = of_get_gpio(np, 0);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get GPIO from device tree\n");
-			return ret;
-		}
-		data->gpio_pin = ret;
-		gpio_label = PPS_GPIO_NAME;
-
-		if (of_get_property(np, "assert-falling-edge", NULL))
-			data->assert_falling_edge = true;
-	}
+	platform_set_drvdata(pdev, data);
 
 	/* GPIO setup */
-	ret = devm_gpio_request(&pdev->dev, data->gpio_pin, gpio_label);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request GPIO %u\n",
-			data->gpio_pin);
-		return ret;
-	}
-
-	ret = gpio_direction_input(data->gpio_pin);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to set pin direction\n");
+	ret = pps_gpio_setup(pdev);
+	if (ret)
 		return -EINVAL;
-	}
 
 	/* IRQ setup */
-	ret = gpio_to_irq(data->gpio_pin);
+	if (data->legacy_int_gpio)
+		ret = gpio_to_irq(data->gpio_pin_int);
+	else
+		ret = gpiod_to_irq(data->gpio_pin);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
 		return -EINVAL;
@@ -173,7 +218,6 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	platform_set_drvdata(pdev, data);
 	dev_info(data->pps->dev, "Registered IRQ %d as PPS source\n",
 		 data->irq);
 
@@ -209,4 +253,4 @@ MODULE_AUTHOR("Ricardo Martins <rasm@fe.up.pt>");
 MODULE_AUTHOR("James Nuss <jamesnuss@nanometrics.ca>");
 MODULE_DESCRIPTION("Use GPIO pin as PPS source");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.0");
+MODULE_VERSION("1.1.0");
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index 56f35dd3d01d..86e2081dc7d1 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -23,9 +23,10 @@
 #define _PPS_GPIO_H
 
 struct pps_gpio_platform_data {
+	struct gpio_desc *gpio_pin;
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
+	unsigned int gpio_pin_int;
 	const char *gpio_label;
 };
 
-- 
2.12.3


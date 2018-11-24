Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D44C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C102D20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="Xw0BWheN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C102D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeKXW3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:29:09 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:44504 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKXW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:29:08 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAOBeOqB008096
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sat, 24 Nov 2018 22:40:46 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1543059646; bh=CvzlQr/NmKAmcvVpVgE4I0y2g1+IpsQu+7kqgrf5IA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xw0BWheNlM5nXaAOuow0n5RK9ZHKNfQnutzGxid/RuFMJwTWowhf/WwAAuLUgXOVU
         ZKREthchq3WoDG0XnUuc7kAgjZMZmJ9YZUKg38QU57JpM3giqHFXoS9u1xiwkGemct
         1xO3B5JRtcoVrbFRp6Ibv08OOvAjsD4qpeXLQwyP5FL+VblK6l/Yq4oUgFWc0taABl
         3ni+qwQyunmhz8JhgfJNQgMDPvYDpO+GOyd4s9ZiF7WI7Rr7Njnyesqqc/M0bFCoKZ
         GETh7swKa2NxF5p1A8WRngczEAynzmDWPpOZWoy0a55hIKY4q2IRocoK3E09y0Mmx3
         +cw/g7isDQ6fQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v10 2/4] pps: descriptor-based gpio, capture-clear addition
Date:   Sat, 24 Nov 2018 22:38:10 +1100
Message-Id: <20181124113812.31700-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181124113812.31700-2-tom@aussec.com>
References: <20181124113812.31700-1-tom@aussec.com>
 <20181124113812.31700-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the GPIO access for the pps-gpio driver from the
integer based ABI to the descriptor based ABI.  It also adds the
extraction of the device tree capture-clear option.

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Tom Burkart <tom@aussec.com>
---
 drivers/pps/clients/pps-gpio.c | 70 ++++++++++++++++++++----------------------
 include/linux/pps-gpio.h       |  3 +-
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 333ad7d5b45b..3d6e6f9a2304 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -31,7 +31,7 @@
 #include <linux/slab.h>
 #include <linux/pps_kernel.h>
 #include <linux/pps-gpio.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/list.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -41,9 +41,9 @@ struct pps_gpio_device_data {
 	int irq;			/* IRQ used as PPS source */
 	struct pps_device *pps;		/* PPS source device */
 	struct pps_source_info info;	/* PPS source information */
+	struct gpio_desc *gpio_pin;	/* GPIO port descriptors */
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
 };
 
 /*
@@ -61,18 +61,40 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
-	rising_edge = gpio_get_value(info->gpio_pin);
+	rising_edge = gpiod_get_value(info->gpio_pin);
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
+	struct device_node *np = pdev->dev.of_node;
+
+	data->gpio_pin = devm_gpiod_get(&pdev->dev,
+		NULL,	/* request "gpios" */
+		GPIOD_IN);
+	if (IS_ERR(data->gpio_pin)) {
+		dev_err(&pdev->dev,
+			"failed to request PPS GPIO\n");
+		return PTR_ERR(data->gpio_pin);
+	}
+
+	if (of_property_read_bool(np, "assert-falling-edge"))
+		data->assert_falling_edge = true;
+
+	if (of_property_read_bool(np, "capture-clear"))
+		data->capture_clear = true;
+	return 0;
+}
+
 static unsigned long
 get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 {
@@ -90,53 +112,30 @@ get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 static int pps_gpio_probe(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data;
-	const char *gpio_label;
 	int ret;
 	int pps_default_params;
 	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
 
 	/* allocate space for device info */
-	data = devm_kzalloc(&pdev->dev, sizeof(struct pps_gpio_device_data),
-			GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, data);
 
+	/* GPIO setup */
 	if (pdata) {
 		data->gpio_pin = pdata->gpio_pin;
-		gpio_label = pdata->gpio_label;
 
 		data->assert_falling_edge = pdata->assert_falling_edge;
 		data->capture_clear = pdata->capture_clear;
 	} else {
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
-
-	/* GPIO setup */
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
-		return -EINVAL;
+		ret = pps_gpio_setup(pdev);
+		if (ret)
+			return -EINVAL;
 	}
 
 	/* IRQ setup */
-	ret = gpio_to_irq(data->gpio_pin);
+	ret = gpiod_to_irq(data->gpio_pin);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
 		return -EINVAL;
@@ -173,7 +172,6 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	platform_set_drvdata(pdev, data);
 	dev_info(data->pps->dev, "Registered IRQ %d as PPS source\n",
 		 data->irq);
 
@@ -209,4 +207,4 @@ MODULE_AUTHOR("Ricardo Martins <rasm@fe.up.pt>");
 MODULE_AUTHOR("James Nuss <jamesnuss@nanometrics.ca>");
 MODULE_DESCRIPTION("Use GPIO pin as PPS source");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.0");
+MODULE_VERSION("1.1.0");
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index 56f35dd3d01d..f028d2cda6f5 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -23,10 +23,9 @@
 #define _PPS_GPIO_H
 
 struct pps_gpio_platform_data {
+	struct gpio_desc *gpio_pin;
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
-	const char *gpio_label;
 };
 
 #endif /* _PPS_GPIO_H */
-- 
2.12.3


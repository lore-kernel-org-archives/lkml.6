Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032132AbeBONBo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:01:44 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031970AbeBONBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:01:41 -0500
From: Lukas Senger <lukas@fridolin.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org, Lukas Senger <lukas@fridolin.com>
Subject: [PATCH 2/2] pps-gpio: Set echo GPIO pin via devicetree
Date: Thu, 15 Feb 2018 13:59:21 +0100
Message-Id: <20180215125921.29494-3-lukas@fridolin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215125921.29494-1-lukas@fridolin.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
X-Provags-ID: V03:K0:VI1seVeYY5g8HRMQeHOwFQS8jyTFG9Z+bxDj9k57N4oEeltE977
 WHy13AV1Yf/mc1nt8lMDBZdMjaXJCcgu/6p1Ac8BuLedSRhSaEm3pLGbWb2kEN3GNfiurFR
 LSCbYQn/bnrK9/v9Jqzgrk+9qQ7BK9xWLjVsefaNhK7qOP7ff+g7LlVfLxSvgZrvyKTKaIA
 +7RwKngksGBbR3SxfGnog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K5nZEuHxV2Q=:JuevYL33cOs69pU9D1I4YD
 SFvL7ymJ1XWlR0iS/IZE65FirYXfAYf6Jc99DlMNLt+op9HLK3s/kTyqcie6WUlE63yoicq5J
 w/rZzIletSCjZI5PjBfWst8gnTJ30I3448kmY8IndnhaY+gE62V7rldcCora/a2+cwagpKCpO
 WsRxV8tK65L/1d7Sz62WJjEC2dGZtTZwoYoVIg1IGFFoDxXluCiIhPXpErBMgSiyMcM9DaSKc
 zeToOrV/00Y56rnsamrwOnJZI0CJpagW2MqpeQTDLlT8QSB+RdgeMk2s1LebfCzQtzPBM/aMU
 oMPMSfl0cW8jEtGYRKrtmnsCNebNtpQM8039WRHk5uIAYEAz067vIAAgbwY+hov6KRs3+vfPK
 qnWP7Sk8HS/AsCLiTtHXEWIUhZ/sWJxlvNXN9bvMjG9lIaTG9ZQWHCpT7Kn8bETgn60ewabnJ
 OIs2C2+Ji58+xMSd+2e/mqS6G7Ib6oMbUeJj+ufplHhjeFLBZn+eROhSd7nwjuPQOTiol/eKU
 EqF8w56BroxNrG5YjG9kxPrL/q+MmTwTitmdxjyJa4PYCR7n5LexNNaXzzYUMJCdatCQ+WnJY
 KU3sWC2w8wjB1IJ6LiEpTRZZS/qzWhcZPNn+ayGvpsAm6Fs5HBCTtp9m4IrUKQpChQxG3afLo
 EWODo/Pcog8dQNJPtw60nh5vz7ka28/jvweCL8tMTXWgc8X9+3Z2B+Z1FW8dLDmrpcRH4pzlT
 Bw4oHqpAWXtxapGugQDLObXbO0rfxvt9eLANuw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/arm/boot/dts/overlays/pps-gpio-overlay.dts | 13 ++++++++-----
 drivers/pps/clients/pps-gpio.c                  | 26 ++++++++++++++-----------
 include/linux/pps-gpio.h                        |  1 +
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts b/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
index 9ee4bdfa6167..06e6cf5fc6ea 100644
--- a/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
+++ b/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
@@ -10,7 +10,8 @@
 				compatible = "pps-gpio";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pps_pins>;
-				gpios = <&gpio 18 0>;
+				in-gpios = <&gpio 18 0>;
+				out-gpios = <&gpio 17 0>;
 				status = "okay";
 			};
 		};
@@ -20,18 +21,20 @@
 		target = <&gpio>;
 		__overlay__ {
 			pps_pins: pps_pins@12 {
-				brcm,pins =     <18>;
-				brcm,function = <0>;    // in
-				brcm,pull =     <0>;    // off
+				brcm,pins =     <18 17>;
+				brcm,function = <0 1>;    // in  out
+				brcm,pull =     <0 0>;    // off off
 			};
 		};
 	};
 
 	__overrides__ {
-		gpiopin = <&pps>,"gpios:4",
+		gpiopin = <&pps>,"in-gpios:4",
 			  <&pps>,"reg:0",
 			  <&pps_pins>,"brcm,pins:0",
 			  <&pps_pins>,"reg:0";
+		echopin = <&pps>,"out-gpios:4",
+			  <&pps_pins>,"brcm,pins:4";
 		assert_falling_edge = <&pps>,"assert-falling-edge?";
 	};
 };
diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 35c3b14fc9b9..ce3065889a7e 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -37,10 +37,6 @@
 #include <linux/of_gpio.h>
 #include <linux/delay.h>
 
-/* TODO: this should work like gpio_pin below but I don't know how to work with
- * devicetree overlays.
- */
-#define PPS_GPIO_ECHO_PIN 17
 
 /* Info for each registered platform device */
 struct pps_gpio_device_data {
@@ -50,6 +46,7 @@ struct pps_gpio_device_data {
 	bool assert_falling_edge;
 	bool capture_clear;
 	unsigned int gpio_pin;
+	unsigned int echo_pin;
 };
 
 /*
@@ -71,14 +68,14 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge)) {
 		if (info->pps->params.mode & PPS_ECHOASSERT) {
-			gpio_set_value(PPS_GPIO_ECHO_PIN, 1);
+			gpio_set_value(info->echo_pin, 1);
 		}
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
 	} else if (info->capture_clear &&
 			((rising_edge && info->assert_falling_edge) ||
 			 (!rising_edge && !info->assert_falling_edge))) {
 		if (info->pps->params.mode & PPS_ECHOCLEAR) {
-			gpio_set_value(PPS_GPIO_ECHO_PIN, 1);
+			gpio_set_value(info->echo_pin, 1);
 		}
 		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
 	}
@@ -98,7 +95,7 @@ static irqreturn_t pps_gpio_irq_threaded(int irq, void *data)
 	info = data;
 
 	msleep(100);
-	gpio_set_value(PPS_GPIO_ECHO_PIN, 0);
+	gpio_set_value(info->echo_pin, 0);
 
 	return IRQ_HANDLED;
 }
@@ -135,17 +132,24 @@ static int pps_gpio_probe(struct platform_device *pdev)
 
 	if (pdata) {
 		data->gpio_pin = pdata->gpio_pin;
+		data->echo_pin = pdata->echo_pin;
 		gpio_label = pdata->gpio_label;
 
 		data->assert_falling_edge = pdata->assert_falling_edge;
 		data->capture_clear = pdata->capture_clear;
 	} else {
-		ret = of_get_gpio(np, 0);
+		ret = of_get_named_gpio(np, "in-gpios", 0);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get GPIO from device tree\n");
 			return ret;
 		}
 		data->gpio_pin = ret;
+		ret = of_get_named_gpio(np, "out-gpios", 0);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get second GPIO from device tree\n");
+			return ret;
+		}
+		data->echo_pin = ret;
 		gpio_label = PPS_GPIO_NAME;
 
 		if (of_get_property(np, "assert-falling-edge", NULL))
@@ -166,14 +170,14 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_gpio_request(&pdev->dev, PPS_GPIO_ECHO_PIN, gpio_label);
+	ret = devm_gpio_request(&pdev->dev, data->echo_pin, gpio_label);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request GPIO %u\n",
-			PPS_GPIO_ECHO_PIN);
+			data->echo_pin);
 		return ret;
 	}
 
-	ret = gpio_direction_output(PPS_GPIO_ECHO_PIN, 0);
+	ret = gpio_direction_output(data->echo_pin, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set pin as output\n");
 		return -EINVAL;
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index 67f50e8dcd11..de1701ae1c6a 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -26,6 +26,7 @@ struct pps_gpio_platform_data {
 	bool assert_falling_edge;
 	bool capture_clear;
 	unsigned int gpio_pin;
+	unsigned int echo_pin;
 	const char *gpio_label;
 };
 
-- 
2.16.1

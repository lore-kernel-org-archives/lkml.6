Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932859AbeCOWmd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:42:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39873 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeCOWmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:12 -0400
X-Google-Smtp-Source: AG47ELt8JtmjKd7e49V/NqtsZtqk1/Y2ZMNm7GLLSI8wr1esiS4lxRYLCj+S0w6ixLh+DeyIPNP34w==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC 4/4] backlight: gpio_backlight: remove platform data support
Date: Thu, 15 Mar 2018 15:42:02 -0700
Message-Id: <20180315224202.96668-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy boards can use static property sets/GPIO lookup tables to describe
backlight connections, there is no need to maintain legacy platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c     | 85 ++++----------------
 include/linux/platform_data/gpio_backlight.h | 20 -----
 2 files changed, 14 insertions(+), 91 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio_backlight.h

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 173fc4aafb89b..795359deeb700 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -15,17 +15,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
-#include <linux/platform_data/gpio_backlight.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 struct gpio_backlight {
-	struct device *dev;
-	struct device *fbdev;
-
 	struct gpio_desc *gpiod;
-	int def_value;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
@@ -43,84 +38,32 @@ static int gpio_backlight_update_status(struct backlight_device *bl)
 	return 0;
 }
 
-static int gpio_backlight_check_fb(struct backlight_device *bl,
-				   struct fb_info *info)
-{
-	struct gpio_backlight *gbl = bl_get_data(bl);
-
-	return gbl->fbdev == NULL || gbl->fbdev == info->dev;
-}
-
 static const struct backlight_ops gpio_backlight_ops = {
 	.options	= BL_CORE_SUSPENDRESUME,
 	.update_status	= gpio_backlight_update_status,
-	.check_fb	= gpio_backlight_check_fb,
 };
 
-static int gpio_backlight_probe_dt(struct platform_device *pdev,
-				   struct gpio_backlight *gbl)
-{
-	struct device *dev = &pdev->dev;
-	enum gpiod_flags flags;
-	int ret;
-
-	gbl->def_value = device_property_read_bool(dev, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-
-	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
-	if (IS_ERR(gbl->gpiod)) {
-		ret = PTR_ERR(gbl->gpiod);
-
-		if (ret != -EPROBE_DEFER) {
-			dev_err(dev,
-				"Error: The gpios parameter is missing or invalid.\n");
-		}
-		return ret;
-	}
-
-	return 0;
-}
-
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
-	struct gpio_backlight_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
+	int def_value;
 	int ret;
 
-	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
-	if (gbl == NULL)
+	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
+	if (!gbl)
 		return -ENOMEM;
 
-	gbl->dev = &pdev->dev;
-
-	if (!pdata) {
-		ret = gpio_backlight_probe_dt(pdev, gbl);
-		if (ret)
-			return ret;
-	} else {
-		/*
-		 * Legacy platform data GPIO retrieveal. Do not expand
-		 * the use of this code path, currently only used by one
-		 * SH board.
-		 */
-		unsigned long flags = GPIOF_DIR_OUT;
-
-		gbl->fbdev = pdata->fbdev;
-		gbl->def_value = pdata->def_value;
-		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
-
-		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
-					    pdata ? pdata->name : "backlight");
-		if (ret < 0) {
-			dev_err(&pdev->dev, "unable to request GPIO\n");
-			return ret;
-		}
-		gbl->gpiod = gpio_to_desc(pdata->gpio);
-		if (!gbl->gpiod)
-			return -EINVAL;
+	def_value = device_property_read_bool(dev, "default-on");
+	gbl->gpiod = devm_gpiod_get(dev, NULL,
+				    def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+	if (IS_ERR(gbl->gpiod)) {
+		ret = PTR_ERR(gbl->gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "unable to request GPIO: %d\n", ret);
+		return ret;
 	}
 
 	memset(&props, 0, sizeof(props));
@@ -134,7 +77,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.brightness = def_value;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
diff --git a/include/linux/platform_data/gpio_backlight.h b/include/linux/platform_data/gpio_backlight.h
deleted file mode 100644
index 683d90453c419..0000000000000
--- a/include/linux/platform_data/gpio_backlight.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * gpio_backlight.h - Simple GPIO-controlled backlight
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __GPIO_BACKLIGHT_H__
-#define __GPIO_BACKLIGHT_H__
-
-struct device;
-
-struct gpio_backlight_platform_data {
-	struct device *fbdev;
-	int gpio;
-	int def_value;
-	const char *name;
-};
-
-#endif
-- 
2.16.2.804.g6dcf76e118-goog

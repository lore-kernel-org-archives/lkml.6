Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeCOWmN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:42:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36108 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932641AbeCOWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:07 -0400
X-Google-Smtp-Source: AG47ELvR4jjVarhJCgEc2P3zZOKU2EjLV8/vVApm364I6QrdpqCTHV86QUAQU7lvpezlMOFSPlvVYQ==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC 1/4] backlight: gpio_backlight: use generic device properties
Date: Thu, 15 Mar 2018 15:41:59 -0700
Message-Id: <20180315224202.96668-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using of_property_read_bool() switch to using
device_property_read_bool() This will allow switching from platform data to
device properties everywhere.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806f..173fc4aafb89b 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -61,11 +61,10 @@ static int gpio_backlight_probe_dt(struct platform_device *pdev,
 				   struct gpio_backlight *gbl)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	enum gpiod_flags flags;
 	int ret;
 
-	gbl->def_value = of_property_read_bool(np, "default-on");
+	gbl->def_value = device_property_read_bool(dev, "default-on");
 	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
 	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
@@ -89,22 +88,15 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (!pdata && !np) {
-		dev_err(&pdev->dev,
-			"failed to find platform data or device tree node.\n");
-		return -ENODEV;
-	}
-
 	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
 		return -ENOMEM;
 
 	gbl->dev = &pdev->dev;
 
-	if (np) {
+	if (!pdata) {
 		ret = gpio_backlight_probe_dt(pdev, gbl);
 		if (ret)
 			return ret;
-- 
2.16.2.804.g6dcf76e118-goog

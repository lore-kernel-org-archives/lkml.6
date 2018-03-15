Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeCOWmO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:42:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33425 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeCOWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:11 -0400
X-Google-Smtp-Source: AG47ELunN8MTk3YDrSrrt0kHkYNCJOkWszANYtjNzOqMxFiDIBR/jg+e2Qp2UWK9gA2/ieqH0L316A==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC 3/4] sh: ecovec24: convert backlight to use device properties
Date: Thu, 15 Mar 2018 15:42:01 -0700
Message-Id: <20180315224202.96668-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of backlight legacy platform data, let's switch to using device
properties and GPIO lookup tables.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 67633d2d42390..ad3d48b3ead19 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -11,11 +11,13 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -30,7 +32,6 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
-#include <linux/platform_data/gpio_backlight.h>
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/videodev2.h>
@@ -367,17 +368,21 @@ static struct platform_device lcdc_device = {
 	},
 };
 
-static struct gpio_backlight_platform_data gpio_backlight_data = {
-	.gpio = GPIO_PTR1,
-	.def_value = 1,
-	.name = "backlight",
+static struct gpiod_lookup_table gpio_backlight_gpios_table = {
+	.dev_id = "gpio-backlight.0",
+	.table = {
+		GPIO_LOOKUP_IDX("sh7724_pfc", GPIO_PTR1, NULL, 0, GPIO_ACTIVE_HIGH);
+		{ }
+	},
+};
+
+static struct property_entry gpio_backlight_properties[] = {
+	PROPERTY_ENTRY_BOOL("default-on"),
+	{ }
 };
 
 static struct platform_device gpio_backlight_device = {
 	.name = "gpio-backlight",
-	.dev = {
-		.platform_data = &gpio_backlight_data,
-	},
 };
 
 /* CEU0 */
@@ -1436,6 +1441,8 @@ static int __init arch_setup(void)
 		return error;
 
 	if (use_backlight) {
+		device_add_properties(&gpio_backlight_device.dev,
+				      gpio_backlight_properties);
 		error = platform_device_add(&gpio_backlight_device);
 		if (error)
 			pr_warn("%s: failed to register backlight: %d\n",
-- 
2.16.2.804.g6dcf76e118-goog

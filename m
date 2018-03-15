Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeCOWnE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:43:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45144 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932666AbeCOWmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:09 -0400
X-Google-Smtp-Source: AG47ELtB0vMT+LrfiX1Q85/ksyCaoHewMtdf9dmd2qrw7tmHd5aaQ3fKE4IocEfGKX2LFE2cVsBxSg==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC 2/4] sh: ecovec24: conditionally register backlight device
Date: Thu, 15 Mar 2018 15:42:00 -0700
Message-Id: <20180315224202.96668-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fe79f919f47e ("sh: ecovec24: Use gpio-backlight") removed custom
backlight support and switched over to generic gpio-backlight driver. The
comment when we run with DVI states "no backlight", but setting
gpio_backlight_data.fbdev to NULL actually makes gpio-backlight to react to
events from any framebuffer device, not ignore them.

We want to get rid of platform data in favor of generic device properties
in gpio_backlight driver, so we can not have kernel pointers passed around
to tie the framebuffer device to backlight. Assuming that the intent of the
above referenced commit was to indeed not export backlight when using DVI,
let's switch to conditionally registering backlight device so it is not
present at all in DVI case.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-ecovec24/setup.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6f929abe0b50f..67633d2d42390 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -368,7 +368,6 @@ static struct platform_device lcdc_device = {
 };
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
-	.fbdev = &lcdc_device.dev,
 	.gpio = GPIO_PTR1,
 	.def_value = 1,
 	.name = "backlight",
@@ -987,7 +986,6 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb1_common_device,
 	&usbhs_device,
 	&lcdc_device,
-	&gpio_backlight_device,
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
@@ -1077,6 +1075,8 @@ static int __init arch_setup(void)
 {
 	struct clk *clk;
 	bool cn12_enabled = false;
+	bool use_backlight = false;
+	int error;
 
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
@@ -1193,9 +1193,6 @@ static int __init arch_setup(void)
 		lcdc_info.ch[0].lcd_modes		= ecovec_dvi_modes;
 		lcdc_info.ch[0].num_modes		= ARRAY_SIZE(ecovec_dvi_modes);
 
-		/* No backlight */
-		gpio_backlight_data.fbdev = NULL;
-
 		gpio_set_value(GPIO_PTA2, 1);
 		gpio_set_value(GPIO_PTU1, 1);
 	} else {
@@ -1217,6 +1214,8 @@ static int __init arch_setup(void)
 		/* enable TouchScreen */
 		i2c_register_board_info(0, &ts_i2c_clients, 1);
 		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
+
+		use_backlight = true;
 	}
 
 	/* enable CEU0 */
@@ -1431,8 +1430,19 @@ static int __init arch_setup(void)
 	gpio_set_value(GPIO_PTG4, 1);
 #endif
 
-	return platform_add_devices(ecovec_devices,
-				    ARRAY_SIZE(ecovec_devices));
+	error = platform_add_devices(ecovec_devices,
+				      ARRAY_SIZE(ecovec_devices));
+	if (error)
+		return error;
+
+	if (use_backlight) {
+		error = platform_device_add(&gpio_backlight_device);
+		if (error)
+			pr_warn("%s: failed to register backlight: %d\n",
+				error);
+	}
+
+	return 0;
 }
 arch_initcall(arch_setup);
 
-- 
2.16.2.804.g6dcf76e118-goog

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeB0VPy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:15:54 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41894 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbeB0VPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:15:50 -0500
X-Google-Smtp-Source: AG47ELveXtuvEeixkdJ8l4HgEbTUO+RsREjyvIyXnm0CE7iKDJjk3VgX0x2KI6oB4NcEVIjmJbg0jQ==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] platform/x86: fujitsu-laptop: Define constants for FUNC features
Date: Tue, 27 Feb 2018 22:15:34 +0100
Message-Id: <20180227211539.5708-3-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227211539.5708-1-kernel@kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various functions exposed by the firmware through the FUNC interface
allow operations to be performed on certain features.  Make sure these
features are referred to by consistently named constants instead of
integers in order to better convey the intent of each call_fext_func()
invocation.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 53 +++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 74775caeb609..087b5d1f2f4a 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -103,15 +103,18 @@
 /* FUNC interface - LED control */
 #define FUNC_LED_OFF			BIT(0)
 #define FUNC_LED_ON			(BIT(0) | BIT(16) | BIT(17))
-#define LOGOLAMP_POWERON		BIT(13)
-#define LOGOLAMP_ALWAYS			BIT(14)
-#define KEYBOARD_LAMPS			BIT(8)
+#define FEAT_LOGOLAMP_POWERON		BIT(13)
+#define FEAT_LOGOLAMP_ALWAYS		BIT(14)
+#define FEAT_KEYBOARD_LAMPS		BIT(8)
+
+#define FEAT_RADIO_LED			BIT(5)
 #define RADIO_LED_ON			BIT(5)
-#define ECO_LED				BIT(16)
+
+#define FEAT_ECO_LED			BIT(16)
 #define ECO_LED_ON			BIT(19)
 
 /* FUNC interface - backlight power control */
-#define BACKLIGHT_PARAM_POWER		BIT(2)
+#define FEAT_BACKLIGHT_POWER		BIT(2)
 #define BACKLIGHT_OFF			(BIT(0) | BIT(1))
 #define BACKLIGHT_ON			0
 
@@ -273,10 +276,10 @@ static int bl_update_status(struct backlight_device *b)
 	if (fext) {
 		if (b->props.power == FB_BLANK_POWERDOWN)
 			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       BACKLIGHT_PARAM_POWER, BACKLIGHT_OFF);
+				       FEAT_BACKLIGHT_POWER, BACKLIGHT_OFF);
 		else
 			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       BACKLIGHT_PARAM_POWER, BACKLIGHT_ON);
+				       FEAT_BACKLIGHT_POWER, BACKLIGHT_ON);
 	}
 
 	return set_lcd_level(device, b->props.brightness);
@@ -606,12 +609,12 @@ static int logolamp_set(struct led_classdev *cdev,
 		always = FUNC_LED_OFF;
 
 	ret = call_fext_func(device, FUNC_LEDS, OP_SET,
-			     LOGOLAMP_POWERON, poweron);
+			     FEAT_LOGOLAMP_POWERON, poweron);
 	if (ret < 0)
 		return ret;
 
 	return call_fext_func(device, FUNC_LEDS, OP_SET,
-			      LOGOLAMP_ALWAYS, always);
+			      FEAT_LOGOLAMP_ALWAYS, always);
 }
 
 static enum led_brightness logolamp_get(struct led_classdev *cdev)
@@ -619,11 +622,13 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int ret;
 
-	ret = call_fext_func(device, FUNC_LEDS, OP_GET, LOGOLAMP_ALWAYS, 0x0);
+	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
+			     FEAT_LOGOLAMP_ALWAYS, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_FULL;
 
-	ret = call_fext_func(device, FUNC_LEDS, OP_GET, LOGOLAMP_POWERON, 0x0);
+	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
+			     FEAT_LOGOLAMP_POWERON, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_HALF;
 
@@ -637,10 +642,10 @@ static int kblamps_set(struct led_classdev *cdev,
 
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      KEYBOARD_LAMPS, FUNC_LED_ON);
+				      FEAT_KEYBOARD_LAMPS, FUNC_LED_ON);
 	else
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      KEYBOARD_LAMPS, FUNC_LED_OFF);
+				      FEAT_KEYBOARD_LAMPS, FUNC_LED_OFF);
 }
 
 static enum led_brightness kblamps_get(struct led_classdev *cdev)
@@ -649,7 +654,7 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 	enum led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
+			   FEAT_KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -662,10 +667,10 @@ static int radio_led_set(struct led_classdev *cdev,
 
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      RADIO_LED_ON, RADIO_LED_ON);
+				      FEAT_RADIO_LED, RADIO_LED_ON);
 	else
 		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      RADIO_LED_ON, 0x0);
+				      FEAT_RADIO_LED, 0x0);
 }
 
 static enum led_brightness radio_led_get(struct led_classdev *cdev)
@@ -686,13 +691,13 @@ static int eco_led_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int curr;
 
-	curr = call_fext_func(device, FUNC_LEDS, OP_GET, ECO_LED, 0x0);
+	curr = call_fext_func(device, FUNC_LEDS, OP_GET, FEAT_ECO_LED, 0x0);
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      ECO_LED, curr | ECO_LED_ON);
+				      FEAT_ECO_LED, curr | ECO_LED_ON);
 	else
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      ECO_LED, curr & ~ECO_LED_ON);
+				      FEAT_ECO_LED, curr & ~ECO_LED_ON);
 }
 
 static enum led_brightness eco_led_get(struct led_classdev *cdev)
@@ -701,7 +706,7 @@ static enum led_brightness eco_led_get(struct led_classdev *cdev)
 	enum led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   ECO_LED, 0x0) & ECO_LED_ON)
+			   FEAT_ECO_LED, 0x0) & ECO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -714,7 +719,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	int ret;
 
 	if (call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
-			   0x0, 0x0) & LOGOLAMP_POWERON) {
+			   0x0, 0x0) & FEAT_LOGOLAMP_POWERON) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -728,7 +733,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	}
 
 	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
-			    0x0, 0x0) & KEYBOARD_LAMPS) &&
+			    0x0, 0x0) & FEAT_KEYBOARD_LAMPS) &&
 	    (call_fext_func(device, FUNC_BUTTONS, OP_GET_CAPS,
 			    0x0, 0x0) == 0x0)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
@@ -774,7 +779,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
 			    0x0, 0x0) & BIT(14)) &&
 	    (call_fext_func(device, FUNC_LEDS, OP_GET,
-			    ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
+			    FEAT_ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -844,7 +849,7 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		if (call_fext_func(fext, FUNC_BACKLIGHT, OP_GET,
-				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
+				   FEAT_BACKLIGHT_POWER, 0x0) == BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
 			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
-- 
2.16.2

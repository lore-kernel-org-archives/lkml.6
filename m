Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeB0VRZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:17:25 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36192 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeB0VPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:15:52 -0500
X-Google-Smtp-Source: AG47ELvvSFwEdLFLITiiVRfuUfXv9HBz4iAeR5bQZTHBMIFtA3kcMxTKq5PGIyUnC8biGNxH2qo2Kw==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] platform/x86: fujitsu-laptop: Define constants for FUNC feature states
Date: Tue, 27 Feb 2018 22:15:35 +0100
Message-Id: <20180227211539.5708-4-kernel@kempniu.pl>
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
allow read/write access to the state of certain features.  Make sure
these states are referred to by consistently named constants instead of
integers in order to better convey the intent of each call_fext_func()
invocation.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 50 +++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 087b5d1f2f4a..3e824e961260 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -101,22 +101,23 @@
 #define FLAG_DOCK			BIT(9)
 
 /* FUNC interface - LED control */
-#define FUNC_LED_OFF			BIT(0)
-#define FUNC_LED_ON			(BIT(0) | BIT(16) | BIT(17))
+#define STATE_LED_OFF			BIT(0)
+#define STATE_LED_ON			(BIT(0) | BIT(16) | BIT(17))
 #define FEAT_LOGOLAMP_POWERON		BIT(13)
 #define FEAT_LOGOLAMP_ALWAYS		BIT(14)
 #define FEAT_KEYBOARD_LAMPS		BIT(8)
 
 #define FEAT_RADIO_LED			BIT(5)
-#define RADIO_LED_ON			BIT(5)
+#define STATE_RADIO_LED_OFF		0
+#define STATE_RADIO_LED_ON		BIT(5)
 
 #define FEAT_ECO_LED			BIT(16)
-#define ECO_LED_ON			BIT(19)
+#define STATE_ECO_LED_ON		BIT(19)
 
 /* FUNC interface - backlight power control */
 #define FEAT_BACKLIGHT_POWER		BIT(2)
-#define BACKLIGHT_OFF			(BIT(0) | BIT(1))
-#define BACKLIGHT_ON			0
+#define STATE_BACKLIGHT_OFF		(BIT(0) | BIT(1))
+#define STATE_BACKLIGHT_ON		0
 
 /* Scancodes read from the GIRB register */
 #define KEY1_CODE			0x410
@@ -276,10 +277,12 @@ static int bl_update_status(struct backlight_device *b)
 	if (fext) {
 		if (b->props.power == FB_BLANK_POWERDOWN)
 			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       FEAT_BACKLIGHT_POWER, BACKLIGHT_OFF);
+				       FEAT_BACKLIGHT_POWER,
+				       STATE_BACKLIGHT_OFF);
 		else
 			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       FEAT_BACKLIGHT_POWER, BACKLIGHT_ON);
+				       FEAT_BACKLIGHT_POWER,
+				       STATE_BACKLIGHT_ON);
 	}
 
 	return set_lcd_level(device, b->props.brightness);
@@ -599,14 +602,14 @@ static int logolamp_set(struct led_classdev *cdev,
 			enum led_brightness brightness)
 {
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
-	int poweron = FUNC_LED_ON, always = FUNC_LED_ON;
+	int poweron = STATE_LED_ON, always = STATE_LED_ON;
 	int ret;
 
 	if (brightness < LED_HALF)
-		poweron = FUNC_LED_OFF;
+		poweron = STATE_LED_OFF;
 
 	if (brightness < LED_FULL)
-		always = FUNC_LED_OFF;
+		always = STATE_LED_OFF;
 
 	ret = call_fext_func(device, FUNC_LEDS, OP_SET,
 			     FEAT_LOGOLAMP_POWERON, poweron);
@@ -624,12 +627,12 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 
 	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
 			     FEAT_LOGOLAMP_ALWAYS, 0x0);
-	if (ret == FUNC_LED_ON)
+	if (ret == STATE_LED_ON)
 		return LED_FULL;
 
 	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
 			     FEAT_LOGOLAMP_POWERON, 0x0);
-	if (ret == FUNC_LED_ON)
+	if (ret == STATE_LED_ON)
 		return LED_HALF;
 
 	return LED_OFF;
@@ -642,10 +645,10 @@ static int kblamps_set(struct led_classdev *cdev,
 
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_KEYBOARD_LAMPS, FUNC_LED_ON);
+				      FEAT_KEYBOARD_LAMPS, STATE_LED_ON);
 	else
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_KEYBOARD_LAMPS, FUNC_LED_OFF);
+				      FEAT_KEYBOARD_LAMPS, STATE_LED_OFF);
 }
 
 static enum led_brightness kblamps_get(struct led_classdev *cdev)
@@ -654,7 +657,7 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 	enum led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   FEAT_KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
+			   FEAT_KEYBOARD_LAMPS, 0x0) == STATE_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -667,10 +670,10 @@ static int radio_led_set(struct led_classdev *cdev,
 
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      FEAT_RADIO_LED, RADIO_LED_ON);
+				      FEAT_RADIO_LED, STATE_RADIO_LED_ON);
 	else
 		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      FEAT_RADIO_LED, 0x0);
+				      FEAT_RADIO_LED, STATE_RADIO_LED_OFF);
 }
 
 static enum led_brightness radio_led_get(struct led_classdev *cdev)
@@ -679,7 +682,7 @@ static enum led_brightness radio_led_get(struct led_classdev *cdev)
 	enum led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_FLAGS, OP_GET_EXT,
-			   0x0, 0x0) & RADIO_LED_ON)
+			   0x0, 0x0) & STATE_RADIO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -694,10 +697,10 @@ static int eco_led_set(struct led_classdev *cdev,
 	curr = call_fext_func(device, FUNC_LEDS, OP_GET, FEAT_ECO_LED, 0x0);
 	if (brightness >= LED_FULL)
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_ECO_LED, curr | ECO_LED_ON);
+				      FEAT_ECO_LED, curr | STATE_ECO_LED_ON);
 	else
 		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_ECO_LED, curr & ~ECO_LED_ON);
+				      FEAT_ECO_LED, curr & ~STATE_ECO_LED_ON);
 }
 
 static enum led_brightness eco_led_get(struct led_classdev *cdev)
@@ -706,7 +709,7 @@ static enum led_brightness eco_led_get(struct led_classdev *cdev)
 	enum led_brightness brightness = LED_OFF;
 
 	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   FEAT_ECO_LED, 0x0) & ECO_LED_ON)
+			   FEAT_ECO_LED, 0x0) & STATE_ECO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -849,7 +852,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		if (call_fext_func(fext, FUNC_BACKLIGHT, OP_GET,
-				   FEAT_BACKLIGHT_POWER, 0x0) == BACKLIGHT_OFF)
+				   FEAT_BACKLIGHT_POWER,
+				   0x0) == STATE_BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
 			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
-- 
2.16.2

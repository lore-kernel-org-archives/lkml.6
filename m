Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeB0VQY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:16:24 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40386 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbeB0VP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:15:56 -0500
X-Google-Smtp-Source: AH8x224e9xk9uNuMtUy8izEDuS7l57oShTYEL8k4M/Gm0ymj/UaotOuSGxXyVz3CilOD4nKvmpvDxA==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] platform/x86: fujitsu-laptop: Introduce fext_*() helper functions
Date: Tue, 27 Feb 2018 22:15:39 +0100
Message-Id: <20180227211539.5708-8-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227211539.5708-1-kernel@kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop invoking call_fext_func() directly to improve code clarity and save
some horizontal space.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 116 +++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 46c9f4441c24..9ac9283fa707 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -184,6 +184,30 @@ static int call_fext_func(struct acpi_device *device,
 	return value;
 }
 
+static int fext_backlight(struct acpi_device *device,
+			  int op, int feature, int state)
+{
+	return call_fext_func(device, FUNC_BACKLIGHT, op, feature, state);
+}
+
+static int fext_buttons(struct acpi_device *device,
+			int op, int feature, int state)
+{
+	return call_fext_func(device, FUNC_BUTTONS, op, feature, state);
+}
+
+static int fext_flags(struct acpi_device *device,
+		      int op, int feature, int state)
+{
+	return call_fext_func(device, FUNC_FLAGS, op, feature, state);
+}
+
+static int fext_leds(struct acpi_device *device,
+		     int op, int feature, int state)
+{
+	return call_fext_func(device, FUNC_LEDS, op, feature, state);
+}
+
 /* Hardware access for LCD brightness control */
 
 static int set_lcd_level(struct acpi_device *device, int level)
@@ -274,12 +298,10 @@ static int bl_update_status(struct backlight_device *b)
 
 	if (fext) {
 		if (b->props.power == FB_BLANK_POWERDOWN)
-			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       FEAT_BACKLIGHT_POWER,
+			fext_backlight(fext, OP_SET, FEAT_BACKLIGHT_POWER,
 				       STATE_BACKLIGHT_OFF);
 		else
-			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
-				       FEAT_BACKLIGHT_POWER,
+			fext_backlight(fext, OP_SET, FEAT_BACKLIGHT_POWER,
 				       STATE_BACKLIGHT_ON);
 	}
 
@@ -609,13 +631,11 @@ static int logolamp_set(struct led_classdev *cdev,
 	if (brightness < LED_FULL)
 		always = STATE_LED_OFF;
 
-	ret = call_fext_func(device, FUNC_LEDS, OP_SET,
-			     FEAT_LOGOLAMP_POWERON, poweron);
+	ret = fext_leds(device, OP_SET, FEAT_LOGOLAMP_POWERON, poweron);
 	if (ret < 0)
 		return ret;
 
-	return call_fext_func(device, FUNC_LEDS, OP_SET,
-			      FEAT_LOGOLAMP_ALWAYS, always);
+	return fext_leds(device, OP_SET, FEAT_LOGOLAMP_ALWAYS, always);
 }
 
 static enum led_brightness logolamp_get(struct led_classdev *cdev)
@@ -623,13 +643,11 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int ret;
 
-	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
-			     FEAT_LOGOLAMP_ALWAYS, 0x0);
+	ret = fext_leds(device, OP_GET, FEAT_LOGOLAMP_ALWAYS, 0x0);
 	if (ret == STATE_LED_ON)
 		return LED_FULL;
 
-	ret = call_fext_func(device, FUNC_LEDS, OP_GET,
-			     FEAT_LOGOLAMP_POWERON, 0x0);
+	ret = fext_leds(device, OP_GET, FEAT_LOGOLAMP_POWERON, 0x0);
 	if (ret == STATE_LED_ON)
 		return LED_HALF;
 
@@ -642,11 +660,11 @@ static int kblamps_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_KEYBOARD_LAMPS, STATE_LED_ON);
+		return fext_leds(device, OP_SET, FEAT_KEYBOARD_LAMPS,
+				 STATE_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_KEYBOARD_LAMPS, STATE_LED_OFF);
+		return fext_leds(device, OP_SET, FEAT_KEYBOARD_LAMPS,
+				 STATE_LED_OFF);
 }
 
 static enum led_brightness kblamps_get(struct led_classdev *cdev)
@@ -654,8 +672,7 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   FEAT_KEYBOARD_LAMPS, 0x0) == STATE_LED_ON)
+	if (fext_leds(device, OP_GET, FEAT_KEYBOARD_LAMPS, 0x0) == STATE_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -667,11 +684,11 @@ static int radio_led_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      FEAT_RADIO_LED, STATE_RADIO_LED_ON);
+		return fext_flags(device, OP_SET_EXT, FEAT_RADIO_LED,
+				  STATE_RADIO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
-				      FEAT_RADIO_LED, STATE_RADIO_LED_OFF);
+		return fext_flags(device, OP_SET_EXT, FEAT_RADIO_LED,
+				  STATE_RADIO_LED_OFF);
 }
 
 static enum led_brightness radio_led_get(struct led_classdev *cdev)
@@ -679,8 +696,7 @@ static enum led_brightness radio_led_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_FLAGS, OP_GET_EXT,
-			   0x0, 0x0) & STATE_RADIO_LED_ON)
+	if (fext_flags(device, OP_GET_EXT, 0x0, 0x0) & STATE_RADIO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -692,13 +708,13 @@ static int eco_led_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int curr;
 
-	curr = call_fext_func(device, FUNC_LEDS, OP_GET, FEAT_ECO_LED, 0x0);
+	curr = fext_leds(device, OP_GET, FEAT_ECO_LED, 0x0);
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_ECO_LED, curr | STATE_ECO_LED_ON);
+		return fext_leds(device, OP_SET, FEAT_ECO_LED,
+				 curr | STATE_ECO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, OP_SET,
-				      FEAT_ECO_LED, curr & ~STATE_ECO_LED_ON);
+		return fext_leds(device, OP_SET, FEAT_ECO_LED,
+				 curr & ~STATE_ECO_LED_ON);
 }
 
 static enum led_brightness eco_led_get(struct led_classdev *cdev)
@@ -706,8 +722,7 @@ static enum led_brightness eco_led_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_LEDS, OP_GET,
-			   FEAT_ECO_LED, 0x0) & STATE_ECO_LED_ON)
+	if (fext_leds(device, OP_GET, FEAT_ECO_LED, 0x0) & STATE_ECO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -719,8 +734,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	struct led_classdev *led;
 	int ret;
 
-	if (call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
-			   0x0, 0x0) & FEAT_LOGOLAMP_POWERON) {
+	if (fext_leds(device, OP_GET_CAPS, 0x0, 0x0) & FEAT_LOGOLAMP_POWERON) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -733,10 +747,8 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 			return ret;
 	}
 
-	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
-			    0x0, 0x0) & FEAT_KEYBOARD_LAMPS) &&
-	    (call_fext_func(device, FUNC_BUTTONS, OP_GET_CAPS,
-			    0x0, 0x0) == 0x0)) {
+	if ((fext_leds(device, OP_GET_CAPS, 0x0, 0x0) & FEAT_KEYBOARD_LAMPS) &&
+	    (fext_buttons(device, OP_GET_CAPS, 0x0, 0x0) == 0x0)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -777,10 +789,8 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	 * bit 14 seems to indicate presence of said led as well.
 	 * Confirm by testing the status.
 	 */
-	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
-			    0x0, 0x0) & BIT(14)) &&
-	    (call_fext_func(device, FUNC_LEDS, OP_GET,
-			    FEAT_ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
+	if ((fext_leds(device, OP_GET_CAPS, 0x0, 0x0) & BIT(14)) &&
+	    (fext_leds(device, OP_GET, FEAT_ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -822,15 +832,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	while (call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
-			      0x0, 0x0) != 0 &&
+	while (fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0) != 0 &&
 	       i++ < HOTKEY_RINGBUFFER_SIZE)
 		; /* No action, result is discarded */
 	acpi_handle_debug(device->handle, "Discarded %i ringbuffer entries\n",
 			  i);
 
-	priv->flags_supported = call_fext_func(device, FUNC_FLAGS, OP_GET_CAPS,
-					       0x0, 0x0);
+	priv->flags_supported = fext_flags(device, OP_GET_CAPS, 0x0, 0x0);
 
 	/* Make sure our bitmask of supported functions is cleared if the
 	   RFKILL function block is not implemented, like on the S7020. */
@@ -838,19 +846,16 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 		priv->flags_supported = 0;
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS,
-						   OP_GET_EXT, 0x0, 0x0);
+		priv->flags_state = fext_flags(device, OP_GET_EXT, 0x0, 0x0);
 
 	/* Suspect this is a keymap of the application panel, print it */
 	acpi_handle_info(device->handle, "BTNI: [0x%x]\n",
-			 call_fext_func(device, FUNC_BUTTONS, OP_GET_CAPS,
-					0x0, 0x0));
+			 fext_buttons(device, OP_GET_CAPS, 0x0, 0x0));
 
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
-		if (call_fext_func(fext, FUNC_BACKLIGHT, OP_GET,
-				   FEAT_BACKLIGHT_POWER,
+		if (fext_backlight(fext, OP_GET, FEAT_BACKLIGHT_POWER,
 				   0x0) == STATE_BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
@@ -935,11 +940,9 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	}
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS,
-						   OP_GET_EXT, 0x0, 0x0);
+		priv->flags_state = fext_flags(device, OP_GET_EXT, 0x0, 0x0);
 
-	while ((irb = call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
-				     0x0, 0x0)) != 0 &&
+	while ((irb = fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0)) != 0 &&
 	       i++ < HOTKEY_RINGBUFFER_SIZE) {
 		scancode = irb & 0x4ff;
 		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
@@ -956,8 +959,7 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	 * handled in software; its state is queried using FUNC_FLAGS
 	 */
 	if ((priv->flags_supported & BIT(26)) &&
-	    (call_fext_func(device, FUNC_FLAGS, OP_GET_EVENTS,
-			    0x0, 0x0) & BIT(26)))
+	    (fext_flags(device, OP_GET_EVENTS, 0x0, 0x0) & BIT(26)))
 		sparse_keymap_report_event(priv->input, BIT(26), 1, true);
 }
 
-- 
2.16.2

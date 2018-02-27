Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeB0VPw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:15:52 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46088 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeB0VPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:15:49 -0500
X-Google-Smtp-Source: AG47ELuDfH9qxgk2CREwkm+i5RXih2lIOnM3EdBSA2UodZRMJNxuWPMSGyctcZBbzXjnwQkJeOz9iA==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for FUNC operations
Date: Tue, 27 Feb 2018 22:15:33 +0100
Message-Id: <20180227211539.5708-2-kernel@kempniu.pl>
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
tend to use a consistent set of integers for denoting the type of
operation to be performed for a specified feature.  Use named constants
instead of integers in each call_fext_func() invocation in order to more
clearly convey the intent of each call.

Note that FUNC_FLAGS is a bit peculiar:

  - operations 0x4 (OP_GET_EXT) and 0x5 (OP_SET_EXT) are used for,
    respectively, getting and setting feature states, instead of 0x2 and
    0x1 used by other FUNC interfaces,

  - operation 0x1 is used for retrieving events (OP_GET_EVENTS).

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 103 ++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 13bcdfea5349..74775caeb609 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -87,6 +87,14 @@
 /* FUNC interface - responses */
 #define UNSUPPORTED_CMD			BIT(31)
 
+/* FUNC interface - operations */
+#define OP_GET				BIT(1)
+#define OP_GET_CAPS			0
+#define OP_GET_EVENTS			BIT(0)
+#define OP_GET_EXT			BIT(2)
+#define OP_SET				BIT(0)
+#define OP_SET_EXT			(BIT(2) | BIT(0))
+
 /* FUNC interface - status flags */
 #define FLAG_RFKILL			BIT(5)
 #define FLAG_LID			BIT(8)
@@ -264,10 +272,10 @@ static int bl_update_status(struct backlight_device *b)
 
 	if (fext) {
 		if (b->props.power == FB_BLANK_POWERDOWN)
-			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
+			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
 				       BACKLIGHT_PARAM_POWER, BACKLIGHT_OFF);
 		else
-			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
+			call_fext_func(fext, FUNC_BACKLIGHT, OP_SET,
 				       BACKLIGHT_PARAM_POWER, BACKLIGHT_ON);
 	}
 
@@ -597,11 +605,13 @@ static int logolamp_set(struct led_classdev *cdev,
 	if (brightness < LED_FULL)
 		always = FUNC_LED_OFF;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_POWERON, poweron);
+	ret = call_fext_func(device, FUNC_LEDS, OP_SET,
+			     LOGOLAMP_POWERON, poweron);
 	if (ret < 0)
 		return ret;
 
-	return call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_ALWAYS, always);
+	return call_fext_func(device, FUNC_LEDS, OP_SET,
+			      LOGOLAMP_ALWAYS, always);
 }
 
 static enum led_brightness logolamp_get(struct led_classdev *cdev)
@@ -609,11 +619,11 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int ret;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_ALWAYS, 0x0);
+	ret = call_fext_func(device, FUNC_LEDS, OP_GET, LOGOLAMP_ALWAYS, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_FULL;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_POWERON, 0x0);
+	ret = call_fext_func(device, FUNC_LEDS, OP_GET, LOGOLAMP_POWERON, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_HALF;
 
@@ -626,11 +636,11 @@ static int kblamps_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
-				      FUNC_LED_ON);
+		return call_fext_func(device, FUNC_LEDS, OP_SET,
+				      KEYBOARD_LAMPS, FUNC_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
-				      FUNC_LED_OFF);
+		return call_fext_func(device, FUNC_LEDS, OP_SET,
+				      KEYBOARD_LAMPS, FUNC_LED_OFF);
 }
 
 static enum led_brightness kblamps_get(struct led_classdev *cdev)
@@ -638,8 +648,8 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device,
-			   FUNC_LEDS, 0x2, KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
+	if (call_fext_func(device, FUNC_LEDS, OP_GET,
+			   KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -651,11 +661,11 @@ static int radio_led_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
-				      RADIO_LED_ON);
+		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
+				      RADIO_LED_ON, RADIO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
-				      0x0);
+		return call_fext_func(device, FUNC_FLAGS, OP_SET_EXT,
+				      RADIO_LED_ON, 0x0);
 }
 
 static enum led_brightness radio_led_get(struct led_classdev *cdev)
@@ -663,7 +673,8 @@ static enum led_brightness radio_led_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
+	if (call_fext_func(device, FUNC_FLAGS, OP_GET_EXT,
+			   0x0, 0x0) & RADIO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -675,13 +686,13 @@ static int eco_led_set(struct led_classdev *cdev,
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	int curr;
 
-	curr = call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0);
+	curr = call_fext_func(device, FUNC_LEDS, OP_GET, ECO_LED, 0x0);
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
-				      curr | ECO_LED_ON);
+		return call_fext_func(device, FUNC_LEDS, OP_SET,
+				      ECO_LED, curr | ECO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
-				      curr & ~ECO_LED_ON);
+		return call_fext_func(device, FUNC_LEDS, OP_SET,
+				      ECO_LED, curr & ~ECO_LED_ON);
 }
 
 static enum led_brightness eco_led_get(struct led_classdev *cdev)
@@ -689,7 +700,8 @@ static enum led_brightness eco_led_get(struct led_classdev *cdev)
 	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
+	if (call_fext_func(device, FUNC_LEDS, OP_GET,
+			   ECO_LED, 0x0) & ECO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -701,8 +713,8 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	struct led_classdev *led;
 	int ret;
 
-	if (call_fext_func(device,
-			   FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
+	if (call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
+			   0x0, 0x0) & LOGOLAMP_POWERON) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -715,9 +727,10 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 			return ret;
 	}
 
-	if ((call_fext_func(device,
-			    FUNC_LEDS, 0x0, 0x0, 0x0) & KEYBOARD_LAMPS) &&
-	    (call_fext_func(device, FUNC_BUTTONS, 0x0, 0x0, 0x0) == 0x0)) {
+	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
+			    0x0, 0x0) & KEYBOARD_LAMPS) &&
+	    (call_fext_func(device, FUNC_BUTTONS, OP_GET_CAPS,
+			    0x0, 0x0) == 0x0)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -758,9 +771,10 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	 * bit 14 seems to indicate presence of said led as well.
 	 * Confirm by testing the status.
 	 */
-	if ((call_fext_func(device, FUNC_LEDS, 0x0, 0x0, 0x0) & BIT(14)) &&
-	    (call_fext_func(device,
-			    FUNC_LEDS, 0x2, ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
+	if ((call_fext_func(device, FUNC_LEDS, OP_GET_CAPS,
+			    0x0, 0x0) & BIT(14)) &&
+	    (call_fext_func(device, FUNC_LEDS, OP_GET,
+			    ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
 		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
@@ -802,14 +816,15 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
+	while (call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
+			      0x0, 0x0) != 0 &&
 	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
 		; /* No action, result is discarded */
 	acpi_handle_debug(device->handle, "Discarded %i ringbuffer entries\n",
 			  i);
 
-	priv->flags_supported = call_fext_func(device, FUNC_FLAGS, 0x0, 0x0,
-					       0x0);
+	priv->flags_supported = call_fext_func(device, FUNC_FLAGS, OP_GET_CAPS,
+					       0x0, 0x0);
 
 	/* Make sure our bitmask of supported functions is cleared if the
 	   RFKILL function block is not implemented, like on the S7020. */
@@ -817,17 +832,18 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 		priv->flags_supported = 0;
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
-						   0x0);
+		priv->flags_state = call_fext_func(device, FUNC_FLAGS,
+						   OP_GET_EXT, 0x0, 0x0);
 
 	/* Suspect this is a keymap of the application panel, print it */
 	acpi_handle_info(device->handle, "BTNI: [0x%x]\n",
-			 call_fext_func(device, FUNC_BUTTONS, 0x0, 0x0, 0x0));
+			 call_fext_func(device, FUNC_BUTTONS, OP_GET_CAPS,
+					0x0, 0x0));
 
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
-		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
+		if (call_fext_func(fext, FUNC_BACKLIGHT, OP_GET,
 				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
 		else
@@ -912,11 +928,11 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	}
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
-						   0x0);
+		priv->flags_state = call_fext_func(device, FUNC_FLAGS,
+						   OP_GET_EXT, 0x0, 0x0);
 
-	while ((irb = call_fext_func(device,
-				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
+	while ((irb = call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
+				     0x0, 0x0)) != 0 &&
 	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
 		scancode = irb & 0x4ff;
 		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
@@ -933,7 +949,8 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	 * handled in software; its state is queried using FUNC_FLAGS
 	 */
 	if ((priv->flags_supported & BIT(26)) &&
-	    (call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0) & BIT(26)))
+	    (call_fext_func(device, FUNC_FLAGS, OP_GET_EVENTS,
+			    0x0, 0x0) & BIT(26)))
 		sparse_keymap_report_event(priv->input, BIT(26), 1, true);
 }
 
-- 
2.16.2

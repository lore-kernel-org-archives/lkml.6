Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCTWdQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:33:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35220 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeCTWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:32:01 -0400
X-Google-Smtp-Source: AG47ELu8gMhc7/qtJGGtzljHusbE8LpdHK+0k1HVOGcOV807iLPtOIqt8bQgftLLW7P9D8r2SNe4gw==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] Input: atmel_mxt_ts - remove platform data support
Date: Tue, 20 Mar 2018 15:31:38 -0700
Message-Id: <20180320223138.234724-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there are no users of custom Atmel platform data, and everyone
has switched to the generic device properties, we can remove support for
the platform data.

Acked-by: Nick Dyer <nick@shmanahar.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 MAINTAINERS                                |   1 -
 drivers/input/touchscreen/atmel_mxt_ts.c   | 130 +++++++++------------
 include/linux/platform_data/atmel_mxt_ts.h |  31 -----
 3 files changed, 55 insertions(+), 107 deletions(-)
 delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 205c8fc12a9c0..4442559713ea4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2394,7 +2394,6 @@ T:	git git://github.com/ndyer/linux.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
-F:	include/linux/platform_data/atmel_mxt_ts.h
 
 ATMEL SAMA5D2 ADC DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 799d2ac35787b..5d9699fe1b55a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -23,10 +23,10 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/atmel_mxt_ts.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/gpio/consumer.h>
 #include <linux/property.h>
@@ -269,12 +269,16 @@ static const struct v4l2_file_operations mxt_video_fops = {
 	.poll = vb2_fop_poll,
 };
 
+enum mxt_suspend_mode {
+	MXT_SUSPEND_DEEP_SLEEP	= 0,
+	MXT_SUSPEND_T9_CTRL	= 1,
+};
+
 /* Each client has this additional data */
 struct mxt_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	char phys[64];		/* device physical location */
-	const struct mxt_platform_data *pdata;
 	struct mxt_object *object_table;
 	struct mxt_info info;
 	unsigned int irq;
@@ -326,6 +330,9 @@ struct mxt_data {
 	/* for config update handling */
 	struct completion crc_completion;
 
+	u32 *t19_keymap;
+	unsigned int t19_num_keys;
+
 	enum mxt_suspend_mode suspend_mode;
 };
 
@@ -745,15 +752,14 @@ static int mxt_write_object(struct mxt_data *data,
 static void mxt_input_button(struct mxt_data *data, u8 *message)
 {
 	struct input_dev *input = data->input_dev;
-	const struct mxt_platform_data *pdata = data->pdata;
 	int i;
 
-	for (i = 0; i < pdata->t19_num_keys; i++) {
-		if (pdata->t19_keymap[i] == KEY_RESERVED)
+	for (i = 0; i < data->t19_num_keys; i++) {
+		if (data->t19_keymap[i] == KEY_RESERVED)
 			continue;
 
 		/* Active-low switch */
-		input_report_key(input, pdata->t19_keymap[i],
+		input_report_key(input, data->t19_keymap[i],
 				 !(message[1] & BIT(i)));
 	}
 }
@@ -761,7 +767,7 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
 static void mxt_input_sync(struct mxt_data *data)
 {
 	input_mt_report_pointer_emulation(data->input_dev,
-					  data->pdata->t19_num_keys);
+					  data->t19_num_keys);
 	input_sync(data->input_dev);
 }
 
@@ -1861,7 +1867,6 @@ static void mxt_input_close(struct input_dev *dev);
 static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
 				   struct mxt_data *data)
 {
-	const struct mxt_platform_data *pdata = data->pdata;
 	int i;
 
 	input_dev->name = "Atmel maXTouch Touchpad";
@@ -1875,15 +1880,14 @@ static void mxt_set_up_as_touchpad(struct input_dev *input_dev,
 	input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
 			  MXT_PIXELS_PER_MM);
 
-	for (i = 0; i < pdata->t19_num_keys; i++)
-		if (pdata->t19_keymap[i] != KEY_RESERVED)
+	for (i = 0; i < data->t19_num_keys; i++)
+		if (data->t19_keymap[i] != KEY_RESERVED)
 			input_set_capability(input_dev, EV_KEY,
-					     pdata->t19_keymap[i]);
+					     data->t19_keymap[i]);
 }
 
 static int mxt_initialize_input_device(struct mxt_data *data)
 {
-	const struct mxt_platform_data *pdata = data->pdata;
 	struct device *dev = &data->client->dev;
 	struct input_dev *input_dev;
 	int error;
@@ -1949,7 +1953,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	}
 
 	/* If device has buttons we assume it is a touchpad */
-	if (pdata->t19_num_keys) {
+	if (data->t19_num_keys) {
 		mxt_set_up_as_touchpad(input_dev, data);
 		mt_flags |= INPUT_MT_POINTER;
 	} else {
@@ -2923,51 +2927,42 @@ static void mxt_input_close(struct input_dev *dev)
 	mxt_stop(data);
 }
 
-static const struct mxt_platform_data *
-mxt_parse_device_properties(struct i2c_client *client)
+static int mxt_parse_device_properties(struct mxt_data *data)
 {
 	static const char keymap_property[] = "linux,gpio-keymap";
-	struct mxt_platform_data *pdata;
+	struct device *dev = &data->client->dev;
 	u32 *keymap;
 	int n_keys;
 	int error;
 
-	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	if (device_property_present(&client->dev, keymap_property)) {
-		n_keys = device_property_read_u32_array(&client->dev,
-							keymap_property,
+	if (device_property_present(dev, keymap_property)) {
+		n_keys = device_property_read_u32_array(dev, keymap_property,
 							NULL, 0);
 		if (n_keys <= 0) {
 			error = n_keys < 0 ? n_keys : -EINVAL;
-			dev_err(&client->dev,
-				"invalid/malformed '%s' property: %d\n",
+			dev_err(dev, "invalid/malformed '%s' property: %d\n",
 				keymap_property, error);
-			return ERR_PTR(error);
+			return error;
 		}
 
-		keymap = devm_kmalloc_array(&client->dev, n_keys, sizeof(u32),
+		keymap = devm_kmalloc_array(dev, n_keys, sizeof(*keymap),
 					    GFP_KERNEL);
 		if (!keymap)
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 
-		error = device_property_read_u32_array(&client->dev,
-						       keymap_property,
+		error = device_property_read_u32_array(dev, keymap_property,
 						       keymap, n_keys);
 		if (error) {
-			dev_err(&client->dev,
-				"failed to parse '%s' property: %d\n",
+			dev_err(dev, "failed to parse '%s' property: %d\n",
 				keymap_property, error);
-			return ERR_PTR(error);
+			return error;
 		}
 
-		pdata->t19_keymap = keymap;
-		pdata->t19_num_keys = n_keys;
+		data->t19_keymap = keymap;
+		data->t19_num_keys = n_keys;
 	}
 
-	return pdata;
+	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -3050,25 +3045,12 @@ static const struct dmi_system_id mxt_dmi_table[] = {
 	{ }
 };
 
-static int mxt_acpi_probe(struct i2c_client *client)
+static int mxt_prepare_acpi_properties(struct i2c_client *client)
 {
 	struct acpi_device *adev;
 	const struct dmi_system_id *system_id;
 	const struct mxt_acpi_platform_data *acpi_pdata;
 
-	/*
-	 * Ignore ACPI devices representing bootloader mode.
-	 *
-	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
-	 * devices for both application and bootloader modes, but we are
-	 * interested in application mode only (if device is in bootloader
-	 * mode we'll end up switching into application anyway). So far
-	 * application mode addresses were all above 0x40, so we'll use it
-	 * as a threshold.
-	 */
-	if (client->addr < 0x40)
-		return -ENXIO;
-
 	adev = ACPI_COMPANION(&client->dev);
 	if (!adev)
 		return -ENOENT;
@@ -3104,24 +3086,12 @@ static int mxt_acpi_probe(struct i2c_client *client)
 	return 0;
 }
 #else
-static int mxt_acpi_probe(struct i2c_client *client)
+static int mxt_prepare_acpi_properties(struct i2c_client *client)
 {
 	return -ENOENT;
 }
 #endif
 
-static const struct mxt_platform_data *
-mxt_get_platform_data(struct i2c_client *client)
-{
-	const struct mxt_platform_data *pdata;
-
-	pdata = dev_get_platdata(&client->dev);
-	if (pdata)
-		return pdata;
-
-	return mxt_parse_device_properties(client);
-}
-
 static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 	{
 		.matches = {
@@ -3140,16 +3110,20 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mxt_data *data;
-	const struct mxt_platform_data *pdata;
 	int error;
 
-	error = mxt_acpi_probe(client);
-	if (error && error != -ENOENT)
-		return error;
-
-	pdata = mxt_get_platform_data(client);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
+	/*
+	 * Ignore ACPI devices representing bootloader mode.
+	 *
+	 * This is a bit of a hack: Google Chromebook BIOS creates ACPI
+	 * devices for both application and bootloader modes, but we are
+	 * interested in application mode only (if device is in bootloader
+	 * mode we'll end up switching into application anyway). So far
+	 * application mode addresses were all above 0x40, so we'll use it
+	 * as a threshold.
+	 */
+	if (ACPI_COMPANION(&client->dev) && client->addr < 0x40)
+		return -ENXIO;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct mxt_data), GFP_KERNEL);
 	if (!data)
@@ -3159,7 +3133,6 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 client->adapter->nr, client->addr);
 
 	data->client = client;
-	data->pdata = pdata;
 	data->irq = client->irq;
 	i2c_set_clientdata(client, data);
 
@@ -3170,6 +3143,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	data->suspend_mode = dmi_check_system(chromebook_T9_suspend_dmi) ?
 		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
 
+	error = mxt_prepare_acpi_properties(client);
+	if (error && error != -ENOENT)
+		return error;
+
+	error = mxt_parse_device_properties(data);
+	if (error)
+		return error;
+
 	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						   "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(data->reset_gpio)) {
@@ -3179,8 +3160,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, mxt_interrupt,
-					  pdata->irqflags | IRQF_ONESHOT,
+					  NULL, mxt_interrupt, IRQF_ONESHOT,
 					  client->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
@@ -3300,7 +3280,7 @@ MODULE_DEVICE_TABLE(i2c, mxt_id);
 static struct i2c_driver mxt_driver = {
 	.driver = {
 		.name	= "atmel_mxt_ts",
-		.of_match_table = of_match_ptr(mxt_of_match),
+		.of_match_table = mxt_of_match,
 		.acpi_match_table = ACPI_PTR(mxt_acpi_id),
 		.pm	= &mxt_pm_ops,
 	},
diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
deleted file mode 100644
index 695035a8d7fb9..0000000000000
--- a/include/linux/platform_data/atmel_mxt_ts.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Atmel maXTouch Touchscreen driver
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
-#define __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H
-
-#include <linux/types.h>
-
-enum mxt_suspend_mode {
-	MXT_SUSPEND_DEEP_SLEEP	= 0,
-	MXT_SUSPEND_T9_CTRL	= 1,
-};
-
-/* The platform data for the Atmel maXTouch touchscreen driver */
-struct mxt_platform_data {
-	unsigned long irqflags;
-	u8 t19_num_keys;
-	const unsigned int *t19_keymap;
-	enum mxt_suspend_mode suspend_mode;
-};
-
-#endif /* __LINUX_PLATFORM_DATA_ATMEL_MXT_TS_H */
-- 
2.16.2.804.g6dcf76e118-goog

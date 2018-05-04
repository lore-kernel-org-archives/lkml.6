Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEDAlp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:41:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35938 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeEDAlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:41:42 -0400
X-Google-Smtp-Source: AB8JxZpjixSi9HUB7K35o3p68qE/FwttfhIKe8IKiUM6y9mCKi03F3TlKYdcr+Vc90Me0T1dyb3jyA==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: atmel_mxt_ts - require device properties present when probing
Date: Thu,  3 May 2018 17:41:35 -0700
Message-Id: <20180504004135.67554-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180504004135.67554-1-dmitry.torokhov@gmail.com>
References: <20180504004135.67554-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver needs help determining whether it is dealing with a touchscreen
or a touchpad, and with button mapping. Previously we supported passing
this data via device properties, and also had DMI lists for Chromebooks
that specified Atmel devices in ACPI, but did not provide enough data
there. Now that chromeos_laptop driver is adjusted to supply necessary
device properties even for ACPI devices, we can drop the DMI tables and
refuse to probe if device properties are not attached to the device.

We use presence of "compatible" property to determine if device properties
are attached to the device or not and rely on chromeos_laptop to re-probe
the device after attaching missing device properties to it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 152 ++---------------------
 1 file changed, 12 insertions(+), 140 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 09194721aed2d..4ac49c6c00060 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2999,142 +2999,6 @@ static int mxt_parse_device_properties(struct mxt_data *data)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-
-struct mxt_acpi_platform_data {
-	const char *hid;
-	const struct property_entry *props;
-};
-
-static unsigned int samus_touchpad_buttons[] = {
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	BTN_LEFT
-};
-
-static const struct property_entry samus_touchpad_props[] = {
-	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", samus_touchpad_buttons),
-	{ }
-};
-
-static struct mxt_acpi_platform_data samus_platform_data[] = {
-	{
-		/* Touchpad */
-		.hid	= "ATML0000",
-		.props	= samus_touchpad_props,
-	},
-	{
-		/* Touchscreen */
-		.hid	= "ATML0001",
-	},
-	{ }
-};
-
-static unsigned int chromebook_tp_buttons[] = {
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	BTN_LEFT
-};
-
-static const struct property_entry chromebook_tp_props[] = {
-	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_tp_buttons),
-	{ }
-};
-
-static struct mxt_acpi_platform_data chromebook_platform_data[] = {
-	{
-		/* Touchpad */
-		.hid	= "ATML0000",
-		.props	= chromebook_tp_props,
-	},
-	{
-		/* Touchscreen */
-		.hid	= "ATML0001",
-	},
-	{ }
-};
-
-static const struct dmi_system_id mxt_dmi_table[] = {
-	{
-		/* 2015 Google Pixel */
-		.ident = "Chromebook Pixel 2",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Samus"),
-		},
-		.driver_data = samus_platform_data,
-	},
-	{
-		/* Samsung Chromebook Pro */
-		.ident = "Samsung Chromebook Pro",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
-		},
-		.driver_data = samus_platform_data,
-	},
-	{
-		/* Other Google Chromebooks */
-		.ident = "Chromebook",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
-		},
-		.driver_data = chromebook_platform_data,
-	},
-	{ }
-};
-
-static int mxt_prepare_acpi_properties(struct i2c_client *client)
-{
-	struct acpi_device *adev;
-	const struct dmi_system_id *system_id;
-	const struct mxt_acpi_platform_data *acpi_pdata;
-
-	adev = ACPI_COMPANION(&client->dev);
-	if (!adev)
-		return -ENOENT;
-
-	system_id = dmi_first_match(mxt_dmi_table);
-	if (!system_id)
-		return -ENOENT;
-
-	acpi_pdata = system_id->driver_data;
-	if (!acpi_pdata)
-		return -ENOENT;
-
-	while (acpi_pdata->hid) {
-		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid)) {
-			/*
-			 * Remove previously installed properties if we
-			 * are probing this device not for the very first
-			 * time.
-			 */
-			device_remove_properties(&client->dev);
-
-			/*
-			 * Now install the platform-specific properties
-			 * that are missing from ACPI.
-			 */
-			device_add_properties(&client->dev, acpi_pdata->props);
-			break;
-		}
-
-		acpi_pdata++;
-	}
-
-	return 0;
-}
-#else
-static int mxt_prepare_acpi_properties(struct i2c_client *client)
-{
-	return -ENOENT;
-}
-#endif
-
 static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
 	{
 		.matches = {
@@ -3155,6 +3019,18 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct mxt_data *data;
 	int error;
 
+	/*
+	 * Ignore devices that do not have device properties attached to
+	 * them, as we need help determining whether we are dealing with
+	 * touch screen or touchpad.
+	 *
+	 * So far on x86 the only users of Atmel touch controllers are
+	 * Chromebooks, and chromeos_laptop driver will ensure that
+	 * necessary properties are provided (if firmware does not do that).
+	 */
+	if (!device_property_present(&client->dev, "compatible"))
+		return -ENXIO;
+
 	/*
 	 * Ignore ACPI devices representing bootloader mode.
 	 *
@@ -3186,10 +3062,6 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	data->suspend_mode = dmi_check_system(chromebook_T9_suspend_dmi) ?
 		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
 
-	error = mxt_prepare_acpi_properties(client);
-	if (error && error != -ENOENT)
-		return error;
-
 	error = mxt_parse_device_properties(data);
 	if (error)
 		return error;
-- 
2.17.0.441.gb46fe60e1d-goog

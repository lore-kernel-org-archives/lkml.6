Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeCTWeD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:34:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33337 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCTWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:55 -0400
X-Google-Smtp-Source: AG47ELvINWvvHGwSqX3z1N9umTWAbK/PfSOxG+tW0lvulkz9K95Kqng0U+7iY7gsqYEXnAhriMfkRA==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] platform/chrome: chromeos_laptop - parse DMI IRQ data once
Date: Tue, 20 Mar 2018 15:31:33 -0700
Message-Id: <20180320223138.234724-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to parse DMI IRQ data every time we try to instantiate a
device, let's do it once, when we identify the device we are working with.
This allows us to mark chromeos_laptop_get_irq_from_dmi() as __init and
discard it once module is initialized.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 120 ++++++++++++----------
 1 file changed, 64 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 2a81ae4c15c93..d6d2bc6f3aaf0 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -68,26 +68,6 @@ struct chromeos_laptop {
 
 static struct chromeos_laptop *cros_laptop;
 
-static int chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
-{
-	const struct dmi_device *dmi_dev;
-	const struct dmi_dev_onboard *dev_data;
-
-	dmi_dev = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, dmi_name, NULL);
-	if (!dmi_dev) {
-		pr_err("failed to find DMI device '%s'\n", dmi_name);
-		return -ENOENT;
-	}
-
-	dev_data = dmi_dev->device_data;
-	if (!dev_data) {
-		pr_err("failed to get data from DMI for '%s'\n", dmi_name);
-		return -EINVAL;
-	}
-
-	return dev_data->instance;
-}
-
 static struct i2c_client *
 chromes_laptop_instantiate_i2c_device(int bus,
 				      struct i2c_board_info *info,
@@ -185,7 +165,6 @@ static int chromeos_laptop_add_peripheral(struct i2c_peripheral *i2c_dev)
 {
 	struct i2c_client *client;
 	int bus;
-	int irq;
 
 	/*
 	 * Check that the i2c adapter is present.
@@ -196,16 +175,6 @@ static int chromeos_laptop_add_peripheral(struct i2c_peripheral *i2c_dev)
 	if (bus < 0)
 		return bus == -ENODEV ? -EPROBE_DEFER : bus;
 
-	if (i2c_dev->dmi_name) {
-		irq = chromeos_laptop_get_irq_from_dmi(i2c_dev->dmi_name);
-		if (irq < 0) {
-			i2c_dev->state = FAILED;
-			return irq;
-		}
-
-		i2c_dev->board_info.irq = irq;
-	}
-
 	client = chromes_laptop_instantiate_i2c_device(bus,
 						       &i2c_dev->board_info,
 						       i2c_dev->alt_addr);
@@ -230,15 +199,6 @@ static int chromeos_laptop_add_peripheral(struct i2c_peripheral *i2c_dev)
 	return 0;
 }
 
-static int __init chromeos_laptop_dmi_matched(const struct dmi_system_id *id)
-{
-	cros_laptop = (void *)id->driver_data;
-	pr_debug("DMI Matched %s\n", id->ident);
-
-	/* Indicate to dmi_scan that processing is done. */
-	return 1;
-}
-
 static int chromeos_laptop_probe(struct platform_device *pdev)
 {
 	struct i2c_peripheral *i2c_dev;
@@ -499,10 +459,6 @@ static struct chromeos_laptop cr48 = {
 	},
 };
 
-#define _CBDD(board_) \
-	.callback = chromeos_laptop_dmi_matched, \
-	.driver_data = (void *)&board_
-
 static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 	{
 		.ident = "Samsung Series 5 550",
@@ -510,14 +466,14 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lumpy"),
 		},
-		_CBDD(samsung_series_5_550),
+		.driver_data = (void *)&samsung_series_5_550,
 	},
 	{
 		.ident = "Samsung Series 5",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alex"),
 		},
-		_CBDD(samsung_series_5),
+		.driver_data = (void *)&samsung_series_5,
 	},
 	{
 		.ident = "Chromebook Pixel",
@@ -525,7 +481,7 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Link"),
 		},
-		_CBDD(chromebook_pixel),
+		.driver_data = (void *)&chromebook_pixel,
 	},
 	{
 		.ident = "Wolf",
@@ -533,7 +489,7 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Wolf"),
 		},
-		_CBDD(dell_chromebook_11),
+		.driver_data = (void *)&dell_chromebook_11,
 	},
 	{
 		.ident = "HP Chromebook 14",
@@ -541,7 +497,7 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Falco"),
 		},
-		_CBDD(hp_chromebook_14),
+		.driver_data = (void *)&hp_chromebook_14,
 	},
 	{
 		.ident = "Toshiba CB35",
@@ -549,42 +505,42 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Leon"),
 		},
-		_CBDD(toshiba_cb35),
+		.driver_data = (void *)&toshiba_cb35,
 	},
 	{
 		.ident = "Acer C7 Chromebook",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Parrot"),
 		},
-		_CBDD(acer_c7_chromebook),
+		.driver_data = (void *)&acer_c7_chromebook,
 	},
 	{
 		.ident = "Acer AC700",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ZGB"),
 		},
-		_CBDD(acer_ac700),
+		.driver_data = (void *)&acer_ac700,
 	},
 	{
 		.ident = "Acer C720",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Peppy"),
 		},
-		_CBDD(acer_c720),
+		.driver_data = (void *)&acer_c720,
 	},
 	{
 		.ident = "HP Pavilion 14 Chromebook",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Butterfly"),
 		},
-		_CBDD(hp_pavilion_14_chromebook),
+		.driver_data = (void *)&hp_pavilion_14_chromebook,
 	},
 	{
 		.ident = "Cr-48",
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Mario"),
 		},
-		_CBDD(cr48),
+		.driver_data = (void *)&cr48,
 	},
 	{ }
 };
@@ -599,15 +555,67 @@ static struct platform_driver cros_platform_driver = {
 	.probe = chromeos_laptop_probe,
 };
 
+static int __init chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
+{
+	const struct dmi_device *dmi_dev;
+	const struct dmi_dev_onboard *dev_data;
+
+	dmi_dev = dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD, dmi_name, NULL);
+	if (!dmi_dev) {
+		pr_err("failed to find DMI device '%s'\n", dmi_name);
+		return -ENOENT;
+	}
+
+	dev_data = dmi_dev->device_data;
+	if (!dev_data) {
+		pr_err("failed to get data from DMI for '%s'\n", dmi_name);
+		return -EINVAL;
+	}
+
+	return dev_data->instance;
+}
+
+static struct chromeos_laptop * __init
+chromeos_laptop_prepare(const struct dmi_system_id *id)
+{
+	struct i2c_peripheral *i2c_dev;
+	int irq;
+	int i;
+
+	cros_laptop = (void *)id->driver_data;
+
+	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
+
+		if (!i2c_dev->dmi_name)
+			continue;
+
+		irq = chromeos_laptop_get_irq_from_dmi(i2c_dev->dmi_name);
+		if (irq < 0)
+			return ERR_PTR(irq);
+	}
+
+	return cros_laptop;
+}
+
+
 static int __init chromeos_laptop_init(void)
 {
+	const struct dmi_system_id *dmi_id;
 	int ret;
 
-	if (!dmi_check_system(chromeos_laptop_dmi_table)) {
+	dmi_id = dmi_first_match(chromeos_laptop_dmi_table);
+	if (!dmi_id) {
 		pr_debug("unsupported system\n");
 		return -ENODEV;
 	}
 
+	pr_debug("DMI Matched %s\n", dmi_id->ident);
+
+	cros_laptop = chromeos_laptop_prepare(dmi_id->driver_data);
+	if (IS_ERR(cros_laptop))
+		return PTR_ERR(cros_laptop);
+
 	ret = platform_driver_register(&cros_platform_driver);
 	if (ret)
 		return ret;
-- 
2.16.2.804.g6dcf76e118-goog

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCTWdS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:33:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40898 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeCTWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:32:01 -0400
X-Google-Smtp-Source: AG47ELu1h3aOHJMymR4dizAVR8sZb8qS5E25OVbDEz/rKb/ZIT5mmedz4MTCqvt7VaLvE7bVgTW0pQ==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] platform/chrome: chromeos_laptop - discard data for unneeded boards
Date: Tue, 20 Mar 2018 15:31:37 -0700
Message-Id: <20180320223138.234724-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark board data as __intconst/__initdata and make a copy of appropriate
entry once we identified the board we are running on. The rest of the data
will be discarded once the kernel finished booting (or module finished
loading).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 476 ++++++++++++----------
 1 file changed, 264 insertions(+), 212 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index fe83a2a4900e4..5c47f451e43b1 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -54,13 +54,16 @@ struct i2c_peripheral {
 	struct i2c_client *client;
 };
 
-#define MAX_I2C_PERIPHERALS 4
-
 struct chromeos_laptop {
-	struct i2c_peripheral i2c_peripherals[MAX_I2C_PERIPHERALS];
+	/*
+	 * Note that we can't mark this pointer as const because
+	 * i2c_new_probed_device() changes passed in I2C board info, so.
+	 */
+	struct i2c_peripheral *i2c_peripherals;
+	unsigned int num_i2c_peripherals;
 };
 
-static struct chromeos_laptop *cros_laptop;
+static const struct chromeos_laptop *cros_laptop;
 
 static struct i2c_client *
 chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
@@ -121,13 +124,9 @@ static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
 	struct i2c_peripheral *i2c_dev;
 	int i;
 
-	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
+	for (i = 0; i < cros_laptop->num_i2c_peripherals; i++) {
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
 
-		/* No more peripherals */
-		if (!i2c_dev->board_info.addr)
-			break;
-
 		/* Skip devices already created */
 		if (i2c_dev->client)
 			continue;
@@ -154,7 +153,7 @@ static void chromeos_laptop_detach_i2c_client(struct i2c_client *client)
 	struct i2c_peripheral *i2c_dev;
 	int i;
 
-	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
+	for (i = 0; i < cros_laptop->num_i2c_peripherals; i++) {
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
 
 		if (i2c_dev->client == client)
@@ -186,41 +185,45 @@ static struct notifier_block chromeos_laptop_i2c_notifier = {
 	.notifier_call = chromeos_laptop_i2c_notifier_call,
 };
 
-static struct chromeos_laptop samsung_series_5_550 = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_SMBUS,
+#define DECLARE_CROS_LAPTOP(_name)					\
+static const struct chromeos_laptop _name __initconst = {		\
+	.i2c_peripherals	= _name##_peripherals,			\
+	.num_i2c_peripherals	= ARRAY_SIZE(_name##_peripherals),	\
+}
+
+static struct i2c_peripheral samsung_series_5_550_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
-			},
-			.dmi_name	= "lightsensor",
-			.type		= I2C_ADAPTER_SMBUS,
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_SMBUS,
+	},
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
 		},
+		.dmi_name	= "lightsensor",
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(samsung_series_5_550);
 
-static struct chromeos_laptop samsung_series_5 = {
-	.i2c_peripherals = {
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
-			},
-			.type		= I2C_ADAPTER_SMBUS,
+static struct i2c_peripheral samsung_series_5_peripherals[] __initdata = {
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
 		},
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(samsung_series_5);
 
-static int chromebook_pixel_tp_keys[] = {
+static const int chromebook_pixel_tp_keys[] __initconst = {
 	KEY_RESERVED,
 	KEY_RESERVED,
 	KEY_RESERVED,
@@ -229,199 +232,192 @@ static int chromebook_pixel_tp_keys[] = {
 	BTN_LEFT
 };
 
-static const struct property_entry chromebook_pixel_trackpad_props[] = {
+static const struct property_entry
+chromebook_pixel_trackpad_props[] __initconst = {
 	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_pixel_tp_keys),
 	{ }
 };
 
-static struct chromeos_laptop chromebook_pixel = {
-	.i2c_peripherals = {
-		/* Touch Screen. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("atmel_mxt_ts",
-						ATMEL_TS_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "touchscreen",
-			.irqflags	= IRQF_TRIGGER_FALLING,
-			.type		= I2C_ADAPTER_PANEL,
-			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+static struct i2c_peripheral chromebook_pixel_peripherals[] __initdata = {
+	/* Touch Screen. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("atmel_mxt_ts",
+					ATMEL_TS_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("atmel_mxt_tp",
-						ATMEL_TP_I2C_ADDR),
-				.properties	=
-					chromebook_pixel_trackpad_props,
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.irqflags	= IRQF_TRIGGER_FALLING,
-			.type		= I2C_ADAPTER_VGADDC,
-			.alt_addr	= ATMEL_TP_I2C_BL_ADDR,
+		.dmi_name	= "touchscreen",
+		.irqflags	= IRQF_TRIGGER_FALLING,
+		.type		= I2C_ADAPTER_PANEL,
+		.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+	},
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("atmel_mxt_tp",
+					ATMEL_TP_I2C_ADDR),
+			.properties	=
+				chromebook_pixel_trackpad_props,
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
-			},
-			.dmi_name	= "lightsensor",
-			.type		= I2C_ADAPTER_PANEL,
+		.dmi_name	= "trackpad",
+		.irqflags	= IRQF_TRIGGER_FALLING,
+		.type		= I2C_ADAPTER_VGADDC,
+		.alt_addr	= ATMEL_TP_I2C_BL_ADDR,
+	},
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
 		},
+		.dmi_name	= "lightsensor",
+		.type		= I2C_ADAPTER_PANEL,
 	},
 };
+DECLARE_CROS_LAPTOP(chromebook_pixel);
 
-static struct chromeos_laptop hp_chromebook_14 = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
+static struct i2c_peripheral hp_chromebook_14_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
 	},
 };
+DECLARE_CROS_LAPTOP(hp_chromebook_14);
 
-static struct chromeos_laptop dell_chromebook_11 = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
+static struct i2c_peripheral dell_chromebook_11_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Elan Touchpad option. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
+	},
+	/* Elan Touchpad option. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
 	},
 };
+DECLARE_CROS_LAPTOP(dell_chromebook_11);
 
-static struct chromeos_laptop toshiba_cb35 = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
+static struct i2c_peripheral toshiba_cb35_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
 	},
 };
+DECLARE_CROS_LAPTOP(toshiba_cb35);
 
-static struct chromeos_laptop acer_c7_chromebook = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_SMBUS,
+static struct i2c_peripheral acer_c7_chromebook_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(acer_c7_chromebook);
 
-static struct chromeos_laptop acer_ac700 = {
-	.i2c_peripherals = {
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
-			},
-			.type		= I2C_ADAPTER_SMBUS,
+static struct i2c_peripheral acer_ac700_peripherals[] __initdata = {
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
 		},
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(acer_ac700);
 
-static struct chromeos_laptop acer_c720 = {
-	.i2c_peripherals = {
-		/* Touchscreen. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("atmel_mxt_ts",
-						ATMEL_TS_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "touchscreen",
-			.irqflags	= IRQF_TRIGGER_FALLING,
-			.type		= I2C_ADAPTER_DESIGNWARE,
-			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
-			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+static struct i2c_peripheral acer_c720_peripherals[] __initdata = {
+	/* Touchscreen. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("atmel_mxt_ts",
+					ATMEL_TS_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
-			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
+		.dmi_name	= "touchscreen",
+		.irqflags	= IRQF_TRIGGER_FALLING,
+		.type		= I2C_ADAPTER_DESIGNWARE,
+		.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
+		.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+	},
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Elan Touchpad option. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE,
-			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
+		.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
+	},
+	/* Elan Touchpad option. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
-			},
-			.dmi_name	= "lightsensor",
-			.type		= I2C_ADAPTER_DESIGNWARE,
-			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_DESIGNWARE,
+		.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
+	},
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
 		},
+		.dmi_name	= "lightsensor",
+		.type		= I2C_ADAPTER_DESIGNWARE,
+		.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
 	},
 };
+DECLARE_CROS_LAPTOP(acer_c720);
 
-static struct chromeos_laptop hp_pavilion_14_chromebook = {
-	.i2c_peripherals = {
-		/* Touchpad. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-				.flags		= I2C_CLIENT_WAKE,
-			},
-			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_SMBUS,
+static struct i2c_peripheral
+hp_pavilion_14_chromebook_peripherals[] __initdata = {
+	/* Touchpad. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+			.flags		= I2C_CLIENT_WAKE,
 		},
+		.dmi_name	= "trackpad",
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(hp_pavilion_14_chromebook);
 
-static struct chromeos_laptop cr48 = {
-	.i2c_peripherals = {
-		/* Light Sensor. */
-		{
-			.board_info	= {
-				I2C_BOARD_INFO("tsl2563", TAOS_ALS_I2C_ADDR),
-			},
-			.type		= I2C_ADAPTER_SMBUS,
+static struct i2c_peripheral cr48_peripherals[] __initdata = {
+	/* Light Sensor. */
+	{
+		.board_info	= {
+			I2C_BOARD_INFO("tsl2563", TAOS_ALS_I2C_ADDR),
 		},
+		.type		= I2C_ADAPTER_SMBUS,
 	},
 };
+DECLARE_CROS_LAPTOP(cr48);
 
 static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 	{
@@ -541,24 +537,14 @@ static int __init chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
 	return dev_data->instance;
 }
 
-static struct chromeos_laptop * __init
-chromeos_laptop_prepare(const struct dmi_system_id *id)
+static int __init chromeos_laptop_setup_irq(struct i2c_peripheral *i2c_dev)
 {
-	struct i2c_peripheral *i2c_dev;
 	int irq;
-	int i;
-
-	cros_laptop = (void *)id->driver_data;
-
-	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
-		i2c_dev = &cros_laptop->i2c_peripherals[i];
-
-		if (!i2c_dev->dmi_name)
-			continue;
 
+	if (i2c_dev->dmi_name) {
 		irq = chromeos_laptop_get_irq_from_dmi(i2c_dev->dmi_name);
 		if (irq < 0)
-			return ERR_PTR(irq);
+			return irq;
 
 		i2c_dev->irq_resource  = (struct resource)
 			DEFINE_RES_NAMED(irq, 1, NULL,
@@ -567,9 +553,87 @@ chromeos_laptop_prepare(const struct dmi_system_id *id)
 		i2c_dev->board_info.num_resources = 1;
 	}
 
+	return 0;
+}
+
+static struct chromeos_laptop * __init
+chromeos_laptop_prepare(const struct chromeos_laptop *src)
+{
+	struct chromeos_laptop *cros_laptop;
+	struct i2c_peripheral *i2c_dev;
+	struct i2c_board_info *info;
+	int error;
+	int i;
+
+	cros_laptop = kzalloc(sizeof(*cros_laptop), GFP_KERNEL);
+	if (!cros_laptop)
+		return ERR_PTR(-ENOMEM);
+
+	cros_laptop->i2c_peripherals = kmemdup(src->i2c_peripherals,
+					       src->num_i2c_peripherals *
+						sizeof(*src->i2c_peripherals),
+					       GFP_KERNEL);
+	if (!cros_laptop->i2c_peripherals) {
+		error = -ENOMEM;
+		goto err_free_cros_laptop;
+	}
+
+	cros_laptop->num_i2c_peripherals = src->num_i2c_peripherals;
+
+	for (i = 0; i < cros_laptop->num_i2c_peripherals; i++) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
+		info = &i2c_dev->board_info;
+
+		error = chromeos_laptop_setup_irq(i2c_dev);
+		if (error)
+			goto err_destroy_cros_peripherals;
+
+		/* We need to deep-copy properties */
+		if (info->properties) {
+			info->properties =
+				property_entries_dup(info->properties);
+			if (IS_ERR(info->properties)) {
+				error = PTR_ERR(info->properties);
+				goto err_destroy_cros_peripherals;
+			}
+		}
+	}
+
 	return cros_laptop;
+
+err_destroy_cros_peripherals:
+	while (--i >= 0) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
+		info = &i2c_dev->board_info;
+		if (info->properties)
+			property_entries_free(info->properties);
+	}
+	kfree(cros_laptop->i2c_peripherals);
+err_free_cros_laptop:
+	kfree(cros_laptop);
+	return ERR_PTR(error);
 }
 
+static void chromeos_laptop_destroy(const struct chromeos_laptop *cros_laptop)
+{
+	struct i2c_peripheral *i2c_dev;
+	struct i2c_board_info *info;
+	int i;
+
+	for (i = 0; i < cros_laptop->num_i2c_peripherals; i++) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
+		info = &i2c_dev->board_info;
+
+		if (i2c_dev->client)
+			i2c_unregister_device(i2c_dev->client);
+
+		if (info->properties)
+			property_entries_free(info->properties);
+	}
+
+	kfree(cros_laptop->i2c_peripherals);
+	kfree(cros_laptop);
+}
 
 static int __init chromeos_laptop_init(void)
 {
@@ -584,7 +648,7 @@ static int __init chromeos_laptop_init(void)
 
 	pr_debug("DMI Matched %s\n", dmi_id->ident);
 
-	cros_laptop = chromeos_laptop_prepare(dmi_id->driver_data);
+	cros_laptop = chromeos_laptop_prepare((void *)dmi_id->driver_data);
 	if (IS_ERR(cros_laptop))
 		return PTR_ERR(cros_laptop);
 
@@ -592,6 +656,7 @@ static int __init chromeos_laptop_init(void)
 				      &chromeos_laptop_i2c_notifier);
 	if (error) {
 		pr_err("failed to register i2c bus notifier: %d\n", error);
+		chromeos_laptop_destroy(cros_laptop);
 		return error;
 	}
 
@@ -606,21 +671,8 @@ static int __init chromeos_laptop_init(void)
 
 static void __exit chromeos_laptop_exit(void)
 {
-	struct i2c_peripheral *i2c_dev;
-	int i;
-
 	bus_unregister_notifier(&i2c_bus_type, &chromeos_laptop_i2c_notifier);
-
-	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
-		i2c_dev = &cros_laptop->i2c_peripherals[i];
-
-		/* No more peripherals */
-		if (!i2c_dev->board_info.type)
-			break;
-
-		if (i2c_dev->client)
-			i2c_unregister_device(i2c_dev->client);
-	}
+	chromeos_laptop_destroy(cros_laptop);
 }
 
 module_init(chromeos_laptop_init);
-- 
2.16.2.804.g6dcf76e118-goog

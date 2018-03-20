Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCTWdq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:33:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44870 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCTWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:56 -0400
X-Google-Smtp-Source: AG47ELvxg7MNE2ghItGTnaG9GiDFwvd6ZoU+LvxjTuw8mARkseIsEvXY6R227xFkho9VKuOEi41hqg==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/14] platform/chrome: chromeos_laptop - use I2C notifier to create devices
Date: Tue, 20 Mar 2018 15:31:34 -0700
Message-Id: <20180320223138.234724-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using platform device and deferrals to handle the case when i2C
adapters appear late in the game, and not handling device unbinding all
that well, let's switch to using I2C bus notifier to get told when a new
I2C adapter appears in the system, and attempt to add appropriate devices
at that time.

In case when we have 2 Designware adapters in the system (Acer C720),
instead of counting and hoping they get enumerate din the right order,
let's switch to using their PCI devids (slot/function) that should be
stable.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 247 +++++++++-------------
 1 file changed, 102 insertions(+), 145 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index d6d2bc6f3aaf0..e5015dfaa81ec 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 
 #define ATMEL_TP_I2C_ADDR	0x4b
@@ -23,14 +24,11 @@
 #define ISL_ALS_I2C_ADDR	0x44
 #define TAOS_ALS_I2C_ADDR	0x29
 
-#define MAX_I2C_DEVICE_DEFERRALS	5
-
 static const char *i2c_adapter_names[] = {
 	"SMBus I801 adapter",
 	"i915 gmbus vga",
 	"i915 gmbus panel",
 	"Synopsys DesignWare I2C adapter",
-	"Synopsys DesignWare I2C adapter",
 };
 
 /* Keep this enum consistent with i2c_adapter_names */
@@ -38,15 +36,7 @@ enum i2c_adapter_type {
 	I2C_ADAPTER_SMBUS = 0,
 	I2C_ADAPTER_VGADDC,
 	I2C_ADAPTER_PANEL,
-	I2C_ADAPTER_DESIGNWARE_0,
-	I2C_ADAPTER_DESIGNWARE_1,
-};
-
-enum i2c_peripheral_state {
-	UNPROBED = 0,
-	PROBED,
-	TIMEDOUT,
-	FAILED,
+	I2C_ADAPTER_DESIGNWARE,
 };
 
 struct i2c_peripheral {
@@ -54,10 +44,9 @@ struct i2c_peripheral {
 	unsigned short alt_addr;
 	const char *dmi_name;
 	enum i2c_adapter_type type;
+	u32 pci_devid;
 
-	enum i2c_peripheral_state state;
 	struct i2c_client *client;
-	int tries;
 };
 
 #define MAX_I2C_PERIPHERALS 4
@@ -69,19 +58,12 @@ struct chromeos_laptop {
 static struct chromeos_laptop *cros_laptop;
 
 static struct i2c_client *
-chromes_laptop_instantiate_i2c_device(int bus,
+chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
 				      struct i2c_board_info *info,
 				      unsigned short alt_addr)
 {
-	struct i2c_adapter *adapter;
-	struct i2c_client *client = NULL;
 	const unsigned short addr_list[] = { info->addr, I2C_CLIENT_END };
-
-	adapter = i2c_get_adapter(bus);
-	if (!adapter) {
-		pr_err("failed to get i2c adapter %d\n", bus);
-		return NULL;
-	}
+	struct i2c_client *client;
 
 	/*
 	 * Add the i2c device. If we can't detect it at the primary
@@ -102,126 +84,103 @@ chromes_laptop_instantiate_i2c_device(int bus,
 					      alt_addr_list, NULL);
 		if (dummy) {
 			pr_debug("%d-%02x is probed at %02x\n",
-				 bus, info->addr, dummy->addr);
+				 adapter->nr, info->addr, dummy->addr);
 			i2c_unregister_device(dummy);
 			client = i2c_new_device(adapter, info);
 		}
 	}
 
 	if (!client)
-		pr_notice("failed to register device %d-%02x\n",
-			  bus, info->addr);
+		pr_debug("failed to register device %d-%02x\n",
+			 adapter->nr, info->addr);
 	else
-		pr_debug("added i2c device %d-%02x\n", bus, info->addr);
+		pr_debug("added i2c device %d-%02x\n",
+			 adapter->nr, info->addr);
 
-	i2c_put_adapter(adapter);
 	return client;
 }
 
-struct i2c_lookup {
-	const char *name;
-	int instance;
-	int n;
-};
-
-static int __find_i2c_adap(struct device *dev, void *data)
+static bool chromeos_laptop_match_adapter_devid(struct device *dev, u32 devid)
 {
-	struct i2c_lookup *lookup = data;
-	static const char *prefix = "i2c-";
-	struct i2c_adapter *adapter;
+	struct pci_dev *pdev;
 
-	if (strncmp(dev_name(dev), prefix, strlen(prefix)) != 0)
-		return 0;
-	adapter = to_i2c_adapter(dev);
-	if (strncmp(adapter->name, lookup->name, strlen(lookup->name)) == 0 &&
-	    lookup->n++ == lookup->instance)
-		return 1;
-	return 0;
-}
+	if (!dev_is_pci(dev))
+		return false;
 
-static int find_i2c_adapter_num(enum i2c_adapter_type type)
-{
-	struct device *dev = NULL;
-	struct i2c_adapter *adapter;
-	struct i2c_lookup lookup;
-
-	memset(&lookup, 0, sizeof(lookup));
-	lookup.name = i2c_adapter_names[type];
-	lookup.instance = (type == I2C_ADAPTER_DESIGNWARE_1) ? 1 : 0;
-
-	/* find the adapter by name */
-	dev = bus_find_device(&i2c_bus_type, NULL, &lookup, __find_i2c_adap);
-	if (!dev) {
-		/* Adapters may appear later. Deferred probing will retry */
-		pr_notice("i2c adapter %s not found on system.\n",
-			  lookup.name);
-		return -ENODEV;
-	}
-	adapter = to_i2c_adapter(dev);
-	return adapter->nr;
+	pdev = to_pci_dev(dev);
+	return devid == PCI_DEVID(pdev->bus->number, pdev->devfn);
 }
 
-static int chromeos_laptop_add_peripheral(struct i2c_peripheral *i2c_dev)
+static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
 {
-	struct i2c_client *client;
-	int bus;
+	struct i2c_peripheral *i2c_dev;
+	int i;
 
-	/*
-	 * Check that the i2c adapter is present.
-	 * -EPROBE_DEFER if missing as the adapter may appear much
-	 * later.
-	 */
-	bus = find_i2c_adapter_num(i2c_dev->type);
-	if (bus < 0)
-		return bus == -ENODEV ? -EPROBE_DEFER : bus;
-
-	client = chromes_laptop_instantiate_i2c_device(bus,
-						       &i2c_dev->board_info,
-						       i2c_dev->alt_addr);
-	if (!client) {
-		/*
-		 * Set -EPROBE_DEFER a limited num of times
-		 * if device is not successfully added.
-		 */
-		if (++i2c_dev->tries < MAX_I2C_DEVICE_DEFERRALS) {
-			return -EPROBE_DEFER;
-		} else {
-			/* Ran out of tries. */
-			pr_notice("ran out of tries for device.\n");
-			i2c_dev->state = TIMEDOUT;
-			return -EIO;
-		}
-	}
+	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
 
-	i2c_dev->client = client;
-	i2c_dev->state = PROBED;
+		/* No more peripherals */
+		if (!i2c_dev->board_info.addr)
+			break;
 
-	return 0;
+		/* Skip devices already created */
+		if (i2c_dev->client)
+			continue;
+
+		if (strncmp(adapter->name, i2c_adapter_names[i2c_dev->type],
+			    strlen(i2c_adapter_names[i2c_dev->type])))
+			continue;
+
+		if (i2c_dev->pci_devid &&
+		    !chromeos_laptop_match_adapter_devid(adapter->dev.parent,
+							 i2c_dev->pci_devid)) {
+			continue;
+		}
+
+		i2c_dev->client =
+			chromes_laptop_instantiate_i2c_device(adapter,
+							&i2c_dev->board_info,
+							i2c_dev->alt_addr);
+	}
 }
 
-static int chromeos_laptop_probe(struct platform_device *pdev)
+static void chromeos_laptop_detach_i2c_client(struct i2c_client *client)
 {
 	struct i2c_peripheral *i2c_dev;
 	int i;
-	int ret = 0;
 
 	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
 
-		/* No more peripherals. */
-		if (!i2c_dev->board_info.addr)
-			break;
-
-		if (i2c_dev->state != UNPROBED)
-			continue;
+		if (i2c_dev->client == client)
+			i2c_dev->client = NULL;
+	}
+}
 
-		if (chromeos_laptop_add_peripheral(i2c_dev) == -EPROBE_DEFER)
-			ret = -EPROBE_DEFER;
+static int chromeos_laptop_i2c_notifier_call(struct notifier_block *nb,
+					     unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (dev->type == &i2c_adapter_type)
+			chromeos_laptop_check_adapter(to_i2c_adapter(dev));
+		break;
+
+	case BUS_NOTIFY_REMOVED_DEVICE:
+		if (dev->type == &i2c_client_type)
+			chromeos_laptop_detach_i2c_client(to_i2c_client(dev));
+		break;
 	}
 
-	return ret;
+	return 0;
 }
 
+static struct notifier_block chromeos_laptop_i2c_notifier = {
+	.notifier_call = chromeos_laptop_i2c_notifier_call,
+};
+
 static struct chromeos_laptop samsung_series_5_550 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
@@ -322,7 +281,7 @@ static struct chromeos_laptop hp_chromebook_14 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
 		},
 	},
 };
@@ -336,7 +295,7 @@ static struct chromeos_laptop dell_chromebook_11 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
 		},
 		/* Elan Touchpad option. */
 		{
@@ -345,7 +304,7 @@ static struct chromeos_laptop dell_chromebook_11 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
 		},
 	},
 };
@@ -359,7 +318,7 @@ static struct chromeos_laptop toshiba_cb35 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
 		},
 	},
 };
@@ -401,7 +360,8 @@ static struct chromeos_laptop acer_c720 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "touchscreen",
-			.type		= I2C_ADAPTER_DESIGNWARE_1,
+			.type		= I2C_ADAPTER_DESIGNWARE,
+			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
 			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
 		},
 		/* Touchpad. */
@@ -411,7 +371,8 @@ static struct chromeos_laptop acer_c720 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
+			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
 		},
 		/* Elan Touchpad option. */
 		{
@@ -420,7 +381,8 @@ static struct chromeos_laptop acer_c720 = {
 				.flags		= I2C_CLIENT_WAKE,
 			},
 			.dmi_name	= "trackpad",
-			.type		= I2C_ADAPTER_DESIGNWARE_0,
+			.type		= I2C_ADAPTER_DESIGNWARE,
+			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x1)),
 		},
 		/* Light Sensor. */
 		{
@@ -428,7 +390,8 @@ static struct chromeos_laptop acer_c720 = {
 				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
 			},
 			.dmi_name	= "lightsensor",
-			.type		= I2C_ADAPTER_DESIGNWARE_1,
+			.type		= I2C_ADAPTER_DESIGNWARE,
+			.pci_devid	= PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
 		},
 	},
 };
@@ -546,14 +509,16 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 };
 MODULE_DEVICE_TABLE(dmi, chromeos_laptop_dmi_table);
 
-static struct platform_device *cros_platform_device;
+static int __init chromeos_laptop_scan_adapter(struct device *dev, void *data)
+{
+	struct i2c_adapter *adapter;
 
-static struct platform_driver cros_platform_driver = {
-	.driver = {
-		.name = "chromeos_laptop",
-	},
-	.probe = chromeos_laptop_probe,
-};
+	adapter = i2c_verify_adapter(dev);
+	if (adapter)
+		chromeos_laptop_check_adapter(adapter);
+
+	return 0;
+}
 
 static int __init chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
 {
@@ -602,7 +567,7 @@ chromeos_laptop_prepare(const struct dmi_system_id *id)
 static int __init chromeos_laptop_init(void)
 {
 	const struct dmi_system_id *dmi_id;
-	int ret;
+	int error;
 
 	dmi_id = dmi_first_match(chromeos_laptop_dmi_table);
 	if (!dmi_id) {
@@ -616,27 +581,20 @@ static int __init chromeos_laptop_init(void)
 	if (IS_ERR(cros_laptop))
 		return PTR_ERR(cros_laptop);
 
-	ret = platform_driver_register(&cros_platform_driver);
-	if (ret)
-		return ret;
-
-	cros_platform_device = platform_device_alloc("chromeos_laptop", -1);
-	if (!cros_platform_device) {
-		ret = -ENOMEM;
-		goto fail_platform_device1;
+	error = bus_register_notifier(&i2c_bus_type,
+				      &chromeos_laptop_i2c_notifier);
+	if (error) {
+		pr_err("failed to register i2c bus notifier: %d\n", error);
+		return error;
 	}
 
-	ret = platform_device_add(cros_platform_device);
-	if (ret)
-		goto fail_platform_device2;
+	/*
+	 * Scan adapters that have been registered before we installed
+	 * the notifier to make sure we do not miss any devices.
+	 */
+	i2c_for_each_dev(NULL, chromeos_laptop_scan_adapter);
 
 	return 0;
-
-fail_platform_device2:
-	platform_device_put(cros_platform_device);
-fail_platform_device1:
-	platform_driver_unregister(&cros_platform_driver);
-	return ret;
 }
 
 static void __exit chromeos_laptop_exit(void)
@@ -644,8 +602,7 @@ static void __exit chromeos_laptop_exit(void)
 	struct i2c_peripheral *i2c_dev;
 	int i;
 
-	platform_device_unregister(cros_platform_device);
-	platform_driver_unregister(&cros_platform_driver);
+	bus_unregister_notifier(&i2c_bus_type, &chromeos_laptop_i2c_notifier);
 
 	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
@@ -654,7 +611,7 @@ static void __exit chromeos_laptop_exit(void)
 		if (!i2c_dev->board_info.type)
 			break;
 
-		if (i2c_dev->state == PROBED)
+		if (i2c_dev->client)
 			i2c_unregister_device(i2c_dev->client);
 	}
 }
-- 
2.16.2.804.g6dcf76e118-goog

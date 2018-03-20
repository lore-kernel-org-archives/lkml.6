Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCTWcQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:32:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40226 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCTWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:53 -0400
X-Google-Smtp-Source: AG47ELv2hzDuNwoYyq7dlj+tjut4bWyTT6imRQLbAb5k2cp/mA9BuEsP2Fxvzd+ZhKgiwJA8uNUndw==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] platform/chrome: chromeos_laptop - rework i2c peripherals initialization
Date: Tue, 20 Mar 2018 15:31:32 -0700
Message-Id: <20180320223138.234724-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having separate setup() functions responsible for instantiating
i2c client for each peripheral, let's generalize the behavior and use
common code for instantiating all i2c peripherals.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 467 +++++++++++-----------
 1 file changed, 235 insertions(+), 232 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 96e962ff38e87..2a81ae4c15c93 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -25,10 +25,6 @@
 
 #define MAX_I2C_DEVICE_DEFERRALS	5
 
-static struct i2c_client *als;
-static struct i2c_client *tp;
-static struct i2c_client *ts;
-
 static const char *i2c_adapter_names[] = {
 	"SMBus I801 adapter",
 	"i915 gmbus vga",
@@ -50,12 +46,17 @@ enum i2c_peripheral_state {
 	UNPROBED = 0,
 	PROBED,
 	TIMEDOUT,
+	FAILED,
 };
 
 struct i2c_peripheral {
-	int (*add)(enum i2c_adapter_type type);
+	struct i2c_board_info board_info;
+	unsigned short alt_addr;
+	const char *dmi_name;
 	enum i2c_adapter_type type;
+
 	enum i2c_peripheral_state state;
+	struct i2c_client *client;
 	int tries;
 };
 
@@ -67,59 +68,6 @@ struct chromeos_laptop {
 
 static struct chromeos_laptop *cros_laptop;
 
-static struct i2c_board_info cyapa_device = {
-	I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
-	.flags		= I2C_CLIENT_WAKE,
-};
-
-static struct i2c_board_info elantech_device = {
-	I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
-	.flags		= I2C_CLIENT_WAKE,
-};
-
-static struct i2c_board_info isl_als_device = {
-	I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
-};
-
-static struct i2c_board_info tsl2583_als_device = {
-	I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
-};
-
-static struct i2c_board_info tsl2563_als_device = {
-	I2C_BOARD_INFO("tsl2563", TAOS_ALS_I2C_ADDR),
-};
-
-static int mxt_t19_keys[] = {
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	KEY_RESERVED,
-	BTN_LEFT
-};
-
-static struct mxt_platform_data atmel_224s_tp_platform_data = {
-	.irqflags		= IRQF_TRIGGER_FALLING,
-	.t19_num_keys		= ARRAY_SIZE(mxt_t19_keys),
-	.t19_keymap		= mxt_t19_keys,
-};
-
-static struct i2c_board_info atmel_224s_tp_device = {
-	I2C_BOARD_INFO("atmel_mxt_tp", ATMEL_TP_I2C_ADDR),
-	.platform_data = &atmel_224s_tp_platform_data,
-	.flags		= I2C_CLIENT_WAKE,
-};
-
-static struct mxt_platform_data atmel_1664s_platform_data = {
-	.irqflags		= IRQF_TRIGGER_FALLING,
-};
-
-static struct i2c_board_info atmel_1664s_device = {
-	I2C_BOARD_INFO("atmel_mxt_ts", ATMEL_TS_I2C_ADDR),
-	.platform_data = &atmel_1664s_platform_data,
-	.flags		= I2C_CLIENT_WAKE,
-};
-
 static int chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
 {
 	const struct dmi_device *dmi_dev;
@@ -140,29 +88,15 @@ static int chromeos_laptop_get_irq_from_dmi(const char *dmi_name)
 	return dev_data->instance;
 }
 
-static struct i2c_client *__add_probed_i2c_device(
-		const char *name,
-		int bus,
-		struct i2c_board_info *info,
-		const unsigned short *alt_addr_list)
+static struct i2c_client *
+chromes_laptop_instantiate_i2c_device(int bus,
+				      struct i2c_board_info *info,
+				      unsigned short alt_addr)
 {
 	struct i2c_adapter *adapter;
 	struct i2c_client *client = NULL;
 	const unsigned short addr_list[] = { info->addr, I2C_CLIENT_END };
 
-	if (bus < 0)
-		return NULL;
-
-	/*
-	 * If a name is specified, look for irq platform information stashed
-	 * in DMI_DEV_TYPE_DEV_ONBOARD by the Chrome OS custom system firmware.
-	 */
-	if (name) {
-		info->irq = chromeos_laptop_get_irq_from_dmi(name);
-		if (info->irq < 0)
-			return NULL;
-	}
-
 	adapter = i2c_get_adapter(bus);
 	if (!adapter) {
 		pr_err("failed to get i2c adapter %d\n", bus);
@@ -175,10 +109,13 @@ static struct i2c_client *__add_probed_i2c_device(
 	 * structure gets assigned primary address.
 	 */
 	client = i2c_new_probed_device(adapter, info, addr_list, NULL);
-	if (!client && alt_addr_list) {
+	if (!client && alt_addr) {
 		struct i2c_board_info dummy_info = {
 			I2C_BOARD_INFO("dummy", info->addr),
 		};
+		const unsigned short alt_addr_list[] = {
+			alt_addr, I2C_CLIENT_END
+		};
 		struct i2c_client *dummy;
 
 		dummy = i2c_new_probed_device(adapter, &dummy_info,
@@ -244,115 +181,53 @@ static int find_i2c_adapter_num(enum i2c_adapter_type type)
 	return adapter->nr;
 }
 
-/*
- * Takes a list of addresses in addrs as such :
- * { addr1, ... , addrn, I2C_CLIENT_END };
- * add_probed_i2c_device will use i2c_new_probed_device
- * and probe for devices at all of the addresses listed.
- * Returns NULL if no devices found.
- * See Documentation/i2c/instantiating-devices for more information.
- */
-static struct i2c_client *add_probed_i2c_device(
-		const char *name,
-		enum i2c_adapter_type type,
-		struct i2c_board_info *info,
-		const unsigned short *addrs)
+static int chromeos_laptop_add_peripheral(struct i2c_peripheral *i2c_dev)
 {
-	return __add_probed_i2c_device(name,
-				       find_i2c_adapter_num(type),
-				       info,
-				       addrs);
-}
+	struct i2c_client *client;
+	int bus;
+	int irq;
 
-/*
- * Probes for a device at a single address, the one provided by
- * info->addr.
- * Returns NULL if no device found.
- */
-static struct i2c_client *add_i2c_device(const char *name,
-						enum i2c_adapter_type type,
-						struct i2c_board_info *info)
-{
-	return __add_probed_i2c_device(name,
-				       find_i2c_adapter_num(type),
-				       info,
-				       NULL);
-}
-
-static int setup_cyapa_tp(enum i2c_adapter_type type)
-{
-	if (tp)
-		return 0;
-
-	/* add cyapa touchpad */
-	tp = add_i2c_device("trackpad", type, &cyapa_device);
-	return (!tp) ? -EAGAIN : 0;
-}
-
-static int setup_atmel_224s_tp(enum i2c_adapter_type type)
-{
-	const unsigned short addr_list[] = { ATMEL_TP_I2C_BL_ADDR,
-					     I2C_CLIENT_END };
-	if (tp)
-		return 0;
-
-	/* add atmel mxt touchpad */
-	tp = add_probed_i2c_device("trackpad", type,
-				   &atmel_224s_tp_device, addr_list);
-	return (!tp) ? -EAGAIN : 0;
-}
-
-static int setup_elantech_tp(enum i2c_adapter_type type)
-{
-	if (tp)
-		return 0;
-
-	/* add elantech touchpad */
-	tp = add_i2c_device("trackpad", type, &elantech_device);
-	return (!tp) ? -EAGAIN : 0;
-}
-
-static int setup_atmel_1664s_ts(enum i2c_adapter_type type)
-{
-	const unsigned short addr_list[] = { ATMEL_TS_I2C_BL_ADDR,
-					     I2C_CLIENT_END };
-	if (ts)
-		return 0;
-
-	/* add atmel mxt touch device */
-	ts = add_probed_i2c_device("touchscreen", type,
-				   &atmel_1664s_device, addr_list);
-	return (!ts) ? -EAGAIN : 0;
-}
-
-static int setup_isl29018_als(enum i2c_adapter_type type)
-{
-	if (als)
-		return 0;
+	/*
+	 * Check that the i2c adapter is present.
+	 * -EPROBE_DEFER if missing as the adapter may appear much
+	 * later.
+	 */
+	bus = find_i2c_adapter_num(i2c_dev->type);
+	if (bus < 0)
+		return bus == -ENODEV ? -EPROBE_DEFER : bus;
 
-	/* add isl29018 light sensor */
-	als = add_i2c_device("lightsensor", type, &isl_als_device);
-	return (!als) ? -EAGAIN : 0;
-}
+	if (i2c_dev->dmi_name) {
+		irq = chromeos_laptop_get_irq_from_dmi(i2c_dev->dmi_name);
+		if (irq < 0) {
+			i2c_dev->state = FAILED;
+			return irq;
+		}
 
-static int setup_tsl2583_als(enum i2c_adapter_type type)
-{
-	if (als)
-		return 0;
+		i2c_dev->board_info.irq = irq;
+	}
 
-	/* add tsl2583 light sensor */
-	als = add_i2c_device(NULL, type, &tsl2583_als_device);
-	return (!als) ? -EAGAIN : 0;
-}
+	client = chromes_laptop_instantiate_i2c_device(bus,
+						       &i2c_dev->board_info,
+						       i2c_dev->alt_addr);
+	if (!client) {
+		/*
+		 * Set -EPROBE_DEFER a limited num of times
+		 * if device is not successfully added.
+		 */
+		if (++i2c_dev->tries < MAX_I2C_DEVICE_DEFERRALS) {
+			return -EPROBE_DEFER;
+		} else {
+			/* Ran out of tries. */
+			pr_notice("ran out of tries for device.\n");
+			i2c_dev->state = TIMEDOUT;
+			return -EIO;
+		}
+	}
 
-static int setup_tsl2563_als(enum i2c_adapter_type type)
-{
-	if (als)
-		return 0;
+	i2c_dev->client = client;
+	i2c_dev->state = PROBED;
 
-	/* add tsl2563 light sensor */
-	als = add_i2c_device(NULL, type, &tsl2563_als_device);
-	return (!als) ? -EAGAIN : 0;
+	return 0;
 }
 
 static int __init chromeos_laptop_dmi_matched(const struct dmi_system_id *id)
@@ -366,47 +241,22 @@ static int __init chromeos_laptop_dmi_matched(const struct dmi_system_id *id)
 
 static int chromeos_laptop_probe(struct platform_device *pdev)
 {
+	struct i2c_peripheral *i2c_dev;
 	int i;
 	int ret = 0;
 
 	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
-		struct i2c_peripheral *i2c_dev;
-
 		i2c_dev = &cros_laptop->i2c_peripherals[i];
 
 		/* No more peripherals. */
-		if (i2c_dev->add == NULL)
+		if (!i2c_dev->board_info.addr)
 			break;
 
-		if (i2c_dev->state == TIMEDOUT || i2c_dev->state == PROBED)
+		if (i2c_dev->state != UNPROBED)
 			continue;
 
-		/*
-		 * Check that the i2c adapter is present.
-		 * -EPROBE_DEFER if missing as the adapter may appear much
-		 * later.
-		 */
-		if (find_i2c_adapter_num(i2c_dev->type) == -ENODEV) {
+		if (chromeos_laptop_add_peripheral(i2c_dev) == -EPROBE_DEFER)
 			ret = -EPROBE_DEFER;
-			continue;
-		}
-
-		/* Add the device. */
-		if (i2c_dev->add(i2c_dev->type) == -EAGAIN) {
-			/*
-			 * Set -EPROBE_DEFER a limited num of times
-			 * if device is not successfully added.
-			 */
-			if (++i2c_dev->tries < MAX_I2C_DEVICE_DEFERRALS) {
-				ret = -EPROBE_DEFER;
-			} else {
-				/* Ran out of tries. */
-				pr_notice("ran out of tries for device.\n");
-				i2c_dev->state = TIMEDOUT;
-			}
-		} else {
-			i2c_dev->state = PROBED;
-		}
 	}
 
 	return ret;
@@ -415,91 +265,237 @@ static int chromeos_laptop_probe(struct platform_device *pdev)
 static struct chromeos_laptop samsung_series_5_550 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 		/* Light Sensor. */
-		{ .add = setup_isl29018_als, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
+			},
+			.dmi_name	= "lightsensor",
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
 static struct chromeos_laptop samsung_series_5 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
-		{ .add = setup_tsl2583_als, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
+			},
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
+static struct mxt_platform_data atmel_1664s_platform_data = {
+	.irqflags		= IRQF_TRIGGER_FALLING,
+};
+
+static int chromebook_pixel_tp_keys[] = {
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	BTN_LEFT
+};
+
+static struct mxt_platform_data chromebook_pixel_tp_platform_data = {
+	.irqflags		= IRQF_TRIGGER_FALLING,
+	.t19_num_keys		= ARRAY_SIZE(chromebook_pixel_tp_keys),
+	.t19_keymap		= chromebook_pixel_tp_keys,
+};
+
 static struct chromeos_laptop chromebook_pixel = {
 	.i2c_peripherals = {
 		/* Touch Screen. */
-		{ .add = setup_atmel_1664s_ts, I2C_ADAPTER_PANEL },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("atmel_mxt_ts",
+						ATMEL_TS_I2C_ADDR),
+				.platform_data	= &atmel_1664s_platform_data,
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "touchscreen",
+			.type		= I2C_ADAPTER_PANEL,
+			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+		},
 		/* Touchpad. */
-		{ .add = setup_atmel_224s_tp, I2C_ADAPTER_VGADDC },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("atmel_mxt_tp",
+						ATMEL_TP_I2C_ADDR),
+				.platform_data	=
+					&chromebook_pixel_tp_platform_data,
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_VGADDC,
+			.alt_addr	= ATMEL_TP_I2C_BL_ADDR,
+		},
 		/* Light Sensor. */
-		{ .add = setup_isl29018_als, I2C_ADAPTER_PANEL },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
+			},
+			.dmi_name	= "lightsensor",
+			.type		= I2C_ADAPTER_PANEL,
+		},
 	},
 };
 
 static struct chromeos_laptop hp_chromebook_14 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 	},
 };
 
 static struct chromeos_laptop dell_chromebook_11 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 		/* Elan Touchpad option. */
-		{ .add = setup_elantech_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 	},
 };
 
 static struct chromeos_laptop toshiba_cb35 = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 	},
 };
 
 static struct chromeos_laptop acer_c7_chromebook = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
 static struct chromeos_laptop acer_ac700 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
-		{ .add = setup_tsl2563_als, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("tsl2583", TAOS_ALS_I2C_ADDR),
+			},
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
 static struct chromeos_laptop acer_c720 = {
 	.i2c_peripherals = {
 		/* Touchscreen. */
-		{ .add = setup_atmel_1664s_ts, I2C_ADAPTER_DESIGNWARE_1 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("atmel_mxt_ts",
+						ATMEL_TS_I2C_ADDR),
+				.platform_data	= &atmel_1664s_platform_data,
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "touchscreen",
+			.type		= I2C_ADAPTER_DESIGNWARE_1,
+			.alt_addr	= ATMEL_TS_I2C_BL_ADDR,
+		},
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 		/* Elan Touchpad option. */
-		{ .add = setup_elantech_tp, I2C_ADAPTER_DESIGNWARE_0 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("elan_i2c", ELAN_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_DESIGNWARE_0,
+		},
 		/* Light Sensor. */
-		{ .add = setup_isl29018_als, I2C_ADAPTER_DESIGNWARE_1 },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("isl29018", ISL_ALS_I2C_ADDR),
+			},
+			.dmi_name	= "lightsensor",
+			.type		= I2C_ADAPTER_DESIGNWARE_1,
+		},
 	},
 };
 
 static struct chromeos_laptop hp_pavilion_14_chromebook = {
 	.i2c_peripherals = {
 		/* Touchpad. */
-		{ .add = setup_cyapa_tp, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("cyapa", CYAPA_TP_I2C_ADDR),
+				.flags		= I2C_CLIENT_WAKE,
+			},
+			.dmi_name	= "trackpad",
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
 static struct chromeos_laptop cr48 = {
 	.i2c_peripherals = {
 		/* Light Sensor. */
-		{ .add = setup_tsl2563_als, I2C_ADAPTER_SMBUS },
+		{
+			.board_info	= {
+				I2C_BOARD_INFO("tsl2563", TAOS_ALS_I2C_ADDR),
+			},
+			.type		= I2C_ADAPTER_SMBUS,
+		},
 	},
 };
 
@@ -637,15 +633,22 @@ static int __init chromeos_laptop_init(void)
 
 static void __exit chromeos_laptop_exit(void)
 {
-	if (als)
-		i2c_unregister_device(als);
-	if (tp)
-		i2c_unregister_device(tp);
-	if (ts)
-		i2c_unregister_device(ts);
+	struct i2c_peripheral *i2c_dev;
+	int i;
 
 	platform_device_unregister(cros_platform_device);
 	platform_driver_unregister(&cros_platform_driver);
+
+	for (i = 0; i < MAX_I2C_PERIPHERALS; i++) {
+		i2c_dev = &cros_laptop->i2c_peripherals[i];
+
+		/* No more peripherals */
+		if (!i2c_dev->board_info.type)
+			break;
+
+		if (i2c_dev->state == PROBED)
+			i2c_unregister_device(i2c_dev->client);
+	}
 }
 
 module_init(chromeos_laptop_init);
-- 
2.16.2.804.g6dcf76e118-goog

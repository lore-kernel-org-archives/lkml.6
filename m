Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeENIHC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39623 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeENIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:06:49 -0400
X-Google-Smtp-Source: AB8JxZpEZr+fba0Ksjs7815Sta6muKsl7jzqsz7CfCcrU8cyTToBaM53De8lGUR+I34cqFycaPKBwQ==
From: Linus Walleij <linus.walleij@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
Date: Mon, 14 May 2018 10:06:22 +0200
Message-Id: <20180514080640.12515-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514080640.12515-1-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we augmented the regulator core to accept a GPIO descriptor instead
of a GPIO number, we can augment the fixed GPIO regulator to look up
and pass that descriptor directly from device tree or board GPIO
descriptor look up tables.

Some boards just auto-enumerate their fixed regulator platform devices
and I have assumed they get names like "fixed-regulator.0" but it's
pretty hard to guess this. I need some testing from board maintainers to
be sure. Other boards are straight forward, using just plain
"fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
device ID.

The OMAP didn't have proper label names on its GPIO chips so I have fixed
this with a separate patch to the GPIO tree, see
commit 088413bc0bd5f5fb66ca22a19d66a49d7154ba4c
"gpio: omap: Give unique labels to each GPIO bank/chip"

It seems the da9055 and da9211 has never got around to actually passing
any enable gpio into its platform data (not the in-tree code anyway) so we
can just decide to simply pass a descriptor instead.

The fixed GPIO-controlled regulator in mach-pxa/ezx.c was confusingly named
"*_dummy_supply_device" while it is a very real device backed by a GPIO
line. There is nothing dummy about it at all, so I renamed it with the
infix *_regulator_* as part of this patch set.

For the patch hunk hitting arch/blackfin I would say I do not expect
testing, review or ACKs anymore so if it works, it works.

The hunk hitting the x86 BCM43xx driver is especially tricky as the number
comes out of SFI which is a mystery to me. I definately need someone to
look at this. (Hi Andy.)

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Check the x86 BCM stuff
Cc: Alexander Shiyan <shc_work@mail.ru> # i.MX boards user
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> # MMP2 maintainer
Cc: Aaro Koskinen <aaro.koskinen@iki.fi> # OMAP1 maintainer
Cc: Tony Lindgren <tony@atomide.com> # OMAP1,2,3 maintainer
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com> # EM-X270 maintainer
Cc: Robert Jarzmik <robert.jarzmik@free.fr> # EZX maintainer
Cc: Philipp Zabel <philipp.zabel@gmail.com> # Magician maintainer
Cc: Daniel Mack <zonque@gmail.com> # Raumfeld maintainer
Cc: Marc Zyngier <marc.zyngier@arm.com> # Zeus maintainer
Cc: Geert Uytterhoeven <geert+renesas@glider.be> # SuperH pinctrl/GPIO maintainer
Cc: Russell King <rmk+kernel@armlinux.org.uk> # SA1100
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on mainline with Blackfin gone and other changes.
- Fix up the new users that appeared in sa1100
- Drop some suplus comments in x86.
---
 arch/arm/mach-imx/mach-mx21ads.c              | 13 +++++++-
 arch/arm/mach-imx/mach-mx27ads.c              | 12 ++++++-
 arch/arm/mach-mmp/brownstone.c                | 12 ++++++-
 arch/arm/mach-omap1/board-ams-delta.c         | 14 +++++++-
 arch/arm/mach-omap2/pdata-quirks.c            | 16 ++++++++-
 arch/arm/mach-pxa/em-x270.c                   |  1 -
 arch/arm/mach-pxa/ezx.c                       | 33 ++++++++++++-------
 arch/arm/mach-pxa/magician.c                  |  2 +-
 arch/arm/mach-pxa/raumfeld.c                  | 12 +++++--
 arch/arm/mach-pxa/zeus.c                      | 23 +++++++++++--
 arch/arm/mach-s3c64xx/mach-crag6410.c         |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |  1 -
 arch/arm/mach-sa1100/assabet.c                | 21 ++++++++----
 arch/arm/mach-sa1100/generic.c                |  5 +--
 arch/arm/mach-sa1100/generic.h                |  3 +-
 arch/arm/mach-sa1100/shannon.c                |  4 +--
 arch/sh/boards/mach-ecovec24/setup.c          | 22 +++++++++++--
 .../intel-mid/device_libs/platform_bcm43xx.c  | 17 ++++++++--
 drivers/regulator/fixed-helper.c              |  1 -
 drivers/regulator/fixed.c                     | 33 +++++++++----------
 include/linux/regulator/fixed.h               |  3 --
 21 files changed, 187 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 5e366824814f..5d3b6b4fe6db 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -18,6 +18,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -175,6 +176,7 @@ static struct resource mx21ads_mmgpio_resource =
 	DEFINE_RES_MEM_NAMED(MX21ADS_IO_REG, SZ_2, "dat");
 
 static struct bgpio_pdata mx21ads_mmgpio_pdata = {
+	.label	= "mx21ads-mmgpio",
 	.base	= MX21ADS_MMGPIO_BASE,
 	.ngpio	= 16,
 };
@@ -203,7 +205,6 @@ static struct regulator_init_data mx21ads_lcd_regulator_init_data = {
 static struct fixed_voltage_config mx21ads_lcd_regulator_pdata = {
 	.supply_name	= "LCD",
 	.microvolts	= 3300000,
-	.gpio		= MX21ADS_IO_LCDON,
 	.enable_high	= 1,
 	.init_data	= &mx21ads_lcd_regulator_init_data,
 };
@@ -216,6 +217,15 @@ static struct platform_device mx21ads_lcd_regulator = {
 	},
 };
 
+static struct gpiod_lookup_table mx21ads_lcd_regulator_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
+	.table = {
+		GPIO_LOOKUP("mx21ads-mmgpio", 9,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /*
  * Connected is a portrait Sharp-QVGA display
  * of type: LQ035Q7DB02
@@ -311,6 +321,7 @@ static void __init mx21ads_late_init(void)
 {
 	imx21_add_mxc_mmc(0, &mx21ads_sdhc_pdata);
 
+	gpiod_add_lookup_table(&mx21ads_lcd_regulator_gpiod_table);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 	mx21ads_cs8900_resources[1].start =
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index a04bb094ded1..0fdb88db0cbd 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/driver.h>
 /* Needed for gpio_to_irq() */
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
@@ -230,10 +231,17 @@ static struct regulator_init_data mx27ads_lcd_regulator_init_data = {
 static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
 	.supply_name	= "LCD",
 	.microvolts	= 3300000,
-	.gpio		= MX27ADS_LCD_GPIO,
 	.init_data	= &mx27ads_lcd_regulator_init_data,
 };
 
+static struct gpiod_lookup_table mx27ads_lcd_regulator_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0", /* Let's hope ID 0 is what we get */
+	.table = {
+		GPIO_LOOKUP("LCD", 0, "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init mx27ads_regulator_init(void)
 {
 	struct gpio_chip *vchip;
@@ -247,6 +255,8 @@ static void __init mx27ads_regulator_init(void)
 	vchip->set		= vgpio_set;
 	gpiochip_add_data(vchip, NULL);
 
+	gpiod_add_lookup_table(&mx27ads_lcd_regulator_gpiod_table);
+
 	platform_device_register_data(NULL, "reg-fixed-voltage",
 				      PLATFORM_DEVID_AUTO,
 				      &mx27ads_lcd_regulator_pdata,
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index d1613b954926..563b5a278d65 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio-pxa.h>
+#include <linux/gpio/machine.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
@@ -148,7 +149,6 @@ static struct regulator_init_data brownstone_v_5vp_data = {
 static struct fixed_voltage_config brownstone_v_5vp = {
 	.supply_name		= "v_5vp",
 	.microvolts		= 5000000,
-	.gpio			= GPIO_5V_ENABLE,
 	.enable_high		= 1,
 	.enabled_at_boot	= 1,
 	.init_data		= &brownstone_v_5vp_data,
@@ -162,6 +162,15 @@ static struct platform_device brownstone_v_5vp_device = {
 	},
 };
 
+static struct gpiod_lookup_table brownstone_v_5vp_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.1", /* .id set to 1 above */
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO_5V_ENABLE,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct max8925_platform_data brownstone_max8925_info = {
 	.irq_base		= MMP_NR_IRQS,
 };
@@ -217,6 +226,7 @@ static void __init brownstone_init(void)
 	mmp2_add_isram(&mmp2_isram_platdata);
 
 	/* enable 5v regulator */
+	gpiod_add_lookup_table(&brownstone_v_5vp_gpiod_table);
 	platform_device_register(&brownstone_v_5vp_device);
 }
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 52e8e53ca154..759fa18f6ab4 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -203,6 +204,7 @@ static struct resource latch2_resources[] = {
 };
 
 static struct bgpio_pdata latch2_pdata = {
+	.label	= "ams-delta-latch2",
 	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
 };
@@ -272,7 +274,6 @@ static struct regulator_init_data modem_nreset_data = {
 static struct fixed_voltage_config modem_nreset_config = {
 	.supply_name		= "modem_nreset",
 	.microvolts		= 3300000,
-	.gpio			= AMS_DELTA_GPIO_PIN_MODEM_NRESET,
 	.startup_delay		= 25000,
 	.enable_high		= 1,
 	.enabled_at_boot	= 1,
@@ -287,6 +288,16 @@ static struct platform_device modem_nreset_device = {
 	},
 };
 
+static struct gpiod_lookup_table modem_nreset_gpiod_table = {
+	.dev_id = "reg-fixed-voltage",
+	.table = {
+		/* The AMS_DELTA_GPIO_PIN_MODEM_NRESET is at offset 12 */
+		GPIO_LOOKUP("ams-delta-latch2", 12,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 struct modem_private_data {
 	struct regulator *regulator;
 };
@@ -570,6 +581,7 @@ static int __init late_init(void)
 
 	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
 
+	gpiod_add_lookup_table(&modem_nreset_gpiod_table);
 	err = platform_device_register(&modem_nreset_device);
 	if (err) {
 		pr_err("Couldn't register the modem regulator device\n");
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6459816c2879..7d1447204fb8 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/davinci_emac.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -330,7 +331,6 @@ static struct regulator_init_data pandora_vmmc3 = {
 static struct fixed_voltage_config pandora_vwlan = {
 	.supply_name		= "vwlan",
 	.microvolts		= 1800000, /* 1.8V */
-	.gpio			= PANDORA_WIFI_NRESET_GPIO,
 	.startup_delay		= 50000, /* 50ms */
 	.enable_high		= 1,
 	.init_data		= &pandora_vmmc3,
@@ -344,6 +344,19 @@ static struct platform_device pandora_vwlan_device = {
 	},
 };
 
+static struct gpiod_lookup_table pandora_vwlan_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.1",
+	.table = {
+		/*
+		 * As this is a low GPIO number it should be at the first
+		 * GPIO bank.
+		 */
+		GPIO_LOOKUP("gpio-0-31", PANDORA_WIFI_NRESET_GPIO,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void pandora_wl1251_init_card(struct mmc_card *card)
 {
 	/*
@@ -405,6 +418,7 @@ static void __init pandora_wl1251_init(void)
 static void __init omap3_pandora_legacy_init(void)
 {
 	platform_device_register(&pandora_backlight);
+	gpiod_add_lookup_table(&pandora_vwlan_gpiod_table);
 	platform_device_register(&pandora_vwlan_device);
 	omap_hsmmc_init(pandora_mmc3);
 	omap_hsmmc_late_init(pandora_mmc3);
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 49022ad338e9..6d7d93981098 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -987,7 +987,6 @@ static struct fixed_voltage_config camera_dummy_config = {
 	.supply_name		= "camera_vdd",
 	.input_supply		= "vcc cam",
 	.microvolts		= 2800000,
-	.gpio			= -1,
 	.enable_high		= 0,
 	.init_data		= &camera_dummy_initdata,
 };
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 2c90b58f347d..2b4bd6d94855 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -21,6 +21,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds-lp3944.h>
 #include <linux/platform_data/i2c-pxa.h>
@@ -698,31 +699,39 @@ static struct pxa27x_keypad_platform_data e2_keypad_platform_data = {
 
 #if defined(CONFIG_MACH_EZX_A780) || defined(CONFIG_MACH_EZX_A910)
 /* camera */
-static struct regulator_consumer_supply camera_dummy_supplies[] = {
+static struct regulator_consumer_supply camera_regulator_supplies[] = {
 	REGULATOR_SUPPLY("vdd", "0-005d"),
 };
 
-static struct regulator_init_data camera_dummy_initdata = {
-	.consumer_supplies = camera_dummy_supplies,
-	.num_consumer_supplies = ARRAY_SIZE(camera_dummy_supplies),
+static struct regulator_init_data camera_regulator_initdata = {
+	.consumer_supplies = camera_regulator_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(camera_regulator_supplies),
 	.constraints = {
 		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 	},
 };
 
-static struct fixed_voltage_config camera_dummy_config = {
+static struct fixed_voltage_config camera_regulator_config = {
 	.supply_name		= "camera_vdd",
 	.microvolts		= 2800000,
-	.gpio			= GPIO50_nCAM_EN,
 	.enable_high		= 0,
-	.init_data		= &camera_dummy_initdata,
+	.init_data		= &camera_regulator_initdata,
 };
 
-static struct platform_device camera_supply_dummy_device = {
+static struct platform_device camera_supply_regulator_device = {
 	.name	= "reg-fixed-voltage",
 	.id	= 1,
 	.dev	= {
-		.platform_data = &camera_dummy_config,
+		.platform_data = &camera_regulator_config,
+	},
+};
+
+static struct gpiod_lookup_table camera_supply_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.1",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO50_nCAM_EN,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
 	},
 };
 #endif
@@ -800,7 +809,7 @@ static struct i2c_board_info a780_i2c_board_info[] = {
 
 static struct platform_device *a780_devices[] __initdata = {
 	&a780_gpio_keys,
-	&camera_supply_dummy_device,
+	&camera_supply_regulator_device,
 };
 
 static void __init a780_init(void)
@@ -823,6 +832,7 @@ static void __init a780_init(void)
 	if (a780_camera_init() == 0)
 		pxa_set_camera_info(&a780_pxacamera_platform_data);
 
+	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
@@ -892,6 +902,7 @@ static void __init e680_init(void)
 
 	pxa_set_keypad_info(&e680_keypad_platform_data);
 
+	gpiod_add_lookup_table(&camera_supply_gpiod_table);
 	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(e680_devices));
@@ -1098,7 +1109,7 @@ static struct i2c_board_info __initdata a910_i2c_board_info[] = {
 
 static struct platform_device *a910_devices[] __initdata = {
 	&a910_gpio_keys,
-	&camera_supply_dummy_device,
+	&camera_supply_regulator_device,
 };
 
 static void __init a910_init(void)
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index c5325d1ae77b..14c0f80bc9e7 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/mfd/htc-pasic3.h>
@@ -696,7 +697,6 @@ static struct regulator_init_data vads7846_regulator = {
 static struct fixed_voltage_config vads7846 = {
 	.supply_name	= "vads7846",
 	.microvolts	= 3300000, /* probably */
-	.gpio		= -EINVAL,
 	.startup_delay	= 0,
 	.init_data	= &vads7846_regulator,
 };
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 034345546f84..ee766e4ebddc 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -886,7 +886,6 @@ static struct regulator_init_data audio_va_initdata = {
 static struct fixed_voltage_config audio_va_config = {
 	.supply_name		= "audio_va",
 	.microvolts		= 5000000,
-	.gpio			= GPIO_AUDIO_VA_ENABLE,
 	.enable_high		= 1,
 	.enabled_at_boot	= 0,
 	.init_data		= &audio_va_initdata,
@@ -900,6 +899,15 @@ static struct platform_device audio_va_device = {
 	},
 };
 
+static struct gpiod_lookup_table audio_va_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO_AUDIO_VA_ENABLE,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* Dummy supplies for Codec's VD/VLC */
 
 static struct regulator_consumer_supply audio_dummy_supplies[] = {
@@ -918,7 +926,6 @@ static struct regulator_init_data audio_dummy_initdata = {
 static struct fixed_voltage_config audio_dummy_config = {
 	.supply_name		= "audio_vd",
 	.microvolts		= 3300000,
-	.gpio			= -1,
 	.init_data		= &audio_dummy_initdata,
 };
 
@@ -1033,6 +1040,7 @@ static void __init raumfeld_audio_init(void)
 	else
 		gpio_direction_output(GPIO_MCLK_RESET, 1);
 
+	gpiod_add_lookup_table(&audio_va_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(audio_regulator_devices));
 }
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index e3851795d6d7..58e05afcece0 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/pm.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/serial_8250.h>
 #include <linux/dm9000.h>
 #include <linux/mmc/host.h>
@@ -410,7 +411,6 @@ static struct regulator_init_data can_regulator_init_data = {
 static struct fixed_voltage_config can_regulator_pdata = {
 	.supply_name	= "CAN_SHDN",
 	.microvolts	= 3300000,
-	.gpio		= ZEUS_CAN_SHDN_GPIO,
 	.init_data	= &can_regulator_init_data,
 };
 
@@ -422,6 +422,15 @@ static struct platform_device can_regulator_device = {
 	},
 };
 
+static struct gpiod_lookup_table can_regulator_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", ZEUS_CAN_SHDN_GPIO,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct mcp251x_platform_data zeus_mcp2515_pdata = {
 	.oscillator_frequency	= 16*1000*1000,
 };
@@ -538,7 +547,6 @@ static struct regulator_init_data zeus_ohci_regulator_data = {
 static struct fixed_voltage_config zeus_ohci_regulator_config = {
 	.supply_name		= "vbus2",
 	.microvolts		= 5000000, /* 5.0V */
-	.gpio			= ZEUS_USB2_PWREN_GPIO,
 	.enable_high		= 1,
 	.startup_delay		= 0,
 	.init_data		= &zeus_ohci_regulator_data,
@@ -552,6 +560,15 @@ static struct platform_device zeus_ohci_regulator_device = {
 	},
 };
 
+static struct gpiod_lookup_table zeus_ohci_regulator_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", ZEUS_USB2_PWREN_GPIO,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.port_mode	= PMM_NPS_MODE,
 	/* Clear Power Control Polarity Low and set Power Sense
@@ -855,6 +872,8 @@ static void __init zeus_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(zeus_pin_config));
 
+	gpiod_add_lookup_table(&can_regulator_gpiod_table);
+	gpiod_add_lookup_table(&zeus_ohci_regulator_gpiod_table);
 	platform_add_devices(zeus_devices, ARRAY_SIZE(zeus_devices));
 
 	zeus_register_ohci();
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index f04650297487..379424d72ae7 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -352,7 +352,6 @@ static struct fixed_voltage_config wallvdd_pdata = {
 	.supply_name = "WALLVDD",
 	.microvolts = 5000000,
 	.init_data = &wallvdd_data,
-	.gpio = -EINVAL,
 };
 
 static struct platform_device wallvdd_device = {
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index c46fa5dfd2e0..908e5aa831c8 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -222,7 +222,6 @@ static struct fixed_voltage_config smdk6410_b_pwr_5v_pdata = {
 	.supply_name = "B_PWR_5V",
 	.microvolts = 5000000,
 	.init_data = &smdk6410_b_pwr_5v_data,
-	.gpio = -EINVAL,
 };
 
 static struct platform_device smdk6410_b_pwr_5v = {
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 575ec085cffa..dbb53c520165 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -101,7 +101,7 @@ static int __init assabet_init_gpio(void __iomem *reg, u32 def_val)
 
 	assabet_bcr_gc = gc;
 
-	return gc->base;
+	return 0;
 }
 
 /*
@@ -471,6 +471,14 @@ static struct fixed_voltage_config assabet_cf_vcc_pdata __initdata = {
 	.enable_high = 1,
 };
 
+static struct gpiod_lookup_table assabet_cf_vcc_gpio_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		GPIO_LOOKUP("assabet", 0, "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init assabet_init(void)
 {
 	/*
@@ -517,9 +525,11 @@ static void __init assabet_init(void)
 			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
 	} else {
+		gpiod_add_lookup_table(&assabet_cf_vcc_gpio_table);
 		sa11x0_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
-					 assabet_cf_vcc_consumers,
-					 ARRAY_SIZE(assabet_cf_vcc_consumers));
+					assabet_cf_vcc_consumers,
+					ARRAY_SIZE(assabet_cf_vcc_consumers),
+					true);
 
 	}
 
@@ -802,7 +812,6 @@ fs_initcall(assabet_leds_init);
 
 void __init assabet_init_irq(void)
 {
-	unsigned int assabet_gpio_base;
 	u32 def_val;
 
 	sa1100_init_irq();
@@ -817,9 +826,7 @@ void __init assabet_init_irq(void)
 	 *
 	 * This must precede any driver calls to BCR_set() or BCR_clear().
 	 */
-	assabet_gpio_base = assabet_init_gpio((void *)&ASSABET_BCR, def_val);
-
-	assabet_cf_vcc_pdata.gpio = assabet_gpio_base + 0;
+	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
 }
 
 MACHINE_START(ASSABET, "Intel-Assabet")
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 7167ddf84a0e..800321c6cbd8 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -348,7 +348,8 @@ void __init sa11x0_init_late(void)
 
 int __init sa11x0_register_fixed_regulator(int n,
 	struct fixed_voltage_config *cfg,
-	struct regulator_consumer_supply *supplies, unsigned num_supplies)
+	struct regulator_consumer_supply *supplies, unsigned num_supplies,
+	bool uses_gpio)
 {
 	struct regulator_init_data *id;
 
@@ -356,7 +357,7 @@ int __init sa11x0_register_fixed_regulator(int n,
 	if (!cfg->init_data)
 		return -ENOMEM;
 
-	if (cfg->gpio < 0)
+	if (!uses_gpio)
 		id->constraints.always_on = 1;
 	id->constraints.name = cfg->supply_name;
 	id->constraints.min_uV = cfg->microvolts;
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 5f3cb52fa6ab..158a4fd5ca24 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -54,4 +54,5 @@ void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *);
 struct fixed_voltage_config;
 struct regulator_consumer_supply;
 int sa11x0_register_fixed_regulator(int n, struct fixed_voltage_config *cfg,
-	struct regulator_consumer_supply *supplies, unsigned num_supplies);
+	struct regulator_consumer_supply *supplies, unsigned num_supplies,
+	bool uses_gpio);
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 22f7fe0b809f..5bc82e2671c6 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -102,14 +102,14 @@ static struct fixed_voltage_config shannon_cf_vcc_pdata __initdata = {
 	.supply_name = "cf-power",
 	.microvolts = 3300000,
 	.enabled_at_boot = 1,
-	.gpio = -EINVAL,
 };
 
 static void __init shannon_init(void)
 {
 	sa11x0_register_fixed_regulator(0, &shannon_cf_vcc_pdata,
 					shannon_cf_vcc_consumers,
-					ARRAY_SIZE(shannon_cf_vcc_consumers));
+					ARRAY_SIZE(shannon_cf_vcc_consumers),
+					false);
 	sa11x0_register_pcmcia(0, &shannon_pcmcia0_gpio_table);
 	sa11x0_register_pcmcia(1, &shannon_pcmcia1_gpio_table);
 	sa11x0_ppc_configure_mcp();
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index adc61d14172c..c296b5c399b7 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -633,7 +633,6 @@ static struct regulator_init_data cn12_power_init_data = {
 static struct fixed_voltage_config cn12_power_info = {
 	.supply_name = "CN12 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.gpio = GPIO_PTB7,
 	.enable_high = 1,
 	.init_data = &cn12_power_init_data,
 };
@@ -646,6 +645,16 @@ static struct platform_device cn12_power = {
 	},
 };
 
+static struct gpiod_lookup_table cn12_power_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.0",
+	.table = {
+		/* Offset 7 on port B */
+		GPIO_LOOKUP("sh7724_pfc", GPIO_PTB7,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 /* SDHI0 */
 static struct regulator_consumer_supply sdhi0_power_consumers[] =
@@ -665,7 +674,6 @@ static struct regulator_init_data sdhi0_power_init_data = {
 static struct fixed_voltage_config sdhi0_power_info = {
 	.supply_name = "CN11 SD/MMC Vdd",
 	.microvolts = 3300000,
-	.gpio = GPIO_PTB6,
 	.enable_high = 1,
 	.init_data = &sdhi0_power_init_data,
 };
@@ -678,6 +686,16 @@ static struct platform_device sdhi0_power = {
 	},
 };
 
+static struct gpiod_lookup_table sdhi0_power_gpiod_table = {
+	.dev_id = "reg-fixed-voltage.1",
+	.table = {
+		/* Offset 6 on port B */
+		GPIO_LOOKUP("sh7724_pfc", GPIO_PTB6,
+			    "enable", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct tmio_mmc_data sdhi0_info = {
 	.chan_priv_tx	= (void *)SHDMA_SLAVE_SDHI0_TX,
 	.chan_priv_rx	= (void *)SHDMA_SLAVE_SDHI0_RX,
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
index 4392c15ed9e0..fc77d69e51d7 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
@@ -10,7 +10,7 @@
  * of the License.
  */
 
-#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
@@ -43,7 +43,6 @@ static struct fixed_voltage_config bcm43xx_vmmc = {
 	 * real voltage and signaling are still 1.8V.
 	 */
 	.microvolts		= 2000000,		/* 1.8V */
-	.gpio			= -EINVAL,
 	.startup_delay		= 250 * 1000,		/* 250ms */
 	.enable_high		= 1,			/* active high */
 	.enabled_at_boot	= 0,			/* disabled at boot */
@@ -58,11 +57,23 @@ static struct platform_device bcm43xx_vmmc_regulator = {
 	},
 };
 
+static struct gpiod_lookup_table bcm43xx_vmmc_gpio_table = {
+	.dev_id	= "reg-fixed-voltage.0",
+	.table	= {
+		GPIO_LOOKUP("0000:00:0c.0", -1, "enable", GPIO_ACTIVE_LOW),
+		{}
+	},
+};
+
 static int __init bcm43xx_regulator_register(void)
 {
+	struct gpiod_lookup_table *table = &bcm43xx_vmmc_gpio_table;
+	struct gpiod_lookup *lookup = table->table;
 	int ret;
 
-	bcm43xx_vmmc.gpio = get_gpio_by_name(WLAN_SFI_GPIO_ENABLE_NAME);
+	lookup[0].chip_hwnum = get_gpio_by_name(WLAN_SFI_GPIO_ENABLE_NAME);
+	gpiod_add_lookup_table(table);
+
 	ret = platform_device_register(&bcm43xx_vmmc_regulator);
 	if (ret) {
 		pr_err("%s: vmmc regulator register failed\n", __func__);
diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 777fac6fb4cb..2c6098e6f4bc 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -43,7 +43,6 @@ struct platform_device *regulator_register_always_on(int id, const char *name,
 	}
 
 	data->cfg.microvolts = uv;
-	data->cfg.gpio = -EINVAL;
 	data->cfg.enabled_at_boot = 1;
 	data->cfg.init_data = &data->init_data;
 
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 988a7472c2ab..1142f195529b 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -24,10 +24,9 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/fixed.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 
@@ -78,10 +77,6 @@ of_get_fixed_voltage_config(struct device *dev,
 	if (init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
-	config->gpio = of_get_named_gpio(np, "gpio", 0);
-	if ((config->gpio < 0) && (config->gpio != -ENOENT))
-		return ERR_PTR(config->gpio);
-
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
 	config->enable_high = of_property_read_bool(np, "enable-active-high");
@@ -102,6 +97,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	struct fixed_voltage_config *config;
 	struct fixed_voltage_data *drvdata;
 	struct regulator_config cfg = { };
+	enum gpiod_flags gflags;
 	int ret;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct fixed_voltage_data),
@@ -150,25 +146,28 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	if (gpio_is_valid(config->gpio)) {
-		cfg.ena_gpio = config->gpio;
-		if (pdev->dev.of_node)
-			cfg.ena_gpio_initialized = true;
-	}
 	cfg.ena_gpio_invert = !config->enable_high;
 	if (config->enabled_at_boot) {
 		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+			gflags = GPIOD_OUT_HIGH;
 		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
+			gflags = GPIOD_OUT_LOW;
 	} else {
 		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
+			gflags = GPIOD_OUT_LOW;
 		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+			gflags = GPIOD_OUT_HIGH;
 	}
-	if (config->gpio_is_open_drain)
-		cfg.ena_gpio_flags |= GPIOF_OPEN_DRAIN;
+	if (config->gpio_is_open_drain) {
+		if (gflags == GPIOD_OUT_HIGH)
+			gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
+		else
+			gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
+	}
+
+	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
+	if (IS_ERR(cfg.ena_gpiod))
+		return PTR_ERR(cfg.ena_gpiod);
 
 	cfg.dev = &pdev->dev;
 	cfg.init_data = config->init_data;
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index 48918be649d4..1a4340ed8e2b 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -24,8 +24,6 @@ struct regulator_init_data;
  * @supply_name:	Name of the regulator supply
  * @input_supply:	Name of the input regulator supply
  * @microvolts:		Output voltage of regulator
- * @gpio:		GPIO to use for enable control
- * 			set to -EINVAL if not used
  * @startup_delay:	Start-up time in microseconds
  * @gpio_is_open_drain: Gpio pin is open drain or normal type.
  *			If it is open drain type then HIGH will be set
@@ -49,7 +47,6 @@ struct fixed_voltage_config {
 	const char *supply_name;
 	const char *input_supply;
 	int microvolts;
-	int gpio;
 	unsigned startup_delay;
 	unsigned gpio_is_open_drain:1;
 	unsigned enable_high:1;
-- 
2.17.0

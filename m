Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22920C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18072064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ksZufzk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfANVRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:17:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52264 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfANVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:17:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ELHfBR064129;
        Mon, 14 Jan 2019 15:17:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547500661;
        bh=7tnLgo+vFMDPkuNtKEN7EnfBbzNtzSNsUfPbGtF6cK8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ksZufzk5JdCWbCeW56Iz6ycUlYiF+H+rXgo04K2+ams98sg3Qy1plh6i2F558+Hos
         COs8Qeulbdhd0u0/ZhetueW586z3U88VzwRr7ti4ZaRApMyweSDdLi1eIXgerdFsh8
         OeCnr+Osuxfdbi7gAQ7UgwqL8vxOizX1ESKpYIDc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ELHfrR057466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 15:17:41 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 15:17:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 15:17:40 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ELHekw016552;
        Mon, 14 Jan 2019 15:17:40 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.100.22])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0ELHeU00274;
        Mon, 14 Jan 2019 15:17:40 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-leds@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jacek.anaszewski@gmail.com>,
        <pavel@ucw.cz>, <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED driver
Date:   Mon, 14 Jan 2019 15:17:23 -0600
Message-ID: <20190114211723.11186-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190114211723.11186-1-dmurphy@ti.com>
References: <20190114211723.11186-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the LP5036/30/24/18 RGB LED driver.
The difference in these parts are the number of
LED outputs where the:

LP5036 can control 36 LEDs
LP5030 can control 30 LEDs
LP5024 can control 24 LEDs
LP5018 can control 18 LEDs

The device has the ability to group LED output into control banks
so that multiple LED banks can be controlled with the same mixing and
brightness.  Inversely the LEDs can also be controlled independently.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Changed the mix and module files to a single "color" file, added the LP5030
and LP5036 register mapping, added ABI documentation, updated the parsing of
DT and led sources to match DT, renamed driver to leds-lp50xx.c - https://lore.kernel.org/patchwork/patch/1026515/

 Documentation/leds/leds-lp50xx.txt |  36 ++
 drivers/leds/Kconfig               |   7 +
 drivers/leds/Makefile              |   1 +
 drivers/leds/leds-lp50xx.c         | 754 +++++++++++++++++++++++++++++
 4 files changed, 798 insertions(+)
 create mode 100644 Documentation/leds/leds-lp50xx.txt
 create mode 100644 drivers/leds/leds-lp50xx.c

diff --git a/Documentation/leds/leds-lp50xx.txt b/Documentation/leds/leds-lp50xx.txt
new file mode 100644
index 000000000000..8b1b01dfdd22
--- /dev/null
+++ b/Documentation/leds/leds-lp50xx.txt
@@ -0,0 +1,36 @@
+LP5018/LP5024/LP5030/LP5036 Common Driver
+=================================================
+
+Authors: Dan Murphy <dmurphy@ti.com>
+
+Description
+-----------
+The LP50XX RGB LED drivers have the ability to group multiple RGB cluster
+LEDs into a single group for simultaneous control or expose single RGB cluster
+for control.  This device exposes different register interfaces to control
+the cluster brightness as well as the individual RGB LEDs color intensity.
+
+RGB Cluster Color Control
+-------------------------
+The LP50xx driver will expose a file called "color" for each LED class instance
+defined.  This file will accept a 24-bit RGB value in which the the color of the
+RGB LEDs will be set.
+
+The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
+XX - Do not care ignored by the driver
+RR - is the 8 bit Red LED value
+GG - is the 8 bit Green LED value
+BB - is the 8 bit Blue LED value
+
+Example:
+LED module output 4 of the LP5024 will be a yellow color:
+echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
+
+LED module output 4 of the LP5024 will be dimmed 50%:
+echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
+
+LED banked RGBs of the LP5036 will be a white color:
+echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
+
+LED banked RGBs of the LP50364 will be dimmed 50%:
+echo 0x80 > /sys/class/leds/lp5036\:led_banked/brightness
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..5f413445a667 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -326,6 +326,13 @@ config LEDS_LP3952
 	  To compile this driver as a module, choose M here: the
 	  module will be called leds-lp3952.
 
+config LEDS_LP50XX
+	tristate "LED Support for TI LP5036/30/24/18 LED driver chip"
+	depends on LEDS_CLASS && REGMAP_I2C
+	help
+	  If you say yes here you get support for the Texas Instruments
+	  LP5036, LP5030, LP5024 and LP5018 LED driver.
+
 config LEDS_LP55XX_COMMON
 	tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
 	depends on LEDS_LP5521 || LEDS_LP5523 || LEDS_LP5562 || LEDS_LP8501
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4c1b0054f379..852eff0b773f 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_LEDS_GPIO_REGISTER)	+= leds-gpio-register.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
 obj-$(CONFIG_LEDS_LP3944)		+= leds-lp3944.o
 obj-$(CONFIG_LEDS_LP3952)		+= leds-lp3952.o
+obj-$(CONFIG_LEDS_LP50XX)		+= leds-lp50xx.o
 obj-$(CONFIG_LEDS_LP55XX_COMMON)	+= leds-lp55xx-common.o
 obj-$(CONFIG_LEDS_LP5521)		+= leds-lp5521.o
 obj-$(CONFIG_LEDS_LP5523)		+= leds-lp5523.o
diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
new file mode 100644
index 000000000000..41bb2e0129c8
--- /dev/null
+++ b/drivers/leds/leds-lp50xx.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0
+/* TI LP50XX LED chip family driver
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <uapi/linux/uleds.h>
+
+#define LP50XX_DEV_CFG0		0x00
+#define LP50XX_DEV_CFG1		0x01
+#define LP50XX_LED_CFG0		0x02
+
+/* LP5018 and LP5024 registers */
+#define LP5024_BNK_BRT		0x03
+#define LP5024_BNKA_CLR		0x04
+#define LP5024_BNKB_CLR		0x05
+#define LP5024_BNKC_CLR		0x06
+#define LP5024_LED0_BRT		0x07
+#define LP5024_LED1_BRT		0x08
+#define LP5024_LED2_BRT		0x09
+#define LP5024_LED3_BRT		0x0a
+#define LP5024_LED4_BRT		0x0b
+#define LP5024_LED5_BRT		0x0c
+#define LP5024_LED6_BRT		0x0d
+#define LP5024_LED7_BRT		0x0e
+
+#define LP5024_OUT0_CLR		0x0f
+#define LP5024_OUT1_CLR		0x10
+#define LP5024_OUT2_CLR		0x11
+#define LP5024_OUT3_CLR		0x12
+#define LP5024_OUT4_CLR		0x13
+#define LP5024_OUT5_CLR		0x14
+#define LP5024_OUT6_CLR		0x15
+#define LP5024_OUT7_CLR		0x16
+#define LP5024_OUT8_CLR		0x17
+#define LP5024_OUT9_CLR		0x18
+#define LP5024_OUT10_CLR	0x19
+#define LP5024_OUT11_CLR	0x1a
+#define LP5024_OUT12_CLR	0x1b
+#define LP5024_OUT13_CLR	0x1c
+#define LP5024_OUT14_CLR	0x1d
+#define LP5024_OUT15_CLR	0x1e
+#define LP5024_OUT16_CLR	0x1f
+#define LP5024_OUT17_CLR	0x20
+#define LP5024_OUT18_CLR	0x21
+#define LP5024_OUT19_CLR	0x22
+#define LP5024_OUT20_CLR	0x23
+#define LP5024_OUT21_CLR	0x24
+#define LP5024_OUT22_CLR	0x25
+#define LP5024_OUT23_CLR	0x26
+#define LP5024_RESET		0x27
+
+/* LP5030 and LP5036 registers */
+#define LP5036_LED_CFG1		0x03
+#define LP5036_BNK_BRT		0x04
+#define LP5036_BNKA_CLR		0x05
+#define LP5036_BNKB_CLR		0x06
+#define LP5036_BNKC_CLR		0x07
+#define LP5036_LED0_BRT		0x08
+#define LP5036_LED1_BRT		0x09
+#define LP5036_LED2_BRT		0x0a
+#define LP5036_LED3_BRT		0x0b
+#define LP5036_LED4_BRT		0x0c
+#define LP5036_LED5_BRT		0x0d
+#define LP5036_LED6_BRT		0x0e
+#define LP5036_LED7_BRT		0x0f
+#define LP5036_LED8_BRT		0x10
+#define LP5036_LED9_BRT		0x11
+#define LP5036_LED10_BRT	0x12
+#define LP5036_LED11_BRT	0x13
+
+#define LP5036_OUT0_CLR		0x14
+#define LP5036_OUT1_CLR		0x15
+#define LP5036_OUT2_CLR		0x16
+#define LP5036_OUT3_CLR		0x17
+#define LP5036_OUT4_CLR		0x18
+#define LP5036_OUT5_CLR		0x19
+#define LP5036_OUT6_CLR		0x1a
+#define LP5036_OUT7_CLR		0x1b
+#define LP5036_OUT8_CLR		0x1c
+#define LP5036_OUT9_CLR		0x1d
+#define LP5036_OUT10_CLR	0x1e
+#define LP5036_OUT11_CLR	0x1f
+#define LP5036_OUT12_CLR	0x20
+#define LP5036_OUT13_CLR	0x21
+#define LP5036_OUT14_CLR	0x22
+#define LP5036_OUT15_CLR	0x23
+#define LP5036_OUT16_CLR	0x24
+#define LP5036_OUT17_CLR	0x25
+#define LP5036_OUT18_CLR	0x26
+#define LP5036_OUT19_CLR	0x27
+#define LP5036_OUT20_CLR	0x28
+#define LP5036_OUT21_CLR	0x29
+#define LP5036_OUT22_CLR	0x2a
+#define LP5036_OUT23_CLR	0x2b
+#define LP5036_OUT24_CLR	0x2c
+#define LP5036_OUT25_CLR	0x2d
+#define LP5036_OUT26_CLR	0x2e
+#define LP5036_OUT27_CLR	0x2f
+#define LP5036_OUT28_CLR	0x30
+#define LP5036_OUT29_CLR	0x31
+#define LP5036_OUT30_CLR	0x32
+#define LP5036_OUT31_CLR	0x33
+#define LP5036_OUT32_CLR	0x34
+#define LP5036_OUT33_CLR	0x35
+#define LP5036_OUT34_CLR	0x36
+#define LP5036_OUT35_CLR	0x37
+#define LP5036_RESET		0x38
+
+#define LP50XX_SW_RESET		0xff
+
+#define LP50XX_CHIP_EN		BIT(6)
+
+#define LP5018_MAX_LED_STRINGS	6
+#define LP5024_MAX_LED_STRINGS	8
+#define LP5030_MAX_LED_STRINGS	10
+#define LP5036_MAX_LED_STRINGS	12
+
+enum lp50xx_model {
+	LP5018,
+	LP5024,
+	LP5030,
+	LP5036,
+};
+
+struct lp50xx_led {
+	u32 led_strings[LP5036_MAX_LED_STRINGS];
+	char label[LED_MAX_NAME_SIZE];
+	struct led_classdev led_dev;
+	struct lp50xx *priv;
+	int led_number;
+	u8 ctrl_bank_enabled;
+};
+
+/**
+ * struct lp50xx -
+ * @enable_gpio: Hardware enable gpio
+ * @regulator: LED supply regulator pointer
+ * @client: Pointer to the I2C client
+ * @regmap: Devices register map
+ * @dev: Pointer to the devices device struct
+ * @lock: Lock for reading/writing the device
+ * @model_id: ID of the device
+ * @leds: Array of LED strings
+ */
+struct lp50xx {
+	struct gpio_desc *enable_gpio;
+	struct regulator *regulator;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+	enum lp50xx_model model_id;
+	int max_leds;
+	int num_of_leds;
+
+	u8 led_brightness0_reg;
+	u8 mix_out0_reg;
+	u8 bank_brt_reg;
+	u8 bank_mix_reg;
+	u8 reset_reg;
+
+	/* This needs to be at the end of the struct */
+	struct lp50xx_led leds[];
+};
+
+static const struct reg_default lp5024_reg_defs[] = {
+	{LP50XX_DEV_CFG0, 0x0},
+	{LP50XX_DEV_CFG1, 0x3c},
+	{LP50XX_LED_CFG0, 0x0},
+	{LP5024_BNK_BRT, 0xff},
+	{LP5024_BNKA_CLR, 0x0f},
+	{LP5024_BNKB_CLR, 0x0f},
+	{LP5024_BNKC_CLR, 0x0f},
+	{LP5024_LED0_BRT, 0x0f},
+	{LP5024_LED1_BRT, 0xff},
+	{LP5024_LED2_BRT, 0xff},
+	{LP5024_LED3_BRT, 0xff},
+	{LP5024_LED4_BRT, 0xff},
+	{LP5024_LED5_BRT, 0xff},
+	{LP5024_LED6_BRT, 0xff},
+	{LP5024_LED7_BRT, 0xff},
+	{LP5024_OUT0_CLR, 0x0f},
+	{LP5024_OUT1_CLR, 0x00},
+	{LP5024_OUT2_CLR, 0x00},
+	{LP5024_OUT3_CLR, 0x00},
+	{LP5024_OUT4_CLR, 0x00},
+	{LP5024_OUT5_CLR, 0x00},
+	{LP5024_OUT6_CLR, 0x00},
+	{LP5024_OUT7_CLR, 0x00},
+	{LP5024_OUT8_CLR, 0x00},
+	{LP5024_OUT9_CLR, 0x00},
+	{LP5024_OUT10_CLR, 0x00},
+	{LP5024_OUT11_CLR, 0x00},
+	{LP5024_OUT12_CLR, 0x00},
+	{LP5024_OUT13_CLR, 0x00},
+	{LP5024_OUT14_CLR, 0x00},
+	{LP5024_OUT15_CLR, 0x00},
+	{LP5024_OUT16_CLR, 0x00},
+	{LP5024_OUT17_CLR, 0x00},
+	{LP5024_OUT18_CLR, 0x00},
+	{LP5024_OUT19_CLR, 0x00},
+	{LP5024_OUT20_CLR, 0x00},
+	{LP5024_OUT21_CLR, 0x00},
+	{LP5024_OUT22_CLR, 0x00},
+	{LP5024_OUT23_CLR, 0x00},
+	{LP5024_RESET, 0x00}
+};
+
+static const struct reg_default lp5036_reg_defs[] = {
+	{LP50XX_DEV_CFG0, 0x0},
+	{LP50XX_DEV_CFG1, 0x3c},
+	{LP50XX_LED_CFG0, 0x0},
+	{LP5036_LED_CFG1, 0x0},
+	{LP5036_BNK_BRT, 0xff},
+	{LP5036_BNKA_CLR, 0x0f},
+	{LP5036_BNKB_CLR, 0x0f},
+	{LP5036_BNKC_CLR, 0x0f},
+	{LP5036_LED0_BRT, 0x0f},
+	{LP5036_LED1_BRT, 0xff},
+	{LP5036_LED2_BRT, 0xff},
+	{LP5036_LED3_BRT, 0xff},
+	{LP5036_LED4_BRT, 0xff},
+	{LP5036_LED5_BRT, 0xff},
+	{LP5036_LED6_BRT, 0xff},
+	{LP5036_LED7_BRT, 0xff},
+	{LP5036_OUT0_CLR, 0x0f},
+	{LP5036_OUT1_CLR, 0x00},
+	{LP5036_OUT2_CLR, 0x00},
+	{LP5036_OUT3_CLR, 0x00},
+	{LP5036_OUT4_CLR, 0x00},
+	{LP5036_OUT5_CLR, 0x00},
+	{LP5036_OUT6_CLR, 0x00},
+	{LP5036_OUT7_CLR, 0x00},
+	{LP5036_OUT8_CLR, 0x00},
+	{LP5036_OUT9_CLR, 0x00},
+	{LP5036_OUT10_CLR, 0x00},
+	{LP5036_OUT11_CLR, 0x00},
+	{LP5036_OUT12_CLR, 0x00},
+	{LP5036_OUT13_CLR, 0x00},
+	{LP5036_OUT14_CLR, 0x00},
+	{LP5036_OUT15_CLR, 0x00},
+	{LP5036_OUT16_CLR, 0x00},
+	{LP5036_OUT17_CLR, 0x00},
+	{LP5036_OUT18_CLR, 0x00},
+	{LP5036_OUT19_CLR, 0x00},
+	{LP5036_OUT20_CLR, 0x00},
+	{LP5036_OUT21_CLR, 0x00},
+	{LP5036_OUT22_CLR, 0x00},
+	{LP5036_OUT23_CLR, 0x00},
+	{LP5036_OUT24_CLR, 0x00},
+	{LP5036_OUT25_CLR, 0x00},
+	{LP5036_OUT26_CLR, 0x00},
+	{LP5036_OUT27_CLR, 0x00},
+	{LP5036_OUT28_CLR, 0x00},
+	{LP5036_OUT29_CLR, 0x00},
+	{LP5036_OUT30_CLR, 0x00},
+	{LP5036_OUT31_CLR, 0x00},
+	{LP5036_OUT32_CLR, 0x00},
+	{LP5036_OUT33_CLR, 0x00},
+	{LP5036_OUT34_CLR, 0x00},
+	{LP5036_OUT35_CLR, 0x00},
+	{LP5036_RESET, 0x00}
+};
+
+static const struct regmap_config lp5024_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LP5024_RESET,
+	.reg_defaults = lp5024_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(lp5024_reg_defs),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct regmap_config lp5036_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LP5036_RESET,
+	.reg_defaults = lp5036_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(lp5036_reg_defs),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static ssize_t color_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct lp50xx_led *led = container_of(led_cdev, struct lp50xx_led,
+					      led_dev);
+	struct lp50xx *priv = led->priv;
+	unsigned int red_val, green_val, blue_val;
+	u8 red_reg, green_reg, blue_reg;
+	u32 mix_value = 0;
+	u8 led_offset;
+	int ret;
+
+	if (led->ctrl_bank_enabled) {
+		red_reg = priv->bank_mix_reg;
+		green_reg = priv->bank_mix_reg + 1;
+		blue_reg = priv->bank_mix_reg + 2;
+	} else {
+		led_offset = (led->led_number * 3);
+		red_reg = priv->mix_out0_reg + led_offset;
+		green_reg = priv->mix_out0_reg + led_offset + 1;
+		blue_reg = priv->mix_out0_reg + led_offset + 2;
+	}
+
+	ret = regmap_read(priv->regmap, red_reg, &red_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot read LED value\n");
+		goto out;
+	}
+
+	ret = regmap_read(priv->regmap, green_reg, &green_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot read LED value\n");
+		goto out;
+	}
+
+	ret = regmap_read(priv->regmap, blue_reg, &blue_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot read LED value\n");
+		goto out;
+	}
+
+	mix_value = (red_val << 16 | green_val << 8 | blue_val);
+
+out:
+	return scnprintf(buf, PAGE_SIZE, "0x%X\n", mix_value);
+}
+
+static ssize_t color_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct lp50xx_led *led = container_of(led_cdev, struct lp50xx_led,
+					      led_dev);
+	struct lp50xx *priv = led->priv;
+	u8 led_offset;
+	unsigned long mix_value;
+	u8 red_reg, green_reg, blue_reg;
+	u8 red_val, green_val, blue_val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &mix_value);
+	if (ret)
+		return ret;
+
+	if (led->ctrl_bank_enabled) {
+		red_reg = priv->bank_mix_reg;
+		green_reg = priv->bank_mix_reg + 1;
+		blue_reg = priv->bank_mix_reg + 2;
+	} else {
+		led_offset = (led->led_number * 3);
+		red_reg = priv->mix_out0_reg + led_offset;
+		green_reg = priv->mix_out0_reg + led_offset + 1;
+		blue_reg = priv->mix_out0_reg + led_offset + 2;
+	}
+
+	red_val = (mix_value & 0xff0000) >> 16;
+	green_val = (mix_value & 0xff00) >> 8;
+	blue_val = (mix_value & 0xff);
+
+	ret = regmap_write(priv->regmap, red_reg, red_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write LED value\n");
+		goto out;
+	}
+
+	ret = regmap_write(priv->regmap, green_reg, green_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write LED value\n");
+		goto out;
+	}
+
+	ret = regmap_write(priv->regmap, blue_reg, blue_val);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write LED value\n");
+		goto out;
+	}
+out:
+	return size;
+}
+
+static DEVICE_ATTR_RW(color);
+
+static struct attribute *lp50xx_led_color_attrs[] = {
+	&dev_attr_color.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(lp50xx_led_color);
+
+static int lp50xx_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lp50xx_led *led = container_of(led_cdev, struct lp50xx_led,
+					      led_dev);
+	int ret = 0;
+	u8 reg_val;
+
+	mutex_lock(&led->priv->lock);
+
+	if (led->ctrl_bank_enabled)
+		reg_val = led->priv->bank_brt_reg;
+	else
+		reg_val = led->priv->led_brightness0_reg + led->led_number;
+
+	ret = regmap_write(led->priv->regmap, reg_val, brt_val);
+
+	mutex_unlock(&led->priv->lock);
+
+	return ret;
+}
+
+static enum led_brightness lp50xx_brightness_get(struct led_classdev *led_cdev)
+{
+	struct lp50xx_led *led = container_of(led_cdev, struct lp50xx_led,
+					      led_dev);
+	unsigned int brt_val;
+	u8 reg_val;
+	int ret;
+
+	mutex_lock(&led->priv->lock);
+
+	if (led->ctrl_bank_enabled)
+		reg_val = led->priv->bank_brt_reg;
+	else
+		reg_val = led->priv->led_brightness0_reg + led->led_number;
+
+	ret = regmap_read(led->priv->regmap, reg_val, &brt_val);
+
+	mutex_unlock(&led->priv->lock);
+
+	return brt_val;
+}
+
+static void lp50xx_set_led_values(struct lp50xx *priv)
+{
+	if (priv->model_id == LP5018 || priv->model_id == LP5024) {
+		priv->led_brightness0_reg = LP5024_LED0_BRT;
+		priv->mix_out0_reg = LP5024_OUT0_CLR;
+		priv->bank_brt_reg = LP5024_BNK_BRT;
+		priv->bank_mix_reg = LP5024_BNKA_CLR;
+		priv->reset_reg = LP5024_RESET;
+	} else {
+		priv->led_brightness0_reg = LP5036_LED0_BRT;
+		priv->mix_out0_reg = LP5036_OUT0_CLR;
+		priv->bank_brt_reg = LP5036_BNK_BRT;
+		priv->bank_mix_reg = LP5036_BNKA_CLR;
+		priv->reset_reg = LP5036_RESET;
+	}
+}
+
+static int lp50xx_set_banks(struct lp50xx *priv)
+{
+	struct lp50xx_led *led;
+	u8 led_ctrl_enable = 0;
+	u8 led1_ctrl_enable = 0;
+	u8 ctrl_ext = 0;
+	int i, j;
+	int ret;
+
+	for (i = 0; i <= priv->num_of_leds; i++) {
+		led = &priv->leds[i];
+		if (!led->ctrl_bank_enabled)
+			continue;
+
+		for (j = 0; j <= priv->max_leds - 1; j++) {
+			if (led->led_strings[j]	> (LP5024_MAX_LED_STRINGS - 1)) {
+				ctrl_ext = led->led_strings[j] - LP5024_MAX_LED_STRINGS;
+				led1_ctrl_enable |= (1 << ctrl_ext);
+			} else {
+				led_ctrl_enable |= (1 << led->led_strings[j]);
+			}
+		}
+	}
+
+	ret = regmap_write(priv->regmap, LP50XX_LED_CFG0, led_ctrl_enable);
+
+	if (led1_ctrl_enable)
+		ret = regmap_write(priv->regmap, LP5036_LED_CFG1,
+				   led1_ctrl_enable);
+
+	return ret;
+}
+
+static int lp50xx_init(struct lp50xx *priv)
+{
+	int ret;
+
+	lp50xx_set_led_values(priv);
+
+	if (priv->enable_gpio) {
+		gpiod_direction_output(priv->enable_gpio, 1);
+	} else {
+		ret = regmap_write(priv->regmap, priv->reset_reg,
+				   LP50XX_SW_RESET);
+		if (ret) {
+			dev_err(&priv->client->dev,
+				"Cannot reset the device\n");
+			goto out;
+		}
+	}
+
+	ret = lp50xx_set_banks(priv);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot set the banks\n");
+		goto out;
+	}
+
+	ret = regmap_write(priv->regmap, LP50XX_DEV_CFG0, LP50XX_CHIP_EN);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
+
+out:
+	return ret;
+}
+
+static int lp50xx_probe_dt(struct lp50xx *priv)
+{
+	struct fwnode_handle *child = NULL;
+	struct lp50xx_led *led;
+	int control_bank_defined = 0;
+	const char *name;
+	int led_number;
+	size_t i = 0;
+	int ret;
+
+	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
+						   "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio)) {
+		ret = PTR_ERR(priv->enable_gpio);
+		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
+			ret);
+		return ret;
+	}
+
+	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
+	if (IS_ERR(priv->regulator))
+		priv->regulator = NULL;
+
+	if (priv->model_id == LP5018)
+		priv->max_leds = LP5018_MAX_LED_STRINGS;
+	else if (priv->model_id == LP5024)
+		priv->max_leds = LP5024_MAX_LED_STRINGS;
+	else if (priv->model_id == LP5030)
+		priv->max_leds = LP5030_MAX_LED_STRINGS;
+	else
+		priv->max_leds = LP5036_MAX_LED_STRINGS;
+
+	device_for_each_child_node(&priv->client->dev, child) {
+		led = &priv->leds[i];
+
+		if (fwnode_property_present(child, "ti,led-bank")) {
+			led->ctrl_bank_enabled = 1;
+			if (!control_bank_defined)
+				control_bank_defined = 1;
+			else {
+				dev_err(&priv->client->dev,
+					"ti,led-bank defined twice\n");
+				fwnode_handle_put(child);
+				goto child_out;
+			}
+		} else {
+			led->ctrl_bank_enabled = 0;
+		}
+
+		if (led->ctrl_bank_enabled) {
+			ret = fwnode_property_read_u32_array(child,
+							     "ti,led-bank",
+							     NULL, 0);
+			ret = fwnode_property_read_u32_array(child,
+							     "ti,led-bank",
+							     led->led_strings,
+							     ret);
+
+			led->led_number = led->led_strings[0];
+
+		} else {
+			ret = fwnode_property_read_u32(child, "ti,led-module",
+					       &led_number);
+
+			led->led_number = led_number;
+		}
+		if (ret) {
+			dev_err(&priv->client->dev,
+				"led sourcing property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		if (led_number > priv->max_leds) {
+			dev_err(&priv->client->dev,
+				"led-sources property is invalid\n");
+			ret = -EINVAL;
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret)
+			snprintf(led->label, sizeof(led->label),
+				"%s::", priv->client->name);
+		else
+			snprintf(led->label, sizeof(led->label),
+				 "%s:%s", priv->client->name, name);
+
+		fwnode_property_read_string(child, "linux,default-trigger",
+				    &led->led_dev.default_trigger);
+
+		led->priv = priv;
+		led->led_dev.name = led->label;
+		led->led_dev.brightness_set_blocking = lp50xx_brightness_set;
+		led->led_dev.brightness_get = lp50xx_brightness_get;
+		led->led_dev.groups = lp50xx_led_color_groups;
+
+		ret = devm_led_classdev_register(&priv->client->dev,
+						 &led->led_dev);
+		if (ret) {
+			dev_err(&priv->client->dev, "led register err: %d\n",
+				ret);
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+		i++;
+	}
+	priv->num_of_leds = i;
+
+child_out:
+	return ret;
+}
+
+static int lp50xx_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct lp50xx *led;
+	int count;
+	int ret;
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count) {
+		dev_err(&client->dev, "LEDs are not defined in device tree!");
+		return -ENODEV;
+	}
+
+	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
+			   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	mutex_init(&led->lock);
+	led->client = client;
+	led->dev = &client->dev;
+	led->model_id = id->driver_data;
+	i2c_set_clientdata(client, led);
+
+	if (led->model_id == LP5018 || led->model_id == LP5024)
+		led->regmap = devm_regmap_init_i2c(client,
+						   &lp5024_regmap_config);
+	else
+		led->regmap = devm_regmap_init_i2c(client,
+						   &lp5036_regmap_config);
+
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = lp50xx_probe_dt(led);
+	if (ret)
+		return ret;
+
+	ret = lp50xx_init(led);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int lp50xx_remove(struct i2c_client *client)
+{
+	struct lp50xx *led = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_update_bits(led->regmap, LP50XX_DEV_CFG0,
+				 LP50XX_CHIP_EN, 0);
+	if (ret) {
+		dev_err(&led->client->dev, "Failed to disable regulator\n");
+		return ret;
+	}
+
+	if (led->enable_gpio)
+		gpiod_direction_output(led->enable_gpio, 0);
+
+	if (led->regulator) {
+		ret = regulator_disable(led->regulator);
+		if (ret)
+			dev_err(&led->client->dev,
+				"Failed to disable regulator\n");
+	}
+
+	mutex_destroy(&led->lock);
+
+	return 0;
+}
+
+static const struct i2c_device_id lp50xx_id[] = {
+	{ "lp5018", LP5018 },
+	{ "lp5024", LP5024 },
+	{ "lp5030", LP5030 },
+	{ "lp5036", LP5036 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lp50xx_id);
+
+static const struct of_device_id of_lp50xx_leds_match[] = {
+	{ .compatible = "ti,lp5018", },
+	{ .compatible = "ti,lp5024", },
+	{ .compatible = "ti,lp5030", },
+	{ .compatible = "ti,lp5036", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lp50xx_leds_match);
+
+static struct i2c_driver lp50xx_driver = {
+	.driver = {
+		.name	= "lp50xx",
+		.of_match_table = of_lp50xx_leds_match,
+	},
+	.probe		= lp50xx_probe,
+	.remove		= lp50xx_remove,
+	.id_table	= lp50xx_id,
+};
+module_i2c_driver(lp50xx_driver);
+
+MODULE_DESCRIPTION("Texas Instruments LP5024 LED driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1.98.gecbdaf0899


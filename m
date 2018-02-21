Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBUVr1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:47:27 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50232 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUVrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:47:24 -0500
X-Google-Smtp-Source: AH8x225GSR3R3EAylmS5uuJVfF38e8IkFm5N/HKjWp5fQSbyu3jzjKvdP3Pvt7+kVmXQkcyN3Kyf/g==
From: Florian Vaussard <florian.vaussard@gmail.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH v4 2/2] leds: Add driver for NCP5623 3-channel I2C LED driver
Date: Wed, 21 Feb 2018 22:46:54 +0100
Message-Id: <20180221214654.3306-3-florian.vaussard@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221214654.3306-1-florian.vaussard@gmail.com>
References: <20180221214654.3306-1-florian.vaussard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NCP5623 is a 3-channel LED driver from On Semiconductor controlled
through I2C. The PWM of each channel can be independently set with 32
distinct levels. In addition, the intensity of the current source can be
globally set using an external bias resistor fixing the reference
current (Iref) and a dedicated register (ILED), following the
relationship:

I = 2400*Iref/(31-ILED)

with Iref = Vref/Rbias, and Vref = 0.6V.

Signed-off-by: Florian Vaussard <florian.vaussard@gmail.com>
---
 drivers/leds/Kconfig        |  11 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-ncp5623.c | 228 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/leds/leds-ncp5623.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 318a28fd58fe..344b96ec7803 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -706,6 +706,17 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_NCP5623
+	tristate "LED Support for NCP5623 I2C chip"
+	depends on LEDS_CLASS
+	depends on I2C
+	help
+	  This option enables support for LEDs connected to NCP5623
+	  LED driver chips accessed via the I2C bus.
+	  Driver supports brightness control.
+
+	  Say Y to enable this driver.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index a2a6b5a4f86d..3ef8186ca942 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
 obj-$(CONFIG_LEDS_MLXCPLD)		+= leds-mlxcpld.o
 obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
 obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
+obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-ncp5623.c b/drivers/leds/leds-ncp5623.c
new file mode 100644
index 000000000000..005caae67397
--- /dev/null
+++ b/drivers/leds/leds-ncp5623.c
@@ -0,0 +1,228 @@
+/*
+ * Copyright 2018 Florian Vaussard <florian.vaussard@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+#define NCP5623_MAX_LEDS	3
+#define NCP5623_MAX_STEPS	31
+#define NCP5623_MAX_CURRENT	31
+#define NCP5623_MAX_CURRENT_UA	30000
+
+#define NCP5623_CMD_SHIFT	5
+#define CMD_SHUTDOWN		(0x00 << NCP5623_CMD_SHIFT)
+#define CMD_ILED		(0x01 << NCP5623_CMD_SHIFT)
+#define CMD_PWM1		(0x02 << NCP5623_CMD_SHIFT)
+#define CMD_PWM2		(0x03 << NCP5623_CMD_SHIFT)
+#define CMD_PWM3		(0x04 << NCP5623_CMD_SHIFT)
+#define CMD_UPWARD_DIM		(0x05 << NCP5623_CMD_SHIFT)
+#define CMD_DOWNWARD_DIM	(0x06 << NCP5623_CMD_SHIFT)
+#define CMD_DIM_STEP		(0x07 << NCP5623_CMD_SHIFT)
+
+#define LED_TO_PWM_CMD(led)	((0x02 + led - 1) << NCP5623_CMD_SHIFT)
+
+#define NCP5623_DATA_MASK	GENMASK(NCP5623_CMD_SHIFT - 1, 0)
+#define NCP5623_CMD(cmd, data)	(cmd | (data & NCP5623_DATA_MASK))
+
+struct ncp5623_led {
+	int led_no;
+	u32 led_max_current;
+	struct led_classdev ldev;
+	struct ncp5623_priv *priv;
+};
+
+struct ncp5623_priv {
+	struct ncp5623_led leds[NCP5623_MAX_LEDS];
+	u32 led_iref;
+	u32 leds_max_current;
+	struct i2c_client *client;
+};
+
+static struct ncp5623_led *ldev_to_led(struct led_classdev *ldev)
+{
+	return container_of(ldev, struct ncp5623_led, ldev);
+}
+
+static int ncp5623_send_cmd(struct ncp5623_priv *priv, u8 cmd, u8 data)
+{
+	char cmd_data[1] = { NCP5623_CMD(cmd, data) };
+	int err;
+
+	err = i2c_master_send(priv->client, cmd_data, ARRAY_SIZE(cmd_data));
+
+	return (err < 0 ? err : 0);
+}
+
+static int ncp5623_brightness_set(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	struct ncp5623_led *led = ldev_to_led(led_cdev);
+
+	return ncp5623_send_cmd(led->priv, LED_TO_PWM_CMD(led->led_no),
+				brightness);
+}
+
+static int ncp5623_configure(struct device *dev,
+			     struct ncp5623_priv *priv)
+{
+	unsigned int i;
+	unsigned int n;
+	struct ncp5623_led *led;
+	int effective_current;
+	int err;
+
+	/* Setup the internal current source, avoid negative values */
+	n = 31 - min_t(unsigned int, 31, DIV_ROUND_UP(2400 * priv->led_iref,
+						      priv->leds_max_current));
+
+	effective_current = 2400 * priv->led_iref / (NCP5623_MAX_CURRENT - n);
+	dev_dbg(dev, "setting maximum current to %u uA\n", effective_current);
+
+	err = ncp5623_send_cmd(priv, CMD_ILED, n);
+	if (err < 0) {
+		dev_err(dev, "cannot set the current\n");
+		return err;
+	}
+
+	/* Setup each individual LED */
+	for (i = 0; i < NCP5623_MAX_LEDS; i++) {
+		led = &priv->leds[i];
+
+		if (led->led_no == 0)
+			continue;
+
+		led->priv = priv;
+		led->ldev.brightness_set_blocking = ncp5623_brightness_set;
+
+		led->ldev.max_brightness =
+			min_t(unsigned int, NCP5623_MAX_STEPS,
+			      led->led_max_current * NCP5623_MAX_STEPS /
+			      effective_current);
+
+		err = devm_led_classdev_register(dev, &led->ldev);
+		if (err < 0) {
+			dev_err(dev, "couldn't register LED %s\n",
+				led->ldev.name);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int ncp5623_parse_dt(struct ncp5623_priv *priv, struct device_node *np)
+{
+	struct device_node *child;
+	struct ncp5623_led *led;
+	u32 reg;
+	int count;
+	int err;
+
+	err = of_property_read_u32(np, "onnn,led-iref-microamp",
+				   &priv->led_iref);
+	if (err)
+		return -EINVAL;
+
+	count = of_get_child_count(np);
+	if (count == 0 || count > NCP5623_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_child_of_node(np, child) {
+		err = of_property_read_u32(child, "reg", &reg);
+		if (err)
+			return err;
+
+		/* reg should be 0 ... NCP5623_MAX_LEDS - 1 */
+		if (reg >= NCP5623_MAX_LEDS) {
+			err = -EINVAL;
+			goto dt_child_parse_error;
+		}
+
+		led = &priv->leds[reg];
+
+		/* while valid led_no is 1 ... NCP5623_MAX_LEDS */
+		if (led->led_no > 0) {
+			/* Already registered */
+			err = -EINVAL;
+			goto dt_child_parse_error;
+		}
+		led->led_no = reg + 1;
+
+		err = of_property_read_u32(child, "led-max-microamp",
+					   &led->led_max_current);
+		if (err || led->led_max_current > NCP5623_MAX_CURRENT_UA)
+			return -EINVAL;
+		if (led->led_max_current > priv->leds_max_current)
+			priv->leds_max_current = led->led_max_current;
+
+		led->ldev.name =
+			of_get_property(child, "label", NULL) ? : child->name;
+		led->ldev.default_trigger =
+			of_get_property(child, "linux,default-trigger", NULL);
+	}
+
+	return 0;
+
+dt_child_parse_error:
+	of_node_put(child);
+
+	return err;
+}
+
+static int ncp5623_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+	struct ncp5623_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	i2c_set_clientdata(client, priv);
+
+	err = ncp5623_parse_dt(priv, np);
+	if (err)
+		return err;
+
+	return ncp5623_configure(dev, priv);
+}
+
+static const struct of_device_id ncp5623_of_match[] = {
+	{ .compatible = "onnn,ncp5623" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ncp5623_of_match);
+
+static const struct i2c_device_id ncp5623_id[] = {
+	{ "ncp5623" },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ncp5623_id);
+
+static struct i2c_driver ncp5623_driver = {
+	.driver = {
+		.name = "ncp5623",
+		.of_match_table = of_match_ptr(ncp5623_of_match),
+	},
+	.probe = ncp5623_probe,
+	.id_table = ncp5623_id,
+};
+
+module_i2c_driver(ncp5623_driver);
+
+MODULE_AUTHOR("Florian Vaussard <florian.vaussard@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("NCP5623 LED driver");
-- 
2.13.6

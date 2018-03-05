Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeCEWDV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:03:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42763 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbeCEWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:03:17 -0500
X-Google-Smtp-Source: AG47ELsnwdaie8VSVgwEs2WoA327rRB86h/F/zGGrkXMA3nKXLU7Wv/H1m+xmVRwuGRm4os1dnoNeg==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/4] mfd: add Gateworks System Controller core driver
Date: Mon,  5 Mar 2018 14:02:39 -0800
Message-Id: <1520287361-12569-3-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gateworks System Controller (GSC) is an I2C slave controller
implemented with an MSP430 micro-controller whose firmware embeds the
following features:
 - I/O expander (16 GPIO's) using PCA955x protocol
 - Real Time Clock using DS1672 protocol
 - User EEPROM using AT24 protocol
 - HWMON using custom protocol
 - Interrupt controller with tamper detect, user pushbotton
 - Watchdog controller capable of full board power-cycle
 - Power Control capable of full board power-cycle

see http://trac.gateworks.com/wiki/gsc for more details

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
- change license comment block style
- remove COMPILE_TEST (Randy)
- fixed whitespace issues
- replaced a printk with dev_err

 drivers/mfd/Kconfig     |  13 ++
 drivers/mfd/Makefile    |   1 +
 drivers/mfd/gsc.c       | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/gsc.h |  82 ++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 drivers/mfd/gsc.c
 create mode 100644 include/linux/mfd/gsc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1d20a80..5694013 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -341,6 +341,19 @@ config MFD_EXYNOS_LPASS
 	  Select this option to enable support for Samsung Exynos Low Power
 	  Audio Subsystem.
 
+config MFD_GSC
+	tristate "Gateworks System Controller"
+	depends on (I2C && OF)
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Enable support for the Gateworks System Controller found
+	  on Gateworks Single Board Computers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gsc.
+
 config MFD_MC13XXX
 	tristate
 	depends on (SPI_MASTER || I2C)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9474ad..aede0bc 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
 obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
 obj-$(CONFIG_MFD_CROS_EC_SPI)	+= cros_ec_spi.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
+obj-$(CONFIG_MFD_GSC)		+= gsc.o
 
 rtsx_pci-objs			:= rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o
 obj-$(CONFIG_MFD_RTSX_PCI)	+= rtsx_pci.o
diff --git a/drivers/mfd/gsc.c b/drivers/mfd/gsc.c
new file mode 100644
index 0000000..4ac400a
--- /dev/null
+++ b/drivers/mfd/gsc.c
@@ -0,0 +1,330 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Gateworks Corporation
+ *
+ * The Gateworks System Controller (GSC) is a family of a multi-function
+ * "Power Management and System Companion Device" chips originally designed for
+ * use in Gateworks Single Board Computers. The control interface is I2C,
+ * at 100kbps, with an interrupt.
+ *
+ */
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/gsc.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/*
+ * The GSC suffers from an errata where occasionally during
+ * ADC cycles the chip can NAK i2c transactions. To ensure we have reliable
+ * register access we place retries around register access.
+ */
+#define I2C_RETRIES	3
+
+static int gsc_regmap_regwrite(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	struct i2c_client *client = context;
+	int retry, ret;
+
+	for (retry = 0; retry < I2C_RETRIES; retry++) {
+		ret = i2c_smbus_write_byte_data(client, reg, val);
+		/*
+		 * -EAGAIN returned when the i2c host controller is busy
+		 * -EIO returned when i2c device is busy
+		 */
+		if (ret != -EAGAIN && ret != -EIO)
+			break;
+	}
+	if (ret < 0) {
+		dev_err(&client->dev, ">> 0x%02x %d\n", reg, ret);
+		return ret;
+	}
+	dev_dbg(&client->dev, ">> 0x%02x=0x%02x (%d)\n", reg, val, retry);
+
+	return 0;
+}
+
+static int gsc_regmap_regread(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	struct i2c_client *client = context;
+	int retry, ret;
+
+	for (retry = 0; retry < I2C_RETRIES; retry++) {
+		ret = i2c_smbus_read_byte_data(client, reg);
+		/*
+		 * -EAGAIN returned when the i2c host controller is busy
+		 * -EIO returned when i2c device is busy
+		 */
+		if (ret != -EAGAIN && ret != -EIO)
+			break;
+	}
+	if (ret < 0) {
+		dev_err(&client->dev, "<< 0x%02x %d\n", reg, ret);
+		return ret;
+	}
+
+	*val = ret & 0xff;
+	dev_dbg(&client->dev, "<< 0x%02x=0x%02x (%d)\n", reg, *val, retry);
+
+	return 0;
+}
+
+static struct regmap_bus regmap_gsc = {
+	.reg_write = gsc_regmap_regwrite,
+	.reg_read = gsc_regmap_regread,
+};
+
+/*
+ * gsc_powerdown - API to use GSC to power down board for a specific time
+ *
+ * secs - number of seconds to remain powered off
+ */
+static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
+{
+	int ret;
+	unsigned char regs[4];
+
+	dev_info(&gsc->i2c->dev, "GSC powerdown for %ld seconds\n",
+		 secs);
+	regs[0] = secs & 0xff;
+	regs[1] = (secs >> 8) & 0xff;
+	regs[2] = (secs >> 16) & 0xff;
+	regs[3] = (secs >> 24) & 0xff;
+	ret = regmap_bulk_write(gsc->regmap, GSC_TIME_ADD, regs, 4);
+
+	return ret;
+}
+
+/*
+ * sysfs hooks
+ */
+static ssize_t gsc_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	const char *name = attr->attr.name;
+	int rz = 0;
+
+	if (strcasecmp(name, "fw_version") == 0)
+		rz = sprintf(buf, "%d\n", gsc->fwver);
+	else if (strcasecmp(name, "fw_crc") == 0)
+		rz = sprintf(buf, "0x%04x\n", gsc->fwcrc);
+
+	return rz;
+}
+
+static ssize_t gsc_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(dev);
+	const char *name = attr->attr.name;
+	int ret;
+
+	if (strcasecmp(name, "powerdown") == 0) {
+		long value;
+
+		ret = kstrtol(buf, 0, &value);
+		if (ret == 0)
+			gsc_powerdown(gsc, value);
+	} else
+		dev_err(dev, "invalid name '%s\n", name);
+
+	return count;
+}
+
+
+/*
+ * Create a group of attributes so that we can create and destroy them all
+ * at once.
+ */
+static struct device_attribute attr_fwver =
+	__ATTR(fw_version, 0440, gsc_show, NULL);
+static struct device_attribute attr_fwcrc =
+	__ATTR(fw_crc, 0440, gsc_show, NULL);
+static struct device_attribute attr_pwrdown =
+	__ATTR(powerdown, 0220, NULL, gsc_store);
+
+static struct attribute *gsc_attrs[] = {
+	&attr_fwver.attr,
+	&attr_fwcrc.attr,
+	&attr_pwrdown.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = gsc_attrs,
+};
+
+static const struct i2c_device_id gsc_i2c_ids[] = {
+	{ "gsc_v1", gsc_v1 },
+	{ "gsc_v2", gsc_v2 },
+	{ "gsc_v3", gsc_v3 },
+	{ },
+};
+
+static const struct of_device_id gsc_of_match[] = {
+	{ .compatible = "gw,gsc_v1", .data = (void *)gsc_v1 },
+	{ .compatible = "gw,gsc_v2", .data = (void *)gsc_v2 },
+	{ .compatible = "gw,gsc_v3", .data = (void *)gsc_v3 },
+	{ }
+};
+
+static const struct regmap_config gsc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xf,
+};
+
+static const struct regmap_config gsc_regmap_hwmon_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0x37,
+};
+
+static const struct regmap_irq gsc_irqs[] = {
+	REGMAP_IRQ_REG(GSC_IRQ_PB, 0, BIT(GSC_IRQ_PB)),
+	REGMAP_IRQ_REG(GSC_IRQ_KEY_ERASED, 0, BIT(GSC_IRQ_KEY_ERASED)),
+	REGMAP_IRQ_REG(GSC_IRQ_EEPROM_WP, 0, BIT(GSC_IRQ_EEPROM_WP)),
+	REGMAP_IRQ_REG(GSC_IRQ_RESV, 0, BIT(GSC_IRQ_RESV)),
+	REGMAP_IRQ_REG(GSC_IRQ_GPIO, 0, BIT(GSC_IRQ_GPIO)),
+	REGMAP_IRQ_REG(GSC_IRQ_TAMPER, 0, BIT(GSC_IRQ_TAMPER)),
+	REGMAP_IRQ_REG(GSC_IRQ_WDT_TIMEOUT, 0, BIT(GSC_IRQ_WDT_TIMEOUT)),
+	REGMAP_IRQ_REG(GSC_IRQ_SWITCH_HOLD, 0, BIT(GSC_IRQ_SWITCH_HOLD)),
+};
+
+static const struct regmap_irq_chip gsc_irq_chip = {
+	.name = KBUILD_MODNAME,
+	.irqs = gsc_irqs,
+	.num_irqs = ARRAY_SIZE(gsc_irqs),
+	.num_regs = 1,
+	.status_base = GSC_IRQ_STATUS,
+	.mask_base = GSC_IRQ_ENABLE,
+	.mask_invert = true,
+	.ack_base = GSC_IRQ_STATUS,
+	.ack_invert = true,
+};
+
+static int gsc_of_probe(struct device_node *np, struct gsc_dev *gsc)
+{
+	const struct of_device_id *of_id;
+
+	if (!np)
+		return -ENODEV;
+
+	of_id = of_match_device(gsc_of_match, gsc->dev);
+	if (of_id)
+		gsc->type = (enum gsc_type)of_id->data;
+
+	return 0;
+}
+
+static int
+gsc_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct gsc_dev *gsc;
+	int ret;
+	unsigned int reg;
+
+	gsc = devm_kzalloc(dev, sizeof(*gsc), GFP_KERNEL);
+	if (!gsc)
+		return -ENOMEM;
+
+	gsc->dev = &client->dev;
+	gsc->i2c = client;
+	gsc->irq = client->irq;
+	i2c_set_clientdata(client, gsc);
+
+	gsc->regmap = devm_regmap_init(dev, &regmap_gsc, client,
+				       &gsc_regmap_config);
+	if (IS_ERR(gsc->regmap))
+		return PTR_ERR(gsc->regmap);
+
+	ret = gsc_of_probe(dev->of_node, gsc);
+	if (reg < 0)
+		return ret;
+
+	if (regmap_read(gsc->regmap, GSC_FW_VER, &reg))
+		return -EIO;
+	gsc->fwver = reg;
+	regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
+	gsc->fwcrc = reg;
+	regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
+	gsc->fwcrc |= reg << 8;
+
+	gsc->i2c_hwmon = i2c_new_dummy(client->adapter, GSC_HWMON);
+	if (!gsc->i2c_hwmon) {
+		dev_err(dev, "Failed to allocate I2C device for HWMON\n");
+		return -ENODEV;
+	}
+	i2c_set_clientdata(gsc->i2c_hwmon, gsc);
+
+	gsc->regmap_hwmon = devm_regmap_init(dev, &regmap_gsc, gsc->i2c_hwmon,
+					     &gsc_regmap_hwmon_config);
+	if (IS_ERR(gsc->regmap_hwmon)) {
+		ret = PTR_ERR(gsc->regmap_hwmon);
+		dev_err(dev, "failed to allocate register map: %d\n", ret);
+		goto err_regmap;
+	}
+
+	ret = devm_regmap_add_irq_chip(dev, gsc->regmap, gsc->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &gsc_irq_chip, &gsc->irq_chip_data);
+	if (ret)
+		goto err_regmap;
+
+	dev_info(dev, "Gateworks System Controller v%d: fw v%02d 0x%04x\n",
+		 gsc->type, gsc->fwver, gsc->fwcrc);
+
+	/* sysfs hooks */
+	ret = sysfs_create_group(&dev->kobj, &attr_group);
+	if (ret)
+		dev_err(dev, "failed to create sysfs attrs\n");
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_sysfs;
+
+	return 0;
+
+err_sysfs:
+	sysfs_remove_group(&dev->kobj, &attr_group);
+err_regmap:
+	i2c_unregister_device(gsc->i2c_hwmon);
+
+	return ret;
+}
+
+static int gsc_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &attr_group);
+
+	return 0;
+}
+
+static struct i2c_driver gsc_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(gsc_of_match),
+	},
+	.probe		= gsc_probe,
+	.remove		= gsc_remove,
+	.id_table	= gsc_i2c_ids,
+};
+
+module_i2c_driver(gsc_driver);
+
+MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
+MODULE_DESCRIPTION("I2C Core interface for GSC");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/gsc.h b/include/linux/mfd/gsc.h
new file mode 100644
index 0000000..e0d8c8f
--- /dev/null
+++ b/include/linux/mfd/gsc.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Gateworks Corporation
+ */
+#ifndef __LINUX_MFD_GSC_H_
+#define __LINUX_MFD_GSC_H_
+
+/* Device Addresses */
+#define GSC_MISC	0x20
+#define GSC_UPDATE	0x21
+#define GSC_GPIO	0x23
+#define GSC_HWMON	0x29
+#define GSC_EEPROM0	0x50
+#define GSC_EEPROM1	0x51
+#define GSC_EEPROM2	0x52
+#define GSC_EEPROM3	0x53
+#define GSC_RTC		0x68
+
+/* Register offsets */
+#define GSC_CTRL_0	0x00
+#define GSC_CTRL_1	0x01
+#define GSC_TIME	0x02
+#define GSC_TIME_ADD	0x06
+#define GSC_IRQ_STATUS	0x0A
+#define GSC_IRQ_ENABLE	0x0B
+#define GSC_FW_CRC	0x0C
+#define GSC_FW_VER	0x0E
+#define GSC_WP		0x0F
+
+/* Bit definitions */
+#define GSC_CTRL_0_PB_HARD_RESET	0
+#define GSC_CTRL_0_PB_CLEAR_SECURE_KEY	1
+#define GSC_CTRL_0_PB_SOFT_POWER_DOWN	2
+#define GSC_CTRL_0_PB_BOOT_ALTERNATE	3
+#define GSC_CTRL_0_PERFORM_CRC		4
+#define GSC_CTRL_0_TAMPER_DETECT	5
+#define GSC_CTRL_0_SWITCH_HOLD		6
+
+#define GSC_CTRL_1_SLEEP_ENABLE		0
+#define GSC_CTRL_1_ACTIVATE_SLEEP	1
+#define GSC_CTRL_1_LATCH_SLEEP_ADD	2
+#define GSC_CTRL_1_SLEEP_NOWAKEPB	3
+#define GSC_CTRL_1_WDT_TIME		4
+#define GSC_CTRL_1_WDT_ENABLE		5
+#define GSC_CTRL_1_SWITCH_BOOT_ENABLE	6
+#define GSC_CTRL_1_SWITCH_BOOT_CLEAR	7
+
+#define GSC_IRQ_PB			0
+#define GSC_IRQ_KEY_ERASED		1
+#define GSC_IRQ_EEPROM_WP		2
+#define GSC_IRQ_RESV			3
+#define GSC_IRQ_GPIO			4
+#define GSC_IRQ_TAMPER			5
+#define GSC_IRQ_WDT_TIMEOUT		6
+#define GSC_IRQ_SWITCH_HOLD		7
+
+/* Max registers */
+#define GSC_HWMON_MAX_REG	56
+
+enum gsc_type {
+	gsc_v1 = 1,
+	gsc_v2 = 2,
+	gsc_v3 = 3,
+};
+
+struct gsc_dev {
+	struct device *dev;
+
+	struct i2c_client *i2c;		/* 0x20: interrupt controller, WDT */
+	struct i2c_client *i2c_hwmon;	/* 0x29: hwmon, fan controller */
+
+	struct regmap *regmap;
+	struct regmap *regmap_hwmon;
+	struct regmap_irq_chip_data *irq_chip_data;
+
+	int irq;
+	enum gsc_type type;
+	unsigned int fwver;
+	unsigned short fwcrc;
+};
+
+#endif /* __LINUX_MFD_GSC_H_ */
-- 
2.7.4

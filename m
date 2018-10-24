Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028AFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4952064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4952064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arcx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeJXXIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:08:35 -0400
Received: from mail.arcx.com ([184.94.50.18]:27680 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeJXXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:08:33 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 19:08:27 EDT
Received: from svens-asus.arcx.com (192.168.2.132) by WEBMAIL.arcx.com
 (192.168.2.64) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 24 Oct
 2018 10:26:18 -0400
From:   Sven Van Asbroeck <svendev@arcx.com>
To:     <svendev@arcx.com>, <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <afaerber@suse.de>, <treding@nvidia.com>,
        <david@lechnology.com>, <noralf@tronnes.org>, <johan@kernel.org>,
        <monstr@monstr.eu>, <michal.vokac@ysoft.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <john.garry@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
        <robin.murphy@arm.com>, <paul.gortmaker@windriver.com>,
        <sebastien.bourdelin@savoirfairelinux.com>, <icenowy@aosc.io>,
        <yuanzhichang@hisilicon.com>, <stuyoder@gmail.com>,
        <linus.walleij@linaro.org>, <maxime.ripard@bootlin.com>,
        <bogdan.purcareata@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH anybus v1 1/4] mfd: support the Arcx anybus bridge.
Date:   Wed, 24 Oct 2018 10:24:53 -0400
Message-ID: <20181024142456.10084-2-svendev@arcx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024142456.10084-1-svendev@arcx.com>
References: <20181024142456.10084-1-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.132]
X-ClientProxiedBy: webmail.arcx.com (192.168.2.64) To WEBMAIL.arcx.com
 (192.168.2.64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Arcx anybus bridge.

This chip embeds up to two Anybus-S application connectors
(slots), and connects to the SoC via the i.MX parallel WEIM bus.
There is also a CAN power readout, unrelated to the anybus.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/mfd/Kconfig          |  11 +
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/anybus-bridge.c  | 441 +++++++++++++++++++++++++++++++++++
 include/linux/anybuss-host.h |  28 +++
 4 files changed, 481 insertions(+)
 create mode 100644 drivers/mfd/anybus-bridge.c
 create mode 100644 include/linux/anybuss-host.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 11841f4b7b2b..49b9de71cb16 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -125,6 +125,17 @@ config MFD_ATMEL_SMC
 	bool
 	select MFD_SYSCON
 
+config MFD_ANYBUS_BRIDGE
+	tristate "Arcx Anybus-S Bridge"
+	select MFD_CORE
+	select REGMAP
+	depends on OF
+	help
+	  Select this to get support for the Arcx Anybus bridge.
+	  It is accessible via the i.MX parallel WEIM bus, and
+	  embeds up to two Anybus-S application connectors (slots).
+	  There is also a CAN power readout, unrelated to the anybus.
+
 config MFD_BCM590XX
 	tristate "Broadcom BCM590xx PMUs"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5856a9489cbd..c45075452d40 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -223,6 +223,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
+obj-$(CONFIG_MFD_ANYBUS_BRIDGE) += anybus-bridge.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/anybus-bridge.c b/drivers/mfd/anybus-bridge.c
new file mode 100644
index 000000000000..f6eda5b2b6e8
--- /dev/null
+++ b/drivers/mfd/anybus-bridge.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arcx Anybus Bridge driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/of_address.h>
+#include <linux/pwm.h>
+#include <linux/mfd/core.h>
+#include <linux/of_irq.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+
+#include <linux/anybuss-host.h>
+
+#define CPLD_STATUS1		0x80
+#define CPLD_CONTROL		0x80
+#define CPLD_CONTROL_CRST	0x40
+#define CPLD_CONTROL_RST1	0x04
+#define CPLD_CONTROL_RST2	0x80
+#define CPLD_STATUS1_AB		0x02
+#define CPLD_STATUS1_CAN_POWER	0x01
+#define CPLD_DESIGN_LO		0x81
+#define CPLD_DESIGN_HI		0x82
+#define CPLD_CAP		0x83
+#define CPLD_CAP_COMPAT		0x01
+#define CPLD_CAP_SEP_RESETS	0x02
+
+struct bridge_priv {
+	struct device *class_dev;
+	void __iomem *cpld_base;
+	spinlock_t regs_lock;
+	u8 control_reg;
+	char version[3];
+	u16 design_no;
+};
+
+/* the cpld supports single-byte accesses ONLY */
+
+static int read_reg_weim(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readb(base + reg);
+	return 0;
+}
+
+static int write_reg_weim(void *context, unsigned int reg,
+				unsigned int val)
+{
+	void __iomem *base = context;
+
+	writeb(val, base + reg);
+	return 0;
+}
+
+static struct regmap *create_weim_regmap(struct device *dev,
+			struct resource *res, int slot)
+{
+	struct regmap_config regmap_cfg = {
+		.reg_bits = 11,
+		.val_bits = 8,
+		/* bus accesses are simple weim byte accesses.
+		 * they don't require any synchronization.
+		 * also, the bus driver requirement is that regmap accesses
+		 * must never sleep.
+		 */
+		.disable_locking = true,
+		.reg_read = read_reg_weim,
+		.reg_write = write_reg_weim,
+	};
+	void __iomem *base;
+	char name[32];
+
+	if (resource_size(res) < (1<<regmap_cfg.reg_bits))
+		return ERR_PTR(-EINVAL);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return (struct regmap *)base;
+	/* give the regmap a name, so it shows up in debugfs */
+	snprintf(name, sizeof(name), "slot%d", slot);
+	regmap_cfg.name = devm_kmemdup(dev, name, sizeof(name), GFP_KERNEL);
+	if (regmap_cfg.name == NULL)
+		return ERR_PTR(-ENOMEM);
+	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+}
+
+static int add_anybus_slot(struct device *dev, anybuss_reset_t reset,
+				int slot)
+{
+	int err, irq;
+	struct resource mem_res, *irq_res;
+	struct mfd_cell *cell;
+	struct anybuss_host_pdata *pdata;
+	struct gpio_desc *gpio;
+	struct regmap *regmap;
+
+	/* get irq from devicetree */
+	gpio = devm_gpiod_get_index(dev, "irq", slot, GPIOD_IN);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+	irq = gpiod_to_irq(gpio);
+	if (irq < 0) {
+		dev_err(dev, "Anybus-S slot %d: no irq?", slot);
+		return -EINVAL;
+	}
+	/* get anybus mem resource from devicetree
+	 * note that the cpld registers sit at dt offset 0
+	 * anybus slot memory starts at offset 1
+	 */
+	err = of_address_to_resource(dev->of_node, slot+1, &mem_res);
+	if (err) {
+		dev_err(dev, "Anybus-S slot %d: no weim memory?", slot);
+		return err;
+	}
+	regmap = create_weim_regmap(dev, &mem_res, slot);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+	/* add slot as a mfd device */
+	irq_res = devm_kzalloc(dev, sizeof(*irq_res), GFP_KERNEL);
+	if (!irq_res)
+		return -ENOMEM;
+	irq_res->start = irq_res->end = irq;
+	irq_res->flags = IORESOURCE_IRQ;
+	irq_res->name = "anybus-irq";
+	cell = devm_kzalloc(dev, sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->reset = reset;
+	pdata->regmap = regmap;
+	cell->name = "anybuss-host";
+	cell->num_resources = 1;
+	cell->resources = irq_res;
+	cell->platform_data = pdata;
+	cell->pdata_size = sizeof(*pdata);
+	dev_info(dev, "Anybus-S slot %d: [weim 0x%016x-0x%016x] [irq %d]",
+		slot, mem_res.start, mem_res.end, irq);
+	err = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1,
+						NULL, 0, NULL);
+	if (err)
+		dev_err(dev, "failed to add Anybus-S slot %d", slot);
+	return err;
+}
+
+static int add_anybus_slots(struct device *dev, struct device_node *np,
+				anybuss_reset_t *resets)
+{
+	int i, err;
+
+	/* bridge has two Anybus-S slots */
+	for (i = 0; i < 2; i++) {
+		err = add_anybus_slot(dev, resets[i], i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static void do_reset(struct device *dev, u8 rst_bit, bool reset)
+{
+	unsigned long flags;
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	spin_lock_irqsave(&cd->regs_lock, flags);
+	/* CPLD_CONTROL is write-only, so cache its value in
+	 * cd->control_reg
+	 */
+	if (reset)
+		cd->control_reg &= ~rst_bit;
+	else
+		cd->control_reg |= rst_bit;
+	writeb(cd->control_reg, cd->cpld_base + CPLD_CONTROL);
+	/* h/w work-around:
+	 * EIM bus is 'too fast', so a reset followed by an immediate
+	 * not-reset will _not_ change the anybus reset line in any way,
+	 * losing the reset. to prevent this from happening, introduce
+	 * a minimum reset duration.
+	 * Verified minimum safe duration required using a scope
+	 * on 14-June-2018: 100 us.
+	 */
+	if (reset)
+		udelay(100);
+	spin_unlock_irqrestore(&cd->regs_lock, flags);
+}
+
+static void common_reset(struct device *dev, bool reset)
+{
+	do_reset(dev, CPLD_CONTROL_CRST, reset);
+}
+
+static void ab1_reset(struct device *dev, bool reset)
+{
+	do_reset(dev, CPLD_CONTROL_RST1, reset);
+}
+
+static void ab2_reset(struct device *dev, bool reset)
+{
+	do_reset(dev, CPLD_CONTROL_RST2, reset);
+}
+
+static void create_resets(struct device *dev, u8 cap,
+				anybuss_reset_t *resets)
+{
+	if (cap & CPLD_CAP_SEP_RESETS) {
+		dev_info(dev, "Bridge supports separate resets");
+		resets[0] = ab1_reset;
+		resets[1] = ab2_reset;
+	} else {
+		dev_info(dev, "Bridge supports a common reset");
+		resets[0] = resets[1] = common_reset;
+	}
+}
+
+static ssize_t version_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", cd->version);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t design_number_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cd->design_no);
+}
+static DEVICE_ATTR_RO(design_number);
+
+static ssize_t can_power_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct bridge_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n",
+		!(readb(cd->cpld_base + CPLD_STATUS1) &
+					CPLD_STATUS1_CAN_POWER));
+}
+static DEVICE_ATTR_RO(can_power);
+
+static struct attribute *bridge_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_design_number.attr,
+	&dev_attr_can_power.attr,
+	NULL,
+};
+
+static struct attribute_group bridge_attribute_group = {
+	.attrs = bridge_attributes,
+};
+
+static const struct attribute_group *bridge_attribute_groups[] = {
+	&bridge_attribute_group,
+	NULL,
+};
+
+static void bridge_device_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static struct class *bridge_class;
+static DEFINE_IDA(bridge_index_ida);
+
+static int bridge_probe(struct platform_device *pdev)
+{
+	struct bridge_priv *cd;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int enable_gpio, err, id;
+	struct pwm_device *pwm;
+	struct pwm_args pargs;
+	struct resource res;
+	unsigned int period;
+	u8 status1, cap;
+	anybuss_reset_t resets[2];
+
+	if (!np) {
+		dev_err(dev, "device node not found\n");
+		return -EINVAL;
+	}
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+	dev_set_drvdata(dev, cd);
+	spin_lock_init(&cd->regs_lock);
+	enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);
+	if (!gpio_is_valid(enable_gpio)) {
+		dev_err(dev, "enable-gpios not found\n");
+		return -EINVAL;
+	}
+	devm_gpio_request(dev, enable_gpio, NULL);
+	gpio_direction_output(enable_gpio, 0);
+
+	/* PWM */
+	pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(pwm)) {
+		dev_err(dev, "pwm not found\n");
+		return -EINVAL;
+	}
+	pwm_get_args(pwm, &pargs);
+	period = pargs.period;
+	err = pwm_config(pwm, period/2, period);
+	if (err)
+		return err;
+	err = pwm_enable(pwm);
+	if (err)
+		return err;
+
+	/* CPLD control memory, sits at index 0 */
+	if (of_address_to_resource(np, 0, &res)) {
+		dev_err(dev, "cpld base address not found\n");
+		return -EINVAL;
+	}
+	cd->cpld_base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(cd->cpld_base)) {
+		dev_err(dev,
+			"failed to map cpld base address\n");
+		return PTR_ERR(cd->cpld_base);
+	}
+
+	/* identify cpld */
+	status1 = readb(cd->cpld_base + CPLD_STATUS1);
+	cd->design_no = (__raw_readb(cd->cpld_base + CPLD_DESIGN_HI) << 8) |
+				__raw_readb(cd->cpld_base + CPLD_DESIGN_LO);
+	snprintf(cd->version, sizeof(cd->version), "%c%d",
+			'A' + ((status1>>5) & 0x7),
+			(status1>>2) & 0x7);
+	dev_info(dev, "Bridge is design number %d, revision %s\n",
+		cd->design_no,
+		cd->version);
+	cap = readb(cd->cpld_base + CPLD_CAP);
+	if (!(cap & CPLD_CAP_COMPAT)) {
+		dev_err(dev, "unsupported bridge [cap=0x%02X]", cap);
+		return -ENODEV;
+	}
+
+	if (status1 & CPLD_STATUS1_AB) {
+		dev_info(dev, "Bridge has anybus-S slot(s)");
+		create_resets(dev, cap, resets);
+		err = add_anybus_slots(dev, np, resets);
+		if (err)
+			return err;
+	}
+
+	id = ida_simple_get(&bridge_index_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	/* make bridge info visible to userspace */
+	cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
+	if (!cd->class_dev) {
+		err = -ENOMEM;
+		goto out_ida;
+	}
+	cd->class_dev->class = bridge_class;
+	cd->class_dev->groups = bridge_attribute_groups;
+	cd->class_dev->parent = dev;
+	cd->class_dev->id = id;
+	cd->class_dev->release = bridge_device_release;
+	dev_set_name(cd->class_dev, "bridge%d", cd->class_dev->id);
+	dev_set_drvdata(cd->class_dev, cd);
+	err = device_register(cd->class_dev);
+	if (err)
+		goto out_dev;
+	return 0;
+out_dev:
+	put_device(cd->class_dev);
+out_ida:
+	ida_simple_remove(&bridge_index_ida, id);
+	return err;
+}
+
+static int bridge_remove(struct platform_device *pdev)
+{
+	struct bridge_priv *cd = platform_get_drvdata(pdev);
+	int id = cd->class_dev->id;
+
+	device_unregister(cd->class_dev);
+	ida_simple_remove(&bridge_index_ida, id);
+	return 0;
+}
+
+static const struct of_device_id bridge_of_match[] = {
+	{ .compatible = "arcx,anybus-bridge" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, bridge_of_match);
+
+static struct platform_driver bridge_driver = {
+	.probe = bridge_probe,
+	.remove = bridge_remove,
+	.driver		= {
+		.name   = "arcx-anybus-bridge",
+		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(bridge_of_match),
+	},
+};
+
+static int __init bridge_init(void)
+{
+	int err;
+
+	bridge_class = class_create(THIS_MODULE, "arcx_anybus_bridge");
+	if (!IS_ERR(bridge_class)) {
+		err = platform_driver_register(&bridge_driver);
+		if (err)
+			class_destroy(bridge_class);
+	} else
+		err = PTR_ERR(bridge_class);
+	return err;
+}
+
+static void __exit bridge_exit(void)
+{
+	platform_driver_unregister(&bridge_driver);
+	class_destroy(bridge_class);
+}
+
+module_init(bridge_init);
+module_exit(bridge_exit);
+
+MODULE_DESCRIPTION("Arcx Anybus Bridge driver");
+MODULE_AUTHOR("Sven Van Asbroeck <svendev@arcx.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/anybuss-host.h b/include/linux/anybuss-host.h
new file mode 100644
index 000000000000..38037833acd4
--- /dev/null
+++ b/include/linux/anybuss-host.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Anybus-S host adapter definitions
+ *
+ * Copyright 2018 Arcx Inc
+ */
+
+#ifndef __LINUX_ANYBUSS_HOST_H__
+#define __LINUX_ANYBUSS_HOST_H__
+
+#include <linux/regmap.h>
+
+typedef void (*anybuss_reset_t)(struct device *dev, bool reset);
+
+/**
+ * Platform data of the Anybus-S host controller.
+ *
+ * @regmap: provides access to the card dpram.
+ *		MUST NOT use caching
+ *		MUST NOT sleep
+ * @reset:  controls the card reset line.
+ */
+struct anybuss_host_pdata {
+	struct regmap *regmap;
+	anybuss_reset_t reset;
+};
+
+#endif /* __LINUX_ANYBUS_S_HOST_H__ */
-- 
2.17.1


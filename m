Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D420657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ZaGgJOK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195D420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeKBTmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:42:36 -0400
Received: from mail.nic.cz ([217.31.204.67]:57799 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeKBTmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:42:36 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id E81396236F;
        Fri,  2 Nov 2018 11:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1541154950; bh=7kfXmk/czuoAZtZkSCAlc5UG+eieQPZ/aGUWNBosAZs=;
        h=From:To:Date;
        b=ZaGgJOK5SKGLe8bfNM0MtdU4vOMsvIcCf/uBejC+igHMP04aw84I359beqNi8T3cQ
         Ms+i8hPhtodKHZPMaIFYk13SxxCv1+E6quFkNB4J0KjQ3OVSWlst8vun8chYYVBys1
         c+LU2qeDWM+3AeFdiU5C6V6SsfidTQLXJD1XkXV0=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 bus+gpio 1/4] bus: Add support for Moxtet bus
Date:   Fri,  2 Nov 2018 11:35:36 +0100
Message-Id: <20181102103539.6077-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Turris Mox router different modules can be connected to the main
CPU board: currently a module with a SFP cage, a module with MiniPCIe
connector, a 4-port switch module, an 8-port switch module, and a 4-port
USB3 module.

For example:
  [CPU]-[PCIe]-[8-port switch]-[8-port switch]-[SFP]

Each of this modules has an input and output shift register, and these
are connected via SPI to the CPU board.

Via SPI we are able to discover which modules are connected, in which
order, and we can also read some information about the modules or
configure them.
From each module 8 bits can be read (of which low 4 bits identify the
module) and 8 bits can be written.

For example from the module with a SFP cage we can read the LOS,
TX-FAULT and MOD-DEF0 signals, while we can write TX-DISABLE and
RATE-SELECT signals.

This driver creates a new bus type, called "moxtet". For each Mox module
it finds via SPI, it creates a new device on the moxtet bus so that
drivers can be written for them.

The topology of how Mox modules are connected can then be read by
listing /sys/bus/moxtet/devices.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 MAINTAINERS            |   7 +
 drivers/bus/Kconfig    |  10 +
 drivers/bus/Makefile   |   1 +
 drivers/bus/moxtet.c   | 533 +++++++++++++++++++++++++++++++++++++++++
 include/linux/moxtet.h | 109 +++++++++
 5 files changed, 660 insertions(+)
 create mode 100644 drivers/bus/moxtet.c
 create mode 100644 include/linux/moxtet.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c0f771b859e..ccc745d1b430 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1472,6 +1472,13 @@ F:	drivers/clocksource/timer-prima2.c
 F:	drivers/clocksource/timer-atlas7.c
 N:	[^a-z]sirf
 
+ARM/CZ.NIC TURRIS MOX SUPPORT
+M:	Marek Behun <marek.behun@nic.cz>
+W:	http://mox.turris.cz
+S:	Maintained
+F:	include/linux/moxtet.h
+F:	drivers/bus/moxtet.c
+
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..6b331061d34b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -29,6 +29,16 @@ config BRCMSTB_GISB_ARB
 	  arbiter. This driver provides timeout and target abort error handling
 	  and internal bus master decoding.
 
+config MOXTET
+	tristate "CZ.NIC Turris Mox module configuration bus"
+	depends on SPI_MASTER && OF
+	help
+	  Say yes here to add support for the module configuration bus found
+	  on CZ.NIC's Turris Mox. This is needed for the ability to discover
+	  the order in which the modules are connected and to get/set some of
+	  their settings. For example the GPIOs on Mox SFP module are
+	  configured through this bus.
+
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ca300b1914ce..16b43d3468c6 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 
 obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+obj-$(CONFIG_MOXTET)		+= moxtet.o
 
 # DPAA2 fsl-mc bus
 obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
new file mode 100644
index 000000000000..19b9d12154d4
--- /dev/null
+++ b/drivers/bus/moxtet.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Turris Mox module configuration bus driver
+ *
+ * Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ */
+
+#include <linux/module.h>
+#include <linux/moxtet.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+static ssize_t
+module_id_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+
+	return sprintf(buf, "0x%x\n", mdev->id);
+}
+static DEVICE_ATTR_RO(module_id);
+
+static ssize_t
+module_name_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+
+	return sprintf(buf, "%s\n", turris_mox_module_name(mdev->id));
+}
+static DEVICE_ATTR_RO(module_name);
+
+static ssize_t
+input_value_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	int ret;
+
+	ret = moxtet_device_read(dev);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret);
+}
+static DEVICE_ATTR_RO(input_value);
+
+static ssize_t
+output_value_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	int ret;
+
+	ret = moxtet_device_written(dev);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret);
+}
+
+static ssize_t
+output_value_store(struct device *dev, struct device_attribute *a,
+		   const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val > 0xff)
+		return -ERANGE;
+
+	ret = moxtet_device_write(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(output_value);
+
+static struct attribute *moxtet_dev_attrs[] = {
+	&dev_attr_module_id.attr,
+	&dev_attr_module_name.attr,
+	&dev_attr_input_value.attr,
+	&dev_attr_output_value.attr,
+	NULL,
+};
+
+static const struct attribute_group moxtet_dev_group = {
+	.attrs = moxtet_dev_attrs,
+};
+
+static const struct attribute_group *moxtet_dev_groups[] = {
+	&moxtet_dev_group,
+	NULL,
+};
+
+static int moxtet_match(struct device *dev, struct device_driver *drv)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet_driver *tdrv = to_moxtet_driver(drv);
+	const enum turris_mox_module_id *t;
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (!tdrv->id_table)
+		return 0;
+
+	for (t = tdrv->id_table; *t; ++t)
+		if (*t == mdev->id)
+			return 1;
+
+	return 0;
+}
+
+struct bus_type moxtet_bus_type = {
+	.name		= "moxtet",
+	.dev_groups	= moxtet_dev_groups,
+	.match		= moxtet_match,
+};
+EXPORT_SYMBOL_GPL(moxtet_bus_type);
+
+int __moxtet_register_driver(struct module *owner,
+			     struct moxtet_driver *mdrv)
+{
+	mdrv->driver.owner = owner;
+	mdrv->driver.bus = &moxtet_bus_type;
+	return driver_register(&mdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__moxtet_register_driver);
+
+static int moxtet_dev_check(struct device *dev, void *data)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet_device *new_dev = data;
+
+	if (mdev->moxtet == new_dev->moxtet && mdev->id == new_dev->id &&
+	    mdev->idx == new_dev->idx)
+		return -EBUSY;
+	return 0;
+}
+
+static void moxtet_dev_release(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+
+	put_device(mdev->moxtet->dev);
+	kfree(mdev);
+}
+
+static struct moxtet_device *
+moxtet_alloc_device(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+
+	if (!get_device(moxtet->dev))
+		return NULL;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		put_device(moxtet->dev);
+		return NULL;
+	}
+
+	dev->moxtet = moxtet;
+	dev->dev.parent = moxtet->dev;
+	dev->dev.bus = &moxtet_bus_type;
+	dev->dev.release = moxtet_dev_release;
+
+	device_initialize(&dev->dev);
+
+	return dev;
+}
+
+static int moxtet_add_device(struct moxtet_device *dev)
+{
+	static DEFINE_MUTEX(add_mutex);
+	int ret;
+
+	if (dev->idx >= TURRIS_MOX_MAX_MODULES || dev->id > 0xf)
+		return -EINVAL;
+
+	dev_set_name(&dev->dev, "moxtet-%s.%u",
+		     turris_mox_module_name(dev->id), dev->idx);
+
+	mutex_lock(&add_mutex);
+
+	ret = bus_for_each_dev(&moxtet_bus_type, NULL, dev,
+			       moxtet_dev_check);
+	if (ret)
+		goto done;
+
+	ret = device_add(&dev->dev);
+	if (ret < 0)
+		dev_err(dev->moxtet->dev, "can't add %s, status %d\n",
+			dev_name(dev->moxtet->dev), ret);
+
+done:
+	mutex_unlock(&add_mutex);
+	return ret;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	if (dev->of_node) {
+		of_node_clear_flag(dev->of_node, OF_POPULATED);
+		of_node_put(dev->of_node);
+	}
+
+	device_unregister(dev);
+
+	return 0;
+}
+
+static struct moxtet_device *
+of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
+{
+	struct moxtet_device *dev;
+	u32 val;
+	int ret;
+
+	dev = moxtet_alloc_device(moxtet);
+	if (!dev) {
+		dev_err(moxtet->dev,
+			"Moxtet device alloc error for %pOF\n", nc);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = of_property_read_u32(nc, "reg", &val);
+	if (ret) {
+		dev_err(moxtet->dev, "%pOF has no valid 'reg' property (%d)\n",
+			nc, ret);
+		goto err_put;
+	}
+
+	dev->idx = val;
+
+	if (dev->idx >= TURRIS_MOX_MAX_MODULES) {
+		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x out of range\n",
+			nc, dev->idx);
+		ret = -EINVAL;
+		goto err_put;
+	}
+
+	dev->id = moxtet->modules[dev->idx];
+
+	if (!dev->id) {
+		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x is empty\n", nc,
+			dev->idx);
+		ret = -ENODEV;
+		goto err_put;
+	}
+
+	of_node_get(nc);
+	dev->dev.of_node = nc;
+
+	ret = moxtet_add_device(dev);
+	if (ret) {
+		dev_err(moxtet->dev,
+			"Moxtet device register error for %pOF\n", nc);
+		of_node_put(nc);
+		goto err_put;
+	}
+
+	return dev;
+
+err_put:
+	put_device(&dev->dev);
+	return ERR_PTR(ret);
+}
+
+static void of_register_moxtet_devices(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+	struct device_node *nc;
+
+	if (!moxtet->dev->of_node)
+		return;
+
+	for_each_available_child_of_node(moxtet->dev->of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+		dev = of_register_moxtet_device(moxtet, nc);
+		if (IS_ERR(dev)) {
+			dev_warn(moxtet->dev,
+				 "Failed to create Moxtet device for %pOF\n",
+				 nc);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
+	}
+}
+
+static void
+moxtet_register_devices_from_topology(struct moxtet *moxtet)
+{
+	struct moxtet_device *dev;
+	int i, ret;
+
+	for (i = 0; i < moxtet->count; ++i) {
+		dev = moxtet_alloc_device(moxtet);
+		if (!dev) {
+			dev_err(moxtet->dev, "Moxtet device %u alloc error\n",
+				i);
+			continue;
+		}
+
+		dev->idx = i;
+		dev->id = moxtet->modules[i];
+
+		ret = moxtet_add_device(dev);
+		if (ret && ret != -EBUSY) {
+			put_device(&dev->dev);
+			dev_err(moxtet->dev,
+				"Moxtet device %u register error: %i\n", i,
+				ret);
+		}
+	}
+}
+
+static int moxtet_find_topology(struct moxtet *moxtet)
+{
+	u8 buf[TURRIS_MOX_MAX_MODULES];
+	int i, ret;
+
+	ret = spi_read(to_spi_device(moxtet->dev), buf, TURRIS_MOX_MAX_MODULES);
+	if (ret < 0)
+		return ret;
+
+	if (buf[0] == TURRIS_MOX_CPU_ID_EMMC) {
+		dev_info(moxtet->dev, "Found eMMC Turris Mox CPU module\n");
+	} else if (buf[0] == TURRIS_MOX_CPU_ID_SD) {
+		dev_info(moxtet->dev, "Found SD Turris Mox CPU module\n");
+	} else {
+		dev_err(moxtet->dev, "Invalid Turris Mox CPU module 0x%02x\n",
+			buf[0]);
+		return -ENODEV;
+	}
+
+	moxtet->count = 0;
+
+	for (i = 1; i < TURRIS_MOX_MAX_MODULES; ++i) {
+		int module_id;
+
+		if (buf[i] == 0xff)
+			break;
+
+		module_id = buf[i] & 0xf;
+
+		moxtet->modules[i-1] = module_id;
+		++moxtet->count;
+
+		switch (module_id) {
+		case TURRIS_MOX_MODULE_SFP:
+			dev_info(moxtet->dev, "SFP module found\n");
+			break;
+		case TURRIS_MOX_MODULE_PCI:
+			dev_info(moxtet->dev, "Mini-PCIe module found\n");
+			break;
+		case TURRIS_MOX_MODULE_TOPAZ:
+			dev_info(moxtet->dev, "Topaz Switch module found\n");
+			break;
+		case TURRIS_MOX_MODULE_PERIDOT:
+			dev_info(moxtet->dev, "Peridot Switch module found\n");
+			break;
+		case TURRIS_MOX_MODULE_USB3:
+			dev_info(moxtet->dev, "USB 3.0 module found\n");
+			break;
+		case TURRIS_MOX_MODULE_PASSPCI:
+			dev_info(moxtet->dev,
+				 "Passthrough Mini-PCIe module found\n");
+			break;
+		default:
+			dev_info(moxtet->dev,
+				 "Unknown Moxtet module found (ID 0x%02x)\n",
+				 module_id);
+		}
+	}
+
+	return 0;
+}
+
+int moxtet_device_read(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+	u8 buf[TURRIS_MOX_MAX_MODULES];
+	struct spi_transfer xfer = {
+		.rx_buf = buf,
+		.tx_buf = moxtet->tx,
+		.len = moxtet->count + 1
+	};
+	int ret;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	mutex_lock(&moxtet->lock);
+
+	ret = spi_sync_transfer(to_spi_device(moxtet->dev), &xfer, 1);
+
+	mutex_unlock(&moxtet->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return buf[mdev->idx + 1] >> 4;
+}
+EXPORT_SYMBOL_GPL(moxtet_device_read);
+
+int moxtet_device_write(struct device *dev, u8 val)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+	int ret;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	mutex_lock(&moxtet->lock);
+
+	moxtet->tx[moxtet->count - mdev->idx] = val;
+
+	ret = spi_write(to_spi_device(moxtet->dev), moxtet->tx,
+			moxtet->count + 1);
+
+	mutex_unlock(&moxtet->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(moxtet_device_write);
+
+int moxtet_device_written(struct device *dev)
+{
+	struct moxtet_device *mdev = to_moxtet_device(dev);
+	struct moxtet *moxtet = mdev->moxtet;
+
+	if (mdev->idx >= moxtet->count)
+		return -EINVAL;
+
+	return moxtet->tx[moxtet->count - mdev->idx];
+}
+EXPORT_SYMBOL_GPL(moxtet_device_written);
+
+static int moxtet_probe(struct spi_device *spi)
+{
+	struct moxtet *moxtet;
+	int ret;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	moxtet = devm_kzalloc(&spi->dev, sizeof(struct moxtet),
+			      GFP_KERNEL);
+	if (!moxtet)
+		return -ENOMEM;
+
+	moxtet->dev = &spi->dev;
+	spi_set_drvdata(spi, moxtet);
+
+	mutex_init(&moxtet->lock);
+
+	ret = moxtet_find_topology(moxtet);
+	if (ret < 0)
+		return ret;
+
+	of_register_moxtet_devices(moxtet);
+	moxtet_register_devices_from_topology(moxtet);
+
+	return 0;
+}
+
+static int moxtet_remove(struct spi_device *spi)
+{
+	struct moxtet *moxtet = spi_get_drvdata(spi);
+	int dummy;
+
+	dummy = device_for_each_child(moxtet->dev, NULL, __unregister);
+
+	mutex_destroy(&moxtet->lock);
+
+	return 0;
+}
+
+static const struct of_device_id moxtet_dt_ids[] = {
+	{ .compatible = "cznic,moxtet" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, moxtet_dt_ids);
+
+static struct spi_driver moxtet_spi_driver = {
+	.driver = {
+		.name		= "moxtet",
+		.of_match_table = moxtet_dt_ids,
+	},
+	.probe		= moxtet_probe,
+	.remove		= moxtet_remove,
+};
+
+static int __init moxtet_init(void)
+{
+	int ret;
+
+	ret = bus_register(&moxtet_bus_type);
+	if (ret < 0) {
+		pr_err("moxtet bus registration failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = spi_register_driver(&moxtet_spi_driver);
+	if (ret < 0) {
+		pr_err("moxtet spi driver registration failed: %d\n", ret);
+		goto error_bus;
+	}
+
+	return 0;
+
+error_bus:
+	bus_unregister(&moxtet_bus_type);
+error:
+	return ret;
+}
+postcore_initcall_sync(moxtet_init);
+
+static void __exit moxtet_exit(void)
+{
+	spi_unregister_driver(&moxtet_spi_driver);
+	bus_unregister(&moxtet_bus_type);
+}
+module_exit(moxtet_exit);
+
+MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_DESCRIPTION("CZ.NIC's Turris Mox module configuration bus");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
new file mode 100644
index 000000000000..ddc1619815f0
--- /dev/null
+++ b/include/linux/moxtet.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Turris Mox module configuration bus driver
+ *
+ * Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ */
+
+#ifndef __LINUX_MOXTET_H
+#define __LINUX_MOXTET_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+
+#define TURRIS_MOX_MAX_MODULES	10
+
+enum turris_mox_cpu_module_id {
+	TURRIS_MOX_CPU_ID_EMMC	= 0x00,
+	TURRIS_MOX_CPU_ID_SD	= 0x10,
+};
+
+enum turris_mox_module_id {
+	TURRIS_MOX_MODULE_SFP		= 0x01,
+	TURRIS_MOX_MODULE_PCI		= 0x02,
+	TURRIS_MOX_MODULE_TOPAZ		= 0x03,
+	TURRIS_MOX_MODULE_PERIDOT	= 0x04,
+	TURRIS_MOX_MODULE_USB3		= 0x05,
+	TURRIS_MOX_MODULE_PASSPCI	= 0x06,
+};
+
+static inline const char *turris_mox_module_name(unsigned int id)
+{
+	switch (id) {
+	case TURRIS_MOX_MODULE_SFP:
+		return "sfp";
+	case TURRIS_MOX_MODULE_PCI:
+		return "pci";
+	case TURRIS_MOX_MODULE_TOPAZ:
+		return "topaz";
+	case TURRIS_MOX_MODULE_PERIDOT:
+		return "peridot";
+	case TURRIS_MOX_MODULE_USB3:
+		return "usb3";
+	case TURRIS_MOX_MODULE_PASSPCI:
+		return "passthrough-pci";
+	default:
+		return "unknown";
+	}
+}
+
+extern struct bus_type moxtet_type;
+
+struct moxtet {
+	struct device	*dev;
+	struct mutex	lock;
+	u8		modules[TURRIS_MOX_MAX_MODULES];
+	int		count;
+	u8		tx[TURRIS_MOX_MAX_MODULES];
+	char		module_topology[128];
+};
+
+struct moxtet_driver {
+	const enum turris_mox_module_id	*id_table;
+	struct device_driver		driver;
+};
+
+static inline struct moxtet_driver *
+to_moxtet_driver(struct device_driver *drv)
+{
+	if (!drv)
+		return NULL;
+	return container_of(drv, struct moxtet_driver, driver);
+}
+
+extern int __moxtet_register_driver(struct module *owner,
+				    struct moxtet_driver *mdrv);
+
+static inline void moxtet_unregister_driver(struct moxtet_driver *mdrv)
+{
+	if (mdrv)
+		driver_unregister(&mdrv->driver);
+}
+
+#define moxtet_register_driver(driver) \
+	__moxtet_register_driver(THIS_MODULE, driver)
+
+#define module_moxtet_driver(__moxtet_driver) \
+	module_driver(__moxtet_driver, moxtet_register_driver, \
+			moxtet_unregister_driver)
+
+struct moxtet_device {
+	struct device			dev;
+	struct moxtet			*moxtet;
+	enum turris_mox_module_id	id;
+	unsigned int			idx;
+};
+
+extern int moxtet_device_read(struct device *dev);
+extern int moxtet_device_write(struct device *dev, u8 val);
+extern int moxtet_device_written(struct device *dev);
+
+static inline struct moxtet_device *
+to_moxtet_device(struct device *dev)
+{
+	if (!dev)
+		return NULL;
+	return container_of(dev, struct moxtet_device, dev);
+}
+
+#endif /* __LINUX_MOXTET_H */
-- 
2.18.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFELCp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:02:45 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51225 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751580AbeFELCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:02:41 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v5 6/8] platform/mellanox: Introduce support for Mellanox register access driver
Date: Tue,  5 Jun 2018 12:58:19 +0000
Message-Id: <1528203501-129092-1-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new Mellanox platform driver to allow access to Mellanox
programmable device register space trough sysfs interface.
The driver purpose is to provide sysfs interface for user space for the
registers essential for system control and monitoring.
The sets of registers for sysfs access are supposed to be defined per
system type bases and include the registers related to system resets
operation, system reset causes monitoring and some kinds of mux selection.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1->v2:
 Change added by Vadim:
 - Change ---help--- to help in Kconfig, according to new requirements;
v2->v3:
 Comments pointed out by Darren:
 - Remove conditional assignment per attribute mode type, because mode
   will guard against not permitted access.
   Verified by Vadim.
v4-v5:
 Comments pointed out by Darren:
 - Add more comments.
 - Add validation for the buffer length in attribute store method.
 - Remove unnecessary check for input value in attribute store method.
 - Change name val to input_value in order to improve code readability.
 Changes added by Vadim:
 - Extend logic in attribute show and store methods to cover all
   configurations.
---
 drivers/platform/mellanox/Kconfig     |  11 ++
 drivers/platform/mellanox/Makefile    |   1 +
 drivers/platform/mellanox/mlxreg-io.c | 227 ++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/platform/mellanox/mlxreg-io.c

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 591bccd..ddfae9fc 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
 	  This driver handles hot-plug events for the power suppliers, power
 	  cables and fans on the wide range Mellanox IB and Ethernet systems.
 
+config MLXREG_IO
+	tristate "Mellanox platform register access driver support"
+	depends on REGMAP
+	depends on HWMON
+	help
+	  This driver allows access to Mellanox programmable device register
+	  space trough sysfs interface. The sets of registers for sysfs access
+	  are defined per system type bases and includes the registers related
+	  to system resets operation, system reset causes monitoring and some
+	  kinds of mux selection.
+
 endif # MELLANOX_PLATFORM
diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
index 7c8385e..57074d9c 100644
--- a/drivers/platform/mellanox/Makefile
+++ b/drivers/platform/mellanox/Makefile
@@ -4,3 +4,4 @@
 # Mellanox Platform-Specific Drivers
 #
 obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
+obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
new file mode 100644
index 0000000..2d4867a
--- /dev/null
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Mellanox register access driver
+ *
+ * Copyright (C) 2018 Mellanox Technologies
+ * Copyright (C) 2018 Vadim Pasternak <vadimp@mellanox.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_data/mlxreg.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* Attribute parameters. */
+#define MLXREG_IO_ATT_SIZE	10
+#define MLXREG_IO_ATT_NUM	48
+
+/**
+ * struct mlxreg_io_priv_data - driver's private data:
+ *
+ * @pdev: platform device;
+ * @pdata: platform data;
+ * @hwmon: hwmon device;
+ * @mlxreg_io_attr: sysfs attributes array;
+ * @mlxreg_io_dev_attr: sysfs sensor device attribute array;
+ * @group: sysfs attribute group;
+ * @groups: list of sysfs attribute group for hwmon registration;
+ */
+struct mlxreg_io_priv_data {
+	struct platform_device *pdev;
+	struct mlxreg_core_platform_data *pdata;
+	struct device *hwmon;
+	struct attribute *mlxreg_io_attr[MLXREG_IO_ATT_NUM + 1];
+	struct sensor_device_attribute mlxreg_io_dev_attr[MLXREG_IO_ATT_NUM];
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
+};
+
+static ssize_t
+mlxreg_io_attr_show(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct mlxreg_io_priv_data *priv = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct mlxreg_core_data *data = priv->pdata->data + index;
+	u32 regval = 0;
+	int ret;
+
+	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
+	if (ret)
+		goto access_error;
+
+	/*
+	 * There are three kinds of attributes: single bit, full register's
+	 * bits and bit sequence. For the first kind field mask indicates which
+	 * bits are not related and filed bit is set zero. For the second kind
+	 * field mask is set to zero and field bit is set with all bits one.
+	 * For the third kind, filed mask indicates which bits are related and
+	 * field bit is set to the first bit number (from 1 to 32) is the bit
+	 * sequence.
+	 */
+	if (!data->bit)
+		regval = !!(regval & ~data->mask);
+	else if (!data->mask)
+		regval &= data->bit;
+	else
+		regval = ror32(regval & data->mask, (data->bit - 1));
+
+	return sprintf(buf, "%u\n", regval);
+
+access_error:
+	return ret;
+}
+
+static ssize_t
+mlxreg_io_attr_store(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t len)
+{
+	struct mlxreg_io_priv_data *priv = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct mlxreg_core_data *data = priv->pdata->data + index;
+	u32 input_val, regval;
+	int ret;
+
+	if (len > MLXREG_IO_ATT_SIZE)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, MLXREG_IO_ATT_SIZE, &input_val);
+	if (ret)
+		return ret;
+
+	/* Convert buffer to input value. */
+	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
+	if (ret)
+		goto access_error;
+
+	if (!data->bit) {
+		/* Single bit, set or clear it according to the input value. */
+		regval &= data->mask;
+		if (input_val)
+			regval |= ~data->mask;
+	} else if (!data->mask) {
+		/* All bits, clear out of range bits form the input value. */
+		regval = input_val & data->bit;
+	} else {
+		/* Bit sequence: shift to relevant position and mask. */
+		input_val = rol32(input_val, data->bit - 1) & data->mask;
+		/* Clear relevant bits and set them to new value. */
+		regval = (regval & ~data->mask) | input_val;
+	}
+
+	ret = regmap_write(priv->pdata->regmap, data->reg, regval);
+	if (ret)
+		goto access_error;
+
+	return len;
+
+access_error:
+	dev_err(&priv->pdev->dev, "Bus access error\n");
+	return ret;
+}
+
+static struct device_attribute mlxreg_io_devattr_rw = {
+	.show	= mlxreg_io_attr_show,
+	.store	= mlxreg_io_attr_store,
+};
+
+static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv)
+{
+	int i;
+
+	priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
+					 priv->pdata->counter *
+					 sizeof(struct attribute *),
+					 GFP_KERNEL);
+	if (!priv->group.attrs)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->pdata->counter; i++) {
+		priv->mlxreg_io_attr[i] =
+				&priv->mlxreg_io_dev_attr[i].dev_attr.attr;
+		memcpy(&priv->mlxreg_io_dev_attr[i].dev_attr,
+		       &mlxreg_io_devattr_rw, sizeof(struct device_attribute));
+
+		/* Set attribute name as a label. */
+		priv->mlxreg_io_attr[i]->name =
+				devm_kasprintf(&priv->pdev->dev, GFP_KERNEL,
+					       priv->pdata->data[i].label);
+
+		if (!priv->mlxreg_io_attr[i]->name) {
+			dev_err(&priv->pdev->dev, "Memory allocation failed for sysfs attribute %d.\n",
+				i + 1);
+			return -ENOMEM;
+		}
+
+		priv->mlxreg_io_dev_attr[i].dev_attr.attr.mode =
+						priv->pdata->data[i].mode;
+		priv->mlxreg_io_dev_attr[i].dev_attr.attr.name =
+					priv->mlxreg_io_attr[i]->name;
+		priv->mlxreg_io_dev_attr[i].index = i;
+		sysfs_attr_init(&priv->mlxreg_io_dev_attr[i].dev_attr.attr);
+	}
+
+	priv->group.attrs = priv->mlxreg_io_attr;
+	priv->groups[0] = &priv->group;
+	priv->groups[1] = NULL;
+
+	return 0;
+}
+
+static int mlxreg_io_probe(struct platform_device *pdev)
+{
+	struct mlxreg_io_priv_data *priv;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdata = dev_get_platdata(&pdev->dev);
+	if (!priv->pdata) {
+		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		return -EINVAL;
+	}
+
+	priv->pdev = pdev;
+
+	err = mlxreg_io_attr_init(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to allocate attributes: %d\n",
+			err);
+		return err;
+	}
+
+	priv->hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
+							     "mlxreg_io",
+							      priv,
+							      priv->groups);
+	if (IS_ERR(priv->hwmon)) {
+		dev_err(&pdev->dev, "Failed to register hwmon device %ld\n",
+			PTR_ERR(priv->hwmon));
+		return PTR_ERR(priv->hwmon);
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	return 0;
+}
+
+static struct platform_driver mlxreg_io_driver = {
+	.driver = {
+	    .name = "mlxreg-io",
+	},
+	.probe = mlxreg_io_probe,
+};
+
+module_platform_driver(mlxreg_io_driver);
+
+MODULE_AUTHOR("Vadim Pasternak <vadimp@mellanox.com>");
+MODULE_DESCRIPTION("Mellanox regmap I/O access driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mlxreg-io");
-- 
2.1.4

Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AIpwx4/TdJch5Q2RjqJBzWjLULSQAPuMwdxr62lWc2E2NTfT/1LCZxqlF74d3owx8CLSppnmYgDK
ARC-Seal: i=1; a=rsa-sha256; t=1522137956; cv=none;
        d=google.com; s=arc-20160816;
        b=RlrGvPjqBSJbNIDQIW8TKWbmeM+KnquNTB8TqDiguVlcdbnmGWxxAE7A66tIW+2+0W
         8lGL+Ezf1MVcxkB/A9xMxW6GqkH/lPZ5YDwcxld7PpQfX6I+ZIyfe4vad2CgWLOlIyU2
         sHrOvshVkBqI3un7lJHmlk3kl4Q0Q8GvOeDtLzVGeQio3Ntu81rywbU84SW0FKCMP9aP
         UpcoJkw1QesL3ZE1lHBggyRsbx8Fj8jdFNfdsPYwN6C8mvf8ggjLauUnE7exgmdUvsHg
         +qfMcRNVmn4ZpAAyRcPP1RPevJRwxwlZEWEn7MzpqWD0nrvZ/gLx5llVt/WerH39MN32
         FGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qxD95ULV0Jn5eD1DgT2RI/ntIx+BGLOPUuVnXO9KJqk=;
        b=vbBUaexcEznXJaL/VwPKRI2N3tWosV/08yS/sgsIlhOntKsWRxrpCtxQ8OgcF5feGH
         Kts1VERMAXhP4Fwbfd9r2Wiwg0i/D1ATZJTWzDROQv6w5F/xsl/N+f2ayNujxeFM7xOr
         Cbp3JYeV/84uQwb3ovOlrmGRbMns80HFDnuNB4+IhwXag5CXYHFFKgtjuk74OTv3hpUK
         JWwoxriodrlk3vqpPW5u+w6rvBJurqX03rXSYvEIUjRhxACmqw+XWICBCemnwEyByIBV
         X352WjnKRGPk3YNWsyX9tLZOmVux6gEVZr4XHuscZJPSV/iOPsgpsxzD5FruWBveAxJW
         7xjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 6/7] platform/mellanox: Introduce support for Mellanox register access driver
Date: Tue, 27 Mar 2018 10:02:06 +0000
Message-Id: <1522144927-56512-7-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077330779221681?=
X-GMAIL-MSGID: =?utf-8?q?1596077330779221681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It introduces new Mellanox platform driver to allow access to Mellanox
programmable device register space trough sysfs interface.
The driver purpose is to provide sysfs interface for user space for the
registers essential for system control and monitoring.
The sets of registers for sysfs access are supposed to be defined per
system type bases and include the registers related to system resets
operation, system reset causes monitoring and some kinds of mux selection.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/Kconfig     |  11 ++
 drivers/platform/mellanox/Makefile    |   1 +
 drivers/platform/mellanox/mlxreg-io.c | 221 ++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/platform/mellanox/mlxreg-io.c

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 591bccd..7fc266e 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
 	  This driver handles hot-plug events for the power suppliers, power
 	  cables and fans on the wide range Mellanox IB and Ethernet systems.
 
+config MLXREG_IO
+	tristate "Mellanox platform register access driver support"
+	depends on REGMAP
+	depends on HWMON
+	---help---
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
index 0000000..f573b65
--- /dev/null
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -0,0 +1,221 @@
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
+	if (!data->bit)
+		regval = !!(regval & ~data->mask);
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
+	u32 val, regval;
+	int ret;
+
+	ret = kstrtou32(buf, MLXREG_IO_ATT_SIZE, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
+	if (ret)
+		goto access_error;
+
+	regval &= data->mask;
+
+	val = !!val;
+	if (val)
+		regval |= ~data->mask;
+	else
+		regval &= data->mask;
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
+		switch (priv->pdata->data[i].mode) {
+		case 0200:
+			priv->mlxreg_io_dev_attr[i].dev_attr.store =
+							mlxreg_io_attr_store;
+			break;
+
+		case 0444:
+			priv->mlxreg_io_dev_attr[i].dev_attr.show =
+							mlxreg_io_attr_show;
+			break;
+
+		case 0644:
+			priv->mlxreg_io_dev_attr[i].dev_attr.show =
+							mlxreg_io_attr_show;
+			priv->mlxreg_io_dev_attr[i].dev_attr.store =
+							mlxreg_io_attr_store;
+			break;
+
+		default:
+			dev_err(&priv->pdev->dev, "Bad access mode %u for attribute %s.\n",
+				priv->pdata->data[i].mode,
+				priv->mlxreg_io_attr[i]->name);
+			return -EINVAL;
+		}
+
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

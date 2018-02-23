Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeBWK1Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:27:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43194 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:14 -0500
X-Google-Smtp-Source: AH8x22512ehmlRKSZtILxgH2GeqUVDI08IjizRS+lFsLY6cw2Opm1it7OdJdcLqkdgL3WtLr8G4K/Q==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 03/13] drivers: Add boot constraints core
Date: Fri, 23 Feb 2018 15:53:42 +0530
Message-Id: <4b97ea6f509fe74bd5d3341f6b1f2d441962543a.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices are powered ON by the bootloader before the bootloader
handovers control to Linux. It maybe important for those devices to keep
working until the time a Linux device driver probes the device and
reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the platform is booting into
Linux. The LCD controller can be using some resources, like clk,
regulators, PM domain, etc, that are shared between several devices.
These shared resources should be configured to satisfy need of all the
users. If another device's (X) driver gets probed before the LCD
controller driver in this case, then it may end up reconfiguring these
resources to ranges satisfying the current users (only device X) and
that can make the LCD screen unstable.

This patch introduces the concept of boot-constraints, which will be set
by the bootloaders and the kernel will satisfy them until the time
driver for such a device is probed (successfully or unsuccessfully).

The list of boot constraint types is empty for now, and will be
incrementally updated by later patches.

Only two routines are exposed by the boot constraints core for now:

- dev_boot_constraint_add(): This shall be called by parts of the kernel
  (before the device is probed) to set the constraints.

- dev_boot_constraints_remove(): This is called only by the driver core
  after a device is probed successfully or unsuccessfully. Special
  handling is done here for deferred probing.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   1 +
 drivers/base/dd.c               |  20 ++--
 drivers/bootconstraint/Kconfig  |   9 ++
 drivers/bootconstraint/Makefile |   3 +
 drivers/bootconstraint/core.c   | 219 ++++++++++++++++++++++++++++++++++++++++
 drivers/bootconstraint/core.h   |  30 ++++++
 include/linux/boot_constraint.h |  66 ++++++++++++
 8 files changed, 343 insertions(+), 7 deletions(-)
 create mode 100644 drivers/bootconstraint/Kconfig
 create mode 100644 drivers/bootconstraint/Makefile
 create mode 100644 drivers/bootconstraint/core.c
 create mode 100644 drivers/bootconstraint/core.h
 create mode 100644 include/linux/boot_constraint.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 879dc0604cba..2cef3c2563b6 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -5,6 +5,8 @@ source "drivers/amba/Kconfig"
 
 source "drivers/base/Kconfig"
 
+source "drivers/bootconstraint/Kconfig"
+
 source "drivers/bus/Kconfig"
 
 source "drivers/connector/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..a38c8b0af3af 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-$(CONFIG_NVM)		+= lightnvm/
 obj-y				+= base/ block/ misc/ mfd/ nfc/
+obj-$(CONFIG_DEV_BOOT_CONSTRAINT) += bootconstraint/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd092bf2f..777267aa1710 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -16,6 +16,7 @@
  * Copyright (c) 2007-2009 Novell Inc.
  */
 
+#include <linux/boot_constraint.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -445,15 +446,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	 */
 	devices_kset_move_last(dev);
 
-	if (dev->bus->probe) {
+	if (dev->bus->probe)
 		ret = dev->bus->probe(dev);
-		if (ret)
-			goto probe_failed;
-	} else if (drv->probe) {
+	else if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			goto probe_failed;
-	}
+
+	/*
+	 * Remove boot constraints for both successful and unsuccessful probe(),
+	 * except for the case where EPROBE_DEFER is returned by probe().
+	 */
+	if (ret != -EPROBE_DEFER)
+		dev_boot_constraints_remove(dev);
+
+	if (ret)
+		goto probe_failed;
 
 	if (test_remove) {
 		test_remove = false;
diff --git a/drivers/bootconstraint/Kconfig b/drivers/bootconstraint/Kconfig
new file mode 100644
index 000000000000..9195f9a39fe2
--- /dev/null
+++ b/drivers/bootconstraint/Kconfig
@@ -0,0 +1,9 @@
+config DEV_BOOT_CONSTRAINT
+	bool "Boot constraints for devices"
+	help
+	  This enables boot constraints detection for devices. These constraints
+	  are (normally) set by the Bootloader and must be satisfied by the
+	  kernel until the relevant device driver is probed. Once the driver is
+	  probed, the constraint is dropped.
+
+	  If unsure, say N.
diff --git a/drivers/bootconstraint/Makefile b/drivers/bootconstraint/Makefile
new file mode 100644
index 000000000000..0f2680177974
--- /dev/null
+++ b/drivers/bootconstraint/Makefile
@@ -0,0 +1,3 @@
+# Makefile for device boot constraints
+
+obj-y := core.o
diff --git a/drivers/bootconstraint/core.c b/drivers/bootconstraint/core.c
new file mode 100644
index 000000000000..a9f38a0febb3
--- /dev/null
+++ b/drivers/bootconstraint/core.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This takes care of boot time device constraints, normally set by the
+ * Bootloader.
+ *
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+#define for_each_constraint(_constraint, _temp, _cdev)		\
+	list_for_each_entry_safe(_constraint, _temp, &_cdev->constraints, node)
+
+/* Global list of all constraint devices currently registered */
+static LIST_HEAD(constraint_devices);
+static DEFINE_MUTEX(constraint_devices_mutex);
+
+/* Boot constraints core */
+
+static struct constraint_dev *constraint_device_find(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	list_for_each_entry(cdev, &constraint_devices, node) {
+		if (cdev->dev == dev)
+			return cdev;
+	}
+
+	return NULL;
+}
+
+static struct constraint_dev *constraint_device_allocate(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return ERR_PTR(-ENOMEM);
+
+	cdev->dev = dev;
+	INIT_LIST_HEAD(&cdev->node);
+	INIT_LIST_HEAD(&cdev->constraints);
+
+	list_add(&cdev->node, &constraint_devices);
+
+	return cdev;
+}
+
+static void constraint_device_free(struct constraint_dev *cdev)
+{
+	list_del(&cdev->node);
+	kfree(cdev);
+}
+
+static struct constraint_dev *constraint_device_get(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	cdev = constraint_device_find(dev);
+	if (cdev)
+		return cdev;
+
+	cdev = constraint_device_allocate(dev);
+	if (IS_ERR(cdev)) {
+		dev_err(dev, "Failed to add constraint dev (%ld)\n",
+			PTR_ERR(cdev));
+	}
+
+	return cdev;
+}
+
+static void constraint_device_put(struct constraint_dev *cdev)
+{
+	if (!list_empty(&cdev->constraints))
+		return;
+
+	constraint_device_free(cdev);
+}
+
+static struct constraint *constraint_allocate(struct constraint_dev *cdev,
+					enum dev_boot_constraint_type type)
+{
+	struct constraint *constraint;
+	int (*add)(struct constraint *constraint, void *data);
+	void (*remove)(struct constraint *constraint);
+
+	switch (type) {
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
+	if (!constraint)
+		return ERR_PTR(-ENOMEM);
+
+	constraint->cdev = cdev;
+	constraint->type = type;
+	constraint->add = add;
+	constraint->remove = remove;
+	INIT_LIST_HEAD(&constraint->node);
+
+	list_add(&constraint->node, &cdev->constraints);
+
+	return constraint;
+}
+
+static void constraint_free(struct constraint *constraint)
+{
+	list_del(&constraint->node);
+	kfree(constraint);
+}
+
+/**
+ * dev_boot_constraint_add: Adds a boot constraint.
+ *
+ * @dev: Device for which the boot constraint is getting added.
+ * @info: Structure representing the boot constraint.
+ *
+ * This routine adds a single boot constraint for the device. This must be
+ * called before the device is probed by its driver, otherwise the boot
+ * constraint will never get removed and may result in unwanted behavior of the
+ * hardware. The boot constraint is removed by the driver core automatically
+ * after the device is probed (successfully or unsuccessfully).
+ *
+ * Return: 0 on success, and a negative error otherwise.
+ */
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info)
+{
+	struct constraint_dev *cdev;
+	struct constraint *constraint;
+	int ret;
+
+	mutex_lock(&constraint_devices_mutex);
+
+	/* Find or add the cdev type first */
+	cdev = constraint_device_get(dev);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto unlock;
+	}
+
+	constraint = constraint_allocate(cdev, info->constraint.type);
+	if (IS_ERR(constraint)) {
+		dev_err(dev, "Failed to add constraint type: %d (%ld)\n",
+			info->constraint.type, PTR_ERR(constraint));
+		ret = PTR_ERR(constraint);
+		goto put_cdev;
+	}
+
+	constraint->free_resources = info->free_resources;
+	constraint->free_resources_data = info->free_resources_data;
+
+	/* Set constraint */
+	ret = constraint->add(constraint, info->constraint.data);
+	if (ret)
+		goto free_constraint;
+
+	dev_dbg(dev, "Added boot constraint-type (%d)\n",
+		info->constraint.type);
+
+	mutex_unlock(&constraint_devices_mutex);
+
+	return 0;
+
+free_constraint:
+	constraint_free(constraint);
+put_cdev:
+	constraint_device_put(cdev);
+unlock:
+	mutex_unlock(&constraint_devices_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_boot_constraint_add);
+
+static void constraint_remove(struct constraint *constraint)
+{
+	constraint->remove(constraint);
+
+	if (constraint->free_resources)
+		constraint->free_resources(constraint->free_resources_data);
+
+	constraint_free(constraint);
+}
+
+/**
+ * dev_boot_constraints_remove: Removes all boot constraints of a device.
+ *
+ * @dev: Device for which the boot constraints are getting removed.
+ *
+ * This routine removes all the boot constraints that were previously added for
+ * the device. This is called directly by the driver core and should not be
+ * called by platform specific code.
+ */
+void dev_boot_constraints_remove(struct device *dev)
+{
+	struct constraint_dev *cdev;
+	struct constraint *constraint, *temp;
+
+	mutex_lock(&constraint_devices_mutex);
+
+	cdev = constraint_device_find(dev);
+	if (!cdev)
+		goto unlock;
+
+	for_each_constraint(constraint, temp, cdev)
+		constraint_remove(constraint);
+
+	constraint_device_put(cdev);
+unlock:
+	mutex_unlock(&constraint_devices_mutex);
+}
diff --git a/drivers/bootconstraint/core.h b/drivers/bootconstraint/core.h
new file mode 100644
index 000000000000..d04bd484b2a7
--- /dev/null
+++ b/drivers/bootconstraint/core.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+#ifndef _CORE_H
+#define _CORE_H
+
+#include <linux/boot_constraint.h>
+#include <linux/device.h>
+#include <linux/list.h>
+
+struct constraint_dev {
+	struct device *dev;
+	struct list_head node;
+	struct list_head constraints;
+};
+
+struct constraint {
+	struct constraint_dev *cdev;
+	struct list_head node;
+	enum dev_boot_constraint_type type;
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+
+	int (*add)(struct constraint *constraint, void *data);
+	void (*remove)(struct constraint *constraint);
+	void *private;
+};
+#endif /* _CORE_H */
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
new file mode 100644
index 000000000000..d56e33f3f921
--- /dev/null
+++ b/include/linux/boot_constraint.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Boot constraints header.
+ *
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+#ifndef _LINUX_BOOT_CONSTRAINT_H
+#define _LINUX_BOOT_CONSTRAINT_H
+
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct device;
+
+/**
+ * enum dev_boot_constraint_type - This defines different boot constraint types.
+ *
+ */
+enum dev_boot_constraint_type {
+	DEV_BOOT_CONSTRAINT_NONE,
+};
+
+/**
+ * struct dev_boot_constraint - This represents a single boot constraint.
+ *
+ * @type: This is boot constraint type (like: clk, supply, etc.).
+ * @data: This points to constraint type specific data (like:
+ * dev_boot_constraint_clk_info).
+ */
+struct dev_boot_constraint {
+	enum dev_boot_constraint_type type;
+	void *data;
+};
+
+/**
+ * struct dev_boot_constraint_info - This is used to add a single boot
+ * constraint.
+ *
+ * @constraint: This represents a single boot constraint.
+ * @free_resources: This callback is called by the boot constraint core after
+ * the constraint is removed. This is an optional field.
+ * @free_resources_data: This is data to be passed to free_resources() callback.
+ * This is an optional field.
+ */
+struct dev_boot_constraint_info {
+	struct dev_boot_constraint constraint;
+
+	/* This will be called just before the constraint is removed */
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+};
+
+#ifdef CONFIG_DEV_BOOT_CONSTRAINT
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info);
+void dev_boot_constraints_remove(struct device *dev);
+#else
+static inline
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info)
+{ return 0; }
+static inline void dev_boot_constraints_remove(struct device *dev) {}
+#endif /* CONFIG_DEV_BOOT_CONSTRAINT */
+
+#endif /* _LINUX_BOOT_CONSTRAINT_H */
-- 
2.15.0.194.g9af6a3dea062

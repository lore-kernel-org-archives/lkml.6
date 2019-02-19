Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF5C00319
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B67E21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfBSDHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:07:32 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:46258 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfBSDHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:07:32 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 825803897E7936F5B1F2;
        Tue, 19 Feb 2019 11:06:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1J36G6X092401;
        Tue, 19 Feb 2019 11:06:16 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021911062864-595573 ;
          Tue, 19 Feb 2019 11:06:28 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V6 2/4]  misc/pvpanic: Add pvpanic driver framework
Date:   Tue, 19 Feb 2019 19:27:46 +0800
Message-Id: <1550575668-6240-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550575668-6240-1-git-send-email-peng.hao2@zte.com.cn>
References: <1550575668-6240-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-19 11:06:28,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-19 11:06:12,
        Serialize complete at 2019-02-19 11:06:12
X-MAIL: mse01.zte.com.cn x1J36G6X092401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pvpanic driver framework and split the original pvpanic acpi/of
driver as the two separate files and modify code to adapt the framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic/Kconfig        |  19 ++++
 drivers/misc/pvpanic/Makefile       |   2 +
 drivers/misc/pvpanic/pvpanic-acpi.c |  77 +++++++++++++++
 drivers/misc/pvpanic/pvpanic-of.c   |  53 +++++++++++
 drivers/misc/pvpanic/pvpanic.c      | 181 ++++++++++++------------------------
 drivers/misc/pvpanic/pvpanic.h      |  15 +++
 6 files changed, 225 insertions(+), 122 deletions(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
 create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
 create mode 100644 drivers/misc/pvpanic/pvpanic.h

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 3e612c6..0c0c0b2 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -5,3 +5,22 @@ config PVPANIC
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
+
+if PVPANIC
+
+config PVPANIC_ACPI
+	tristate "pvpanic acpi driver"
+	depends on ACPI
+	default PVPANIC
+	help
+	  This driver is one specific driver for pvpanic driver framework.
+	  It provides an acpi device as pvpanic device.
+
+config PVPANIC_OF
+	tristate "pvpanic mmio driver"
+	depends on OF
+	help
+	  This driver is one specific driver for pvpanic driver framework.
+	  It provides a mmio device as pvpanic device.
+
+endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index 6394224..8819509 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -3,3 +3,5 @@
 # Copyright (c) 2018 ZTE Ltd.
 
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
+obj-$(CONFIG_PVPANIC_ACPI)       += pvpanic-acpi.o
+obj-$(CONFIG_PVPANIC_OF)         += pvpanic-of.o
diff --git a/drivers/misc/pvpanic/pvpanic-acpi.c b/drivers/misc/pvpanic/pvpanic-acpi.c
new file mode 100644
index 0000000..8d10924
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-acpi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic acpi driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao
+ */
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_add(struct acpi_device *device);
+static int pvpanic_remove(struct acpi_device *device);
+
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 }
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
+static struct acpi_driver pvpanic_driver = {
+	.name =         "pvpanic",
+	.class =        "QEMU",
+	.ids =          pvpanic_device_ids,
+	.ops =          {
+				.add =          pvpanic_add,
+				.remove =       pvpanic_remove,
+			},
+	.owner =        THIS_MODULE,
+};
+
+static acpi_status
+pvpanic_walk_resources(struct acpi_resource *res, void *context)
+{
+	struct resource r;
+	int ret = 0;
+	struct device *dev = context;
+
+	memset(&r, 0, sizeof(r));
+	if (acpi_dev_resource_io(res, &r) || acpi_dev_resource_memory(res, &r))
+		ret = pvpanic_add_device(dev, &r);
+
+	if (!ret)
+		return AE_OK;
+
+	return AE_ERROR;
+}
+static int pvpanic_add(struct acpi_device *device)
+{
+	int ret;
+	acpi_status status;
+
+	ret = acpi_bus_get_status(device);
+	if (ret < 0)
+		return ret;
+
+	if (!device->status.enabled || !device->status.functional)
+		return -ENODEV;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     pvpanic_walk_resources, &device->dev);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_remove(struct acpi_device *device)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
+module_acpi_driver(pvpanic_driver);
diff --git a/drivers/misc/pvpanic/pvpanic-of.c b/drivers/misc/pvpanic/pvpanic-of.c
new file mode 100644
index 0000000..73ca5f3
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-of.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  pvpanic of driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+static int pvpanic_mmio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	ret = pvpanic_add_device(&pdev->dev, res);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pvpanic_mmio_remove(struct platform_device *pdev)
+{
+	pvpanic_remove_device();
+	return 0;
+}
+
+static const struct of_device_id pvpanic_mmio_match[] = {
+	{ .compatible = "qemu,pvpanic-mmio", },
+	{}
+};
+
+static struct platform_driver pvpanic_mmio_driver = {
+	.driver = {
+		.name = "pvpanic-mmio",
+		.of_match_table = pvpanic_mmio_match,
+	},
+	.probe = pvpanic_mmio_probe,
+	.remove = pvpanic_mmio_remove,
+};
+
+module_platform_driver(pvpanic_mmio_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 595ac06..ccadec0 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -8,15 +8,17 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-static void __iomem *base;
+static struct {
+	struct platform_device *pdev;
+	void __iomem *base;
+	bool is_ioport;
+} pvpanic_data;
 
 #define PVPANIC_PANICKED        (1 << 0)
 
@@ -27,7 +29,7 @@
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	iowrite8(event, pvpanic_data.base);
 }
 
 static int
@@ -43,150 +45,85 @@
 	.priority = 1, /* let this called before broken drm_fb_helper */
 };
 
-#ifdef CONFIG_ACPI
-static int pvpanic_add(struct acpi_device *device);
-static int pvpanic_remove(struct acpi_device *device);
-
-static const struct acpi_device_id pvpanic_device_ids[] = {
-	{ "QEMU0001", 0 },
-	{ "", 0 }
-};
-MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
-
-static struct acpi_driver pvpanic_driver = {
-	.name =		"pvpanic",
-	.class =	"QEMU",
-	.ids =		pvpanic_device_ids,
-	.ops =		{
-				.add =		pvpanic_add,
-				.remove =	pvpanic_remove,
-			},
-	.owner =	THIS_MODULE,
-};
-
-static acpi_status
-pvpanic_walk_resources(struct acpi_resource *res, void *context)
-{
-	struct resource r;
-
-	if (acpi_dev_resource_io(res, &r)) {
-		base = ioport_map(r.start, resource_size(&r));
-		return AE_OK;
-	} else if (acpi_dev_resource_memory(res, &r)) {
-		base = ioremap(r.start, resource_size(&r));
-		return AE_OK;
-	}
-
-	return AE_ERROR;
-}
-
-static int pvpanic_add(struct acpi_device *device)
+int pvpanic_add_device(struct device *dev, struct resource *res)
 {
+	struct platform_device *pdev;
 	int ret;
 
-	ret = acpi_bus_get_status(device);
-	if (ret < 0)
-		return ret;
-
-	if (!device->status.enabled || !device->status.functional)
-		return -ENODEV;
+	pdev = platform_device_alloc("pvpanic", -1);
+	if (!pdev)
+		return -ENOMEM;
 
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    pvpanic_walk_resources, NULL);
+	pdev->dev.parent = dev;
 
-	if (!base)
-		return -ENODEV;
+	ret = platform_device_add_resources(pdev, res, 1);
+	if (ret)
+		goto err;
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
-
-	return 0;
-}
-
-static int pvpanic_remove(struct acpi_device *device)
-{
-
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
-	iounmap(base);
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto err;
+	pvpanic_data.pdev = pdev;
 
 	return 0;
+err:
+	platform_device_put(pdev);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(pvpanic_add_device);
 
-static int pvpanic_register_acpi_driver(void)
+void pvpanic_remove_device(void)
 {
-	return acpi_bus_register_driver(&pvpanic_driver);
+	platform_device_unregister(pvpanic_data.pdev);
+	pvpanic_data.pdev = NULL;
 }
+EXPORT_SYMBOL_GPL(pvpanic_remove_device);
 
-static void pvpanic_unregister_acpi_driver(void)
+static int pvpanic_platform_probe(struct platform_device *pdev)
 {
-	acpi_bus_unregister_driver(&pvpanic_driver);
-}
-#else
-static int pvpanic_register_acpi_driver(void)
-{
-	return -ENODEV;
-}
-
-static void pvpanic_unregister_acpi_driver(void) {}
-#endif
-
-static int pvpanic_mmio_probe(struct platform_device *pdev)
-{
-	struct resource *mem;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-
-	base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return -ENODEV;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+		if (!res)
+			return -ENODEV;
+
+		base = ioport_map(res->start, resource_size(res));
+		if (!base)
+			return -ENODEV;
+		pvpanic_data.is_ioport = true;
+	}
+
+	pvpanic_data.base = base;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
 
 	return 0;
 }
 
-static int pvpanic_mmio_remove(struct platform_device *pdev)
+static int pvpanic_platform_remove(struct platform_device *pdev)
 {
-
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &pvpanic_panic_nb);
+	if (pvpanic_data.is_ioport)
+		iounmap(pvpanic_data.base);
 
 	return 0;
 }
 
-static const struct of_device_id pvpanic_mmio_match[] = {
-	{ .compatible = "qemu,pvpanic-mmio", },
-	{}
-};
-
-static struct platform_driver pvpanic_mmio_driver = {
+static struct platform_driver pvpanic_driver = {
+	.probe = pvpanic_platform_probe,
+	.remove = pvpanic_platform_remove,
 	.driver = {
-		.name = "pvpanic-mmio",
-		.of_match_table = pvpanic_mmio_match,
-	},
-	.probe = pvpanic_mmio_probe,
-	.remove = pvpanic_mmio_remove,
+		.name = "pvpanic",
+	}
 };
 
-static int __init pvpanic_mmio_init(void)
-{
-	if (acpi_disabled)
-		return platform_driver_register(&pvpanic_mmio_driver);
-	else
-		return pvpanic_register_acpi_driver();
-}
-
-static void __exit pvpanic_mmio_exit(void)
-{
-	if (acpi_disabled)
-		platform_driver_unregister(&pvpanic_mmio_driver);
-	else
-		pvpanic_unregister_acpi_driver();
-}
-
-module_init(pvpanic_mmio_init);
-module_exit(pvpanic_mmio_exit);
+module_platform_driver(pvpanic_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
new file mode 100644
index 0000000..7fb6bb2
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* pvpanic driver framework header file
+ *
+ * Copyright (C) 2019 ZTE Ltd.
+ *
+ * Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#ifndef __DRIVERS_MISC_PVPANIC_H
+#define __DRIVERS_MISC_PVPANIC_H
+
+extern int pvpanic_add_device(struct device *dev, struct resource *res);
+extern void pvpanic_remove_device(void);
+
+#endif
-- 
1.8.3.1


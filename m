Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524756577; cv=none;
        d=google.com; s=arc-20160816;
        b=ViqGhWkrbBQxVofhw73FdTEjTlCm/D2x5Fqs50l2yuDeqSzODnUReZt4ASK2SgxL2p
         4y4qZgZ2XfvuXhNXKCpYJ5wPVrFdrApALpxZ5fd3nV5o2zRhYPh8oIOj3fefeoCXFUUj
         JEIdcOfkEpu4PRXacKgP+JqrSS9emBsGzSzeFOJ5u0AdIrmE8TwX/hKbjUY9bXXaCW/T
         0674tdupewJ1K7m7DiytmNTXWAKL++FSp7GQqeDJjYi0+/lEjngqOjOB/wCSi2/skyVN
         yGyASKkOthon0SEzMJvmMnNEyIFMB61h8hxcB+BvapIUZCJTHiTDGtXC/bYxUJ/zfsNf
         ym7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=dP/iv4nYZ2Zzzb9UJyIQSqixu5+U0vTlmCuWP8NrWuU=;
        b=cNMtcwjhjzwf2eQCg9Ij9shHv+NYdPj2SVCxovpUpYKKPL5FcLq4w0KaTj/723IwD/
         c731Tdr+L7LdUNTB1mc5d75McwFiai/S2O7xBYpF9N6lVJlNv6sYA4udvE3bR+JWmIwp
         kW9olm7Uc9lHirwGYf+GyyBfBQQB8c3caEc1ZG9ki29N72TAOujigdTXyebc/POufxDT
         hyGOxSQVxMvE5BDk5A6tHSFpu/BPqb2W8AD1+dr5+DOMuGFDwNO6mRKna4UjKn7bd6cO
         VAC53GXtLf42Br9vu0VMpkk+N61lE8u60ANngqdq9+oR4+wiQKZwHg0rK73fJAdFnptI
         wqUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=A3JLp0eI;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=A3JLp0eI;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4+3XoVfRcQwUo4VMIHmDgzM27k0T9z6t/d0xTO2i5eMbkLJJD3Sr/iGDnuXAA2L4GHUszRR+Q==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Rosin <peda@axentia.se>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFC PoC 1/2] earlydev: implement a new way to probe platform devices early
Date: Thu, 26 Apr 2018 17:29:19 +0200
Message-Id: <20180426152920.21569-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426152920.21569-1-brgl@bgdev.pl>
References: <20180426152920.21569-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823153159386390?=
X-GMAIL-MSGID: =?utf-8?q?1598823153159386390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The current implementation of early platform drivers is pretty much a
hack built on top of the early_param mechanism. The devices only look
like platform devices and use the same structures but never actually
get registered with the driver model.

The idea behind this series is to allow users to probe platform devices
very early in the boot sequence and then switch the early devices to
actual platform devices and the early drivers to platform drivers in
during device_initcall.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/Kconfig            |   3 +
 drivers/base/Makefile           |   1 +
 drivers/base/earlydev.c         | 175 ++++++++++++++++++++++++++++++++
 drivers/base/platform.c         |  11 ++
 include/linux/earlydev.h        |  63 ++++++++++++
 include/linux/platform_device.h |   4 +
 6 files changed, 257 insertions(+)
 create mode 100644 drivers/base/earlydev.c
 create mode 100644 include/linux/earlydev.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 29b0eb452b3a..e05f96d626b3 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -170,6 +170,9 @@ config DEV_COREDUMP
 	default y if WANT_DEV_COREDUMP
 	depends on ALLOW_DEV_COREDUMP
 
+config EARLYDEV
+	def_bool n
+
 config DEBUG_DRIVER
 	bool "Driver Core verbose debug messages"
 	depends on DEBUG_KERNEL
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index b074f242a435..ec47f86eac44 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -7,6 +7,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   devcon.o
+obj-$(CONFIG_EARLYDEV)	+= earlydev.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/earlydev.c b/drivers/base/earlydev.c
new file mode 100644
index 000000000000..3da9e81031d2
--- /dev/null
+++ b/drivers/base/earlydev.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Texas Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#include <linux/earlydev.h>
+#include <linux/slab.h>
+
+#include "base.h"
+
+static bool early_done;
+static LIST_HEAD(early_drvs);
+static LIST_HEAD(early_devs);
+
+static void earlydev_pdev_set_name(struct platform_device *pdev)
+{
+	if (pdev->dev.init_name)
+		return;
+
+	if (!slab_is_available()) {
+		pr_warn("slab unavailable - not assigning name to early device\n");
+		return;
+	}
+
+	switch (pdev->id) {
+	case PLATFORM_DEVID_NONE:
+		pdev->dev.init_name = kasprintf(GFP_KERNEL, "%s", pdev->name);
+		break;
+	case PLATFORM_DEVID_AUTO:
+		pr_warn("auto device ID not supported in early devices\n");
+		break;
+	default:
+		pdev->dev.init_name = kasprintf(GFP_KERNEL, "%s.%d",
+						pdev->name, pdev->id);
+		break;
+	}
+
+	if (!pdev->dev.init_name)
+		pr_warn("error allocating the early device name\n");
+}
+
+static void earlydev_probe_devices(void)
+{
+	struct earlydev_driver *edrv, *ndrv;
+	struct earlydev_device *edev, *ndev;
+	int rv;
+
+	list_for_each_entry_safe(edev, ndev, &early_devs, list) {
+		if (edev->bound_to)
+			continue;
+
+		list_for_each_entry_safe(edrv, ndrv, &early_drvs, list) {
+			if (strcmp(edrv->plat_drv.driver.name,
+				   edev->pdev.name) != 0)
+				continue;
+
+			earlydev_pdev_set_name(&edev->pdev);
+			rv = edrv->plat_drv.probe(&edev->pdev);
+			if (rv) {
+				if (rv == -EPROBE_DEFER) {
+					/*
+					 * Move the device to the end of the
+					 * list so that it'll be reprobed next
+					 * time after all new devices.
+					 */
+					list_move_tail(&edev->list,
+						       &early_devs);
+					continue;
+				}
+
+				pr_err("error probing early device: %d\n", rv);
+				continue;
+			}
+
+			edev->bound_to = edrv;
+			edev->pdev.early_probed = true;
+		}
+	}
+}
+
+bool earlydev_probing_early(void)
+{
+	return !early_done;
+}
+
+bool earlydev_probe_late(struct platform_device *pdev)
+{
+	struct earlydev_device *edev;
+
+	edev = container_of(pdev, struct earlydev_device, pdev);
+
+	return edev->probe_late;
+}
+
+void __earlydev_driver_register(struct earlydev_driver *edrv,
+				struct module *owner)
+{
+	if (early_done) {
+		__platform_driver_register(&edrv->plat_drv, owner);
+		return;
+	}
+
+	pr_debug("registering early driver: %s\n", edrv->plat_drv.driver.name);
+
+	edrv->plat_drv.driver.owner = owner;
+
+	INIT_LIST_HEAD(&edrv->list);
+	list_add(&early_drvs, &edrv->list);
+
+	earlydev_probe_devices();
+}
+EXPORT_SYMBOL_GPL(__earlydev_driver_register);
+
+void earlydev_device_add(struct earlydev_device *edev)
+{
+	if (early_done) {
+		platform_device_register(&edev->pdev);
+		return;
+	}
+
+	pr_debug("adding early device: %s\n", edev->pdev.name);
+
+	INIT_LIST_HEAD(&edev->list);
+	list_add(&early_devs, &edev->list);
+
+	earlydev_probe_devices();
+}
+EXPORT_SYMBOL_GPL(earlydev_device_add);
+
+static void earlydev_drivers_to_platform(void)
+{
+	struct earlydev_driver *edrv, *n;
+	struct platform_driver *pdrv;
+	int rv;
+
+	list_for_each_entry_safe(edrv, n, &early_drvs, list) {
+		pdrv = &edrv->plat_drv;
+
+		rv = __platform_driver_register(pdrv, pdrv->driver.owner);
+		if (rv)
+			pr_err("error switching early to platform driver: %d\n",
+			       rv);
+
+		list_del(&edrv->list);
+	}
+}
+
+static void earlydev_devices_to_platform(void)
+{
+	struct earlydev_device *edev, *n;
+	struct platform_device *pdev;
+	int rv;
+
+	list_for_each_entry_safe(edev, n, &early_devs, list) {
+		pdev = &edev->pdev;
+
+		rv = platform_device_register(pdev);
+		if (rv)
+			pr_err("error switching early to platform device: %d\n",
+			       rv);
+	}
+}
+
+static int earlydev_switch_to_platform(void)
+{
+	pr_debug("switching early drivers and devices to platform\n");
+	early_done = true;
+
+	earlydev_drivers_to_platform();
+	earlydev_devices_to_platform();
+
+	return 0;
+}
+device_initcall(earlydev_switch_to_platform);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..fb51ce242f6c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -26,6 +26,7 @@
 #include <linux/clk/clk-conf.h>
 #include <linux/limits.h>
 #include <linux/property.h>
+#include <linux/earlydev.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -574,7 +575,17 @@ static int platform_drv_probe(struct device *_dev)
 	ret = dev_pm_domain_attach(_dev, true);
 	if (ret != -EPROBE_DEFER) {
 		if (drv->probe) {
+#ifdef CONFIG_EARLYDEV
+			if (dev->early_probed && !earlydev_probe_late(dev)) {
+				/* Skip this probe if probed early. */
+				dev->early_probed = false;
+				ret = 0;
+			} else {
+				ret = drv->probe(dev);
+			}
+#else /* CONFIG_EARLYDEV */
 			ret = drv->probe(dev);
+#endif /* CONFIG_EARLYDEV */
 			if (ret)
 				dev_pm_domain_detach(_dev, true);
 		} else {
diff --git a/include/linux/earlydev.h b/include/linux/earlydev.h
new file mode 100644
index 000000000000..7f190a904405
--- /dev/null
+++ b/include/linux/earlydev.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Texast Instruments
+ * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef __EARLYDEV_H__
+#define __EARLYDEV_H__
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+struct earlydev_driver {
+	struct list_head list;
+	struct platform_driver plat_drv;
+};
+
+struct earlydev_device {
+	struct list_head list;
+	struct platform_device pdev;
+	struct earlydev_driver *bound_to;
+	bool probe_late;
+};
+
+#ifdef CONFIG_EARLYDEV
+extern bool earlydev_probing_early(void);
+extern bool earlydev_probe_late(struct platform_device *pdev);
+extern void __earlydev_driver_register(struct earlydev_driver *edrv,
+				       struct module *owner);
+#define earlydev_driver_register(_driver) \
+	__earlydev_driver_register((_driver), THIS_MODULE)
+extern void earlydev_device_add(struct earlydev_device *edev);
+#else /* CONFIG_EARLYDEV */
+static inline void earlydev_probing_early(void)
+{
+	return false;
+}
+static inline bool earlydev_probe_late(struct platform_device *pdev)
+{
+	return true;
+}
+static inline void __earlydev_driver_register(struct earlydev_driver *drv,
+					       struct module *owner) {}
+#define earlydev_driver_register(_driver)
+static inline void earlydev_device_add(struct earlydev_device *edev) {}
+#endif /* CONFIG_EARLYDEV */
+
+/*
+ * REVISIT: early_initcall may be still too late for some timers and critical
+ * clocks. We should probably have a separate section with callbacks that can
+ * be invoked at each architecture's discretion.
+ */
+#define earlydev_platform_driver(_drv)					\
+	static int _drv##_register(void)				\
+	{								\
+		earlydev_driver_register(&(_drv));			\
+		return 0;						\
+	}								\
+	early_initcall(_drv##_register)
+
+#endif /* __EARLYDEV_H__ */
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d96118..5246f60f9aae 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -36,6 +36,10 @@ struct platform_device {
 
 	/* arch specific additions */
 	struct pdev_archdata	archdata;
+
+#ifdef CONFIG_EARLYDEV
+	bool early_probed;
+#endif
 };
 
 #define platform_get_device_id(pdev)	((pdev)->id_entry)
-- 
2.17.0

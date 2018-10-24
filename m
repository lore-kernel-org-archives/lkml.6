Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2105C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3AF207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3AF207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJXR3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:29:17 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:53388 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeJXR3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:29:10 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id DB8384A824E66131929C;
        Wed, 24 Oct 2018 17:01:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9O91AEs009093;
        Wed, 24 Oct 2018 17:01:10 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102417013357-6460469 ;
          Wed, 24 Oct 2018 17:01:33 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V2 1/4]  misc/pvpanic: move pvpanic to misc as common driver
Date:   Thu, 25 Oct 2018 01:12:13 +0800
Message-Id: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-24 17:01:33,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-24 17:01:02,
        Serialize complete at 2018-10-24 17:01:02
X-MAIL: mse01.zte.com.cn w9O91AEs009093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move pvpanic.c from drivers/platform/x86 to drivers/misc.
following patches will use pvpanic device in arm64.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/Kconfig           |   7 +++
 drivers/misc/Makefile          |   1 +
 drivers/misc/pvpanic.c         | 124 +++++++++++++++++++++++++++++++++++++++++
 drivers/platform/Kconfig       |   3 +
 drivers/platform/Makefile      |   1 +
 drivers/platform/x86/Kconfig   |   8 ---
 drivers/platform/x86/Makefile  |   1 -
 drivers/platform/x86/pvpanic.c | 124 -----------------------------------------
 8 files changed, 136 insertions(+), 133 deletions(-)
 create mode 100644 drivers/misc/pvpanic.c
 delete mode 100644 drivers/platform/x86/pvpanic.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5d71300..ca55c94 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -499,6 +499,13 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config PVPANIC
+	tristate "pvpanic device support"
+	help
+          This driver provides support for the pvpanic device.  pvpanic is
+          a paravirtualized device provided by QEMU; it lets a virtual machine
+          (guest) communicate panic events to the host.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 20be70c..39dc005 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_PVPANIC)  		+= pvpanic.o
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
new file mode 100644
index 0000000..fd86dab
--- /dev/null
+++ b/drivers/misc/pvpanic.c
@@ -0,0 +1,124 @@
+/*
+ *  pvpanic.c - pvpanic Device Support
+ *
+ *  Copyright (C) 2013 Fujitsu.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+
+MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
+MODULE_DESCRIPTION("pvpanic device driver");
+MODULE_LICENSE("GPL");
+
+static int pvpanic_add(struct acpi_device *device);
+static int pvpanic_remove(struct acpi_device *device);
+
+static const struct acpi_device_id pvpanic_device_ids[] = {
+	{ "QEMU0001", 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
+
+#define PVPANIC_PANICKED	(1 << 0)
+
+static u16 port;
+
+static struct acpi_driver pvpanic_driver = {
+	.name =		"pvpanic",
+	.class =	"QEMU",
+	.ids =		pvpanic_device_ids,
+	.ops =		{
+				.add =		pvpanic_add,
+				.remove =	pvpanic_remove,
+			},
+	.owner =	THIS_MODULE,
+};
+
+static void
+pvpanic_send_event(unsigned int event)
+{
+	outb(event, port);
+}
+
+static int
+pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
+		     void *unused)
+{
+	pvpanic_send_event(PVPANIC_PANICKED);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pvpanic_panic_nb = {
+	.notifier_call = pvpanic_panic_notify,
+	.priority = 1, /* let this called before broken drm_fb_helper */
+};
+
+
+static acpi_status
+pvpanic_walk_resources(struct acpi_resource *res, void *context)
+{
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		return AE_OK;
+
+	case ACPI_RESOURCE_TYPE_IO:
+		port = res->data.io.minimum;
+		return AE_OK;
+
+	default:
+		return AE_ERROR;
+	}
+}
+
+static int pvpanic_add(struct acpi_device *device)
+{
+	int ret;
+
+	ret = acpi_bus_get_status(device);
+	if (ret < 0)
+		return ret;
+
+	if (!device->status.enabled || !device->status.functional)
+		return -ENODEV;
+
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+			    pvpanic_walk_resources, NULL);
+
+	if (!port)
+		return -ENODEV;
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &pvpanic_panic_nb);
+
+	return 0;
+}
+
+static int pvpanic_remove(struct acpi_device *device)
+{
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &pvpanic_panic_nb);
+	return 0;
+}
+
+module_acpi_driver(pvpanic_driver);
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index d4c2e42..8b64b78 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -1,3 +1,6 @@
+if ARM64
+source "drivers/platform/arm/Kconfig"
+endif
 if X86
 source "drivers/platform/x86/Kconfig"
 endif
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 4b2ce58..232231c 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -3,6 +3,7 @@
 # Makefile for linux/drivers/platform
 #
 
+obj-$(CONFIG_ARM64)               += arm/
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_MELLANOX_PLATFORM)	+= mellanox/
 obj-$(CONFIG_MIPS)		+= mips/
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ef016e4..a6b412e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1119,14 +1119,6 @@ config INTEL_SMARTCONNECT
 	  This driver checks to determine whether the device has Intel Smart
 	  Connect enabled, and if so disables it.
 
-config PVPANIC
-	tristate "pvpanic device support"
-	depends on ACPI
-	---help---
-	  This driver provides support for the pvpanic device.  pvpanic is
-	  a paravirtualized device provided by QEMU; it lets a virtual machine
-	  (guest) communicate panic events to the host.
-
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2ba6cb7..a4ec299 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -75,7 +75,6 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
 obj-$(CONFIG_INTEL_RST)		+= intel-rst.o
 obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
 
-obj-$(CONFIG_PVPANIC)           += pvpanic.o
 obj-$(CONFIG_ALIENWARE_WMI)	+= alienware-wmi.o
 obj-$(CONFIG_INTEL_PMC_IPC)	+= intel_pmc_ipc.o
 obj-$(CONFIG_SILEAD_DMI)	+= silead_dmi.o
diff --git a/drivers/platform/x86/pvpanic.c b/drivers/platform/x86/pvpanic.c
deleted file mode 100644
index fd86dab..0000000
--- a/drivers/platform/x86/pvpanic.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- *  pvpanic.c - pvpanic Device Support
- *
- *  Copyright (C) 2013 Fujitsu.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/acpi.h>
-
-MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
-MODULE_DESCRIPTION("pvpanic device driver");
-MODULE_LICENSE("GPL");
-
-static int pvpanic_add(struct acpi_device *device);
-static int pvpanic_remove(struct acpi_device *device);
-
-static const struct acpi_device_id pvpanic_device_ids[] = {
-	{ "QEMU0001", 0 },
-	{ "", 0 },
-};
-MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
-
-#define PVPANIC_PANICKED	(1 << 0)
-
-static u16 port;
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
-static void
-pvpanic_send_event(unsigned int event)
-{
-	outb(event, port);
-}
-
-static int
-pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
-		     void *unused)
-{
-	pvpanic_send_event(PVPANIC_PANICKED);
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pvpanic_panic_nb = {
-	.notifier_call = pvpanic_panic_notify,
-	.priority = 1, /* let this called before broken drm_fb_helper */
-};
-
-
-static acpi_status
-pvpanic_walk_resources(struct acpi_resource *res, void *context)
-{
-	switch (res->type) {
-	case ACPI_RESOURCE_TYPE_END_TAG:
-		return AE_OK;
-
-	case ACPI_RESOURCE_TYPE_IO:
-		port = res->data.io.minimum;
-		return AE_OK;
-
-	default:
-		return AE_ERROR;
-	}
-}
-
-static int pvpanic_add(struct acpi_device *device)
-{
-	int ret;
-
-	ret = acpi_bus_get_status(device);
-	if (ret < 0)
-		return ret;
-
-	if (!device->status.enabled || !device->status.functional)
-		return -ENODEV;
-
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    pvpanic_walk_resources, NULL);
-
-	if (!port)
-		return -ENODEV;
-
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
-	return 0;
-}
-
-module_acpi_driver(pvpanic_driver);
-- 
1.8.3.1


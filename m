Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCMNdn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:33:43 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33499 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbeCMNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:31:19 -0400
X-Google-Smtp-Source: AG47ELt2IHrn5CMpI0zVkMCEfEUmwD2W5IJqOTdBUZjp2naGPEAJIjahEe+a4X/kWHEojWLFEU3VIA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 1/8] drm/xen-front: Introduce Xen para-virtualized frontend driver
Date: Tue, 13 Mar 2018 15:31:00 +0200
Message-Id: <1520947867-32514-2-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520947867-32514-1-git-send-email-andr2000@gmail.com>
References: <1520947867-32514-1-git-send-email-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Introduce skeleton of the para-virtualized Xen display
frontend driver. This patch only adds required
essential stubs.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/Kconfig             |  2 ++
 drivers/gpu/drm/Makefile            |  1 +
 drivers/gpu/drm/xen/Kconfig         | 17 +++++++++
 drivers/gpu/drm/xen/Makefile        |  5 +++
 drivers/gpu/drm/xen/xen_drm_front.c | 70 +++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 drivers/gpu/drm/xen/Kconfig
 create mode 100644 drivers/gpu/drm/xen/Makefile
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index deeefa7a1773..757825ac60df 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -289,6 +289,8 @@ source "drivers/gpu/drm/pl111/Kconfig"
 
 source "drivers/gpu/drm/tve200/Kconfig"
 
+source "drivers/gpu/drm/xen/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 50093ff4479b..9d66657ea117 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -103,3 +103,4 @@ obj-$(CONFIG_DRM_MXSFB)	+= mxsfb/
 obj-$(CONFIG_DRM_TINYDRM) += tinydrm/
 obj-$(CONFIG_DRM_PL111) += pl111/
 obj-$(CONFIG_DRM_TVE200) += tve200/
+obj-$(CONFIG_DRM_XEN) += xen/
diff --git a/drivers/gpu/drm/xen/Kconfig b/drivers/gpu/drm/xen/Kconfig
new file mode 100644
index 000000000000..4cca160782ab
--- /dev/null
+++ b/drivers/gpu/drm/xen/Kconfig
@@ -0,0 +1,17 @@
+config DRM_XEN
+	bool "DRM Support for Xen guest OS"
+	depends on XEN
+	help
+	  Choose this option if you want to enable DRM support
+	  for Xen.
+
+config DRM_XEN_FRONTEND
+	tristate "Para-virtualized frontend driver for Xen guest OS"
+	depends on DRM_XEN
+	depends on DRM
+	select DRM_KMS_HELPER
+	select VIDEOMODE_HELPERS
+	select XEN_XENBUS_FRONTEND
+	help
+	  Choose this option if you want to enable a para-virtualized
+	  frontend DRM/KMS driver for Xen guest OSes.
diff --git a/drivers/gpu/drm/xen/Makefile b/drivers/gpu/drm/xen/Makefile
new file mode 100644
index 000000000000..3283e104c7bb
--- /dev/null
+++ b/drivers/gpu/drm/xen/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+
+drm_xen_front-objs := xen_drm_front.o
+
+obj-$(CONFIG_DRM_XEN_FRONTEND) += drm_xen_front.o
diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
new file mode 100644
index 000000000000..03bc50b128fd
--- /dev/null
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+/*
+ *  Xen para-virtual DRM device
+ *
+ * Copyright (C) 2016-2018 EPAM Systems Inc.
+ *
+ * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+ */
+
+#include <drm/drmP.h>
+
+#include <xen/platform_pci.h>
+#include <xen/xen.h>
+#include <xen/xenbus.h>
+
+#include <xen/interface/io/displif.h>
+
+static void displback_changed(struct xenbus_device *xb_dev,
+		enum xenbus_state backend_state)
+{
+}
+
+static int xen_drv_probe(struct xenbus_device *xb_dev,
+		const struct xenbus_device_id *id)
+{
+	return 0;
+}
+
+static int xen_drv_remove(struct xenbus_device *dev)
+{
+	return 0;
+}
+
+static const struct xenbus_device_id xen_drv_ids[] = {
+	{ XENDISPL_DRIVER_NAME },
+	{ "" }
+};
+
+static struct xenbus_driver xen_driver = {
+	.ids = xen_drv_ids,
+	.probe = xen_drv_probe,
+	.remove = xen_drv_remove,
+	.otherend_changed = displback_changed,
+};
+
+static int __init xen_drv_init(void)
+{
+	if (!xen_domain())
+		return -ENODEV;
+
+	if (!xen_has_pv_devices())
+		return -ENODEV;
+
+	DRM_INFO("Registering XEN PV " XENDISPL_DRIVER_NAME "\n");
+	return xenbus_register_frontend(&xen_driver);
+}
+
+static void __exit xen_drv_cleanup(void)
+{
+	DRM_INFO("Unregistering XEN PV " XENDISPL_DRIVER_NAME "\n");
+	xenbus_unregister_driver(&xen_driver);
+}
+
+module_init(xen_drv_init);
+module_exit(xen_drv_cleanup);
+
+MODULE_DESCRIPTION("Xen para-virtualized display device frontend");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("xen:"XENDISPL_DRIVER_NAME);
-- 
2.7.4

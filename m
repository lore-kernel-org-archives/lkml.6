Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDJPyI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:54:08 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:41814 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeDJPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:53:59 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] vfio: platform: Add generic DT reset controller support
Date: Tue, 10 Apr 2018 17:53:47 +0200
Message-Id: <1523375627-23746-3-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
References: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vfio-platform requires reset support, provided either by ACPI, or, on DT
platforms, by a device-specific reset driver matching against the
device's compatible value.

On many SoCs, devices are connected to an SoC-internal reset controller.
If the reset hierarchy is described in DT using "resets" properties,
such devices can be reset in a generic way through the reset controller
subsystem.  Hence add support for this, avoiding the need to write
device-specific reset drivers for each single device on affected SoCs.

Devices that do require a more complex reset procedure can still provide
a device-specific reset driver, as that takes precedence.

Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
becomes a no-op (as in: "No reset function found for device") if reset
controller support is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Don't store error values in vdev->reset_control,
  - Use of_reset_control_get_exclusive() instead of
    __of_reset_control_get(),
  - Improve description.
---
 drivers/vfio/platform/vfio_platform_common.c  | 26 ++++++++++++++++++++++++--
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index b60bb5326668498c..3c13327b2777f8ec 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -17,6 +17,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -112,11 +113,19 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 	if (VFIO_PLATFORM_IS_ACPI(vdev))
 		return vfio_platform_acpi_has_reset(vdev);
 
-	return vdev->of_reset ? true : false;
+	if (vdev->of_reset)
+		return true;
+
+	if (vdev->reset_control)
+		return true;
+
+	return false;
 }
 
 static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
+	struct reset_control *rstc;
+
 	if (VFIO_PLATFORM_IS_ACPI(vdev))
 		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
 
@@ -127,8 +136,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 							&vdev->reset_module);
 	}
+	if (vdev->of_reset)
+		return 0;
+
+	rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
+	if (!IS_ERR(rstc)) {
+		vdev->reset_control = rstc;
+		return 0;
+	}
 
-	return vdev->of_reset ? 0 : -ENOENT;
+	return PTR_ERR(rstc);
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -138,6 +155,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 
 	if (vdev->of_reset)
 		module_put(vdev->reset_module);
+
+	reset_control_put(vdev->reset_control);
 }
 
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
@@ -217,6 +236,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
 	} else if (vdev->of_reset) {
 		dev_info(vdev->device, "reset\n");
 		return vdev->of_reset(vdev);
+	} else if (vdev->reset_control) {
+		dev_info(vdev->device, "reset\n");
+		return reset_control_reset(vdev->reset_control);
 	}
 
 	dev_warn(vdev->device, "no reset function found!\n");
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 85ffe5d9d1abd94e..a56e80ae5986540b 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -60,6 +60,7 @@ struct vfio_platform_device {
 	const char			*compat;
 	const char			*acpihid;
 	struct module			*reset_module;
+	struct reset_control		*reset_control;
 	struct device			*device;
 
 	/*
-- 
2.7.4

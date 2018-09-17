Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCC3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F742088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F742088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeIQWIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:08:24 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:42694 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbeIQWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:08:14 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id cgg41y00o3XaVaC06gg4sy; Mon, 17 Sep 2018 18:40:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZA-0006bE-AL; Mon, 17 Sep 2018 18:40:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZA-0004xm-9N; Mon, 17 Sep 2018 18:40:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v4 2/2] vfio: platform: Add generic reset controller support
Date:   Mon, 17 Sep 2018 18:39:55 +0200
Message-Id: <20180917163955.19023-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917163955.19023-1-geert+renesas@glider.be>
References: <20180917163955.19023-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vfio-platform requires dedicated reset support, provided either by ACPI,
or, on DT platforms, by a device-specific reset driver matching against
the device's compatible value.

On many SoCs, devices are connected to an SoC-internal reset controller.
If the reset hierarchy is described in DT using "resets" properties, or
in lookup tables in platform code, such devices can be reset in a
generic way through the reset controller subsystem.  Hence add support
for this, avoiding the need to write device-specific reset drivers for
each single device on affected SoCs.

Devices that do require a more complex reset procedure can still provide
a device-specific reset driver, as that takes precedence.

Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
becomes a no-op (as in: "No reset function found for device") if reset
controller support is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v4:
  - Add Reviewed-by,
  - Use new RFC reset_control_get_dedicated() instead of
    of_reset_control_get_exclusive(), to (a) make it more generic, and
    (b) make sure the reset returned is really a dedicated reset, and
    does not affect other devices,

v3:
  - Add Reviewed-by,
  - Merge similar checks in vfio_platform_has_reset(),

v2:
  - Don't store error values in vdev->reset_control,
  - Use of_reset_control_get_exclusive() instead of
    __of_reset_control_get(),
  - Improve description.

---
 drivers/vfio/platform/vfio_platform_common.c  | 20 +++++++++++++++++--
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index c0cd824be2b767be..eb77fe87f3663e3e 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -113,11 +114,13 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
 	if (VFIO_PLATFORM_IS_ACPI(vdev))
 		return vfio_platform_acpi_has_reset(vdev);
 
-	return vdev->of_reset ? true : false;
+	return vdev->of_reset || vdev->reset_control;
 }
 
 static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
+	struct reset_control *rstc;
+
 	if (VFIO_PLATFORM_IS_ACPI(vdev))
 		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
 
@@ -128,8 +131,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
 							&vdev->reset_module);
 	}
+	if (vdev->of_reset)
+		return 0;
+
+	rstc = reset_control_get_dedicated(vdev->device, NULL);
+	if (!IS_ERR(rstc)) {
+		vdev->reset_control = rstc;
+		return 0;
+	}
 
-	return vdev->of_reset ? 0 : -ENOENT;
+	return PTR_ERR(rstc);
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -139,6 +150,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
 
 	if (vdev->of_reset)
 		module_put(vdev->reset_module);
+
+	reset_control_put(vdev->reset_control);
 }
 
 static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
@@ -218,6 +231,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
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
2.17.1


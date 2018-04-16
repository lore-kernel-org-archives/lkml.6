Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDPRZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:25:51 -0400
Received: from anholt.net ([50.246.234.109]:55176 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDPRZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:25:49 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org
Cc: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/3] drm/vc4: Remove the need for the GPU-subsystem DT node.
Date: Mon, 16 Apr 2018 10:25:46 -0700
Message-Id: <20180416172546.32118-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413175632.oz62n363g6rxdp6z@rob-hp-laptop>
References: <20180413175632.oz62n363g6rxdp6z@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU subsystem node was a workaround to have a central device to
bind V3D and display to.  Following the lead of 246774d17fc0
("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
the subsystem node usage and just create a platform device for the DRM
device to attach to if any of the subsystem devices are present.

v2: Simplify the DT walking code.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/display/brcm,bcm-vc4.txt         |  7 -----
 drivers/gpu/drm/vc4/vc4_drv.c                 | 29 ++++++++++++++-----
 drivers/gpu/drm/vc4/vc4_hvs.c                 |  1 +
 drivers/gpu/drm/vc4/vc4_v3d.c                 |  1 +
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
index 284e2b14cfbe..5fd4717101d6 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
+++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
@@ -4,9 +4,6 @@ The VC4 device present on the Raspberry Pi includes a display system
 with HDMI output and the HVS (Hardware Video Scaler) for compositing
 display planes.
 
-Required properties for VC4:
-- compatible:	Should be "brcm,bcm2835-vc4" or "brcm,cygnus-vc4"
-
 Required properties for Pixel Valve:
 - compatible:	Should be one of "brcm,bcm2835-pixelvalve0",
 		  "brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
@@ -153,10 +150,6 @@ v3d: v3d@7ec00000 {
 	interrupts = <1 10>;
 };
 
-vc4: gpu {
-	compatible = "brcm,bcm2835-vc4";
-};
-
 panel: panel {
 	compatible = "ontat,yx700wv03", "simple-panel";
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 7c95ed5c5cac..13b840b534b8 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -364,22 +364,30 @@ static int vc4_platform_drm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id vc4_of_match[] = {
-	{ .compatible = "brcm,bcm2835-vc4", },
-	{ .compatible = "brcm,cygnus-vc4", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, vc4_of_match);
-
 static struct platform_driver vc4_platform_driver = {
 	.probe		= vc4_platform_drm_probe,
 	.remove		= vc4_platform_drm_remove,
 	.driver		= {
 		.name	= "vc4-drm",
-		.of_match_table = vc4_of_match,
 	},
 };
 
+static bool
+driver_of_table_has_a_match(const struct platform_driver *driver)
+{
+	struct device_node *node;
+
+	node = of_find_matching_node_and_match(NULL,
+					       driver->driver.of_match_table,
+					       NULL);
+	if (of_device_is_available(node)) {
+		of_node_put(node);
+		return true;
+	}
+
+	return false;
+}
+
 static int __init vc4_drm_register(void)
 {
 	int ret;
@@ -389,6 +397,11 @@ static int __init vc4_drm_register(void)
 	if (ret)
 		return ret;
 
+	if (driver_of_table_has_a_match(&vc4_v3d_driver) ||
+	    driver_of_table_has_a_match(&vc4_hvs_driver)) {
+		platform_device_register_simple("vc4-drm", -1, NULL, 0);
+	}
+
 	return platform_driver_register(&vc4_platform_driver);
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2b62fc5b8d85..730813ee74ae 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -262,6 +262,7 @@ static const struct of_device_id vc4_hvs_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-hvs" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, vc4_hvs_dt_match);
 
 struct platform_driver vc4_hvs_driver = {
 	.probe = vc4_hvs_dev_probe,
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bfc2fa73d2ae..e77e9ebbab4b 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -459,6 +459,7 @@ static const struct of_device_id vc4_v3d_dt_match[] = {
 	{ .compatible = "brcm,vc4-v3d" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, vc4_v3d_dt_match);
 
 struct platform_driver vc4_v3d_driver = {
 	.probe = vc4_v3d_dev_probe,
-- 
2.17.0

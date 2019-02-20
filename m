Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3B120855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfBTXhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:37:06 -0500
Received: from anholt.net ([50.246.234.109]:52460 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfBTXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:37:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EF41A10A2ADF;
        Wed, 20 Feb 2019 15:37:02 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wdfz0T6VtlzV; Wed, 20 Feb 2019 15:37:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D9D7310A2D20;
        Wed, 20 Feb 2019 15:36:59 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 045562FE464C; Wed, 20 Feb 2019 15:36:58 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 1/3] drm/v3d: Add support for V3D v4.2.
Date:   Wed, 20 Feb 2019 15:36:56 -0800
Message-Id: <20190220233658.986-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No compatible string for it yet, just the version-dependent changes.
They've now tied the hub and the core interrupt lines into a single
interrupt line coming out of the block.  It also turns out I made a
mistake in modeling the V3D v3.3 and v4.1 bridge as a part of V3D
itself -- the bridge is going away in favor of an external reset
controller in a larger HW module.

v2: Use consistent checks for whether we're on 4.2, and fix a leak in
    an error path.
v3: Use more general means of determining if the current 4.2 changes
    are in place, as apparently other platforms may switch back (noted
    by Dave).  Update the binding doc.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../devicetree/bindings/gpu/brcm,bcm-v3d.txt  | 11 ++++++--
 drivers/gpu/drm/v3d/v3d_drv.c                 | 21 +++++++++++---
 drivers/gpu/drm/v3d/v3d_drv.h                 |  2 ++
 drivers/gpu/drm/v3d/v3d_gem.c                 | 12 +++++++-
 drivers/gpu/drm/v3d/v3d_irq.c                 | 28 +++++++++++++++----
 5 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
index c907aa8dd755..b2df82b44625 100644
--- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
@@ -6,15 +6,20 @@ For V3D 2.x, see brcm,bcm-vc4.txt.
 Required properties:
 - compatible:	Should be "brcm,7268-v3d" or "brcm,7278-v3d"
 - reg:		Physical base addresses and lengths of the register areas
-- reg-names:	Names for the register areas.  The "hub", "bridge", and "core0"
+- reg-names:	Names for the register areas.  The "hub" and "core0"
 		  register areas are always required.  The "gca" register area
-		  is required if the GCA cache controller is present.
+		  is required if the GCA cache controller is present.  The
+		  "bridge" register area is required if an external reset
+		  controller is not present.
 - interrupts:	The interrupt numbers.  The first interrupt is for the hub,
-		  while the following interrupts are for the cores.
+		  while the following interrupts are separate interrupt lines
+		  for the cores (if they don't share the hub's interrupt).
 		  See bindings/interrupt-controller/interrupts.txt
 
 Optional properties:
 - clocks:	The core clock the unit runs on
+- resets:	The reset line for v3d, if not using a mapping of the bridge
+		  See bindings/reset/reset.txt
 
 v3d {
 	compatible = "brcm,7268-v3d";
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index b189b1a0ae7e..392e458b55bd 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
@@ -496,10 +497,6 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->pdev = pdev;
 	drm = &v3d->drm;
 
-	ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
-	if (ret)
-		goto dev_free;
-
 	ret = map_regs(v3d, &v3d->hub_regs, "hub");
 	if (ret)
 		goto dev_free;
@@ -514,6 +511,22 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->cores = V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
 	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
 
+	v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(v3d->reset)) {
+		ret = PTR_ERR(v3d->reset);
+
+		if (ret == -EPROBE_DEFER)
+			goto dev_free;
+
+		v3d->reset = NULL;
+		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
+		if (ret) {
+			dev_err(dev,
+				"Failed to get reset control or bridge regs\n");
+			goto dev_free;
+		}
+	}
+
 	if (v3d->ver < 41) {
 		ret = map_regs(v3d, &v3d->gca_regs, "gca");
 		if (ret)
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 9e0e11f57307..fab9979b7e1f 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -39,6 +39,7 @@ struct v3d_dev {
 	 * and revision.
 	 */
 	int ver;
+	bool single_irq_line;
 
 	struct device *dev;
 	struct platform_device *pdev;
@@ -47,6 +48,7 @@ struct v3d_dev {
 	void __iomem *bridge_regs;
 	void __iomem *gca_regs;
 	struct clk *clk;
+	struct reset_control *reset;
 
 	/* Virtual and DMA addresses of the single shared page table. */
 	volatile u32 *pt;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 0d1e5e0b8042..109be31e47ea 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/sched/signal.h>
@@ -69,7 +70,7 @@ v3d_idle_gca(struct v3d_dev *v3d)
 }
 
 static void
-v3d_reset_v3d(struct v3d_dev *v3d)
+v3d_reset_by_bridge(struct v3d_dev *v3d)
 {
 	int version = V3D_BRIDGE_READ(V3D_TOP_GR_BRIDGE_REVISION);
 
@@ -89,6 +90,15 @@ v3d_reset_v3d(struct v3d_dev *v3d)
 				 V3D_TOP_GR_BRIDGE_SW_INIT_1_V3D_CLK_108_SW_INIT);
 		V3D_BRIDGE_WRITE(V3D_TOP_GR_BRIDGE_SW_INIT_1, 0);
 	}
+}
+
+static void
+v3d_reset_v3d(struct v3d_dev *v3d)
+{
+	if (v3d->reset)
+		reset_control_reset(v3d->reset);
+	else
+		v3d_reset_by_bridge(v3d);
 
 	v3d_init_hw_state(v3d);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 69338da70ddc..288ab1036a7a 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -27,6 +27,9 @@
 			    V3D_HUB_INT_MMU_CAP |	\
 			    V3D_HUB_INT_TFUC))
 
+static irqreturn_t
+v3d_hub_irq(int irq, void *arg);
+
 static void
 v3d_overflow_mem_work(struct work_struct *work)
 {
@@ -112,6 +115,12 @@ v3d_irq(int irq, void *arg)
 	if (intsts & V3D_INT_GMPV)
 		dev_err(v3d->dev, "GMP violation\n");
 
+	/* V3D 4.2 wires the hub and core IRQs together, so if we &
+	 * didn't see the common one then check hub for MMU IRQs.
+	 */
+	if (v3d->single_irq_line && status == IRQ_NONE)
+		return v3d_hub_irq(irq, arg);
+
 	return status;
 }
 
@@ -170,12 +179,19 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
 
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
-			       v3d_hub_irq, IRQF_SHARED,
-			       "v3d_hub", v3d);
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
-			       v3d_irq, IRQF_SHARED,
-			       "v3d_core0", v3d);
+	if (platform_get_irq(v3d->pdev, 1) < 0) {
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+				       v3d_irq, IRQF_SHARED,
+				       "v3d", v3d);
+		v3d->single_irq_line = true;
+	} else {
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+				       v3d_hub_irq, IRQF_SHARED,
+				       "v3d_hub", v3d);
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
+				       v3d_irq, IRQF_SHARED,
+				       "v3d_core0", v3d);
+	}
 	if (ret)
 		dev_err(v3d->dev, "IRQ setup failed: %d\n", ret);
 
-- 
2.20.1


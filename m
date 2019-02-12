Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0830CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71D721904
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfBLU1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:27:21 -0500
Received: from anholt.net ([50.246.234.109]:59666 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731290AbfBLU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:27:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C8EDB10A02F6;
        Tue, 12 Feb 2019 12:27:19 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id TJjRLtsLSkp0; Tue, 12 Feb 2019 12:27:16 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A811F10A2C5B;
        Tue, 12 Feb 2019 12:27:14 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id BAEE82FE464C; Tue, 12 Feb 2019 12:27:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 1/3] drm/v3d: Add support for V3D v4.2.
Date:   Tue, 12 Feb 2019 12:27:11 -0800
Message-Id: <20190212202713.29205-1-eric@anholt.net>
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

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 19 +++++++++++++++----
 drivers/gpu/drm/v3d/v3d_drv.h |  1 +
 drivers/gpu/drm/v3d/v3d_gem.c | 12 +++++++++++-
 drivers/gpu/drm/v3d/v3d_irq.c | 27 +++++++++++++++++++++------
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index dd842af8b531..aef46de55b6a 100644
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
@@ -497,10 +498,6 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->pdev = pdev;
 	drm = &v3d->drm;
 
-	ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
-	if (ret)
-		goto dev_free;
-
 	ret = map_regs(v3d, &v3d->hub_regs, "hub");
 	if (ret)
 		goto dev_free;
@@ -515,6 +512,20 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	v3d->cores = V3D_GET_FIELD(ident1, V3D_HUB_IDENT1_NCORES);
 	WARN_ON(v3d->cores > 1); /* multicore not yet implemented */
 
+	if (v3d->ver >= 42) {
+		v3d->reset = devm_reset_control_get_exclusive(dev, NULL);
+		if (IS_ERR(v3d->reset)) {
+			ret = PTR_ERR(v3d->reset);
+			dev_err(dev, "Failed to get reset control: %ld\n",
+				ret);
+			goto dev_free;
+		}
+	} else {
+		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
+		if (ret)
+			goto dev_free;
+	}
+
 	if (v3d->ver < 41) {
 		ret = map_regs(v3d, &v3d->gca_regs, "gca");
 		if (ret)
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 239b56d76f3e..b5732cf897fe 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -48,6 +48,7 @@ struct v3d_dev {
 	void __iomem *bridge_regs;
 	void __iomem *gca_regs;
 	struct clk *clk;
+	struct reset_control *reset;
 
 	/* Virtual and DMA addresses of the single shared page table. */
 	volatile u32 *pt;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 803f31467ec1..3ee3ae4d3cac 100644
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
index 69338da70ddc..2ad0c5865edd 100644
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
+	if (v3d->ver >= 42 && status == IRQ_NONE)
+		return v3d_hub_irq(irq, arg);
+
 	return status;
 }
 
@@ -170,12 +179,18 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
 
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
-			       v3d_hub_irq, IRQF_SHARED,
-			       "v3d_hub", v3d);
-	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
-			       v3d_irq, IRQF_SHARED,
-			       "v3d_core0", v3d);
+	if (v3d->ver >= 42) {
+		ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
+				       v3d_irq, IRQF_SHARED,
+				       "v3d", v3d);
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


Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE21C71122
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3402098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TfciB5Nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3402098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeJMDv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJMDv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKHDZZ028890;
        Fri, 12 Oct 2018 15:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375433;
        bh=sA1ldwPNmkFm+qJsNutZcsrwiplxOOcc0sqQhRWT6VA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TfciB5NjHB2ShMxGV6geq8kMpBNnhCQA+oCqSjA/kn5mIua+mzNiFaTeT4GTIlayd
         DUODI8b/wB421yUFy9AmkyMLKUBVqHh9t6wP2gZ27pfzPH4FHaKIdTD7UAA3zV+VJE
         CHYURxUDThBmFukUBlnFsQIWaOnRSXrqG8GC2xpo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKHD6Q011773;
        Fri, 12 Oct 2018 15:17:13 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:13 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:13 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7EX000402;
        Fri, 12 Oct 2018 15:17:13 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 3/8] drm/omap: introduce omap_hw_overlay
Date:   Fri, 12 Oct 2018 15:16:58 -0500
Message-ID: <20181012201703.29065-4-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the hardware overlay specifics from omap_plane.
To start, the hw overlays are statically assigned to planes.

The goal is to eventually assign hw overlays dynamically to planes
during plane->atomic_check() based on requested caps (scaling, YUV,
etc). And then perform hw overlay re-assignment if required.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/Makefile       |  1 +
 drivers/gpu/drm/omapdrm/omap_drv.c     | 10 +++-
 drivers/gpu/drm/omapdrm/omap_drv.h     |  4 ++
 drivers/gpu/drm/omapdrm/omap_overlay.c | 87 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_overlay.h | 31 ++++++++++++
 drivers/gpu/drm/omapdrm/omap_plane.c   | 47 +++++++++---------
 6 files changed, 156 insertions(+), 24 deletions(-)
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h

diff --git a/drivers/gpu/drm/omapdrm/Makefile b/drivers/gpu/drm/omapdrm/Makefile
index f115253115c5..800dfd035360 100644
--- a/drivers/gpu/drm/omapdrm/Makefile
+++ b/drivers/gpu/drm/omapdrm/Makefile
@@ -12,6 +12,7 @@ omapdrm-y := omap_drv.o \
 	omap_debugfs.o \
 	omap_crtc.o \
 	omap_plane.o \
+	omap_overlay.o \
 	omap_encoder.o \
 	omap_connector.o \
 	omap_fb.o \
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 5e67d58cbc28..2921cc90f2d8 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -569,10 +569,14 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 
 	omap_gem_init(ddev);
 
+	ret = omap_hwoverlays_init(priv);
+	if (ret)
+		goto err_gem_deinit;
+
 	ret = omap_modeset_init(ddev);
 	if (ret) {
 		dev_err(priv->dev, "omap_modeset_init failed: ret=%d\n", ret);
-		goto err_gem_deinit;
+		goto err_free_overlays;
 	}
 
 	/* Initialize vblank handling, start with all CRTCs disabled. */
@@ -608,6 +612,8 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 err_cleanup_modeset:
 	drm_mode_config_cleanup(ddev);
 	omap_drm_irq_uninstall(ddev);
+err_free_overlays:
+	omap_hwoverlays_destroy(priv);
 err_gem_deinit:
 	omap_gem_deinit(ddev);
 	destroy_workqueue(priv->wq);
@@ -638,6 +644,8 @@ static void omapdrm_cleanup(struct omap_drm_private *priv)
 	omap_drm_irq_uninstall(ddev);
 	omap_gem_deinit(ddev);
 
+	omap_hwoverlays_destroy(priv);
+
 	destroy_workqueue(priv->wq);
 
 	omap_disconnect_pipelines(ddev);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index bd7f2c227a25..929f04e7cc3b 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -37,6 +37,7 @@
 #include "omap_gem.h"
 #include "omap_irq.h"
 #include "omap_plane.h"
+#include "omap_overlay.h"
 
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
@@ -69,6 +70,9 @@ struct omap_drm_private {
 	unsigned int num_planes;
 	struct drm_plane *planes[8];
 
+	unsigned int num_ovls;
+	struct omap_hw_overlay *overlays[8];
+
 	struct drm_fb_helper *fbdev;
 
 	struct workqueue_struct *wq;
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
new file mode 100644
index 000000000000..7a09b0aa823a
--- /dev/null
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Texas Instruments Incorporated -  http://www.ti.com/
+ * Author: Benoit Parrot, <bparrot@ti.com>
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_plane_helper.h>
+
+#include "omap_dmm_tiler.h"
+#include "omap_drv.h"
+
+/*
+ * overlay funcs
+ */
+static const char * const overlay_id_to_name[] = {
+	[OMAP_DSS_GFX] = "gfx",
+	[OMAP_DSS_VIDEO1] = "vid1",
+	[OMAP_DSS_VIDEO2] = "vid2",
+	[OMAP_DSS_VIDEO3] = "vid3",
+};
+
+static void omap_overlay_destroy(struct omap_hw_overlay *overlay)
+{
+	kfree(overlay);
+}
+
+static struct omap_hw_overlay *omap_overlay_init(enum omap_plane_id overlay_id,
+						 enum omap_overlay_caps caps)
+{
+	struct omap_hw_overlay *overlay;
+
+	overlay = kzalloc(sizeof(*overlay), GFP_KERNEL);
+	if (!overlay)
+		return ERR_PTR(-ENOMEM);
+
+	overlay->name = overlay_id_to_name[overlay_id];
+	overlay->overlay_id = overlay_id;
+	overlay->caps = caps;
+	/*
+	 * When this is called priv->num_crtcs is not known yet.
+	 * Use a safe mask value to start with, it will get updated to the
+	 * proper value after the first use.
+	 */
+	overlay->possible_crtcs = 0xff;
+
+	return overlay;
+}
+
+int omap_hwoverlays_init(struct omap_drm_private *priv)
+{
+	static const enum omap_plane_id hw_plane_ids[] = {
+			OMAP_DSS_GFX, OMAP_DSS_VIDEO1,
+			OMAP_DSS_VIDEO2, OMAP_DSS_VIDEO3,
+	};
+	u32 num_overlays = priv->dispc_ops->get_num_ovls(priv->dispc);
+	enum omap_overlay_caps caps;
+	int i, ret;
+
+	for (i = 0; i < num_overlays; i++) {
+		struct omap_hw_overlay *overlay;
+
+		caps = priv->dispc_ops->ovl_get_caps(priv->dispc, hw_plane_ids[i]);
+		overlay = omap_overlay_init(hw_plane_ids[i], caps);
+		if (IS_ERR(overlay)) {
+			ret = PTR_ERR(overlay);
+			dev_err(priv->dev, "failed to construct overlay for %s (%d)\n",
+				overlay_id_to_name[i], ret);
+			return ret;
+		}
+		overlay->idx = priv->num_ovls;
+		priv->overlays[priv->num_ovls++] = overlay;
+	}
+
+	return 0;
+}
+
+void omap_hwoverlays_destroy(struct omap_drm_private *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_ovls; i++) {
+		omap_overlay_destroy(priv->overlays[i]);
+		priv->overlays[i] = NULL;
+	}
+}
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.h b/drivers/gpu/drm/omapdrm/omap_overlay.h
new file mode 100644
index 000000000000..892fecb67adb
--- /dev/null
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Texas Instruments Incorporated -  http://www.ti.com/
+ * Author: Benoit Parrot, <bparrot@ti.com>
+ */
+
+#ifndef __OMAPDRM_OVERLAY_H__
+#define __OMAPDRM_OVERLAY_H__
+
+#include <linux/types.h>
+
+enum drm_plane_type;
+
+struct drm_device;
+struct drm_mode_object;
+struct drm_plane;
+
+/* Used to associate a HW overlay/plane to a plane */
+struct omap_hw_overlay {
+	int idx;
+
+	const char *name;
+	enum omap_plane_id overlay_id;
+
+	enum omap_overlay_caps caps;
+	u32 possible_crtcs;
+};
+
+int omap_hwoverlays_init(struct omap_drm_private *priv);
+void omap_hwoverlays_destroy(struct omap_drm_private *priv);
+#endif /* __OMAPDRM_OVERLAY_H__ */
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index e1e338e76841..26c2c78d020f 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -32,6 +32,8 @@ struct omap_plane {
 	struct drm_plane base;
 	enum omap_plane_id id;
 	const char *name;
+
+	struct omap_hw_overlay *overlay;
 };
 
 static int omap_plane_prepare_fb(struct drm_plane *plane,
@@ -57,8 +59,11 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct drm_plane_state *state = plane->state;
 	struct omap_overlay_info info;
+	enum omap_plane_id ovl_id = omap_plane->overlay->overlay_id;
 	int ret;
 
+	DBG("[PLANE:%d:%s] overlay_id: %d", plane->base.id, plane->name,
+	    ovl_id);
 	DBG("%s, crtc=%p fb=%p", omap_plane->name, state->crtc, state->fb);
 
 	memset(&info, 0, sizeof(info));
@@ -77,17 +82,17 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 			&info.paddr, &info.p_uv_addr);
 
 	/* and finally, update omapdss: */
-	ret = priv->dispc_ops->ovl_setup(priv->dispc, omap_plane->id, &info,
+	ret = priv->dispc_ops->ovl_setup(priv->dispc, ovl_id, &info,
 			      omap_crtc_timings(state->crtc), false,
 			      omap_crtc_channel(state->crtc));
 	if (ret) {
 		dev_err(plane->dev->dev, "Failed to setup plane %s\n",
 			omap_plane->name);
-		priv->dispc_ops->ovl_enable(priv->dispc, omap_plane->id, false);
+		priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, false);
 		return;
 	}
 
-	priv->dispc_ops->ovl_enable(priv->dispc, omap_plane->id, true);
+	priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, true);
 }
 
 static void omap_plane_atomic_disable(struct drm_plane *plane,
@@ -95,12 +100,13 @@ static void omap_plane_atomic_disable(struct drm_plane *plane,
 {
 	struct omap_drm_private *priv = plane->dev->dev_private;
 	struct omap_plane *omap_plane = to_omap_plane(plane);
+	enum omap_plane_id ovl_id = omap_plane->overlay->overlay_id;
 
 	plane->state->rotation = DRM_MODE_ROTATE_0;
 	plane->state->zpos = plane->type == DRM_PLANE_TYPE_PRIMARY
-			   ? 0 : omap_plane->id;
+			   ? 0 : ovl_id;
 
-	priv->dispc_ops->ovl_enable(priv->dispc, omap_plane->id, false);
+	priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, false);
 }
 
 static int omap_plane_atomic_check(struct drm_plane *plane,
@@ -209,7 +215,7 @@ static void omap_plane_reset(struct drm_plane *plane)
 	 * plane.
 	 */
 	plane->state->zpos = plane->type == DRM_PLANE_TYPE_PRIMARY
-			   ? 0 : omap_plane->id;
+			   ? 0 : omap_plane->overlay->overlay_id;
 }
 
 static int omap_plane_atomic_set_property(struct drm_plane *plane,
@@ -260,13 +266,6 @@ static const char *plane_id_to_name[] = {
 	[OMAP_DSS_VIDEO3] = "vid3",
 };
 
-static const enum omap_plane_id plane_idx_to_id[] = {
-	OMAP_DSS_GFX,
-	OMAP_DSS_VIDEO1,
-	OMAP_DSS_VIDEO2,
-	OMAP_DSS_VIDEO3,
-};
-
 /* initialize plane */
 struct drm_plane *omap_plane_init(struct drm_device *dev,
 		int idx, enum drm_plane_type type,
@@ -276,27 +275,29 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	unsigned int num_planes = priv->dispc_ops->get_num_ovls(priv->dispc);
 	struct drm_plane *plane;
 	struct omap_plane *omap_plane;
-	enum omap_plane_id id;
 	int ret;
 	u32 nformats;
 	const u32 *formats;
 
-	if (WARN_ON(idx >= ARRAY_SIZE(plane_idx_to_id)))
+	if (WARN_ON(idx >= num_planes))
 		return ERR_PTR(-EINVAL);
 
-	id = plane_idx_to_id[idx];
-
-	DBG("%s: type=%d", plane_id_to_name[id], type);
-
 	omap_plane = kzalloc(sizeof(*omap_plane), GFP_KERNEL);
 	if (!omap_plane)
 		return ERR_PTR(-ENOMEM);
 
-	formats = priv->dispc_ops->ovl_get_color_modes(priv->dispc, id);
+	omap_plane->id = idx;
+	omap_plane->name = plane_id_to_name[idx];
+	omap_plane->overlay = priv->overlays[idx];
+
+	DBG("%s: type=%d", omap_plane->name, type);
+	DBG("	omap_plane->id: %d", omap_plane->id);
+	DBG("	crtc_mask: 0x%04x", possible_crtcs);
+
+	formats = priv->dispc_ops->ovl_get_color_modes(priv->dispc,
+						       omap_plane->overlay->overlay_id);
 	for (nformats = 0; formats[nformats]; ++nformats)
 		;
-	omap_plane->id = id;
-	omap_plane->name = plane_id_to_name[id];
 
 	plane = &omap_plane->base;
 
@@ -315,7 +316,7 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 
 error:
 	dev_err(dev->dev, "%s(): could not create plane: %s\n",
-		__func__, plane_id_to_name[id]);
+		__func__, omap_plane->name);
 
 	kfree(omap_plane);
 	return NULL;
-- 
2.9.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbeERI0q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:26:46 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:31373 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753847AbeERIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:38 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mali DP Maintainers <malidp@foss.arm.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v7 5/5] drm: mali-dp: Add writeback connector
Date: Fri, 18 May 2018 09:24:23 +0100
Message-Id: <20180518082423.15500-6-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518082423.15500-1-Liviu.Dudau@arm.com>
References: <20180518082423.15500-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Starkey <brian.starkey@arm.com>

Mali-DP has a memory writeback engine which can be used to write the
composition result to a memory buffer. Expose this functionality as a
DRM writeback connector on supported hardware.

Changes since v1:
 Daniel Vetter:
 - Don't require a modeset when writeback routing changes
 - Make writeback connector always disconnected

Changes since v2:
 - Rebase onto new drm_writeback_connector
 - Add reset callback, allocating subclassed state
 Daniel Vetter:
 - Squash out-fence support into this commit
 Gustavo Padovan:
 - Don't signal fence directly from driver (and drop malidp_mw_job)

Changes since v3:
 - Modifications to fit with Mali-DP commit tail changes

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
[rebased and fixed conflicts]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/Makefile      |   1 +
 drivers/gpu/drm/arm/malidp_crtc.c |   9 ++
 drivers/gpu/drm/arm/malidp_drv.c  |  19 ++-
 drivers/gpu/drm/arm/malidp_drv.h  |   3 +
 drivers/gpu/drm/arm/malidp_hw.c   |   2 +
 drivers/gpu/drm/arm/malidp_mw.c   | 253 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/arm/malidp_mw.h   |  18 +++
 drivers/gpu/drm/drm_atomic.c      |   4 +
 8 files changed, 304 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.c
 create mode 100644 drivers/gpu/drm/arm/malidp_mw.h

diff --git a/drivers/gpu/drm/arm/Makefile b/drivers/gpu/drm/arm/Makefile
index bb8b158ff90d0..3bf31d1a4722c 100644
--- a/drivers/gpu/drm/arm/Makefile
+++ b/drivers/gpu/drm/arm/Makefile
@@ -1,4 +1,5 @@
 hdlcd-y := hdlcd_drv.o hdlcd_crtc.o
 obj-$(CONFIG_DRM_HDLCD)	+= hdlcd.o
 mali-dp-y := malidp_drv.o malidp_hw.o malidp_planes.o malidp_crtc.o
+mali-dp-y += malidp_mw.o
 obj-$(CONFIG_DRM_MALI_DISPLAY)	+= mali-dp.o
diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index fcc62bc60f6a7..e04e48b5269bd 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -411,6 +411,15 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	/* If only the writeback routing has changed, we don't need a modeset */
+	if (state->connectors_changed) {
+		u32 old_mask = crtc->state->connector_mask;
+		u32 new_mask = state->connector_mask;
+		if ((old_mask ^ new_mask) ==
+		    (1 << drm_connector_index(&malidp->mw_connector.base)))
+			state->connectors_changed = false;
+	}
+
 	ret = malidp_crtc_atomic_check_gamma(crtc, state);
 	ret = ret ? ret : malidp_crtc_atomic_check_ctm(crtc, state);
 	ret = ret ? ret : malidp_crtc_atomic_check_scaling(crtc, state);
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 8d20faa198cf1..4b0c4b4e76224 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -31,6 +31,7 @@
 #include <drm/drm_of.h>
 
 #include "malidp_drv.h"
+#include "malidp_mw.h"
 #include "malidp_regs.h"
 #include "malidp_hw.h"
 
@@ -230,7 +231,9 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 		malidp_atomic_commit_se_config(crtc, old_crtc_state);
 	}
 
-	drm_atomic_helper_commit_planes(drm, state, 0);
+	drm_atomic_helper_commit_planes(drm, state, DRM_PLANE_COMMIT_ACTIVE_ONLY);
+
+	malidp_mw_atomic_commit(drm, state);
 
 	drm_atomic_helper_commit_modeset_enables(drm, state);
 
@@ -268,12 +271,18 @@ static int malidp_init(struct drm_device *drm)
 	drm->mode_config.helper_private = &malidp_mode_config_helpers;
 
 	ret = malidp_crtc_init(drm);
-	if (ret) {
-		drm_mode_config_cleanup(drm);
-		return ret;
-	}
+	if (ret)
+		goto crtc_fail;
+
+	ret = malidp_mw_connector_init(drm);
+	if (ret)
+		goto crtc_fail;
 
 	return 0;
+
+crtc_fail:
+	drm_mode_config_cleanup(drm);
+	return ret;
 }
 
 static void malidp_fini(struct drm_device *drm)
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index c70989b933874..7f4eccd32d2f1 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -13,6 +13,8 @@
 #ifndef __MALIDP_DRV_H__
 #define __MALIDP_DRV_H__
 
+#include <drm/drm_writeback.h>
+#include <drm/drm_encoder.h>
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <drm/drmP.h>
@@ -21,6 +23,7 @@
 struct malidp_drm {
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
+	struct drm_writeback_connector mw_connector;
 	wait_queue_head_t wq;
 	struct drm_pending_vblank_event *event;
 	atomic_t config_valid;
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index ea8b23aefe961..1eed20e10561f 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -21,6 +21,7 @@
 
 #include "malidp_drv.h"
 #include "malidp_hw.h"
+#include "malidp_mw.h"
 
 enum {
 	MW_NOT_ENABLED = 0,	/* SE writeback not enabled */
@@ -995,6 +996,7 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 		switch (hwdev->mw_state) {
 		case MW_STOP:
 		case MW_ONESHOT:
+			drm_writeback_signal_completion(&malidp->mw_connector, 0);
 			/* disable writeback after stop or oneshot */
 			hwdev->mw_state = MW_NOT_ENABLED;
 			break;
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
new file mode 100644
index 0000000000000..e18e62c814f65
--- /dev/null
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -0,0 +1,253 @@
+/*
+ * (C) COPYRIGHT 2016 ARM Limited. All rights reserved.
+ * Author: Brian Starkey <brian.starkey@arm.com>
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * ARM Mali DP Writeback connector implementation
+ */
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drmP.h>
+#include <drm/drm_writeback.h>
+
+#include "malidp_drv.h"
+#include "malidp_hw.h"
+#include "malidp_mw.h"
+
+#define to_mw_state(_state) (struct malidp_mw_connector_state *)(_state)
+
+struct malidp_mw_connector_state {
+	struct drm_connector_state base;
+	dma_addr_t addrs[2];
+	s32 pitches[2];
+	u8 format;
+	u8 n_planes;
+};
+
+static int malidp_mw_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+
+	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
+				    dev->mode_config.max_height);
+}
+
+static enum drm_mode_status
+malidp_mw_connector_mode_valid(struct drm_connector *connector,
+			       struct drm_display_mode *mode)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_mode_config *mode_config = &dev->mode_config;
+	int w = mode->hdisplay, h = mode->vdisplay;
+
+	if ((w < mode_config->min_width) || (w > mode_config->max_width))
+		return MODE_BAD_HVALUE;
+
+	if ((h < mode_config->min_height) || (h > mode_config->max_height))
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
+const struct drm_connector_helper_funcs malidp_mw_connector_helper_funcs = {
+	.get_modes = malidp_mw_connector_get_modes,
+	.mode_valid = malidp_mw_connector_mode_valid,
+};
+
+static void malidp_mw_connector_reset(struct drm_connector *connector)
+{
+	struct malidp_mw_connector_state *mw_state =
+		kzalloc(sizeof(*mw_state), GFP_KERNEL);
+
+	if (connector->state)
+		__drm_atomic_helper_connector_destroy_state(connector->state);
+
+	kfree(connector->state);
+	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+}
+
+static enum drm_connector_status
+malidp_mw_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_disconnected;
+}
+
+static void malidp_mw_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_cleanup(connector);
+}
+
+static struct drm_connector_state *
+malidp_mw_connector_duplicate_state(struct drm_connector *connector)
+{
+	struct malidp_mw_connector_state *mw_state;
+
+	if (WARN_ON(!connector->state))
+		return NULL;
+
+	mw_state = kzalloc(sizeof(*mw_state), GFP_KERNEL);
+	if (!mw_state)
+		return NULL;
+
+	/* No need to preserve any of our driver-local data */
+	__drm_atomic_helper_connector_duplicate_state(connector, &mw_state->base);
+
+	return &mw_state->base;
+}
+
+static const struct drm_connector_funcs malidp_mw_connector_funcs = {
+	.reset = malidp_mw_connector_reset,
+	.detect = malidp_mw_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = malidp_mw_connector_destroy,
+	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int
+malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_connector_state *conn_state)
+{
+	struct malidp_mw_connector_state *mw_state = to_mw_state(conn_state);
+	struct malidp_drm *malidp = encoder->dev->dev_private;
+	struct drm_framebuffer *fb;
+	int i, n_planes;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
+	fb = conn_state->writeback_job->fb;
+	if ((fb->width != crtc_state->mode.hdisplay) ||
+	    (fb->height != crtc_state->mode.vdisplay)) {
+		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
+				fb->width, fb->height);
+		return -EINVAL;
+	}
+
+	mw_state->format =
+		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
+					fb->format->format);
+	if (mw_state->format == MALIDP_INVALID_FORMAT_ID) {
+		struct drm_format_name_buf format_name;
+
+		DRM_DEBUG_KMS("Invalid pixel format %s\n",
+			      drm_get_format_name(fb->format->format,
+						  &format_name));
+		return -EINVAL;
+	}
+
+	n_planes = drm_format_num_planes(fb->format->format);
+	for (i = 0; i < n_planes; i++) {
+		struct drm_gem_cma_object *obj = drm_fb_cma_get_gem_obj(fb, i);
+		/* memory write buffers are never rotated */
+		u8 alignment = malidp_hw_get_pitch_align(malidp->dev, 0);
+		if (fb->pitches[i] & (alignment - 1)) {
+			DRM_DEBUG_KMS("Invalid pitch %u for plane %d\n",
+				      fb->pitches[i], i);
+			return -EINVAL;
+		}
+		mw_state->pitches[i] = fb->pitches[i];
+		mw_state->addrs[i] = obj->paddr + fb->offsets[i];
+	}
+	mw_state->n_planes = n_planes;
+
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs malidp_mw_encoder_helper_funcs = {
+	.atomic_check = malidp_mw_encoder_atomic_check,
+};
+
+static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
+{
+	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
+	u32 *formats;
+	int n, i;
+
+	formats = kcalloc(map->n_pixel_formats, sizeof(*formats),
+			  GFP_KERNEL);
+	if (!formats)
+		return NULL;
+
+	for (n = 0, i = 0;  i < map->n_pixel_formats; i++) {
+		if (map->pixel_formats[i].layer & SE_MEMWRITE)
+			formats[n++] = map->pixel_formats[i].format;
+	}
+
+	*n_formats = n;
+
+	return formats;
+}
+
+int malidp_mw_connector_init(struct drm_device *drm)
+{
+	struct malidp_drm *malidp = drm->dev_private;
+	u32 *formats;
+	int ret, n_formats;
+
+	if (!malidp->dev->hw->enable_memwrite)
+		return 0;
+
+	malidp->mw_connector.encoder.possible_crtcs = 1 << drm_crtc_index(&malidp->crtc);
+	drm_connector_helper_add(&malidp->mw_connector.base,
+				 &malidp_mw_connector_helper_funcs);
+
+	formats = get_writeback_formats(malidp, &n_formats);
+	if (!formats)
+		return -ENOMEM;
+
+	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
+					   &malidp_mw_connector_funcs,
+					   &malidp_mw_encoder_helper_funcs,
+					   formats, n_formats);
+	kfree(formats);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void malidp_mw_atomic_commit(struct drm_device *drm,
+			     struct drm_atomic_state *old_state)
+{
+	struct malidp_drm *malidp = drm->dev_private;
+	struct drm_writeback_connector *mw_conn = &malidp->mw_connector;
+	struct drm_connector_state *conn_state = mw_conn->base.state;
+	struct malidp_hw_device *hwdev = malidp->dev;
+	struct malidp_mw_connector_state *mw_state;
+
+	if (!conn_state)
+		return;
+
+	mw_state = to_mw_state(conn_state);
+
+	if (conn_state->writeback_job && conn_state->writeback_job->fb) {
+		struct drm_framebuffer *fb = conn_state->writeback_job->fb;
+
+		DRM_DEV_DEBUG_DRIVER(drm->dev,
+				     "Enable memwrite %ux%u:%d %pad fmt: %u\n",
+				     fb->width, fb->height,
+				     mw_state->pitches[0],
+				     &mw_state->addrs[0],
+				     mw_state->format);
+
+		drm_writeback_queue_job(mw_conn, conn_state->writeback_job);
+		conn_state->writeback_job = NULL;
+
+		hwdev->hw->enable_memwrite(hwdev, mw_state->addrs,
+					   mw_state->pitches, mw_state->n_planes,
+					   fb->width, fb->height, mw_state->format);
+	} else {
+		DRM_DEV_DEBUG_DRIVER(drm->dev, "Disable memwrite\n");
+		hwdev->hw->disable_memwrite(hwdev);
+	}
+}
diff --git a/drivers/gpu/drm/arm/malidp_mw.h b/drivers/gpu/drm/arm/malidp_mw.h
new file mode 100644
index 0000000000000..93477eac5ed27
--- /dev/null
+++ b/drivers/gpu/drm/arm/malidp_mw.h
@@ -0,0 +1,18 @@
+/*
+ * (C) COPYRIGHT 2016 ARM Limited. All rights reserved.
+ * Author: Brian Starkey <brian.starkey@arm.com>
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ */
+
+#ifndef __MALIDP_MW_H__
+#define __MALIDP_MW_H__
+
+int malidp_mw_connector_init(struct drm_device *drm);
+void malidp_mw_atomic_commit(struct drm_device *drm,
+			     struct drm_atomic_state *old_state);
+#endif
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index cc2f86c68b293..c61fe85e80d16 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1378,6 +1378,10 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 	drm_printf(p, "connector[%u]: %s\n", connector->base.id, connector->name);
 	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		if (state->writeback_job && state->writeback_job->fb)
+			drm_printf(p, "\tfb=%d\n", state->writeback_job->fb->base.id);
+
 	if (connector->funcs->atomic_print_state)
 		connector->funcs->atomic_print_state(p, state);
 }
-- 
2.17.0

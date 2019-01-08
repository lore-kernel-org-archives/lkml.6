Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3B206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfAHOvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:51:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41376 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfAHOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:51:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 269DE20A0D; Tue,  8 Jan 2019 15:51:16 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB4472078C;
        Tue,  8 Jan 2019 15:51:15 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 3/4] drm/vc4: Add a load tracker to prevent HVS underflow errors
Date:   Tue,  8 Jan 2019 15:50:55 +0100
Message-Id: <20190108145056.2276-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The HVS block is supposed to fill the pixelvalve FIFOs fast enough to
meet the requested framerate. The problem is, the HVS and memory bus
bandwidths are limited, and if we don't take these limitations into
account we might end up with HVS underflow errors.

This patch is trying to model the per-plane HVS and memory bus bandwidth
consumption and take a decision at atomic_check() time whether the
estimated load will fit in the HVS and membus budget.

Note that we take an extra margin on the memory bus consumption to let
the system run smoothly when other blocks are doing heavy use of the
memory bus. Same goes for the HVS limit, except the margin is smaller in
this case, since the HVS is not used by external components.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v3:
- Use an u32 instead of an unsigned long to store/calculate the load
- Fix a typo in a comment
- Fix HVS load calculation (use crtc_h/w instead of src_h/w)

Changes in v2:
- Remove an unused var in vc4_load_tracker_atomic_check()
---
 drivers/gpu/drm/vc4/vc4_drv.c   |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h   |  11 ++++
 drivers/gpu/drm/vc4/vc4_kms.c   | 103 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_plane.c |  57 ++++++++++++++++++
 4 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index f6f5cd80c04d..7195a0bcceb3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -313,6 +313,7 @@ static void vc4_drm_unbind(struct device *dev)
 
 	drm_mode_config_cleanup(drm);
 
+	drm_atomic_private_obj_fini(&vc4->load_tracker);
 	drm_atomic_private_obj_fini(&vc4->ctm_manager);
 
 	drm_dev_put(drm);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 619fb8bec428..30cde58be737 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -207,6 +207,7 @@ struct vc4_dev {
 
 	struct drm_modeset_lock ctm_state_lock;
 	struct drm_private_obj ctm_manager;
+	struct drm_private_obj load_tracker;
 };
 
 static inline struct vc4_dev *
@@ -382,6 +383,16 @@ struct vc4_plane_state {
 	 * when async update is not possible.
 	 */
 	bool dlist_initialized;
+
+	/* Load of this plane on the HVS block. The load is expressed in HVS
+	 * cycles/sec.
+	 */
+	u64 hvs_load;
+
+	/* Memory bandwidth needed for this plane. This is expressed in
+	 * bytes/sec.
+	 */
+	u64 membus_load;
 };
 
 static inline struct vc4_plane_state *
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index a28e801aeae2..695ec793d429 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -34,6 +34,18 @@ static struct vc4_ctm_state *to_vc4_ctm_state(struct drm_private_state *priv)
 	return container_of(priv, struct vc4_ctm_state, base);
 }
 
+struct vc4_load_tracker_state {
+	struct drm_private_state base;
+	u64 hvs_load;
+	u64 membus_load;
+};
+
+static struct vc4_load_tracker_state *
+to_vc4_load_tracker_state(struct drm_private_state *priv)
+{
+	return container_of(priv, struct vc4_load_tracker_state, base);
+}
+
 static struct vc4_ctm_state *vc4_get_ctm_state(struct drm_atomic_state *state,
 					       struct drm_private_obj *manager)
 {
@@ -391,6 +403,81 @@ vc4_ctm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 	return 0;
 }
 
+static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
+{
+	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
+	struct vc4_load_tracker_state *load_state;
+	struct drm_private_state *priv_state;
+	struct drm_plane *plane;
+	int i;
+
+	priv_state = drm_atomic_get_private_obj_state(state,
+						      &vc4->load_tracker);
+	if (IS_ERR(priv_state))
+		return PTR_ERR(priv_state);
+
+	load_state = to_vc4_load_tracker_state(priv_state);
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state,
+				       new_plane_state, i) {
+		struct vc4_plane_state *vc4_plane_state;
+
+		if (old_plane_state->fb && old_plane_state->crtc) {
+			vc4_plane_state = to_vc4_plane_state(old_plane_state);
+			load_state->membus_load -= vc4_plane_state->membus_load;
+			load_state->hvs_load -= vc4_plane_state->hvs_load;
+		}
+
+		if (new_plane_state->fb && new_plane_state->crtc) {
+			vc4_plane_state = to_vc4_plane_state(new_plane_state);
+			load_state->membus_load += vc4_plane_state->membus_load;
+			load_state->hvs_load += vc4_plane_state->hvs_load;
+		}
+	}
+
+	/* The absolute limit is 2Gbyte/sec, but let's take a margin to let
+	 * the system work when other blocks are accessing the memory.
+	 */
+	if (load_state->membus_load > SZ_1G + SZ_512M)
+		return -ENOSPC;
+
+	/* HVS clock is supposed to run @ 250Mhz, let's take a margin and
+	 * consider the maximum number of cycles is 240M.
+	 */
+	if (load_state->hvs_load > 240000000ULL)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static struct drm_private_state *
+vc4_load_tracker_duplicate_state(struct drm_private_obj *obj)
+{
+	struct vc4_load_tracker_state *state;
+
+	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+
+	return &state->base;
+}
+
+static void vc4_load_tracker_destroy_state(struct drm_private_obj *obj,
+					   struct drm_private_state *state)
+{
+	struct vc4_load_tracker_state *load_state;
+
+	load_state = to_vc4_load_tracker_state(state);
+	kfree(load_state);
+}
+
+static const struct drm_private_state_funcs vc4_load_tracker_state_funcs = {
+	.atomic_duplicate_state = vc4_load_tracker_duplicate_state,
+	.atomic_destroy_state = vc4_load_tracker_destroy_state,
+};
+
 static int
 vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 {
@@ -400,7 +487,11 @@ vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 	if (ret < 0)
 		return ret;
 
-	return drm_atomic_helper_check(dev, state);
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	return vc4_load_tracker_atomic_check(state);
 }
 
 static const struct drm_mode_config_funcs vc4_mode_funcs = {
@@ -413,6 +504,7 @@ int vc4_kms_load(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_ctm_state *ctm_state;
+	struct vc4_load_tracker_state *load_state;
 	int ret;
 
 	sema_init(&vc4->async_modeset, 1);
@@ -442,6 +534,15 @@ int vc4_kms_load(struct drm_device *dev)
 	drm_atomic_private_obj_init(dev, &vc4->ctm_manager, &ctm_state->base,
 				    &vc4_ctm_state_funcs);
 
+	load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
+	if (!load_state) {
+		drm_atomic_private_obj_fini(&vc4->ctm_manager);
+		return -ENOMEM;
+	}
+
+	drm_atomic_private_obj_init(dev, &vc4->load_tracker, &load_state->base,
+				    &vc4_load_tracker_state_funcs);
+
 	drm_mode_config_reset(dev);
 
 	drm_kms_helper_poll_init(dev);
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 2901ed0c5223..6c643953a6e2 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -488,6 +488,61 @@ static void vc4_write_scaling_parameters(struct drm_plane_state *state,
 	}
 }
 
+static void vc4_plane_calc_load(struct drm_plane_state *state)
+{
+	unsigned int hvs_load_shift, vrefresh, i;
+	struct drm_framebuffer *fb = state->fb;
+	struct vc4_plane_state *vc4_state;
+	struct drm_crtc_state *crtc_state;
+	unsigned int vscale_factor;
+
+	vc4_state = to_vc4_plane_state(state);
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+							state->crtc);
+	vrefresh = drm_mode_vrefresh(&crtc_state->adjusted_mode);
+
+	/* The HVS is able to process 2 pixels/cycle when scaling the source,
+	 * 4 pixels/cycle otherwise.
+	 * Alpha blending step seems to be pipelined and it's always operating
+	 * at 4 pixels/cycle, so the limiting aspect here seems to be the
+	 * scaler block.
+	 * HVS load is expressed in clk-cycles/sec (AKA Hz).
+	 */
+	if (vc4_state->x_scaling[0] != VC4_SCALING_NONE ||
+	    vc4_state->x_scaling[1] != VC4_SCALING_NONE ||
+	    vc4_state->y_scaling[0] != VC4_SCALING_NONE ||
+	    vc4_state->y_scaling[1] != VC4_SCALING_NONE)
+		hvs_load_shift = 1;
+	else
+		hvs_load_shift = 2;
+
+	vc4_state->membus_load = 0;
+	vc4_state->hvs_load = 0;
+	for (i = 0; i < fb->format->num_planes; i++) {
+		/* Even if the bandwidth/plane required for a single frame is
+		 *
+		 * vc4_state->src_w[i] * vc4_state->src_h[i] * cpp * vrefresh
+		 *
+		 * when downscaling, we have to read more pixels per line in
+		 * the time frame reserved for a single line, so the bandwidth
+		 * demand can be punctually higher. To account for that, we
+		 * calculate the down-scaling factor and multiply the plane
+		 * load by this number. We're likely over-estimating the read
+		 * demand, but that's better than under-estimating it.
+		 */
+		vscale_factor = DIV_ROUND_UP(vc4_state->src_h[i],
+					     vc4_state->crtc_h);
+		vc4_state->membus_load += vc4_state->src_w[i] *
+					  vc4_state->src_h[i] * vscale_factor *
+					  fb->format->cpp[i];
+		vc4_state->hvs_load += vc4_state->crtc_h * vc4_state->crtc_w;
+	}
+
+	vc4_state->hvs_load *= vrefresh;
+	vc4_state->hvs_load >>= hvs_load_shift;
+	vc4_state->membus_load *= vrefresh;
+}
+
 static int vc4_plane_allocate_lbm(struct drm_plane_state *state)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(state->plane->dev);
@@ -888,6 +943,8 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	 */
 	vc4_state->dlist_initialized = 1;
 
+	vc4_plane_calc_load(state);
+
 	return 0;
 }
 
-- 
2.20.1


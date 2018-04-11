Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757256AbeDKTb0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:31:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757226AbeDKTag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:30:36 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/10] drm/i915: Only use one link bw config for MST topologies
Date: Wed, 11 Apr 2018 15:29:34 -0400
Message-Id: <20180411192951.21997-8-lyude@redhat.com>
In-Reply-To: <20180411192951.21997-1-lyude@redhat.com>
References: <20180411192951.21997-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DP MST link needs retraining, sometimes the hub will detect that
the current link bw config is impossible and will update it's RX caps in
the DPCD to reflect the new maximum link rate. Currently, we make the
assumption that the RX caps in the dpcd will never change like this.
This means if the sink changes it's RX caps after we've already set up
an MST link and we attempt to add or remove another sink from the
topology, we could put ourselves into an invalid state where we've tried
to configure different sinks on the same MST topology with different
link rates. We could also run into this situation if a sink reports a
higher link rate after suspend, usually from us having trained it with a
fallback bw configuration before suspending.

So: keep the link rate consistent by subclassing
drm_dp_mst_topology_state, and tracking it there. For the time being, we
only allow the link rate to change when the entire topology has been
disconnected.

V4:
 - Track link rate/lane count in the atomic topology state instead of in
   intel_dp.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 77 +++++++++++++++++++++++++++++--------
 drivers/gpu/drm/i915/intel_drv.h    |  7 ++++
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index cf844cfd2bb0..40af938e2fe7 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -41,8 +41,9 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	struct intel_connector *connector =
 		to_intel_connector(conn_state->connector);
 	struct drm_atomic_state *state = pipe_config->base.state;
+	struct intel_dp_mst_topology_state *mst_state;
 	int bpp;
-	int lane_count, slots;
+	int slots;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
 	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
@@ -55,18 +56,22 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 		DRM_DEBUG_KMS("Setting pipe bpp to %d\n",
 			      bpp);
 	}
+
+	mst_state = to_intel_dp_mst_topology_state(
+	    drm_atomic_dp_mst_get_topology_state(state, &intel_dp->mst_mgr));
 	/*
 	 * for MST we always configure max link bw - the spec doesn't
 	 * seem to suggest we should do otherwise.
 	 */
-	lane_count = intel_dp_max_lane_count(intel_dp);
-
-	pipe_config->lane_count = lane_count;
+	if (!mst_state->link_rate || !mst_state->lane_count) {
+		mst_state->link_rate = intel_dp_max_link_rate(intel_dp);
+		mst_state->lane_count = intel_dp_max_lane_count(intel_dp);
+	}
 
+	pipe_config->lane_count = mst_state->lane_count;
+	pipe_config->port_clock = mst_state->link_rate;
 	pipe_config->pipe_bpp = bpp;
 
-	pipe_config->port_clock = intel_dp_max_link_rate(intel_dp);
-
 	if (drm_dp_mst_port_has_audio(&intel_dp->mst_mgr, connector->port))
 		pipe_config->has_audio = true;
 
@@ -80,7 +85,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 		return false;
 	}
 
-	intel_link_compute_m_n(bpp, lane_count,
+	intel_link_compute_m_n(bpp, mst_state->lane_count,
 			       adjusted_mode->crtc_clock,
 			       pipe_config->port_clock,
 			       &pipe_config->dp_m_n,
@@ -530,11 +535,55 @@ static void intel_dp_mst_hotplug(struct drm_dp_mst_topology_mgr *mgr)
 	drm_kms_helper_hotplug_event(dev);
 }
 
+static void intel_mst_reset_state(struct drm_dp_mst_topology_state *state)
+{
+	struct intel_dp_mst_topology_state *intel_mst_state =
+		to_intel_dp_mst_topology_state(state);
+
+	intel_mst_state->link_rate = 0;
+	intel_mst_state->lane_count = 0;
+}
+
 static const struct drm_dp_mst_topology_cbs mst_cbs = {
 	.add_connector = intel_dp_add_mst_connector,
 	.register_connector = intel_dp_register_mst_connector,
 	.destroy_connector = intel_dp_destroy_mst_connector,
 	.hotplug = intel_dp_mst_hotplug,
+	.reset_state = intel_mst_reset_state,
+};
+
+static struct drm_private_state *
+intel_dp_mst_duplicate_state(struct drm_private_obj *obj)
+{
+	struct intel_dp_mst_topology_state *state;
+
+	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_dp_mst_duplicate_topology_state(
+	    to_dp_mst_topology_mgr(obj), &state->base);
+
+	return &state->base.base;
+}
+
+static void
+intel_dp_mst_destroy_state(struct drm_private_obj *obj,
+			   struct drm_private_state *state)
+{
+	struct drm_dp_mst_topology_state *mst_state =
+		to_dp_mst_topology_state(state);
+	struct intel_dp_mst_topology_state *intel_mst_state =
+		to_intel_dp_mst_topology_state(mst_state);
+
+	__drm_atomic_dp_mst_destroy_topology_state(mst_state);
+
+	kfree(intel_mst_state);
+}
+
+static const struct drm_private_state_funcs mst_state_funcs = {
+	.atomic_duplicate_state = intel_dp_mst_duplicate_state,
+	.atomic_destroy_state = intel_dp_mst_destroy_state,
 };
 
 static struct intel_dp_mst_encoder *
@@ -587,21 +636,16 @@ intel_dp_create_fake_mst_encoders(struct intel_digital_port *intel_dig_port)
 	return true;
 }
 
-static const struct drm_private_state_funcs mst_state_funcs = {
-	.atomic_destroy_state = drm_atomic_dp_mst_destroy_topology_state,
-	.atomic_duplicate_state = drm_atomic_dp_mst_duplicate_topology_state,
-};
-
 int
 intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_base_id)
 {
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
-	struct drm_dp_mst_topology_state *mst_state;
+	struct intel_dp_mst_topology_state *intel_mst_state;
 	struct drm_device *dev = intel_dig_port->base.base.dev;
 	int ret;
 
-	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
-	if (!mst_state)
+	intel_mst_state = kzalloc(sizeof(*intel_mst_state), GFP_KERNEL);
+	if (!intel_mst_state)
 		return -ENOMEM;
 
 	intel_dp->can_mst = true;
@@ -610,7 +654,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_ba
 
 	/* create encoders */
 	intel_dp_create_fake_mst_encoders(intel_dig_port);
-	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, mst_state, dev,
+	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr,
+					   &intel_mst_state->base, dev,
 					   &intel_dp->aux, 16, 3, conn_base_id);
 	if (ret) {
 		intel_dp->can_mst = false;
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 742d53495974..34bbf70d4c54 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -985,6 +985,12 @@ struct cxsr_latency {
 	u16 cursor_hpll_disable;
 };
 
+struct intel_dp_mst_topology_state {
+	struct drm_dp_mst_topology_state base;
+	int link_rate;
+	int lane_count;
+};
+
 #define to_intel_atomic_state(x) container_of(x, struct intel_atomic_state, base)
 #define to_intel_crtc(x) container_of(x, struct intel_crtc, base)
 #define to_intel_crtc_state(x) container_of(x, struct intel_crtc_state, base)
@@ -993,6 +999,7 @@ struct cxsr_latency {
 #define to_intel_framebuffer(x) container_of(x, struct intel_framebuffer, base)
 #define to_intel_plane(x) container_of(x, struct intel_plane, base)
 #define to_intel_plane_state(x) container_of(x, struct intel_plane_state, base)
+#define to_intel_dp_mst_topology_state(x) container_of(x, struct intel_dp_mst_topology_state, base);
 #define intel_fb_obj(x) (x ? to_intel_framebuffer(x)->obj : NULL)
 
 struct intel_hdmi {
-- 
2.14.3

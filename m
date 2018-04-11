Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDKW4n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 18:56:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752662AbeDKWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 18:55:35 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/10] drm/i915: Make intel_dp_mst_atomic_check() idempotent
Date: Wed, 11 Apr 2018 18:54:45 -0400
Message-Id: <20180411225501.26751-9-lyude@redhat.com>
In-Reply-To: <20180411225501.26751-1-lyude@redhat.com>
References: <20180411225501.26751-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current way of handling changing VCPI allocations doesn't make a
whole ton of sense. Since drm_atomic_helper_check_modeset() can be
called multiple times which means that intel_dp_mst_atomic_check() can
also be called multiple times. However, since we make the silly mistake
of trying to free VCPI slots based off the /new/ atomic state instead of
the old atomic state, we'll end up potentially double freeing the vcpi
slots for the ports.

This also has another unintended consequence that came back up while
implementing MST fallback retraining: if a modeset is forced on a
connector that's already part of the state, but it's atomic_check() has
already been run once and doesn't get run again, we'll end up not
freeing the VCPI allocations on the connector at all.

The easiest way to solve this is to be clever and, with the exception of
connectors that are being disabled and thus will never have
compute_config() ran on them, move vcpi freeing out of the atomic check
and into compute_config().

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>

V7:
 - Fix CHECKPATCH errors
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 84 +++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 19de0b5a7a40..31b37722cd89 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -30,6 +30,38 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 
+static int
+intel_dp_mst_atomic_release_vcpi_slots(struct drm_atomic_state *state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct drm_crtc_state *new_crtc_state;
+	struct intel_crtc_state *intel_crtc_state =
+		to_intel_crtc_state(crtc_state);
+	struct drm_encoder *encoder;
+	struct drm_dp_mst_topology_mgr *mgr;
+	int slots, ret;
+
+	slots = intel_crtc_state->dp_m_n.tu;
+	if (slots <= 0)
+		return 0;
+
+	encoder = conn_state->best_encoder;
+	mgr = &enc_to_mst(encoder)->primary->dp.mst_mgr;
+
+	ret = drm_dp_atomic_release_vcpi_slots(state, mgr, slots);
+	if (ret) {
+		DRM_DEBUG_KMS("failed releasing %d vcpi slots:%d\n",
+			      slots, ret);
+	} else {
+		new_crtc_state = drm_atomic_get_crtc_state(state,
+							   crtc_state->crtc);
+		to_intel_crtc_state(new_crtc_state)->dp_m_n.tu = 0;
+	}
+
+	return ret;
+}
+
 static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 					struct intel_crtc_state *pipe_config,
 					struct drm_connector_state *conn_state)
@@ -44,10 +76,14 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	struct drm_dp_mst_topology_state *mst_state =
 		drm_atomic_dp_mst_get_topology_state(state, &intel_dp->mst_mgr);
 	struct intel_dp_mst_topology_state *intel_mst_state;
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, &connector->base);
+	struct drm_crtc *old_crtc;
 	int bpp;
 	int slots;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
+	int ret;
 	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
 					   DP_DPCD_QUIRK_LIMITED_M_N);
 
@@ -80,6 +116,21 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
 	pipe_config->pbn = mst_pbn;
 
+	/* Free any VCPI allocations on this connector from the previous
+	 * state
+	 */
+	old_crtc = old_conn_state->crtc;
+	if (old_crtc) {
+		struct drm_crtc_state *old_crtc_state =
+			drm_atomic_get_old_crtc_state(state, old_crtc);
+
+		ret = intel_dp_mst_atomic_release_vcpi_slots(state,
+							     old_crtc_state,
+							     old_conn_state);
+		if (ret)
+			return ret;
+	}
+
 	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
 					      connector->port, mst_pbn);
 	if (slots < 0) {
@@ -109,31 +160,22 @@ static int intel_dp_mst_atomic_check(struct drm_connector *connector,
 {
 	struct drm_atomic_state *state = new_conn_state->state;
 	struct drm_connector_state *old_conn_state;
-	struct drm_crtc *old_crtc;
-	struct drm_crtc_state *crtc_state;
-	int slots, ret = 0;
+	struct drm_crtc_state *new_crtc_state;
+	int ret = 0;
 
 	old_conn_state = drm_atomic_get_old_connector_state(state, connector);
-	old_crtc = old_conn_state->crtc;
-	if (!old_crtc)
-		return ret;
 
-	crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
-	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
-	if (drm_atomic_crtc_needs_modeset(crtc_state) && slots > 0) {
-		struct drm_dp_mst_topology_mgr *mgr;
-		struct drm_encoder *old_encoder;
-
-		old_encoder = old_conn_state->best_encoder;
-		mgr = &enc_to_mst(old_encoder)->primary->dp.mst_mgr;
+	/* Only free VCPI here if we're not going to be detaching the
+	 * connector's current CRTC, since no config will be computed
+	 */
+	if (new_conn_state->crtc || !old_conn_state->crtc)
+		return ret;
 
-		ret = drm_dp_atomic_release_vcpi_slots(state, mgr, slots);
-		if (ret)
-			DRM_DEBUG_KMS("failed releasing %d vcpi slots:%d\n", slots, ret);
-		else
-			to_intel_crtc_state(crtc_state)->dp_m_n.tu = 0;
-	}
-	return ret;
+	new_crtc_state = drm_atomic_get_new_crtc_state(state,
+						       old_conn_state->crtc);
+	return intel_dp_mst_atomic_release_vcpi_slots(state,
+						      new_crtc_state,
+						      old_conn_state);
 }
 
 static void intel_mst_disable_dp(struct intel_encoder *encoder,
-- 
2.14.3

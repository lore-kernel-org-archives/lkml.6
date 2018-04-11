Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934608AbeDKTaw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:30:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934007AbeDKTah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:30:37 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/10] drm/i915: Implement proper fallback training for MST
Date: Wed, 11 Apr 2018 15:29:37 -0400
Message-Id: <20180411192951.21997-11-lyude@redhat.com>
In-Reply-To: <20180411192951.21997-1-lyude@redhat.com>
References: <20180411192951.21997-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a while we actually haven't had any way of retraining MST links with
fallback link parameters like we do with SST. While uncommon, certain
setups such as my Caldigit TS3 + EVGA MST hub require this since
otherwise, they end up getting stuck in an infinite MST retraining loop.

MST retraining is somewhat different then SST retraining. While it's
possible during the normal link retraining sequence for a hub to indicate
bad link status, it's also possible for a hub to only indicate this
status through ESI messages and it's possible for this to happen after
the initial link training succeeds. This can lead to a pattern that
looks like this:

- Train MST link
- Training completes successfully
- MST hub sets Channel EQ failed bit in ESI
- Retraining starts
- Retraining completes successfully
- MST hub sets Channel EQ failed bit in ESI again
- Rinse and repeat

In these situations, we need to be able to actually trigger fallback
link training from the ESI handler as well, along with using the ESI
handler during retraining to figure out whether or not our retraining
actually succeeded.

This gets a bit more complicated since we have to ensure that we don't
block the ESI handler at all while doing retraining. If we do, due to
DisplayPort's general issues with being sensitive to IRQ latency most
MST hubs will just stop responding to us if their interrupts aren't
handled in a timely manner.

So: move retraining into it's own seperate handler. Running in a
seperate handler allows us to avoid stalling the ESI during link
retraining, and we can have the ESI signal that the channel EQ bit was
cleared through a simple completion struct. Additionally, we take care
to stick as much of this into the SST retraining path as possible since
sharing is caring.

V4:
 - Move all MST retraining work into hotplug_work
 - Grab the correct power wells when retraining.
 - Loop through MST encoders in intel_dp_get_crtc_mask(), quicker/easier
   than connectors

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_ddi.c              |  10 +-
 drivers/gpu/drm/i915/intel_dp.c               | 355 ++++++++++++++++++++------
 drivers/gpu/drm/i915/intel_dp_link_training.c |   6 +-
 drivers/gpu/drm/i915/intel_dp_mst.c           |  27 +-
 drivers/gpu/drm/i915/intel_drv.h              |   7 +
 5 files changed, 313 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index 92cb26b18a9b..effc61db41d2 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -3063,9 +3063,17 @@ static bool intel_ddi_hotplug(struct intel_encoder *encoder,
 		break;
 	}
 
+	if (ret == -EINVAL)
+		ret = intel_dp_handle_train_failure(
+		    enc_to_intel_dp(&encoder->base));
+
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-	WARN(ret, "Acquiring modeset locks failed with %i\n", ret);
+
+	if (ret == -EIO)
+		changed = true;
+	else
+		WARN(ret, "Acquiring modeset locks failed with %i\n", ret);
 
 	return changed;
 }
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index fbb467bc227d..a7fd28929402 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -45,6 +45,8 @@
 
 #define DP_DPRX_ESI_LEN 14
 
+#define DP_MST_RETRAIN_TIMEOUT (msecs_to_jiffies(100))
+
 /* Compliance test status bits  */
 #define INTEL_DP_RESOLUTION_SHIFT_MASK	0
 #define INTEL_DP_RESOLUTION_PREFERRED	(1 << INTEL_DP_RESOLUTION_SHIFT_MASK)
@@ -2760,6 +2762,7 @@ static void intel_disable_dp(struct intel_encoder *encoder,
 	struct intel_dp *intel_dp = enc_to_intel_dp(&encoder->base);
 
 	intel_dp->link_trained = false;
+	intel_dp->link_is_bad = false;
 
 	if (old_crtc_state->has_audio)
 		intel_audio_codec_disable(encoder,
@@ -4205,8 +4208,133 @@ static void intel_dp_handle_test_request(struct intel_dp *intel_dp)
 		DRM_DEBUG_KMS("Could not write test response to sink\n");
 }
 
+/* Get a mask of the CRTCs that are running on the given intel_dp struct. For
+ * MST, this returns a crtc mask containing all of the CRTCs driving
+ * downstream sinks, for SST it just returns a mask of the attached
+ * connector's CRTC.
+ */
+int
+intel_dp_get_crtc_mask(struct intel_dp *intel_dp)
+{
+	struct drm_device *dev = dp_to_dig_port(intel_dp)->base.base.dev;
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
+	int crtc_mask = 0;
+
+	WARN_ON(!drm_modeset_is_locked(&dev->mode_config.connection_mutex));
+
+	if (intel_dp->is_mst) {
+		struct intel_dp_mst_encoder *mst_enc;
+		struct intel_connector *intel_connector;
+		struct drm_connector_state *conn_state;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(intel_dp->mst_encoders); i++) {
+			mst_enc = intel_dp->mst_encoders[i];
+
+			intel_connector = mst_enc->connector;
+			if (!intel_connector)
+				continue;
+
+			conn_state = intel_connector->base.state;
+			if (conn_state->crtc)
+				crtc_mask |= drm_crtc_mask(conn_state->crtc);
+		}
+	} else if (intel_dp->attached_connector) {
+		connector = &intel_dp->attached_connector->base;
+		crtc = connector->state->crtc;
+
+		if (crtc)
+			crtc_mask |= drm_crtc_mask(crtc);
+	}
+
+	return crtc_mask;
+}
+
+static bool
+intel_dp_needs_link_retrain(struct intel_dp *intel_dp,
+			    const u8 esi[DP_DPRX_ESI_LEN])
+{
+	u8 buf[DP_LINK_STATUS_SIZE];
+	const u8 *link_status = NULL;
+
+	if (intel_dp->link_is_bad)
+		return false;
+
+	if (intel_dp->is_mst) {
+		if (!intel_dp->active_mst_links)
+			return false;
+
+		if (esi) {
+			link_status = &esi[10];
+		} else {
+			/* We're not running from the ESI handler, so wait a
+			 * little bit to see if the ESI handler lets us know
+			 * that the link status is OK
+			 */
+			if (wait_for_completion_timeout(
+				&intel_dp->mst_retrain_completion,
+				DP_MST_RETRAIN_TIMEOUT))
+				return false;
+		}
+	} else {
+		if (intel_dp->link_trained)
+			return false;
+		if (!intel_dp_get_link_status(intel_dp, buf))
+			return false;
+
+		link_status = buf;
+	}
+
+	/*
+	 * Validate the cached values of intel_dp->link_rate and
+	 * intel_dp->lane_count before attempting to retrain.
+	 */
+	if (!intel_dp_link_params_valid(intel_dp, intel_dp->link_rate,
+					intel_dp->lane_count))
+		return false;
+
+	if (link_status) {
+		return !drm_dp_channel_eq_ok(link_status,
+					     intel_dp->lane_count);
+	} else {
+		return true;
+	}
+}
+
+static inline bool
+intel_dp_mst_needs_retrain(struct intel_dp *intel_dp,
+			   const u8 esi[DP_DPRX_ESI_LEN])
+{
+	struct drm_device *dev = dp_to_dig_port(intel_dp)->base.base.dev;
+	struct drm_i915_private *dev_priv = to_i915(dev);
+
+	if (intel_dp_needs_link_retrain(intel_dp, esi)) {
+		DRM_DEBUG_KMS("Channel EQ failing\n");
+
+		if (completion_done(&intel_dp->mst_retrain_completion)) {
+			reinit_completion(&intel_dp->mst_retrain_completion);
+			DRM_DEBUG_KMS("Starting retrain\n");
+
+			return true;
+		} else if (!work_busy(&dev_priv->hotplug.hotplug_work)) {
+			/* Retraining was probably interrupted (usually from
+			 * one of the CRTCs being in a modeset during a
+			 * previous retrain attempt)
+			 */
+			return true;
+		}
+
+	} else if (!completion_done(&intel_dp->mst_retrain_completion)) {
+		DRM_DEBUG_KMS("Channel EQ stable\n");
+		complete_all(&intel_dp->mst_retrain_completion);
+	}
+
+	return false;
+}
+
 static int
-intel_dp_check_mst_status(struct intel_dp *intel_dp)
+intel_dp_check_mst_status(struct intel_dp *intel_dp, bool *need_retrain)
 {
 	bool bret;
 
@@ -4215,16 +4343,13 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 		int ret = 0;
 		int retry;
 		bool handled;
+		*need_retrain = false;
 		bret = intel_dp_get_sink_irq_esi(intel_dp, esi);
 go_again:
 		if (bret == true) {
-
-			/* check link status - esi[10] = 0x200c */
-			if (intel_dp->active_mst_links &&
-			    !drm_dp_channel_eq_ok(&esi[10], intel_dp->lane_count)) {
-				DRM_DEBUG_KMS("channel EQ not ok, retraining\n");
-				intel_dp_start_link_train(intel_dp);
-				intel_dp_stop_link_train(intel_dp);
+			if (!*need_retrain) {
+			    *need_retrain = intel_dp_mst_needs_retrain(
+				intel_dp, esi);
 			}
 
 			DRM_DEBUG_KMS("got esi %3ph\n", esi);
@@ -4262,29 +4387,6 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
 	return -EINVAL;
 }
 
-static bool
-intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
-{
-	u8 link_status[DP_LINK_STATUS_SIZE];
-
-	if (!intel_dp->link_trained)
-		return false;
-
-	if (!intel_dp_get_link_status(intel_dp, link_status))
-		return false;
-
-	/*
-	 * Validate the cached values of intel_dp->link_rate and
-	 * intel_dp->lane_count before attempting to retrain.
-	 */
-	if (!intel_dp_link_params_valid(intel_dp, intel_dp->link_rate,
-					intel_dp->lane_count))
-		return false;
-
-	/* Retrain if Channel EQ or CR not ok */
-	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
-}
-
 /*
  * If display is now connected check links status,
  * there has been known issues of link loss triggering
@@ -4300,65 +4402,117 @@ intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
 int intel_dp_retrain_link(struct intel_encoder *encoder,
 			  struct drm_modeset_acquire_ctx *ctx)
 {
-	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	struct drm_device *dev = encoder->base.dev;
+	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_dp *intel_dp = enc_to_intel_dp(&encoder->base);
-	struct intel_connector *connector = intel_dp->attached_connector;
-	struct drm_connector_state *conn_state;
-	struct intel_crtc_state *crtc_state;
-	struct intel_crtc *crtc;
+	struct drm_crtc *crtc;
+	struct intel_crtc *intel_crtc;
+	int crtc_mask, retry_count = 0;
 	int ret;
 
-	/* FIXME handle the MST connectors as well */
-
-	if (!connector || connector->base.status != connector_status_connected)
-		return 0;
-
 	ret = drm_modeset_lock(&dev_priv->drm.mode_config.connection_mutex,
 			       ctx);
 	if (ret)
 		return ret;
 
-	conn_state = connector->base.state;
-
-	crtc = to_intel_crtc(conn_state->crtc);
-	if (!crtc)
-		return 0;
+	crtc_mask = intel_dp_get_crtc_mask(intel_dp);
+	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
+		struct drm_crtc_state *crtc_state;
+		struct intel_crtc_state *intel_crtc_state;
 
-	ret = drm_modeset_lock(&crtc->base.mutex, ctx);
-	if (ret)
-		return ret;
+		crtc = &intel_crtc->base;
+		ret = drm_modeset_lock(&crtc->mutex, ctx);
+		if (ret)
+			return ret;
 
-	crtc_state = to_intel_crtc_state(crtc->base.state);
+		crtc_state = crtc->state;
+		intel_crtc_state = to_intel_crtc_state(crtc_state);
+		WARN_ON(!intel_crtc_has_dp_encoder(intel_crtc_state));
 
-	WARN_ON(!intel_crtc_has_dp_encoder(crtc_state));
+		if (crtc_state->commit &&
+		    !try_wait_for_completion(&crtc_state->commit->hw_done)) {
+			DRM_DEBUG_KMS("Not all CRTCs ready yet\n");
+			return 0;
+		}
 
-	if (!crtc_state->base.active)
+		if (!crtc_state->active)
+			crtc_mask &= ~drm_crtc_mask(crtc);
+	}
+	if (!crtc_mask)
 		return 0;
 
-	if (conn_state->commit &&
-	    !try_wait_for_completion(&conn_state->commit->hw_done))
+	if (!intel_dp_needs_link_retrain(intel_dp, NULL))
 		return 0;
 
-	if (!intel_dp_needs_link_retrain(intel_dp))
-		return 0;
+	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
+		intel_set_cpu_fifo_underrun_reporting(
+		    dev_priv, intel_crtc->pipe, false);
 
-	/* Suppress underruns caused by re-training */
-	intel_set_cpu_fifo_underrun_reporting(dev_priv, crtc->pipe, false);
-	if (crtc->config->has_pch_encoder)
-		intel_set_pch_fifo_underrun_reporting(dev_priv,
-						      intel_crtc_pch_transcoder(crtc), false);
+		if (intel_crtc->config->has_pch_encoder) {
+			intel_set_pch_fifo_underrun_reporting(
+			    dev_priv, intel_crtc_pch_transcoder(intel_crtc),
+			    false);
+		}
+	}
 
-	intel_dp_start_link_train(intel_dp);
-	intel_dp_stop_link_train(intel_dp);
+	do {
+		if (++retry_count > 5) {
+			DRM_DEBUG_KMS("Too many retries, can't retrain\n");
+			return -EINVAL;
+		}
+
+		intel_dp_start_link_train(intel_dp);
+		intel_dp_stop_link_train(intel_dp);
+	} while (intel_dp_needs_link_retrain(intel_dp, NULL));
+
+	/* Wait for things to become stable */
+	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask)
+		intel_wait_for_vblank(dev_priv, intel_crtc->pipe);
+
+	/* Now that we know everything is OK, finally re-enable underrun
+	 * reporting */
+	for_each_intel_crtc_mask(dev, intel_crtc, crtc_mask) {
+		intel_set_cpu_fifo_underrun_reporting(
+		    dev_priv, intel_crtc->pipe, true);
+
+		if (intel_crtc->config->has_pch_encoder) {
+			intel_set_pch_fifo_underrun_reporting(
+			    dev_priv, intel_crtc_pch_transcoder(intel_crtc),
+			    true);
+		}
+	}
 
-	/* Keep underrun reporting disabled until things are stable */
-	intel_wait_for_vblank(dev_priv, crtc->pipe);
+	return 0;
+}
+
+int intel_dp_handle_train_failure(struct intel_dp *intel_dp)
+{
+	int ret;
+
+	if (intel_dp->link_is_bad)
+		return 0;
+	intel_dp->link_is_bad = true;
+
+	/* Sometimes sinks will change their RX caps in response to a link
+	 * retraining failure, so only fallback the link rate if we need to
+	 */
+	ret = intel_dp_get_dpcd(intel_dp);
+	if (!ret) {
+		DRM_ERROR("IO error while reading dpcd from sink\n");
+		return -EIO;
+	}
 
-	intel_set_cpu_fifo_underrun_reporting(dev_priv, crtc->pipe, true);
-	if (crtc->config->has_pch_encoder)
-		intel_set_pch_fifo_underrun_reporting(dev_priv,
-						      intel_crtc_pch_transcoder(crtc), true);
+	if (intel_dp->link_rate == intel_dp_max_link_rate(intel_dp) &&
+	    intel_dp->lane_count == intel_dp_max_lane_count(intel_dp)) {
+		if (intel_dp_get_link_train_fallback_values(
+			intel_dp, intel_dp_max_link_rate(intel_dp),
+			intel_dp_max_lane_count(intel_dp))) {
+			DRM_ERROR("No possible fallback values for link retraining\n");
+			return -EINVAL;
+		}
+	}
 
+	schedule_work(&intel_dp->modeset_retry_work);
 	return 0;
 }
 
@@ -4396,9 +4550,17 @@ static bool intel_dp_hotplug(struct intel_encoder *encoder,
 		break;
 	}
 
+	if (ret == -EINVAL)
+		ret = intel_dp_handle_train_failure(
+		    enc_to_intel_dp(&encoder->base));
+
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-	WARN(ret, "Acquiring modeset locks failed with %i\n", ret);
+
+	if (ret == -EIO)
+		changed = true;
+	else
+		WARN(ret, "Acquiring modeset locks failed with %i\n", ret);
 
 	return changed;
 }
@@ -4459,7 +4621,7 @@ intel_dp_short_pulse(struct intel_dp *intel_dp)
 	}
 
 	/* defer to the hotplug work for link retraining if needed */
-	if (intel_dp_needs_link_retrain(intel_dp))
+	if (intel_dp_needs_link_retrain(intel_dp, NULL))
 		return false;
 
 	if (intel_dp->compliance.test_type == DP_TEST_LINK_TRAINING) {
@@ -5379,6 +5541,7 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
 	struct drm_i915_private *dev_priv = to_i915(intel_dp_to_dev(intel_dp));
 	enum irqreturn ret = IRQ_NONE;
+	bool need_retrain = false;
 
 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
 		/*
@@ -5405,7 +5568,8 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 	intel_display_power_get(dev_priv, intel_dp->aux_power_domain);
 
 	if (intel_dp->is_mst) {
-		if (intel_dp_check_mst_status(intel_dp) == -EINVAL) {
+		if (intel_dp_check_mst_status(intel_dp,
+					      &need_retrain) == -EINVAL) {
 			/*
 			 * If we were in MST mode, and device is not
 			 * there, get out of MST mode
@@ -5417,6 +5581,8 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
 							intel_dp->is_mst);
 			intel_dp->detect_done = false;
 			goto put_power;
+		} else if (need_retrain) {
+			goto put_power;
 		}
 	}
 
@@ -6251,21 +6417,33 @@ static void intel_dp_modeset_retry_work_fn(struct work_struct *work)
 {
 	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
 						 modeset_retry_work);
-	struct drm_connector *connector = &intel_dp->attached_connector->base;
+	struct intel_digital_port *intel_dig_port = dp_to_dig_port(intel_dp);
+	struct drm_device *dev = intel_dig_port->base.base.dev;
+	struct drm_connector *connector;
 
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
-		      connector->name);
+	mutex_lock(&dev->mode_config.mutex);
 
-	/* Grab the locks before changing connector property*/
-	mutex_lock(&connector->dev->mode_config.mutex);
-	/* Set connector link status to BAD and send a Uevent to notify
-	 * userspace to do a modeset.
+	/* Set the connector link status of all (possibly downstream) ports to
+	 * BAD and send a Uevent to notify userspace to do a modeset.
 	 */
-	drm_mode_connector_set_link_status_property(connector,
-						    DRM_MODE_LINK_STATUS_BAD);
-	mutex_unlock(&connector->dev->mode_config.mutex);
+	if (intel_dp->is_mst) {
+		drm_dp_mst_topology_mgr_lower_link_rate(
+		    &intel_dp->mst_mgr,
+		    intel_dp_max_link_rate(intel_dp),
+		    intel_dp_max_lane_count(intel_dp));
+	} else {
+		connector = &intel_dp->attached_connector->base;
+
+		DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
+			      connector->base.id, connector->name);
+		drm_mode_connector_set_link_status_property(
+		    connector, DRM_MODE_LINK_STATUS_BAD);
+	}
+
+	mutex_unlock(&dev->mode_config.mutex);
+
 	/* Send Hotplug uevent so userspace can reprobe */
-	drm_kms_helper_hotplug_event(connector->dev);
+	drm_kms_helper_hotplug_event(dev);
 }
 
 bool
@@ -6283,6 +6461,8 @@ intel_dp_init_connector(struct intel_digital_port *intel_dig_port,
 	/* Initialize the work for modeset in case of link train failure */
 	INIT_WORK(&intel_dp->modeset_retry_work,
 		  intel_dp_modeset_retry_work_fn);
+	init_completion(&intel_dp->mst_retrain_completion);
+	complete_all(&intel_dp->mst_retrain_completion);
 
 	if (WARN(intel_dig_port->max_lanes < 1,
 		 "Not enough lanes (%d) for DP on port %c\n",
@@ -6499,6 +6679,7 @@ void intel_dp_mst_resume(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	int i;
+	bool need_retrain = false;
 
 	for (i = 0; i < I915_MAX_PORTS; i++) {
 		struct intel_digital_port *intel_dig_port = dev_priv->hotplug.irq_port[i];
@@ -6508,7 +6689,11 @@ void intel_dp_mst_resume(struct drm_device *dev)
 			continue;
 
 		ret = drm_dp_mst_topology_mgr_resume(&intel_dig_port->dp.mst_mgr);
-		if (ret)
-			intel_dp_check_mst_status(&intel_dig_port->dp);
+		if (ret) {
+			intel_dp_check_mst_status(&intel_dig_port->dp,
+						  &need_retrain);
+			if (need_retrain)
+				drm_kms_helper_hotplug_event(dev);
+		}
 	}
 }
diff --git a/drivers/gpu/drm/i915/intel_dp_link_training.c b/drivers/gpu/drm/i915/intel_dp_link_training.c
index 2cfa58ce1f95..aa6cfccdab0f 100644
--- a/drivers/gpu/drm/i915/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/intel_dp_link_training.c
@@ -336,11 +336,7 @@ intel_dp_start_link_train(struct intel_dp *intel_dp)
 			      intel_connector->base.base.id,
 			      intel_connector->base.name,
 			      intel_dp->link_rate, intel_dp->lane_count);
-		if (!intel_dp_get_link_train_fallback_values(intel_dp,
-							     intel_dp->link_rate,
-							     intel_dp->lane_count))
-			/* Schedule a Hotplug Uevent to userspace to start modeset */
-			schedule_work(&intel_dp->modeset_retry_work);
+		intel_dp_handle_train_failure(intel_dp);
 	} else {
 		DRM_ERROR("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
 			  intel_connector->base.base.id,
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 74b9ebd7b996..5e1ac2ce2421 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -150,12 +150,35 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 }
 
 static int intel_dp_mst_atomic_check(struct drm_connector *connector,
-		struct drm_connector_state *new_conn_state)
+				     struct drm_connector_state *new_conn_state)
 {
 	struct drm_atomic_state *state = new_conn_state->state;
 	struct drm_connector_state *old_conn_state;
+	struct intel_dp *intel_dp = to_intel_connector(connector)->mst_port;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct intel_dp_mst_topology_state *intel_mst_state;
 	int ret = 0;
 
+	/* We can't retrain anything if the hub isn't there anymore */
+	if (intel_dp) {
+		ret = drm_dp_atomic_mst_check_retrain(
+		    new_conn_state, &intel_dp->mst_mgr);
+
+		/* This commit invokes a retrain, reset the link rate */
+		if (ret == 1) {
+			mst_state = drm_atomic_dp_mst_get_topology_state(
+			    state, &intel_dp->mst_mgr);
+			intel_mst_state = to_intel_dp_mst_topology_state(
+			    mst_state);
+
+			intel_mst_state->link_rate = 0;
+			intel_mst_state->lane_count = 0;
+			ret = 0;
+		} else if (ret < 0) {
+			return ret;
+		}
+	}
+
 	old_conn_state = drm_atomic_get_old_connector_state(state, connector);
 
 	/* Only free VCPI here if we're not going to be detaching the
@@ -222,7 +245,9 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
 
 	intel_mst->connector = NULL;
 	if (intel_dp->active_mst_links == 0) {
+		intel_dp->link_is_bad = false;
 		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
+
 		intel_dig_port->base.post_disable(&intel_dig_port->base,
 						  old_crtc_state, NULL);
 	}
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 34bbf70d4c54..cc3023b4face 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1128,6 +1128,11 @@ struct intel_dp {
 	/* mst connector list */
 	struct intel_dp_mst_encoder *mst_encoders[I915_MAX_PIPES];
 	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct completion mst_retrain_completion;
+	/* Set when retraining the link at the current parameters is
+	 * impossible
+	 */
+	bool link_is_bad;
 
 	uint32_t (*get_aux_clock_divider)(struct intel_dp *dp, int index);
 	/*
@@ -1649,6 +1654,7 @@ void intel_dp_start_link_train(struct intel_dp *intel_dp);
 void intel_dp_stop_link_train(struct intel_dp *intel_dp);
 int intel_dp_retrain_link(struct intel_encoder *encoder,
 			  struct drm_modeset_acquire_ctx *ctx);
+int intel_dp_handle_train_failure(struct intel_dp *intel_dp);
 void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode);
 void intel_dp_encoder_reset(struct drm_encoder *encoder);
 void intel_dp_encoder_suspend(struct intel_encoder *intel_encoder);
@@ -1701,6 +1707,7 @@ void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 bool intel_dp_source_supports_hbr2(struct intel_dp *intel_dp);
 bool
 intel_dp_get_link_status(struct intel_dp *intel_dp, uint8_t link_status[DP_LINK_STATUS_SIZE]);
+int intel_dp_get_crtc_mask(struct intel_dp *intel_dp);
 
 static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
 {
-- 
2.14.3

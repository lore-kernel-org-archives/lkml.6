Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDKXpG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:45:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752065AbeDKXnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:43:13 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/10] drm/i915: Move DP modeset retry work into intel_dp
Date: Wed, 11 Apr 2018 19:42:41 -0400
Message-Id: <20180411234302.2896-3-lyude@redhat.com>
In-Reply-To: <20180411234302.2896-1-lyude@redhat.com>
References: <20180411234302.2896-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While having the modeset_retry_work in intel_connector makes sense with
SST, this paradigm doesn't make a whole ton of sense when it comes to
MST since we have to deal with multiple connectors. In most cases, it's
more useful to just use the intel_dp struct since it indicates whether
or not we're dealing with an MST device, along with being able to easily
trace the intel_dp struct back to it's respective connector (if there is
any). So, move the modeset_retry_work function out of the
intel_connector struct and into intel_dp.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

V2:
 - Remove accidental duplicate modeset_retry_work in intel_connector
V3:
 - Also check against eDP in intel_hpd_poll_fini() - mdnavare
V4:
 - Don't bother looping over connectors for canceling modeset rety work,
   just encoders.
V7:
 - Fix CHECKPATCH errors
---
 drivers/gpu/drm/i915/intel_display.c          | 14 +++++++++++---
 drivers/gpu/drm/i915/intel_dp.c               | 10 ++++------
 drivers/gpu/drm/i915/intel_dp_link_training.c |  2 +-
 drivers/gpu/drm/i915/intel_drv.h              |  6 +++---
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index e04050ea3e28..18edb9628a54 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -15471,20 +15471,28 @@ void intel_connector_unregister(struct drm_connector *connector)
 
 static void intel_hpd_poll_fini(struct drm_device *dev)
 {
-	struct intel_connector *connector;
 	struct drm_connector_list_iter conn_iter;
+	struct intel_connector *connector;
+	struct intel_encoder *encoder;
+	struct intel_dp *intel_dp;
 
 	/* Kill all the work that may have been queued by hpd. */
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	for_each_intel_connector_iter(connector, &conn_iter) {
-		if (connector->modeset_retry_work.func)
-			cancel_work_sync(&connector->modeset_retry_work);
 		if (connector->hdcp_shim) {
 			cancel_delayed_work_sync(&connector->hdcp_check_work);
 			cancel_work_sync(&connector->hdcp_prop_work);
 		}
 	}
 	drm_connector_list_iter_end(&conn_iter);
+
+	for_each_intel_encoder(dev, encoder) {
+		if (encoder->type == INTEL_OUTPUT_DP ||
+		    encoder->type == INTEL_OUTPUT_EDP) {
+			intel_dp = enc_to_intel_dp(&encoder->base);
+			cancel_work_sync(&intel_dp->modeset_retry_work);
+		}
+	}
 }
 
 void intel_modeset_cleanup(struct drm_device *dev)
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 62f82c4298ac..fbb467bc227d 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -6249,12 +6249,10 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 
 static void intel_dp_modeset_retry_work_fn(struct work_struct *work)
 {
-	struct intel_connector *intel_connector;
-	struct drm_connector *connector;
+	struct intel_dp *intel_dp = container_of(work, typeof(*intel_dp),
+						 modeset_retry_work);
+	struct drm_connector *connector = &intel_dp->attached_connector->base;
 
-	intel_connector = container_of(work, typeof(*intel_connector),
-				       modeset_retry_work);
-	connector = &intel_connector->base;
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
 		      connector->name);
 
@@ -6283,7 +6281,7 @@ intel_dp_init_connector(struct intel_digital_port *intel_dig_port,
 	int type;
 
 	/* Initialize the work for modeset in case of link train failure */
-	INIT_WORK(&intel_connector->modeset_retry_work,
+	INIT_WORK(&intel_dp->modeset_retry_work,
 		  intel_dp_modeset_retry_work_fn);
 
 	if (WARN(intel_dig_port->max_lanes < 1,
diff --git a/drivers/gpu/drm/i915/intel_dp_link_training.c b/drivers/gpu/drm/i915/intel_dp_link_training.c
index f59b59bb0a21..2cfa58ce1f95 100644
--- a/drivers/gpu/drm/i915/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/intel_dp_link_training.c
@@ -340,7 +340,7 @@ intel_dp_start_link_train(struct intel_dp *intel_dp)
 							     intel_dp->link_rate,
 							     intel_dp->lane_count))
 			/* Schedule a Hotplug Uevent to userspace to start modeset */
-			schedule_work(&intel_connector->modeset_retry_work);
+			schedule_work(&intel_dp->modeset_retry_work);
 	} else {
 		DRM_ERROR("[CONNECTOR:%d:%s] Link Training failed at link rate = %d, lane count = %d",
 			  intel_connector->base.base.id,
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 5bd2263407b2..742d53495974 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -406,9 +406,6 @@ struct intel_connector {
 
 	struct intel_dp *mst_port;
 
-	/* Work struct to schedule a uevent on link train failure */
-	struct work_struct modeset_retry_work;
-
 	const struct intel_hdcp_shim *hdcp_shim;
 	struct mutex hdcp_mutex;
 	uint64_t hdcp_value; /* protected by hdcp_mutex */
@@ -1143,6 +1140,9 @@ struct intel_dp {
 
 	/* Displayport compliance testing */
 	struct intel_dp_compliance compliance;
+
+	/* Work struct to schedule a uevent on link train failure */
+	struct work_struct modeset_retry_work;
 };
 
 struct intel_lspcon {
-- 
2.14.3

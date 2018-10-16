Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86493C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358C9208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358C9208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJPKWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPKWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:22:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 786593082AF5;
        Tue, 16 Oct 2018 02:34:01 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-2.rdu2.redhat.com [10.10.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 893E07FC31;
        Tue, 16 Oct 2018 02:33:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/atomic_helper: Stop modesets on unregistered connectors harder
Date:   Mon, 15 Oct 2018 22:33:06 -0400
Message-Id: <20181016023306.27417-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Oct 2018 02:34:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, it appears our fix in:
commit b5d29843d8ef ("drm/atomic_helper: Allow DPMS On<->Off changes
for unregistered connectors")

Which attempted to work around the problems introduced by:
commit 4d80273976bf ("drm/atomic_helper: Disallow new modesets on
unregistered connectors")

Is still not the right solution, as modesets can still be triggered
outside of drm_atomic_set_crtc_for_connector().

So in order to fix this, while still being careful that we don't break
modesets that a driver may perform before being registered with
userspace, we replace connector->registered with a tristate member,
connector->registration_state. This allows us to keep track of whether
or not a connector is still initializing and hasn't been exposed to
userspace, is currently registered and exposed to userspace, or has been
legitimately removed from the system after having once been present.

Using this info, we can prevent userspace from performing new modesets
on unregistered connectors while still allowing the driver to perform
modesets on unregistered connectors before the driver has finished being
registered.

Fixes: b5d29843d8ef ("drm/atomic_helper: Allow DPMS On<->Off changes for unregistered connectors")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 60 +++++++++++++++++++++----
 drivers/gpu/drm/drm_atomic_uapi.c   | 21 ---------
 drivers/gpu/drm/drm_connector.c     | 10 ++---
 drivers/gpu/drm/i915/intel_dp_mst.c |  8 ++--
 include/drm/drm_connector.h         | 68 ++++++++++++++++++++++++++++-
 5 files changed, 127 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6f66777dca4b..6cadeaf28ae4 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -529,6 +529,35 @@ mode_valid(struct drm_atomic_state *state)
 	return 0;
 }
 
+static int
+unregistered_connector_check(struct drm_atomic_state *state,
+			     struct drm_connector *connector,
+			     struct drm_connector_state *old_conn_state,
+			     struct drm_connector_state *new_conn_state)
+{
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+
+	if (!drm_connector_unregistered(connector))
+		return 0;
+
+	crtc = new_conn_state->crtc;
+	if (!crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	if (!crtc_state || !drm_atomic_crtc_needs_modeset(crtc_state))
+		return 0;
+
+	if (crtc_state->mode_changed) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] can't change mode on unregistered connector\n",
+				 connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_check_modeset - validate state object for modeset changes
  * @dev: DRM device
@@ -684,18 +713,33 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			return ret;
 	}
 
-	/*
-	 * Iterate over all connectors again, to make sure atomic_check()
-	 * has been called on them when a modeset is forced.
-	 */
 	for_each_oldnew_connector_in_state(state, connector, old_connector_state, new_connector_state, i) {
 		const struct drm_connector_helper_funcs *funcs = connector->helper_private;
 
-		if (connectors_mask & BIT(i))
-			continue;
+		/* Make sure atomic_check() is called on any unchecked
+		 * connectors when a modeset has been forced
+		 */
+		if (connectors_mask & BIT(i) && funcs->atomic_check) {
+			ret = funcs->atomic_check(connector,
+						  new_connector_state);
+			if (ret)
+				return ret;
+		}
 
-		if (funcs->atomic_check)
-			ret = funcs->atomic_check(connector, new_connector_state);
+		/*
+		 * Prevent userspace from turning on new displays or setting
+		 * new modes using connectors which have been removed from
+		 * userspace. This is racy since an unplug could happen at any
+		 * time including after this check, but that's OK: we only
+		 * care about preventing userspace from trying to set invalid
+		 * state using destroyed connectors that it's been notified
+		 * about. No one can save us after the atomic check completes
+		 * but ourselves.
+		 */
+		ret = unregistered_connector_check(state,
+						   connector,
+						   old_connector_state,
+						   new_connector_state);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a22d6f269b07..d5b7f315098c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -299,27 +299,6 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 	struct drm_connector *connector = conn_state->connector;
 	struct drm_crtc_state *crtc_state;
 
-	/*
-	 * For compatibility with legacy users, we want to make sure that
-	 * we allow DPMS On<->Off modesets on unregistered connectors, since
-	 * legacy modesetting users will not be expecting these to fail. We do
-	 * not however, want to allow legacy users to assign a connector
-	 * that's been unregistered from sysfs to another CRTC, since doing
-	 * this with a now non-existent connector could potentially leave us
-	 * in an invalid state.
-	 *
-	 * Since the connector can be unregistered at any point during an
-	 * atomic check or commit, this is racy. But that's OK: all we care
-	 * about is ensuring that userspace can't use this connector for new
-	 * configurations after it's been notified that the connector is no
-	 * longer present.
-	 */
-	if (!READ_ONCE(connector->registered) && crtc) {
-		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
-				 connector->base.id, connector->name);
-		return -EINVAL;
-	}
-
 	if (conn_state->crtc == crtc)
 		return 0;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 5d01414ec9f7..79943102fe18 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -396,7 +396,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */
-	if (WARN_ON(connector->registered))
+	if (WARN_ON(!drm_connector_unregistered(connector)))
 		drm_connector_unregister(connector);
 
 	if (connector->tile_group) {
@@ -453,7 +453,7 @@ int drm_connector_register(struct drm_connector *connector)
 		return 0;
 
 	mutex_lock(&connector->mutex);
-	if (connector->registered)
+	if (connector->registration_state != DRM_CONNECTOR_INITIALIZING)
 		goto unlock;
 
 	ret = drm_sysfs_connector_add(connector);
@@ -473,7 +473,7 @@ int drm_connector_register(struct drm_connector *connector)
 
 	drm_mode_object_register(connector->dev, &connector->base);
 
-	connector->registered = true;
+	connector->registration_state = DRM_CONNECTOR_REGISTERED;
 	goto unlock;
 
 err_debugfs:
@@ -495,7 +495,7 @@ EXPORT_SYMBOL(drm_connector_register);
 void drm_connector_unregister(struct drm_connector *connector)
 {
 	mutex_lock(&connector->mutex);
-	if (!connector->registered) {
+	if (connector->registration_state != DRM_CONNECTOR_REGISTERED) {
 		mutex_unlock(&connector->mutex);
 		return;
 	}
@@ -506,7 +506,7 @@ void drm_connector_unregister(struct drm_connector *connector)
 	drm_sysfs_connector_remove(connector);
 	drm_debugfs_connector_remove(connector);
 
-	connector->registered = false;
+	connector->registration_state = DRM_CONNECTOR_UNREGISTERED;
 	mutex_unlock(&connector->mutex);
 }
 EXPORT_SYMBOL(drm_connector_unregister);
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index b268bdd71bd3..ad367309e10b 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -78,7 +78,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	pipe_config->pbn = mst_pbn;
 
 	/* Zombie connectors can't have VCPI slots */
-	if (READ_ONCE(connector->registered)) {
+	if (!drm_connector_unregistered(connector)) {
 		slots = drm_dp_atomic_find_vcpi_slots(state,
 						      &intel_dp->mst_mgr,
 						      port,
@@ -314,7 +314,7 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_unregistered(connector))
 		return intel_connector_update_modes(connector, NULL);
 
 	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
@@ -330,7 +330,7 @@ intel_dp_mst_detect(struct drm_connector *connector, bool force)
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_unregistered(connector))
 		return connector_status_disconnected;
 	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
 				      intel_connector->port);
@@ -361,7 +361,7 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
 	int bpp = 24; /* MST uses fixed bpp */
 	int max_rate, mode_rate, max_lanes, max_link_clock;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_unregistered(connector))
 		return MODE_ERROR;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5b3cf909fd5e..5f3e4a37bcd2 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -82,6 +82,51 @@ enum drm_connector_status {
 	connector_status_unknown = 3,
 };
 
+/**
+ * enum drm_connector_registration_status - userspace registration status for
+ * a &drm_connector
+ *
+ * This enum is used to track the status of initializing a connector and
+ * registering it with userspace, so that DRM can prevent bogus modesets on
+ * connectors that no longer exist.
+ */
+enum drm_connector_registration_state {
+	/**
+	 * @DRM_CONNECTOR_INITIALIZING: The connector has just been created,
+	 * but has yet to be exposed to userspace. There should be no
+	 * additional restrictions to how the state of this connector may be
+	 * modified. connector to a new CRTC.
+	 */
+	DRM_CONNECTOR_INITIALIZING = 0,
+
+	/**
+	 * @DRM_CONNECTOR_REGISTERED: The connector has been fully initialized
+	 * and registered with sysfs, as such it has been exposed to
+	 * userspace. There should be no additional restrictions to how the
+	 * state of this connector may be modified.
+	 */
+	DRM_CONNECTOR_REGISTERED = 1,
+
+	/**
+	 * @DRM_CONNECTOR_UNREGISTERED: The connector has either been exposed
+	 * to userspace and has since been unregistered and removed from
+	 * userspace, or the connector was destroyed before it had a chance to
+	 * be exposed to userspace. There are additional restrictions to how
+	 * the state of an unregistered connector may be modified:
+	 *
+	 * - The current display mode as exposed to userspace must remain the
+	 *   same as it was when the connector was unregistered.
+	 * - The connector's currently assigned CRTC may be unassigned from
+	 *   this connector. Unassigning the connector's CRTC must be
+	 *   permanent.
+	 * - New CRTCs must not be assigned to this connector.
+	 * - The DPMS state of the connector (for compatibility with legacy
+	 *   modesetting) may modified freely, so long as doing so does not
+	 *   cause the new atomic state to violate any of these rules.
+	 */
+	DRM_CONNECTOR_UNREGISTERED = 2,
+};
+
 enum subpixel_order {
 	SubPixelUnknown = 0,
 	SubPixelHorizontalRGB,
@@ -853,10 +898,12 @@ struct drm_connector {
 	bool ycbcr_420_allowed;
 
 	/**
-	 * @registered: Is this connector exposed (registered) with userspace?
+	 * @registration_state: Is this connector initializing, exposed
+	 * (registered) with userspace, or unregistered?
+	 *
 	 * Protected by @mutex.
 	 */
-	bool registered;
+	enum drm_connector_registration_state registration_state;
 
 	/**
 	 * @modes:
@@ -1167,6 +1214,23 @@ static inline void drm_connector_unreference(struct drm_connector *connector)
 	drm_connector_put(connector);
 }
 
+/**
+ * drm_connector_unregistered - has the connector been unregistered from
+ * userspace?
+ * @connector: DRM connector
+ *
+ * Checks whether or not @connector has been unregistered from userspace.
+ *
+ * Returns:
+ * True if the connector was unregistered, false if the connector is
+ * registered or has not yet been registered with userspace.
+ */
+static inline bool drm_connector_unregistered(struct drm_connector *connector)
+{
+	return READ_ONCE(connector->registration_state) ==
+		DRM_CONNECTOR_UNREGISTERED;
+}
+
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);
 const char *drm_get_dpms_name(int val);
-- 
2.17.2


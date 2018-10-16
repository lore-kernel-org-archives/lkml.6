Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C827C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010952145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010952145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJQEcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQEcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01205C04F2AE;
        Tue, 16 Oct 2018 20:40:08 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA71A1001947;
        Tue, 16 Oct 2018 20:40:01 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/atomic_helper: Stop modesets on unregistered connectors harder
Date:   Tue, 16 Oct 2018 16:39:46 -0400
Message-Id: <20181016203946.9601-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 16 Oct 2018 20:40:08 +0000 (UTC)
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

Changes since v1:
- Fix WARN_ON() in drm_connector_cleanup() that CI caught with this
  patchset in igt@drv_module_reload@basic-reload-inject and
  igt@drv_module_reload@basic-reload by checking if the connector is
  registered instead of unregistered, as calling drm_connector_cleanup()
  on a connector that hasn't been registered with userspace yet should
  stay valid.
- Remove unregistered_connector_check(), and just go back to what we
  were doing before in commit 4d80273976bf ("drm/atomic_helper: Disallow
  new modesets on unregistered connectors") except replacing
  READ_ONCE(connector->registered) with drm_connector_is_unregistered().
  This gets rid of the behavior of allowing DPMS On<->Off, but that should
  be fine as it's more consistent with the UAPI we had before - danvet
- s/drm_connector_unregistered/drm_connector_is_unregistered/ - danvet
- Update documentation, fix some typos.

Fixes: b5d29843d8ef ("drm/atomic_helper: Allow DPMS On<->Off changes for unregistered connectors")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 21 ++++++++-
 drivers/gpu/drm/drm_atomic_uapi.c   | 21 ---------
 drivers/gpu/drm/drm_connector.c     | 11 +++--
 drivers/gpu/drm/i915/intel_dp_mst.c |  8 ++--
 include/drm/drm_connector.h         | 71 ++++++++++++++++++++++++++++-
 5 files changed, 99 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 6f66777dca4b..ee6b2987a3c7 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -319,6 +319,26 @@ update_connector_routing(struct drm_atomic_state *state,
 		return 0;
 	}
 
+	crtc_state = drm_atomic_get_new_crtc_state(state,
+						   new_connector_state->crtc);
+	/*
+	 * For compatibility with legacy users, we want to make sure that
+	 * we allow DPMS On->Off modesets on unregistered connectors. Modesets
+	 * which would result in anything else must be considered invalid, to
+	 * avoid turning on new displays on dead connectors.
+	 *
+	 * Since the connector can be unregistered at any point during an
+	 * atomic check or commit, this is racy. But that's OK: all we care
+	 * about is ensuring that userspace can't do anything but shut off the
+	 * display on a connector that was destroyed after its been notified,
+	 * not before.
+	 */
+	if (drm_connector_is_unregistered(connector) && crtc_state->active) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] is not registered\n",
+				 connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
 	funcs = connector->helper_private;
 
 	if (funcs->atomic_best_encoder)
@@ -363,7 +383,6 @@ update_connector_routing(struct drm_atomic_state *state,
 
 	set_best_encoder(state, new_connector_state, new_encoder);
 
-	crtc_state = drm_atomic_get_new_crtc_state(state, new_connector_state->crtc);
 	crtc_state->connectors_changed = true;
 
 	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] using [ENCODER:%d:%s] on [CRTC:%d:%s]\n",
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
index 5d01414ec9f7..891f9458d29e 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -396,7 +396,8 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */
-	if (WARN_ON(connector->registered))
+	if (WARN_ON(connector->registration_state ==
+		    DRM_CONNECTOR_REGISTERED))
 		drm_connector_unregister(connector);
 
 	if (connector->tile_group) {
@@ -453,7 +454,7 @@ int drm_connector_register(struct drm_connector *connector)
 		return 0;
 
 	mutex_lock(&connector->mutex);
-	if (connector->registered)
+	if (connector->registration_state != DRM_CONNECTOR_INITIALIZING)
 		goto unlock;
 
 	ret = drm_sysfs_connector_add(connector);
@@ -473,7 +474,7 @@ int drm_connector_register(struct drm_connector *connector)
 
 	drm_mode_object_register(connector->dev, &connector->base);
 
-	connector->registered = true;
+	connector->registration_state = DRM_CONNECTOR_REGISTERED;
 	goto unlock;
 
 err_debugfs:
@@ -495,7 +496,7 @@ EXPORT_SYMBOL(drm_connector_register);
 void drm_connector_unregister(struct drm_connector *connector)
 {
 	mutex_lock(&connector->mutex);
-	if (!connector->registered) {
+	if (connector->registration_state != DRM_CONNECTOR_REGISTERED) {
 		mutex_unlock(&connector->mutex);
 		return;
 	}
@@ -506,7 +507,7 @@ void drm_connector_unregister(struct drm_connector *connector)
 	drm_sysfs_connector_remove(connector);
 	drm_debugfs_connector_remove(connector);
 
-	connector->registered = false;
+	connector->registration_state = DRM_CONNECTOR_UNREGISTERED;
 	mutex_unlock(&connector->mutex);
 }
 EXPORT_SYMBOL(drm_connector_unregister);
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index b268bdd71bd3..8b71d64ebd9d 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -78,7 +78,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	pipe_config->pbn = mst_pbn;
 
 	/* Zombie connectors can't have VCPI slots */
-	if (READ_ONCE(connector->registered)) {
+	if (!drm_connector_is_unregistered(connector)) {
 		slots = drm_dp_atomic_find_vcpi_slots(state,
 						      &intel_dp->mst_mgr,
 						      port,
@@ -314,7 +314,7 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_is_unregistered(connector))
 		return intel_connector_update_modes(connector, NULL);
 
 	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr, intel_connector->port);
@@ -330,7 +330,7 @@ intel_dp_mst_detect(struct drm_connector *connector, bool force)
 	struct intel_connector *intel_connector = to_intel_connector(connector);
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_is_unregistered(connector))
 		return connector_status_disconnected;
 	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
 				      intel_connector->port);
@@ -361,7 +361,7 @@ intel_dp_mst_mode_valid(struct drm_connector *connector,
 	int bpp = 24; /* MST uses fixed bpp */
 	int max_rate, mode_rate, max_lanes, max_link_clock;
 
-	if (!READ_ONCE(connector->registered))
+	if (drm_connector_is_unregistered(connector))
 		return MODE_ERROR;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5b3cf909fd5e..dd0552cb7472 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -82,6 +82,53 @@ enum drm_connector_status {
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
+	 * modified.
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
+	 * userspace, or the connector was unregistered before it had a chance
+	 * to be exposed to userspace (e.g. still in the
+	 * @DRM_CONNECTOR_INITIALIZING state). When a connector is
+	 * unregistered, there are additional restrictions to how its state
+	 * may be modified:
+	 *
+	 * - An unregistered connector may only have its DPMS changed from
+	 *   On->Off. Once DPMS is changed to Off, it may not be switched back
+	 *   to On.
+	 * - Modesets are not allowed on unregistered connectors, unless they
+	 *   would result in disabling its assigned CRTCs. This means
+	 *   disabling a CRTC on an unregistered connector is OK, but enabling
+	 *   one is not.
+	 * - Removing a CRTC from an unregistered connector is OK, but new
+	 *   CRTCs may never be assigned to an unregistered connector.
+	 */
+	DRM_CONNECTOR_UNREGISTERED = 2,
+};
+
 enum subpixel_order {
 	SubPixelUnknown = 0,
 	SubPixelHorizontalRGB,
@@ -853,10 +900,12 @@ struct drm_connector {
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
@@ -1167,6 +1216,24 @@ static inline void drm_connector_unreference(struct drm_connector *connector)
 	drm_connector_put(connector);
 }
 
+/**
+ * drm_connector_is_unregistered - has the connector been unregistered from
+ * userspace?
+ * @connector: DRM connector
+ *
+ * Checks whether or not @connector has been unregistered from userspace.
+ *
+ * Returns:
+ * True if the connector was unregistered, false if the connector is
+ * registered or has not yet been registered with userspace.
+ */
+static inline bool
+drm_connector_is_unregistered(struct drm_connector *connector)
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


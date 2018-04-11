Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDKXn4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:43:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752501AbeDKXnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:43:32 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] drm/dp_mst: Add MST fallback retraining helpers
Date: Wed, 11 Apr 2018 19:42:48 -0400
Message-Id: <20180411234302.2896-10-lyude@redhat.com>
In-Reply-To: <20180411234302.2896-1-lyude@redhat.com>
References: <20180411234302.2896-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike SST, MST can have far more then a single display hooked up on a
single port. What this also means however, is that if the DisplayPort
link to the top-level MST branch device becomes unstable then every
single branch device also has an unstable link. Additionally, MST has a
few more steps that must be taken in order to properly retrain the
entire topology under a lower link rate. Since the VCPI allocations for
each mstb is determined based off the link rate for the top of the
topology, we also have to recalculate all of the VCPI allocations for
the downstream ports as well to ensure that we still have enough link
bandwidth to drive each mstb.

Additionally, since we have multiple downstream connectors per port,
setting the link status of the parent mstb's port to bad isn't enough:
all of the downstream mstb ports have to have their link status set to
bad.

This basically follows the same paradigm that our DP link status logic
in DRM does, in that we simply tell userspace that all of the mstb ports
need retraining and additionally applying the new lower bandwidth
constraints to all of the atomic commits on the topology that follow.
Additionally; we add helpers that handle automatically checking whether
or not a new atomic commit would perform the modesets required to
retrain a link and if so, additionally handles updating the link status
of each connector on the MST topology.

V4:
 - clarify slightly confusing message in
   drm_dp_mst_topology_mgr_lower_link_rate()
 - Fix argument naming
 - Squash this with the other retrain helper, because now they're
   intertwined with one another
 - Track which connectors with CRTCs need modesets in order to retrain a
   topology in the topology's atomic state. This lets us greatly simplify
   the helpers, along with alleviating drivers of the responsibility of
   figuring out when to call the retrain helpers during atomic checks. It
   also ensures that we can keep zombie connectors that a retrain is
   dependent on alive until the topology either disappears, or they are
   disabled. We needed to do most of this anyway, since our original
   helpers didn't take into account that we need to invoke retraining
   when the link status prop changes, regardless of whether or not a
   modeset has been initiated yet.
 - Handle situation we completely forgot about: adding new connectors to
   an MST topology that needs fallback retraining (solution: new
   connectors on a topology inherit the link status of the rest of the
   topology)
 - Also make sure to handle connectors that are orphaned due to their
   MST topology disappearing. Solution: remove from topology state,
   reset link status to good
 - Write more docs on the retraining procedure.
V7:
 - Fix CHECKPATCH errors

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 440 +++++++++++++++++++++++++++++++++-
 include/drm/drm_dp_mst_helper.h       |  20 ++
 2 files changed, 455 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 981bd0f7d3ab..cc4b737a47b0 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1199,6 +1199,7 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 
 	if (created && !port->input) {
 		char proppath[255];
+		struct drm_dp_mst_topology_state *state;
 
 		build_mst_prop_path(mstb, port->port_num, proppath, sizeof(proppath));
 		port->connector = (*mstb->mgr->cbs->add_connector)(mstb->mgr, port, proppath);
@@ -1217,6 +1218,11 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 			port->cached_edid = drm_get_edid(port->connector, &port->aux.ddc);
 			drm_mode_connector_set_tile_property(port->connector);
 		}
+		state = to_dp_mst_topology_state(port->mgr->base.state);
+		if (!list_empty(&state->bad_ports)) {
+			port->connector->state->link_status =
+				DRM_LINK_STATUS_BAD;
+		}
 		(*mstb->mgr->cbs->register_connector)(port->connector);
 	}
 
@@ -2076,7 +2082,7 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
 {
 	switch (dp_link_bw) {
 	default:
-		DRM_DEBUG_KMS("invalid link bandwidth in DPCD: %x (link count: %d)\n",
+		DRM_DEBUG_KMS("invalid link bandwidth: %x (link count: %d)\n",
 			      dp_link_bw, dp_link_count);
 		return false;
 
@@ -2096,10 +2102,409 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
 	return true;
 }
 
+static int drm_dp_set_mstb_link_status(struct drm_dp_mst_topology_mgr *mgr,
+				       struct drm_dp_mst_branch *mstb,
+				       enum drm_link_status status)
+{
+	struct drm_dp_mst_topology_state *state =
+		to_dp_mst_topology_state(mgr->base.state);
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+	struct drm_connector *connector;
+	struct drm_dp_mst_retrain_dep *retrain_dep;
+	int ret;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mgr, port->mstb);
+		if (rmstb) {
+			ret = drm_dp_set_mstb_link_status(mgr, rmstb, status);
+			drm_dp_put_mst_branch_device(rmstb);
+
+			if (ret)
+				return ret;
+		}
+
+		connector = port->connector;
+		if (!connector)
+			continue;
+
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] link status good -> bad\n",
+				 connector->base.id, connector->name);
+		connector->state->link_status = status;
+
+		if (!connector->state->crtc)
+			continue;
+
+		retrain_dep = kmalloc(sizeof(*retrain_dep), GFP_KERNEL);
+		if (!retrain_dep) {
+			DRM_ERROR("Not enough memory to update atomic state\n");
+			return -ENOMEM;
+		}
+
+		retrain_dep->connector = connector;
+		drm_connector_get(connector);
+		list_add(&retrain_dep->entry, &state->bad_ports);
+	}
+
+	return 0;
+}
+
+static void drm_dp_mst_destroy_retrain_dep(struct drm_dp_mst_retrain_dep *dep)
+{
+	drm_connector_put(dep->connector);
+	list_del(&dep->entry);
+	kfree(dep);
+}
+
+/**
+ * DOC: handling link retraining on MST topologies
+ *
+ * DisplayPort MST hubs work by allowing multiple connections on a single
+ * physical DisplayPort link. Because of this, any changes in the link status
+ * affect all connectors on the shared link. This has quite a number of
+ * important implications.
+ *
+ * When an MST topology requires that it be retrained at a lower link rate,
+ * the new link rate must be applied to all active connectors at the same
+ * time, since they share the same link. This means that if a connector has
+ * it's link status set to &DRM_MODE_LINK_STATUS_BAD and it's on an MST
+ * topology, changing the property to &DRM_MODE_LINK_STATUS_GOOD will result
+ * in adding every other connector that resides on the same topology into the
+ * new atomic state. Additionally, any MST connectors that were added to the
+ * state with CRTCs attached to them will automatically have a modeset forced
+ * on them in the atomic state, and have their link status updated to
+ * &DRM_MODE_LINK_STATUS_GOOD. If userspace has not set a new mode on these
+ * connectors, the kernel will attempt to reuse the same modes that are
+ * currently active on said CRTCs. All modes set on said connectors within
+ * this state are then checked against the new lowered link configuration to
+ * ensure that there is still enough bandwidth to support them. If there is
+ * not enough bandwidth, the atomic check will fail.
+ *
+ * Detaching CRTCs from MST connectors that have their link status set to
+ * &DRM_MODE_LINK_STATUS_BAD has a different effect however. Because disabling
+ * a CRTC on an MST connector only requires that the driver free the bandwidth
+ * allocated to a connector and does not require the driver to allocate more
+ * bandwidth, states which disable CRTCs on an MST topology but do not enable
+ * new CRTCs or apply new modes to CRTCs on the topology will not implicitly
+ * pull in the state of other CRTCs attached to connectors on the topology.
+ * This allows userspace to disable CRTCs on a topology that requires
+ * retraining in any order it chooses, so long as it doesn't try to apply new
+ * modes to the topology.
+ *
+ * If an atomic state would put an MST topology into a state where it has no
+ * connectors present that are attached to CRTCs, the kernel will
+ * automatically add each connector on the topology to the state and update
+ * their respective link statuses to &DRM_MODE_LINK_STATUS_GOOD. This is
+ * because when there are no active VC channels allocated on a hub, there is
+ * nothing which prevents the driver from immediately changing the maximum
+ * link rate/lane count, as the updated link configuration can simply be
+ * applied the next time a CRTC is attached to a connector on the topology.
+ *
+ * When an MST topology requires link retraining at a lower link rate, any new
+ * connectors that appear on the topology will automatically inherit the link
+ * status value of other connectors on the topology. This is to ensure that
+ * the shared link status remains consistent across the topology, and to
+ * prevent new modesets from occurring on the topology without first requiring
+ * a full retrain.
+ */
+
+/**
+ * drm_dp_mst_topology_mgr_lower_link_rate() - Override the DP link rate/count
+ * for all connectors in a given MST topology
+ * @mgr: manager to set state for
+ * @link_rate: The new DP link bandwidth
+ * @lane_count: The new DP lane count
+ *
+ * This is called by the driver when it detects that the current DP link for
+ * the given topology manager is unstable, and needs to be retrained at a
+ * lower link rate/lane count.
+ *
+ * This takes care of updating the link status on all downstream connectors,
+ * the mst topology's atomic state, and VC payloads for each port.
+ * The driver should send a hotplug event after calling this function to
+ * notify userspace of the link status change.
+ *
+ * RETURNS:
+ *
+ * True for success, or negative error code on failure.
+ */
+int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
+					    int link_rate, int lane_count)
+{
+	struct drm_device *dev = mgr->dev;
+	struct drm_dp_mst_topology_state *state;
+	struct drm_dp_mst_branch *mst_primary;
+	struct drm_dp_mst_retrain_dep *retrain_dep, *retrain_tmp;
+	struct drm_connector *connector;
+	int new_pbn_div;
+	int ret = 0;
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	state = to_dp_mst_topology_state(mgr->base.state);
+
+	if (!drm_dp_get_vc_payload_bw(drm_dp_link_rate_to_bw_code(link_rate),
+				      lane_count, &new_pbn_div)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mst_primary = drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
+	if (!mst_primary)
+		goto out;
+
+	DRM_DEBUG_KMS("MST link impossible to retrain at current params, lowering pbn_div to %d\n",
+		      new_pbn_div);
+	mgr->pbn_div = new_pbn_div;
+
+	ret = drm_dp_set_mstb_link_status(mgr, mst_primary,
+					  DRM_LINK_STATUS_BAD);
+	if (ret) {
+		DRM_DEBUG_KMS("Failed to update link status, rolling back\n");
+
+		list_for_each_entry_safe(retrain_dep, retrain_tmp,
+					 &state->bad_ports, entry) {
+			connector = retrain_dep->connector;
+			connector->state->link_status = DRM_LINK_STATUS_GOOD;
+
+			drm_dp_mst_destroy_retrain_dep(retrain_dep);
+		}
+	}
+
+	drm_dp_put_mst_branch_device(mst_primary);
+out:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_mgr_lower_link_rate);
+
+static void
+drm_atomic_dp_mst_satisfy_retrain_dep(struct drm_dp_mst_topology_state *mst_state,
+				      struct drm_connector *connector)
+{
+	struct drm_dp_mst_retrain_dep *dep;
+
+	list_for_each_entry(dep, &mst_state->bad_ports, entry) {
+		if (dep->connector != connector)
+			continue;
+
+		drm_dp_mst_destroy_retrain_dep(dep);
+		break;
+	}
+}
+
+static int
+drm_atomic_dp_mst_retrain_connector(struct drm_atomic_state *state,
+				    struct drm_dp_mst_topology_state *mst_state,
+				    struct drm_connector *connector)
+{
+	struct drm_connector_state *conn_state =
+		drm_atomic_get_connector_state(state, connector);
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
+
+	if (conn_state->link_status == DRM_LINK_STATUS_BAD) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] link status bad -> good\n",
+				 connector->base.id, connector->name);
+		conn_state->link_status = DRM_LINK_STATUS_GOOD;
+	}
+
+	drm_atomic_dp_mst_satisfy_retrain_dep(mst_state, connector);
+
+	crtc = conn_state->crtc;
+	if (!crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
+	if (!drm_atomic_crtc_needs_modeset(crtc_state))
+		DRM_DEBUG_ATOMIC("[CRTC:%d:%s] needs full modeset\n",
+				 crtc->base.id, crtc->name);
+
+	crtc_state->mode_changed = true;
+	return 0;
+}
+
+static int
+drm_atomic_dp_mst_retrain_mstb(struct drm_atomic_state *state,
+			       struct drm_dp_mst_topology_state *mst_state,
+			       struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+	struct drm_connector *connector;
+	int ret;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mstb->mgr, port->mstb);
+		if (rmstb) {
+			ret = drm_atomic_dp_mst_retrain_mstb(state, mst_state,
+							     rmstb);
+			drm_dp_put_mst_branch_device(rmstb);
+			if (ret)
+				return ret;
+		}
+
+		connector = port->connector;
+		if (!connector)
+			continue;
+
+		ret = drm_atomic_dp_mst_retrain_connector(state, mst_state,
+							  connector);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * drm_dp_atomic_mst_check_retrain() - Prepare the topology's state to be
+ * retrained during this atomic commit, if required
+ * @new_conn_state: the new connector state possibly triggering a retrain
+ * @mgr: The DP MST topology to retrain
+ *
+ * When the link status of an MST topology goes from
+ * &DRM_MODE_LINK_STATUS_GOOD to &DRM_MODE_LINK_STATUS_BAD, the entire
+ * topology is considered to be in a state where a retrain at a lower link
+ * rate is required. Because each connector on an MST topology shares the same
+ * DP link, each connector must have it's link rate lowered and be retrained
+ * at the same time. Additionally, drivers must take care to update the link
+ * status of a connector on an MST topology themselves if userspace attempts
+ * to set a new mode to the connector regardless of whether or not it properly
+ * updates the connector's link status property from
+ * &DRM_MODE_LINK_STATUS_BAD to &DRM_MODE_LINK_STATUS_GOOD. In this case, the
+ * driver must take care of updating this link status property on it's own.
+ *
+ * This function takes care of handling all of the above requirements, and
+ * should be called during the start of the atomic check phase for an MST
+ * connector if the driver properly implements MST fallback retraining.
+ *
+ * Additionally; drivers are recommended to check the return value of this
+ * function in order to determine whether or not a full retrain of the MST
+ * topology would be performed by the new atomic state. This gives the
+ * driver a chance to update any private portions of the topology state that
+ * must be reset before a retrain, such as the link rate and lane count being
+ * shared by the topology.
+ *
+ * RETURNS: 1 if the given atomic state retrains the MST topology, 0 if the
+ * atomic state doesn't retrain the topology. On error, a negative error code
+ * is returned.
+ */
+int drm_dp_atomic_mst_check_retrain(struct drm_connector_state *new_conn_state,
+				    struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_atomic_state *state = new_conn_state->state;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_retrain_dep *retrain_dep, *retrain_tmp;
+	struct drm_connector *connector = new_conn_state->connector;
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int ret;
+
+	if (old_conn_state->link_status != DRM_LINK_STATUS_BAD)
+		return 0;
+
+	mst_state = drm_atomic_dp_mst_get_topology_state(state, mgr);
+	if (list_empty(&mst_state->bad_ports))
+		return 0;
+
+	/* Check if the new state requires us to update the link status
+	 * prop
+	 */
+	if (new_conn_state->link_status == DRM_LINK_STATUS_BAD) {
+		/* Any modesets that leave a CRTC enabled must update link
+		 * status
+		 */
+		if (new_conn_state->crtc) {
+			crtc = new_conn_state->crtc;
+			crtc_state = drm_atomic_get_new_crtc_state(state,
+								   crtc);
+			if (crtc_state &&
+			    drm_atomic_crtc_needs_modeset(crtc_state)) {
+				DRM_DEBUG_ATOMIC("[CRTC:%d:%s] modeset requires link retrain\n",
+						 crtc->base.id, crtc->name);
+				new_conn_state->link_status =
+					DRM_LINK_STATUS_GOOD;
+			}
+		} else if (old_conn_state->crtc) {
+			drm_atomic_dp_mst_satisfy_retrain_dep(mst_state,
+							      connector);
+			/* If all CRTCs on this hub would be disabled by this
+			 * state, link status can be updated to GOOD
+			 */
+			if (list_empty(&mst_state->bad_ports)) {
+				DRM_DEBUG_ATOMIC("state %p disables all CRTCs on %p, link would be retrained\n",
+						 state, mgr);
+				new_conn_state->link_status =
+					DRM_LINK_STATUS_GOOD;
+			}
+		}
+		if (new_conn_state->link_status == DRM_LINK_STATUS_BAD)
+			return 0;
+	}
+
+	DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] link status bad -> good\n",
+			 connector->base.id, connector->name);
+	ret = drm_atomic_dp_mst_retrain_connector(state, mst_state,
+						  connector);
+	if (ret)
+		return ret;
+
+	/* Retrain whole topology */
+	mstb = drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
+	if (!mstb)
+		return -EIO;
+	ret = drm_atomic_dp_mst_retrain_mstb(state, mst_state, mstb);
+	drm_dp_put_mst_branch_device(mstb);
+	if (ret)
+		return ret;
+
+	/* Additionally, it's possible that the topology connector state may
+	 * have changed between the time the topology's link status went to
+	 * BAD. As a result, it's possible that there's still leftover retrain
+	 * dependencies that refer to connectors that no longer exist on the
+	 * hub. Ensure these are added to the state as well
+	 */
+	list_for_each_entry_safe(retrain_dep, retrain_tmp,
+				 &mst_state->bad_ports, entry) {
+		ret = drm_atomic_dp_mst_retrain_connector(state, mst_state,
+							  connector);
+		if (ret)
+			return ret;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL(drm_dp_atomic_mst_check_retrain);
+
 static void drm_dp_mst_topology_reset_state(struct drm_dp_mst_topology_mgr *mgr)
 {
+	struct drm_dp_mst_retrain_dep *retrain_dep, *retrain_tmp;
 	struct drm_dp_mst_topology_state *state =
 		to_dp_mst_topology_state(mgr->base.state);
+	struct drm_connector *connector;
+
+	list_for_each_entry_safe(retrain_dep, retrain_tmp, &state->bad_ports,
+				 entry) {
+		/* Reset the connector link state, since there's no way to
+		 * retrain something that no longer exists
+		 */
+		connector = retrain_dep->connector;
+
+		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] loses parent MST topology mgr %p, link status bad -> good\n",
+			      connector->base.id, connector->name, mgr);
+		connector->state->link_status = DRM_LINK_STATUS_GOOD;
+		drm_dp_mst_destroy_retrain_dep(retrain_dep);
+	}
 
 	if (mgr->cbs->reset_state)
 		mgr->cbs->reset_state(state);
@@ -3110,7 +3515,7 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
 		(*mgr->cbs->hotplug)(mgr);
 }
 
-/**
+/*
  * drm_atomic_dp_mst_duplicate_topology_state - default
  * drm_dp_mst_topology_state duplicate handler
  *
@@ -3153,9 +3558,26 @@ int
 __drm_atomic_dp_mst_duplicate_topology_state(struct drm_dp_mst_topology_mgr *mgr,
 					     struct drm_dp_mst_topology_state *state)
 {
+	struct drm_dp_mst_retrain_dep *retrain_dep, *new_retrain_dep;
 	struct drm_private_obj *obj = &mgr->base;
+	struct drm_dp_mst_topology_state *src_state =
+		to_dp_mst_topology_state(obj->state);
 
 	memcpy(state, obj->state, sizeof(*state));
+	INIT_LIST_HEAD(&state->bad_ports);
+
+	/* Copy the bad ports list to the new state */
+	list_for_each_entry(retrain_dep, &src_state->bad_ports, entry) {
+		new_retrain_dep = kmalloc(sizeof(*retrain_dep), GFP_KERNEL);
+		if (!new_retrain_dep) {
+			__drm_atomic_dp_mst_destroy_topology_state(state);
+			return -ENOMEM;
+		}
+
+		new_retrain_dep->connector = retrain_dep->connector;
+		drm_connector_get(retrain_dep->connector);
+		list_add(&new_retrain_dep->entry, &state->bad_ports);
+	}
 
 	__drm_atomic_helper_private_obj_duplicate_state(&mgr->base,
 							&state->base);
@@ -3169,9 +3591,8 @@ EXPORT_SYMBOL(__drm_atomic_dp_mst_duplicate_topology_state);
  *
  * For drivers which don't yet subclass drm_dp_mst_topology_state.
  */
-void
-drm_atomic_dp_mst_destroy_topology_state(struct drm_private_obj *obj,
-					 struct drm_private_state *state)
+void drm_atomic_dp_mst_destroy_topology_state(struct drm_private_obj *obj,
+					      struct drm_private_state *state)
 {
 	struct drm_dp_mst_topology_state *mst_state =
 		to_dp_mst_topology_state(state);
@@ -3192,6 +3613,13 @@ EXPORT_SYMBOL(drm_atomic_dp_mst_destroy_topology_state);
 void
 __drm_atomic_dp_mst_destroy_topology_state(struct drm_dp_mst_topology_state *state)
 {
+	struct drm_dp_mst_retrain_dep *retrain_dep, *retrain_tmp;
+
+	list_for_each_entry_safe(retrain_dep, retrain_tmp, &state->bad_ports,
+				 entry) {
+		drm_connector_put(retrain_dep->connector);
+		kfree(retrain_dep);
+	}
 }
 EXPORT_SYMBOL(__drm_atomic_dp_mst_destroy_topology_state);
 
@@ -3276,6 +3704,8 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	/* max. time slots - one slot for MTP header */
 	state->avail_slots = 63;
 
+	INIT_LIST_HEAD(&state->bad_ports);
+
 	drm_atomic_private_obj_init(&mgr->base,
 				    &state->base,
 				    mgr->funcs);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 3a7378cd5bd1..32f6944de560 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -407,9 +407,24 @@ struct drm_dp_payload {
 
 #define to_dp_mst_topology_state(x) container_of(x, struct drm_dp_mst_topology_state, base)
 
+/* Represents a connector with an MST port whose mstb had a mode programmed
+ * when the link rate of the topology was lowered. As long as a topology state
+ * has these, no mstbs may be activated
+ */
+struct drm_dp_mst_retrain_dep {
+	struct drm_connector *connector;
+	struct list_head entry;
+};
+
 struct drm_dp_mst_topology_state {
 	struct drm_private_state base;
 	int avail_slots;
+	/**
+	 * @bad_ports: DRM connectors that must have their mode changed before
+	 * the link status of each connector on the MST hub can be updated
+	 * from BAD to GOOD
+	 */
+	struct list_head bad_ports;
 	struct drm_dp_mst_topology_mgr *mgr;
 };
 
@@ -639,4 +654,9 @@ int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
 int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_port *port, bool power_up);
 
+int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
+					    int link_rate, int lane_count);
+int drm_dp_atomic_mst_check_retrain(struct drm_connector_state *new_conn_state,
+				    struct drm_dp_mst_topology_mgr *mgr);
+
 #endif
-- 
2.14.3

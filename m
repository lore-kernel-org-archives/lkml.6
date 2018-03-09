Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeCIVdK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:33:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932327AbeCIVdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:33:07 -0500
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] drm/dp_mst: Add drm_atomic_dp_mst_retrain_topology()
Date: Fri,  9 Mar 2018 16:32:30 -0500
Message-Id: <20180309213232.19855-4-lyude@redhat.com>
In-Reply-To: <20180309213232.19855-1-lyude@redhat.com>
References: <20180308232421.14049-1-lyude@redhat.com>
 <20180309213232.19855-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retraining MST is rather difficult. In order to do it properly while
guaranteeing that we'll never run into a spot where we commit a
physically impossible configuration, we have to do a lot of checks on
atomic commits which affect MST topologies. All of this work is going to
need to be repeated for every driver at some point, so let's save
ourselves some trouble and just implement these atomic checks as
a single helper.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 223 ++++++++++++++++++++++++++++++++++
 include/drm/drm_dp_mst_helper.h       |   2 +
 2 files changed, 225 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0d6604500b29..c4a91b1ba61b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2167,6 +2167,229 @@ int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_lower_link_rate);
 
+static bool drm_atomic_dp_mst_state_only_disables_mstbs(struct drm_atomic_state *state,
+							struct drm_dp_mst_topology_mgr *mgr,
+							struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mstb->mgr, port->mstb);
+		if (rmstb) {
+			ret = drm_atomic_dp_mst_state_only_disables_mstbs(
+			    state, mgr, rmstb);
+			drm_dp_put_mst_branch_device(rmstb);
+			if (!ret)
+				return false;
+		}
+
+		connector = port->connector;
+		if (!connector)
+			continue;
+
+		conn_state = drm_atomic_get_new_connector_state(
+		    state, connector);
+		if (!conn_state)
+			continue;
+
+		crtc = conn_state->crtc;
+		if (!crtc)
+			continue;
+
+		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+		if (!crtc_state)
+			continue;
+
+		if (drm_atomic_crtc_needs_modeset(crtc_state))
+			return false;
+	}
+
+	return true;
+}
+
+static int drm_atomic_dp_mst_all_mstbs_disabled(struct drm_atomic_state *state,
+						struct drm_dp_mst_topology_mgr *mgr,
+						struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	int ret;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mstb->mgr, port->mstb);
+		if (rmstb) {
+			ret = drm_atomic_dp_mst_all_mstbs_disabled(
+			    state, mgr, rmstb);
+			drm_dp_put_mst_branch_device(rmstb);
+			if (ret <= 0)
+				return ret;
+		}
+
+		connector = port->connector;
+		if (!connector)
+			continue;
+
+		conn_state = drm_atomic_get_connector_state(
+		    state, connector);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		if (conn_state->crtc)
+			return false;
+	}
+
+	/* No enabled CRTCs found */
+	return true;
+}
+
+static int drm_atomic_dp_mst_retrain_mstb(struct drm_atomic_state *state,
+					  struct drm_dp_mst_topology_mgr *mgr,
+					  struct drm_dp_mst_branch *mstb,
+					  bool full_modeset)
+{
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mstb->mgr, port->mstb);
+		if (rmstb) {
+			ret = drm_atomic_dp_mst_retrain_mstb(
+			    state, mgr, rmstb, full_modeset);
+			drm_dp_put_mst_branch_device(rmstb);
+			if (ret)
+				return ret;
+		}
+
+		connector = port->connector;
+		if (!connector)
+			continue;
+
+		conn_state = drm_atomic_get_connector_state(state, connector);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		if (conn_state->link_status != DRM_MODE_LINK_STATUS_GOOD) {
+			DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] link status bad -> good\n",
+					 connector->base.id, connector->name);
+			conn_state->link_status = DRM_MODE_LINK_STATUS_GOOD;
+		}
+
+		if (!full_modeset)
+			continue;
+
+		crtc = conn_state->crtc;
+		if (!crtc)
+			continue;
+
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		if (!crtc_state->mode_changed) {
+			DRM_DEBUG_ATOMIC("[CRTC:%d:%s] needs full modeset\n",
+					 crtc->base.id, crtc->name);
+			crtc_state->mode_changed = true;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * drm_atomic_dp_mst_retrain_topology() - prepare a modeset that will retrain
+ * an MST topology
+ * @state: The new state that would retrain the topology link
+ * @mgr: The topology manager to use
+ *
+ * After userspace has been signaled that connectors are in need of
+ * retraining, it's expected that a modeset will be performed for any CRTCs on
+ * said connectors. Since all of the branch devices in an MST topology share a
+ * single link, they also share the same link status, lane count, and link
+ * rate.
+ *
+ * Since all of these characteristics are shared, there's only two valid
+ * solutions when fallback link training parameters need to be applied. The
+ * first is simply unassigning each mstb connector's CRTC. Since this action
+ * can only free slots on the VCPI table and not allocate them, this can be
+ * done without pulling in additional CRTCs on the MST topology. Additionally
+ * if this action would result in there no longer being any CRTCs assigned to
+ * mstb connectors, this would be enough to bring the topology back into a
+ * trained state since there would be nothing left requiring VCPI
+ * reallocations.
+ *
+ * The second solution is to commit new modes to all of the connectors on the
+ * topology. Since this action would result in VCPI reallocations with a new
+ * link rate and lane count, a modeset must also be performed on every other
+ * CRTC driving a branch device on the given topology at the same time. This
+ * is to ensure that all VCPI allocations are properly recalculated in
+ * response to the new link rate and lane count, that the new modes will fit
+ * into the recalculated VCPI table, and that the new atomic state could never
+ * result in an otherwise physically impossible configuration (e.g. different
+ * mstbs with CRTCs trained to different link rates/lane counts).
+ *
+ * Finally, any atomic commit which would result in going from an
+ * unrecoverable link state to a properly trained link state must also take
+ * care of appropriately updating the link status properties of all connectors
+ * on the topology from bad to good. This function takes care of all of these
+ * checks in @state for the topology manager @mgr including possibly pulling
+ * in additional CRTCs into the modeset, and possibly updating the link status
+ * of each mstb's DRM connector.
+ *
+ * This function should be called within the driver's atomic check callbacks
+ * whenever a modeset happens on an MST connector with it's link status set to
+ * DRM_MODE_LINK_STATUS_BAD.
+ *
+ * RETURNS:
+ *
+ * Returns 0 for success, or negative error code for failure.
+ */
+int drm_atomic_dp_mst_retrain_topology(struct drm_atomic_state *state,
+				       struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_dp_mst_branch *mstb =
+		drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
+	int ret = 0;
+	bool need_modeset = false;
+
+	if (!mstb)
+		return 0;
+
+	if (drm_atomic_dp_mst_state_only_disables_mstbs(state, mgr, mstb)) {
+		ret = drm_atomic_dp_mst_all_mstbs_disabled(state, mgr, mstb);
+		if (ret < 0)
+			goto out;
+
+		if (ret)
+			DRM_DEBUG_ATOMIC("state %p disables all CRTCs on mst mgr %p\n",
+					 state, mgr);
+		else
+			goto out; /* valid, but doesn't retrain link */
+	} else {
+		DRM_DEBUG_ATOMIC("state %p requires full modeset for CRTCs on mst mgr %p\n",
+				 state, mgr);
+		need_modeset = true;
+	}
+
+	ret = drm_atomic_dp_mst_retrain_mstb(state, mgr, mstb, need_modeset);
+out:
+	drm_dp_put_mst_branch_device(mgr->mst_primary);
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_dp_mst_retrain_topology);
+
 /**
  * drm_dp_mst_topology_mgr_set_mst() - Set the MST state for a topology manager
  * @mgr: manager to set state for
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 6261ec43a2c0..24075eb2dd1b 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -636,5 +636,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 
 int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
 					    int dp_link_bw, int dp_link_count);
+int drm_atomic_dp_mst_retrain_topology(struct drm_atomic_state *state,
+				       struct drm_dp_mst_topology_mgr *mgr);
 
 #endif
-- 
2.14.3

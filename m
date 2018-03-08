Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeCHXYe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:24:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751277AbeCHXYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:24:31 -0500
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drm/dp_mst: Add drm_dp_mst_topology_mgr_lower_link_rate()
Date: Thu,  8 Mar 2018 18:24:18 -0500
Message-Id: <20180308232421.14049-5-lyude@redhat.com>
In-Reply-To: <20180308232421.14049-1-lyude@redhat.com>
References: <20180308232421.14049-1-lyude@redhat.com>
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
entire topology under a lower link rate. Since the VCID allocations for
each mstb is determined based off the link rate for the top of the
topology, we also have to recalculate all of the VCID allocations for
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

Since the work of figuring out which connectors live downstream on an
MST topology and updating their link status is something that any driver
supporting MST is going to need to do in order to retrain MST links
properly, we add the drm_dp_mst_topology_mgr_lower_link_rate() helper
which simply recalculates the pbn_div for a given mst topology, then
marks the link status of all connectors living in that topology as bad.
We'll make use of it in i915 later in this series.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 73 ++++++++++++++++++++++++++++++++++-
 include/drm/drm_dp_mst_helper.h       |  3 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6fac4129e6a2..0d6604500b29 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2076,7 +2076,7 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
 {
 	switch (dp_link_bw) {
 	default:
-		DRM_DEBUG_KMS("invalid link bandwidth in DPCD: %x (link count: %d)\n",
+		DRM_DEBUG_KMS("invalid link bandwidth: %x (link count: %d)\n",
 			      dp_link_bw, dp_link_count);
 		return false;
 
@@ -2096,6 +2096,77 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
 	return true;
 }
 
+static void drm_dp_set_mstb_link_status(struct drm_dp_mst_branch *mstb,
+					enum drm_link_status status)
+{
+	struct drm_dp_mst_branch *rmstb;
+	struct drm_dp_mst_port *port;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		rmstb = drm_dp_get_validated_mstb_ref(mstb->mgr, port->mstb);
+		if (rmstb) {
+			drm_dp_set_mstb_link_status(rmstb, status);
+			drm_dp_put_mst_branch_device(rmstb);
+		}
+
+		if (port->connector)
+			port->connector->state->link_status = status;
+	}
+}
+
+/**
+ * drm_dp_mst_topology_mgr_lower_link_rate() - Override the DP link bw/count
+ * for all connectors in a given MST topology
+ * @mgr: manager to set state for
+ * @dp_link_bw: The new DP link bandwidth
+ * @dp_link_count: The new DP link count
+ *
+ * This is called by the driver when it detects that the current DP link for
+ * the given topology manager is unstable, and needs to be retrained at a
+ * lower link rate.
+ *
+ * This takes care of updating the link status on all downstream connectors
+ * along with recalculating the VC payloads. The driver should send a hotplug
+ * event after calling this function to notify userspace of the link status
+ * change.
+ *
+ * RETURNS:
+ *
+ * True for success, or negative error code on failure.
+ */
+int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
+					    int dp_link_bw, int dp_link_count)
+{
+	struct drm_device *dev = mgr->dev;
+	struct drm_dp_mst_branch *mst_primary;
+	int new_pbn_div;
+	int ret = 0;
+
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+
+	if (!drm_dp_get_vc_payload_bw(drm_dp_link_rate_to_bw_code(dp_link_bw),
+				      dp_link_count, &new_pbn_div)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mst_primary = drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
+	if (!mst_primary)
+		goto out;
+
+	DRM_DEBUG_KMS("MST link failed to retrain, lowering pbn_div to %d\n",
+		      new_pbn_div);
+	mgr->pbn_div = new_pbn_div;
+
+	drm_dp_set_mstb_link_status(mst_primary, DRM_MODE_LINK_STATUS_BAD);
+
+	drm_dp_put_mst_branch_device(mst_primary);
+out:
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(drm_dp_mst_topology_mgr_lower_link_rate);
+
 /**
  * drm_dp_mst_topology_mgr_set_mst() - Set the MST state for a topology manager
  * @mgr: manager to set state for
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 7f78d26a0766..6261ec43a2c0 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -634,4 +634,7 @@ int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
 int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_port *port, bool power_up);
 
+int drm_dp_mst_topology_mgr_lower_link_rate(struct drm_dp_mst_topology_mgr *mgr,
+					    int dp_link_bw, int dp_link_count);
+
 #endif
-- 
2.14.3

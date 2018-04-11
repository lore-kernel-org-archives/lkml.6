Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeDKTag (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:30:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756848AbeDKTad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:30:33 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/10] drm/dp_mst: Add reset_state callback to topology mgr
Date: Wed, 11 Apr 2018 15:29:33 -0400
Message-Id: <20180411192951.21997-7-lyude@redhat.com>
In-Reply-To: <20180411192951.21997-1-lyude@redhat.com>
References: <20180411192951.21997-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gives drivers subclassing drm_dp_mst_topology_state the ability to
prepare their topology states for a new hub to be connected whenever
it's detected that the currently connected topology has been
disconnected from the system. We'll need this in order to correctly
track RX capabilities in i915 from the topology's atomic state.

Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 11 +++++++++++
 include/drm/drm_dp_mst_helper.h       |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 8a72eed0ae05..b55fd545d6a3 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2096,6 +2096,16 @@ static bool drm_dp_get_vc_payload_bw(int dp_link_bw,
 	return true;
 }
 
+static void drm_dp_mst_topology_reset_state(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct drm_dp_mst_topology_state *state =
+		to_dp_mst_topology_state(mgr->base.state);
+
+
+	if (mgr->cbs->reset_state)
+		mgr->cbs->reset_state(state);
+}
+
 /**
  * drm_dp_mst_topology_mgr_set_mst() - Set the MST state for a topology manager
  * @mgr: manager to set state for
@@ -2171,6 +2181,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		mgr->payload_mask = 0;
 		set_bit(0, &mgr->payload_mask);
 		mgr->vcpi_mask = 0;
+		drm_dp_mst_topology_reset_state(mgr);
 	}
 
 out_unlock:
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index b42922987470..fd856c371a6e 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -381,6 +381,7 @@ struct drm_dp_sideband_msg_tx {
 
 /* sideband msg handler */
 struct drm_dp_mst_topology_mgr;
+struct drm_dp_mst_topology_state;
 struct drm_dp_mst_topology_cbs {
 	/* create a connector for a port */
 	struct drm_connector *(*add_connector)(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port, const char *path);
@@ -388,7 +389,7 @@ struct drm_dp_mst_topology_cbs {
 	void (*destroy_connector)(struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_connector *connector);
 	void (*hotplug)(struct drm_dp_mst_topology_mgr *mgr);
-
+	void (*reset_state)(struct drm_dp_mst_topology_state *state);
 };
 
 #define DP_MAX_PAYLOAD (sizeof(unsigned long) * 8)
-- 
2.14.3

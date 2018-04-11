Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeDKXna (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:43:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752406AbeDKXnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:43:14 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] drm/dp_mst: Fix naming on drm_atomic_get_mst_topology_state()
Date: Wed, 11 Apr 2018 19:42:42 -0400
Message-Id: <20180411234302.2896-4-lyude@redhat.com>
In-Reply-To: <20180411234302.2896-1-lyude@redhat.com>
References: <20180411234302.2896-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since these functions are dealing with an atomic state that needs to be
modified during atomic check and commit, change the naming on this
function to drm_atomic_dp_mst_get_topology_state() since we're the only
one using the function, and it's more consistent with the naming
scheme used in drm_atomic.c/drm_atomic_helper.c.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

V7:
 - Fix CHECKPATCH errors
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 13 +++++++------
 include/drm/drm_dp_mst_helper.h       |  6 ++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6fac4129e6a2..ba67f1782a04 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2622,7 +2622,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 	struct drm_dp_mst_topology_state *topology_state;
 	int req_slots;
 
-	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
+	topology_state = drm_atomic_dp_mst_get_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
 		return PTR_ERR(topology_state);
 
@@ -2662,7 +2662,7 @@ int drm_dp_atomic_release_vcpi_slots(struct drm_atomic_state *state,
 {
 	struct drm_dp_mst_topology_state *topology_state;
 
-	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
+	topology_state = drm_atomic_dp_mst_get_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
 		return PTR_ERR(topology_state);
 
@@ -3129,7 +3129,7 @@ static const struct drm_private_state_funcs mst_state_funcs = {
 };
 
 /**
- * drm_atomic_get_mst_topology_state: get MST topology state
+ * drm_atomic_dp_mst_get_topology_state: get MST topology state
  *
  * @state: global atomic state
  * @mgr: MST topology manager, also the private object in this case
@@ -3143,15 +3143,16 @@ static const struct drm_private_state_funcs mst_state_funcs = {
  *
  * The MST topology state or error pointer.
  */
-struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
-								    struct drm_dp_mst_topology_mgr *mgr)
+struct drm_dp_mst_topology_state *
+drm_atomic_dp_mst_get_topology_state(struct drm_atomic_state *state,
+				     struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_device *dev = mgr->dev;
 
 	WARN_ON(!drm_modeset_is_locked(&dev->mode_config.connection_mutex));
 	return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(state, &mgr->base));
 }
-EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
+EXPORT_SYMBOL(drm_atomic_dp_mst_get_topology_state);
 
 /**
  * drm_dp_mst_topology_mgr_init - initialise a topology manager
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 7f78d26a0766..2f6203407fd2 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -623,8 +623,10 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
-struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
-								    struct drm_dp_mst_topology_mgr *mgr);
+
+struct drm_dp_mst_topology_state *
+drm_atomic_dp_mst_get_topology_state(struct drm_atomic_state *state,
+				     struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 				  struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_dp_mst_port *port, int pbn);
-- 
2.14.3

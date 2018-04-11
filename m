Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDKWzi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 18:55:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751734AbeDKWzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 18:55:33 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Roman Li <Roman.Li@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [PATCH v7 05/10] drm/dp_mst: Make drm_dp_mst_topology_state subclassable
Date: Wed, 11 Apr 2018 18:54:42 -0400
Message-Id: <20180411225501.26751-6-lyude@redhat.com>
In-Reply-To: <20180411225501.26751-1-lyude@redhat.com>
References: <20180411225501.26751-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for drivers (which will probably be all of them soon)
which need to track state that is exclusive to the topology, and not a
specific connector on said topology. This includes things such as the
link rate and lane count that are shared by all of the connectors on the
topology.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

V7:
 - Fix CHECKPATCH errors
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 46 ++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  4 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 95 +++++++++++++++++-----
 drivers/gpu/drm/i915/intel_dp_mst.c                | 13 ++-
 drivers/gpu/drm/nouveau/nv50_display.c             | 17 +++-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             | 13 ++-
 include/drm/drm_dp_mst_helper.h                    |  8 ++
 8 files changed, 173 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e42a28e3adc5..2c3660c36732 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3626,9 +3626,17 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	drm_connector_register(&aconnector->base);
 
-	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
-		|| connector_type == DRM_MODE_CONNECTOR_eDP)
-		amdgpu_dm_initialize_dp_connector(dm, aconnector);
+	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector_type == DRM_MODE_CONNECTOR_eDP) {
+		res = amdgpu_dm_initialize_dp_connector(dm, aconnector);
+		if (res) {
+			drm_connector_unregister(&aconnector->base);
+			drm_connector_cleanup(&aconnector->base);
+			aconnector->connector_id = -1;
+
+			goto out_free;
+		}
+	}
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8291d74f26bc..dcaa92d12cbc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -475,22 +475,48 @@ static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 	.register_connector = dm_dp_mst_register_connector
 };
 
-void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector)
+static const struct drm_private_state_funcs dm_mst_state_funcs = {
+	.atomic_duplicate_state = drm_atomic_dp_mst_duplicate_topology_state,
+	.atomic_destroy_state = drm_atomic_dp_mst_destroy_topology_state,
+};
+
+int amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
+				      struct amdgpu_dm_connector *aconnector)
 {
+	struct drm_dp_mst_topology_state *state =
+		kzalloc(sizeof(*state), GFP_KERNEL);
+	int ret = 0;
+
+	if (!state)
+		return -ENOMEM;
+
 	aconnector->dm_dp_aux.aux.name = "dmdc";
 	aconnector->dm_dp_aux.aux.dev = dm->adev->dev;
 	aconnector->dm_dp_aux.aux.transfer = dm_dp_aux_transfer;
 	aconnector->dm_dp_aux.ddc_service = aconnector->dc_link->ddc;
 
-	drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
+	ret = drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
+	if (ret)
+		goto err_aux;
+
 	aconnector->mst_mgr.cbs = &dm_mst_cbs;
-	drm_dp_mst_topology_mgr_init(
-		&aconnector->mst_mgr,
-		dm->adev->ddev,
-		&aconnector->dm_dp_aux.aux,
-		16,
-		4,
-		aconnector->connector_id);
+	aconnector->mst_mgr.funcs = &dm_mst_state_funcs;
+	ret = drm_dp_mst_topology_mgr_init(&aconnector->mst_mgr,
+					   state,
+					   dm->adev->ddev,
+					   &aconnector->dm_dp_aux.aux,
+					   16,
+					   4,
+					   aconnector->connector_id);
+	if (ret)
+		goto err_mst;
+
+	return 0;
+
+err_mst:
+	drm_dp_aux_unregister(&aconnector->dm_dp_aux.aux);
+err_aux:
+	kfree(state);
+	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 8cf51da26657..d28fb456d2d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -29,8 +29,8 @@
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
-void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector);
+int amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
+				      struct amdgpu_dm_connector *aconnector);
 void dm_dp_mst_dc_sink_create(struct drm_connector *connector);
 
 #endif
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ba67f1782a04..fbd7888ebca8 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3100,33 +3100,90 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
 		(*mgr->cbs->hotplug)(mgr);
 }
 
-static struct drm_private_state *
-drm_dp_mst_duplicate_state(struct drm_private_obj *obj)
+/**
+ * drm_atomic_dp_mst_duplicate_topology_state - default
+ * drm_dp_mst_topology_state duplicate handler
+ *
+ * For drivers which don't yet subclass drm_dp_mst_topology_state
+ *
+ * RETURNS: the duplicated state on success, or an error code embedded into a
+ * pointer value otherwise.
+ */
+struct drm_private_state *
+drm_atomic_dp_mst_duplicate_topology_state(struct drm_private_obj *obj)
 {
+	struct drm_dp_mst_topology_mgr *mgr = to_dp_mst_topology_mgr(obj);
 	struct drm_dp_mst_topology_state *state;
+	int ret;
 
 	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
-	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+	ret = __drm_atomic_dp_mst_duplicate_topology_state(mgr, state);
+	if (ret) {
+		kfree(state);
+		return NULL;
+	}
 
 	return &state->base;
 }
+EXPORT_SYMBOL(drm_atomic_dp_mst_duplicate_topology_state);
+
+/**
+ * __drm_atomic_dp_mst_duplicate_topology_state - default
+ * drm_dp_mst_topology_state duplicate hook
+ *
+ * Copies atomic state from an MST topology's current state. This is useful
+ * for drivers that subclass the MST topology state.
+ *
+ * RETURNS: 0 on success, negative error code on failure.
+ */
+int
+__drm_atomic_dp_mst_duplicate_topology_state(struct drm_dp_mst_topology_mgr *mgr,
+					     struct drm_dp_mst_topology_state *state)
+{
+	struct drm_private_obj *obj = &mgr->base;
+
+	memcpy(state, obj->state, sizeof(*state));
+
+	__drm_atomic_helper_private_obj_duplicate_state(&mgr->base,
+							&state->base);
+	return 0;
+}
+EXPORT_SYMBOL(__drm_atomic_dp_mst_duplicate_topology_state);
 
-static void drm_dp_mst_destroy_state(struct drm_private_obj *obj,
-				     struct drm_private_state *state)
+/**
+ * drm_atomic_dp_mst_destroy_topology_state - default
+ * drm_dp_mst_topology_state destroy handler
+ *
+ * For drivers which don't yet subclass drm_dp_mst_topology_state.
+ */
+void
+drm_atomic_dp_mst_destroy_topology_state(struct drm_private_obj *obj,
+					 struct drm_private_state *state)
 {
 	struct drm_dp_mst_topology_state *mst_state =
 		to_dp_mst_topology_state(state);
 
+	__drm_atomic_dp_mst_destroy_topology_state(mst_state);
+
 	kfree(mst_state);
 }
+EXPORT_SYMBOL(drm_atomic_dp_mst_destroy_topology_state);
 
-static const struct drm_private_state_funcs mst_state_funcs = {
-	.atomic_duplicate_state = drm_dp_mst_duplicate_state,
-	.atomic_destroy_state = drm_dp_mst_destroy_state,
-};
+/**
+ * __drm_atomic_dp_mst_destroy_topology_state - default
+ * drm_dp_mst_topology_state destroy hook
+ *
+ * Frees the resources associated with the given drm_dp_mst_topology_state.
+ * This is useful for drivers that subclass the MST topology state.
+ */
+void
+__drm_atomic_dp_mst_destroy_topology_state(struct drm_dp_mst_topology_state *state)
+{
+}
+EXPORT_SYMBOL(__drm_atomic_dp_mst_destroy_topology_state);
 
 /**
  * drm_atomic_dp_mst_get_topology_state: get MST topology state
@@ -3157,21 +3214,25 @@ EXPORT_SYMBOL(drm_atomic_dp_mst_get_topology_state);
 /**
  * drm_dp_mst_topology_mgr_init - initialise a topology manager
  * @mgr: manager struct to initialise
+ * @state: atomic topology state to init, allocated by the driver
  * @dev: device providing this structure - for i2c addition.
  * @aux: DP helper aux channel to talk to this device
  * @max_dpcd_transaction_bytes: hw specific DPCD transaction limit
  * @max_payloads: maximum number of payloads this GPU can source
  * @conn_base_id: the connector object ID the MST device is connected to.
  *
+ * Note that this function doesn't take care of allocating the atomic MST
+ * state, this must be handled by the caller before calling
+ * drm_dp_mst_topology_mgr_init().
+ *
  * Return 0 for success, or negative error code on failure
  */
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
+				 struct drm_dp_mst_topology_state *state,
 				 struct drm_device *dev, struct drm_dp_aux *aux,
 				 int max_dpcd_transaction_bytes,
 				 int max_payloads, int conn_base_id)
 {
-	struct drm_dp_mst_topology_state *mst_state;
-
 	mutex_init(&mgr->lock);
 	mutex_init(&mgr->qlock);
 	mutex_init(&mgr->payload_lock);
@@ -3200,18 +3261,14 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	if (test_calc_pbn_mode() < 0)
 		DRM_ERROR("MST PBN self-test failed\n");
 
-	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
-	if (mst_state == NULL)
-		return -ENOMEM;
-
-	mst_state->mgr = mgr;
+	state->mgr = mgr;
 
 	/* max. time slots - one slot for MTP header */
-	mst_state->avail_slots = 63;
+	state->avail_slots = 63;
 
 	drm_atomic_private_obj_init(&mgr->base,
-				    &mst_state->base,
-				    &mst_state_funcs);
+				    &state->base,
+				    mgr->funcs);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 9e6956c08688..cf844cfd2bb0 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -587,19 +587,30 @@ intel_dp_create_fake_mst_encoders(struct intel_digital_port *intel_dig_port)
 	return true;
 }
 
+static const struct drm_private_state_funcs mst_state_funcs = {
+	.atomic_destroy_state = drm_atomic_dp_mst_destroy_topology_state,
+	.atomic_duplicate_state = drm_atomic_dp_mst_duplicate_topology_state,
+};
+
 int
 intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_base_id)
 {
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
+	struct drm_dp_mst_topology_state *mst_state;
 	struct drm_device *dev = intel_dig_port->base.base.dev;
 	int ret;
 
+	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
+	if (!mst_state)
+		return -ENOMEM;
+
 	intel_dp->can_mst = true;
 	intel_dp->mst_mgr.cbs = &mst_cbs;
+	intel_dp->mst_mgr.funcs = &mst_state_funcs;
 
 	/* create encoders */
 	intel_dp_create_fake_mst_encoders(intel_dig_port);
-	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, dev,
+	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, mst_state, dev,
 					   &intel_dp->aux, 16, 3, conn_base_id);
 	if (ret) {
 		intel_dp->can_mst = false;
diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
index 8bd739cfd00d..200db30a9c43 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -3310,6 +3310,12 @@ nv50_mstm = {
 	.hotplug = nv50_mstm_hotplug,
 };
 
+static const struct drm_private_state_funcs
+nv50_mst_state_funcs = {
+	.atomic_duplicate_state = drm_atomic_dp_mst_duplicate_topology_state,
+	.atomic_destroy_state = drm_atomic_dp_mst_destroy_topology_state,
+};
+
 void
 nv50_mstm_service(struct nv50_mstm *mstm)
 {
@@ -3438,6 +3444,7 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 {
 	const int max_payloads = hweight8(outp->dcb->heads);
 	struct drm_device *dev = outp->base.base.dev;
+	struct drm_dp_mst_topology_state *state;
 	struct nv50_mstm *mstm;
 	int ret, i;
 	u8 dpcd;
@@ -3454,10 +3461,18 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 
 	if (!(mstm = *pmstm = kzalloc(sizeof(*mstm), GFP_KERNEL)))
 		return -ENOMEM;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		kfree(mstm);
+		return -ENOMEM;
+	}
 	mstm->outp = outp;
 	mstm->mgr.cbs = &nv50_mstm;
+	mstm->mgr.funcs = &nv50_mst_state_funcs;
 
-	ret = drm_dp_mst_topology_mgr_init(&mstm->mgr, dev, aux, aux_max,
+	ret = drm_dp_mst_topology_mgr_init(&mstm->mgr, state, dev,
+					   aux, aux_max,
 					   max_payloads, conn_base_id);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index cd8a3ee16649..6edf52404256 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -335,6 +335,11 @@ static const struct drm_dp_mst_topology_cbs mst_cbs = {
 	.hotplug = radeon_dp_mst_hotplug,
 };
 
+static const struct drm_private_state_funcs mst_state_funcs = {
+	.atomic_duplicate_state = drm_atomic_dp_mst_duplicate_topology_state,
+	.atomic_destroy_state = drm_atomic_dp_mst_destroy_topology_state,
+};
+
 static struct
 radeon_connector *radeon_mst_find_connector(struct drm_encoder *encoder)
 {
@@ -657,12 +662,18 @@ int
 radeon_dp_mst_init(struct radeon_connector *radeon_connector)
 {
 	struct drm_device *dev = radeon_connector->base.dev;
+	struct drm_dp_mst_topology_state *state =
+		kzalloc(sizeof(*state), GFP_KERNEL);
 
+	if (!state)
+		return -ENOMEM;
 	if (!radeon_connector->ddc_bus->has_aux)
 		return 0;
 
 	radeon_connector->mst_mgr.cbs = &mst_cbs;
-	return drm_dp_mst_topology_mgr_init(&radeon_connector->mst_mgr, dev,
+	radeon_connector->mst_mgr.funcs = &mst_state_funcs;
+	return drm_dp_mst_topology_mgr_init(&radeon_connector->mst_mgr,
+					    state, dev,
 					    &radeon_connector->ddc_bus->aux, 16, 6,
 					    radeon_connector->base.base.id);
 }
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 5ca77dcf4f90..ad1aaec8d514 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -565,6 +565,7 @@ struct drm_dp_mst_topology_mgr {
 };
 
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
+				 struct drm_dp_mst_topology_state *state,
 				 struct drm_device *dev, struct drm_dp_aux *aux,
 				 int max_dpcd_transaction_bytes,
 				 int max_payloads, int conn_base_id);
@@ -621,6 +622,13 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_dp_mst_topology_state *
 drm_atomic_dp_mst_get_topology_state(struct drm_atomic_state *state,
 				     struct drm_dp_mst_topology_mgr *mgr);
+struct drm_private_state *drm_atomic_dp_mst_duplicate_topology_state(struct drm_private_obj *obj);
+int __drm_atomic_dp_mst_duplicate_topology_state(struct drm_dp_mst_topology_mgr *mgr,
+						 struct drm_dp_mst_topology_state *state);
+void drm_atomic_dp_mst_destroy_topology_state(struct drm_private_obj *obj,
+					      struct drm_private_state *state);
+void __drm_atomic_dp_mst_destroy_topology_state(struct drm_dp_mst_topology_state *state);
+
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 				  struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_dp_mst_port *port, int pbn);
-- 
2.14.3

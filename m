Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7614620894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7614620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeH1VDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeH1VDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E86987A82;
        Tue, 28 Aug 2018 17:10:57 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7625310DCF48;
        Tue, 28 Aug 2018 17:10:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Shirish S <shirish.s@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/dp_mst: Pass entire connector to drm_dp_mst_topology_mgr_init()
Date:   Tue, 28 Aug 2018 13:10:28 -0400
Message-Id: <20180828171036.25943-3-lyude@redhat.com>
In-Reply-To: <20180828171036.25943-1-lyude@redhat.com>
References: <20180828171036.25943-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 17:10:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 17:10:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no actual reason we pass the connector ID instead of a pointer
to the connector itself, and we're going to need the entire connector
(but only temporarily) in order to name MST debugfs folders properly
since connector IDs can't be looked up until the driver has been
registered with userspace which happens after debugfs init.

So, just pass the entire drm_connector struct instead of just its id.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c                  | 10 ++++++----
 drivers/gpu/drm/i915/intel_dp.c                        |  2 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                    |  6 ++++--
 drivers/gpu/drm/i915/intel_drv.h                       |  3 ++-
 drivers/gpu/drm/nouveau/dispnv50/disp.c                |  6 +++---
 drivers/gpu/drm/radeon/radeon_dp_mst.c                 |  2 +-
 include/drm/drm_dp_mst_helper.h                        |  3 ++-
 8 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a300732ba37..60da7e8fcca7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -503,6 +503,6 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 		&aconnector->dm_dp_aux.aux,
 		16,
 		4,
-		aconnector->connector_id);
+		&aconnector->base);
 }
 
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 7780567aa669..acb7633f3f70 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3161,14 +3161,16 @@ EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
  * @aux: DP helper aux channel to talk to this device
  * @max_dpcd_transaction_bytes: hw specific DPCD transaction limit
  * @max_payloads: maximum number of payloads this GPU can source
- * @conn_base_id: the connector object ID the MST device is connected to.
+ * @connector: the &struct drm_connector the MST device is connected to.
  *
  * Return 0 for success, or negative error code on failure
  */
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
-				 struct drm_device *dev, struct drm_dp_aux *aux,
+				 struct drm_device *dev,
+				 struct drm_dp_aux *aux,
 				 int max_dpcd_transaction_bytes,
-				 int max_payloads, int conn_base_id)
+				 int max_payloads,
+				 struct drm_connector *connector)
 {
 	struct drm_dp_mst_topology_state *mst_state;
 
@@ -3186,7 +3188,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mgr->aux = aux;
 	mgr->max_dpcd_transaction_bytes = max_dpcd_transaction_bytes;
 	mgr->max_payloads = max_payloads;
-	mgr->conn_base_id = conn_base_id;
+	mgr->conn_base_id = connector->base.id;
 	if (max_payloads + 1 > sizeof(mgr->payload_mask) * 8 ||
 	    max_payloads + 1 > sizeof(mgr->vcpi_mask) * 8)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index cd0f649b57a5..3688df38dbe7 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -6247,7 +6247,7 @@ intel_dp_init_connector(struct intel_digital_port *intel_dig_port,
 	    (port == PORT_B || port == PORT_C ||
 	     port == PORT_D || port == PORT_F))
 		intel_dp_mst_encoder_init(intel_dig_port,
-					  intel_connector->base.base.id);
+					  &intel_connector->base);
 
 	if (!intel_edp_init_connector(intel_dp, intel_connector)) {
 		intel_dp_aux_fini(intel_dp);
diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 7e3e01607643..6c07c29235df 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -583,7 +583,8 @@ intel_dp_create_fake_mst_encoders(struct intel_digital_port *intel_dig_port)
 }
 
 int
-intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_base_id)
+intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port,
+			  struct drm_connector *connector)
 {
 	struct intel_dp *intel_dp = &intel_dig_port->dp;
 	struct drm_device *dev = intel_dig_port->base.base.dev;
@@ -595,7 +596,8 @@ intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_ba
 	/* create encoders */
 	intel_dp_create_fake_mst_encoders(intel_dig_port);
 	ret = drm_dp_mst_topology_mgr_init(&intel_dp->mst_mgr, dev,
-					   &intel_dp->aux, 16, 3, conn_base_id);
+					   &intel_dp->aux, 16, 3,
+					   connector);
 	if (ret) {
 		intel_dp->can_mst = false;
 		return ret;
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 8fc61e96754f..af7a6111ff74 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1749,7 +1749,8 @@ bool intel_digital_port_connected(struct intel_encoder *encoder);
 int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector);
 
 /* intel_dp_mst.c */
-int intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port, int conn_id);
+int intel_dp_mst_encoder_init(struct intel_digital_port *intel_dig_port,
+			      struct drm_connector *connector);
 void intel_dp_mst_encoder_cleanup(struct intel_digital_port *intel_dig_port);
 /* vlv_dsi.c */
 void vlv_dsi_init(struct drm_i915_private *dev_priv);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 7139b962c6fd..918f2519859b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1226,7 +1226,7 @@ nv50_mstm_del(struct nv50_mstm **pmstm)
 
 static int
 nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
-	      int conn_base_id, struct nv50_mstm **pmstm)
+	      struct drm_connector *connector, struct nv50_mstm **pmstm)
 {
 	const int max_payloads = hweight8(outp->dcb->heads);
 	struct drm_device *dev = outp->base.base.dev;
@@ -1250,7 +1250,7 @@ nv50_mstm_new(struct nouveau_encoder *outp, struct drm_dp_aux *aux, int aux_max,
 	mstm->mgr.cbs = &nv50_mstm;
 
 	ret = drm_dp_mst_topology_mgr_init(&mstm->mgr, dev, aux, aux_max,
-					   max_payloads, conn_base_id);
+					   max_payloads, connector);
 	if (ret)
 		return ret;
 
@@ -1496,7 +1496,7 @@ nv50_sor_create(struct drm_connector *connector, struct dcb_output *dcbe)
 		if ((data = nvbios_dp_table(bios, &ver, &hdr, &cnt, &len)) &&
 		    ver >= 0x40 && (nvbios_rd08(bios, data + 0x08) & 0x04)) {
 			ret = nv50_mstm_new(nv_encoder, &nv_connector->aux, 16,
-					    nv_connector->base.base.id,
+					    &nv_connector->base,
 					    &nv_encoder->dp.mstm);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index f920be236cc9..3c66b1d26f88 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -664,7 +664,7 @@ radeon_dp_mst_init(struct radeon_connector *radeon_connector)
 	radeon_connector->mst_mgr.cbs = &mst_cbs;
 	return drm_dp_mst_topology_mgr_init(&radeon_connector->mst_mgr, dev,
 					    &radeon_connector->ddc_bus->aux, 16, 6,
-					    radeon_connector->base.base.id);
+					    &radeon_connector->base);
 }
 
 int
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 7f78d26a0766..ef8ba093ae8a 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -573,7 +573,8 @@ struct drm_dp_mst_topology_mgr {
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_device *dev, struct drm_dp_aux *aux,
 				 int max_dpcd_transaction_bytes,
-				 int max_payloads, int conn_base_id);
+				 int max_payloads,
+				 struct drm_connector *connector);
 
 void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
 
-- 
2.17.1


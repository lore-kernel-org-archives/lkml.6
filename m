Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998262145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w8vPqhKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998262145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbeKOIrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbeKOI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C90322526;
        Wed, 14 Nov 2018 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234138;
        bh=86JQTgCPodnhLMkIVBm2L9gTKCpPxCYdHnCx3Id9d/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8vPqhKVCpfB0cleVpxCZ2nFcqUHvIiP5oYuYtzN4AKkrW+GTvxRHWhzDGgzkPB1F
         GogkZWhGADQSwF/vX2TjwbbK32TyaPM8R7flZvUuM7C74qHkB3Yms+bPOzgq3L+Bl3
         3pAcOfeotJ3sNpHjbzuORi6lqN0FVPxgA0TFmQzU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 42/73] drm/amd/display: Drop reusing drm connector for MST
Date:   Wed, 14 Nov 2018 17:21:36 -0500
Message-Id: <20181114222207.98701-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>

[ Upstream commit 0e6613e46fed29316f33acf86e1d1568288638b5 ]

[why]
It is not safe to keep existing connector while entire topology
has been removed. Could lead potential impact to uapi.
Entirely unregister all the connectors on the topology,
and use a new set of connectors when the topology is plugged back
on.

[How]
Remove the drm connector entirely each time when the
corresponding MST topology is gone.
When hotunplug a connector (e.g., DP2)
1. Remove connector from userspace.
2. Drop it's reference.
When hotplug back on:
1. Detect new topology, and create new connectors.
2. Notify userspace with sysfs hotplug event.
3. Reprobe new connectors, and reassign CRTC from old (e.g., DP2)
to new (e.g., DP3) connector.

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 40 ++++---------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a29dc35954c9..aba2c5c1d2f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -173,8 +173,6 @@ struct amdgpu_dm_connector {
 	struct mutex hpd_lock;
 
 	bool fake_enable;
-
-	bool mst_connected;
 };
 
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a300732ba37..4b08359e18bd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -352,25 +352,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		aconnector = to_amdgpu_dm_connector(connector);
-		if (aconnector->mst_port == master
-				&& !aconnector->port) {
-			DRM_INFO("DM_MST: reusing connector: %p [id: %d] [master: %p]\n",
-						aconnector, connector->base.id, aconnector->mst_port);
-
-			aconnector->port = port;
-			drm_connector_set_path_property(connector, pathprop);
-
-			drm_connector_list_iter_end(&conn_iter);
-			aconnector->mst_connected = true;
-			return &aconnector->base;
-		}
-	}
-	drm_connector_list_iter_end(&conn_iter);
 
 	aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 	if (!aconnector)
@@ -419,8 +400,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	 */
 	amdgpu_dm_connector_funcs_reset(connector);
 
-	aconnector->mst_connected = true;
-
 	DRM_INFO("DM_MST: added connector: %p [id: %d] [master: %p]\n",
 			aconnector, connector->base.id, aconnector->mst_port);
 
@@ -432,6 +411,9 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 static void dm_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 					struct drm_connector *connector)
 {
+	struct amdgpu_dm_connector *master = container_of(mgr, struct amdgpu_dm_connector, mst_mgr);
+	struct drm_device *dev = master->base.dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 	DRM_INFO("DM_MST: Disabling connector: %p [id: %d] [master: %p]\n",
@@ -445,7 +427,10 @@ static void dm_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 		aconnector->dc_sink = NULL;
 	}
 
-	aconnector->mst_connected = false;
+	drm_connector_unregister(connector);
+	if (adev->mode_info.rfbdev)
+		drm_fb_helper_remove_one_connector(&adev->mode_info.rfbdev->helper, connector);
+	drm_connector_put(connector);
 }
 
 static void dm_dp_mst_hotplug(struct drm_dp_mst_topology_mgr *mgr)
@@ -456,18 +441,10 @@ static void dm_dp_mst_hotplug(struct drm_dp_mst_topology_mgr *mgr)
 	drm_kms_helper_hotplug_event(dev);
 }
 
-static void dm_dp_mst_link_status_reset(struct drm_connector *connector)
-{
-	mutex_lock(&connector->dev->mode_config.mutex);
-	drm_connector_set_link_status_property(connector, DRM_MODE_LINK_STATUS_BAD);
-	mutex_unlock(&connector->dev->mode_config.mutex);
-}
-
 static void dm_dp_mst_register_connector(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = dev->dev_private;
-	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 	if (adev->mode_info.rfbdev)
 		drm_fb_helper_add_one_connector(&adev->mode_info.rfbdev->helper, connector);
@@ -475,9 +452,6 @@ static void dm_dp_mst_register_connector(struct drm_connector *connector)
 		DRM_ERROR("adev->mode_info.rfbdev is NULL\n");
 
 	drm_connector_register(connector);
-
-	if (aconnector->mst_connected)
-		dm_dp_mst_link_status_reset(connector);
 }
 
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
-- 
2.17.1


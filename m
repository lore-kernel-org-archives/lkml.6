Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF552133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5ClolFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF552133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeK2RCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:41 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D061F208E7;
        Thu, 29 Nov 2018 05:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471110;
        bh=CePCCgcHC8XyuAPJb9335ZD4fWjQ2dDR+xNkVLb3+TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5ClolFj+t/6CArfeEtw0SdSJmmLk2VbrwZAWdBh2DCF4jQcTepMYOHe0HAPg0LMe
         t2BGGBpXPcEBMv3RYqCjCEGLUZqzB19itk8CxK6RQ6/COcNXoioiTqCd3PywZng1km
         7Xeu9pk67JB0i421ip8WoRFRZR8OrN+pYlE87SvU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 28/68] drm/amd/display: Support amdgpu "max bpc" connector property (v2)
Date:   Thu, 29 Nov 2018 00:55:19 -0500
Message-Id: <20181129055559.159228-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 07e3a1cfb0568b6d8d7862077029af96af6690ea ]

[Why]
Many panels support more than 8bpc but some modes are unavailable while
running at greater than 8bpc due to DP/HDMI bandwidth constraints.

Support for more than 8bpc was added recently in the driver but it
defaults to the maximum supported bpc - locking out these modes.

This should be a user configurable option such that the user can select
what bpc configuration they would like.

[How]
This patch adds support for getting and setting the amdgpu driver
specific "max bpc" property on the connector.

It also adds support for limiting the output bpc based on the property
value. The default limitation is the lowest value in the range, 8bpc.
This was the old value before the range was uncapped.

This patch should be updated/replaced later once common drm support
for max bpc lands.

Bugzilla: https://bugs.freedesktop.org/108542
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201585
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200645
Fixes: e03fd3f300f6 ("drm/amd/display: Do not limit color depth to 8bpc")

v2: rebase on upstream (Alex)

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ef5c6af4d964..299def84e69c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2213,8 +2213,15 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 static enum dc_color_depth
 convert_color_depth_from_display_info(const struct drm_connector *connector)
 {
+	struct dm_connector_state *dm_conn_state =
+		to_dm_connector_state(connector->state);
 	uint32_t bpc = connector->display_info.bpc;
 
+	/* TODO: Remove this when there's support for max_bpc in drm */
+	if (dm_conn_state && bpc > dm_conn_state->max_bpc)
+		/* Round down to nearest even number. */
+		bpc = dm_conn_state->max_bpc - (dm_conn_state->max_bpc & 1);
+
 	switch (bpc) {
 	case 0:
 		/* Temporary Work around, DRM don't parse color depth for
@@ -2796,6 +2803,9 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 	} else if (property == adev->mode_info.underscan_property) {
 		dm_new_state->underscan_enable = val;
 		ret = 0;
+	} else if (property == adev->mode_info.max_bpc_property) {
+		dm_new_state->max_bpc = val;
+		ret = 0;
 	}
 
 	return ret;
@@ -2838,6 +2848,9 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	} else if (property == adev->mode_info.underscan_property) {
 		*val = dm_state->underscan_enable;
 		ret = 0;
+	} else if (property == adev->mode_info.max_bpc_property) {
+		*val = dm_state->max_bpc;
+		ret = 0;
 	}
 	return ret;
 }
@@ -3658,6 +3671,9 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	drm_object_attach_property(&aconnector->base.base,
 				adev->mode_info.underscan_vborder_property,
 				0);
+	drm_object_attach_property(&aconnector->base.base,
+				adev->mode_info.max_bpc_property,
+				0);
 
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index aba2c5c1d2f8..74aedcffc4bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -213,6 +213,7 @@ struct dm_connector_state {
 	enum amdgpu_rmx_type scaling;
 	uint8_t underscan_vborder;
 	uint8_t underscan_hborder;
+	uint8_t max_bpc;
 	bool underscan_enable;
 	struct mod_freesync_user_enable user_enable;
 	bool freesync_capable;
-- 
2.17.1


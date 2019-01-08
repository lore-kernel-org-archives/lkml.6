Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF186C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4902064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977462;
	bh=3zs8NCRUHIFi3qMzVG9YE1aoXbGC40gGAPDsWzyXTnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NIe3PCi4M+WaI/hXMuaZwrB7dVr3y8t1aann812nBJIX9UuHahUNztzQlTjUuKKqI
	 bldYmh2xF/d6W6aQGtpYUY5Sd5juUrvKw3XA+OuMg6MqhfdoGxKCZQxcx3rZAAFiEp
	 Oj3BOj7B3z9ASUlZA/2ipFlwf4PjA7Z0TO31g3hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfAHT5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfAHT34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2604B20665;
        Tue,  8 Jan 2019 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975795;
        bh=3zs8NCRUHIFi3qMzVG9YE1aoXbGC40gGAPDsWzyXTnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R81FxtG2cufK8w04k6PMY5U9+gdV0VpawIlpnjRgDzApADun/dUTMbXGC8HWaQeUJ
         bvoNca1FFKWOV4yVwkQUD8O7c36j/dKKlzWgyh/LOJywZouC0uolB+oQv4hbE6moWx
         wF4cozzC23Y8J5XSDdpFqx1x1wPxkk1aWgkR+too=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 03/97] drm/amd/display: Guard against null stream_state in set_crc_source
Date:   Tue,  8 Jan 2019 14:28:12 -0500
Message-Id: <20190108192949.122407-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit f41a895026b8cb6f765190de7d2e7bc3ccbbd183 ]

[Why]

The igt@kms_plane@pixel-format-pipe tests can create a sequence where
stream_state is NULL during amdgpu_dm_crtc_set_crc_source which results
in a null pointer dereference.

[How]

Guard against stream_state being NULL before accessing its fields. This
doesn't fix the root cause of the issue so a DRM_ERROR is generated
to still fail the tests.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: David Francis <David.Francis@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 9bfb040352e9..6a6d977ddd7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -60,6 +60,11 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name,
 		return -EINVAL;
 	}
 
+	if (!stream_state) {
+		DRM_ERROR("No stream state for CRTC%d\n", crtc->index);
+		return -EINVAL;
+	}
+
 	/* When enabling CRC, we should also disable dithering. */
 	if (source == AMDGPU_DM_PIPE_CRC_SOURCE_AUTO) {
 		if (dc_stream_configure_crc(stream_state->ctx->dc,
-- 
2.19.1


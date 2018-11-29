Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDF1208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cITnVz8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDF1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeK2RCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:29 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98407205C9;
        Thu, 29 Nov 2018 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471099;
        bh=yosf/Fv/70HIq7HXF9Clhe977oF49BT16IXjGwBwhkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cITnVz8uN8ZxOObmTtI2fYdata+0s1Qne78JuFd8sO7oxTc77xsDrhwqJiIU0BymY
         RWEK6vKiZ3AQZ2nS/7MHr+nNCjN2TBEJvVLIy6EYB1q0Eiy1850R3/VbcdasU+ZXpY
         WoH562zWSY4+5ALCsoueAfzaLqScccPeaXtnC38A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 27/68] drm/amdgpu: Add amdgpu "max bpc" connector property (v2)
Date:   Thu, 29 Nov 2018 00:55:18 -0500
Message-Id: <20181129055559.159228-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 69756c6ff0de478c10100481f16c966dde3b5339 ]

[Why]
Many panels support more than 8bpc but some modes are unavailable while
running at greater than 8bpc due to DP/HDMI bandwidth constraints.

Support for more than 8bpc was added recently in the driver but it
defaults to the maximum supported bpc - locking out these modes.

This should be a user configurable option such that the user can select
what bpc configuration they would like.

[How]
This patch introduces the "max bpc" amdgpu driver specific connector
property so the user can limit the maximum bpc. It ranges from 8 to 16.

This doesn't directly set the preferred bpc for the panel since it
follows Intel's existing driver conventions.

This proprety should be removed once common drm support for max bpc
lands.

v2: rebase on upstream (Alex)

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 6748cd7fc129..686a26de50f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -626,6 +626,13 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 					 "dither",
 					 amdgpu_dither_enum_list, sz);
 
+	if (amdgpu_device_has_dc_support(adev)) {
+		adev->mode_info.max_bpc_property =
+			drm_property_create_range(adev->ddev, 0, "max bpc", 8, 16);
+		if (!adev->mode_info.max_bpc_property)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index b9e9e8b02fb7..d1b4d9b6aae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -339,6 +339,8 @@ struct amdgpu_mode_info {
 	struct drm_property *audio_property;
 	/* FMT dithering */
 	struct drm_property *dither_property;
+	/* maximum number of bits per channel for monitor color */
+	struct drm_property *max_bpc_property;
 	/* hardcoded DFP edid from BIOS */
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
-- 
2.17.1


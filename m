Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C45C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB92063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976546;
	bh=1uAFkiBROQ8jM2iNyBJR21aRUVNkwuA3a/6KKjj/MAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ym+pBerRSGXhssXVszoV/3gvL1V3hvqHxhvq7+6n43E/ELEwsqP1fm8+Ib3KnyHXJ
	 2JKRscHHGqGYZKGOxkyfpUYAE5h3s2bR3Lvl+SS7dS28Z4bnIOS3C4NJu6efelUZVn
	 dKAWq/2eJUWjbaAoeRCZfPfdkMxuLxmSxAZofhnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfAHTmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731877AbfAHTeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:34:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF76A2063F;
        Tue,  8 Jan 2019 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976046;
        bh=1uAFkiBROQ8jM2iNyBJR21aRUVNkwuA3a/6KKjj/MAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKckTDjHuxG+gZOZJrpCh4N2HTng269I+FtNfE7Sul2BseAvwFvi+xm7o6NbpoIpf
         SFYcUZQGlNhEx6+zzw1e7FI/6o1mJOGsLSmG6+Srd42YZcWv/t2g/gYP28YepFj7Q/
         vc6I8dowtqIV/8wYUGJfpsuFXfw5g39R9rrNU2lk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 10/36] drm/amdgpu: Correct get_crtc_scanoutpos behavior when vpos >= vtotal
Date:   Tue,  8 Jan 2019 14:33:22 -0500
Message-Id: <20190108193348.123880-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 520f08df45fbe300ed650da786a74093d658b7e1 ]

When variable refresh rate is active the hardware counter can return
a position >= vtotal. This results in a vpos being returned from
amdgpu_display_get_crtc_scanoutpos that's a positive value. The
positive value indicates to the caller that the display is
currently in scanout when the display is actually still in vblank.

This is because the vfront porch duration is unknown with variable
refresh active and will end when either a page flip occurs or the
timeout specified by the driver/display is reached.

The behavior of the amdgpu_display_get_crtc_scanoutpos remains the
same when the position is below vtotal. When the position is above
vtotal the function will return a value that is effectively -vbl_end,
the size of the vback porch.

The only caller affected by this change is the DRM helper for
calculating vblank timestamps. This change corrects behavior for
calculating the page flip timestamp from being the previous timestamp
to the calculation to the next timestamp when position >= vtotal.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 15a2d8f3725d..5042ae072386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -856,7 +856,12 @@ int amdgpu_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	/* Inside "upper part" of vblank area? Apply corrective offset if so: */
 	if (in_vbl && (*vpos >= vbl_start)) {
 		vtotal = mode->crtc_vtotal;
-		*vpos = *vpos - vtotal;
+
+		/* With variable refresh rate displays the vpos can exceed
+		 * the vtotal value. Clamp to 0 to return -vbl_end instead
+		 * of guessing the remaining number of lines until scanout.
+		 */
+		*vpos = (*vpos < vtotal) ? (*vpos - vtotal) : 0;
 	}
 
 	/* Correct for shifted end of vbl at vbl_end. */
-- 
2.19.1


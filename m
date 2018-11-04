Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7EDC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E320685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMnAax50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9E320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeKDXHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbeKDXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C04621104;
        Sun,  4 Nov 2018 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339532;
        bh=rgA70eMr4IijAgMCSAF3phuFedc2aN1FpLQVW8IhqcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMnAax50pCYpVgqaaDKqnVSlQJyf1kBuo9EaRhIX4cI4m9l0OTXQwbC56KcsfsE/h
         ADYaPRJMPtz3axCz5Ud0cnYN9QaAzrIS1keeGMsipvGwye9bvWLImvm6m9zgFp1WLu
         9X1bHMhuztKTcuVz1s2Tjmq+e6t14gvPZ0TEhe5g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 26/57] drm/msm: dpu: Allow planes to extend past active display
Date:   Sun,  4 Nov 2018 08:51:13 -0500
Message-Id: <20181104135144.88324-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 96fc56a775c1e44c0e3c0119f2cd3d77431c4569 ]

The atomic_check is a bit too aggressive with respect to planes which
leave the active area. This caused a bunch of log spew when the cursor
got to the edge of the screen and stopped it from going all the way.

This patch removes the conservative bounds checks from atomic and clips
the dst rect such that we properly display planes which go off the
screen.

Changes in v2:
- Apply the clip to src as well (taking into account scaling)
Changes in v3:
- Use drm_atomic_helper_check_plane_state() to clip src/dst

Cc: Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>

Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c   |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c  | 34 +++++++++++++---------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c |  1 -
 drivers/gpu/drm/msm/msm_drv.h              |  2 ++
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 80cbf75bc2ff..cd02eae884cc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1535,8 +1535,7 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 		cnt++;
 
 		dst = drm_plane_state_dest(pstate);
-		if (!drm_rect_intersect(&clip, &dst) ||
-		    !drm_rect_equals(&clip, &dst)) {
+		if (!drm_rect_intersect(&clip, &dst)) {
 			DPU_ERROR("invalid vertical/horizontal destination\n");
 			DPU_ERROR("display: " DRM_RECT_FMT " plane: "
 				  DRM_RECT_FMT "\n", DRM_RECT_ARG(&crtc_rect),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index b640e39ebaca..4ac2b0c669b7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1254,7 +1254,7 @@ static int dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 	const struct dpu_format *fmt;
 	struct drm_crtc *crtc;
 	struct drm_framebuffer *fb;
-	struct drm_rect src, dst;
+	int ret, min_scale;
 
 	if (!plane) {
 		DPU_ERROR("invalid plane\n");
@@ -1293,21 +1293,29 @@ static int dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 	pdpu->is_rt_pipe = (dpu_crtc_get_client_type(crtc) != NRT_CLIENT);
 	_dpu_plane_set_qos_ctrl(plane, false, DPU_PLANE_QOS_PANIC_CTRL);
 
-	src.x1 = state->src_x >> 16;
-	src.y1 = state->src_y >> 16;
-	src.x2 = src.x1 + (state->src_w >> 16);
-	src.y2 = src.y1 + (state->src_h >> 16);
+	min_scale = FRAC_16_16(1, pdpu->pipe_sblk->maxdwnscale);
+	ret = drm_atomic_helper_check_plane_state(state, crtc->state, min_scale,
+					  pdpu->pipe_sblk->maxupscale << 16,
+					  true, false);
+	if (ret) {
+		DPU_ERROR_PLANE(pdpu, "Check plane state failed (%d)\n", ret);
+		return ret;
+	}
 
-	dst = drm_plane_state_dest(state);
+	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
+			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
+			crtc->base.id, DRM_RECT_ARG(&state->dst),
+			(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
 
-	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FMT "->crtc%u " DRM_RECT_FMT
-			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_ARG(&src),
-			crtc->base.id, DRM_RECT_ARG(&dst),
-			(char *)&fmt->base.pixel_format,
-			DPU_FORMAT_IS_UBWC(fmt));
+	pdpu->pipe_cfg.src_rect = state->src;
+
+	/* state->src is 16.16, src_rect is not */
+	pdpu->pipe_cfg.src_rect.x1 >>= 16;
+	pdpu->pipe_cfg.src_rect.x2 >>= 16;
+	pdpu->pipe_cfg.src_rect.y1 >>= 16;
+	pdpu->pipe_cfg.src_rect.y2 >>= 16;
 
-	pdpu->pipe_cfg.src_rect = src;
-	pdpu->pipe_cfg.dst_rect = dst;
+	pdpu->pipe_cfg.dst_rect = state->dst;
 
 	_dpu_plane_setup_scaler(pdpu, pstate, fmt, false);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 7d306c5acd09..273cbbe27c2e 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -259,7 +259,6 @@ static void mdp5_plane_cleanup_fb(struct drm_plane *plane,
 	msm_framebuffer_cleanup(fb, kms->aspace);
 }
 
-#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
 static int mdp5_plane_atomic_check_with_state(struct drm_crtc_state *crtc_state,
 					      struct drm_plane_state *state)
 {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 8e510d5c758a..9d11f321f5a9 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -62,6 +62,8 @@ struct msm_gem_vma;
 #define MAX_BRIDGES    8
 #define MAX_CONNECTORS 8
 
+#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
+
 struct msm_file_private {
 	rwlock_t queuelock;
 	struct list_head submitqueues;
-- 
2.17.1


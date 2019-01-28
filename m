Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF22E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697977;
	bh=4f6PF922jSX8/OFpN44E86hy3HF0IvgZoNTBmwfcvoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GW7gKpe2MWTFjagAoi7x3q4toYXavg4FoF+pO/mWDQiFtEZFKNxZSDAgPWtGVKW7R
	 8FGrF8GnkiQTNhwwq/zu9Mxt09CgrDgSqt6IAz4ZAQenJ+ydbuwHPxbm4mz1Y/mCdX
	 FlvHPF//a62c+AUCt5eiZwhyPpDBGz54iRhyRRDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfA1Pns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Pnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10CA21738;
        Mon, 28 Jan 2019 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690224;
        bh=4f6PF922jSX8/OFpN44E86hy3HF0IvgZoNTBmwfcvoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/PNiJ0e24uSHSx2/F4+nN+yxrBHMNIMgVkbslRKFjVJQbRmA6dUnsEu99jL/Mley
         +9PhgfX+YjjApOcUtKOWnN5d69fvmcUPRaANkhXdzu7aowtFV+9szVGVTDiu5WlUVl
         DB/r5rwfi93l/bpm05vElHX3r01eQ1seOCL9Kcsc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 002/304] drm/v3d: Fix a use-after-free race accessing the scheduler's fences.
Date:   Mon, 28 Jan 2019 10:38:39 -0500
Message-Id: <20190128154341.47195-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 34c2c4f632f232ed2fdb66d4e42cc72d322273fe ]

Once we push the job, the scheduler could run it and free it.  So, if
we want to reference their fences, we need to grab them before then.
I haven't seen this happen in many days of conformance test runtime,
but let's still close the race.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Link: https://patchwork.freedesktop.org/patch/254119/
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index e6fed696ad86..cbe5be0c47eb 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -198,6 +198,11 @@ struct v3d_exec_info {
 	 */
 	struct dma_fence *bin_done_fence;
 
+	/* Fence for when the scheduler considers the render to be
+	 * done, for when the BOs reservations should be complete.
+	 */
+	struct dma_fence *render_done_fence;
+
 	struct kref refcount;
 
 	/* This is the array of BOs that were looked up at the start of exec. */
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 70c54774400b..2814c72cb090 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -209,7 +209,7 @@ v3d_flush_caches(struct v3d_dev *v3d)
 static void
 v3d_attach_object_fences(struct v3d_exec_info *exec)
 {
-	struct dma_fence *out_fence = &exec->render.base.s_fence->finished;
+	struct dma_fence *out_fence = exec->render_done_fence;
 	struct v3d_bo *bo;
 	int i;
 
@@ -409,6 +409,7 @@ v3d_exec_cleanup(struct kref *ref)
 	dma_fence_put(exec->render.done_fence);
 
 	dma_fence_put(exec->bin_done_fence);
+	dma_fence_put(exec->render_done_fence);
 
 	for (i = 0; i < exec->bo_count; i++)
 		drm_gem_object_put_unlocked(&exec->bo[i]->base);
@@ -572,6 +573,9 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
+	exec->render_done_fence =
+		dma_fence_get(&exec->render.base.s_fence->finished);
+
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
@@ -585,7 +589,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
 	if (sync_out) {
 		drm_syncobj_replace_fence(sync_out, 0,
-					  &exec->render.base.s_fence->finished);
+					  exec->render_done_fence);
 		drm_syncobj_put(sync_out);
 	}
 
-- 
2.19.1


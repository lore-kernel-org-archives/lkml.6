Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95736C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C1121B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901714;
	bh=AGGpVywKLrfu/so+5Ht/5dxtWC0TGQQ7M97O1qMuMZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1SbmlBkNtDO9jYxQKFjCepa2x+4Myu2v6vCG0vA9lI1c+ZkZcTF5/wQdpuCbJveB
	 MeUi8tFW60g+5koPeca+gssVpYAy+3YmUc1iBKKYzavIqqiLdRi6nLh3RoYTUdOJMi
	 /VondSy+40hd1v4cQpelxreRrbWHTxHk8CtdXy9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfBKQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfBKOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:20:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1522073F;
        Mon, 11 Feb 2019 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894855;
        bh=AGGpVywKLrfu/so+5Ht/5dxtWC0TGQQ7M97O1qMuMZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6vzUa9yYsItYOt43X/+l0CkMQpRqEFz5YoFGCPIeYya0OCyb76ofKL81WbS3+0Jr
         taLMSVqRAKoQHc/1qngVLlnJrYrORIyY99/zRFWojtzQ2eonItgGVL2HfjLv1MkrBJ
         9+MmpPS9XgqUbRDms8fAUwhVre6uwyZT5WCB1b34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 002/352] drm/v3d: Fix a use-after-free race accessing the schedulers fences.
Date:   Mon, 11 Feb 2019 15:13:49 +0100
Message-Id: <20190211141846.670909263@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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




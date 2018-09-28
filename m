Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47BBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A101D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A101D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeI2Frb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:47:31 -0400
Received: from anholt.net ([50.246.234.109]:45446 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeI2Frb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:47:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1427D10A1AF1;
        Fri, 28 Sep 2018 16:21:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DkX1X_iNQ64i; Fri, 28 Sep 2018 16:21:28 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0253310A1504;
        Fri, 28 Sep 2018 16:21:27 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DDF462FE1B40; Fri, 28 Sep 2018 16:21:26 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm/v3d: Fix a use-after-free race accessing the scheduler's fences.
Date:   Fri, 28 Sep 2018 16:21:23 -0700
Message-Id: <20180928232126.4332-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we push the job, the scheduler could run it and free it.  So, if
we want to reference their fences, we need to grab them before then.
I haven't seen this happen in many days of conformance test runtime,
but let's still close the race.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
---
 drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 5042573e97f4..83c55ab6e1c0 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -204,6 +204,11 @@ struct v3d_exec_info {
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
index e1fcbb4cd0ae..c98fbfbdb68e 100644
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
@@ -574,6 +575,9 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail_unreserve;
 
+	exec->render_done_fence =
+		dma_fence_get(&exec->render.base.s_fence->finished);
+
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
@@ -587,7 +591,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
 	if (sync_out) {
 		drm_syncobj_replace_fence(sync_out,
-					  &exec->render.base.s_fence->finished);
+					  exec->render_done_fence);
 		drm_syncobj_put(sync_out);
 	}
 
-- 
2.18.0


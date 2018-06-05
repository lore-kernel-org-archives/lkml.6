Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeFETDL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:03:11 -0400
Received: from anholt.net ([50.246.234.109]:40576 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeFETDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:03:09 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        amd-gfx@lists.freedesktop.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/3] drm/v3d: Remove the bad signaled() implementation.
Date: Tue,  5 Jun 2018 12:03:01 -0700
Message-Id: <20180605190302.18279-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180605190302.18279-1-eric@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since our seqno value comes from a counter associated with the GPU
ring, not the entity (aka client), they'll be completed out of order.
There's actually no need for this code at all, since we don't have
enable_signaling() and thus DMA_FENCE_SIGNALED_BIT will be set before
we could be called.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.h   |  1 -
 drivers/gpu/drm/v3d/v3d_fence.c | 13 ++++---------
 drivers/gpu/drm/v3d/v3d_gem.c   |  7 ++-----
 drivers/gpu/drm/v3d/v3d_irq.c   |  3 ---
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 26005abd9c5d..f32ac8c98f37 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -25,7 +25,6 @@ struct v3d_queue_state {
 
 	u64 fence_context;
 	u64 emit_seqno;
-	u64 finished_seqno;
 };
 
 struct v3d_dev {
diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
index 087d49c8cb12..bfe31a89668b 100644
--- a/drivers/gpu/drm/v3d/v3d_fence.c
+++ b/drivers/gpu/drm/v3d/v3d_fence.c
@@ -40,19 +40,14 @@ static bool v3d_fence_enable_signaling(struct dma_fence *fence)
 	return true;
 }
 
-static bool v3d_fence_signaled(struct dma_fence *fence)
-{
-	struct v3d_fence *f = to_v3d_fence(fence);
-	struct v3d_dev *v3d = to_v3d_dev(f->dev);
-
-	return v3d->queue[f->queue].finished_seqno >= f->seqno;
-}
-
 const struct dma_fence_ops v3d_fence_ops = {
 	.get_driver_name = v3d_fence_get_driver_name,
 	.get_timeline_name = v3d_fence_get_timeline_name,
 	.enable_signaling = v3d_fence_enable_signaling,
-	.signaled = v3d_fence_signaled,
+	/* Each of our fences gets signaled as complete by the IRQ
+	 * handler, so we rely on the core's tracking of signaling.
+	 */
+	.signaled = NULL,
 	.wait = dma_fence_default_wait,
 	.release = dma_fence_free,
 };
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 9ea83bdb9a30..d06d6697e089 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -657,17 +657,14 @@ void
 v3d_gem_destroy(struct drm_device *dev)
 {
 	struct v3d_dev *v3d = to_v3d_dev(dev);
-	enum v3d_queue q;
 
 	v3d_sched_fini(v3d);
 
 	/* Waiting for exec to finish would need to be done before
 	 * unregistering V3D.
 	 */
-	for (q = 0; q < V3D_MAX_QUEUES; q++) {
-		WARN_ON(v3d->queue[q].emit_seqno !=
-			v3d->queue[q].finished_seqno);
-	}
+	WARN_ON(v3d->bin_job);
+	WARN_ON(v3d->render_job);
 
 	drm_mm_takedown(&v3d->mm);
 
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 77e1fa046c10..e07514eb11b5 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -87,15 +87,12 @@ v3d_irq(int irq, void *arg)
 	}
 
 	if (intsts & V3D_INT_FLDONE) {
-		v3d->queue[V3D_BIN].finished_seqno++;
 		dma_fence_signal(v3d->bin_job->bin.done_fence);
 		status = IRQ_HANDLED;
 	}
 
 	if (intsts & V3D_INT_FRDONE) {
-		v3d->queue[V3D_RENDER].finished_seqno++;
 		dma_fence_signal(v3d->render_job->render.done_fence);
-
 		status = IRQ_HANDLED;
 	}
 
-- 
2.17.0

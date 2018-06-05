Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeFETDH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:03:07 -0400
Received: from anholt.net ([50.246.234.109]:40558 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeFETDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:03:06 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        amd-gfx@lists.freedesktop.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/3] drm/v3d: Take a lock across GPU scheduler job creation and queuing.
Date: Tue,  5 Jun 2018 12:03:00 -0700
Message-Id: <20180605190302.18279-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between creation and queueing of a job, you need to prevent any other
job from being created and queued.  Otherwise the scheduler's fences
may be signaled out of seqno order.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
---

ccing amd-gfx due to interaction of this series with the scheduler.

 drivers/gpu/drm/v3d/v3d_drv.h |  5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index a043ac3aae98..26005abd9c5d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -85,6 +85,11 @@ struct v3d_dev {
 	 */
 	struct mutex reset_lock;
 
+	/* Lock taken when creating and pushing the GPU scheduler
+	 * jobs, to keep the sched-fence seqnos in order.
+	 */
+	struct mutex sched_lock;
+
 	struct {
 		u32 num_allocated;
 		u32 pages_allocated;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index b513f9189caf..9ea83bdb9a30 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -550,13 +550,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
+	mutex_lock(&v3d->sched_lock);
 	if (exec->bin.start != exec->bin.end) {
 		ret = drm_sched_job_init(&exec->bin.base,
 					 &v3d->queue[V3D_BIN].sched,
 					 &v3d_priv->sched_entity[V3D_BIN],
 					 v3d_priv);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&v3d->sched_lock);
 			goto fail_unreserve;
+		}
 
 		exec->bin_done_fence =
 			dma_fence_get(&exec->bin.base.s_fence->finished);
@@ -570,12 +573,15 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 				 &v3d->queue[V3D_RENDER].sched,
 				 &v3d_priv->sched_entity[V3D_RENDER],
 				 v3d_priv);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&v3d->sched_lock);
 		goto fail_unreserve;
+	}
 
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
+	mutex_unlock(&v3d->sched_lock);
 
 	v3d_attach_object_fences(exec);
 
@@ -615,6 +621,7 @@ v3d_gem_init(struct drm_device *dev)
 	spin_lock_init(&v3d->job_lock);
 	mutex_init(&v3d->bo_lock);
 	mutex_init(&v3d->reset_lock);
+	mutex_init(&v3d->sched_lock);
 
 	/* Note: We don't allocate address 0.  Various bits of HW
 	 * treat 0 as special, such as the occlusion query counters
-- 
2.17.0

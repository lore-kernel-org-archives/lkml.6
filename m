Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2C8B6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeFFRs4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:48:56 -0400
Received: from anholt.net ([50.246.234.109]:49560 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753895AbeFFRsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:48:53 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        amd-gfx@lists.freedesktop.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/3 v2] drm/v3d: Take a lock across GPU scheduler job creation and queuing.
Date: Wed,  6 Jun 2018 10:48:51 -0700
Message-Id: <20180606174851.12433-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <1528274797.26063.6.camel@pengutronix.de>
References: <1528274797.26063.6.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between creation and queueing of a job, you need to prevent any other
job from being created and queued.  Otherwise the scheduler's fences
may be signaled out of seqno order.

v2: move mutex unlock to the error label.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
---
 drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c | 4 ++++
 2 files changed, 9 insertions(+)

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
index b513f9189caf..269fe16379c0 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -550,6 +550,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
+	mutex_lock(&v3d->sched_lock);
 	if (exec->bin.start != exec->bin.end) {
 		ret = drm_sched_job_init(&exec->bin.base,
 					 &v3d->queue[V3D_BIN].sched,
@@ -576,6 +577,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
+	mutex_unlock(&v3d->sched_lock);
 
 	v3d_attach_object_fences(exec);
 
@@ -594,6 +596,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 fail_unreserve:
+	mutex_unlock(&v3d->sched_lock);
 	v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
 fail:
 	v3d_exec_put(exec);
@@ -615,6 +618,7 @@ v3d_gem_init(struct drm_device *dev)
 	spin_lock_init(&v3d->job_lock);
 	mutex_init(&v3d->bo_lock);
 	mutex_init(&v3d->reset_lock);
+	mutex_init(&v3d->sched_lock);
 
 	/* Note: We don't allocate address 0.  Various bits of HW
 	 * treat 0 as special, such as the occlusion query counters
-- 
2.17.0

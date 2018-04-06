Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeDGACW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 20:02:22 -0400
Received: from home.keithp.com ([63.227.221.253]:56914 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDGACU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 20:02:20 -0400
From: Keith Packard <keithp@keithp.com>
To: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Add crtc_queue_syncobj and crtc_get_syncobj ioctls
Date: Fri,  6 Apr 2018 16:56:49 -0700
Message-Id: <20180406235649.9494-2-keithp@keithp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180406235649.9494-1-keithp@keithp.com>
References: <20180406235649.9494-1-keithp@keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crtc_queue_syncobj creates a new syncobj that will get signaled at a
specified vblank sequence count.

crtc_get_syncobj returns the time and vblank sequence count when the
syncobj was signaled.

The pair of these allows use of syncobjs instead of events for
monitoring vblank activity.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 drivers/gpu/drm/drm_file.c     |   5 +
 drivers/gpu/drm/drm_internal.h |   4 +
 drivers/gpu/drm/drm_ioctl.c    |   2 +
 drivers/gpu/drm/drm_syncobj.c  |  13 ++-
 drivers/gpu/drm/drm_vblank.c   | 212 +++++++++++++++++++++++++++++++++++++----
 include/drm/drm_file.h         |  11 ++-
 include/drm/drm_syncobj.h      |  13 +++
 include/uapi/drm/drm.h         |  17 ++++
 8 files changed, 253 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index b3c6e997ccdb..c1ada3fe70b0 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -37,6 +37,7 @@
 
 #include <drm/drm_file.h>
 #include <drm/drmP.h>
+#include <drm/drm_syncobj.h>
 
 #include "drm_legacy.h"
 #include "drm_internal.h"
@@ -711,6 +712,10 @@ void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e)
 		dma_fence_put(e->fence);
 	}
 
+	if (e->syncobj) {
+		drm_syncobj_put(e->syncobj);
+	}
+
 	if (!e->file_priv) {
 		kfree(e);
 		return;
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index c9d5a6cd4d41..71b9435b5b37 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -75,6 +75,10 @@ int drm_crtc_get_sequence_ioctl(struct drm_device *dev, void *data,
 
 int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *filp);
+int drm_crtc_queue_syncobj_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp);
+int drm_crtc_get_syncobj_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp);
 
 /* drm_auth.c */
 int drm_getmagic(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 4aafe4802099..309611fb5d0d 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -665,6 +665,8 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF(DRM_IOCTL_CRTC_GET_SEQUENCE, drm_crtc_get_sequence_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_CRTC_QUEUE_SEQUENCE, drm_crtc_queue_sequence_ioctl, DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_CRTC_QUEUE_SYNCOBJ, drm_crtc_queue_syncobj_ioctl, DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_CRTC_GET_SYNCOBJ, drm_crtc_get_syncobj_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_CREATE_LEASE, drm_mode_create_lease_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_LIST_LESSEES, drm_mode_list_lessees_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GET_LEASE, drm_mode_get_lease_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index cb4d09c70fd4..e197b007079d 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -208,7 +208,7 @@ static const struct dma_fence_ops drm_syncobj_null_fence_ops = {
 	.release = NULL,
 };
 
-static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
+int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj, bool signal)
 {
 	struct drm_syncobj_null_fence *fence;
 	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
@@ -218,7 +218,8 @@ static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
 	spin_lock_init(&fence->lock);
 	dma_fence_init(&fence->base, &drm_syncobj_null_fence_ops,
 		       &fence->lock, 0, 0);
-	dma_fence_signal(&fence->base);
+	if (signal)
+		dma_fence_signal(&fence->base);
 
 	drm_syncobj_replace_fence(syncobj, &fence->base);
 
@@ -226,6 +227,7 @@ static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_syncobj_assign_null_handle);
 
 int drm_syncobj_find_fence(struct drm_file *file_private,
 			   u32 handle,
@@ -283,7 +285,7 @@ int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 	spin_lock_init(&syncobj->lock);
 
 	if (flags & DRM_SYNCOBJ_CREATE_SIGNALED) {
-		ret = drm_syncobj_assign_null_handle(syncobj);
+		ret = drm_syncobj_assign_null_handle(syncobj, true);
 		if (ret < 0) {
 			drm_syncobj_put(syncobj);
 			return ret;
@@ -341,7 +343,7 @@ static int drm_syncobj_create_as_handle(struct drm_file *file_private,
 	return ret;
 }
 
-static int drm_syncobj_destroy(struct drm_file *file_private,
+int drm_syncobj_destroy(struct drm_file *file_private,
 			       u32 handle)
 {
 	struct drm_syncobj *syncobj;
@@ -356,6 +358,7 @@ static int drm_syncobj_destroy(struct drm_file *file_private,
 	drm_syncobj_put(syncobj);
 	return 0;
 }
+EXPORT_SYMBOL(drm_syncobj_destroy);
 
 static int drm_syncobj_file_release(struct inode *inode, struct file *file)
 {
@@ -973,7 +976,7 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 		return ret;
 
 	for (i = 0; i < args->count_handles; i++) {
-		ret = drm_syncobj_assign_null_handle(syncobjs[i]);
+		ret = drm_syncobj_assign_null_handle(syncobjs[i], true);
 		if (ret < 0)
 			break;
 	}
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 32d9bcf5be7f..422a5b1d3b92 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -26,6 +26,7 @@
 
 #include <drm/drm_vblank.h>
 #include <drm/drmP.h>
+#include <drm/drm_syncobj.h>
 #include <linux/export.h>
 
 #include "drm_trace.h"
@@ -806,25 +807,33 @@ static void send_vblank_event(struct drm_device *dev,
 		u64 seq, ktime_t now)
 {
 	struct timespec64 tv;
+	struct drm_syncobj *syncobj = e->base.syncobj;
 
-	switch (e->event.base.type) {
-	case DRM_EVENT_VBLANK:
-	case DRM_EVENT_FLIP_COMPLETE:
-		tv = ktime_to_timespec64(now);
-		e->event.vbl.sequence = seq;
-		/*
-		 * e->event is a user space structure, with hardcoded unsigned
-		 * 32-bit seconds/microseconds. This is safe as we always use
-		 * monotonic timestamps since linux-4.15
-		 */
-		e->event.vbl.tv_sec = tv.tv_sec;
-		e->event.vbl.tv_usec = tv.tv_nsec / 1000;
-		break;
-	case DRM_EVENT_CRTC_SEQUENCE:
+	if (syncobj) {
 		if (seq)
-			e->event.seq.sequence = seq;
-		e->event.seq.time_ns = ktime_to_ns(now);
-		break;
+			syncobj->sequence = seq;
+		syncobj->time = now;
+	}
+	if (e->base.event) {
+		switch (e->event.base.type) {
+		case DRM_EVENT_VBLANK:
+		case DRM_EVENT_FLIP_COMPLETE:
+			tv = ktime_to_timespec64(now);
+			e->event.vbl.sequence = seq;
+			/*
+			 * e->event is a user space structure, with hardcoded unsigned
+			 * 32-bit seconds/microseconds. This is safe as we always use
+			 * monotonic timestamps since linux-4.15
+			 */
+			e->event.vbl.tv_sec = tv.tv_sec;
+			e->event.vbl.tv_usec = tv.tv_nsec / 1000;
+			break;
+		case DRM_EVENT_CRTC_SEQUENCE:
+			if (seq)
+				e->event.seq.sequence = seq;
+			e->event.seq.time_ns = ktime_to_ns(now);
+			break;
+		}
 	}
 	trace_drm_vblank_event_delivered(e->base.file_priv, e->pipe, seq);
 	drm_send_event_locked(dev, &e->base);
@@ -1837,3 +1846,172 @@ int drm_crtc_queue_sequence_ioctl(struct drm_device *dev, void *data,
 	kfree(e);
 	return ret;
 }
+
+/*
+ * Create a syncobj that is signaled when the specified vblank
+ * occurs.
+ */
+int drm_crtc_queue_syncobj_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct drm_crtc *crtc;
+	struct drm_vblank_crtc *vblank;
+	int pipe;
+	struct drm_crtc_queue_syncobj *queue_syncobj = data;
+	ktime_t now;
+	struct drm_pending_vblank_event *e;
+	struct drm_syncobj *syncobj;
+	u32 syncobj_handle;
+	u32 flags;
+	u64 seq;
+	u64 req_seq;
+	int ret;
+	unsigned long spin_flags;
+
+	if (!drm_core_check_feature(dev, DRIVER_MODESET))
+		return -EINVAL;
+
+	if (!dev->irq_enabled)
+		return -EINVAL;
+
+	crtc = drm_crtc_find(dev, file_priv, queue_syncobj->crtc_id);
+	if (!crtc)
+		return -ENOENT;
+
+	flags = queue_syncobj->flags;
+	/* Check valid flag bits */
+	if (flags & ~(DRM_CRTC_SEQUENCE_RELATIVE|
+		      DRM_CRTC_SEQUENCE_NEXT_ON_MISS))
+		return -EINVAL;
+
+	pipe = drm_crtc_index(crtc);
+
+	vblank = &dev->vblank[pipe];
+
+	/*
+	 * Allocate all of the necessary objects --
+	 * a drm_pending_vblank, drm_syncobj, drm_syncobj handle and dma_fence
+	 */
+
+	/* drm_pending_vblank_event */
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (e == NULL)
+		return -ENOMEM;
+
+	/* syncobj */
+	ret = drm_syncobj_create(&syncobj, 0, NULL);
+	if (ret) {
+		DRM_DEBUG("crtc %d failed to allocate syncobj, %d\n", pipe, ret);
+		goto err_free_event;
+	}
+
+	/*
+	 * This allocates the dma_fence object for the syncobj and
+	 * leaves it unsignaled.
+	 */
+	ret = drm_syncobj_assign_null_handle(syncobj, false);
+	if (ret) {
+		DRM_DEBUG("crtc %d failed to allocate syncobj fence, %d\n", pipe, ret);
+		goto err_free_event;
+	}
+
+	/* and finally the syncobj handle to return to user space */
+	ret = drm_syncobj_get_handle(file_priv, syncobj, &syncobj_handle);
+	if (ret) {
+		DRM_DEBUG("crtc %d failed to allocate syncobj handle, %d\n", pipe, ret);
+		goto err_free_syncobj;
+	}
+
+	ret = drm_crtc_vblank_get(crtc);
+	if (ret) {
+		DRM_DEBUG("crtc %d failed to acquire vblank counter, %d\n", pipe, ret);
+		goto err_free_syncobj_handle;
+	}
+
+	seq = drm_vblank_count_and_time(dev, pipe, &now);
+	req_seq = queue_syncobj->sequence;
+
+	if (flags & DRM_CRTC_SEQUENCE_RELATIVE)
+		req_seq += seq;
+
+	if ((flags & DRM_CRTC_SEQUENCE_NEXT_ON_MISS) && vblank_passed(seq, req_seq))
+		req_seq = seq + 1;
+
+	e->pipe = pipe;
+	spin_lock_irqsave(&dev->event_lock, spin_flags);
+
+	/*
+	 * drm_crtc_vblank_off() might have been called after we called
+	 * drm_crtc_vblank_get(). drm_crtc_vblank_off() holds event_lock around the
+	 * vblank disable, so no need for further locking.  The reference from
+	 * drm_crtc_vblank_get() protects against vblank disable from another source.
+	 */
+	if (!READ_ONCE(vblank->enabled)) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	e->base.syncobj = syncobj;
+	e->base.fence = drm_syncobj_fence_get(syncobj);
+
+	list_add(&e->base.pending_link, &file_priv->pending_event_list);
+	e->base.file_priv = file_priv;
+
+	e->sequence = req_seq;
+
+	if (vblank_passed(seq, req_seq)) {
+		drm_crtc_vblank_put(crtc);
+		send_vblank_event(dev, e, seq, now);
+		queue_syncobj->sequence = seq;
+	} else {
+		/* drm_handle_vblank_events will call drm_vblank_put */
+		list_add_tail(&e->base.link, &dev->vblank_event_list);
+		queue_syncobj->sequence = req_seq;
+	}
+
+	spin_unlock_irqrestore(&dev->event_lock, spin_flags);
+
+	/* Pass the syncobj handle back to user space */
+	queue_syncobj->handle = syncobj_handle;
+
+	return 0;
+
+err_unlock:
+	spin_unlock_irqrestore(&dev->event_lock, spin_flags);
+	drm_crtc_vblank_put(crtc);
+err_free_syncobj_handle:
+	drm_syncobj_destroy(file_priv, syncobj_handle);
+err_free_syncobj:
+	drm_syncobj_put(syncobj);
+err_free_event:
+	kfree(e);
+	return ret;
+}
+
+int drm_crtc_get_syncobj_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct drm_crtc_get_syncobj *args = data;
+	struct drm_syncobj *syncobj;
+	struct dma_fence *fence;
+
+	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
+		return -ENODEV;
+
+	syncobj = drm_syncobj_find(file_priv, args->handle);
+	if (!syncobj)
+		return -ENOENT;
+
+	/* If there's no fence, it can't have been signaled */
+	fence = syncobj->fence;
+	if (fence == NULL)
+		return -EBUSY;
+
+	if (!dma_fence_is_signaled(fence))
+		return -EBUSY;
+
+	args->sequence = syncobj->sequence;
+	args->sequence_ns = syncobj->time;
+
+	return 0;
+}
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0e0c868451a5..16de395a2be9 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -106,8 +106,8 @@ struct drm_pending_event {
 	 *
 	 * Pointer to the actual event that should be sent to userspace to be
 	 * read using drm_read(). Can be optional, since nowadays events are
-	 * also used to signal kernel internal threads with @completion or DMA
-	 * transactions using @fence.
+	 * also used to signal kernel internal threads with @completion, DMA
+	 * transactions using @fence or sync objects using @syncobj.
 	 */
 	struct drm_event *event;
 
@@ -119,6 +119,13 @@ struct drm_pending_event {
 	 */
 	struct dma_fence *fence;
 
+	/**
+	 * @syncobj:
+	 *
+	 * Optional Sync Object to signal when the event occurs.
+	 */
+	struct drm_syncobj *syncobj;
+
 	/**
 	 * @file_priv:
 	 *
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 43e2f382d2f0..924f8b880d0c 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -65,6 +65,16 @@ struct drm_syncobj {
 	 * a file backing for this syncobj.
 	 */
 	struct file *file;
+	/**
+	 * @sequence:
+	 * crtc sequence number when a vblank syncobj was signaled
+	 */
+	uint64_t sequence;
+	/**
+	 * @time:
+	 * time that a vblank syncobj was signaled
+	 */
+	ktime_t time;
 };
 
 typedef void (*drm_syncobj_func_t)(struct drm_syncobj *syncobj,
@@ -132,6 +142,7 @@ void drm_syncobj_remove_callback(struct drm_syncobj *syncobj,
 				 struct drm_syncobj_cb *cb);
 void drm_syncobj_replace_fence(struct drm_syncobj *syncobj,
 			       struct dma_fence *fence);
+int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj, bool signal);
 int drm_syncobj_find_fence(struct drm_file *file_private,
 			   u32 handle,
 			   struct dma_fence **fence);
@@ -140,6 +151,8 @@ int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence);
 int drm_syncobj_get_handle(struct drm_file *file_private,
 			   struct drm_syncobj *syncobj, u32 *handle);
+int drm_syncobj_destroy(struct drm_file *file_private,
+			u32 handle);
 int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd);
 
 #endif
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 6fdff5945c8a..7a996f73e972 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -759,6 +759,21 @@ struct drm_crtc_queue_sequence {
 	__u64 user_data;	/* user data passed to event */
 };
 
+struct drm_crtc_queue_syncobj {
+	__u32 crtc_id;
+	__u32 flags;
+	__u64 sequence;
+	__u32 handle;		/* return syncobj handle */
+	__u32 pad;
+};
+
+struct drm_crtc_get_syncobj {
+	__u32 handle;		/* signaled syncobj */
+	__u32 pad;
+	__u64 sequence;		/* return: sequence when syncobj was signaled */
+	__u64 sequence_ns;	/* return: time when syncobj was signaled */
+};
+
 #if defined(__cplusplus)
 }
 #endif
@@ -843,6 +858,8 @@ extern "C" {
 
 #define DRM_IOCTL_CRTC_GET_SEQUENCE	DRM_IOWR(0x3b, struct drm_crtc_get_sequence)
 #define DRM_IOCTL_CRTC_QUEUE_SEQUENCE	DRM_IOWR(0x3c, struct drm_crtc_queue_sequence)
+#define DRM_IOCTL_CRTC_QUEUE_SYNCOBJ	DRM_IOWR(0x3d, struct drm_crtc_queue_syncobj)
+#define DRM_IOCTL_CRTC_GET_SYNCOBJ	DRM_IOWR(0x3e, struct drm_crtc_get_syncobj)
 
 #define DRM_IOCTL_UPDATE_DRAW		DRM_IOW(0x3f, struct drm_update_draw)
 
-- 
2.16.2

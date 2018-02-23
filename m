Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBWNUG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:20:06 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44805 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBWNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:20:01 -0500
X-Google-Smtp-Source: AG47ELvAy5Rpi1LZDogOq7RaYjiVXPkcEkBE8qOdAI5OIlWD9DU6DXFDbYHDYyxU3eNOzwkDozCM1A==
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Rob Clark <robdclark@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/4] drm: writeback: Add out-fences for writeback connectors
Date: Fri, 23 Feb 2018 08:17:52 -0500
Message-Id: <20180223131758.18362-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180223131758.18362-1-robdclark@gmail.com>
References: <20180223131758.18362-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Starkey <brian.starkey@arm.com>

Add the WRITEBACK_OUT_FENCE_PTR property to writeback connectors, to
enable userspace to get a fence which will signal once the writeback is
complete. It is not allowed to request an out-fence without a
framebuffer attached to the connector.

A timeline is added to drm_writeback_connector for use by the writeback
out-fences.

In the case of a commit failure or DRM_MODE_ATOMIC_TEST_ONLY, the fence
is set to -1.

Changes from v2:
 - Rebase onto Gustavo Padovan's v9 explicit sync series
 - Change out_fence_ptr type to s32 __user *
 - Set *out_fence_ptr to -1 in drm_atomic_connector_set_property
 - Store fence in drm_writeback_job
 Gustavo Padovan:
 - Move out_fence_ptr out of connector_state
 - Signal fence from drm_writeback_signal_completion instead of
   in driver directly

Changes from v3:
 - Rebase onto 7e9081c5aac7 drm/fence: fix memory overwrite when setting out_fence fd
   (change out_fence_ptr to s32 __user *, for real this time.)
 - Update documentation around WRITEBACK_OUT_FENCE_PTR

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
[rebased and fixed conflicts]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c    |  99 ++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/drm_writeback.c | 109 +++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h        |   8 +++
 include/drm/drm_connector.h     |   8 +--
 include/drm/drm_mode_config.h   |   8 +++
 include/drm/drm_writeback.h     |  41 ++++++++++++++-
 6 files changed, 257 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 019f131fe8be..fc8c4da409ff 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -318,6 +318,35 @@ static s32 __user *get_out_fence_for_crtc(struct drm_atomic_state *state,
 	return fence_ptr;
 }
 
+static int set_out_fence_for_connector(struct drm_atomic_state *state,
+					struct drm_connector *connector,
+					s32 __user *fence_ptr)
+{
+	unsigned int index = drm_connector_index(connector);
+
+	if (!fence_ptr)
+		return 0;
+
+	if (put_user(-1, fence_ptr))
+		return -EFAULT;
+
+	state->connectors[index].out_fence_ptr = fence_ptr;
+
+	return 0;
+}
+
+static s32 __user *get_out_fence_for_connector(struct drm_atomic_state *state,
+					       struct drm_connector *connector)
+{
+	unsigned int index = drm_connector_index(connector);
+	s32 __user *fence_ptr;
+
+	fence_ptr = state->connectors[index].out_fence_ptr;
+	state->connectors[index].out_fence_ptr = NULL;
+
+	return fence_ptr;
+}
+
 /**
  * drm_atomic_set_mode_for_crtc - set mode for CRTC
  * @state: the CRTC whose incoming state to update
@@ -676,6 +705,12 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
 		return -EINVAL;
 	}
 
+	if (writeback_job->out_fence && !writeback_job->fb) {
+		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] requesting out-fence without framebuffer\n",
+				 connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1277,6 +1312,11 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		if (fb)
 			drm_framebuffer_unreference(fb);
 		return ret;
+	} else if (property == config->writeback_out_fence_ptr_property) {
+		s32 __user *fence_ptr = u64_to_user_ptr(val);
+
+		return set_out_fence_for_connector(state->state, connector,
+						   fence_ptr);
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1361,6 +1401,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 	} else if (property == config->writeback_fb_id_property) {
 		/* Writeback framebuffer is one-shot, write and forget */
 		*val = 0;
+	} else if (property == config->writeback_out_fence_ptr_property) {
+		*val = 0;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
@@ -2221,7 +2263,7 @@ static int setup_out_fence(struct drm_out_fence_state *fence_state,
 	return 0;
 }
 
-static int prepare_crtc_signaling(struct drm_device *dev,
+static int prepare_signaling(struct drm_device *dev,
 				  struct drm_atomic_state *state,
 				  struct drm_mode_atomic *arg,
 				  struct drm_file *file_priv,
@@ -2230,6 +2272,8 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_connector *conn;
+	struct drm_connector_state *conn_state;
 	int i, c = 0, ret;
 
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
@@ -2295,6 +2339,43 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 		c++;
 	}
 
+	for_each_new_connector_in_state(state, conn, conn_state, i) {
+		struct drm_writeback_job *job;
+		struct drm_out_fence_state *f;
+		struct dma_fence *fence;
+		s32 __user *fence_ptr;
+
+		fence_ptr = get_out_fence_for_connector(state, conn);
+		if (!fence_ptr)
+			continue;
+
+		job = drm_atomic_get_writeback_job(conn_state);
+		if (!job)
+			return -ENOMEM;
+
+		f = krealloc(*fence_state, sizeof(**fence_state) *
+			     (*num_fences + 1), GFP_KERNEL);
+		if (!f)
+			return -ENOMEM;
+
+		memset(&f[*num_fences], 0, sizeof(*f));
+
+		f[*num_fences].out_fence_ptr = fence_ptr;
+		*fence_state = f;
+
+		fence = drm_writeback_get_out_fence((struct drm_writeback_connector *)conn);
+		if (!fence)
+			return -ENOMEM;
+
+		ret = setup_out_fence(&f[(*num_fences)++], fence);
+		if (ret) {
+			dma_fence_put(fence);
+			return ret;
+		}
+
+		job->out_fence = fence;
+	}
+
 	/*
 	 * Having this flag means user mode pends on event which will never
 	 * reach due to lack of at least one CRTC for signaling
@@ -2305,11 +2386,11 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 	return 0;
 }
 
-static void complete_crtc_signaling(struct drm_device *dev,
-				    struct drm_atomic_state *state,
-				    struct drm_out_fence_state *fence_state,
-				    unsigned int num_fences,
-				    bool install_fds)
+static void complete_signaling(struct drm_device *dev,
+			       struct drm_atomic_state *state,
+			       struct drm_out_fence_state *fence_state,
+			       unsigned int num_fences,
+			       bool install_fds)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -2488,8 +2569,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_mode_object_put(obj);
 	}
 
-	ret = prepare_crtc_signaling(dev, state, arg, file_priv, &fence_state,
-				     &num_fences);
+	ret = prepare_signaling(dev, state, arg, file_priv, &fence_state,
+				&num_fences);
 	if (ret)
 		goto out;
 
@@ -2507,7 +2588,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 out:
 	drm_atomic_clean_old_fb(dev, plane_mask, ret);
 
-	complete_crtc_signaling(dev, state, fence_state, num_fences, !ret);
+	complete_signaling(dev, state, fence_state, num_fences, !ret);
 
 	if (ret == -EDEADLK) {
 		drm_atomic_state_clear(state);
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index da61f929cbc3..839e79932c19 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -13,6 +13,7 @@
 #include <drm/drm_property.h>
 #include <drm/drm_writeback.h>
 #include <drm/drmP.h>
+#include <linux/dma-fence.h>
 
 /**
  * DOC: overview
@@ -30,6 +31,16 @@
  * framebuffer applies only to a single commit (see below). A framebuffer may
  * not be attached while the CRTC is off.
  *
+ * Unlike with planes, when a writeback framebuffer is removed by userspace DRM
+ * makes no attempt to remove it from active use by the connector. This is
+ * because no method is provided to abort a writeback operation, and in any
+ * case making a new commit whilst a writeback is ongoing is undefined (see
+ * WRITEBACK_OUT_FENCE_PTR below). As soon as the current writeback is finished,
+ * the framebuffer will automatically no longer be in active use. As it will
+ * also have already been removed from the framebuffer list, there will be no
+ * way for any userspace application to retrieve a reference to it in the
+ * intervening period.
+ *
  * Writeback connectors have some additional properties, which userspace
  * can use to query and control them:
  *
@@ -46,8 +57,54 @@
  *	data is an array of u32 DRM_FORMAT_* fourcc values.
  *	Userspace can use this blob to find out what pixel formats are supported
  *	by the connector's writeback engine.
+ *
+ *  "WRITEBACK_OUT_FENCE_PTR":
+ *	Userspace can use this property to provide a pointer for the kernel to
+ *	fill with a sync_file file descriptor, which will signal once the
+ *	writeback is finished. The value should be the address of a 32-bit
+ *	signed integer, cast to a u64.
+ *	Userspace should wait for this fence to signal before making another
+ *	commit affecting any of the same CRTCs, Planes or Connectors.
+ *	**Failure to do so will result in undefined behaviour.**
+ *	For this reason it is strongly recommended that all userspace
+ *	applications making use of writeback connectors *always* retrieve an
+ *	out-fence for the commit and use it appropriately.
+ *	From userspace, this property will always read as zero.
  */
 
+#define fence_to_wb_connector(x) container_of(x->lock, \
+					      struct drm_writeback_connector, \
+					      fence_lock)
+
+static const char *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
+{
+	struct drm_writeback_connector *wb_connector =
+		fence_to_wb_connector(fence);
+
+	return wb_connector->base.dev->driver->name;
+}
+
+static const char *
+drm_writeback_fence_get_timeline_name(struct dma_fence *fence)
+{
+	struct drm_writeback_connector *wb_connector =
+		fence_to_wb_connector(fence);
+
+	return wb_connector->timeline_name;
+}
+
+static bool drm_writeback_fence_enable_signaling(struct dma_fence *fence)
+{
+	return true;
+}
+
+static const struct dma_fence_ops drm_writeback_fence_ops = {
+	.get_driver_name = drm_writeback_fence_get_driver_name,
+	.get_timeline_name = drm_writeback_fence_get_timeline_name,
+	.enable_signaling = drm_writeback_fence_enable_signaling,
+	.wait = dma_fence_default_wait,
+};
+
 static bool create_writeback_properties(struct drm_device *dev)
 {
 	struct drm_property *prop;
@@ -69,6 +126,15 @@ static bool create_writeback_properties(struct drm_device *dev)
 		dev->mode_config.writeback_pixel_formats_property = prop;
 	}
 
+	if (!dev->mode_config.writeback_out_fence_ptr_property) {
+		prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
+						 "WRITEBACK_OUT_FENCE_PTR", 0,
+						 U64_MAX);
+		if (!prop)
+			return -ENOMEM;
+		dev->mode_config.writeback_out_fence_ptr_property = prop;
+	}
+
 	return true;
 }
 
@@ -138,6 +204,15 @@ int drm_writeback_connector_init(struct drm_device *dev,
 	INIT_LIST_HEAD(&wb_connector->job_queue);
 	spin_lock_init(&wb_connector->job_lock);
 
+	wb_connector->fence_context = dma_fence_context_alloc(1);
+	spin_lock_init(&wb_connector->fence_lock);
+	snprintf(wb_connector->timeline_name,
+		 sizeof(wb_connector->timeline_name),
+		 "CONNECTOR:%d-%s", connector->base.id, connector->name);
+
+	drm_object_attach_property(&connector->base,
+				   config->writeback_out_fence_ptr_property, 0);
+
 	drm_object_attach_property(&connector->base,
 				   config->writeback_fb_id_property, 0);
 
@@ -200,6 +275,7 @@ void drm_writeback_cleanup_job(struct drm_writeback_job *job)
 
 	if (job->fb)
 		drm_framebuffer_unreference(job->fb);
+	dma_fence_put(job->out_fence);
 	kfree(job);
 }
 EXPORT_SYMBOL(drm_writeback_cleanup_job);
@@ -222,6 +298,7 @@ static void cleanup_work(struct work_struct *work)
 /**
  * drm_writeback_signal_completion - Signal the completion of a writeback job
  * @wb_connector: The writeback connector whose job is complete
+ * @status: Status code to set in the writeback out_fence (0 for success)
  *
  * Drivers should call this to signal the completion of a previously queued
  * writeback job. It should be called as soon as possible after the hardware
@@ -235,7 +312,8 @@ static void cleanup_work(struct work_struct *work)
  * See also: drm_writeback_queue_job()
  */
 void
-drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
+drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
+				int status)
 {
 	unsigned long flags;
 	struct drm_writeback_job *job;
@@ -244,8 +322,14 @@ drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
 	job = list_first_entry_or_null(&wb_connector->job_queue,
 				       struct drm_writeback_job,
 				       list_entry);
-	if (job)
+	if (job) {
 		list_del(&job->list_entry);
+		if (job->out_fence) {
+			if (status)
+				dma_fence_set_error(job->out_fence, status);
+			dma_fence_signal(job->out_fence);
+		}
+	}
 	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
 
 	if (WARN_ON(!job))
@@ -255,3 +339,24 @@ drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
 	queue_work(system_long_wq, &job->cleanup_work);
 }
 EXPORT_SYMBOL(drm_writeback_signal_completion);
+
+struct dma_fence *
+drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
+{
+	struct dma_fence *fence;
+
+	if (WARN_ON(wb_connector->base.connector_type !=
+		    DRM_MODE_CONNECTOR_WRITEBACK))
+		return NULL;
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		return NULL;
+
+	dma_fence_init(fence, &drm_writeback_fence_ops,
+		       &wb_connector->fence_lock, wb_connector->fence_context,
+		       ++wb_connector->fence_seqno);
+
+	return fence;
+}
+EXPORT_SYMBOL(drm_writeback_get_out_fence);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index d7b0263cc5cf..09076a625637 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -160,6 +160,14 @@ struct __drm_crtcs_state {
 struct __drm_connnectors_state {
 	struct drm_connector *ptr;
 	struct drm_connector_state *state, *old_state, *new_state;
+	/**
+	 * @out_fence_ptr:
+	 *
+	 * User-provided pointer which the kernel uses to return a sync_file
+	 * file descriptor. Used by writeback connectors to signal completion of
+	 * the writeback.
+	 */
+	s32 __user *out_fence_ptr;
 };
 
 struct drm_private_obj;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8701ebcc68b3..da56fda6e218 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -429,10 +429,10 @@ struct drm_connector_state {
 	/**
 	 * @writeback_job: Writeback job for writeback connectors
 	 *
-	 * Holds the framebuffer for a writeback connector. As the writeback
-	 * completion may be asynchronous to the normal commit cycle, the
-	 * writeback job lifetime is managed separately from the normal atomic
-	 * state by this object.
+	 * Holds the framebuffer and out-fence for a writeback connector. As
+	 * the writeback completion may be asynchronous to the normal commit
+	 * cycle, the writeback job lifetime is managed separately from the
+	 * normal atomic state by this object.
 	 *
 	 * See also: drm_writeback_queue_job() and
 	 * drm_writeback_signal_completion()
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index c012e1148ec0..930e00560380 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -792,6 +792,14 @@ struct drm_mode_config {
 	 * See also: drm_writeback_connector_init()
 	 */
 	struct drm_property *writeback_pixel_formats_property;
+	/**
+	 * @writeback_out_fence_ptr_property: Property for writeback connectors,
+	 * fd pointer representing the outgoing fences for a writeback
+	 * connector. Userspace should provide a pointer to a value of type s32,
+	 * and then cast that pointer to u64.
+	 * See also: drm_writeback_connector_init()
+	 */
+	struct drm_property *writeback_out_fence_ptr_property;
 
 	/* dumb ioctl parameters */
 	uint32_t preferred_depth, prefer_shadow;
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 0bb95fd4907d..b9470ae2a53d 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -49,6 +49,32 @@ struct drm_writeback_connector {
 	 * drm_writeback_signal_completion()
 	 */
 	struct list_head job_queue;
+
+	/**
+	 * @fence_context:
+	 *
+	 * timeline context used for fence operations.
+	 */
+	unsigned int fence_context;
+	/**
+	 * @fence_lock:
+	 *
+	 * spinlock to protect the fences in the fence_context.
+	 */
+	spinlock_t fence_lock;
+	/**
+	 * @fence_seqno:
+	 *
+	 * Seqno variable used as monotonic counter for the fences
+	 * created on the connector's timeline.
+	 */
+	unsigned long fence_seqno;
+	/**
+	 * @timeline_name:
+	 *
+	 * The name of the connector's fence timeline.
+	 */
+	char timeline_name[32];
 };
 #define to_wb_connector(x) container_of(x, struct drm_writeback_connector, base)
 
@@ -73,6 +99,13 @@ struct drm_writeback_job {
 	 * directly, use drm_atomic_set_writeback_fb_for_connector()
 	 */
 	struct drm_framebuffer *fb;
+
+	/**
+	 * @out_fence:
+	 *
+	 * Fence which will signal once the writeback has completed
+	 */
+	struct dma_fence *out_fence;
 };
 
 int drm_writeback_connector_init(struct drm_device *dev,
@@ -85,5 +118,11 @@ void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
 			     struct drm_writeback_job *job);
 
 void drm_writeback_cleanup_job(struct drm_writeback_job *job);
-void drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector);
+
+void
+drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
+				int status);
+
+struct dma_fence *
+drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector);
 #endif
-- 
2.14.3

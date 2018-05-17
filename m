Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeEQRhv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:37:51 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:12304 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752065AbeEQRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:37:49 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v7 2/3] drm: writeback: Add out-fences for writeback connectors
Date: Thu, 17 May 2018 17:43:27 +0100
Message-Id: <20180517164328.11814-3-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517164328.11814-1-Liviu.Dudau@arm.com>
References: <20180517164328.11814-1-Liviu.Dudau@arm.com>
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
 - Rebase onto commit 7e9081c5aac7 ("drm/fence: fix memory overwrite
   when setting out_fence fd") (change out_fence_ptr to s32 __user *,
   for real this time.)
 - Update documentation around WRITEBACK_OUT_FENCE_PTR

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
[rebased and fixed conflicts]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_atomic.c    |  99 ++++++++++++++++++++++++++---
 drivers/gpu/drm/drm_writeback.c | 108 +++++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h        |   8 +++
 include/drm/drm_connector.h     |   8 +--
 include/drm/drm_mode_config.h   |   8 +++
 include/drm/drm_writeback.h     |  43 ++++++++++++-
 6 files changed, 258 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3f1e4b894803b..cc2f86c68b293 100644
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
@@ -705,6 +734,12 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
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
 
@@ -1320,6 +1355,11 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
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
@@ -1404,6 +1444,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 	} else if (property == config->writeback_fb_id_property) {
 		/* Writeback framebuffer is one-shot, write and forget */
 		*val = 0;
+	} else if (property == config->writeback_out_fence_ptr_property) {
+		*val = 0;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
@@ -2263,7 +2305,7 @@ static int setup_out_fence(struct drm_out_fence_state *fence_state,
 	return 0;
 }
 
-static int prepare_crtc_signaling(struct drm_device *dev,
+static int prepare_signaling(struct drm_device *dev,
 				  struct drm_atomic_state *state,
 				  struct drm_mode_atomic *arg,
 				  struct drm_file *file_priv,
@@ -2272,6 +2314,8 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_connector *conn;
+	struct drm_connector_state *conn_state;
 	int i, c = 0, ret;
 
 	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
@@ -2337,6 +2381,43 @@ static int prepare_crtc_signaling(struct drm_device *dev,
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
@@ -2347,11 +2428,11 @@ static int prepare_crtc_signaling(struct drm_device *dev,
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
@@ -2530,8 +2611,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_mode_object_put(obj);
 	}
 
-	ret = prepare_crtc_signaling(dev, state, arg, file_priv, &fence_state,
-				     &num_fences);
+	ret = prepare_signaling(dev, state, arg, file_priv, &fence_state,
+				&num_fences);
 	if (ret)
 		goto out;
 
@@ -2549,7 +2630,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 out:
 	drm_atomic_clean_old_fb(dev, plane_mask, ret);
 
-	complete_crtc_signaling(dev, state, fence_state, num_fences, !ret);
+	complete_signaling(dev, state, fence_state, num_fences, !ret);
 
 	if (ret == -EDEADLK) {
 		drm_atomic_state_clear(state);
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 17cacd2170b0c..46a93a883344f 100644
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
 static int create_writeback_properties(struct drm_device *dev)
 {
 	struct drm_property *prop;
@@ -71,6 +128,15 @@ static int create_writeback_properties(struct drm_device *dev)
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
 	return 0;
 }
 
@@ -140,6 +206,15 @@ int drm_writeback_connector_init(struct drm_device *dev,
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
 
@@ -221,6 +296,7 @@ static void cleanup_work(struct work_struct *work)
 /**
  * drm_writeback_signal_completion - Signal the completion of a writeback job
  * @wb_connector: The writeback connector whose job is complete
+ * @status: Status code to set in the writeback out_fence (0 for success)
  *
  * Drivers should call this to signal the completion of a previously queued
  * writeback job. It should be called as soon as possible after the hardware
@@ -234,7 +310,8 @@ static void cleanup_work(struct work_struct *work)
  * See also: drm_writeback_queue_job()
  */
 void
-drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
+drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
+				int status)
 {
 	unsigned long flags;
 	struct drm_writeback_job *job;
@@ -243,8 +320,14 @@ drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
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
@@ -254,3 +337,24 @@ drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
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
index a5e904105db3a..7c77a1916182a 100644
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
index 60c0ffb947d5e..b0d2ed13d625b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -433,10 +433,10 @@ struct drm_connector_state {
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
index de8881324f734..74fe26aaf5444 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -793,6 +793,14 @@ struct drm_mode_config {
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
index cf3a28676006a..6a7462c1821ad 100644
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
 
 struct drm_writeback_job {
@@ -59,12 +85,14 @@ struct drm_writeback_job {
 	 * framebuffer reference to a workqueue.
 	 */
 	struct work_struct cleanup_work;
+
 	/**
 	 * @list_entry:
 	 *
 	 * List item for the connector's @job_queue
 	 */
 	struct list_head list_entry;
+
 	/**
 	 * @fb:
 	 *
@@ -72,6 +100,13 @@ struct drm_writeback_job {
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
@@ -84,5 +119,11 @@ void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
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
2.17.0

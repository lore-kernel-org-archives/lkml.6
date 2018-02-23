Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBWOAX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:00:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeBWOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:00:21 -0500
Date: Fri, 23 Feb 2018 14:00:18 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Brian Starkey <brian.starkey@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/4] drm: Add writeback connector type
Message-ID: <20180223140018.GV9111@e110455-lin.cambridge.arm.com>
References: <20180223131758.18362-1-robdclark@gmail.com>
 <20180223131758.18362-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223131758.18362-2-robdclark@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Feb 23, 2018 at 08:17:51AM -0500, Rob Clark wrote:
> From: Brian Starkey <brian.starkey@arm.com>
> 
> Writeback connectors represent writeback engines which can write the
> CRTC output to a memory framebuffer. Add a writeback connector type and
> related support functions.
> 
> Drivers should initialize a writeback connector with
> drm_writeback_connector_init() which takes care of setting up all the
> writeback-specific details on top of the normal functionality of
> drm_connector_init().
> 
> Writeback connectors have a WRITEBACK_FB_ID property, used to set the
> output framebuffer, and a WRITEBACK_PIXEL_FORMATS blob used to expose the
> supported writeback formats to userspace.
> 
> When a framebuffer is attached to a writeback connector with the
> WRITEBACK_FB_ID property, it is used only once (for the commit in which
> it was included), and userspace can never read back the value of
> WRITEBACK_FB_ID. WRITEBACK_FB_ID can only be set if the connector is
> attached to a CRTC.

[snip]

> +static bool create_writeback_properties(struct drm_device *dev)
> +{
> +	struct drm_property *prop;
> +
> +	if (!dev->mode_config.writeback_fb_id_property) {
> +		prop = drm_property_create_object(dev, DRM_MODE_PROP_ATOMIC,
> +						  "WRITEBACK_FB_ID",
> +						  DRM_MODE_OBJECT_FB);
> +		if (!prop)
> +			return false;
> +		dev->mode_config.writeback_fb_id_property = prop;
> +	}
> +
> +	if (!dev->mode_config.writeback_pixel_formats_property) {
> +		prop = drm_property_create(dev, DRM_MODE_PROP_BLOB | DRM_MODE_PROP_IMMUTABLE,
> +					   "WRITEBACK_PIXEL_FORMATS", 0);
> +		if (!prop)
> +			return false;
> +		dev->mode_config.writeback_pixel_formats_property = prop;
> +	}
> +
> +	return true;
> +}

based on a buildbot warning and the fact that the next patch starts
returning -ENOMEM inside the above function, I have this variant in my
internal tree that I was preparing to send out once I've got my i-g-t
tests in better shape:

+static int create_writeback_properties(struct drm_device *dev)
+{
+       struct drm_property *prop;
+
+       if (!dev->mode_config.writeback_fb_id_property) {
+               prop = drm_property_create_object(dev, DRM_MODE_PROP_ATOMIC,
+                                                 "WRITEBACK_FB_ID",
+                                                 DRM_MODE_OBJECT_FB);
+               if (!prop)
+                       return -ENOMEM;
+               dev->mode_config.writeback_fb_id_property = prop;
+       }
+
+       if (!dev->mode_config.writeback_pixel_formats_property) {
+               prop = drm_property_create(dev, DRM_MODE_PROP_BLOB | DRM_MODE_PROP_IMMUTABLE,
+                                          "WRITEBACK_PIXEL_FORMATS", 0);
+               if (!prop)
+                       return -ENOMEM;
+               dev->mode_config.writeback_pixel_formats_property = prop;
+       }
+
+       return 0;
+}


Feel free to use this version in the next update if you're going to send
one, otherwise I guess we could be patching it later.

Best regards,
Liviu


> +
> +static const struct drm_encoder_funcs drm_writeback_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +/**
> + * drm_writeback_connector_init - Initialize a writeback connector and its properties
> + * @dev: DRM device
> + * @wb_connector: Writeback connector to initialize
> + * @con_funcs: Connector funcs vtable
> + * @enc_helper_funcs: Encoder helper funcs vtable to be used by the internal encoder
> + * @formats: Array of supported pixel formats for the writeback engine
> + * @n_formats: Length of the formats array
> + *
> + * This function creates the writeback-connector-specific properties if they
> + * have not been already created, initializes the connector as
> + * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
> + * values. It will also create an internal encoder associated with the
> + * drm_writeback_connector and set it to use the @enc_helper_funcs vtable for
> + * the encoder helper.
> + *
> + * Drivers should always use this function instead of drm_connector_init() to
> + * set up writeback connectors.
> + *
> + * Returns: 0 on success, or a negative error code
> + */
> +int drm_writeback_connector_init(struct drm_device *dev,
> +				 struct drm_writeback_connector *wb_connector,
> +				 const struct drm_connector_funcs *con_funcs,
> +				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
> +				 const u32 *formats, int n_formats)
> +{
> +	int ret;
> +	struct drm_property_blob *blob;
> +	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_mode_config *config = &dev->mode_config;
> +
> +	if (!create_writeback_properties(dev))
> +		return -EINVAL;
> +
> +	blob = drm_property_create_blob(dev, n_formats * sizeof(*formats),
> +					formats);
> +	if (IS_ERR(blob))
> +		return PTR_ERR(blob);
> +
> +	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
> +	ret = drm_encoder_init(dev, &wb_connector->encoder,
> +			       &drm_writeback_encoder_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (ret)
> +		goto fail;
> +
> +	connector->interlace_allowed = 0;
> +
> +	ret = drm_connector_init(dev, connector, con_funcs,
> +				 DRM_MODE_CONNECTOR_WRITEBACK);
> +	if (ret)
> +		goto connector_fail;
> +
> +	ret = drm_mode_connector_attach_encoder(connector,
> +						&wb_connector->encoder);
> +	if (ret)
> +		goto attach_fail;
> +
> +	INIT_LIST_HEAD(&wb_connector->job_queue);
> +	spin_lock_init(&wb_connector->job_lock);
> +
> +	drm_object_attach_property(&connector->base,
> +				   config->writeback_fb_id_property, 0);
> +
> +	drm_object_attach_property(&connector->base,
> +				   config->writeback_pixel_formats_property,
> +				   blob->base.id);
> +	wb_connector->pixel_formats_blob_ptr = blob;
> +
> +	return 0;
> +
> +attach_fail:
> +	drm_connector_cleanup(connector);
> +connector_fail:
> +	drm_encoder_cleanup(&wb_connector->encoder);
> +fail:
> +	drm_property_unreference_blob(blob);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_writeback_connector_init);
> +
> +/**
> + * drm_writeback_queue_job - Queue a writeback job for later signalling
> + * @wb_connector: The writeback connector to queue a job on
> + * @job: The job to queue
> + *
> + * This function adds a job to the job_queue for a writeback connector. It
> + * should be considered to take ownership of the writeback job, and so any other
> + * references to the job must be cleared after calling this function.
> + *
> + * Drivers must ensure that for a given writeback connector, jobs are queued in
> + * exactly the same order as they will be completed by the hardware (and
> + * signaled via drm_writeback_signal_completion).
> + *
> + * For every call to drm_writeback_queue_job() there must be exactly one call to
> + * drm_writeback_signal_completion()
> + *
> + * See also: drm_writeback_signal_completion()
> + */
> +void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
> +			     struct drm_writeback_job *job)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wb_connector->job_lock, flags);
> +	list_add_tail(&job->list_entry, &wb_connector->job_queue);
> +	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
> +}
> +EXPORT_SYMBOL(drm_writeback_queue_job);
> +
> +/**
> + * drm_writeback_cleanup_job - Cleanup and free a writeback job
> + * @job: The writeback job to free
> + *
> + * Drops any references held by the writeback job, and frees the structure.
> + */
> +void drm_writeback_cleanup_job(struct drm_writeback_job *job)
> +{
> +	if (!job)
> +		return;
> +
> +	if (job->fb)
> +		drm_framebuffer_unreference(job->fb);
> +	kfree(job);
> +}
> +EXPORT_SYMBOL(drm_writeback_cleanup_job);
> +
> +/*
> + * @cleanup_work: deferred cleanup of a writeback job
> + *
> + * The job cannot be cleaned up directly in drm_writeback_signal_completion,
> + * because it may be called in interrupt context. Dropping the framebuffer
> + * reference can sleep, and so the cleanup is deferred to a workqueue.
> + */
> +static void cleanup_work(struct work_struct *work)
> +{
> +	struct drm_writeback_job *job = container_of(work,
> +						     struct drm_writeback_job,
> +						     cleanup_work);
> +	drm_writeback_cleanup_job(job);
> +}
> +
> +/**
> + * drm_writeback_signal_completion - Signal the completion of a writeback job
> + * @wb_connector: The writeback connector whose job is complete
> + *
> + * Drivers should call this to signal the completion of a previously queued
> + * writeback job. It should be called as soon as possible after the hardware
> + * has finished writing, and may be called from interrupt context.
> + * It is the driver's responsibility to ensure that for a given connector, the
> + * hardware completes writeback jobs in the same order as they are queued.
> + *
> + * Unless the driver is holding its own reference to the framebuffer, it must
> + * not be accessed after calling this function.
> + *
> + * See also: drm_writeback_queue_job()
> + */
> +void
> +drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector)
> +{
> +	unsigned long flags;
> +	struct drm_writeback_job *job;
> +
> +	spin_lock_irqsave(&wb_connector->job_lock, flags);
> +	job = list_first_entry_or_null(&wb_connector->job_queue,
> +				       struct drm_writeback_job,
> +				       list_entry);
> +	if (job)
> +		list_del(&job->list_entry);
> +	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
> +
> +	if (WARN_ON(!job))
> +		return;
> +
> +	INIT_WORK(&job->cleanup_work, cleanup_work);
> +	queue_work(system_long_wq, &job->cleanup_work);
> +}
> +EXPORT_SYMBOL(drm_writeback_signal_completion);
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index cf13842a6dbd..d7b0263cc5cf 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -594,6 +594,9 @@ void drm_atomic_set_fence_for_plane(struct drm_plane_state *plane_state,
>  int __must_check
>  drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  				  struct drm_crtc *crtc);
> +int drm_atomic_set_writeback_fb_for_connector(
> +		struct drm_connector_state *conn_state,
> +		struct drm_framebuffer *fb);
>  int __must_check
>  drm_atomic_add_affected_connectors(struct drm_atomic_state *state,
>  				   struct drm_crtc *crtc);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 758a176e7b57..8701ebcc68b3 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -425,6 +425,19 @@ struct drm_connector_state {
>  	 * protection. This is most commonly used for HDCP.
>  	 */
>  	unsigned int content_protection;
> +
> +	/**
> +	 * @writeback_job: Writeback job for writeback connectors
> +	 *
> +	 * Holds the framebuffer for a writeback connector. As the writeback
> +	 * completion may be asynchronous to the normal commit cycle, the
> +	 * writeback job lifetime is managed separately from the normal atomic
> +	 * state by this object.
> +	 *
> +	 * See also: drm_writeback_queue_job() and
> +	 * drm_writeback_signal_completion()
> +	 */
> +	struct drm_writeback_job *writeback_job;
>  };
>  
>  /**
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 7569f22ffef6..c012e1148ec0 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -779,6 +779,20 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *panel_orientation_property;
>  
> +	/**
> +	 * @writeback_fb_id_property: Property for writeback connectors, storing
> +	 * the ID of the output framebuffer.
> +	 * See also: drm_writeback_connector_init()
> +	 */
> +	struct drm_property *writeback_fb_id_property;
> +	/**
> +	 * @writeback_pixel_formats_property: Property for writeback connectors,
> +	 * storing an array of the supported pixel formats for the writeback
> +	 * engine (read-only).
> +	 * See also: drm_writeback_connector_init()
> +	 */
> +	struct drm_property *writeback_pixel_formats_property;
> +
>  	/* dumb ioctl parameters */
>  	uint32_t preferred_depth, prefer_shadow;
>  
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 3e76ca805b0f..97d3a810bc85 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -974,6 +974,17 @@ struct drm_connector_helper_funcs {
>  	 */
>  	int (*atomic_check)(struct drm_connector *connector,
>  			    struct drm_connector_state *state);
> +
> +	/**
> +	 * @atomic_commit:
> +	 *
> +	 * For write-back connectors, this is the point to commit the write-
> +	 * back job to hw.
> +	 *
> +	 * This callback is used by the atomic modeset helpers.
> +	 */
> +	void (*atomic_commit)(struct drm_connector *connector,
> +			      struct drm_writeback_job *writeback_job);
>  };
>  
>  /**
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> new file mode 100644
> index 000000000000..0bb95fd4907d
> --- /dev/null
> +++ b/include/drm/drm_writeback.h
> @@ -0,0 +1,89 @@
> +/*
> + * (C) COPYRIGHT 2016 ARM Limited. All rights reserved.
> + * Author: Brian Starkey <brian.starkey@arm.com>
> + *
> + * This program is free software and is provided to you under the terms of the
> + * GNU General Public License version 2 as published by the Free Software
> + * Foundation, and any use by you of this program is subject to the terms
> + * of such GNU licence.
> + */
> +
> +#ifndef __DRM_WRITEBACK_H__
> +#define __DRM_WRITEBACK_H__
> +#include <drm/drm_connector.h>
> +#include <drm/drm_encoder.h>
> +#include <linux/workqueue.h>
> +
> +struct drm_writeback_connector {
> +	struct drm_connector base;
> +
> +	/**
> +	 * @encoder: Internal encoder used by the connector to fulfill
> +	 * the DRM framework requirements. The users of the
> +	 * @drm_writeback_connector control the behaviour of the @encoder
> +	 * by passing the @enc_funcs parameter to drm_writeback_connector_init()
> +	 * function.
> +	 */
> +	struct drm_encoder encoder;
> +
> +	/**
> +	 * @pixel_formats_blob_ptr:
> +	 *
> +	 * DRM blob property data for the pixel formats list on writeback
> +	 * connectors
> +	 * See also drm_writeback_connector_init()
> +	 */
> +	struct drm_property_blob *pixel_formats_blob_ptr;
> +
> +	/** @job_lock: Protects job_queue */
> +	spinlock_t job_lock;
> +
> +	/**
> +	 * @job_queue:
> +	 *
> +	 * Holds a list of a connector's writeback jobs; the last item is the
> +	 * most recent. The first item may be either waiting for the hardware
> +	 * to begin writing, or currently being written.
> +	 *
> +	 * See also: drm_writeback_queue_job() and
> +	 * drm_writeback_signal_completion()
> +	 */
> +	struct list_head job_queue;
> +};
> +#define to_wb_connector(x) container_of(x, struct drm_writeback_connector, base)
> +
> +struct drm_writeback_job {
> +	/**
> +	 * @cleanup_work:
> +	 *
> +	 * Used to allow drm_writeback_signal_completion to defer dropping the
> +	 * framebuffer reference to a workqueue.
> +	 */
> +	struct work_struct cleanup_work;
> +	/**
> +	 * @list_entry:
> +	 *
> +	 * List item for the connector's @job_queue
> +	 */
> +	struct list_head list_entry;
> +	/**
> +	 * @fb:
> +	 *
> +	 * Framebuffer to be written to by the writeback connector. Do not set
> +	 * directly, use drm_atomic_set_writeback_fb_for_connector()
> +	 */
> +	struct drm_framebuffer *fb;
> +};
> +
> +int drm_writeback_connector_init(struct drm_device *dev,
> +				 struct drm_writeback_connector *wb_connector,
> +				 const struct drm_connector_funcs *con_funcs,
> +				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
> +				 const u32 *formats, int n_formats);
> +
> +void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
> +			     struct drm_writeback_job *job);
> +
> +void drm_writeback_cleanup_job(struct drm_writeback_job *job);
> +void drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector);
> +#endif
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 2c575794fb52..7b47e184e95e 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -338,6 +338,7 @@ enum drm_mode_subconnector {
>  #define DRM_MODE_CONNECTOR_VIRTUAL      15
>  #define DRM_MODE_CONNECTOR_DSI		16
>  #define DRM_MODE_CONNECTOR_DPI		17
> +#define DRM_MODE_CONNECTOR_WRITEBACK	18
>  
>  struct drm_mode_get_connector {
>  
> -- 
> 2.14.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

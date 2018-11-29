Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA01DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50321019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edudzrTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E50321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeK3C0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:26:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37210 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK3C0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:26:23 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so4168525iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RBkB59cuAZ9UQZcLA3eKE0dH144uT1ajZE5qE3+84w=;
        b=edudzrTrdGliW33fXuQ6HxEtFuYhal0EZnwiPwrtIY13a1XfpgRSlOyAhY0ba22wJo
         bLx9NPAMc8OcgRS49RuCnaa1MDlDk856RXUzStTuTD+DBfwyjDLbFMcg9vTAi5dqLQTR
         1CZEkv1PQufn9ZIsWOcTv56SOmU9fMOHZAoRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RBkB59cuAZ9UQZcLA3eKE0dH144uT1ajZE5qE3+84w=;
        b=YZdqjL/wRaya/INQUEsSkAc+WNgVPZVZr9nHGZPhxCqe6tNQJ42lYM8J59pmB5BCcx
         D/9zA0T7WGln+5MXbL+Thluy+gucmxqIxELdEGOjQo5WccFbos8SfBWal7ZqT/F0yvVX
         iFtm5lLPKUTrgWMnUoG7phpEb0agllvCb0x41zR9dMwGHTOJdSdhix7MkFX7+ggLzqT0
         JHe/eBzNR4PExB9FuFUvsTIoRDGRaJzDI3C6P3VPtQBlY+2eAPCyEOF8v+MXEnENh+cv
         7Z/9F7PbPZEo6SImSpWz+Oqq5/a67Eyr/0mejg8C5kBCDWDYRrPX9/gRSasihqxXEU6o
         N3ew==
X-Gm-Message-State: AA+aEWaOr638zxofebnjbwdZrdjr5SElHAMlbSn1sl30RO8xi0lYVV1Y
        RCes7+/J/vh9jg5PGhpv9XqqcMym85tSKTJtm86jsQ==
X-Google-Smtp-Source: AFSGD/We695f4jQhrS1DvX8YQ1ZqtBZCz+Lc5d92nAKtkor1V298y/eNgz58pbn6nU1BtFoRcHEZNB48EnXWSnL9mZ0=
X-Received: by 2002:a02:9c53:: with SMTP id h19mr1652992jal.31.1543504839436;
 Thu, 29 Nov 2018 07:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20181128230927.10951-1-eric@anholt.net>
In-Reply-To: <20181128230927.10951-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Thu, 29 Nov 2018 15:20:28 +0000
Message-ID: <CAApk1dWqFO3A7jJ6Ge1e_GKONS+_TLQ3je5-FsPU69Gx-LaZWA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/v3d: Add support for submitting jobs to the TFU.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 23:09, Eric Anholt <eric@anholt.net> wrote:
>
> The TFU can copy from raster, UIF, and SAND input images to UIF output
> images, with optional mipmap generation.  This will certainly be
> useful for media EGL image input, but is also useful immediately for
> mipmap generation without bogging the V3D core down.
>
> For now we only run the queue 1 job deep, and don't have any hang
> recovery (though I don't think we should need it, with TFU).  Queuing
> multiple jobs in the HW will require synchronizing the YUV coefficient
> regs updates since they don't get FIFOed with the job.
>
> v2: Change the ioctl to IOW instead of IOWR, always set COEF0, explain
>     why TFU is AUTH, clarify the syncing docs, drop the unused TFU
>     interrupt regs (you're expected to use the hub's), don't take
>     &bo->base for NULL bos.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Dave Emett <david.emett@broadcom.com>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.c   |  15 ++-
>  drivers/gpu/drm/v3d/v3d_drv.h   |  32 +++++-
>  drivers/gpu/drm/v3d/v3d_gem.c   | 178 ++++++++++++++++++++++++++++----
>  drivers/gpu/drm/v3d/v3d_irq.c   |  12 ++-
>  drivers/gpu/drm/v3d/v3d_regs.h  |  49 +++++++++
>  drivers/gpu/drm/v3d/v3d_sched.c | 147 ++++++++++++++++++++++----
>  drivers/gpu/drm/v3d/v3d_trace.h |  20 ++++
>  include/uapi/drm/v3d_drm.h      |  25 +++++
>  8 files changed, 426 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 4857c0a63131..0c59a7e16275 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -184,10 +184,15 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
>                 return 0;
>         }
>
> -       /* Any params that aren't just register reads would go here. */
>
> -       DRM_DEBUG("Unknown parameter %d\n", args->param);
> -       return -EINVAL;
> +       switch (args->param) {
> +       case DRM_V3D_PARAM_SUPPORTS_TFU:
> +               args->value = 1;
> +               return 0;
> +       default:
> +               DRM_DEBUG("Unknown parameter %d\n", args->param);
> +               return -EINVAL;
> +       }
>  }
>
>  static int
> @@ -242,7 +247,8 @@ static const struct file_operations v3d_drm_fops = {
>  /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
>   * protection between clients.  Note that render nodes would be be
>   * able to submit CLs that could access BOs from clients authenticated
> - * with the master node.
> + * with the master node.  The TFU doesn't use the GMP, so it would
> + * need to stay DRM_AUTH until we do buffer size/offset validation.
>   */
>  static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
>         DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CL, v3d_submit_cl_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
> @@ -251,6 +257,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
>         DRM_IOCTL_DEF_DRV(V3D_MMAP_BO, v3d_mmap_bo_ioctl, DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(V3D_GET_PARAM, v3d_get_param_ioctl, DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(V3D_GET_BO_OFFSET, v3d_get_bo_offset_ioctl, DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(V3D_SUBMIT_TFU, v3d_submit_tfu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
>  };
>
>  static const struct vm_operations_struct v3d_vm_ops = {
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 83c55ab6e1c0..e0624ea72942 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -8,19 +8,18 @@
>  #include <drm/drm_gem.h>
>  #include <drm/gpu_scheduler.h>
>  #include <drm/drm_simple_kms_helper.h>
> +#include "uapi/drm/v3d_drm.h"
>
>  #define GMP_GRANULARITY (128 * 1024)
>
> -/* Enum for each of the V3D queues.  We maintain various queue
> - * tracking as an array because at some point we'll want to support
> - * the TFU (texture formatting unit) as another queue.
> - */
> +/* Enum for each of the V3D queues. */
>  enum v3d_queue {
>         V3D_BIN,
>         V3D_RENDER,
> +       V3D_TFU,
>  };
>
> -#define V3D_MAX_QUEUES (V3D_RENDER + 1)
> +#define V3D_MAX_QUEUES (V3D_TFU + 1)
>
>  struct v3d_queue_state {
>         struct drm_gpu_scheduler sched;
> @@ -74,6 +73,7 @@ struct v3d_dev {
>
>         struct v3d_exec_info *bin_job;
>         struct v3d_exec_info *render_job;
> +       struct v3d_tfu_job *tfu_job;
>
>         struct v3d_queue_state queue[V3D_MAX_QUEUES];
>
> @@ -224,6 +224,25 @@ struct v3d_exec_info {
>         u32 qma, qms, qts;
>  };
>
> +struct v3d_tfu_job {
> +       struct drm_sched_job base;
> +
> +       struct drm_v3d_submit_tfu args;
> +
> +       /* An optional fence userspace can pass in for the job to depend on. */
> +       struct dma_fence *in_fence;
> +
> +       /* v3d fence to be signaled by IRQ handler when the job is complete. */
> +       struct dma_fence *done_fence;
> +
> +       struct v3d_dev *v3d;
> +
> +       struct kref refcount;
> +
> +       /* This is the array of BOs that were looked up at the start of exec. */
> +       struct v3d_bo *bo[4];
> +};
> +
>  /**
>   * _wait_for - magic (register) wait macro
>   *
> @@ -287,9 +306,12 @@ int v3d_gem_init(struct drm_device *dev);
>  void v3d_gem_destroy(struct drm_device *dev);
>  int v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>                         struct drm_file *file_priv);
> +int v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
> +                        struct drm_file *file_priv);
>  int v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *file_priv);
>  void v3d_exec_put(struct v3d_exec_info *exec);
> +void v3d_tfu_job_put(struct v3d_tfu_job *exec);
>  void v3d_reset(struct v3d_dev *v3d);
>  void v3d_invalidate_caches(struct v3d_dev *v3d);
>  void v3d_flush_caches(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 1e8947c7d954..41cbe2cdad50 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -207,26 +207,27 @@ v3d_flush_caches(struct v3d_dev *v3d)
>  }
>
>  static void
> -v3d_attach_object_fences(struct v3d_exec_info *exec)
> +v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
> +                        struct dma_fence *fence)
>  {
> -       struct dma_fence *out_fence = exec->render_done_fence;
>         int i;
>
> -       for (i = 0; i < exec->bo_count; i++) {
> +       for (i = 0; i < bo_count; i++) {
>                 /* XXX: Use shared fences for read-only objects. */
> -               reservation_object_add_excl_fence(exec->bo[i]->resv, out_fence);
> +               reservation_object_add_excl_fence(bos[i]->resv, fence);
>         }
>  }
>
>  static void
>  v3d_unlock_bo_reservations(struct drm_device *dev,
> -                          struct v3d_exec_info *exec,
> +                          struct v3d_bo **bos,
> +                          int bo_count,
>                            struct ww_acquire_ctx *acquire_ctx)
>  {
>         int i;
>
> -       for (i = 0; i < exec->bo_count; i++)
> -               ww_mutex_unlock(&exec->bo[i]->resv->lock);
> +       for (i = 0; i < bo_count; i++)
> +               ww_mutex_unlock(&bos[i]->resv->lock);
>
>         ww_acquire_fini(acquire_ctx);
>  }
> @@ -240,7 +241,8 @@ v3d_unlock_bo_reservations(struct drm_device *dev,
>   */
>  static int
>  v3d_lock_bo_reservations(struct drm_device *dev,
> -                        struct v3d_exec_info *exec,
> +                        struct v3d_bo **bos,
> +                        int bo_count,
>                          struct ww_acquire_ctx *acquire_ctx)
>  {
>         int contended_lock = -1;
> @@ -250,7 +252,7 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>
>  retry:
>         if (contended_lock != -1) {
> -               struct v3d_bo *bo = exec->bo[contended_lock];
> +               struct v3d_bo *bo = bos[contended_lock];
>
>                 ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
>                                                        acquire_ctx);
> @@ -260,20 +262,20 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>                 }
>         }
>
> -       for (i = 0; i < exec->bo_count; i++) {
> +       for (i = 0; i < bo_count; i++) {
>                 if (i == contended_lock)
>                         continue;
>
> -               ret = ww_mutex_lock_interruptible(&exec->bo[i]->resv->lock,
> +               ret = ww_mutex_lock_interruptible(&bos[i]->resv->lock,
>                                                   acquire_ctx);
>                 if (ret) {
>                         int j;
>
>                         for (j = 0; j < i; j++)
> -                               ww_mutex_unlock(&exec->bo[j]->resv->lock);
> +                               ww_mutex_unlock(&bos[j]->resv->lock);
>
>                         if (contended_lock != -1 && contended_lock >= i) {
> -                               struct v3d_bo *bo = exec->bo[contended_lock];
> +                               struct v3d_bo *bo = bos[contended_lock];
>
>                                 ww_mutex_unlock(&bo->resv->lock);
>                         }
> @@ -293,10 +295,11 @@ v3d_lock_bo_reservations(struct drm_device *dev,
>         /* Reserve space for our shared (read-only) fence references,
>          * before we commit the CL to the hardware.
>          */
> -       for (i = 0; i < exec->bo_count; i++) {
> -               ret = reservation_object_reserve_shared(exec->bo[i]->resv, 1);
> +       for (i = 0; i < bo_count; i++) {
> +               ret = reservation_object_reserve_shared(bos[i]->resv, 1);
>                 if (ret) {
> -                       v3d_unlock_bo_reservations(dev, exec, acquire_ctx);
> +                       v3d_unlock_bo_reservations(dev, bos, bo_count,
> +                                                  acquire_ctx);
>                         return ret;
>                 }
>         }
> @@ -419,6 +422,33 @@ void v3d_exec_put(struct v3d_exec_info *exec)
>         kref_put(&exec->refcount, v3d_exec_cleanup);
>  }
>
> +static void
> +v3d_tfu_job_cleanup(struct kref *ref)
> +{
> +       struct v3d_tfu_job *job = container_of(ref, struct v3d_tfu_job,
> +                                              refcount);
> +       struct v3d_dev *v3d = job->v3d;
> +       unsigned int i;
> +
> +       dma_fence_put(job->in_fence);
> +       dma_fence_put(job->done_fence);
> +
> +       for (i = 0; i < ARRAY_SIZE(job->bo); i++) {
> +               if (job->bo[i])
> +                       drm_gem_object_put_unlocked(&job->bo[i]->base);
> +       }
> +
> +       pm_runtime_mark_last_busy(v3d->dev);
> +       pm_runtime_put_autosuspend(v3d->dev);
> +
> +       kfree(job);
> +}
> +
> +void v3d_tfu_job_put(struct v3d_tfu_job *job)
> +{
> +       kref_put(&job->refcount, v3d_tfu_job_cleanup);
> +}
> +
>  int
>  v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
>                   struct drm_file *file_priv)
> @@ -536,7 +566,8 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>         if (ret)
>                 goto fail;
>
> -       ret = v3d_lock_bo_reservations(dev, exec, &acquire_ctx);
> +       ret = v3d_lock_bo_reservations(dev, exec->bo, exec->bo_count,
> +                                      &acquire_ctx);
>         if (ret)
>                 goto fail;
>
> @@ -570,9 +601,10 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>                                   &v3d_priv->sched_entity[V3D_RENDER]);
>         mutex_unlock(&v3d->sched_lock);
>
> -       v3d_attach_object_fences(exec);
> +       v3d_attach_object_fences(exec->bo, exec->bo_count,
> +                                exec->render_done_fence);
>
> -       v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
> +       v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
>
>         /* Update the return sync object for the */
>         sync_out = drm_syncobj_find(file_priv, args->out_sync);
> @@ -588,13 +620,119 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>
>  fail_unreserve:
>         mutex_unlock(&v3d->sched_lock);
> -       v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
> +       v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
>  fail:
>         v3d_exec_put(exec);
>
>         return ret;
>  }
>
> +/**
> + * v3d_submit_tfu_ioctl() - Submits a TFU (texture formatting) job to the V3D.
> + * @dev: DRM device
> + * @data: ioctl argument
> + * @file_priv: DRM file for this fd
> + *
> + * Userspace provides the register setup for the TFU, which we don't
> + * need to validate since the TFU is behind the MMU.
> + */
> +int
> +v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
> +                   struct drm_file *file_priv)
> +{
> +       struct v3d_dev *v3d = to_v3d_dev(dev);
> +       struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
> +       struct drm_v3d_submit_tfu *args = data;
> +       struct v3d_tfu_job *job;
> +       struct ww_acquire_ctx acquire_ctx;
> +       struct drm_syncobj *sync_out;
> +       struct dma_fence *sched_done_fence;
> +       int ret = 0;
> +       int bo_count;
> +
> +       job = kcalloc(1, sizeof(*job), GFP_KERNEL);
> +       if (!job)
> +               return -ENOMEM;
> +
> +       ret = pm_runtime_get_sync(v3d->dev);
> +       if (ret < 0) {
> +               kfree(job);
> +               return ret;
> +       }
> +
> +       kref_init(&job->refcount);
> +
> +       ret = drm_syncobj_find_fence(file_priv, args->in_sync,
> +                                    0, 0, &job->in_fence);
> +       if (ret == -EINVAL)
> +               goto fail;
> +
> +       job->args = *args;
> +       job->v3d = v3d;
> +
> +       spin_lock(&file_priv->table_lock);
> +       for (bo_count = 0; bo_count < ARRAY_SIZE(job->bo); bo_count++) {
> +               struct drm_gem_object *bo;
> +
> +               if (!args->bo_handles[bo_count])
> +                       break;
> +
> +               bo = idr_find(&file_priv->object_idr,
> +                             args->bo_handles[bo_count]);
> +               if (!bo) {
> +                       DRM_DEBUG("Failed to look up GEM BO %d: %d\n",
> +                                 bo_count, args->bo_handles[bo_count]);
> +                       ret = -ENOENT;
> +                       spin_unlock(&file_priv->table_lock);
> +                       goto fail;
> +               }
> +               drm_gem_object_get(bo);
> +               job->bo[bo_count] = to_v3d_bo(bo);
> +       }
> +       spin_unlock(&file_priv->table_lock);
> +
> +       ret = v3d_lock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +       if (ret)
> +               goto fail;
> +
> +       mutex_lock(&v3d->sched_lock);
> +       ret = drm_sched_job_init(&job->base,
> +                                &v3d_priv->sched_entity[V3D_TFU],
> +                                v3d_priv);
> +       if (ret)
> +               goto fail_unreserve;
> +
> +       sched_done_fence = dma_fence_get(&job->base.s_fence->finished);
> +
> +       kref_get(&job->refcount); /* put by scheduler job completion */
> +       drm_sched_entity_push_job(&job->base, &v3d_priv->sched_entity[V3D_TFU]);
> +       mutex_unlock(&v3d->sched_lock);
> +
> +       v3d_attach_object_fences(job->bo, bo_count, sched_done_fence);
> +
> +       v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +
> +       /* Update the return sync object */
> +       sync_out = drm_syncobj_find(file_priv, args->out_sync);
> +       if (sync_out) {
> +               drm_syncobj_replace_fence(sync_out, 0, sched_done_fence);
> +               drm_syncobj_put(sync_out);
> +       }
> +       dma_fence_put(sched_done_fence);
> +
> +       v3d_tfu_job_put(job);
> +
> +       return 0;
> +
> +fail_unreserve:
> +       mutex_unlock(&v3d->sched_lock);
> +       v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
> +fail:
> +       v3d_tfu_job_put(job);
> +
> +       return ret;
> +}
> +
>  int
>  v3d_gem_init(struct drm_device *dev)
>  {
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index e07514eb11b5..dd7a7b0bd5a1 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -4,8 +4,8 @@
>  /**
>   * DOC: Interrupt management for the V3D engine
>   *
> - * When we take a binning or rendering flush done interrupt, we need
> - * to signal the fence for that job so that the scheduler can queue up
> + * When we take a bin, render, or TFU done interrupt, we need to
> + * signal the fence for that job so that the scheduler can queue up
>   * the next one and unblock any waiters.
>   *
>   * When we take the binner out of memory interrupt, we need to
> @@ -23,7 +23,8 @@
>
>  #define V3D_HUB_IRQS ((u32)(V3D_HUB_INT_MMU_WRV |      \
>                             V3D_HUB_INT_MMU_PTI |       \
> -                           V3D_HUB_INT_MMU_CAP))
> +                           V3D_HUB_INT_MMU_CAP |       \
> +                           V3D_HUB_INT_TFUC))
>
>  static void
>  v3d_overflow_mem_work(struct work_struct *work)
> @@ -117,6 +118,11 @@ v3d_hub_irq(int irq, void *arg)
>         /* Acknowledge the interrupts we're handling here. */
>         V3D_WRITE(V3D_HUB_INT_CLR, intsts);
>
> +       if (intsts & V3D_HUB_INT_TFUC) {
> +               dma_fence_signal(v3d->tfu_job->done_fence);
> +               status = IRQ_HANDLED;
> +       }
> +
>         if (intsts & (V3D_HUB_INT_MMU_WRV |
>                       V3D_HUB_INT_MMU_PTI |
>                       V3D_HUB_INT_MMU_CAP)) {
> diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
> index c3a5e4e44f73..6ccdee9d47bd 100644
> --- a/drivers/gpu/drm/v3d/v3d_regs.h
> +++ b/drivers/gpu/drm/v3d/v3d_regs.h
> @@ -86,6 +86,55 @@
>  # define V3D_TOP_GR_BRIDGE_SW_INIT_1                   0x0000c
>  # define V3D_TOP_GR_BRIDGE_SW_INIT_1_V3D_CLK_108_SW_INIT BIT(0)
>
> +#define V3D_TFU_CS                                     0x00400
> +/* Stops current job, empties input fifo. */
> +# define V3D_TFU_CS_TFURST                             BIT(31)
> +# define V3D_TFU_CS_CVTCT_MASK                         V3D_MASK(23, 16)
> +# define V3D_TFU_CS_CVTCT_SHIFT                        16
> +# define V3D_TFU_CS_NFREE_MASK                         V3D_MASK(13, 8)
> +# define V3D_TFU_CS_NFREE_SHIFT                        8
> +# define V3D_TFU_CS_BUSY                               BIT(0)
> +
> +#define V3D_TFU_SU                                     0x00404
> +/* Interrupt when FINTTHR input slots are free (0 = disabled) */
> +# define V3D_TFU_SU_FINTTHR_MASK                       V3D_MASK(13, 8)
> +# define V3D_TFU_SU_FINTTHR_SHIFT                      8
> +/* Skips resetting the CRC at the start of CRC generation. */
> +# define V3D_TFU_SU_CRCCHAIN                           BIT(4)
> +/* skips writes, computes CRC of the image.  miplevels must be 0. */
> +# define V3D_TFU_SU_CRC                                BIT(3)
> +# define V3D_TFU_SU_THROTTLE_MASK                      V3D_MASK(1, 0)
> +# define V3D_TFU_SU_THROTTLE_SHIFT                     0
> +
> +#define V3D_TFU_ICFG                                   0x00408
> +/* Interrupt when the conversion is complete. */
> +# define V3D_TFU_ICFG_IOC                              BIT(0)
> +
> +/* Input Image Address */
> +#define V3D_TFU_IIA                                    0x0040c
> +/* Input Chroma Address */
> +#define V3D_TFU_ICA                                    0x00410
> +/* Input Image Stride */
> +#define V3D_TFU_IIS                                    0x00414
> +/* Input Image U-Plane Address */
> +#define V3D_TFU_IUA                                    0x00418
> +/* Output Image Address */
> +#define V3D_TFU_IOA                                    0x0041c
> +/* Image Output Size */
> +#define V3D_TFU_IOS                                    0x00420
> +/* TFU YUV Coefficient 0 */
> +#define V3D_TFU_COEF0                                  0x00424
> +/* Use these regs instead of the defaults. */
> +# define V3D_TFU_COEF0_USECOEF                         BIT(31)
> +/* TFU YUV Coefficient 1 */
> +#define V3D_TFU_COEF1                                  0x00428
> +/* TFU YUV Coefficient 2 */
> +#define V3D_TFU_COEF2                                  0x0042c
> +/* TFU YUV Coefficient 3 */
> +#define V3D_TFU_COEF3                                  0x00430
> +
> +#define V3D_TFU_CRC                                    0x00434
> +
>  /* Per-MMU registers. */
>
>  #define V3D_MMUC_CONTROL                               0x01000
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index e1f2aab0717b..0d13c722c8df 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -30,6 +30,12 @@ to_v3d_job(struct drm_sched_job *sched_job)
>         return container_of(sched_job, struct v3d_job, base);
>  }
>
> +static struct v3d_tfu_job *
> +to_tfu_job(struct drm_sched_job *sched_job)
> +{
> +       return container_of(sched_job, struct v3d_tfu_job, base);
> +}
> +
>  static void
>  v3d_job_free(struct drm_sched_job *sched_job)
>  {
> @@ -38,6 +44,14 @@ v3d_job_free(struct drm_sched_job *sched_job)
>         v3d_exec_put(job->exec);
>  }
>
> +static void
> +v3d_tfu_job_free(struct drm_sched_job *sched_job)
> +{
> +       struct v3d_tfu_job *job = to_tfu_job(sched_job);
> +
> +       v3d_tfu_job_put(job);
> +}
> +
>  /**
>   * Returns the fences that the bin or render job depends on, one by one.
>   * v3d_job_run() won't be called until all of them have been signaled.
> @@ -76,6 +90,27 @@ v3d_job_dependency(struct drm_sched_job *sched_job,
>         return fence;
>  }
>
> +/**
> + * Returns the fences that the TFU job depends on, one by one.
> + * v3d_tfu_job_run() won't be called until all of them have been
> + * signaled.
> + */
> +static struct dma_fence *
> +v3d_tfu_job_dependency(struct drm_sched_job *sched_job,
> +                  struct drm_sched_entity *s_entity)
> +{
> +       struct v3d_tfu_job *job = to_tfu_job(sched_job);
> +       struct dma_fence *fence;
> +
> +       fence = job->in_fence;
> +       if (fence) {
> +               job->in_fence = NULL;
> +               return fence;
> +       }
> +
> +       return NULL;
> +}
> +
>  static struct dma_fence *v3d_job_run(struct drm_sched_job *sched_job)
>  {
>         struct v3d_job *job = to_v3d_job(sched_job);
> @@ -147,6 +182,71 @@ static struct dma_fence *v3d_job_run(struct drm_sched_job *sched_job)
>         return fence;
>  }
>
> +static struct dma_fence *
> +v3d_tfu_job_run(struct drm_sched_job *sched_job)
> +{
> +       struct v3d_tfu_job *job = to_tfu_job(sched_job);
> +       struct v3d_dev *v3d = job->v3d;
> +       struct drm_device *dev = &v3d->drm;
> +       struct dma_fence *fence;
> +
> +       fence = v3d_fence_create(v3d, V3D_TFU);
> +       if (IS_ERR(fence))
> +               return NULL;
> +
> +       v3d->tfu_job = job;
> +       if (job->done_fence)
> +               dma_fence_put(job->done_fence);
> +       job->done_fence = dma_fence_get(fence);
> +
> +       trace_v3d_submit_tfu(dev, to_v3d_fence(fence)->seqno);
> +
> +       V3D_WRITE(V3D_TFU_IIA, job->args.iia);
> +       V3D_WRITE(V3D_TFU_IIS, job->args.iis);
> +       V3D_WRITE(V3D_TFU_ICA, job->args.ica);
> +       V3D_WRITE(V3D_TFU_IUA, job->args.iua);
> +       V3D_WRITE(V3D_TFU_IOA, job->args.ioa);
> +       V3D_WRITE(V3D_TFU_IOS, job->args.ios);
> +       V3D_WRITE(V3D_TFU_COEF0, job->args.coef[0]);
> +       if (job->args.coef[0] & V3D_TFU_COEF0_USECOEF) {
> +               V3D_WRITE(V3D_TFU_COEF1, job->args.coef[1]);
> +               V3D_WRITE(V3D_TFU_COEF2, job->args.coef[2]);
> +               V3D_WRITE(V3D_TFU_COEF3, job->args.coef[3]);
> +       }
> +       /* ICFG kicks off the job. */
> +       V3D_WRITE(V3D_TFU_ICFG, job->args.icfg | V3D_TFU_ICFG_IOC);
> +
> +       return fence;
> +}
> +
> +static void
> +v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job)
> +{
> +       enum v3d_queue q;
> +
> +       mutex_lock(&v3d->reset_lock);
> +
> +       /* block scheduler */
> +       for (q = 0; q < V3D_MAX_QUEUES; q++) {
> +               struct drm_gpu_scheduler *sched = &v3d->queue[q].sched;
> +
> +               kthread_park(sched->thread);
> +               drm_sched_hw_job_reset(sched, (sched_job->sched == sched ?
> +                                              sched_job : NULL));
> +       }
> +
> +       /* get the GPU back into the init state */
> +       v3d_reset(v3d);
> +
> +       /* Unblock schedulers and restart their jobs. */
> +       for (q = 0; q < V3D_MAX_QUEUES; q++) {
> +               drm_sched_job_recovery(&v3d->queue[q].sched);
> +               kthread_unpark(v3d->queue[q].sched.thread);
> +       }
> +
> +       mutex_unlock(&v3d->reset_lock);
> +}
> +
>  static void
>  v3d_job_timedout(struct drm_sched_job *sched_job)
>  {
> @@ -154,7 +254,6 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
>         struct v3d_exec_info *exec = job->exec;
>         struct v3d_dev *v3d = exec->v3d;
>         enum v3d_queue job_q = job == &exec->bin ? V3D_BIN : V3D_RENDER;
> -       enum v3d_queue q;
>         u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(job_q));
>         u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(job_q));
>
> @@ -173,27 +272,15 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
>                 return;
>         }
>
> -       mutex_lock(&v3d->reset_lock);
> -
> -       /* block scheduler */
> -       for (q = 0; q < V3D_MAX_QUEUES; q++) {
> -               struct drm_gpu_scheduler *sched = &v3d->queue[q].sched;
> -
> -               kthread_park(sched->thread);
> -               drm_sched_hw_job_reset(sched, (sched_job->sched == sched ?
> -                                              sched_job : NULL));
> -       }
> -
> -       /* get the GPU back into the init state */
> -       v3d_reset(v3d);
> +       v3d_gpu_reset_for_timeout(v3d, sched_job);
> +}
>
> -       /* Unblock schedulers and restart their jobs. */
> -       for (q = 0; q < V3D_MAX_QUEUES; q++) {
> -               drm_sched_job_recovery(&v3d->queue[q].sched);
> -               kthread_unpark(v3d->queue[q].sched.thread);
> -       }
> +static void
> +v3d_tfu_job_timedout(struct drm_sched_job *sched_job)
> +{
> +       struct v3d_tfu_job *job = to_tfu_job(sched_job);
>
> -       mutex_unlock(&v3d->reset_lock);
> +       v3d_gpu_reset_for_timeout(job->v3d, sched_job);
>  }
>
>  static const struct drm_sched_backend_ops v3d_sched_ops = {
> @@ -203,6 +290,13 @@ static const struct drm_sched_backend_ops v3d_sched_ops = {
>         .free_job = v3d_job_free
>  };
>
> +static const struct drm_sched_backend_ops v3d_tfu_sched_ops = {
> +       .dependency = v3d_tfu_job_dependency,
> +       .run_job = v3d_tfu_job_run,
> +       .timedout_job = v3d_tfu_job_timedout,
> +       .free_job = v3d_tfu_job_free
> +};
> +
>  int
>  v3d_sched_init(struct v3d_dev *v3d)
>  {
> @@ -233,6 +327,19 @@ v3d_sched_init(struct v3d_dev *v3d)
>                 return ret;
>         }
>
> +       ret = drm_sched_init(&v3d->queue[V3D_TFU].sched,
> +                            &v3d_tfu_sched_ops,
> +                            hw_jobs_limit, job_hang_limit,
> +                            msecs_to_jiffies(hang_limit_ms),
> +                            "v3d_tfu");
> +       if (ret) {
> +               dev_err(v3d->dev, "Failed to create TFU scheduler: %d.",
> +                       ret);
> +               drm_sched_fini(&v3d->queue[V3D_RENDER].sched);
> +               drm_sched_fini(&v3d->queue[V3D_BIN].sched);
> +               return ret;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/v3d/v3d_trace.h b/drivers/gpu/drm/v3d/v3d_trace.h
> index 85dd351e1e09..f54ed9cd3444 100644
> --- a/drivers/gpu/drm/v3d/v3d_trace.h
> +++ b/drivers/gpu/drm/v3d/v3d_trace.h
> @@ -42,6 +42,26 @@ TRACE_EVENT(v3d_submit_cl,
>                       __entry->ctnqea)
>  );
>
> +TRACE_EVENT(v3d_submit_tfu,
> +           TP_PROTO(struct drm_device *dev,
> +                    uint64_t seqno),
> +           TP_ARGS(dev, seqno),
> +
> +           TP_STRUCT__entry(
> +                            __field(u32, dev)
> +                            __field(u64, seqno)
> +                            ),
> +
> +           TP_fast_assign(
> +                          __entry->dev = dev->primary->index;
> +                          __entry->seqno = seqno;
> +                          ),
> +
> +           TP_printk("dev=%u, seqno=%llu",
> +                     __entry->dev,
> +                     __entry->seqno)
> +);
> +
>  TRACE_EVENT(v3d_reset_begin,
>             TP_PROTO(struct drm_device *dev),
>             TP_ARGS(dev),
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index b1e5de076b0f..35c7d813c66e 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -36,6 +36,7 @@ extern "C" {
>  #define DRM_V3D_MMAP_BO                           0x03
>  #define DRM_V3D_GET_PARAM                         0x04
>  #define DRM_V3D_GET_BO_OFFSET                     0x05
> +#define DRM_V3D_SUBMIT_TFU                        0x06
>
>  #define DRM_IOCTL_V3D_SUBMIT_CL           DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CL, struct drm_v3d_submit_cl)
>  #define DRM_IOCTL_V3D_WAIT_BO             DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_WAIT_BO, struct drm_v3d_wait_bo)
> @@ -43,6 +44,7 @@ extern "C" {
>  #define DRM_IOCTL_V3D_MMAP_BO             DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_MMAP_BO, struct drm_v3d_mmap_bo)
>  #define DRM_IOCTL_V3D_GET_PARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_GET_PARAM, struct drm_v3d_get_param)
>  #define DRM_IOCTL_V3D_GET_BO_OFFSET       DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_GET_BO_OFFSET, struct drm_v3d_get_bo_offset)
> +#define DRM_IOCTL_V3D_SUBMIT_TFU          DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_TFU, struct drm_v3d_submit_tfu)
>
>  /**
>   * struct drm_v3d_submit_cl - ioctl argument for submitting commands to the 3D
> @@ -179,6 +181,7 @@ enum drm_v3d_param {
>         DRM_V3D_PARAM_V3D_CORE0_IDENT0,
>         DRM_V3D_PARAM_V3D_CORE0_IDENT1,
>         DRM_V3D_PARAM_V3D_CORE0_IDENT2,
> +       DRM_V3D_PARAM_SUPPORTS_TFU,
>  };
>
>  struct drm_v3d_get_param {
> @@ -197,6 +200,28 @@ struct drm_v3d_get_bo_offset {
>         __u32 offset;
>  };
>
> +struct drm_v3d_submit_tfu {
> +       __u32 icfg;
> +       __u32 iia;
> +       __u32 iis;
> +       __u32 ica;
> +       __u32 iua;
> +       __u32 ioa;
> +       __u32 ios;
> +       __u32 coef[4];
> +       /* First handle is the output BO, following are other inputs.
> +        * 0 for unused.
> +        */
> +       __u32 bo_handles[4];
> +       /* sync object to block on before running the TFU job.  Each TFU
> +        * job will execute in the order submitted to its FD.  Synchronization
> +        * against rendering jobs requires using sync objects.
> +        */
> +       __u32 in_sync;
> +       /* Sync object to signal when the TFU job is done. */
> +       __u32 out_sync;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.20.0.rc1
>

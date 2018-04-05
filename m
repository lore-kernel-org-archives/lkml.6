Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEGQD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:16:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39930 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDEGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:16:02 -0400
X-Google-Smtp-Source: AIpwx4/hI64ogfUQso+dm+hlZoeUI8JScXpe2e6Hk5AnOx4EsMRp/bDl4v1BPSn+h7yrP+IefHxW+8NOlC7STMUIcuE=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <20180404223251.28449-1-eric@anholt.net>
References: <20180404223251.28449-1-eric@anholt.net>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 5 Apr 2018 08:16:01 +0200
X-Google-Sender-Auth: sqkZ24Uo3-9t6JO8g7QZzOd_aQk
Message-ID: <CAKMK7uGhm_ixQN3-WWmWK-mrdWRAfPZMuD-=fBEQxbtrMkdVFg@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Extend the documentation.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 12:32 AM, Eric Anholt <eric@anholt.net> wrote:
> These comments answer all the questions I had for myself when
> implementing a driver using the GPU scheduler.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Pulling all these comments into the generated kerneldoc would be
awesome, maybe as a new "GPU Scheduler" chapter at the end of
drm-mm.rst? Would mean a bit of busywork to convert the existing raw
comments into proper kerneldoc. Also has the benefit that 0day will
complain when you forget to update the comment when editing the
function prototype - kerneldoc which isn't included anywhere in .rst
won't be checked automatically.
-Daniel

> ---
>  include/drm/gpu_scheduler.h | 46 +++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index dfd54fb94e10..c053a32341bf 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -43,10 +43,12 @@ enum drm_sched_priority {
>  };
>
>  /**
> - * A scheduler entity is a wrapper around a job queue or a group
> - * of other entities. Entities take turns emitting jobs from their
> - * job queues to corresponding hardware ring based on scheduling
> - * policy.
> + * drm_sched_entity - A wrapper around a job queue (typically attached
> + * to the DRM file_priv).
> + *
> + * Entities will emit jobs in order to their corresponding hardware
> + * ring, and the scheduler will alternate between entities based on
> + * scheduling policy.
>  */
>  struct drm_sched_entity {
>         struct list_head                list;
> @@ -78,7 +80,18 @@ struct drm_sched_rq {
>
>  struct drm_sched_fence {
>         struct dma_fence                scheduled;
> +
> +       /* This fence is what will be signaled by the scheduler when
> +        * the job is completed.
> +        *
> +        * When setting up an out fence for the job, you should use
> +        * this, since it's available immediately upon
> +        * drm_sched_job_init(), and the fence returned by the driver
> +        * from run_job() won't be created until the dependencies have
> +        * resolved.
> +        */
>         struct dma_fence                finished;
> +
>         struct dma_fence_cb             cb;
>         struct dma_fence                *parent;
>         struct drm_gpu_scheduler        *sched;
> @@ -88,6 +101,13 @@ struct drm_sched_fence {
>
>  struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>
> +/**
> + * drm_sched_job - A job to be run by an entity.
> + *
> + * A job is created by the driver using drm_sched_job_init(), and
> + * should call drm_sched_entity_push_job() once it wants the scheduler
> + * to schedule the job.
> + */
>  struct drm_sched_job {
>         struct spsc_node                queue_node;
>         struct drm_gpu_scheduler        *sched;
> @@ -112,10 +132,28 @@ static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
>   * these functions should be implemented in driver side
>  */
>  struct drm_sched_backend_ops {
> +       /* Called when the scheduler is considering scheduling this
> +        * job next, to get another struct dma_fence for this job to
> +        * block on.  Once it returns NULL, run_job() may be called.
> +        */
>         struct dma_fence *(*dependency)(struct drm_sched_job *sched_job,
>                                         struct drm_sched_entity *s_entity);
> +
> +       /* Called to execute the job once all of the dependencies have
> +        * been resolved.  This may be called multiple times, if
> +        * timedout_job() has happened and drm_sched_job_recovery()
> +        * decides to try it again.
> +        */
>         struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
> +
> +       /* Called when a job has taken too long to execute, to trigger
> +        * GPU recovery.
> +        */
>         void (*timedout_job)(struct drm_sched_job *sched_job);
> +
> +       /* Called once the job's finished fence has been signaled and
> +        * it's time to clean it up.
> +        */
>         void (*free_job)(struct drm_sched_job *sched_job);
>  };
>
> --
> 2.17.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

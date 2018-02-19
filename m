Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeBSPY2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:24:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38858 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeBSPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:24:25 -0500
X-Google-Smtp-Source: AH8x225+8l1s75as+TF0ubH6ILzZCa1C2JVycuUFLTd5LgUynaHuvryhnXY1FuqHTPXamHJaXaxSmQ==
Date: Mon, 19 Feb 2018 16:24:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Message-ID: <20180219152421.GQ22199@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180215141944.4332-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180215141944.4332-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:19:42PM +0100, Christian König wrote:
> amdgpu needs to verify if userspace sends us valid addresses and the simplest
> way of doing this is to check if the buffer object is locked with the ticket
> of the current submission.
> 
> Clean up the access to the ww_mutex internals by providing a function
> for this and extend the check to the thread owning the underlying mutex.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  3 ++-
>  include/linux/ww_mutex.h               | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index eaa3cb0c3ad1..4c04b560e358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1594,7 +1594,8 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>  	*map = mapping;
>  
>  	/* Double check that the BO is reserved by this CS */
> -	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
> +	if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, current,
> +				  &parser->ticket))
>  		return -EINVAL;
>  
>  	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 39fda195bf78..dd580db289e8 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>  	return mutex_is_locked(&lock->base);
>  }
>  
> +/**
> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
> + * @lock: the mutex to be queried
> + * @task: the task structure to check
> + * @ctx: the w/w acquire context to test
> + *
> + * Returns true if the mutex is locked in the context by the given task, false
> + * otherwise.
> + */
> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> +					struct task_struct *task,
> +					struct ww_acquire_ctx *ctx)
> +{
> +	return likely(__mutex_owner(&lock->base) == task) &&
> +		READ_ONCE(lock->ctx) == ctx;

Just comparing the context should be good enough. If you ever pass a
ww_acquire_ctx which does not belong to your own thread your seriously
wreaking things much worse already (and if we do catch that, should
probably lock the ctx to a given task when ww-mutex debugging is enabled).

That also simplifies the function signature.

Of course that means if you don't have a ctx, you can't test ownership of
a ww_mute, but I think that's not a really valid use-case. And not needed
for cmd submission, where you need the ctx anyway.

Besides this interface nit looks all good. With the task check&parameter
removed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

-Daniel

> +}
> +
>  #endif
> -- 
> 2.14.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

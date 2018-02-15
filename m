Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033593AbeBOUgK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:36:10 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35988 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755821AbeBOUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:36:09 -0500
X-Google-Smtp-Source: AH8x225r+ZMQfuPF9rExBLfd2bRSRsb6zFOJ5qvbwwAxrQR83IORIsH8yztqd3s2C0xSLYXl0WCNjhChLZhpfmiYmj0=
MIME-Version: 1.0
In-Reply-To: <20180215141944.4332-1-christian.koenig@amd.com>
References: <20180215141944.4332-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Feb 2018 15:36:08 -0500
Message-ID: <CADnq5_PQPce3Xdn3_2Sh-=Y20m=xrVCGBrJ-LjhKdXp+7adrOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1FKaEx7021867

On Thu, Feb 15, 2018 at 9:19 AM, Christian König
<ckoenig.leichtzumerken@gmail.com> wrote:
> amdgpu needs to verify if userspace sends us valid addresses and the simplest
> way of doing this is to check if the buffer object is locked with the ticket
> of the current submission.
>
> Clean up the access to the ww_mutex internals by providing a function
> for this and extend the check to the thread owning the underlying mutex.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Shouldn't this be two patches?  One to add the new ww_mutex code and
one to update amdgpu?

Alex

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
>         *map = mapping;
>
>         /* Double check that the BO is reserved by this CS */
> -       if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
> +       if (!ww_mutex_is_owned_by(&(*bo)->tbo.resv->lock, current,
> +                                 &parser->ticket))
>                 return -EINVAL;
>
>         if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 39fda195bf78..dd580db289e8 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>         return mutex_is_locked(&lock->base);
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
> +                                       struct task_struct *task,
> +                                       struct ww_acquire_ctx *ctx)
> +{
> +       return likely(__mutex_owner(&lock->base) == task) &&
> +               READ_ONCE(lock->ctx) == ctx;
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

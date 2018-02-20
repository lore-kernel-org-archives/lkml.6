Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeBTQaW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:30:22 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46502 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBTQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:30:20 -0500
X-Google-Smtp-Source: AH8x225BPYFA8Mni5rMoNDEXbXsNmvIApk08JsYqW8+OrpTxh+Oyt8PZQ+Wp10lcVh/h7A+b7+cmug==
Date: Tue, 20 Feb 2018 17:30:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: peterz@infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/ww_mutex: add ww_mutex_is_owned_by function v4
Message-ID: <20180220163016.GZ22199@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        peterz@infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180220144946.2510-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220144946.2510-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 03:49:46PM +0100, Christian König wrote:
> amdgpu needs to verify if userspace sends us valid addresses and the simplest
> way of doing this is to check if the buffer object is locked with the ticket
> of the current submission.
> 
> Clean up the access to the ww_mutex internals by providing a function
> for this and extend the check to the thread owning the underlying mutex.
> 
> v2: split amdgpu changes into separate patch as suggested by Alex
> v3: change logic as suggested by Daniel
> v4: fix test in case ctx is NULL
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/ww_mutex.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 39fda195bf78..fea4acc0bcbc 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -358,4 +358,23 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>  	return mutex_is_locked(&lock->base);
>  }
>  
> +/**
> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
> + * @lock: the mutex to be queried
> + * @ctx: the w/w acquire context to test
> + *
> + * If @ctx is not NULL test if the mutex is owned by this context.
> + * If @ctx is NULL test if the mutex is owned by the current thread and not
> + * locked in any context.

Ok I think with the increased guarantees this needs a better kerneldoc, I
think we need to at least add ".... and not locked in any context, i.e.
acquired using either ww_mutex_trylock() or ww_mutex_lock() without
supplying a &ww_acquire_ctx."

I think with that we have a nice 1:1 mapping between the context you
supply to the ww_mutex_lock function and to this one. That means generic
code which takes a ctx (but can handle NULL) should dtrt no matter what.

With the kerneldoc augmented:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll probably regret this r-b too, but hey to err is human :-)

Cheers, Daniel

> + */
> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> +					struct ww_acquire_ctx *ctx)
> +{
> +	if (ctx)
> +		return likely(READ_ONCE(lock->ctx) == ctx);
> +
> +	return likely(__mutex_owner(&lock->base) == current) &&
> +		likely(READ_ONCE(lock->ctx) == NULL;
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBTOC5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:02:57 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43174 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBTOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:02:56 -0500
X-Google-Smtp-Source: AH8x226tf3teoQpWQiwgzYCZmhR2ih0UX2bwc7R0fcgHpDnWFm8Jy0K9STMjriPN6oAod9Q08ZIuTw==
Date: Tue, 20 Feb 2018 15:02:52 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220140252.GU22199@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220125829.27060-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 01:58:26PM +0100, Christian König wrote:
> amdgpu needs to verify if userspace sends us valid addresses and the simplest
> way of doing this is to check if the buffer object is locked with the ticket
> of the current submission.
> 
> Clean up the access to the ww_mutex internals by providing a function
> for this and extend the check to the thread owning the underlying mutex.
> 
> v2: split amdgpu changes into separate patch as suggested by Alex
> v3: change logic as suggested by Daniel
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/ww_mutex.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 39fda195bf78..14e4149d3d9d 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>  	return mutex_is_locked(&lock->base);
>  }
>  
> +/**
> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
> + * @lock: the mutex to be queried
> + * @ctx: the w/w acquire context to test
> + *
> + * If @ctx is not NULL test if the mutex is owned by this context.
> + * If @ctx is NULL test if the mutex is owned by the current thread.

This is a bit much how and not so much why, but I couldn't come up with a
concise text what was materially better.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> + */
> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> +					struct ww_acquire_ctx *ctx)
> +{
> +	if (ctx)
> +		return likely(READ_ONCE(lock->ctx) == ctx);
> +	else
> +		return likely(__mutex_owner(&lock->base) == current);
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

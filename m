Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeBTNNA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:13:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeBTNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:12:59 -0500
Date: Tue, 20 Feb 2018 14:12:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
Message-ID: <20180220131253.GF25314@hirez.programming.kicks-ass.net>
References: <20180220125829.27060-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220125829.27060-1-christian.koenig@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

> Signed-off-by: Christian König <christian.koenig@amd.com>

Much thanks for Cc'ing the relevant maintainers :/

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
> + */
> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
> +					struct ww_acquire_ctx *ctx)
> +{
> +	if (ctx)
> +		return likely(READ_ONCE(lock->ctx) == ctx);
> +	else
> +		return likely(__mutex_owner(&lock->base) == current);
> +}

Much better than the previous version. If you want to bike-shed, you can
leave out the 'else' and unindent the last line.

I do worry about potential users of .ctx = NULL, though. It makes it far
too easy to do recursive locking, which is something we should strongly
discourage.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeBTNEN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:04:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeBTNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:08 -0500
Date: Tue, 20 Feb 2018 13:35:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
Message-ID: <20180220123532.GD25314@hirez.programming.kicks-ass.net>
References: <20180215141944.4332-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180215141944.4332-1-christian.koenig@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This really should've been Cc'ed to me.

On Thu, Feb 15, 2018 at 03:19:42PM +0100, Christian König wrote:
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
> +}

Nak on that interface, that's racy and broken by design.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBWLiv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:38:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBWLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:38:50 -0500
Date: Fri, 23 Feb 2018 12:38:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 15/17] lockdep: Reduce the size of
 lock_list
Message-ID: <20180223113843.GY25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-16-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-16-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:09:02PM +0800, Boqun Feng wrote:
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index a1f91f8680bd..3fce8dbf5091 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -186,11 +186,11 @@ struct lock_list {
>  	struct list_head		entry;
>  	struct lock_class		*class;
>  	struct stack_trace		trace;
> -	int				distance;
> +	u16				distance;
>  	/* bitmap of different dependencies from head to this */
> -	u16				dep;
> +	u8				dep;
>  	/* used by BFS to record whether this is picked as a recursive read */
> -	u16				is_rr;
> +	bool				is_rr;

Don't use bool, use u8 if you want a single byte. sizeof(_Bool) is part
of the architecture ABI and can be up to 4 bytes (well really anything,
but I've not seen it bigger than 4 bytes for any sane implementation).

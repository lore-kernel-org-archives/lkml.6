Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeBVR3L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:29:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933390AbeBVR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:29:09 -0500
Date: Thu, 22 Feb 2018 18:29:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 07/17] lockdep: Adjust
 check_redundant() for recursive read change
Message-ID: <20180222172906.GU25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-8-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-8-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:54PM +0800, Boqun Feng wrote:
> As we have four kinds of dependencies now, check_redundant() should only
> report redundant if we have a dependency path which is equal or
> _stronger_ than the current dependency. For example if in
> check_prev_add() we have:
> 
> 	prev->read == 2 && next->read != 2
> 
> , we should only report redundant if we find a path like:
> 
> 	prev--(RN)-->....--(*N)-->next
> 
> and if we have:
> 
> 	prev->read == 2 && next->read == 2
> 
> , we could report redundant if we find a path like:
> 
> 	prev--(RN)-->....--(*N)-->next
> 
> or
> 
> 	prev--(RN)-->....--(*R)-->next
> 
> To do so, we need to pass the recursive-read status of @next into
> check_redundant().

Very hard to read that.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/locking/lockdep.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e1be088a34c4..0b0ad3db78b4 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1338,9 +1338,12 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
>  	return 0;
>  }
>  
> -static inline int class_equal(struct lock_list *entry, void *data)
> +static inline int hlock_equal(struct lock_list *entry, void *data)
>  {
> -	return entry->class == data;
> +	struct held_lock *hlock = (struct held_lock *)data;
> +
> +	return hlock_class(hlock) == entry->class &&
> +	       (hlock->read == 2 || !entry->is_rr);
>  }

So I guess @data = @next, and we're checking if @prev -> @next already
exists.

Since we only care about forward dependencies, @next->read==2 means *R
and if so, any existing link is equal or stronger. If @next->read!=2, it
means *N and we must regard *R as weaker and not match.

OK, that seems to be fine, but again, that function _really_ could do
with a comment.

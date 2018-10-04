Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA90AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF1213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCF1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeJDOHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:07:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbeJDOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51375ACC5;
        Thu,  4 Oct 2018 07:16:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 456061E3614; Thu,  4 Oct 2018 09:16:00 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:16:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v9 5/5] lib/dlock-list: Scale dlock_lists_empty()
Message-ID: <20181004071600.GC29482@quack2.suse.cz>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
 <1536780532-4092-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536780532-4092-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 15:28:52, Waiman Long wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Instead of the current O(N) implementation, at the cost
> of adding an atomic counter, we can convert the call to
> an atomic_read(). The counter only serves for accounting
> empty to non-empty transitions, and vice versa; therefore
> only modified twice for each of the lists during the
> lifetime of the dlock (while used).
> 
> In addition, to be able to unaccount a list_del(), we
> add a dlist pointer to each head, thus minimizing the
> overall memory footprint.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Acked-by: Waiman Long <longman@redhat.com>

So I was wondering: Is this really worth it? AFAICS we have a single call
site for dlock_lists_empty() and that happens during umount where we don't
really care about this optimization. So it seems like unnecessary
complication to me at this point? If someone comes up with a usecase that
needs fast dlock_lists_empty(), then sure, we can do this...

								Honza

> ---
>  include/linux/dlock-list.h |  8 ++++++
>  lib/dlock-list.c           | 67 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/dlock-list.h b/include/linux/dlock-list.h
> index 327cb9e..ac1a2e3 100644
> --- a/include/linux/dlock-list.h
> +++ b/include/linux/dlock-list.h
> @@ -32,10 +32,18 @@
>  struct dlock_list_head {
>  	struct list_head list;
>  	spinlock_t lock;
> +	struct dlock_list_heads *dlist;
>  } ____cacheline_aligned_in_smp;
>  
> +/*
> + * This is the main dlist data structure, with the array of heads
> + * and a counter that atomically tracks if any of the lists are
> + * being used. That is, empty to non-empty (and vice versa)
> + * head->list transitions.
> + */
>  struct dlock_list_heads {
>  	struct dlock_list_head *heads;
> +	atomic_t used_lists;
>  };
>  
>  /*
> diff --git a/lib/dlock-list.c b/lib/dlock-list.c
> index e286094..04da20d 100644
> --- a/lib/dlock-list.c
> +++ b/lib/dlock-list.c
> @@ -122,8 +122,11 @@ int __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
>  
>  		INIT_LIST_HEAD(&head->list);
>  		head->lock = __SPIN_LOCK_UNLOCKED(&head->lock);
> +		head->dlist = dlist;
>  		lockdep_set_class(&head->lock, key);
>  	}
> +
> +	atomic_set(&dlist->used_lists, 0);
>  	return 0;
>  }
>  EXPORT_SYMBOL(__alloc_dlock_list_heads);
> @@ -139,29 +142,36 @@ void free_dlock_list_heads(struct dlock_list_heads *dlist)
>  {
>  	kfree(dlist->heads);
>  	dlist->heads = NULL;
> +	atomic_set(&dlist->used_lists, 0);
>  }
>  EXPORT_SYMBOL(free_dlock_list_heads);
>  
>  /**
>   * dlock_lists_empty - Check if all the dlock lists are empty
>   * @dlist: Pointer to the dlock_list_heads structure
> - * Return: true if list is empty, false otherwise.
>   *
> - * This can be a pretty expensive function call. If this function is required
> - * in a performance critical path, we may have to maintain a global count
> - * of the list entries in the global dlock_list_heads structure instead.
> + * Return: true if all dlock lists are empty, false otherwise.
>   */
>  bool dlock_lists_empty(struct dlock_list_heads *dlist)
>  {
> -	int idx;
> -
>  	/* Shouldn't be called before nr_dlock_lists is initialized */
>  	WARN_ON_ONCE(!nr_dlock_lists);
>  
> -	for (idx = 0; idx < nr_dlock_lists; idx++)
> -		if (!list_empty(&dlist->heads[idx].list))
> -			return false;
> -	return true;
> +	/*
> +	 * Serialize dlist->used_lists such that a 0->1 transition is not
> +	 * missed by another thread checking if any of the dlock lists are
> +	 * used.
> +	 *
> +	 * CPU0				    CPU1
> +	 * dlock_list_add()                 dlock_lists_empty()
> +	 *   [S] atomic_inc(used_lists);
> +	 *       smp_mb__after_atomic();
> +	 *					  smp_mb__before_atomic();
> +	 *				      [L] atomic_read(used_lists)
> +	 *       list_add()
> +	 */
> +	smp_mb__before_atomic();
> +	return !atomic_read(&dlist->used_lists);
>  }
>  EXPORT_SYMBOL(dlock_lists_empty);
>  
> @@ -177,11 +187,39 @@ void dlock_lists_add(struct dlock_list_node *node,
>  		     struct dlock_list_heads *dlist)
>  {
>  	struct dlock_list_head *head = &dlist->heads[this_cpu_read(cpu2idx)];
> +	bool list_empty_before_lock = false;
> +
> +	/*
> +	 * Optimistically bump the used_lists counter _before_ taking
> +	 * the head->lock such that we don't miss a thread adding itself
> +	 * to a list while spinning for the lock.
> +	 *
> +	 * Then, after taking the lock, recheck if the empty to non-empty
> +	 * transition changed and (un)account for ourselves, accordingly.
> +	 * Note that all these scenarios are corner cases, and not the
> +	 * common scenario, where the lists are actually populated most
> +	 * of the time.
> +	 */
> +	if (unlikely(list_empty_careful(&head->list))) {
> +		list_empty_before_lock = true;
> +		atomic_inc(&dlist->used_lists);
> +		smp_mb__after_atomic();
> +	}
>  
>  	/*
>  	 * There is no need to disable preemption
>  	 */
>  	spin_lock(&head->lock);
> +
> +	if (unlikely(!list_empty_before_lock && list_empty(&head->list))) {
> +		atomic_inc(&dlist->used_lists);
> +		smp_mb__after_atomic();
> +	}
> +	if (unlikely(list_empty_before_lock && !list_empty(&head->list))) {
> +		atomic_dec(&dlist->used_lists);
> +		smp_mb__after_atomic();
> +	}
> +
>  	WRITE_ONCE(node->head, head);
>  	list_add(&node->list, &head->list);
>  	spin_unlock(&head->lock);
> @@ -212,6 +250,15 @@ void dlock_lists_del(struct dlock_list_node *node)
>  		spin_lock(&head->lock);
>  		if (likely(head == READ_ONCE(node->head))) {
>  			list_del_init(&node->list);
> +
> +			if (unlikely(list_empty(&head->list))) {
> +				struct dlock_list_heads *dlist;
> +				dlist = node->head->dlist;
> +
> +				atomic_dec(&dlist->used_lists);
> +				smp_mb__after_atomic();
> +			}
> +
>  			WRITE_ONCE(node->head, NULL);
>  			retry = false;
>  		} else {
> -- 
> 1.8.3.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B410C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E015B20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CL5A5T0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E015B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:14:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGMOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CsjCWJPRF5PYiVwchUprywdjHSYH26DBqNxhdM26OuE=; b=CL5A5T0y/+GKq0C0StbLzQbqg
        MRfQYSxU3NNPKcdG60JmSm7UpYzvYnrROq/3U+LqMxogJInshqyVOLQcfOAGIx+lzyL+nGZ8n0Fc5
        88Gav9d4+B1fRe8YVvnGE1igYgoC/LC4yqPoEDZ56QD9NKHMd38OiJDYoVSTJotwOII8F39vyaV7q
        vaF/kE+bNC5UvUl6h8NH532Qw6voqjMWuImNYLE8g2lIrihc+SAV8CcZwgpq95o01W36IBsjutylY
        h3OlgFvSyDEEo5eyGQD8kAh7Q+oqnsyo3Lar0jQMO0XlMtwoWMWzmHoFij8TRbisXaMNpDK84lrQv
        tVu8HTJ4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVF1c-00064c-Js; Fri, 07 Dec 2018 12:14:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D71EF2075BCED; Fri,  7 Dec 2018 13:14:29 +0100 (CET)
Date:   Fri, 7 Dec 2018 13:14:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 17/24] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20181207121429.GI2237@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
 <20181207011148.251812-18-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207011148.251812-18-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:11:41PM -0800, Bart Van Assche wrote:
> +	if (WARN_ON_ONCE(!hlock_class(prev)->hash_entry.pprev) ||
> +	    WARN_ONCE(!hlock_class(next)->hash_entry.pprev,
> +		      KERN_INFO "Detected use-after-free of lock class %s\n",
> +		      hlock_class(next)->name)) {
> +		return 2;
> +	}

Ah, this is that UaF on ->name, but it only happens when there's already
been a UaF, so that's fine I suppose. Still a note on that earlier
Changelog would've been nice I suppose.

> +/* Must be called with the graph lock held. */
> +static void remove_class_from_lock_chain(struct lock_chain *chain,
> +					 struct lock_class *class)
> +{
> +	u64 chain_key;
> +	int i;
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +	for (i = chain->base; i < chain->base + chain->depth; i++) {
> +		if (chain_hlocks[i] != class - lock_classes)
> +			continue;
> +		if (--chain->depth > 0)
 {
> +			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
> +				(chain->base + chain->depth - i) *
> +				sizeof(chain_hlocks[0]));
 }

Also, I suppose a comment here that notes we 'leak' chain_hlock[]
entries would be appropriate here.

If Waiman cares, it is possible to reclaim then by extending the above
memmove() to cover the _entire_ tail of the array and then going around
and fixing up all the chain->base 'pointers' that are in the moved part.

> +		/*
> +		 * Each lock class occurs at most once in a
> +		 * lock chain so once we found a match we can
> +		 * break out of this loop.
> +		 */
> +		goto recalc;
> +	}
> +	/* Since the chain has not been modified, return. */
> +	return;
> +
> +recalc:
> +	/*
> +	 * Note: calling hlist_del_rcu() from inside a
> +	 * hlist_for_each_entry_rcu() loop is safe.
> +	 */
> +	if (chain->depth == 0) {
> +		/* To do: decrease chain count. See also inc_chains(). */
> +		hlist_del_rcu(&chain->entry);
> +		return;
> +	}
> +	chain_key = 0;
> +	for (i = chain->base; i < chain->base + chain->depth; i++)
> +		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
> +	if (chain->chain_key == chain_key)
> +		return;
> +	hlist_del_rcu(&chain->entry);
> +	chain->chain_key = chain_key;
> +	hlist_add_head_rcu(&chain->entry, chainhashentry(chain_key));

I think this is broken; while hlist_del_rcu() and hlist_add_head_rcu()
are individually safe against concurrent hlist_for_each_entry_rcu(),
they cannot be used consecutively like this.

The thing is, hlist_del_rcu() preserves the ->next pointer such that
a concurrent hlist_for_each_entry_rcu() that happens to be at that entry
will be able to continue.

But your hlist_add_head_rcu() will overwrite that, so the concurrent
iterator, which started on one list will continue on another.

There must be an RCU-GP between del_rcu and add_rcu such that the above
situation cannot happen.


> +/*
> + * Free all lock classes that are on the zapped_classes list. Called as an
> + * RCU callback function.
> + */
> +static void free_zapped_classes(struct callback_head *ch)
> +{
> +	struct lock_class *class;
> +	unsigned long flags;
> +	int locked;
> +
> +	raw_local_irq_save(flags);
> +	locked = graph_lock();

If this fails; you must not touch any of the state. You don't hold the
lock after all.

> +	rcu_callback_scheduled = false;
> +	list_for_each_entry(class, &zapped_classes, lock_entry) {
> +		reinit_class(class);
> +		nr_lock_classes--;
> +	}
> +	list_splice_init(&zapped_classes, &free_lock_classes);
> +	if (locked)
> +		graph_unlock();
> +	raw_local_irq_restore(flags);
> +}
> +
> +/* Must be called with the graph lock held. */
> +static void schedule_free_zapped_classes(void)
> +{
> +	if (rcu_callback_scheduled)
> +		return;
> +	rcu_callback_scheduled = true;
> +	call_rcu(&free_zapped_classes_rcu_head, free_zapped_classes);
> +}

But I fear this is fundamentally broken too. In exactly the manner I
tried to explain earlier.

(sorry, wide(r) terminal required)

It starts out good:

	CPU0			CPU1				CPU2

	rcu_read_lock()
	// use class
				zap_class()
				schedule_free_zapped_classes();
				  call_rcu();

	rcu_read_lock()

				/* since none of the rcu_read_lock()
				 * sections we started out with are
				 * still active; this is where the
				 * callback _can_ happen */

But then, another user and and removal come in:

	rcu_read_lock();

	// use class						zap_class()
								  list_add(&entry, &zapped_classes)
								schedule_free_zapped_classes()
								  /* no-op, still pending */

				free_zapped_classes()
				  list_splice(&zapped_classes, &free_lock_classes)

				  *whoops* we just splice'd a class
				  onto the free list that is still in
				  use !!


	rcu_read_unlock()


There's two possible solutions:

 - the second schedule_free_zapped_classes() must somehow ensure the
   call_rcu() callback re-queues itself and waits for yet another GP, or

 - you must add classes zapped after the first invocation to a second
   list.



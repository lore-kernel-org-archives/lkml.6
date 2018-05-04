Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDXWT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:22:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeEDXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:22:18 -0400
Date: Fri, 4 May 2018 16:22:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save()
 + spin_lock
Message-Id: <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
In-Reply-To: <20180504153218.7301-1-bigeasy@linutronix.de>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 May 2018 17:32:18 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> percpu_ida() decouples disabling interrupts from the locking operations.
> This breaks some assumptions if the locking operations are replaced like
> they are under -RT.
> The same locking can be achieved by avoiding local_irq_save() and using
> spin_lock_irqsave() instead. percpu_ida_alloc() gains one more
> preemption point because after unlocking the fastpath and before the
> pool lock is acquired, the interrupts are briefly enabled.
> 

hmm..

> --- a/lib/percpu_ida.c
> +++ b/lib/percpu_ida.c
> @@ -147,20 +135,22 @@ int percpu_ida_alloc(struct percpu_ida *pool, int state)
>  	DEFINE_WAIT(wait);
>  	struct percpu_ida_cpu *tags;
>  	unsigned long flags;
> -	int tag;
> +	int tag = -ENOSPC;
>  
> -	local_irq_save(flags);
> -	tags = this_cpu_ptr(pool->tag_cpu);
> +	tags = raw_cpu_ptr(pool->tag_cpu);
> +	spin_lock_irqsave(&tags->lock, flags);

I *guess* this is OK.  If a preemption and schedule occurs we could end
up playing with a different CPU's data, but taking that cpu's data's
lock should prevent problems.

Unless there's a CPU hotunplug and that CPU's data vanishes under our
feet, but this code doesn't handle hotplug - it assumes all possible
CPUs are always present.

(798ab48eecdf659d says "Note that there's no cpu hotplug notifier - we
don't care, because ...")

>  	/* Fastpath */
> -	tag = alloc_local_tag(tags);
> -	if (likely(tag >= 0)) {
> -		local_irq_restore(flags);
> +	if (likely(tags->nr_free >= 0)) {
> +		tag = tags->freelist[--tags->nr_free];
> +		spin_unlock_irqrestore(&tags->lock, flags);
>  		return tag;
>  	}
> +	spin_unlock_irqrestore(&tags->lock, flags);
>  
>  	while (1) {
> -		spin_lock(&pool->lock);
> +		spin_lock_irqsave(&pool->lock, flags);
> +		tags = this_cpu_ptr(pool->tag_cpu);
>  
>  		/*
>  		 * prepare_to_wait() must come before steal_tags(), in case
>
> ...
>
> @@ -346,29 +327,27 @@ int percpu_ida_for_each_free(struct percpu_ida *pool, percpu_ida_cb fn,
>  	struct percpu_ida_cpu *remote;
>  	unsigned cpu, i, err = 0;
>  
> -	local_irq_save(flags);
>  	for_each_possible_cpu(cpu) {
>  		remote = per_cpu_ptr(pool->tag_cpu, cpu);
> -		spin_lock(&remote->lock);
> +		spin_lock_irqsave(&remote->lock, flags);
>  		for (i = 0; i < remote->nr_free; i++) {
>  			err = fn(remote->freelist[i], data);
>  			if (err)
>  				break;
>  		}
> -		spin_unlock(&remote->lock);
> +		spin_unlock_irqrestore(&remote->lock, flags);
>  		if (err)
>  			goto out;
>  	}
>  
> -	spin_lock(&pool->lock);
> +	spin_lock_irqsave(&pool->lock, flags);
>  	for (i = 0; i < pool->nr_free; i++) {
>  		err = fn(pool->freelist[i], data);
>  		if (err)
>  			break;
>  	}
> -	spin_unlock(&pool->lock);
> +	spin_unlock_irqrestore(&pool->lock, flags);
>  out:
> -	local_irq_restore(flags);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(percpu_ida_for_each_free);

Unrelated to this patch, but..  Why are there two loops here?  Won't
the first loop process all the data which the second loop attempts to
process?

This function has no callers anyway so perhaps we should just delete
it.

I'm feeling a bit hostile toward lib/percpu_ida.c in general ;) It has
very few users and seems rather complicated (what's with that
schedule() in percpu_ida_alloc?).  I'm suspecting and hoping that if
someone can figure out what the requirements were, this could all be
zapped and reimplemented using something else which we already have.

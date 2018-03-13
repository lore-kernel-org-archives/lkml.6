Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeCMVGP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:06:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50139 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbeCMVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:12 -0400
From: John Ogness <john.ogness@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
References: <20180223035814.GZ30522@ZenIV.linux.org.uk>
        <20180223040814.GA30522@ZenIV.linux.org.uk>
        <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
        <87zi3bn1on.fsf@linutronix.de>
Date: Tue, 13 Mar 2018 22:05:55 +0100
In-Reply-To: <87zi3bn1on.fsf@linutronix.de> (John Ogness's message of "Tue, 13
        Mar 2018 21:46:48 +0100")
Message-ID: <87lgevn0ss.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

1 minor issue on the new shrink_lock_dentry()...

> From 121a8e0834862d2c5d88c95f8e6bc8984f195abf Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Fri, 23 Feb 2018 21:54:18 -0500
> Subject: [PATCH] get rid of trylock loop in locking dentries on shrink
>  list
>
> In case of trylock failure don't re-add to the list - drop the locks
> and carefully get them in the right order.  For shrink_dentry_list(),
> somebody having grabbed a reference to dentry means that we can
> kick it off-list, so if we find dentry being modified under us we
> don't need to play silly buggers with retries anyway - off the list
> it is.
>
> The locking logics taken out into a helper of its own; lock_parent()
> is no longer used for dentries that can be killed under us.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/dcache.c | 103 ++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 66 insertions(+), 37 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1684b6b..58097fd 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -974,56 +974,85 @@ void d_prune_aliases(struct inode *inode)
>  }
>  EXPORT_SYMBOL(d_prune_aliases);
>  
> -static void shrink_dentry_list(struct list_head *list)
> +/*
> + * Lock a dentry from shrink list.
> + * Note that dentry is *not* protected from concurrent dentry_kill(),
> + * d_delete(), etc.  It is protected from freeing (by the fact of
> + * being on a shrink list), but everything else is fair game.
> + * Return false if dentry has been disrupted or grabbed, leaving
> + * the caller to kick it off-list.  Otherwise, return true and have
> + * that dentry's inode and parent both locked.
> + */
> +static bool shrink_lock_dentry(struct dentry *dentry)
>  {
> -	struct dentry *dentry, *parent;
> +	struct inode *inode;
> +	struct dentry *parent;
>  
> -	while (!list_empty(list)) {
> -		struct inode *inode;
> -		dentry = list_entry(list->prev, struct dentry, d_lru);
> +	if (dentry->d_lockref.count)
> +		return false;
> +
> +	inode = dentry->d_inode;
> +	if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
> +		rcu_read_lock();	/* to protect inode */
> +		spin_unlock(&dentry->d_lock);
> +		spin_lock(&inode->i_lock);
>  		spin_lock(&dentry->d_lock);
> -		parent = lock_parent(dentry);
> +		if (unlikely(dentry->d_lockref.count))
> +			goto out;
> +		/* changed inode means that somebody had grabbed it */
> +		if (unlikely(inode != dentry->d_inode))
> +			goto out;
> +		rcu_read_unlock();
> +	}
>  
> -		/*
> -		 * The dispose list is isolated and dentries are not accounted
> -		 * to the LRU here, so we can simply remove it from the list
> -		 * here regardless of whether it is referenced or not.
> -		 */
> -		d_shrink_del(dentry);
> +	parent = dentry->d_parent;
> +	if (IS_ROOT(dentry) || likely(spin_trylock(&parent->d_lock)))
> +		return true;
>  
> -		/*
> -		 * We found an inuse dentry which was not removed from
> -		 * the LRU because of laziness during lookup. Do not free it.
> -		 */
> -		if (dentry->d_lockref.count > 0) {
> -			spin_unlock(&dentry->d_lock);
> -			if (parent)
> -				spin_unlock(&parent->d_lock);
> -			continue;
> -		}
> +	rcu_read_lock();		/* to protect parent */
> +	spin_unlock(&dentry->d_lock);
> +	parent = READ_ONCE(dentry->d_parent);

The preceeding line should be removed. We already have a "parent" from
before we did the most recent trylock().

> +	spin_lock(&parent->d_lock);
> +	if (unlikely(parent != dentry->d_parent)) {
> +		spin_unlock(&parent->d_lock);
> +		spin_lock(&dentry->d_lock);
> +		goto out;
> +	}
> +	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
> +	if (likely(!dentry->d_lockref.count)) {
> +		rcu_read_unlock();
> +		return true;
> +	}
> +	spin_unlock(&parent->d_lock);
> +out:
> +	spin_unlock(&inode->i_lock);
> +	rcu_read_unlock();
> +	return false;
> +}
>  
> +static void shrink_dentry_list(struct list_head *list)
> +{
> +	while (!list_empty(list)) {
> +		struct dentry *dentry, *parent;
> +		struct inode *inode;
>  
> -		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
> -			bool can_free = dentry->d_flags & DCACHE_MAY_FREE;
> +		dentry = list_entry(list->prev, struct dentry, d_lru);
> +		spin_lock(&dentry->d_lock);
> +		if (!shrink_lock_dentry(dentry)) {
> +			bool can_free = false;
> +			d_shrink_del(dentry);
> +			if (dentry->d_lockref.count < 0)
> +				can_free = dentry->d_flags & DCACHE_MAY_FREE;
>  			spin_unlock(&dentry->d_lock);
> -			if (parent)
> -				spin_unlock(&parent->d_lock);
>  			if (can_free)
>  				dentry_free(dentry);
>  			continue;
>  		}
> -
> -		inode = dentry->d_inode;
> -		if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
> -			d_shrink_add(dentry, list);
> -			spin_unlock(&dentry->d_lock);
> -			if (parent)
> -				spin_unlock(&parent->d_lock);
> -			continue;
> -		}
> -
> +		d_shrink_del(dentry);
> +		parent = dentry->d_parent;
>  		__dentry_kill(dentry);
> -
> +		if (parent == dentry)
> +			continue;
>  		/*
>  		 * We need to prune ancestors too. This is necessary to prevent
>  		 * quadratic behavior of shrink_dcache_parent(), but is also

John Ogness

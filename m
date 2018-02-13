Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964831AbeBMNQh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:16:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964775AbeBMNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:16:36 -0500
Date: Tue, 13 Feb 2018 14:16:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: dcache: Avoid livelock between d_alloc_parallel and
 __d_add
Message-ID: <20180213131633.GI25201@hirez.programming.kicks-ass.net>
References: <1518526731-26546-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518526731-26546-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 12:58:51PM +0000, Will Deacon wrote:
> If d_alloc_parallel runs concurrently with __d_add, it is possible for
> d_alloc_parallel to continuously retry whilst i_dir_seq has been
> incremented to an odd value by __d_add:
> 
> CPU0:
> __d_add
> 	n = start_dir_add(dir);
> 		cmpxchg(&dir->i_dir_seq, n, n + 1) == n
> 
> CPU1:
> d_alloc_parallel
> retry:
> 	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
> 	hlist_bl_lock(b);
> 		bit_spin_lock(0, (unsigned long *)b); // Always succeeds
> 
> CPU0:
> 	__d_lookup_done(dentry)
> 		hlist_bl_lock
> 			bit_spin_lock(0, (unsigned long *)b); // Never succeeds
> 
> CPU1:
> 	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
> 		hlist_bl_unlock(b);
> 		goto retry;
> 	}
> 
> Since the simple bit_spin_lock used to implement hlist_bl_lock does not

And cannot, a single bit is just not enough state.

> provide any fairness guarantees, then CPU1 can starve CPU0 of the lock
> and prevent it from reaching end_dir_add(dir), therefore CPU1 cannot
> exit its retry loop because the sequence number always has the bottom
> bit set.
> 
> This patch resolves the livelock by not taking hlist_bl_lock in
> d_alloc_parallel if the sequence counter is odd, since any subsequent
> masked comparison with i_dir_seq will fail anyway.
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  fs/dcache.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7c38f39958bc..b243deec298c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2474,7 +2474,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  
>  retry:
>  	rcu_read_lock();
> -	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
> +	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
>  	r_seq = read_seqbegin(&rename_lock);
>  	dentry = __d_lookup_rcu(parent, name, &d_seq);
>  	if (unlikely(dentry)) {
> @@ -2495,6 +2495,12 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  		rcu_read_unlock();
>  		goto retry;
>  	}
> +
> +	if (unlikely(seq & 1)) {
> +		rcu_read_unlock();
> +		goto retry;
> +	}
> +
>  	hlist_bl_lock(b);
>  	if (unlikely(parent->d_inode->i_dir_seq != seq)) {

Also, should that not read:

	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {

I mean, load-tearing can only result in additional failure, but still.

>  		hlist_bl_unlock(b);

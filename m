Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB0FQh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:16:37 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45299 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeB0FQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:16:34 -0500
From: John Ogness <john.ogness@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
References: <20180222235025.28662-1-john.ogness@linutronix.de>
        <20180222235025.28662-7-john.ogness@linutronix.de>
        <20180223035814.GZ30522@ZenIV.linux.org.uk>
        <20180223040814.GA30522@ZenIV.linux.org.uk>
        <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
Date: Tue, 27 Feb 2018 06:16:28 +0100
In-Reply-To: <20180225073950.GI30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Sun, 25 Feb 2018 07:40:05 +0000")
Message-ID: <87bmgbnhar.fsf_-_@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-25, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> I'll play with cleaning up and reordering tomorrow after I get some
> sleep.  In the meanwhile, the current state of that set is at
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache

I have one comment on your new dentry_kill()...

> From e77db95d1ad189c76bcda7b90ac2225e98d776a2 Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Fri, 23 Feb 2018 21:25:42 -0500
> Subject: [PATCH] get rid of trylock loop around dentry_kill()
>
> In case when trylock in there fails, deal with it directly in
> dentry_kill().  Note that in cases when we drop and retake
> ->d_lock, we need to recheck whether to retain the dentry.
> Another thing is that dropping/retaking ->d_lock might have
> ended up with negative dentry turning into positive; that,
> of course, can happen only once...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/dcache.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 449c1a5..c1f082d 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -657,23 +657,43 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>  	struct dentry *parent = NULL;
>  
>  	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
> -		goto failed;
> +		goto slow_positive;
>  
>  	if (!IS_ROOT(dentry)) {
>  		parent = dentry->d_parent;
>  		if (unlikely(!spin_trylock(&parent->d_lock))) {
> -			if (inode)
> -				spin_unlock(&inode->i_lock);
> -			goto failed;
> +			parent = __lock_parent(dentry);
> +			if (likely(inode || !dentry->d_inode))
> +				goto got_locks;
> +			/* negative that became positive */
> +			if (parent)
> +				spin_unlock(&parent->d_lock);
> +			inode = dentry->d_inode;
> +			goto slow_positive;
>  		}
>  	}
> -
>  	__dentry_kill(dentry);
>  	return parent;
>  
> -failed:
> +slow_positive:
> +	spin_unlock(&dentry->d_lock);
> +	spin_lock(&inode->i_lock);
> +	spin_lock(&dentry->d_lock);
> +	parent = lock_parent(dentry);
> +got_locks:
> +	if (likely(dentry->d_lockref.count == 1 && !retain_dentry(dentry))) {
> +		__dentry_kill(dentry);
> +		return parent;
> +	}
> +	/* we are keeping it, after all */
> +	if (inode)
> +		spin_unlock(&inode->i_lock);
> +	if (parent)
> +		spin_unlock(&parent->d_lock);

If someone else has grabbed a reference, it shouldn't be added to the
lru list. Only decremented.

if (entry->d_lockref.count == 1)

> +	dentry_lru_add(dentry);
> +	dentry->d_lockref.count--;
>  	spin_unlock(&dentry->d_lock);
> -	return dentry; /* try again with same dentry */
> +	return NULL;
>  }
>  
>  /*

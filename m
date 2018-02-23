Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeBWRmT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:42:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33230 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeBWRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:42:17 -0500
Date: Fri, 23 Feb 2018 17:42:16 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in
 shrink_dentry_list()
Message-ID: <20180223174216.GD30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223150928.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 03:09:28PM +0000, Al Viro wrote:
> You are conflating the "we have a reference" cases with this one, and
> they are very different.  Note, BTW, that had we raced with somebody
> else grabbing a reference, we would've quietly dropped dentry from
> the shrink list; what if we do the following: just after checking that
> refcount is not positive, do
> 	inode = dentry->d_inode;
> 	if unlikely(inode && !spin_trylock...)
> 		rcu_read_lock
> 		drop ->d_lock
> 		grab inode->i_lock
> 		grab ->d_lock
> 		if unlikely(dentry->d_inode != inode)
> 			drop inode->i_lock
> 			rcu_read_unlock
> 			if !killed
> 				drop ->d_lock
> 				drop parent's ->d_lock
> 				continue;
> 		else
> 			rcu_read_unlock
> *before* going into
>                 if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
>                         bool can_free = dentry->d_flags & DCACHE_MAY_FREE;
>                         spin_unlock(&dentry->d_lock);
> 			...
> part?

Owww....  It's actually even nastier than I realized - dropping ->d_lock
opens us to having the sucker freed by dput() from another thread here.
IOW, between d_shrink_del(dentry) and __dentry_kill(dentry) dropping ->d_lock
is dangerous...

It's really very different from all other cases, and the trickiest by far.

FWIW, my impression from the series:
	1) dentry_kill() should deal with trylock failures on its own, leaving
the callers only the real "we need to drop the parent" case.  See upthread for
one variant of doing that.
	2) switching parent eviction in shrink_dentry_list() to dentry_kill()
is fine.
	3) for d_delete() trylock loop is wrong; however, it does not need
anything more elaborate than
{
        struct inode *inode;
        int isdir = d_is_dir(dentry);
        /*
         * Are we the only user?
         */
        spin_lock(&dentry->d_lock);
        if (dentry->d_lockref.count != 1)
		goto Shared;

        inode = dentry->d_inode;
	if (unlikely(!spin_trylock(&inode->i_lock))) {
		spin_unlock(&dentry->d_lock);
		spin_lock(&inode->i_lock);
		spin_lock(&dentry->d_lock);
		if (dentry->d_lockref.count != 1) {
			spin_unlock(&inode->i_lock);
			goto Shared;
		}
	}
           
	dentry->d_flags &= ~DCACHE_CANT_MOUNT;
	dentry_unlink_inode(dentry);
	fsnotify_nameremove(dentry, isdir);
	return;

Shared:	/* can't make it negative, must unhash */
        if (!d_unhashed(dentry))
                __d_drop(dentry);
        spin_unlock(&dentry->d_lock);

        fsnotify_nameremove(dentry, isdir);
}

If not an outright "lock inode first from the very beginning" - note that
inode is stable (and non-NULL) here.  IOW, that needs to be compared with
{
        struct inode *inode = dentry->d_inode;
        int isdir = d_is_dir(dentry);
        spin_lock(&inode->i_lock);
        spin_lock(&dentry->d_lock);
        /*
         * Are we the only user?
         */
        if (dentry->d_lockref.count == 1) {
		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
		dentry_unlink_inode(dentry);
	} else {
		if (!d_unhashed(dentry))
			__d_drop(dentry);
		spin_unlock(&dentry->d_lock);
		spin_unlock(&inode->i_lock);
	}
	fsnotify_nameremove(dentry, isdir);
}

That costs an extra boinking the ->i_lock in case dentry is shared, but it's
much shorter and simpler that way.  Needs profiling; if the second variant
does not give worse performance, I would definitely prefer that one.
	4) the nasty one - shrink_dentry_list() evictions of zero-count dentries.
_That_ calls for careful use of RCU, etc. - none of the others need that.  Need
to think how to deal with that sucker; in any case, I do not believe that sharing
said RCU use, etc. with any other cases would do anything other than obfuscating
the rest.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBWDMR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:12:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41938 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeBWDMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:12:16 -0500
Date: Fri, 23 Feb 2018 03:12:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs/dcache: Avoid the try_lock loops in
 dentry_kill()
Message-ID: <20180223031214.GW30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-5-john.ogness@linutronix.de>
 <20180223022242.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223022242.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 02:22:43AM +0000, Al Viro wrote:

> No.  This is completely wrong.  If somebody else has found the sucker
> while we dropped the lock and even got around to playing with refcount,
> they might have done more than that.
> 
> In particular, they might have *dropped* their reference, after e.g.
> picking it as our inode's alias and rehashed the fucker.  Making
> our decision not to retain it no longer valid.  And your code will
> not notice that.

PS: I really wonder if we should treat the failure to trylock ->i_lock
and parent's ->d_lock at that point (we are already off the fast path
here) as
	* drop all spinlocks we'd got
	* grab ->i_lock
	* grab ->d_lock
	* lock_parent()
	* act as if fast_dput() has returned 0, only remember to drop ->i_lock
and unlock parent before dropping ->d_lock if we decide to keep it.

IOW, add

static inline bool retain_dentry(struct dentry *dentry)
{
        WARN_ON(d_in_lookup(dentry));

        /* Unreachable? Get rid of it */
        if (unlikely(d_unhashed(dentry)))
                return false;

        if (unlikely(dentry->d_flags & DCACHE_DISCONNECTED))
                return false;

        if (unlikely(dentry->d_flags & DCACHE_OP_DELETE)) {
                if (dentry->d_op->d_delete(dentry))
                        return false;
        }

	dentry_lru_add(dentry);
	dentry->d_lockref.count--;
	return true;
}

then have dput() do
{
        if (unlikely(!dentry))
                return;
repeat:
        might_sleep();

        rcu_read_lock();
        if (likely(fast_dput(dentry))) {
                rcu_read_unlock();
                return;
        }

        /* Slow case: now with the dentry lock held */
        rcu_read_unlock();
	if (likely(retain_dentry(dentry))) {
		spin_unlock(&dentry->d_lock);
		return;
	}
	dentry = dentry_kill(dentry);
	if (dentry)
		goto repeat;
}

with dentry_kill() being pretty much as it is now, except that
it would be ending on

failed:
	spin_unlock(&dentry->d_lock);
	spin_lock(&inode->i_lock);
	spin_lock(&dentry->d_lock);
	parent = lock_parent(dentry);
	/* retain_dentry() needs ->count == 1 already checked)
	if (dentry->d_lockref.count == 1 && !retain_dentry(dentry)) {
		__dentry_kill(dentry);
		return parent;
	}
	/* we are keeping it, after all */
	if (inode)
		spin_unlock(&inode->i_lock);
	spin_unlock(&dentry->d_lock);
	if (parent)
		spin_unlock(&parent->d_lock);
	return NULL;
}

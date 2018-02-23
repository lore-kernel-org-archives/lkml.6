Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeBWPJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:09:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56010 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBWPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:09:29 -0500
Date: Fri, 23 Feb 2018 15:09:28 +0000
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
Message-ID: <20180223150928.GC30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8q7erlo.fsf@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 02:57:23PM +0100, John Ogness wrote:

> > Actually, it's even worse - _here_ you are dealing with something that
> > really can change inode under you.  This is one and only case where we
> > are kicking out a zero-refcount dentry without having already held
> > ->i_lock.  At the very least, it's bloody different from regular
> > dentry_kill().  In this case, dentry itself is protected from freeing
> > by being on the shrink list - that's what makes __dentry_kill() to
> > leave the sucker allocated.  We are not holding references, it is
> > hashed and anybody could come, pick it, d_delete() it, etc.
> 
> Yes, and that is why the new dentry_lock_inode() and dentry_kill()
> functions react to any changes in refcount and check for inode
> changes. Obviously for d_delete() the helper functions are checking way
> more than they need to. But if we've missed the trylock optimization
> we're already in the unlikely case, so the extra checks _may_ be
> acceptable in order to have simplified code. As Linus already pointed
> out, the cost of spinning will likely overshadow the cost of a few
> compares.

It's not that you are checking extra things - you are checking the wrong
things.  "Refcount has returned to original" is useless.

> Do you recommend I avoid consolidating the 4 trylock loops into the same
> set of helper functions and instead handle them all separately (as is
> the case in mainline)?
> 
> Or maybe the problem is how my patchset is assembling the final
> result. If patch 3 and 4 were refined to address your concerns about
> them but then by the end of the 6th patch we still end up where we are
> now, is that something that is palatable?

No.  The place where you end up with dput() is flat-out wrong.

> IOW, do the patches only need (possibly a lot of) refinement or do you
> consider this approach fundamentally flawed?

You are conflating the "we have a reference" cases with this one, and
they are very different.  Note, BTW, that had we raced with somebody
else grabbing a reference, we would've quietly dropped dentry from
the shrink list; what if we do the following: just after checking that
refcount is not positive, do
	inode = dentry->d_inode;
	if unlikely(inode && !spin_trylock...)
		rcu_read_lock
		drop ->d_lock
		grab inode->i_lock
		grab ->d_lock
		if unlikely(dentry->d_inode != inode)
			drop inode->i_lock
			rcu_read_unlock
			if !killed
				drop ->d_lock
				drop parent's ->d_lock
				continue;
		else
			rcu_read_unlock
*before* going into
                if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
                        bool can_free = dentry->d_flags & DCACHE_MAY_FREE;
                        spin_unlock(&dentry->d_lock);
			...
part?

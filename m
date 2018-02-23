Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755073AbeBWUNW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:13:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41716 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754653AbeBWUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:13:18 -0500
Date: Fri, 23 Feb 2018 20:13:17 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: [BUG] lock_parent() breakage when used from shrink_dentry_list()
 (was Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in
 shrink_dentry_list())
Message-ID: <20180223201317.GG30522@ZenIV.linux.org.uk>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
 <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223174216.GD30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 05:42:16PM +0000, Al Viro wrote:

> 	4) the nasty one - shrink_dentry_list() evictions of zero-count dentries.
> _That_ calls for careful use of RCU, etc. - none of the others need that.  Need
> to think how to deal with that sucker; in any case, I do not believe that sharing
> said RCU use, etc. with any other cases would do anything other than obfuscating
> the rest.

Arrrgh...  Actually, there's a nasty corner case where the variant in mainline is
broken.  Look:
	dentry placed on a shrink list
	we pick the fucker from the list and lock it.
	we call lock_parent() on it.
		dentry is not a root and it's not deleted, so we proceed.
		trylock fails.
		we grab rcu_read_lock()
		we drop dentry->d_lock
	on another CPU, something does e.g. d_prune_aliases() (or finds the
	sucker in hash and proceeds to unhash and dput(), etc.) - anything
	that evicts that dentry.  It is marked with DCACHE_MAY_FREE and left
	alone.  The parent, OTOH, is dropped and freeing gets scheduled as
	soon as RCU allows.
		we grab parent->d_lock
		we verify that dentry->d_parent is still the same (it is)
		we do rcu_read_unlock()
		we grab dentry->d_lock
		we return parent
At that point we are fucked - there's nothing to prevent parent from being
freed at any point.  And we assume that its ->d_lock is held and needs to
be dropped.

The call site in d_prune_aliases() avoids the same scenario, since there we
are already holding ->i_lock and another thread won't get to __dentry_kill()
until we are done with lock_parent().

Unless I'm missing something, that's a (narrow) memory corruptor.  The window is
narrow, but not impossibly so - if that other thread had been spinning on attempt
to grab dentry->d_lock in d_prune_alias(), it has to squeeze through
                if (!dentry->d_lockref.count) {
and then in lock_parent() called there - through
        if (IS_ROOT(dentry))
                return NULL;
        if (unlikely(dentry->d_lockref.count < 0))
                return NULL;
        if (likely(spin_trylock(&parent->d_lock)))
before the first CPU gets through
        parent = READ_ONCE(dentry->d_parent);
        spin_lock(&parent->d_lock);

The first CPU can't be preempted, but there's nothing to prevent an IRQ arriving
at that point, letting the second one win the race.

Comments?

I think the (untested) patch below is -stable fodder:

lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

In case when dentry passed to lock_parent() is protected from freeing only
by the fact that it's on a shrink list and trylock of parent fails, we
could get hit by __dentry_kill() (and subsequent dentry_kill(parent))
between unlocking dentry and locking presumed parent.  We need to recheck
that dentry is alive once we lock both it and parent *and* postpone
rcu_read_unlock() until after that point.  Otherwise we could return
a pointer to struct dentry that already is rcu-scheduled for freeing, with
->d_lock held on it; caller's subsequent attempt to unlock it can end
up with memory corruption.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/dcache.c b/fs/dcache.c
index 7c38f39958bc..32aaab21e648 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -647,11 +647,16 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 		spin_unlock(&parent->d_lock);
 		goto again;
 	}
-	rcu_read_unlock();
-	if (parent != dentry)
+	if (parent != dentry) {
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			spin_unlock(&parent->d_lock);
+			parent = NULL;
+		}
+	} else {
 		parent = NULL;
+	}
+	rcu_read_unlock();
 	return parent;
 }
 

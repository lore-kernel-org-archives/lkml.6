Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeCMX7f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:59:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42590 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbeCMX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:59:33 -0400
Date: Tue, 13 Mar 2018 23:59:30 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent()
 breakage when used from shrink_dentry_list())
Message-ID: <20180313235930.GX30522@ZenIV.linux.org.uk>
References: <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <87zi3bn1on.fsf@linutronix.de>
 <87lgevn0ss.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgevn0ss.fsf@linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:05:55PM +0100, John Ogness wrote:

> > +	rcu_read_lock();		/* to protect parent */
> > +	spin_unlock(&dentry->d_lock);
> > +	parent = READ_ONCE(dentry->d_parent);
> 
> The preceeding line should be removed. We already have a "parent" from
> before we did the most recent trylock().

Nope.  We have parent, yes, but it had been fetched outside of rcu_read_lock().
So the object it used to point to might have been already freed and we
can't do this:

> > +	spin_lock(&parent->d_lock);

To get rid of that reread we'd need to do this:
	rcu_read_lock();
        parent = dentry->d_parent;
        if (IS_ROOT(dentry) || likely(spin_trylock(&parent->d_lock))) {
		rcu_read_unlock();
                return true;
	}
        spin_unlock(&dentry->d_lock);
        spin_lock(&parent->d_lock);
        if (unlikely(parent != dentry->d_parent)) {
		....

Come to think of that, it might make sense to lift rcu_read_lock() all the
way out of that sucker.  Objections?  Below is the incremental I'd fold into
that commit:

diff --git a/fs/dcache.c b/fs/dcache.c
index f0e73c93182b..0d1dac750c0a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1000,7 +1000,6 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 
 	inode = dentry->d_inode;
 	if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
-		rcu_read_lock();	/* to protect inode */
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&inode->i_lock);
 		spin_lock(&dentry->d_lock);
@@ -1009,16 +1008,14 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 		/* changed inode means that somebody had grabbed it */
 		if (unlikely(inode != dentry->d_inode))
 			goto out;
-		rcu_read_unlock();
 	}
 
 	parent = dentry->d_parent;
+	/* parent will stay allocated until we drop rcu_read_lock */
 	if (IS_ROOT(dentry) || likely(spin_trylock(&parent->d_lock)))
 		return true;
 
-	rcu_read_lock();		/* to protect parent */
 	spin_unlock(&dentry->d_lock);
-	parent = READ_ONCE(dentry->d_parent);
 	spin_lock(&parent->d_lock);
 	if (unlikely(parent != dentry->d_parent)) {
 		spin_unlock(&parent->d_lock);
@@ -1026,14 +1023,11 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 		goto out;
 	}
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	if (likely(!dentry->d_lockref.count)) {
-		rcu_read_unlock();
+	if (likely(!dentry->d_lockref.count))
 		return true;
-	}
 	spin_unlock(&parent->d_lock);
 out:
 	spin_unlock(&inode->i_lock);
-	rcu_read_unlock();
 	return false;
 }
 
@@ -1044,8 +1038,10 @@ static void shrink_dentry_list(struct list_head *list)
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
+		rcu_read_lock();
 		if (!shrink_lock_dentry(dentry)) {
 			bool can_free = false;
+			rcu_read_unlock();
 			d_shrink_del(dentry);
 			if (dentry->d_lockref.count < 0)
 				can_free = dentry->d_flags & DCACHE_MAY_FREE;
@@ -1054,6 +1050,7 @@ static void shrink_dentry_list(struct list_head *list)
 				dentry_free(dentry);
 			continue;
 		}
+		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
 		__dentry_kill(dentry);

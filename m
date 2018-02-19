Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeBSXfU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:35:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbeBSXfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:35:18 -0500
From: John Ogness <john.ogness@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
References: <20180216150933.971-1-john.ogness@linutronix.de>
        <20180216150933.971-5-john.ogness@linutronix.de>
        <CA+55aFyo6jrvU62DiwKJZaTnmwLYQe4krNJCbAUui8R+=bDVdQ@mail.gmail.com>
        <87y3js36s7.fsf@linutronix.de>
        <CA+55aFxku7bB9BEBrqgREc5ac4MK9CGLir1c7ZA-7bjp-Q2tAg@mail.gmail.com>
        <87r2pk358g.fsf@linutronix.de>
        <CA+55aFzfug3S_dRrHDh=Zdat0KZVar13NQVzyqXd3-xHLzeSjA@mail.gmail.com>
        <87lgfs3374.fsf@linutronix.de>
        <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
Date: Tue, 20 Feb 2018 00:34:57 +0100
In-Reply-To: <CA+55aFySL+exqUJX0JKmJY4Pa0CKwn9y4Voqs1QjWY29hkzhnQ@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 16 Feb 2018 16:06:36 -0800")
Message-ID: <878tbov9i6.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> After reading your initial feedback my idea was to change both
>> lock_parent() and dentry_lock_inode() to not only communicate _if_
>> the lock was successful, but also if d_lock was dropped in the
>> process. (For example, with a tristate rather than boolean return
>> value.) Then callers would know if they needed to recheck the dentry
>> contents.
>
> So I think that would work well for your dentry_lock_inode() helper,
> and might indeed solve my reaction to your dentry_kill() patch.

I have looked at different implementations and am not clearly convinced
the way to suggest for my v2 patchset. I am also considering avoiding
the fast case and just changing the misleading comments.

Here are 3 different code snippets from a possible v2 dentry_kill()
implementation:

---->8----
Implementation 1: Stay with the original patch implementation but
fix the comments so that they are not misleading. Supports branch
prediction but code assumes trylock failed. This is the simplest
approach.

                /*
                 * Lock the inode. Might drop dentry->d_lock temporarily
                 * which allows inode to change. Start over if that happens.
                 */
                if (unlikely(!dentry_lock_inode(dentry)))
                        goto again;

                /*
                 * Check refcount because it might have incremented
                 * if d_lock was temporarily dropped.
                 */
                if (unlikely(dentry->d_lockref.count != 1))
                        goto drop_ref;

---->8----
Implementation 2: Using switch on a dentry_lock_inode() that returns a
tristate value. Does not support branch prediction. This approach is
probably easiest to understand.

 		/*
 		 * Lock the inode. Might drop dentry->d_lock temporarily
 		 * which allows inode to change. Start over if that happens.
 		 */
                switch (dentry_lock_inode(dentry)) {
                case LOCK_FAST:
                        break;
                case LOCK_SLOW:
                        /*
                         * Recheck refcount as it might have been
                         * incremented while d_lock was dropped.
                         */
                        if (unlikely(dentry->d_lockref.count != 1))
                                goto drop_ref;
                        break;
                case LOCK_FAILED:
                        goto again;
                }

---->8----
Implementation 3: The same as implementation 2 but using if's to
support branch prediction. This approach is probably the most
complicated to understand but will be the fastest.

 		/*
 		 * Lock the inode. Might drop dentry->d_lock temporarily
 		 * which allows inode to change. Start over if that happens.
 		 */
                int ret = dentry_lock_inode(dentry);
                if (unlikely(ret != LOCK_FAST)) {
                        if (ret == LOCK_FAILED)
                                goto again;
                        /*
                         * Recheck refcount as it might have been
                         * incremented while d_lock was dropped.
                         */
                        if (dentry->d_lockref.count != 1)
                                goto drop_ref;
                }

---->8----

> I suspect it doesn't work for lock_parent(), because that has to also
> return the parent itself. So you'd have to add another way to say
> "didn't need to drop dentry lock". I suspect it gets ugly real fast.

If lock_parent() returns a non-NULL, it is returning
dentry->d_parent. So the return value is really just a boolean and the
locked parent is the parent of the dentry. The function is a little bit
tricky because it could return NULL (lock failed) even if the dentry has
a non-NULL d_parent. So any caller using a tristate return variation of
lock_parent() must rely on the return value instead of a non-NULL
dentry->d_parent.

Taking all that into account, the changes are fairly straight forward.

---->8----
Change lock_parent() to return tristate lock status instead of a pointer
to the locked dentry->d_parent.

diff --git a/fs/dcache.c b/fs/dcache.c
index b557679c14c9..53074243ce48 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -589,15 +589,15 @@ static void __dentry_kill(struct dentry *dentry)
 		dentry_free(dentry);
 }
 
-static inline struct dentry *lock_parent(struct dentry *dentry)
+static inline int lock_parent(struct dentry *dentry)
 {
 	struct dentry *parent = dentry->d_parent;
 	if (IS_ROOT(dentry))
-		return NULL;
+		return LOCK_FAILED;
 	if (unlikely(dentry->d_lockref.count < 0))
-		return NULL;
+		return LOCK_FAILED;
 	if (likely(spin_trylock(&parent->d_lock)))
-		return parent;
+		return LOCK_FAST;
 	rcu_read_lock();
 	spin_unlock(&dentry->d_lock);
 again:
@@ -616,11 +616,11 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 		goto again;
 	}
 	rcu_read_unlock();
-	if (parent != dentry)
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	else
-		parent = NULL;
-	return parent;
+	if (parent == dentry)
+		return LOCK_FAILED;
+
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+	return LOCK_SLOW;
 }
 
 /**
@@ -1035,19 +1035,21 @@ EXPORT_SYMBOL(d_find_alias);
  */
 void d_prune_aliases(struct inode *inode)
 {
+	struct dentry *parent;
 	struct dentry *dentry;
 restart:
 	spin_lock(&inode->i_lock);
 	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&dentry->d_lock);
 		if (!dentry->d_lockref.count) {
-			struct dentry *parent = lock_parent(dentry);
+			int ret = lock_parent(dentry);
+			parent = dentry->d_parent;
 			if (likely(!dentry->d_lockref.count)) {
 				__dentry_kill(dentry);
 				dput(parent);
 				goto restart;
 			}
-			if (parent)
+			if (ret != LOCK_FAILED)
 				spin_unlock(&parent->d_lock);
 		}
 		spin_unlock(&dentry->d_lock);
@@ -1062,9 +1064,11 @@ static void shrink_dentry_list(struct list_head *list)
 
 	while (!list_empty(list)) {
 		struct inode *inode;
+		int ret;
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
-		parent = lock_parent(dentry);
+		ret = lock_parent(dentry);
+		parent = dentry->d_parent;
 
 		/*
 		 * The dispose list is isolated and dentries are not accounted
@@ -1079,7 +1083,7 @@ static void shrink_dentry_list(struct list_head *list)
 		 */
 		if (dentry->d_lockref.count > 0) {
 			spin_unlock(&dentry->d_lock);
-			if (parent)
+			if (ret != LOCK_FAILED)
 				spin_unlock(&parent->d_lock);
 			continue;
 		}
@@ -1088,7 +1092,7 @@ static void shrink_dentry_list(struct list_head *list)
 		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
 			bool can_free = dentry->d_flags & DCACHE_MAY_FREE;
 			spin_unlock(&dentry->d_lock);
-			if (parent)
+			if (ret != LOCK_FAILED)
 				spin_unlock(&parent->d_lock);
 			if (can_free)
 				dentry_free(dentry);
@@ -1099,7 +1103,7 @@ static void shrink_dentry_list(struct list_head *list)
 		if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
 			d_shrink_add(dentry, list);
 			spin_unlock(&dentry->d_lock);
-			if (parent)
+			if (ret != LOCK_FAILED)
 				spin_unlock(&parent->d_lock);
 			continue;
 		}

---->8----

The above patch adjusts all callers of lock_parent() except for 1 that
will be replaced will my new dentry_kill() in v2 anyway.

Although the callers of lock_parent() until now do not take advantage of
the LOCK_FAST return value, my new dentry_lock_inode() _would_. Which
would mean that the common case for dentry_kill() would not do any
unnecessary checks.

static struct dentry *dentry_kill(struct dentry *dentry)
        __releases(dentry->d_lock)
{
        int ret_inode, ret_parent;
        struct dentry *parent;
        struct inode *inode;
again:
        parent = NULL;
        inode = dentry->d_inode;
        if (inode) {
                ret_inode = dentry_lock_inode(dentry);
                if (unlikely(ret_inode != LOCK_FAST)) {
                        ...
                }
        }

        ret_parent = lock_parent(dentry);
        if (likely(ret_parent == LOCK_FAST)) {
                parent = dentry->d_parent;
        } else {
                ...
        }

        __dentry_kill(dentry);
        return parent;
...
}

> I'm actually not so much worried about the cost of re-checking (the
> real cost tends to be the locked cycle itself) as I am about the code
> looking understandable. Your d_delete() patch didn't make me go "that
> looks more complicated", probably partly because of the nice helper
> function.

IMHO the original v1 patchset is the simplest codewise. And if the
comments were updated to not mislead, it is the way I would want to go.

Adding all the code to verbosely model a fast path just seems to me to
add too much code to an already complex part of the VFS.

John Ogness

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDOV5K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:57:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53888 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDOVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:59 -0400
Date: Sun, 15 Apr 2018 22:54:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in
 shrink_dcache_parent()
Message-ID: <20180415215455.GB30522@ZenIV.linux.org.uk>
References: <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com>
 <20180414080206.GV30522@ZenIV.linux.org.uk>
 <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
 <20180414205846.GW30522@ZenIV.linux.org.uk>
 <CA+55aFxD1xKqbobvoHQUWc5jc9n7-7KXYeSQy-CpE0SUZHi0PQ@mail.gmail.com>
 <20180415005056.GX30522@ZenIV.linux.org.uk>
 <CA+55aFwB0A-F8HW=QZu9O7Mtt4ryB1prB6cwh+6cwHv9b5bLNw@mail.gmail.com>
 <20180415204054.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415204054.GA30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 09:40:54PM +0100, Al Viro wrote:

> BTW, the current placement of cond_resched() looks bogus; suppose we
> have collected a lot of victims and ran into need_resched().  We leave
> d_walk() and call shrink_dentry_list().  At that point there's a lot
> of stuff on our shrink list and anybody else running into them will
> have to keep scanning.  Giving up the timeslice before we take care
> of any of those looks like a bad idea, to put it mildly, and that's
> precisely what will happen.
> 
> What about doing that in the end of __dentry_kill() instead?  And to
> hell with both existing call sites - dput() one (before going to
> the parent) is obviously covered by that (dentry_kill() only returns
> non-NULL after having called __dentry_kill()) and in shrink_dentry_list()
> we'll get to it as soon as we go through all dentries that can be
> immediately kicked off the shrink list.  Which, AFAICS, improves the
> situation, now that shrink_lock_dentry() contains no trylock loops...
> 
> Comments?

What I mean is something like this (cumulative diff, it'll obviously need
to be carved up into 3--4 commits):

diff --git a/fs/dcache.c b/fs/dcache.c
index 86d2de63461e..b1e62b54941b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -580,6 +580,7 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
+	cond_resched();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
@@ -827,30 +828,23 @@ static inline bool fast_dput(struct dentry *dentry)
  */
 void dput(struct dentry *dentry)
 {
-	if (unlikely(!dentry))
-		return;
+	while (dentry) {
+		might_sleep();
 
-repeat:
-	might_sleep();
+		rcu_read_lock();
+		if (likely(fast_dput(dentry))) {
+			rcu_read_unlock();
+			return;
+		}
 
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
+		/* Slow case: now with the dentry lock held */
 		rcu_read_unlock();
-		return;
-	}
-
-	/* Slow case: now with the dentry lock held */
-	rcu_read_unlock();
-
-	if (likely(retain_dentry(dentry))) {
-		spin_unlock(&dentry->d_lock);
-		return;
-	}
 
-	dentry = dentry_kill(dentry);
-	if (dentry) {
-		cond_resched();
-		goto repeat;
+		if (likely(retain_dentry(dentry))) {
+			spin_unlock(&dentry->d_lock);
+			return;
+		}
+		dentry = dentry_kill(dentry);
 	}
 }
 EXPORT_SYMBOL(dput);
@@ -1052,8 +1046,6 @@ static void shrink_dentry_list(struct list_head *list)
 	while (!list_empty(list)) {
 		struct dentry *dentry, *parent;
 
-		cond_resched();
-
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
@@ -1230,13 +1222,11 @@ enum d_walk_ret {
  * @parent:	start of walk
  * @data:	data passed to @enter() and @finish()
  * @enter:	callback when first entering the dentry
- * @finish:	callback when successfully finished the walk
  *
  * The @enter() and @finish() callbacks are called with d_lock held.
  */
 static void d_walk(struct dentry *parent, void *data,
-		   enum d_walk_ret (*enter)(void *, struct dentry *),
-		   void (*finish)(void *))
+		   enum d_walk_ret (*enter)(void *, struct dentry *))
 {
 	struct dentry *this_parent;
 	struct list_head *next;
@@ -1325,8 +1315,6 @@ static void d_walk(struct dentry *parent, void *data,
 	if (need_seqretry(&rename_lock, seq))
 		goto rename_retry;
 	rcu_read_unlock();
-	if (finish)
-		finish(data);
 
 out_unlock:
 	spin_unlock(&this_parent->d_lock);
@@ -1375,7 +1363,7 @@ int path_has_submounts(const struct path *parent)
 	struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };
 
 	read_seqlock_excl(&mount_lock);
-	d_walk(parent->dentry, &data, path_check_mount, NULL);
+	d_walk(parent->dentry, &data, path_check_mount);
 	read_sequnlock_excl(&mount_lock);
 
 	return data.mounted;
@@ -1483,7 +1471,7 @@ void shrink_dcache_parent(struct dentry *parent)
 		data.start = parent;
 		data.found = 0;
 
-		d_walk(parent, &data, select_collect, NULL);
+		d_walk(parent, &data, select_collect);
 		if (!data.found)
 			break;
 
@@ -1518,7 +1506,7 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
 static void do_one_tree(struct dentry *dentry)
 {
 	shrink_dcache_parent(dentry);
-	d_walk(dentry, dentry, umount_check, NULL);
+	d_walk(dentry, dentry, umount_check);
 	d_drop(dentry);
 	dput(dentry);
 }
@@ -1542,78 +1530,49 @@ void shrink_dcache_for_umount(struct super_block *sb)
 	}
 }
 
-struct detach_data {
-	struct select_data select;
-	struct dentry *mountpoint;
-};
-static enum d_walk_ret detach_and_collect(void *_data, struct dentry *dentry)
+static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
-	struct detach_data *data = _data;
-
+	struct dentry **victim = (struct dentry **)_data;
 	if (d_mountpoint(dentry)) {
 		__dget_dlock(dentry);
-		data->mountpoint = dentry;
+		*victim = dentry;
 		return D_WALK_QUIT;
 	}
 
-	return select_collect(&data->select, dentry);
-}
-
-static void check_and_drop(void *_data)
-{
-	struct detach_data *data = _data;
-
-	if (!data->mountpoint && list_empty(&data->select.dispose))
-		__d_drop(data->select.start);
+	return D_WALK_CONTINUE;
 }
 
 /**
  * d_invalidate - detach submounts, prune dcache, and drop
  * @dentry: dentry to invalidate (aka detach, prune and drop)
- *
- * no dcache lock.
- *
- * The final d_drop is done as an atomic operation relative to
- * rename_lock ensuring there are no races with d_set_mounted.  This
- * ensures there are no unhashed dentries on the path to a mountpoint.
  */
 void d_invalidate(struct dentry *dentry)
 {
-	/*
-	 * If it's already been dropped, return OK.
-	 */
+	bool had_submounts = false;
 	spin_lock(&dentry->d_lock);
 	if (d_unhashed(dentry)) {
 		spin_unlock(&dentry->d_lock);
 		return;
 	}
+	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
 
 	/* Negative dentries can be dropped without further checks */
-	if (!dentry->d_inode) {
-		d_drop(dentry);
+	if (!dentry->d_inode)
 		return;
-	}
 
+	shrink_dcache_parent(dentry);
 	for (;;) {
-		struct detach_data data;
-
-		data.mountpoint = NULL;
-		INIT_LIST_HEAD(&data.select.dispose);
-		data.select.start = dentry;
-		data.select.found = 0;
-
-		d_walk(dentry, &data, detach_and_collect, check_and_drop);
-
-		if (!list_empty(&data.select.dispose))
-			shrink_dentry_list(&data.select.dispose);
-		else if (!data.mountpoint)
+		struct dentry *victim = NULL;
+		d_walk(dentry, &victim, find_submount);
+		if (!victim) {
+			if (had_submounts)
+				shrink_dcache_parent(dentry);
 			return;
-
-		if (data.mountpoint) {
-			detach_mounts(data.mountpoint);
-			dput(data.mountpoint);
 		}
+		had_submounts = true;
+		detach_mounts(victim);
+		dput(victim);
 	}
 }
 EXPORT_SYMBOL(d_invalidate);
@@ -3112,7 +3071,7 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 
 void d_genocide(struct dentry *parent)
 {
-	d_walk(parent, parent, d_genocide_kill, NULL);
+	d_walk(parent, parent, d_genocide_kill);
 }
 
 EXPORT_SYMBOL(d_genocide);

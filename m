Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D3C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3291A21A8E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3291A21A8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeHIE36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:29:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIE35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:29:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 641ECACE8;
        Thu,  9 Aug 2018 02:07:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 09 Aug 2018 12:04:41 +1000
Subject: [PATCH 1/5] fs/locks: rename some lists and pointers.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153378028105.1220.2668473677432721764.stgit@noble>
In-Reply-To: <153378012255.1220.6754153662007899557.stgit@noble>
References: <153378012255.1220.6754153662007899557.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct file lock contains an 'fl_next' pointer which
is used to point to the lock that this request is blocked
waiting for.  So rename it to fl_blocker.

The fl_blocked list_head in an active lock is the head of a list of
blocked requests.  In a request it is a node in that list.
These are two distinct uses, so replace with two list_heads
with different names.
fl_blocked is the head of a list of blocked requests
fl_block is a node on that list.

This separation will be used in the next patch.

Note that a tracepoint is changed to report fl_blocker instead
of fl_next.  Might this be an ABI breakage?

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/cifs/file.c                  |    2 +-
 fs/locks.c                      |   40 ++++++++++++++++++++-------------------
 include/linux/fs.h              |    5 +++--
 include/trace/events/filelock.h |   16 ++++++++--------
 4 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 8d41ca7bfcf1..066ed2e4ba96 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1092,7 +1092,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	rc = posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
 	if (rc == FILE_LOCK_DEFERRED) {
-		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_next);
+		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
 		if (!rc)
 			goto try_again;
 		posix_unblock_lock(flock);
diff --git a/fs/locks.c b/fs/locks.c
index db7b6917d9c5..322491e70e41 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -194,7 +194,7 @@ static DEFINE_HASHTABLE(blocked_hash, BLOCKED_HASH_BITS);
  * This lock protects the blocked_hash. Generally, if you're accessing it, you
  * want to be holding this lock.
  *
- * In addition, it also protects the fl->fl_block list, and the fl->fl_next
+ * In addition, it also protects the fl->fl_blocked list, and the fl->fl_blocker
  * pointer for file_lock structures that are acting as lock requests (in
  * contrast to those that are acting as records of acquired locks).
  *
@@ -203,7 +203,7 @@ static DEFINE_HASHTABLE(blocked_hash, BLOCKED_HASH_BITS);
  * protected by this lock, we can skip acquiring it iff we already hold the
  * flc_lock.
  *
- * In particular, adding an entry to the fl_block list requires that you hold
+ * In particular, adding an entry to the fl_blocked list requires that you hold
  * both the flc_lock and the blocked_lock_lock (acquired in that order).
  * Deleting an entry from the list however only requires the file_lock_lock.
  */
@@ -302,6 +302,7 @@ static void locks_init_lock_heads(struct file_lock *fl)
 {
 	INIT_HLIST_NODE(&fl->fl_link);
 	INIT_LIST_HEAD(&fl->fl_list);
+	INIT_LIST_HEAD(&fl->fl_blocked);
 	INIT_LIST_HEAD(&fl->fl_block);
 	init_waitqueue_head(&fl->fl_wait);
 }
@@ -341,6 +342,7 @@ void locks_free_lock(struct file_lock *fl)
 {
 	BUG_ON(waitqueue_active(&fl->fl_wait));
 	BUG_ON(!list_empty(&fl->fl_list));
+	BUG_ON(!list_empty(&fl->fl_blocked));
 	BUG_ON(!list_empty(&fl->fl_block));
 	BUG_ON(!hlist_unhashed(&fl->fl_link));
 
@@ -676,7 +678,7 @@ static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_block);
-	waiter->fl_next = NULL;
+	waiter->fl_blocker = NULL;
 }
 
 static void locks_delete_block(struct file_lock *waiter)
@@ -692,16 +694,16 @@ static void locks_delete_block(struct file_lock *waiter)
  * it seems like the reasonable thing to do.
  *
  * Must be called with both the flc_lock and blocked_lock_lock held. The
- * fl_block list itself is protected by the blocked_lock_lock, but by ensuring
+ * fl_blocked list itself is protected by the blocked_lock_lock, but by ensuring
  * that the flc_lock is also held on insertions we can avoid taking the
- * blocked_lock_lock in some cases when we see that the fl_block list is empty.
+ * blocked_lock_lock in some cases when we see that the fl_blocked list is empty.
  */
 static void __locks_insert_block(struct file_lock *blocker,
 					struct file_lock *waiter)
 {
 	BUG_ON(!list_empty(&waiter->fl_block));
-	waiter->fl_next = blocker;
-	list_add_tail(&waiter->fl_block, &blocker->fl_block);
+	waiter->fl_blocker = blocker;
+	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
 		locks_insert_global_blocked(waiter);
 }
@@ -725,18 +727,18 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	/*
 	 * Avoid taking global lock if list is empty. This is safe since new
 	 * blocked requests are only added to the list under the flc_lock, and
-	 * the flc_lock is always held here. Note that removal from the fl_block
+	 * the flc_lock is always held here. Note that removal from the fl_blocked
 	 * list does not require the flc_lock, so we must recheck list_empty()
 	 * after acquiring the blocked_lock_lock.
 	 */
-	if (list_empty(&blocker->fl_block))
+	if (list_empty(&blocker->fl_blocked))
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	while (!list_empty(&blocker->fl_block)) {
+	while (!list_empty(&blocker->fl_blocked)) {
 		struct file_lock *waiter;
 
-		waiter = list_first_entry(&blocker->fl_block,
+		waiter = list_first_entry(&blocker->fl_blocked,
 				struct file_lock, fl_block);
 		__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
@@ -887,7 +889,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 
 	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
 		if (posix_same_owner(fl, block_fl))
-			return fl->fl_next;
+			return fl->fl_blocker;
 	}
 	return NULL;
 }
@@ -1245,7 +1247,7 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
 		if (!error)
 			continue;
 
@@ -1332,7 +1334,7 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 		error = posix_lock_inode(inode, &fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
+		error = wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1526,7 +1528,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_next, break_time);
+						!new_fl->fl_blocker, break_time);
 
 	percpu_down_read_preempt_disable(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -1940,7 +1942,7 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
 		if (!error)
 			continue;
 
@@ -2212,7 +2214,7 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_next);
+		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
 		if (!error)
 			continue;
 
@@ -2583,7 +2585,7 @@ posix_unblock_lock(struct file_lock *waiter)
 	int status = 0;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_next)
+	if (waiter->fl_blocker)
 		__locks_delete_block(waiter);
 	else
 		status = -ENOENT;
@@ -2711,7 +2713,7 @@ static int locks_show(struct seq_file *f, void *v)
 
 	lock_get_status(f, fl, iter->li_pos, "");
 
-	list_for_each_entry(bfl, &fl->fl_block, fl_block)
+	list_for_each_entry(bfl, &fl->fl_blocked, fl_block)
 		lock_get_status(f, bfl, iter->li_pos, " ->");
 
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 805bf22898cf..48f7f36c3772 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1002,10 +1002,11 @@ bool opens_in_grace(struct net *);
  * Obviously, the last two criteria only matter for POSIX locks.
  */
 struct file_lock {
-	struct file_lock *fl_next;	/* singly linked list for this inode  */
+	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
 	struct list_head fl_list;	/* link into file_lock_context */
 	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_block;	/* circular list of blocked processes */
+	struct list_head fl_blocked;	/* list of requests with ->fl_blocker pointing here */
+	struct list_head fl_block;	/* node in ->fl_blocker->fl_blocked */
 	fl_owner_t fl_owner;
 	unsigned int fl_flags;
 	unsigned char fl_type;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index d1faf3597b9d..0e50f985a390 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_next)
+		__field(struct file_lock *, fl_blocker)
 		__field(fl_owner_t, fl_owner)
 		__field(unsigned int, fl_pid)
 		__field(unsigned int, fl_flags)
@@ -82,7 +82,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_next = fl ? fl->fl_next : NULL;
+		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
 		__entry->fl_pid = fl ? fl->fl_pid : 0;
 		__entry->fl_flags = fl ? fl->fl_flags : 0;
@@ -92,9 +92,9 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->ret = ret;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_next=0x%p fl_owner=0x%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
+	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_next, __entry->fl_owner,
+		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		__entry->fl_pid, show_fl_flags(__entry->fl_flags),
 		show_fl_type(__entry->fl_type),
 		__entry->fl_start, __entry->fl_end, __entry->ret)
@@ -122,7 +122,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__field(struct file_lock *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
-		__field(struct file_lock *, fl_next)
+		__field(struct file_lock *, fl_blocker)
 		__field(fl_owner_t, fl_owner)
 		__field(unsigned int, fl_flags)
 		__field(unsigned char, fl_type)
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->fl_next = fl ? fl->fl_next : NULL;
+		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
 		__entry->fl_flags = fl ? fl->fl_flags : 0;
 		__entry->fl_type = fl ? fl->fl_type : 0;
@@ -142,9 +142,9 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
 
-	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_next=0x%p fl_owner=0x%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
+	TP_printk("fl=0x%p dev=0x%x:0x%x ino=0x%lx fl_blocker=0x%p fl_owner=0x%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
 		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-		__entry->i_ino, __entry->fl_next, __entry->fl_owner,
+		__entry->i_ino, __entry->fl_blocker, __entry->fl_owner,
 		show_fl_flags(__entry->fl_flags),
 		show_fl_type(__entry->fl_type),
 		__entry->fl_break_time, __entry->fl_downgrade_time)



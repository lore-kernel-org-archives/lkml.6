Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1CAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A033C2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A033C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeKLLIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:08:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:08:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FFADADE3;
        Mon, 12 Nov 2018 01:17:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:49 +1100
Subject: [PATCH 10/12] fs/locks: create a tree of dependent requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528925.14364.1689720543542941272.stgit@noble>
In-Reply-To: <154198490921.14364.13726904731989686092.stgit@noble>
References: <154198490921.14364.13726904731989686092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we find an existing lock which conflicts with a request,
and the request wants to wait, we currently add the request
to a list.  When the lock is removed, the whole list is woken.
This can cause the thundering-herd problem.
To reduce the problem, we make use of the (new) fact that
a pending request can itself have a list of blocked requests.
When we find a conflict, we look through the existing blocked requests.
If any one of them blocks the new request, the new request is attached
below that request, otherwise it is added to the list of blocked
requests, which are now known to be mutually non-conflicting.

This way, when the lock is released, only a set of non-conflicting
locks will be woken, the rest can stay asleep.
If the lock request cannot be granted and the request needs to be
requeued, all the other requests it blocks will then be woken

To make this more concrete:

  If you have a many-core machine, and have many threads all wanting to
  briefly lock a give file (udev is known to do this), you can get quite
  poor performance.

  When one thread releases a lock, it wakes up all other threads that
  are waiting (classic thundering-herd) - one will get the lock and the
  others go to sleep.
  When you have few cores, this is not very noticeable: by the time the
  4th or 5th thread gets enough CPU time to try to claim the lock, the
  earlier threads have claimed it, done what was needed, and released.
  So with few cores, many of the threads don't end up contending.
  With 50+ cores, lost of threads can get the CPU at the same time,
  and the contention can easily be measured.

  This patchset creates a tree of pending lock requests in which siblings
  don't conflict and each lock request does conflict with its parent.
  When a lock is released, only requests which don't conflict with each
  other a woken.

  Testing shows that lock-acquisitions-per-second is now fairly stable
  even as the number of contending process goes to 1000.  Without this
  patch, locks-per-second drops off steeply after a few 10s of
  processes.

  There is a small cost to this extra complexity.
  At 20 processes running a particular test on 72 cores, the lock
  acquisitions per second drops from 1.8 million to 1.4 million with
  this patch.  For 100 processes, this patch still provides 1.4 million
  while without this patch there are about 700,000.


Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 74b24191d6e6..1006b566ddf5 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -112,6 +112,46 @@
  *  Leases and LOCK_MAND
  *  Matthew Wilcox <willy@debian.org>, June, 2000.
  *  Stephen Rothwell <sfr@canb.auug.org.au>, June, 2000.
+ *
+ * Locking conflicts and dependencies:
+ * If multiple threads attempt to lock the same byte (or flock the same file)
+ * only one can be granted the lock, and other must wait their turn.
+ * The first lock has been "applied" or "granted", the others are "waiting"
+ * and are "blocked" by the "applied" lock..
+ *
+ * Waiting and applied locks are all kept in trees whose properties are:
+ *
+ *	- the root of a tree may be an applied or waiting lock.
+ *	- every other node in the tree is a waiting lock that
+ *	  conflicts with every ancestor of that node.
+ *
+ * Every such tree begins life as a waiting singleton which obviously
+ * satisfies the above properties.
+ *
+ * The only ways we modify trees preserve these properties:
+ *
+ *	1. We may add a new child, but only after first verifying that it
+ *	   conflicts with all of its ancestors.
+ *	2. We may remove the root of a tree, creating a new singleton
+ *	   tree from the root and N new trees rooted in the immediate
+ *	   children.
+ *	3. If the root of a tree is not currently an applied lock, we may
+ *	   apply it (if possible).
+ *	4. We may upgrade the root of the tree (either extend its range,
+ *	   or upgrade its entire range from read to write).
+ *
+ * When an applied lock is modified in a way that reduces or downgrades any
+ * part of its range, we remove all its children (2 above).  This particularly
+ * happens when a lock is unlocked.
+ *
+ * For each of those child trees we "wake up" the thread which is
+ * waiting for the lock so it can continue handling as follows: if the
+ * root of the tree applies, we do so (3).  If it doesn't, it must
+ * conflict with some applied lock.  We remove (wake up) all of its children
+ * (2), and add it is a new leaf to the tree rooted in the applied
+ * lock (1).  We then repeat the process recursively with those
+ * children.
+ *
  */
 
 #include <linux/capability.h>
@@ -719,11 +759,25 @@ static void locks_delete_block(struct file_lock *waiter)
  * but by ensuring that the flc_lock is also held on insertions we can avoid
  * taking the blocked_lock_lock in some cases when we see that the
  * fl_blocked_requests list is empty.
+ *
+ * Rather than just adding to the list, we check for conflicts with any existing
+ * waiters, and add beneath any waiter that blocks the new waiter.
+ * Thus wakeups don't happen until needed.
  */
 static void __locks_insert_block(struct file_lock *blocker,
-					struct file_lock *waiter)
+				 struct file_lock *waiter,
+				 bool conflict(struct file_lock *,
+					       struct file_lock *))
 {
+	struct file_lock *fl;
 	BUG_ON(!list_empty(&waiter->fl_blocked_member));
+
+new_blocker:
+	list_for_each_entry(fl, &blocker->fl_blocked_requests, fl_blocked_member)
+		if (conflict(fl, waiter)) {
+			blocker =  fl;
+			goto new_blocker;
+		}
 	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_blocked_member, &blocker->fl_blocked_requests);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
@@ -738,10 +792,12 @@ static void __locks_insert_block(struct file_lock *blocker,
 
 /* Must be called with flc_lock held. */
 static void locks_insert_block(struct file_lock *blocker,
-					struct file_lock *waiter)
+			       struct file_lock *waiter,
+			       bool conflict(struct file_lock *,
+					     struct file_lock *))
 {
 	spin_lock(&blocked_lock_lock);
-	__locks_insert_block(blocker, waiter);
+	__locks_insert_block(blocker, waiter, conflict);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -1000,7 +1056,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request);
+		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_flags & FL_ACCESS)
@@ -1075,7 +1131,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			spin_lock(&blocked_lock_lock);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request);
+				__locks_insert_block(fl, request,
+						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
 			goto out;
@@ -1546,7 +1603,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl);
+	locks_insert_block(fl, new_fl, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read_preempt_enable(&file_rwsem);



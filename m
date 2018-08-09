Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABDC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A95821C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95821C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeHIEaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:30:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIEaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:30:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05A8DAB99;
        Thu,  9 Aug 2018 02:08:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 09 Aug 2018 12:04:41 +1000
Subject: [PATCH 5/5] fs/locks: create a tree of dependent requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153378028121.1220.4418653283078446336.stgit@noble>
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

When we find an existing lock which conflicts with a request,
and the request wants to wait, we currently add the request
to a list.  When the lock is removed, the whole list is woken.
This can cause the thundering-herd problem.
To reduce the problem, we make use of the (new) fact that
a pending request can itself have a list of blocked requests.
When we find a conflict, we look through the existing blocked requests.
If any one of them blocks the new request, the new request is attached
below that request.
This way, when the lock is released, only a set of non-conflicting
locks will be woken.  The rest of the herd can stay asleep.

Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index fc64016d01ee..17843feb6f5b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -738,6 +738,39 @@ static void locks_delete_block(struct file_lock *waiter)
 	spin_unlock(&blocked_lock_lock);
 }
 
+static void wake_non_conflicts(struct file_lock *waiter, struct file_lock *blocker,
+			       enum conflict conflict(struct file_lock *,
+						      struct file_lock *))
+{
+	struct file_lock *parent = waiter;
+	struct file_lock *fl;
+	struct file_lock  *t;
+
+	fl = list_entry(&parent->fl_blocked, struct file_lock, fl_block);
+restart:
+	list_for_each_entry_safe_continue(fl, t, &parent->fl_blocked, fl_block) {
+		switch (conflict(fl, blocker)) {
+		default:
+		case FL_NO_CONFLICT:
+			__locks_wake_one(fl);
+			break;
+		case FL_CONFLICT:
+			/* Need to check children */
+			parent = fl;
+			fl = list_entry(&parent->fl_blocked, struct file_lock, fl_block);
+			goto restart;
+		case FL_TRANSITIVE_CONFLICT:
+			/* all children must also conflict, no need to check */
+			continue;
+		}
+	}
+	if (parent != waiter) {
+		parent = parent->fl_blocker;
+		fl = parent;
+		goto restart;
+	}
+}
+
 /* Insert waiter into blocker's block list.
  * We use a circular list so that processes can be easily woken up in
  * the order they blocked. The documentation doesn't require this but
@@ -747,11 +780,32 @@ static void locks_delete_block(struct file_lock *waiter)
  * fl_blocked list itself is protected by the blocked_lock_lock, but by ensuring
  * that the flc_lock is also held on insertions we can avoid taking the
  * blocked_lock_lock in some cases when we see that the fl_blocked list is empty.
+ *
+ * Rather than just adding to the list, we check for conflicts with any existing
+ * waiter, and add to that waiter instead.
+ * Thus wakeups don't happen until needed.
  */
 static void __locks_insert_block(struct file_lock *blocker,
-					struct file_lock *waiter)
+				 struct file_lock *waiter,
+				 enum conflict conflict(struct file_lock *,
+							struct file_lock *))
 {
+	struct file_lock *fl;
 	BUG_ON(!list_empty(&waiter->fl_block));
+
+	/* Any request in waiter->fl_blocked is know to conflict with
+	 * waiter, but it might not conflict with blocker.
+	 * If it doesn't, it needs to be woken now so it can find
+	 * somewhere else to wait, or possible it can get granted.
+	 */
+	if (conflict(waiter, blocker) != FL_TRANSITIVE_CONFLICT)
+		wake_non_conflicts(waiter, blocker, conflict);
+new_blocker:
+	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
+		if (conflict(fl, waiter)) {
+			blocker =  fl;
+			goto new_blocker;
+		}
 	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
@@ -760,10 +814,12 @@ static void __locks_insert_block(struct file_lock *blocker,
 
 /* Must be called with flc_lock held. */
 static void locks_insert_block(struct file_lock *blocker,
-					struct file_lock *waiter)
+			       struct file_lock *waiter,
+			       enum conflict conflict(struct file_lock *,
+						      struct file_lock *))
 {
 	spin_lock(&blocked_lock_lock);
-	__locks_insert_block(blocker, waiter);
+	__locks_insert_block(blocker, waiter, conflict);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -1033,7 +1089,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request);
+		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_flags & FL_ACCESS)
@@ -1107,7 +1163,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			spin_lock(&blocked_lock_lock);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request);
+				__locks_insert_block(fl, request,
+						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
 			goto out;
@@ -1581,7 +1638,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl);
+	locks_insert_block(fl, new_fl, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read_preempt_enable(&file_rwsem);



Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1907520671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1907520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeJXHLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:11:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeJXHLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:11:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88F47AEAD;
        Tue, 23 Oct 2018 22:46:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 24 Oct 2018 09:43:54 +1100
Subject: [PATCH 7/9] fs/locks: create a tree of dependent requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154033463459.29542.2922554667272131468.stgit@noble>
In-Reply-To: <154033435272.29542.13985568983074440924.stgit@noble>
References: <154033435272.29542.13985568983074440924.stgit@noble>
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

Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1e2a122c9673..06e9ae1cc0c4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -715,11 +715,25 @@ static void locks_delete_block(struct file_lock *waiter)
  * fl_blocked list itself is protected by the blocked_lock_lock, but by ensuring
  * that the flc_lock is also held on insertions we can avoid taking the
  * blocked_lock_lock in some cases when we see that the fl_blocked list is empty.
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
 	BUG_ON(!list_empty(&waiter->fl_block));
+
+new_blocker:
+	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
+		if (conflict(fl, waiter)) {
+			blocker =  fl;
+			goto new_blocker;
+		}
 	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
@@ -734,10 +748,12 @@ static void __locks_insert_block(struct file_lock *blocker,
 
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
 
@@ -996,7 +1012,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request);
+		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_flags & FL_ACCESS)
@@ -1071,7 +1087,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			spin_lock(&blocked_lock_lock);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request);
+				__locks_insert_block(fl, request,
+						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
 			goto out;
@@ -1542,7 +1559,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl);
+	locks_insert_block(fl, new_fl, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read_preempt_enable(&file_rwsem);



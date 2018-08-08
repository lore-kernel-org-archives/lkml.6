Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B3A217B4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B3A217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHHEJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:09:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeHHEJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:09:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12468AF4D;
        Wed,  8 Aug 2018 01:52:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 08 Aug 2018 11:51:08 +1000
Subject: [PATCH 4/4] fs/locks: create a tree of dependent requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.de>
Message-ID: <153369306798.12605.11900283893787605168.stgit@noble>
In-Reply-To: <153369219467.12605.13472423449508444601.stgit@noble>
References: <153369219467.12605.13472423449508444601.stgit@noble>
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
 fs/locks.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index aaa55925c788..69a30421218b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -723,11 +723,24 @@ static void locks_delete_block(struct file_lock *waiter)
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
+				 bool conflict(struct file_lock *,
+					       struct file_lock *))
 {
+	struct file_lock *fl;
 	BUG_ON(!list_empty(&waiter->fl_block));
+new_blocker:
+	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
+		if (conflict(fl, waiter)) {
+			blocker =  fl;
+			goto new_blocker;
+		}
 	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
@@ -736,10 +749,12 @@ static void __locks_insert_block(struct file_lock *blocker,
 
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
 
@@ -995,7 +1010,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!(request->fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
-		locks_insert_block(fl, request);
+		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
 	if (request->fl_flags & FL_ACCESS)
@@ -1069,7 +1084,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			spin_lock(&blocked_lock_lock);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request);
+				__locks_insert_block(fl, request,
+						     posix_locks_conflict);
 			}
 			spin_unlock(&blocked_lock_lock);
 			goto out;
@@ -1542,7 +1558,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		break_time -= jiffies;
 	if (break_time == 0)
 		break_time++;
-	locks_insert_block(fl, new_fl);
+	locks_insert_block(fl, new_fl, leases_conflict);
 	trace_break_lease_block(inode, new_fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read_preempt_enable(&file_rwsem);



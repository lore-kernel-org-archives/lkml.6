Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E94A21723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E94A21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHHEJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:09:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeHHEJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:09:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 155A8AEE1;
        Wed,  8 Aug 2018 01:52:19 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 08 Aug 2018 11:51:07 +1000
Subject: [PATCH 2/4] fs/locks: allow a lock request to block other requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.de>
Message-ID: <153369306792.12605.8354776272905495741.stgit@noble>
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

Currently, a lock can block pending requests, but all pending
requests are equal.  If lots of pending requests are
mutually exclusive, this means they will all be woken up
and all but one will fail.  This can hurt performance.

So we will allow pending requests to block other requests.
Only the first request will be woken, and it will wake the others.

This patch doesn't implement this fully, but prepares the way.

- It acknowledges that a request might be blocking other requests,
  and when the request is converted to a lock, those blocked
  requests are moved across.
- When a request is removed, all blocked requests are woken.
- When deadlock-detection looks for the lock which blocks a
  given request, we follow the chain of ->fl_blocker all
  the way to the top.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   58 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 322491e70e41..b4812da2a374 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -408,9 +408,19 @@ void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 			fl->fl_ops->fl_copy_lock(new, fl);
 	}
 }
-
 EXPORT_SYMBOL(locks_copy_lock);
 
+static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
+{
+	struct file_lock *f;
+
+	spin_lock(&blocked_lock_lock);
+	list_splice_init(&fl->fl_blocked, &new->fl_blocked);
+	list_for_each_entry(f, &fl->fl_blocked, fl_block)
+		f->fl_blocker = new;
+	spin_unlock(&blocked_lock_lock);
+}
+
 static inline int flock_translate_cmd(int cmd) {
 	if (cmd & LOCK_MAND)
 		return cmd & (LOCK_MAND | LOCK_RW);
@@ -681,9 +691,25 @@ static void __locks_delete_block(struct file_lock *waiter)
 	waiter->fl_blocker = NULL;
 }
 
+static void __locks_wake_up_blocks(struct file_lock *blocker)
+{
+	while (!list_empty(&blocker->fl_blocked)) {
+		struct file_lock *waiter;
+
+		waiter = list_first_entry(&blocker->fl_blocked,
+				struct file_lock, fl_block);
+		__locks_delete_block(waiter);
+		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
+			waiter->fl_lmops->lm_notify(waiter);
+		else
+			wake_up(&waiter->fl_wait);
+	}
+}
+
 static void locks_delete_block(struct file_lock *waiter)
 {
 	spin_lock(&blocked_lock_lock);
+	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
 	spin_unlock(&blocked_lock_lock);
 }
@@ -735,17 +761,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	while (!list_empty(&blocker->fl_blocked)) {
-		struct file_lock *waiter;
-
-		waiter = list_first_entry(&blocker->fl_blocked,
-				struct file_lock, fl_block);
-		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
-		else
-			wake_up(&waiter->fl_wait);
-	}
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -888,8 +904,11 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 	struct file_lock *fl;
 
 	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
-		if (posix_same_owner(fl, block_fl))
-			return fl->fl_blocker;
+		if (posix_same_owner(fl, block_fl)) {
+			while (fl->fl_blocker)
+				fl = fl->fl_blocker;
+			return fl;
+		}
 	}
 	return NULL;
 }
@@ -982,6 +1001,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	if (request->fl_flags & FL_ACCESS)
 		goto out;
 	locks_copy_lock(new_fl, request);
+	locks_move_blocks(new_fl, request);
 	locks_insert_lock_ctx(new_fl, &ctx->flc_flock);
 	new_fl = NULL;
 	error = 0;
@@ -1174,6 +1194,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			goto out;
 		}
 		locks_copy_lock(new_fl, request);
+		locks_move_blocks(new_fl, request);
 		locks_insert_lock_ctx(new_fl, &fl->fl_list);
 		fl = new_fl;
 		new_fl = NULL;
@@ -2582,13 +2603,14 @@ void locks_remove_file(struct file *filp)
 int
 posix_unblock_lock(struct file_lock *waiter)
 {
-	int status = 0;
+	int status = -ENOENT;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_blocker)
+	if (waiter->fl_blocker) {
+		__locks_wake_up_blocks(waiter);
 		__locks_delete_block(waiter);
-	else
-		status = -ENOENT;
+		status = 0;
+	}
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }



Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB32087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AB32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeKLLIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:08:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:08:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE2B4ADE3;
        Mon, 12 Nov 2018 01:17:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:49 +1100
Subject: [PATCH 07/12] fs/locks: allow a lock request to block other
 requests.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528913.14364.2790262012801596354.stgit@noble>
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
- When a request is requeued or discarded, all blocked requests are
  woken.
- When deadlock-detection looks for the lock which blocks a
  given request, we follow the chain of ->fl_blocker all
  the way to the top.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 492d970c67d7..c1b79293007b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -402,6 +402,17 @@ void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 
 EXPORT_SYMBOL(locks_copy_lock);
 
+static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
+{
+	struct file_lock *f;
+
+	spin_lock(&blocked_lock_lock);
+	list_splice_init(&fl->fl_blocked_requests, &new->fl_blocked_requests);
+	list_for_each_entry(f, &fl->fl_blocked_requests, fl_blocked_member)
+		f->fl_blocker = new;
+	spin_unlock(&blocked_lock_lock);
+}
+
 static inline int flock_translate_cmd(int cmd) {
 	if (cmd & LOCK_MAND)
 		return cmd & (LOCK_MAND | LOCK_RW);
@@ -693,6 +704,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 static void locks_delete_block(struct file_lock *waiter)
 {
 	spin_lock(&blocked_lock_lock);
+	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
 	spin_unlock(&blocked_lock_lock);
 }
@@ -716,6 +728,12 @@ static void __locks_insert_block(struct file_lock *blocker,
 	list_add_tail(&waiter->fl_blocked_member, &blocker->fl_blocked_requests);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
 		locks_insert_global_blocked(waiter);
+
+	/* The requests in waiter->fl_blocked are known to conflict with
+	 * waiter, but might not conflict with blocker, or the requests
+	 * and lock which block it.  So they all need to be woken.
+	 */
+	__locks_wake_up_blocks(waiter);
 }
 
 /* Must be called with flc_lock held. */
@@ -888,8 +906,11 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
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
@@ -982,6 +1003,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	if (request->fl_flags & FL_ACCESS)
 		goto out;
 	locks_copy_lock(new_fl, request);
+	locks_move_blocks(new_fl, request);
 	locks_insert_lock_ctx(new_fl, &ctx->flc_flock);
 	new_fl = NULL;
 	error = 0;
@@ -1175,6 +1197,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			goto out;
 		}
 		locks_copy_lock(new_fl, request);
+		locks_move_blocks(new_fl, request);
 		locks_insert_lock_ctx(new_fl, &fl->fl_list);
 		fl = new_fl;
 		new_fl = NULL;
@@ -2586,13 +2609,14 @@ void locks_remove_file(struct file *filp)
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



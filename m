Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A794C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C842087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C842087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeKLLIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:08:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:08:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A960AADE3;
        Mon, 12 Nov 2018 01:17:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:49 +1100
Subject: [PATCH 11/12] locks: merge posix_unblock_lock() and
 locks_delete_block()
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528930.14364.3928719662387643513.stgit@noble>
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

posix_unblock_lock() is not specific to posix locks, and behaves
nearly identically to locks_delete_block() - the former returning a
status while the later doesn't.

So discard posix_unblock_lock() and use locks_delete_block() instead,
after giving that function an appropriate return value.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/cifs/file.c      |    2 +-
 fs/lockd/svclock.c  |    2 +-
 fs/locks.c          |   36 +++++++++++++-----------------------
 fs/nfsd/nfs4state.c |    6 +++---
 include/linux/fs.h  |    4 ++--
 5 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d7ed895e05d1..94c3575e850c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1106,7 +1106,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
 		if (!rc)
 			goto try_again;
-		posix_unblock_lock(flock);
+		locks_delete_block(flock);
 	}
 	return rc;
 }
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 74330daeab71..ea719cdd6a36 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -276,7 +276,7 @@ static int nlmsvc_unlink_block(struct nlm_block *block)
 	dprintk("lockd: unlinking block %p...\n", block);
 
 	/* Remove block from list */
-	status = posix_unblock_lock(&block->b_call->a_args.lock.fl);
+	status = locks_delete_block(&block->b_call->a_args.lock.fl);
 	nlmsvc_remove_block(block);
 	return status;
 }
diff --git a/fs/locks.c b/fs/locks.c
index 1006b566ddf5..d306ae7da9f6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -741,13 +741,25 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 	}
 }
 
-static void locks_delete_block(struct file_lock *waiter)
+/**
+ *	locks_delete_lock - stop waiting for a file lock
+ *	@waiter: the lock which was waiting
+ *
+ *	lockd/nfsd need to disconnect the lock while working on it.
+ */
+int locks_delete_block(struct file_lock *waiter)
 {
+	int status = -ENOENT;
+
 	spin_lock(&blocked_lock_lock);
+	if (waiter->fl_blocker)
+		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
 	spin_unlock(&blocked_lock_lock);
+	return status;
 }
+EXPORT_SYMBOL(locks_delete_block);
 
 /* Insert waiter into blocker's block list.
  * We use a circular list so that processes can be easily woken up in
@@ -2654,28 +2666,6 @@ void locks_remove_file(struct file *filp)
 	spin_unlock(&ctx->flc_lock);
 }
 
-/**
- *	posix_unblock_lock - stop waiting for a file lock
- *	@waiter: the lock which was waiting
- *
- *	lockd needs to block waiting for locks.
- */
-int
-posix_unblock_lock(struct file_lock *waiter)
-{
-	int status = -ENOENT;
-
-	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_blocker) {
-		__locks_wake_up_blocks(waiter);
-		__locks_delete_block(waiter);
-		status = 0;
-	}
-	spin_unlock(&blocked_lock_lock);
-	return status;
-}
-EXPORT_SYMBOL(posix_unblock_lock);
-
 /**
  * vfs_cancel_lock - file byte range unblock lock
  * @filp: The file to apply the unblock to
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f093fbe47133..a334828723fa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -238,7 +238,7 @@ find_blocked_lock(struct nfs4_lockowner *lo, struct knfsd_fh *fh,
 	}
 	spin_unlock(&nn->blocked_locks_lock);
 	if (found)
-		posix_unblock_lock(&found->nbl_lock);
+		locks_delete_block(&found->nbl_lock);
 	return found;
 }
 
@@ -293,7 +293,7 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 		nbl = list_first_entry(&reaplist, struct nfsd4_blocked_lock,
 					nbl_lru);
 		list_del_init(&nbl->nbl_lru);
-		posix_unblock_lock(&nbl->nbl_lock);
+		locks_delete_block(&nbl->nbl_lock);
 		free_blocked_lock(nbl);
 	}
 }
@@ -4863,7 +4863,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		nbl = list_first_entry(&reaplist,
 					struct nfsd4_blocked_lock, nbl_lru);
 		list_del_init(&nbl->nbl_lru);
-		posix_unblock_lock(&nbl->nbl_lock);
+		locks_delete_block(&nbl->nbl_lock);
 		free_blocked_lock(nbl);
 	}
 out:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16df3a7df378..26a8607b3c3c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1124,7 +1124,7 @@ extern void locks_remove_file(struct file *);
 extern void locks_release_private(struct file_lock *);
 extern void posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
-extern int posix_unblock_lock(struct file_lock *);
+extern int locks_delete_block(struct file_lock *);
 extern int vfs_test_lock(struct file *, struct file_lock *);
 extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
@@ -1214,7 +1214,7 @@ static inline int posix_lock_file(struct file *filp, struct file_lock *fl,
 	return -ENOLCK;
 }
 
-static inline int posix_unblock_lock(struct file_lock *waiter)
+static inline int locks_delete_block(struct file_lock *waiter)
 {
 	return -ENOENT;
 }



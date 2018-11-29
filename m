Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC6C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1820673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB1820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeK3KNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:13:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:13:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7A82AC66;
        Thu, 29 Nov 2018 23:06:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Date:   Fri, 30 Nov 2018 10:04:08 +1100
Subject: [PATCH 08/12] fs/locks: always delete_block after waiting.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154353264851.32133.3996924672100884987.stgit@noble>
In-Reply-To: <154353251599.32133.1085882002675619240.stgit@noble>
References: <154353251599.32133.1085882002675619240.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that requests can block other requests, we
need to be careful to always clean up those blocked
requests.
Any time that we wait for a request, we might have
other requests attached, and when we stop waiting,
we must clean them up.
If the lock was granted, the requests might have been
moved to the new lock, though when merged with a
pre-exiting lock, this might not happen.
In all cases we don't want blocked locks to remain
attached, so we remove them to be safe.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Tested-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com
Tested-by: kernel test robot <rong.a.chen@intel.com>
---
 fs/locks.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1260c265ba62..2814662ecfe6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -710,6 +710,20 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 
 static void locks_delete_block(struct file_lock *waiter)
 {
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread
+	 * "owns" the lock and is the only one that might try to claim
+	 * the lock.  So it is safe to test fl_blocker locklessly.
+	 * Also if fl_blocker is NULL, this waiter is not listed on
+	 * fl_blocked_requests for some lock, so no other request can
+	 * be added to the list of fl_blocked_requests for this
+	 * request.  So if fl_blocker is NULL, it is safe to
+	 * locklessly check if fl_blocked_requests is empty.  If both
+	 * of these checks succeed, there is no need to take the lock.
+	 */
+	if (waiter->fl_blocker == NULL &&
+	    list_empty(&waiter->fl_blocked_requests))
+		return status;
 	spin_lock(&blocked_lock_lock);
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
@@ -1279,12 +1293,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		if (error != FILE_LOCK_DEFERRED)
 			break;
 		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
-		if (!error)
-			continue;
-
-		locks_delete_block(fl);
-		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
 	return error;
 }
 
@@ -1375,9 +1387,9 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 				continue;
 		}
 
-		locks_delete_block(&fl);
 		break;
 	}
+	locks_delete_block(&fl);
 
 	return error;
 }
@@ -1973,12 +1985,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		if (error != FILE_LOCK_DEFERRED)
 			break;
 		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
-		if (!error)
-			continue;
-
-		locks_delete_block(fl);
-		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
 	return error;
 }
 
@@ -2252,12 +2262,10 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		if (error != FILE_LOCK_DEFERRED)
 			break;
 		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
-		if (!error)
-			continue;
-
-		locks_delete_block(fl);
-		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
 
 	return error;
 }



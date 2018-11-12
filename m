Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFA92087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFA92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeKLLIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:08:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:56894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:08:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C641ADE3;
        Mon, 12 Nov 2018 01:17:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:49 +1100
Subject: [PATCH 08/12] fs/locks: always delete_block after waiting.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528917.14364.12807627735259492190.stgit@noble>
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
---
 fs/locks.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index c1b79293007b..8d9d79e7a565 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1272,12 +1272,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
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
 
@@ -1966,12 +1964,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
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
 
@@ -2245,12 +2241,10 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
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



Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC6C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F68D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F68D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeHNGnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 02:43:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:45156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbeHNGnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 02:43:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2C26AF53;
        Tue, 14 Aug 2018 03:58:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 14 Aug 2018 13:56:52 +1000
Subject: [PATCH 4/5] fs/locks: change all *_conflict() functions to return
 bool.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153421901208.24426.12703365395600257400.stgit@noble>
In-Reply-To: <153421852728.24426.2111161640156686201.stgit@noble>
References: <153421852728.24426.2111161640156686201.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

posix_locks_conflict() and flock_locks_conflict() both return int.
leases_conflict() returns bool.

This inconsistency will cause problems for the next patch if not
fixed.

So change posix_locks_conflict() and flock_locks_conflict() to return
bool.
Also change the locks_conflict() helper.

And convert some
   return (foo);
to
   return foo;

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9439eebd4eb9..c7a372cebff1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -803,47 +803,50 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static bool locks_conflict(struct file_lock *caller_fl,
+			   struct file_lock *sys_fl)
 {
 	if (sys_fl->fl_type == F_WRLCK)
-		return 1;
+		return true;
 	if (caller_fl->fl_type == F_WRLCK)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
  * checking before calling the locks_conflict().
  */
-static int posix_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static bool posix_locks_conflict(struct file_lock *caller_fl,
+				 struct file_lock *sys_fl)
 {
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
 	if (posix_same_owner(caller_fl, sys_fl))
-		return (0);
+		return false;
 
 	/* Check whether they overlap */
 	if (!locks_overlap(caller_fl, sys_fl))
-		return 0;
+		return false;
 
-	return (locks_conflict(caller_fl, sys_fl));
+	return locks_conflict(caller_fl, sys_fl);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
  * checking before calling the locks_conflict().
  */
-static int flock_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static bool flock_locks_conflict(struct file_lock *caller_fl,
+				 struct file_lock *sys_fl)
 {
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
 	if (caller_fl->fl_file == sys_fl->fl_file)
-		return (0);
+		return false;
 	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
-		return 0;
+		return false;
 
-	return (locks_conflict(caller_fl, sys_fl));
+	return locks_conflict(caller_fl, sys_fl);
 }
 
 void



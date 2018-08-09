Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012E6C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B885221C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B885221C17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeHIEaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:30:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIEaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:30:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B5C2AECC;
        Thu,  9 Aug 2018 02:07:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 09 Aug 2018 12:04:41 +1000
Subject: [PATCH 3/5] fs/locks: change all *_conflict() functions to return a
 new enum.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153378028114.1220.3708291796442871726.stgit@noble>
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

In a future patch we will need to differentiate between conflicts that
are "transitive" and those that aren't.
A "transitive" conflict is defined as one where any lock that
conflicts with the first (newly requested) lock would conflict with
the existing lock.

So change posix_locks_conflict(), flock_locks_conflict() (both
currently returning int) and leases_conflict() (currently returning
bool) to return "enum conflict".
Add locks_transitive_overlap() to make it possible to compute the
correct conflict for posix locks.

The FL_NO_CONFLICT value is zero, so current code which only tests the
truth value of these functions will still work the same way.

And convert some
   return (foo);
to
   return foo;

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index b4812da2a374..d06658b2dc7a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -139,6 +139,16 @@
 #define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
 #define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
 
+/* A transitive conflict is one where the first lock conflicts with
+ * the second lock, and any other lock that conflicts with the
+ * first lock, also conflicts with the second lock.
+ */
+enum conflict {
+	FL_NO_CONFLICT = 0,
+	FL_CONFLICT,
+	FL_TRANSITIVE_CONFLICT,
+};
+
 static inline bool is_remote_lock(struct file *filp)
 {
 	return likely(!(filp->f_path.dentry->d_sb->s_flags & SB_NOREMOTELOCK));
@@ -612,6 +622,15 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
 		(fl2->fl_end >= fl1->fl_start));
 }
 
+/* Check for transitive-overlap - true if any lock that overlaps
+ * the first lock must overlap the seconds
+ */
+static inline bool locks_transitive_overlap(struct file_lock *fl1,
+					    struct file_lock *fl2)
+{
+	return (fl1->fl_start >= fl2->fl_start) &&
+		(fl1->fl_end <= fl2->fl_end);
+}
 /*
  * Check whether two locks have the same owner.
  */
@@ -793,47 +812,61 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static enum conflict locks_conflict(struct file_lock *caller_fl,
+				    struct file_lock *sys_fl)
 {
 	if (sys_fl->fl_type == F_WRLCK)
-		return 1;
+		return FL_TRANSITIVE_CONFLICT;
 	if (caller_fl->fl_type == F_WRLCK)
-		return 1;
-	return 0;
+		return FL_CONFLICT;
+	return FL_NO_CONFLICT;
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
  * checking before calling the locks_conflict().
  */
-static int posix_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static enum conflict posix_locks_conflict(struct file_lock *caller_fl,
+					  struct file_lock *sys_fl)
 {
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
 	if (posix_same_owner(caller_fl, sys_fl))
-		return (0);
+		return FL_NO_CONFLICT;
 
 	/* Check whether they overlap */
 	if (!locks_overlap(caller_fl, sys_fl))
-		return 0;
+		return FL_NO_CONFLICT;
 
-	return (locks_conflict(caller_fl, sys_fl));
+	switch (locks_conflict(caller_fl, sys_fl)) {
+	default:
+	case FL_NO_CONFLICT:
+		return FL_NO_CONFLICT;
+	case FL_CONFLICT:
+		return FL_CONFLICT;
+	case FL_TRANSITIVE_CONFLICT:
+		if (locks_transitive_overlap(caller_fl, sys_fl))
+			return FL_TRANSITIVE_CONFLICT;
+		else
+			return FL_CONFLICT;
+	}
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
  * checking before calling the locks_conflict().
  */
-static int flock_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static enum conflict flock_locks_conflict(struct file_lock *caller_fl,
+					  struct file_lock *sys_fl)
 {
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
 	if (caller_fl->fl_file == sys_fl->fl_file)
-		return (0);
+		return FL_NO_CONFLICT;
 	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
-		return 0;
+		return FL_NO_CONFLICT;
 
-	return (locks_conflict(caller_fl, sys_fl));
+	return locks_conflict(caller_fl, sys_fl);
 }
 
 void
@@ -1435,12 +1468,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 	}
 }
 
-static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
+static enum conflict leases_conflict(struct file_lock *lease,
+				     struct file_lock *breaker)
 {
 	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT))
-		return false;
+		return FL_NO_CONFLICT;
 	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE))
-		return false;
+		return FL_NO_CONFLICT;
 	return locks_conflict(breaker, lease);
 }
 



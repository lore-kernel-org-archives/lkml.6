Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA7C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3F20660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF3F20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937276AbeFSDCv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:02:51 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:50367
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937215AbeFSDCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:02:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CWHABicShb/6c80XZcHQIiB4MELoE6F?=
 =?us-ascii?q?RIog3mUVkYBAQEBAQaBDTSWWB4YAYRAAoJfITgUAQIBAQEBAQECbSiFKQYjBFI?=
 =?us-ascii?q?QGAEMAhgOAgJHEAYThRgMqlOBaTMaAogtgWiBC4dJgQyBB4EPMIpSglUCh0kKh?=
 =?us-ascii?q?U0/izcJjwmIGIUjkyUhgVJNLgqCfpBcMjB6AQGQUgEB?=
X-IPAS-Result: =?us-ascii?q?A2CWHABicShb/6c80XZcHQIiB4MELoE6FRIog3mUVkYBAQE?=
 =?us-ascii?q?BAQaBDTSWWB4YAYRAAoJfITgUAQIBAQEBAQECbSiFKQYjBFIQGAEMAhgOAgJHE?=
 =?us-ascii?q?AYThRgMqlOBaTMaAogtgWiBC4dJgQyBB4EPMIpSglUCh0kKhU0/izcJjwmIGIU?=
 =?us-ascii?q?jkyUhgVJNLgqCfpBcMjB6AQGQUgEB?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90294719"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 11:02:21 +0800
Subject: [PATCH 5/6] autofs - make expire flags usage consistent with v5
 params
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:02:20 +0800
Message-ID: <152937734046.21213.9454131988766280028.stgit@pluto.themaw.net>
In-Reply-To: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
References: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the usage of the expire flags consistent by naming
the expire flags the same as it is named in the version
5 miscelaneous ioctl parameters and only check the bit
flags when needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    2 +-
 fs/autofs/expire.c   |   61 +++++++++++++++++++++++---------------------------
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index b1f70bc45ca3..b5e0870acdcb 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -151,7 +151,7 @@ int autofs_expire_run(struct super_block *, struct vfsmount *,
 		      struct autofs_sb_info *,
 		      struct autofs_packet_expire __user *);
 int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			   struct autofs_sb_info *sbi, int when);
+			   struct autofs_sb_info *sbi, unsigned int how);
 int autofs_expire_multi(struct super_block *, struct vfsmount *,
 			struct autofs_sb_info *, int __user *);
 
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 5fb47a4ca48c..dfb666c5b8a2 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -12,7 +12,7 @@
 
 /* Check if a dentry can be expired */
 static inline int autofs_can_expire(struct dentry *dentry,
-				    unsigned long timeout, int do_now)
+				    unsigned long timeout, unsigned int how)
 {
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
@@ -20,7 +20,7 @@ static inline int autofs_can_expire(struct dentry *dentry,
 	if (ino == NULL)
 		return 0;
 
-	if (!do_now) {
+	if (!(how & AUTOFS_EXP_IMMEDIATE)) {
 		/* Too young to die */
 		if (!timeout || time_after(ino->last_used + timeout, jiffies))
 			return 0;
@@ -185,7 +185,7 @@ static struct dentry *get_next_positive_dentry(struct dentry *prev,
 static int autofs_direct_busy(struct vfsmount *mnt,
 			      struct dentry *top,
 			      unsigned long timeout,
-			      int do_now)
+			      unsigned int how)
 {
 	pr_debug("top %p %pd\n", top, top);
 
@@ -200,7 +200,7 @@ static int autofs_direct_busy(struct vfsmount *mnt,
 	}
 
 	/* Timeout of a direct mount is determined by its top dentry */
-	if (!autofs_can_expire(top, timeout, do_now))
+	if (!autofs_can_expire(top, timeout, how))
 		return 1;
 
 	return 0;
@@ -213,7 +213,7 @@ static int autofs_direct_busy(struct vfsmount *mnt,
 static int autofs_tree_busy(struct vfsmount *mnt,
 			    struct dentry *top,
 			    unsigned long timeout,
-			    int do_now)
+			    unsigned int how)
 {
 	struct autofs_info *top_ino = autofs_dentry_ino(top);
 	struct dentry *p;
@@ -259,7 +259,7 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 	}
 
 	/* Timeout of a tree mount is ultimately determined by its top dentry */
-	if (!autofs_can_expire(top, timeout, do_now))
+	if (!autofs_can_expire(top, timeout, how))
 		return 1;
 
 	return 0;
@@ -268,7 +268,7 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 static struct dentry *autofs_check_leaves(struct vfsmount *mnt,
 					  struct dentry *parent,
 					  unsigned long timeout,
-					  int do_now)
+					  unsigned int how)
 {
 	struct dentry *p;
 
@@ -284,7 +284,7 @@ static struct dentry *autofs_check_leaves(struct vfsmount *mnt,
 				continue;
 
 			/* Can we expire this guy */
-			if (autofs_can_expire(p, timeout, do_now))
+			if (autofs_can_expire(p, timeout, how))
 				return p;
 		}
 	}
@@ -295,19 +295,18 @@ static struct dentry *autofs_check_leaves(struct vfsmount *mnt,
 static struct dentry *autofs_expire_direct(struct super_block *sb,
 					   struct vfsmount *mnt,
 					   struct autofs_sb_info *sbi,
-					   int how)
+					   unsigned int how)
 {
-	unsigned long timeout;
 	struct dentry *root = dget(sb->s_root);
-	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 	struct autofs_info *ino;
+	unsigned long timeout;
 
 	if (!root)
 		return NULL;
 
 	timeout = sbi->exp_timeout;
 
-	if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
+	if (!autofs_direct_busy(mnt, root, timeout, how)) {
 		spin_lock(&sbi->fs_lock);
 		ino = autofs_dentry_ino(root);
 		/* No point expiring a pending mount */
@@ -318,7 +317,7 @@ static struct dentry *autofs_expire_direct(struct super_block *sb,
 		ino->flags |= AUTOFS_INF_WANT_EXPIRE;
 		spin_unlock(&sbi->fs_lock);
 		synchronize_rcu();
-		if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
+		if (!autofs_direct_busy(mnt, root, timeout, how)) {
 			spin_lock(&sbi->fs_lock);
 			ino->flags |= AUTOFS_INF_EXPIRING;
 			init_completion(&ino->expire_complete);
@@ -343,10 +342,8 @@ static struct dentry *autofs_expire_direct(struct super_block *sb,
 static struct dentry *should_expire(struct dentry *dentry,
 				    struct vfsmount *mnt,
 				    unsigned long timeout,
-				    int how)
+				    unsigned int how)
 {
-	int do_now = how & AUTOFS_EXP_IMMEDIATE;
-	int exp_leaves = how & AUTOFS_EXP_LEAVES;
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	unsigned int ino_count;
 
@@ -368,7 +365,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 			return NULL;
 
 		/* Can we expire this guy */
-		if (autofs_can_expire(dentry, timeout, do_now))
+		if (autofs_can_expire(dentry, timeout, how))
 			return dentry;
 		return NULL;
 	}
@@ -379,7 +376,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		 * A symlink can't be "busy" in the usual sense so
 		 * just check last used for expire timeout.
 		 */
-		if (autofs_can_expire(dentry, timeout, do_now))
+		if (autofs_can_expire(dentry, timeout, how))
 			return dentry;
 		return NULL;
 	}
@@ -388,13 +385,13 @@ static struct dentry *should_expire(struct dentry *dentry,
 		return NULL;
 
 	/* Case 2: tree mount, expire iff entire tree is not busy */
-	if (!exp_leaves) {
+	if (!(how & AUTOFS_EXP_LEAVES)) {
 		/* Path walk currently on this dentry? */
 		ino_count = atomic_read(&ino->count) + 1;
 		if (d_count(dentry) > ino_count)
 			return NULL;
 
-		if (!autofs_tree_busy(mnt, dentry, timeout, do_now))
+		if (!autofs_tree_busy(mnt, dentry, timeout, how))
 			return dentry;
 	/*
 	 * Case 3: pseudo direct mount, expire individual leaves
@@ -408,7 +405,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		if (d_count(dentry) > ino_count)
 			return NULL;
 
-		expired = autofs_check_leaves(mnt, dentry, timeout, do_now);
+		expired = autofs_check_leaves(mnt, dentry, timeout, how);
 		if (expired) {
 			if (expired == dentry)
 				dput(dentry);
@@ -427,7 +424,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 static struct dentry *autofs_expire_indirect(struct super_block *sb,
 					     struct vfsmount *mnt,
 					     struct autofs_sb_info *sbi,
-					     int how)
+					     unsigned int how)
 {
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
@@ -443,8 +440,6 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 
 	dentry = NULL;
 	while ((dentry = get_next_positive_subdir(dentry, root))) {
-		int flags = how;
-
 		spin_lock(&sbi->fs_lock);
 		ino = autofs_dentry_ino(dentry);
 		if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
@@ -453,7 +448,7 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 		}
 		spin_unlock(&sbi->fs_lock);
 
-		expired = should_expire(dentry, mnt, timeout, flags);
+		expired = should_expire(dentry, mnt, timeout, how);
 		if (!expired)
 			continue;
 
@@ -466,8 +461,8 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 		/* Make sure a reference is not taken on found if
 		 * things have changed.
 		 */
-		flags &= ~AUTOFS_EXP_LEAVES;
-		found = should_expire(expired, mnt, timeout, flags);
+		how &= ~AUTOFS_EXP_LEAVES;
+		found = should_expire(expired, mnt, timeout, how);
 		if (!found || found != expired)
 			/* Something has changed, continue */
 			goto next;
@@ -580,15 +575,15 @@ int autofs_expire_run(struct super_block *sb,
 }
 
 int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			   struct autofs_sb_info *sbi, int when)
+			   struct autofs_sb_info *sbi, unsigned int how)
 {
 	struct dentry *dentry;
 	int ret = -EAGAIN;
 
 	if (autofs_type_trigger(sbi->type))
-		dentry = autofs_expire_direct(sb, mnt, sbi, when);
+		dentry = autofs_expire_direct(sb, mnt, sbi, how);
 	else
-		dentry = autofs_expire_indirect(sb, mnt, sbi, when);
+		dentry = autofs_expire_indirect(sb, mnt, sbi, how);
 
 	if (dentry) {
 		struct autofs_info *ino = autofs_dentry_ino(dentry);
@@ -618,10 +613,10 @@ int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 int autofs_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 			struct autofs_sb_info *sbi, int __user *arg)
 {
-	int do_now = 0;
+	unsigned int how = 0;
 
-	if (arg && get_user(do_now, arg))
+	if (arg && get_user(how, arg))
 		return -EFAULT;
 
-	return autofs_do_expire_multi(sb, mnt, sbi, do_now);
+	return autofs_do_expire_multi(sb, mnt, sbi, how);
 }


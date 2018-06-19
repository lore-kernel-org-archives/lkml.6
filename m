Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A2C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1325C20660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1325C20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937306AbeFSDDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:03:10 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:50447
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937169AbeFSDDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:03:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BRCQBicShb/6c80XZcH4MtLoE6FRIog?=
 =?us-ascii?q?3mUVkYBAQEBAQaBDTSQOIQogXgeGAGEQAKCXyE0GAECAQEBAQEBAm0ohSkGIwR?=
 =?us-ascii?q?SEBgBDAIYDgICRxAGE4UYDKpTgWkzGgKILYFogQuHSYEMgQeBDzCKUoJVAodJh?=
 =?us-ascii?q?Vc/izcJjwmBP4ZZhSMrh0WLHjiBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IPAS-Result: =?us-ascii?q?A2BRCQBicShb/6c80XZcH4MtLoE6FRIog3mUVkYBAQEBAQa?=
 =?us-ascii?q?BDTSQOIQogXgeGAGEQAKCXyE0GAECAQEBAQEBAm0ohSkGIwRSEBgBDAIYDgICR?=
 =?us-ascii?q?xAGE4UYDKpTgWkzGgKILYFogQuHSYEMgQeBDzCKUoJVAodJhVc/izcJjwmBP4Z?=
 =?us-ascii?q?ZhSMrh0WLHjiBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90294739"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 11:02:27 +0800
Subject: [PATCH 6/6] autofs - add AUTOFS_EXP_FORCED flag
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:02:27 +0800
Message-ID: <152937734715.21213.6594007182776598970.stgit@pluto.themaw.net>
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

The user space automount(8) daemon is meant to perform a forced
expire when sent a SIGUSR2.

But since the expiration is routed through the kernel and the
kernel doesn't send an expire request if the mount is busy this
hasn't worked at least since autofs version 5.

Add an AUTOFS_EXP_FORCED flag to allow implemention of the feature
and bump the protocol version so user space can check if it's
implemented if needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c           |   62 ++++++++++++++++++++++++++++++++++--------
 include/uapi/linux/auto_fs.h |    8 +++--
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index dfb666c5b8a2..d441244b79df 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -29,7 +29,8 @@ static inline int autofs_can_expire(struct dentry *dentry,
 }
 
 /* Check a mount point for busyness */
-static int autofs_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
+static int autofs_mount_busy(struct vfsmount *mnt,
+			     struct dentry *dentry, unsigned int how)
 {
 	struct dentry *top = dentry;
 	struct path path = {.mnt = mnt, .dentry = dentry};
@@ -50,6 +51,12 @@ static int autofs_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 			goto done;
 	}
 
+	/* Not a submount, has a forced expire been requested */
+	if (how & AUTOFS_EXP_FORCED) {
+		status = 0;
+		goto done;
+	}
+
 	/* Update the expiry counter if fs is busy */
 	if (!may_umount_tree(path.mnt)) {
 		struct autofs_info *ino;
@@ -189,6 +196,10 @@ static int autofs_direct_busy(struct vfsmount *mnt,
 {
 	pr_debug("top %p %pd\n", top, top);
 
+	/* Forced expire, user space handles busy mounts */
+	if (how & AUTOFS_EXP_FORCED)
+		return 0;
+
 	/* If it's busy update the expiry counters */
 	if (!may_umount_tree(mnt)) {
 		struct autofs_info *ino;
@@ -235,7 +246,7 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 		 * If the fs is busy update the expiry counter.
 		 */
 		if (d_mountpoint(p)) {
-			if (autofs_mount_busy(mnt, p)) {
+			if (autofs_mount_busy(mnt, p, how)) {
 				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
@@ -258,6 +269,10 @@ static int autofs_tree_busy(struct vfsmount *mnt,
 		}
 	}
 
+	/* Forced expire, user space handles busy mounts */
+	if (how & AUTOFS_EXP_FORCED)
+		return 0;
+
 	/* Timeout of a tree mount is ultimately determined by its top dentry */
 	if (!autofs_can_expire(top, timeout, how))
 		return 1;
@@ -280,9 +295,15 @@ static struct dentry *autofs_check_leaves(struct vfsmount *mnt,
 
 		if (d_mountpoint(p)) {
 			/* Can we umount this guy */
-			if (autofs_mount_busy(mnt, p))
+			if (autofs_mount_busy(mnt, p, how))
 				continue;
 
+			/* This isn't a submount so if a forced expire
+			 * has been requested, user space handles busy
+			 * mounts */
+			if (how & AUTOFS_EXP_FORCED)
+				return p;
+
 			/* Can we expire this guy */
 			if (autofs_can_expire(p, timeout, how))
 				return p;
@@ -361,9 +382,15 @@ static struct dentry *should_expire(struct dentry *dentry,
 		pr_debug("checking mountpoint %p %pd\n", dentry, dentry);
 
 		/* Can we umount this guy */
-		if (autofs_mount_busy(mnt, dentry))
+		if (autofs_mount_busy(mnt, dentry, how))
 			return NULL;
 
+		/* This isn't a submount so if a forced expire
+		 * has been requested, user space handles busy
+		 * mounts */
+		if (how & AUTOFS_EXP_FORCED)
+			return dentry;
+
 		/* Can we expire this guy */
 		if (autofs_can_expire(dentry, timeout, how))
 			return dentry;
@@ -372,6 +399,11 @@ static struct dentry *should_expire(struct dentry *dentry,
 
 	if (d_really_is_positive(dentry) && d_is_symlink(dentry)) {
 		pr_debug("checking symlink %p %pd\n", dentry, dentry);
+
+		/* Forced expire, user space handles busy mounts */
+		if (how & AUTOFS_EXP_FORCED)
+			return dentry;
+
 		/*
 		 * A symlink can't be "busy" in the usual sense so
 		 * just check last used for expire timeout.
@@ -386,10 +418,13 @@ static struct dentry *should_expire(struct dentry *dentry,
 
 	/* Case 2: tree mount, expire iff entire tree is not busy */
 	if (!(how & AUTOFS_EXP_LEAVES)) {
-		/* Path walk currently on this dentry? */
-		ino_count = atomic_read(&ino->count) + 1;
-		if (d_count(dentry) > ino_count)
-			return NULL;
+		/* Not a forced expire? */
+		if (!(how & AUTOFS_EXP_FORCED)) {
+			/* ref-walk currently on this dentry? */
+			ino_count = atomic_read(&ino->count) + 1;
+			if (d_count(dentry) > ino_count)
+				return NULL;
+		}
 
 		if (!autofs_tree_busy(mnt, dentry, timeout, how))
 			return dentry;
@@ -398,12 +433,15 @@ static struct dentry *should_expire(struct dentry *dentry,
 	 *	   (autofs-4.1).
 	 */
 	} else {
-		/* Path walk currently on this dentry? */
 		struct dentry *expired;
 
-		ino_count = atomic_read(&ino->count) + 1;
-		if (d_count(dentry) > ino_count)
-			return NULL;
+		/* Not a forced expire? */
+		if (!(how & AUTOFS_EXP_FORCED)) {
+			/* ref-walk currently on this dentry? */
+			ino_count = atomic_read(&ino->count) + 1;
+			if (d_count(dentry) > ino_count)
+				return NULL;
+		}
 
 		expired = autofs_check_leaves(mnt, dentry, timeout, how);
 		if (expired) {
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index e13eec3dfb2f..df31aa9c9a8c 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		2
+#define AUTOFS_PROTO_SUBVERSION		3
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed
@@ -90,8 +90,10 @@ enum {
 /* autofs version 4 and later definitions */
 
 /* Mask for expire behaviour */
-#define AUTOFS_EXP_IMMEDIATE		1
-#define AUTOFS_EXP_LEAVES		2
+#define AUTOFS_EXP_NORMAL		0x00
+#define AUTOFS_EXP_IMMEDIATE		0x01
+#define AUTOFS_EXP_LEAVES		0x02
+#define AUTOFS_EXP_FORCED		0x04
 
 #define AUTOFS_TYPE_ANY			0U
 #define AUTOFS_TYPE_INDIRECT		1U


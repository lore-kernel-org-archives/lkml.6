Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5731BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00F4208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00F4208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbeGKCYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732600AbeGKCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lf-0003Lx-Id; Wed, 11 Jul 2018 02:22:11 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 40/42] make path_init() unconditionally paired with terminate_walk()
Date:   Wed, 11 Jul 2018 03:22:04 +0100
Message-Id: <20180711022206.12571-40-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

including the failure exits

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ca3f4dec8cda..a9a2a8ac8b9d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2125,12 +2125,15 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+/* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
 	const char *s = nd->name->name;
 
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
+	if (flags & LOOKUP_RCU)
+		rcu_read_lock();
 
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
@@ -2143,7 +2146,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		nd->path = nd->root;
 		nd->inode = inode;
 		if (flags & LOOKUP_RCU) {
-			rcu_read_lock();
 			nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
 			nd->root_seq = nd->seq;
 			nd->m_seq = read_seqbegin(&mount_lock);
@@ -2159,21 +2161,15 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 	if (*s == '/') {
-		if (flags & LOOKUP_RCU)
-			rcu_read_lock();
 		set_root(nd);
 		if (likely(!nd_jump_root(nd)))
 			return s;
-		nd->root.mnt = NULL;
-		rcu_read_unlock();
 		return ERR_PTR(-ECHILD);
 	} else if (nd->dfd == AT_FDCWD) {
 		if (flags & LOOKUP_RCU) {
 			struct fs_struct *fs = current->fs;
 			unsigned seq;
 
-			rcu_read_lock();
-
 			do {
 				seq = read_seqcount_begin(&fs->seq);
 				nd->path = fs->pwd;
@@ -2195,16 +2191,13 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 		dentry = f.file->f_path.dentry;
 
-		if (*s) {
-			if (!d_can_lookup(dentry)) {
-				fdput(f);
-				return ERR_PTR(-ENOTDIR);
-			}
+		if (*s && unlikely(!d_can_lookup(dentry))) {
+			fdput(f);
+			return ERR_PTR(-ENOTDIR);
 		}
 
 		nd->path = f.file->f_path;
 		if (flags & LOOKUP_RCU) {
-			rcu_read_lock();
 			nd->inode = nd->path.dentry->d_inode;
 			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 		} else {
@@ -2272,8 +2265,10 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	const char *s = path_init(nd, flags);
 	int err;
 
-	if (IS_ERR(s))
+	if (IS_ERR(s)) {
+		terminate_walk(nd);
 		return PTR_ERR(s);
+	}
 
 	if (unlikely(flags & LOOKUP_DOWN)) {
 		err = handle_lookup_down(nd);
@@ -2337,8 +2332,10 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 {
 	const char *s = path_init(nd, flags);
 	int err;
-	if (IS_ERR(s))
+	if (IS_ERR(s)) {
+		terminate_walk(nd);
 		return PTR_ERR(s);
+	}
 	err = link_path_walk(s, nd);
 	if (!err)
 		err = complete_walk(nd);
@@ -2666,8 +2663,10 @@ path_mountpoint(struct nameidata *nd, unsigned flags, struct path *path)
 {
 	const char *s = path_init(nd, flags);
 	int err;
-	if (IS_ERR(s))
+	if (IS_ERR(s)) {
+		terminate_walk(nd);
 		return PTR_ERR(s);
+	}
 	while (!(err = link_path_walk(s, nd)) &&
 		(err = mountpoint_last(nd)) > 0) {
 		s = trailing_symlink(nd);
@@ -3514,6 +3513,7 @@ static struct file *path_openat(struct nameidata *nd,
 
 	s = path_init(nd, flags);
 	if (IS_ERR(s)) {
+		terminate_walk(nd);
 		fput(file);
 		return ERR_CAST(s);
 	}
-- 
2.11.0


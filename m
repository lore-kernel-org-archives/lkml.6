Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C84208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C84208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbeGKC1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:27:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45526 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGKCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003IF-47; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 10/42] get rid of cred argument of vfs_open() and do_dentry_open()
Date:   Wed, 11 Jul 2018 03:21:34 +0100
Message-Id: <20180711022206.12571-10-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

always equal to ->f_cred

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h |  2 +-
 fs/namei.c    |  4 ++--
 fs/open.c     | 15 ++++++---------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 66473bf388e4..ab84a29f4874 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -126,7 +126,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 
 extern int open_check_o_direct(struct file *f);
-extern int vfs_open(const struct path *, struct file *, const struct cred *);
+extern int vfs_open(const struct path *, struct file *);
 
 /*
  * inode.c
diff --git a/fs/namei.c b/fs/namei.c
index af2ec1803f57..7b1fe5e30a0d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3396,7 +3396,7 @@ static int do_last(struct nameidata *nd,
 	if (error)
 		goto out;
 	BUG_ON(*opened & FILE_OPENED); /* once it's opened, it's opened */
-	error = vfs_open(&nd->path, file, current_cred());
+	error = vfs_open(&nd->path, file);
 	if (error)
 		goto out;
 	*opened |= FILE_OPENED;
@@ -3499,7 +3499,7 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	int error = path_lookupat(nd, flags, &path);
 	if (!error) {
 		audit_inode(nd->name, path.dentry, 0);
-		error = vfs_open(&path, file, current_cred());
+		error = vfs_open(&path, file);
 		path_put(&path);
 	}
 	return error;
diff --git a/fs/open.c b/fs/open.c
index c0dbc67c31f1..c8fd5126c50e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -736,8 +736,7 @@ int open_check_o_direct(struct file *f)
 
 static int do_dentry_open(struct file *f,
 			  struct inode *inode,
-			  int (*open)(struct inode *, struct file *),
-			  const struct cred *cred)
+			  int (*open)(struct inode *, struct file *))
 {
 	static const struct file_operations empty_fops = {};
 	int error;
@@ -780,7 +779,7 @@ static int do_dentry_open(struct file *f,
 		goto cleanup_all;
 	}
 
-	error = security_file_open(f, cred);
+	error = security_file_open(f, f->f_cred);
 	if (error)
 		goto cleanup_all;
 
@@ -858,8 +857,7 @@ int finish_open(struct file *file, struct dentry *dentry,
 	BUG_ON(*opened & FILE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	error = do_dentry_open(file, d_backing_inode(dentry), open,
-			       current_cred());
+	error = do_dentry_open(file, d_backing_inode(dentry), open);
 	if (!error)
 		*opened |= FILE_OPENED;
 
@@ -900,8 +898,7 @@ EXPORT_SYMBOL(file_path);
  * @file: newly allocated file with f_flag initialized
  * @cred: credentials to use
  */
-int vfs_open(const struct path *path, struct file *file,
-	     const struct cred *cred)
+int vfs_open(const struct path *path, struct file *file)
 {
 	struct dentry *dentry = d_real(path->dentry, NULL, file->f_flags, 0);
 
@@ -909,7 +906,7 @@ int vfs_open(const struct path *path, struct file *file,
 		return PTR_ERR(dentry);
 
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
+	return do_dentry_open(file, d_backing_inode(dentry), NULL);
 }
 
 struct file *dentry_open(const struct path *path, int flags,
@@ -926,7 +923,7 @@ struct file *dentry_open(const struct path *path, int flags,
 	f = alloc_empty_file(cred);
 	if (!IS_ERR(f)) {
 		f->f_flags = flags;
-		error = vfs_open(path, f, cred);
+		error = vfs_open(path, f);
 		if (!error) {
 			/* from now on we need fput() to dispose of f */
 			error = open_check_o_direct(f);
-- 
2.11.0


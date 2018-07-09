Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791DEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2F82089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeGIE54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:57:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38098 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbeGIEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBn-0003fS-4f; Mon, 09 Jul 2018 04:54:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 14/27] get rid of 'opened' in path_openat() and the helpers downstream
Date:   Mon,  9 Jul 2018 05:54:04 +0100
Message-Id: <20180709045417.13988-14-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

unused now

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7270cac785b0..5d7aa567c958 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3036,8 +3036,7 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 			struct path *path, struct file *file,
 			const struct open_flags *op,
-			int open_flag, umode_t mode,
-			int *opened)
+			int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
 	struct inode *dir =  nd->path.dentry->d_inode;
@@ -3105,14 +3104,11 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
  * specified then a negative dentry may be returned.
  *
  * An error code is returned otherwise.
- *
- * FILE_CREATE will be set in @*opened if the dentry was created and will be
- * cleared otherwise prior to returning.
  */
 static int lookup_open(struct nameidata *nd, struct path *path,
 			struct file *file,
 			const struct open_flags *op,
-			bool got_write, int *opened)
+			bool got_write)
 {
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
@@ -3187,7 +3183,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 
 	if (dir_inode->i_op->atomic_open) {
 		error = atomic_open(nd, dentry, path, file, op, open_flag,
-				    mode, opened);
+				    mode);
 		if (unlikely(error == -ENOENT) && create_error)
 			error = create_error;
 		return error;
@@ -3240,8 +3236,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
  * Handle the last step of open()
  */
 static int do_last(struct nameidata *nd,
-		   struct file *file, const struct open_flags *op,
-		   int *opened)
+		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
@@ -3307,7 +3302,7 @@ static int do_last(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	error = lookup_open(nd, &path, file, op, got_write, opened);
+	error = lookup_open(nd, &path, file, op, got_write);
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
@@ -3452,7 +3447,7 @@ EXPORT_SYMBOL(vfs_tmpfile);
 
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
-		struct file *file, int *opened)
+		struct file *file)
 {
 	struct dentry *child;
 	struct path path;
@@ -3499,7 +3494,6 @@ static struct file *path_openat(struct nameidata *nd,
 {
 	const char *s;
 	struct file *file;
-	int opened = 0;
 	int error;
 
 	file = get_empty_filp();
@@ -3509,7 +3503,7 @@ static struct file *path_openat(struct nameidata *nd,
 	file->f_flags = op->open_flag;
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
-		error = do_tmpfile(nd, flags, op, file, &opened);
+		error = do_tmpfile(nd, flags, op, file);
 		goto out2;
 	}
 
@@ -3524,7 +3518,7 @@ static struct file *path_openat(struct nameidata *nd,
 		return ERR_CAST(s);
 	}
 	while (!(error = link_path_walk(s, nd)) &&
-		(error = do_last(nd, file, op, &opened)) > 0) {
+		(error = do_last(nd, file, op)) > 0) {
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 		s = trailing_symlink(nd);
 		if (IS_ERR(s)) {
-- 
2.11.0


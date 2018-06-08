Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7ZWPJO/PGlu1EAAAmS7hNA
	; Fri, 08 Jun 2018 18:50:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 52EC7607E4; Fri,  8 Jun 2018 18:50:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BD0D7601D2;
	Fri,  8 Jun 2018 18:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD0D7601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeFHSu5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53830 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeFHSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006OT-UL; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] get rid of 'opened' in path_openat() and the helpers downstream
Date: Fri,  8 Jun 2018 19:50:19 +0100
Message-Id: <20180608185019.24472-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
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
index 189ead589811..00436749003b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3002,8 +3002,7 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 static int atomic_open(struct nameidata *nd, struct dentry *dentry,
 			struct path *path, struct file *file,
 			const struct open_flags *op,
-			int open_flag, umode_t mode,
-			int *opened)
+			int open_flag, umode_t mode)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
 	struct inode *dir =  nd->path.dentry->d_inode;
@@ -3071,14 +3070,11 @@ static int atomic_open(struct nameidata *nd, struct dentry *dentry,
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
@@ -3153,7 +3149,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 
 	if (dir_inode->i_op->atomic_open) {
 		error = atomic_open(nd, dentry, path, file, op, open_flag,
-				    mode, opened);
+				    mode);
 		if (unlikely(error == -ENOENT) && create_error)
 			error = create_error;
 		return error;
@@ -3206,8 +3202,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
  * Handle the last step of open()
  */
 static int do_last(struct nameidata *nd,
-		   struct file *file, const struct open_flags *op,
-		   int *opened)
+		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
@@ -3273,7 +3268,7 @@ static int do_last(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	error = lookup_open(nd, &path, file, op, got_write, opened);
+	error = lookup_open(nd, &path, file, op, got_write);
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
@@ -3418,7 +3413,7 @@ EXPORT_SYMBOL(vfs_tmpfile);
 
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
-		struct file *file, int *opened)
+		struct file *file)
 {
 	struct dentry *child;
 	struct path path;
@@ -3465,7 +3460,6 @@ static struct file *path_openat(struct nameidata *nd,
 {
 	const char *s;
 	struct file *file;
-	int opened = 0;
 	int error;
 
 	file = get_empty_filp();
@@ -3475,7 +3469,7 @@ static struct file *path_openat(struct nameidata *nd,
 	file->f_flags = op->open_flag;
 
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
-		error = do_tmpfile(nd, flags, op, file, &opened);
+		error = do_tmpfile(nd, flags, op, file);
 		goto out2;
 	}
 
@@ -3490,7 +3484,7 @@ static struct file *path_openat(struct nameidata *nd,
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

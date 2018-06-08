Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7/i1HSTQGlsIEgAAmS7hNA
	; Fri, 08 Jun 2018 18:52:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 15AC5607DC; Fri,  8 Jun 2018 18:52:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 881ED6074D;
	Fri,  8 Jun 2018 18:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 881ED6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeFHSvq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:51:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53810 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006Nz-8U; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] __gfs2_lookup(), nfs_finish_open() and fuse_create_open() don't need 'opened'
Date: Fri,  8 Jun 2018 19:50:14 +0100
Message-Id: <20180608185019.24472-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c   | 4 ++--
 fs/gfs2/inode.c | 7 +++----
 fs/nfs/dir.c    | 5 ++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 18952cd38772..ae40501d39c9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -399,7 +399,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
  */
 static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
-			    umode_t mode, int *opened)
+			    umode_t mode)
 {
 	int err;
 	struct inode *inode;
@@ -513,7 +513,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, opened);
+	err = fuse_create_open(dir, entry, file, flags, mode);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 7bb236b99598..198e07d5ecdd 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -830,14 +830,13 @@ static int gfs2_create(struct inode *dir, struct dentry *dentry,
  * @dir: The directory inode
  * @dentry: The dentry of the new inode
  * @file: File to be opened
- * @opened: atomic_open flags
  *
  *
  * Returns: errno
  */
 
 static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
-				    struct file *file, int *opened)
+				    struct file *file)
 {
 	struct inode *inode;
 	struct dentry *d;
@@ -879,7 +878,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 static struct dentry *gfs2_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned flags)
 {
-	return __gfs2_lookup(dir, dentry, NULL, NULL);
+	return __gfs2_lookup(dir, dentry, NULL);
 }
 
 /**
@@ -1244,7 +1243,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!d_in_lookup(dentry))
 		goto skip_lookup;
 
-	d = __gfs2_lookup(dir, dentry, file, opened);
+	d = __gfs2_lookup(dir, dentry, file);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 	if (d != NULL)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5b8f1d32d6b8..43dc1c66873d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1418,8 +1418,7 @@ static int do_open(struct inode *inode, struct file *filp)
 
 static int nfs_finish_open(struct nfs_open_context *ctx,
 			   struct dentry *dentry,
-			   struct file *file, unsigned open_flags,
-			   int *opened)
+			   struct file *file, unsigned open_flags)
 {
 	int err;
 
@@ -1530,7 +1529,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags, opened);
+	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags);
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-- 
2.11.0

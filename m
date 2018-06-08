Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J8ReBHvQGlsSFAAAmS7hNA
	; Fri, 08 Jun 2018 18:52:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 02C67607E4; Fri,  8 Jun 2018 18:52:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 87E7E601D2;
	Fri,  8 Jun 2018 18:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87E7E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeFHSvm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:51:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53822 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006OH-Hv; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] gfs2_create_inode() doesn't need 'opened' anymore
Date: Fri,  8 Jun 2018 19:50:17 +0100
Message-Id: <20180608185019.24472-11-viro@ZenIV.linux.org.uk>
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
 fs/gfs2/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 146ef177982e..9cb09f63d831 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -580,7 +580,7 @@ static int gfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 			     struct file *file,
 			     umode_t mode, dev_t dev, const char *symname,
-			     unsigned int size, int excl, int *opened)
+			     unsigned int size, int excl)
 {
 	const struct qstr *name = &dentry->d_name;
 	struct posix_acl *default_acl, *acl;
@@ -822,7 +822,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 static int gfs2_create(struct inode *dir, struct dentry *dentry,
 		       umode_t mode, bool excl)
 {
-	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl);
 }
 
 /**
@@ -1188,7 +1188,7 @@ static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
 	if (size >= gfs2_max_stuffed_size(GFS2_I(dir)))
 		return -ENAMETOOLONG;
 
-	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFLNK | S_IRWXUGO, 0, symname, size, 0);
 }
 
 /**
@@ -1203,7 +1203,7 @@ static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
 static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
-	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0);
 }
 
 /**
@@ -1218,7 +1218,7 @@ static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 static int gfs2_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 		      dev_t dev)
 {
-	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0, NULL);
+	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
 }
 
 /**
@@ -1261,7 +1261,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!(flags & O_CREAT))
 		return -ENOENT;
 
-	return gfs2_create_inode(dir, dentry, file, S_IFREG | mode, 0, NULL, 0, excl, opened);
+	return gfs2_create_inode(dir, dentry, file, S_IFREG | mode, 0, NULL, 0, excl);
 }
 
 /*
-- 
2.11.0

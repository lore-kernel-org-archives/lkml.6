Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC60C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC63208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC63208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbeGKCYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45694 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbeGKCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4le-0003L6-86; Wed, 11 Jul 2018 02:22:10 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 34/42] anon_inode_getfile(): switch to alloc_file_pseudo()
Date:   Wed, 11 Jul 2018 03:21:58 +0100
Message-Id: <20180711022206.12571-34-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/anon_inodes.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 3168ee4e77f4..7e13edd23db1 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -71,8 +71,6 @@ struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags)
 {
-	struct qstr this;
-	struct path path;
 	struct file *file;
 
 	if (IS_ERR(anon_inode_inode))
@@ -82,29 +80,15 @@ struct file *anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	/*
-	 * Link the inode to a directory entry by creating a unique name
-	 * using the inode sequence number.
-	 */
-	file = ERR_PTR(-ENOMEM);
-	this.name = name;
-	this.len = strlen(name);
-	this.hash = 0;
-	path.dentry = d_alloc_pseudo(anon_inode_mnt->mnt_sb, &this);
-	if (!path.dentry)
-		goto err_module;
-
-	path.mnt = mntget(anon_inode_mnt);
-	/*
 	 * We know the anon_inode inode count is always greater than zero,
 	 * so ihold() is safe.
 	 */
 	ihold(anon_inode_inode);
-
-	d_instantiate(path.dentry, anon_inode_inode);
-
-	file = alloc_file(&path, OPEN_FMODE(flags), fops);
+	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
+				 OPEN_FMODE(flags), fops);
 	if (IS_ERR(file))
-		goto err_dput;
+		goto err;
+
 	file->f_mapping = anon_inode_inode->i_mapping;
 
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
@@ -112,9 +96,8 @@ struct file *anon_inode_getfile(const char *name,
 
 	return file;
 
-err_dput:
-	path_put(&path);
-err_module:
+err:
+	iput(anon_inode_inode);
 	module_put(fops->owner);
 	return file;
 }
-- 
2.11.0


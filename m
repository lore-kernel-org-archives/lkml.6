Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE8BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E368208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E368208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeGKCYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45664 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeGKCYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4ld-0003Kd-Cn; Wed, 11 Jul 2018 02:22:09 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 30/42] ... and switch shmem_file_setup() to alloc_file_pseudo()
Date:   Wed, 11 Jul 2018 03:21:54 +0100
Message-Id: <20180711022206.12571-30-viro@ZenIV.linux.org.uk>
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
 mm/shmem.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1146a48926bc..fd21df189f32 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3896,18 +3896,11 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
 /* common code */
 
-static const struct dentry_operations anon_ops = {
-	.d_dname = simple_dname
-};
-
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, loff_t size,
 				       unsigned long flags, unsigned int i_flags)
 {
-	struct file *res;
 	struct inode *inode;
-	struct path path;
-	struct super_block *sb;
-	struct qstr this;
+	struct file *res;
 
 	if (IS_ERR(mnt))
 		return ERR_CAST(mnt);
@@ -3918,8 +3911,8 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (shmem_acct_size(flags, size))
 		return ERR_PTR(-ENOMEM);
 
-	sb = mnt->mnt_sb;
-	inode = shmem_get_inode(sb, NULL, S_IFREG | S_IRWXUGO, 0, flags);
+	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
+				flags);
 	if (unlikely(!inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_PTR(-ENOSPC);
@@ -3928,28 +3921,12 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	inode->i_size = size;
 	clear_nlink(inode);	/* It is unlinked */
 	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
-	if (IS_ERR(res)) {
-		iput(inode);
-		return res;
-	}
-
-	this.name = name;
-	this.len = strlen(name);
-	this.hash = 0; /* will go */
-	path.mnt = mntget(mnt);
-	path.dentry = d_alloc_pseudo(sb, &this);
-	if (!path.dentry) {
-		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-	d_set_d_op(path.dentry, &anon_ops);
-
-	d_instantiate(path.dentry, inode);
-
-	res = alloc_file(&path, FMODE_WRITE | FMODE_READ,
-		  &shmem_file_operations);
+	if (!IS_ERR(res))
+		res = alloc_file_pseudo(inode, mnt, name,
+				FMODE_WRITE | FMODE_READ,
+				&shmem_file_operations);
 	if (IS_ERR(res))
-		path_put(&path);
+		iput(inode);
 	return res;
 }
 
-- 
2.11.0


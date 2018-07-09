Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A72C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCCE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCCE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeGIEzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:55:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38126 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGIEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBo-0003gD-2s; Mon, 09 Jul 2018 04:54:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 21/27] hugetlb_file_setup(): switch to alloc_file_pseudo()
Date:   Mon,  9 Jul 2018 05:54:11 +0100
Message-Id: <20180709045417.13988-21-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 55 ++++++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e0b8cc89169c..86ffe04f73d6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1308,10 +1308,6 @@ static int get_hstate_idx(int page_size_log)
 	return h - hstates;
 }
 
-static const struct dentry_operations anon_ops = {
-	.d_dname = simple_dname
-};
-
 /*
  * Note that size should be aligned to proper hugepage size in caller side,
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
@@ -1320,19 +1316,18 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 				vm_flags_t acctflag, struct user_struct **user,
 				int creat_flags, int page_size_log)
 {
-	struct file *file = ERR_PTR(-ENOMEM);
 	struct inode *inode;
-	struct path path;
-	struct super_block *sb;
-	struct qstr quick_string;
+	struct vfsmount *mnt;
 	int hstate_idx;
+	struct file *file;
 
 	hstate_idx = get_hstate_idx(page_size_log);
 	if (hstate_idx < 0)
 		return ERR_PTR(-ENODEV);
 
 	*user = NULL;
-	if (!hugetlbfs_vfsmount[hstate_idx])
+	mnt = hugetlbfs_vfsmount[hstate_idx];
+	if (!mnt)
 		return ERR_PTR(-ENOENT);
 
 	if (creat_flags == HUGETLB_SHMFS_INODE && !can_do_hugetlb_shm()) {
@@ -1348,45 +1343,29 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 		}
 	}
 
-	sb = hugetlbfs_vfsmount[hstate_idx]->mnt_sb;
-	quick_string.name = name;
-	quick_string.len = strlen(quick_string.name);
-	quick_string.hash = 0;
-	path.dentry = d_alloc_pseudo(sb, &quick_string);
-	if (!path.dentry)
-		goto out_shm_unlock;
-
-	d_set_d_op(path.dentry, &anon_ops);
-	path.mnt = mntget(hugetlbfs_vfsmount[hstate_idx]);
 	file = ERR_PTR(-ENOSPC);
-	inode = hugetlbfs_get_inode(sb, NULL, S_IFREG | S_IRWXUGO, 0);
+	inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
-		goto out_dentry;
+		goto out;
 	if (creat_flags == HUGETLB_SHMFS_INODE)
 		inode->i_flags |= S_PRIVATE;
 
-	file = ERR_PTR(-ENOMEM);
-	if (hugetlb_reserve_pages(inode, 0,
-			size >> huge_page_shift(hstate_inode(inode)), NULL,
-			acctflag))
-		goto out_inode;
-
-	d_instantiate(path.dentry, inode);
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	file = alloc_file(&path, FMODE_WRITE | FMODE_READ | FMODE_OPENED,
-			&hugetlbfs_file_operations);
-	if (IS_ERR(file))
-		goto out_dentry; /* inode is already attached */
-
-	return file;
+	if (hugetlb_reserve_pages(inode, 0,
+			size >> huge_page_shift(hstate_inode(inode)), NULL,
+			acctflag))
+		file = ERR_PTR(-ENOMEM);
+	else
+		file = alloc_file_pseudo(inode, mnt, name,
+					FMODE_WRITE | FMODE_READ,
+					&hugetlbfs_file_operations);
+	if (!IS_ERR(file))
+		return file;
 
-out_inode:
 	iput(inode);
-out_dentry:
-	path_put(&path);
-out_shm_unlock:
+out:
 	if (*user) {
 		user_shm_unlock(size, *user);
 		*user = NULL;
-- 
2.11.0


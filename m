Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A17D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A17D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeGIE5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:57:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38110 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeGIEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBn-0003fl-Il; Mon, 09 Jul 2018 04:54:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 17/27] __shmem_file_setup(): reorder allocations
Date:   Mon,  9 Jul 2018 05:54:07 +0100
Message-Id: <20180709045417.13988-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

grab inode and reserve memory first.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a76adc3802d1..0aa290f849ee 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3918,41 +3918,38 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (shmem_acct_size(flags, size))
 		return ERR_PTR(-ENOMEM);
 
-	res = ERR_PTR(-ENOMEM);
+	sb = mnt->mnt_sb;
+	inode = shmem_get_inode(sb, NULL, S_IFREG | S_IRWXUGO, 0, flags);
+	if (unlikely(!inode)) {
+		shmem_unacct_size(flags, size);
+		return ERR_PTR(-ENOSPC);
+	}
+	inode->i_flags |= i_flags;
+	inode->i_size = size;
+	clear_nlink(inode);	/* It is unlinked */
+	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
+	if (IS_ERR(res)) {
+		iput(inode);
+		return res;
+	}
+
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
-	sb = mnt->mnt_sb;
 	path.mnt = mntget(mnt);
 	path.dentry = d_alloc_pseudo(sb, &this);
-	if (!path.dentry)
-		goto put_memory;
+	if (!path.dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
 	d_set_d_op(path.dentry, &anon_ops);
 
-	res = ERR_PTR(-ENOSPC);
-	inode = shmem_get_inode(sb, NULL, S_IFREG | 0777, 0, flags);
-	if (!inode)
-		goto put_memory;
-
-	inode->i_flags |= i_flags;
 	d_instantiate(path.dentry, inode);
-	inode->i_size = size;
-	clear_nlink(inode);	/* It is unlinked */
-	res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
-	if (IS_ERR(res))
-		goto put_path;
 
 	res = alloc_file(&path, FMODE_WRITE | FMODE_READ | FMODE_OPENED,
 		  &shmem_file_operations);
 	if (IS_ERR(res))
-		goto put_path;
-
-	return res;
-
-put_memory:
-	shmem_unacct_size(flags, size);
-put_path:
-	path_put(&path);
+		path_put(&path);
 	return res;
 }
 
-- 
2.11.0


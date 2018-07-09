Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3210CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67FF2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67FF2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeGIEzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:55:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38140 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754455AbeGIEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBo-0003gh-JX; Mon, 09 Jul 2018 04:54:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 25/27] do_shmat(): grab shp->shm_file earlier, switch to alloc_file_clone()
Date:   Mon,  9 Jul 2018 05:54:15 +0100
Message-Id: <20180709045417.13988-25-viro@ZenIV.linux.org.uk>
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
 ipc/shm.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index e37931121070..0cebcf74b669 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1354,14 +1354,13 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	struct shmid_kernel *shp;
 	unsigned long addr = (unsigned long)shmaddr;
 	unsigned long size;
-	struct file *file;
+	struct file *file, *base;
 	int    err;
 	unsigned long flags = MAP_SHARED;
 	unsigned long prot;
 	int acc_mode;
 	struct ipc_namespace *ns;
 	struct shm_file_data *sfd;
-	struct path path;
 	fmode_t f_mode;
 	unsigned long populate = 0;
 
@@ -1435,46 +1434,44 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		goto out_unlock;
 	}
 
-	path = shp->shm_file->f_path;
-	path_get(&path);
+	/*
+	 * We need to take a reference to the real shm file to prevent the
+	 * pointer from becoming stale in cases where the lifetime of the outer
+	 * file extends beyond that of the shm segment.  It's not usually
+	 * possible, but it can happen during remap_file_pages() emulation as
+	 * that unmaps the memory, then does ->mmap() via file reference only.
+	 * We'll deny the ->mmap() if the shm segment was since removed, but to
+	 * detect shm ID reuse we need to compare the file pointers.
+	 */
+	base = get_file(shp->shm_file);
 	shp->shm_nattch++;
-	size = i_size_read(d_inode(path.dentry));
+	size = i_size_read(file_inode(base));
 	ipc_unlock_object(&shp->shm_perm);
 	rcu_read_unlock();
 
 	err = -ENOMEM;
 	sfd = kzalloc(sizeof(*sfd), GFP_KERNEL);
 	if (!sfd) {
-		path_put(&path);
+		fput(base);
 		goto out_nattch;
 	}
 
-	file = alloc_file(&path, f_mode | FMODE_OPENED,
-			  is_file_hugepages(shp->shm_file) ?
+	file = alloc_file_clone(base, f_mode,
+			  is_file_hugepages(base) ?
 				&shm_file_operations_huge :
 				&shm_file_operations);
 	err = PTR_ERR(file);
 	if (IS_ERR(file)) {
 		kfree(sfd);
-		path_put(&path);
+		fput(base);
 		goto out_nattch;
 	}
 
-	file->private_data = sfd;
-	file->f_mapping = shp->shm_file->f_mapping;
 	sfd->id = shp->shm_perm.id;
 	sfd->ns = get_ipc_ns(ns);
-	/*
-	 * We need to take a reference to the real shm file to prevent the
-	 * pointer from becoming stale in cases where the lifetime of the outer
-	 * file extends beyond that of the shm segment.  It's not usually
-	 * possible, but it can happen during remap_file_pages() emulation as
-	 * that unmaps the memory, then does ->mmap() via file reference only.
-	 * We'll deny the ->mmap() if the shm segment was since removed, but to
-	 * detect shm ID reuse we need to compare the file pointers.
-	 */
-	sfd->file = get_file(shp->shm_file);
+	sfd->file = base;
 	sfd->vm_ops = NULL;
+	file->private_data = sfd;
 
 	err = security_mmap_file(file, prot, flags);
 	if (err)
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeEHSEy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53813 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbeEHSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:51 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 02/76] arch: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:22 -0700
Message-Id: <20180508180436.716-3-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 arch/arc/kernel/troubleshoot.c            | 2 +-
 arch/powerpc/platforms/cell/spufs/inode.c | 6 +++---
 arch/s390/hypfs/inode.c                   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 6e9a0a9a6a04..18eb4984d555 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -104,7 +104,7 @@ static void show_faulting_vma(unsigned long address, char *buf)
 		if (file) {
 			nm = file_path(file, buf, PAGE_SIZE - 1);
 			inode = file_inode(vma->vm_file);
-			dev = inode->i_sb->s_dev;
+			dev = inode_sb(inode)->s_dev;
 			ino = inode->i_ino;
 		}
 		pr_info("    @off 0x%lx in [%s]\n"
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index db329d4bf1c3..d04460e86728 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -251,7 +251,7 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 	struct inode *inode;
 	struct spu_context *ctx;
 
-	inode = spufs_new_inode(dir->i_sb, mode | S_IFDIR);
+	inode = spufs_new_inode(inode_sb(dir), mode | S_IFDIR);
 	if (!inode)
 		return -ENOSPC;
 
@@ -284,7 +284,7 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 	else
 		ret = spufs_fill_dir(dentry, spufs_dir_contents, mode, ctx);
 
-	if (!ret && spufs_get_sb_info(dir->i_sb)->debug)
+	if (!ret && spufs_get_sb_info(inode_sb(dir))->debug)
 		ret = spufs_fill_dir(dentry, spufs_dir_debug_contents,
 				mode, ctx);
 
@@ -484,7 +484,7 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct spu_gang *gang;
 
 	ret = -ENOSPC;
-	inode = spufs_new_inode(dir->i_sb, mode | S_IFDIR);
+	inode = spufs_new_inode(inode_sb(dir), mode | S_IFDIR);
 	if (!inode)
 		goto out;
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 43bbe63e2992..6a7679dcd9b7 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -128,7 +128,7 @@ static int hypfs_open(struct inode *inode, struct file *filp)
 			return -EACCES;
 	}
 
-	fs_info = inode->i_sb->s_fs_info;
+	fs_info = inode_sb(inode)->s_fs_info;
 	if(data) {
 		mutex_lock(&fs_info->lock);
 		filp->private_data = kstrdup(data, GFP_KERNEL);
@@ -164,7 +164,7 @@ static ssize_t hypfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	int rc;
-	struct super_block *sb = file_inode(iocb->ki_filp)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(iocb->ki_filp));
 	struct hypfs_sb_info *fs_info = sb->s_fs_info;
 	size_t count = iov_iter_count(from);
 
-- 
2.15.1

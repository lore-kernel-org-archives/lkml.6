Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XCLiDhrOGlsueAAAmS7hNA
	; Fri, 08 Jun 2018 18:50:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6271C607DC; Fri,  8 Jun 2018 18:50:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B1CFC601D2;
	Fri,  8 Jun 2018 18:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1CFC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeFHSuZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:50:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53790 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSp-0006NV-Nk; Fri, 08 Jun 2018 18:50:19 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] introduce FMODE_OPENED
Date: Fri,  8 Jun 2018 19:50:09 +0100
Message-Id: <20180608185019.24472-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

basically, "is that instance set up enough for regular fput(), or
do we want put_filp() for that one".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/perfmon.c | 1 +
 drivers/misc/cxl/api.c     | 2 +-
 fs/aio.c                   | 3 ++-
 fs/anon_inodes.c           | 2 +-
 fs/hugetlbfs/inode.c       | 2 +-
 fs/open.c                  | 3 ++-
 fs/pipe.c                  | 2 ++
 include/linux/fs.h         | 3 +++
 ipc/shm.c                  | 2 +-
 mm/shmem.c                 | 2 +-
 net/socket.c               | 2 +-
 11 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 8fb280e33114..ae4c762321d4 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2684,6 +2684,7 @@ pfm_context_create(pfm_context_t *ctx, void *arg, int count, struct pt_regs *reg
 	 * initialize soft PMU state
 	 */
 	pfm_reset_pmu_state(ctx);
+	filp->f_mode |= FMODE_OPENED;
 
 	fd_install(fd, filp);
 
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 753b1a698fc4..0427ff3f575a 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -102,7 +102,7 @@ static struct file *cxl_getfile(const char *name,
 	path.mnt = mntget(cxl_vfs_mount);
 	d_instantiate(path.dentry, inode);
 
-	file = alloc_file(&path, OPEN_FMODE(flags), fops);
+	file = alloc_file(&path, OPEN_FMODE(flags) | FMODE_OPENED, fops);
 	if (IS_ERR(file))
 		goto err_dput;
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
diff --git a/fs/aio.c b/fs/aio.c
index 49f53516eef0..bbc3fc0d0524 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -223,7 +223,8 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 	path.mnt = mntget(aio_mnt);
 
 	d_instantiate(path.dentry, inode);
-	file = alloc_file(&path, FMODE_READ | FMODE_WRITE, &aio_ring_fops);
+	file = alloc_file(&path, FMODE_READ | FMODE_WRITE | FMODE_OPENED,
+			  &aio_ring_fops);
 	if (IS_ERR(file)) {
 		path_put(&path);
 		return file;
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 3168ee4e77f4..bf952939a1d3 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -102,7 +102,7 @@ struct file *anon_inode_getfile(const char *name,
 
 	d_instantiate(path.dentry, anon_inode_inode);
 
-	file = alloc_file(&path, OPEN_FMODE(flags), fops);
+	file = alloc_file(&path, OPEN_FMODE(flags) | FMODE_OPENED, fops);
 	if (IS_ERR(file))
 		goto err_dput;
 	file->f_mapping = anon_inode_inode->i_mapping;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d508c7844681..e0b8cc89169c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1375,7 +1375,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	file = alloc_file(&path, FMODE_WRITE | FMODE_READ,
+	file = alloc_file(&path, FMODE_WRITE | FMODE_READ | FMODE_OPENED,
 			&hugetlbfs_file_operations);
 	if (IS_ERR(file))
 		goto out_dentry; /* inode is already attached */
diff --git a/fs/open.c b/fs/open.c
index 96ab60d52303..b3b1dbf0227d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -753,7 +753,7 @@ static int do_dentry_open(struct file *f,
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH;
+		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		f->f_op = &empty_fops;
 		return 0;
 	}
@@ -795,6 +795,7 @@ static int do_dentry_open(struct file *f,
 		if (error)
 			goto cleanup_all;
 	}
+	f->f_mode |= FMODE_OPENED;
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(inode);
 	if ((f->f_mode & FMODE_READ) &&
diff --git a/fs/pipe.c b/fs/pipe.c
index 39d6f431da83..a03622bd3491 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -772,6 +772,8 @@ int create_pipe_files(struct file **res, int flags)
 		goto err_file;
 	}
 
+	res[0]->f_mode |= FMODE_OPENED;
+	f->f_mode |= FMODE_OPENED;
 	path_get(&path);
 	res[0]->private_data = inode->i_pipe;
 	res[0]->f_flags = O_RDONLY | (flags & O_NONBLOCK);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8f0b4667ebf1..105f071d4732 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -147,12 +147,15 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* Has write method(s) */
 #define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
 
+#define FMODE_OPENED		((__force fmode_t)0x80000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT	((__force fmode_t)0x8000000)
 
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..2d0a6a9f2559 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1438,7 +1438,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 		goto out_nattch;
 	}
 
-	file = alloc_file(&path, f_mode,
+	file = alloc_file(&path, f_mode | FMODE_OPENED,
 			  is_file_hugepages(shp->shm_file) ?
 				&shm_file_operations_huge :
 				&shm_file_operations);
diff --git a/mm/shmem.c b/mm/shmem.c
index 9d6c7e595415..80103281af8d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4239,7 +4239,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (IS_ERR(res))
 		goto put_path;
 
-	res = alloc_file(&path, FMODE_WRITE | FMODE_READ,
+	res = alloc_file(&path, FMODE_WRITE | FMODE_READ | FMODE_OPENED,
 		  &shmem_file_operations);
 	if (IS_ERR(res))
 		goto put_path;
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..00934c3fa46a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -407,7 +407,7 @@ struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
 
 	d_instantiate(path.dentry, SOCK_INODE(sock));
 
-	file = alloc_file(&path, FMODE_READ | FMODE_WRITE,
+	file = alloc_file(&path, FMODE_READ | FMODE_WRITE | FMODE_OPENED,
 		  &socket_file_ops);
 	if (IS_ERR(file)) {
 		/* drop dentry, keep inode for a bit */
-- 
2.11.0

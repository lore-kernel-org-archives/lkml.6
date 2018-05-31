Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754844AbeEaL37 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbeEaL3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:29:51 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: willy@infradead.org, andres@anarazel.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cmaiolino@redhat.com
Subject: [PATCH v2 3/5] vfs: track per-sb writeback errors and report them to syncfs
Date: Thu, 31 May 2018 07:29:43 -0400
Message-Id: <20180531112945.8629-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Usually we suggest that applications call fsync when they want to
ensure that all data written to the file has made it to the backing
store, but that can be inefficient when there are a lot of open
files.

Calling syncfs on the filesystem can be more efficient in some
situations, but the error reporting doesn't currently work the way most
people expect. If a single inode on a filesystem reports a writeback
error, syncfs won't necessarily return an error. syncfs only returns an
error if __sync_blockdev fails, and on some filesystems that's a no-op.

It would be better if syncfs reported an error if there were any writeback
failures. Then applications could call syncfs to see if there are any
errors on any open files, and could then call fsync on all of the other
descriptors to figure out which one failed.

This patch adds a new errseq_t to struct super_block, and has
mapping_set_error also record writeback errors there.

To report those errors, we also need to keep an errseq_t for in struct
file to act as a cursor, but growing struct file for this purpose is
undesirable. We could just reuse f_wb_err, but someone could mix calls
to fsync and syncfs and that would break things.

This patch implements an alternative suggested by Willy. When the file
is opened with O_PATH, then we repurpose the f_wb_err cursor to track
s_wb_err. Any file opened with O_PATH will not have an fsync
file_operation, and attempts to fsync such a fd will return -EBADF.

Note that calling syncfs on an O_PATH descriptor today will also return
-EBADF, so this scheme gives userland a way to tell whether this
mechanism will work at runtime.

Cc: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/open.c               |  6 +++---
 fs/quota/dquot.c        |  4 ++--
 fs/sync.c               | 28 +++++++++++++++++++++-------
 include/linux/fs.h      |  5 ++++-
 include/linux/pagemap.h |  5 ++++-
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c5ee7cd60424..3e8c7b16abb8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -739,15 +739,15 @@ static int do_dentry_open(struct file *f,
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 
-	/* Ensure that we skip any errors that predate opening of the file */
-	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
-
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH;
 		f->f_op = &empty_fops;
+		f->f_wb_err = errseq_sample(&f->f_path.dentry->d_sb->s_wb_err);
 		goto done;
 	}
 
+	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1894f6ca9dc8..b788678f0f03 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -686,7 +686,7 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	/* This is not very clever (and fast) but currently I don't know about
 	 * any other simple way of getting quota data to disk and we must get
 	 * them there for userspace to be visible... */
-	vfs_sync_fs(sb, 1);
+	vfs_sync_fs(sb, 1, NULL);
 
 	/*
 	 * Now when everything is written we can discard the pagecache so
@@ -2243,7 +2243,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 
 	/* Sync the superblock so that buffers with quota data are written to
 	 * disk (and so userspace sees correct data afterwards). */
-	vfs_sync_fs(sb, 1);
+	vfs_sync_fs(sb, 1, NULL);
 
 	/* Now the quota files are just ordinary files and we can set the
 	 * inode flags back. Moreover we discard the pagecache so that
diff --git a/fs/sync.c b/fs/sync.c
index dc395426a2c8..be547c82e9d8 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -25,11 +25,20 @@
  * Many legacy filesystems don't have a sync_fs op. For them, we just flush
  * the block device (if there is one).
  */
-int vfs_sync_fs(struct super_block *sb, int wait)
+int vfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
+	int ret;
+
 	if (sb->s_op->sync_fs)
-		return sb->s_op->sync_fs(sb, wait);
-	return __sync_blockdev(sb->s_bdev, wait);
+		ret = sb->s_op->sync_fs(sb, wait);
+	ret = __sync_blockdev(sb->s_bdev, wait);
+
+	if (since) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
+		if (ret == 0)
+			ret = ret2;
+	}
+	return ret;
 }
 EXPORT_SYMBOL(vfs_sync_fs);
 
@@ -47,7 +56,7 @@ static int __sync_filesystem(struct super_block *sb, int wait, errseq_t *since)
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
-	return vfs_sync_fs(sb, wait);
+	return vfs_sync_fs(sb, wait, since);
 }
 
 /*
@@ -90,7 +99,7 @@ static void sync_fs_one_sb(struct super_block *sb, void *arg)
 
 	if (sb_rdonly(sb))
 		return;
-	vfs_sync_fs(sb, wait);
+	vfs_sync_fs(sb, wait, NULL);
 }
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
@@ -172,16 +181,21 @@ void emergency_sync(void)
  */
 SYSCALL_DEFINE1(syncfs, int, fd)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	struct super_block *sb;
+	errseq_t *wberr = NULL;
 	int ret;
 
 	if (!f.file)
 		return -EBADF;
+
 	sb = f.file->f_path.dentry->d_sb;
 
+	if (f.file->f_flags & O_PATH)
+		wberr = &f.file->f_wb_err;
+
 	down_read(&sb->s_umount);
-	ret = sync_filesystem(sb, NULL);
+	ret = sync_filesystem(sb, wberr);
 	up_read(&sb->s_umount);
 
 	fdput(f);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 91be22f83ebd..a9ab2be0123f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1416,6 +1416,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
@@ -2491,7 +2494,7 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return false;
 }
 #endif
-int vfs_sync_fs(struct super_block *sb, int wait);
+int vfs_sync_fs(struct super_block *sb, int wait, errseq_t *since);
 extern int sync_filesystem(struct super_block *, errseq_t *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b1bd2186e6d2..2de87c5a2718 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 		return;
 
 	/* Record in wb_err for checkers using errseq_t based tracking */
-	filemap_set_wb_err(mapping, error);
+	__filemap_set_wb_err(mapping, error);
+
+	/* Record it in superblock */
+	errseq_set(&mapping->host->i_sb->s_wb_err, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
-- 
2.17.0

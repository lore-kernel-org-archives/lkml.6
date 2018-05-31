Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeEaLbC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754455AbeEaL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:29:49 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: willy@infradead.org, andres@anarazel.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cmaiolino@redhat.com
Subject: [PATCH v2 1/5] vfs: push __sync_blockdev calls down into sync_fs routines
Date: Thu, 31 May 2018 07:29:41 -0400
Message-Id: <20180531112945.8629-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Currently, we always call __sync_blockdev after sync_fs, though very
few filesystems actually need it these days.

Note that many older filesystems still rely on flushing out the bd_inode
cache to ensure that it's safely written to the backing store, so when
sync_fs is not defined, we do still call __sync_blockdev to support
them.

Export __sync_blockdev and push the calls to __sync_blockdev down into
the sync_fs routines. Push those calls down into the filesystem
->sync_fs routines that actually need it, rather than calling it
unconditionally.

This also means that we need to return the error from the ->sync_fs op
to the caller as well, so add a vfs_sync_fs helper to encapsulate these
details.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/affs/super.c     |  2 +-
 fs/block_dev.c      |  1 +
 fs/ext2/super.c     |  2 +-
 fs/ext4/super.c     |  9 +++++----
 fs/f2fs/super.c     | 15 +++++++++------
 fs/gfs2/super.c     |  4 +++-
 fs/hfs/super.c      |  2 +-
 fs/internal.h       |  7 -------
 fs/jfs/super.c      |  3 +--
 fs/nilfs2/super.c   |  5 +++--
 fs/ocfs2/super.c    |  2 +-
 fs/quota/dquot.c    |  9 +++------
 fs/reiserfs/super.c |  2 +-
 fs/sync.c           | 21 ++++++++++++++++-----
 fs/sysv/inode.c     |  3 +--
 include/linux/fs.h  |  8 ++++++++
 16 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index e602619aed9d..b76af8e3c87d 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -58,7 +58,7 @@ static int
 affs_sync_fs(struct super_block *sb, int wait)
 {
 	affs_commit_super(sb, wait);
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 static void flush_superblock(struct work_struct *work)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..8f1d13a3f02b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -447,6 +447,7 @@ int __sync_blockdev(struct block_device *bdev, int wait)
 		return filemap_flush(bdev->bd_inode->i_mapping);
 	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
 }
+EXPORT_SYMBOL(__sync_blockdev);
 
 /*
  * Write out and wait upon all the dirty data associated with a block
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index de1694512f1f..fd8536bc13da 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1280,7 +1280,7 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
 	}
 	spin_unlock(&sbi->s_lock);
 	ext2_sync_super(sb, es, wait);
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 static int ext2_freeze(struct super_block *sb)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb104e8476f0..ac2ffdbf54e6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4857,13 +4857,13 @@ int ext4_force_commit(struct super_block *sb)
 
 static int ext4_sync_fs(struct super_block *sb, int wait)
 {
-	int ret = 0;
+	int ret = 0, ret2;
 	tid_t target;
 	bool needs_barrier = false;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	if (unlikely(ext4_forced_shutdown(sbi)))
-		return 0;
+		goto out;
 
 	trace_ext4_sync_fs(sb, wait);
 	flush_workqueue(sbi->rsv_conversion_wq);
@@ -4896,8 +4896,9 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 		if (!ret)
 			ret = err;
 	}
-
-	return ret;
+out:
+	ret2 = __sync_blockdev(sb->s_bdev, wait);
+	return ret ? ret : ret2;
 }
 
 /*
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42d564c5ccd0..70fb16aac0bd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1058,15 +1058,17 @@ static void f2fs_put_super(struct super_block *sb)
 int f2fs_sync_fs(struct super_block *sb, int sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int err = 0;
+	int err = 0, err2;
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return 0;
+		goto out;
 
 	trace_f2fs_sync_fs(sb, sync);
 
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		return -EAGAIN;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING))) {
+		err = -EAGAIN;
+		goto out;
+	}
 
 	if (sync) {
 		struct cp_control cpc;
@@ -1078,8 +1080,9 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 		mutex_unlock(&sbi->gc_mutex);
 	}
 	f2fs_trace_ios(NULL, 1);
-
-	return err;
+out:
+	err2 = __sync_blockdev(sb->s_bdev, sync);
+	return err ? err : err2;
 }
 
 static int f2fs_freeze(struct super_block *sb)
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index cf5c7f3080d2..884dd8b7d7b3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -951,13 +951,15 @@ static void gfs2_put_super(struct super_block *sb)
 
 static int gfs2_sync_fs(struct super_block *sb, int wait)
 {
+	int bderr;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	gfs2_quota_sync(sb, -1);
 	if (wait)
 		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_SYNC_FS);
-	return sdp->sd_log_error;
+	bderr = __sync_blockdev(sb->s_bdev, wait);
+	return sdp->sd_log_error ? sdp->sd_log_error : bderr;
 }
 
 void gfs2_freeze_func(struct work_struct *work)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 173876782f73..9cb410ebab7c 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -33,7 +33,7 @@ MODULE_LICENSE("GPL");
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
 	hfs_mdb_commit(sb);
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 /*
diff --git a/fs/internal.h b/fs/internal.h
index e08972db0303..148b74293dfe 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -24,17 +24,10 @@ struct shrink_control;
 #ifdef CONFIG_BLOCK
 extern void __init bdev_cache_init(void);
 
-extern int __sync_blockdev(struct block_device *bdev, int wait);
-
 #else
 static inline void bdev_cache_init(void)
 {
 }
-
-static inline int __sync_blockdev(struct block_device *bdev, int wait)
-{
-	return 0;
-}
 #endif
 
 /*
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1b9264fd54b6..c4b99ad53f9c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -717,8 +717,7 @@ static int jfs_sync_fs(struct super_block *sb, int wait)
 		jfs_flush_journal(log, wait);
 		jfs_syncpt(log, 0);
 	}
-
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 static int jfs_show_options(struct seq_file *seq, struct dentry *root)
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 6ffeca84d7c3..280a28b62d13 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -495,7 +495,7 @@ static int nilfs_sync_fs(struct super_block *sb, int wait)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_super_block **sbp;
-	int err = 0;
+	int err = 0, bderr;
 
 	/* This function is called when super block should be written back */
 	if (wait)
@@ -514,7 +514,8 @@ static int nilfs_sync_fs(struct super_block *sb, int wait)
 	if (!err)
 		err = nilfs_flush_device(nilfs);
 
-	return err;
+	bderr = __sync_blockdev(sb->s_bdev, wait);
+	return err ? err : bderr;
 }
 
 int nilfs_attach_checkpoint(struct super_block *sb, __u64 cno, int curr_mnt,
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3415e0b09398..07a1a297c2ed 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -429,7 +429,7 @@ static int ocfs2_sync_fs(struct super_block *sb, int wait)
 			jbd2_log_wait_commit(osb->journal->j_journal,
 					     target);
 	}
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 static int ocfs2_need_system_inode(struct ocfs2_super *osb, int ino)
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index d88231e3b2be..92e695385875 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -686,9 +686,7 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	/* This is not very clever (and fast) but currently I don't know about
 	 * any other simple way of getting quota data to disk and we must get
 	 * them there for userspace to be visible... */
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
+	vfs_sync_fs(sb, 1);
 
 	/*
 	 * Now when everything is written we can discard the pagecache so
@@ -2245,9 +2243,8 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 
 	/* Sync the superblock so that buffers with quota data are written to
 	 * disk (and so userspace sees correct data afterwards). */
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
+	vfs_sync_fs(sb, 1);
+
 	/* Now the quota files are just ordinary files and we can set the
 	 * inode flags back. Moreover we discard the pagecache so that
 	 * userspace sees the writes we did bypassing the pagecache. We
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1fc934d24459..b3a390eab9b7 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -78,7 +78,7 @@ static int reiserfs_sync_fs(struct super_block *s, int wait)
 		if (!journal_end_sync(&th))
 			reiserfs_flush_old_commits(s);
 	reiserfs_write_unlock(s);
-	return 0;
+	return __sync_blockdev(s->s_bdev, wait);
 }
 
 static void flush_old_commits(struct work_struct *work)
diff --git a/fs/sync.c b/fs/sync.c
index a863cd2490ce..5fc211d16a00 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -21,6 +21,18 @@
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 			SYNC_FILE_RANGE_WAIT_AFTER)
 
+/*
+ * Many legacy filesystems don't have a sync_fs op. For them, we just flush
+ * the block device (if there is one).
+ */
+int vfs_sync_fs(struct super_block *sb, int wait)
+{
+	if (sb->s_op->sync_fs)
+		return sb->s_op->sync_fs(sb, wait);
+	return __sync_blockdev(sb->s_bdev, wait);
+}
+EXPORT_SYMBOL(vfs_sync_fs);
+
 /*
  * Do the filesystem syncing work. For simple filesystems
  * writeback_inodes_sb(sb) just dirties buffers with inodes so we have to
@@ -35,9 +47,7 @@ static int __sync_filesystem(struct super_block *sb, int wait)
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, wait);
-	return __sync_blockdev(sb->s_bdev, wait);
+	return vfs_sync_fs(sb, wait);
 }
 
 /*
@@ -78,8 +88,9 @@ static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
 	int wait = arg ? 1 : 0;
 
-	if (!sb_rdonly(sb) && sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, wait);
+	if (sb_rdonly(sb))
+		return;
+	vfs_sync_fs(sb, wait);
 }
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index bec9f79adb25..2232cf97840b 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -53,8 +53,7 @@ static int sysv_sync_fs(struct super_block *sb, int wait)
 	}
 
 	mutex_unlock(&sbi->s_lock);
-
-	return 0;
+	return __sync_blockdev(sb->s_bdev, wait);
 }
 
 static int sysv_remount(struct super_block *sb, int *flags, char *data)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6bccf323c01e..eee017c5a821 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2441,6 +2441,7 @@ extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
 extern void invalidate_bdev(struct block_device *);
 extern void iterate_bdevs(void (*)(struct block_device *, void *), void *);
+extern int __sync_blockdev(struct block_device *bdev, int wait);
 extern int sync_blockdev(struct block_device *bdev);
 extern void kill_bdev(struct block_device *);
 extern struct super_block *freeze_bdev(struct block_device *);
@@ -2461,6 +2462,11 @@ static inline int sync_blockdev(struct block_device *bdev) { return 0; }
 static inline void kill_bdev(struct block_device *bdev) {}
 static inline void invalidate_bdev(struct block_device *bdev) {}
 
+static inline int __sync_blockdev(struct block_device *bdev, int wait)
+{
+	return 0;
+}
+
 static inline struct super_block *freeze_bdev(struct block_device *sb)
 {
 	return NULL;
@@ -2485,9 +2491,11 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return false;
 }
 #endif
+int vfs_sync_fs(struct super_block *sb, int wait);
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
+
 #ifdef CONFIG_BLOCK
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.17.0

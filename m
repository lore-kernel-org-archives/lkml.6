Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeDCHJM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:09:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46225 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751582AbeDCHJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:09:10 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: introduce private inode status mapping
Date: Tue, 3 Apr 2018 15:08:17 +0800
Message-ID: <20180403070817.113923-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we use generic FS_*_FL defined by vfs to indicate inode status
for each bit of i_flags, so f2fs's flag status definition is tied to vfs'
one, it will be hard for f2fs to reuse bits f2fs never used to indicate
new status..

In order to solve this issue, we introduce private inode status mapping,
Note, for these bits have already been persisted into disk, we should
never change their definition, for other ones, we can remap them for
later new coming status.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/file.c  | 54 +++++++++++++++++++++++-------------------------------
 fs/f2fs/inode.c | 12 ++++++------
 fs/f2fs/namei.c |  6 +++---
 fs/f2fs/super.c |  4 ++--
 5 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 675c39d85111..277ec0172a40 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2156,9 +2156,60 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 	*addr ^= mask;
 }
 
-#define F2FS_REG_FLMASK		(~(FS_DIRSYNC_FL | FS_TOPDIR_FL))
-#define F2FS_OTHER_FLMASK	(FS_NODUMP_FL | FS_NOATIME_FL)
-#define F2FS_FL_INHERITED	(FS_PROJINHERIT_FL)
+/*
+ * Inode flags
+ */
+#define	F2FS_SECRM_FL			0x00000001 /* Secure deletion */
+#define	F2FS_UNRM_FL			0x00000002 /* Undelete */
+#define	F2FS_COMPR_FL			0x00000004 /* Compress file */
+#define F2FS_SYNC_FL			0x00000008 /* Synchronous updates */
+#define F2FS_IMMUTABLE_FL		0x00000010 /* Immutable file */
+#define F2FS_APPEND_FL			0x00000020 /* writes to file may only append */
+#define F2FS_NODUMP_FL			0x00000040 /* do not dump file */
+#define F2FS_NOATIME_FL			0x00000080 /* do not update atime */
+/* Reserved for compression usage... */
+#define F2FS_DIRTY_FL			0x00000100
+#define F2FS_COMPRBLK_FL		0x00000200 /* One or more compressed clusters */
+#define F2FS_NOCOMPR_FL			0x00000400 /* Don't compress */
+#define F2FS_ENCRYPT_FL			0x00000800 /* encrypted file */
+/* End compression flags --- maybe not all used */
+#define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
+#define F2FS_IMAGIC_FL			0x00002000 /* AFS directory */
+#define F2FS_JOURNAL_DATA_FL		0x00004000 /* file data should be journaled */
+#define F2FS_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define F2FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define F2FS_HUGE_FILE_FL               0x00040000 /* Set to each huge file */
+#define F2FS_EXTENTS_FL			0x00080000 /* Inode uses extents */
+#define F2FS_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
+#define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
+#define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
+#define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
+#define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
+
+#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
+#define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
+
+/* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
+#define F2FS_FL_XFLAG_VISIBLE		(F2FS_SYNC_FL | \
+					 F2FS_IMMUTABLE_FL | \
+					 F2FS_APPEND_FL | \
+					 F2FS_NODUMP_FL | \
+					 F2FS_NOATIME_FL | \
+					 F2FS_PROJINHERIT_FL)
+
+/* Flags that should be inherited by new inodes from their parent. */
+#define F2FS_FL_INHERITED (F2FS_SECRM_FL | F2FS_UNRM_FL | F2FS_COMPR_FL |\
+			   F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL |\
+			   F2FS_NOCOMPR_FL | F2FS_JOURNAL_DATA_FL |\
+			   F2FS_NOTAIL_FL | F2FS_DIRSYNC_FL |\
+			   F2FS_PROJINHERIT_FL)
+
+/* Flags that are appropriate for regular files (all but dir-specific ones). */
+#define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_TOPDIR_FL))
+
+/* Flags that are appropriate for non-directories/regular files. */
+#define F2FS_OTHER_FLMASK	(F2FS_NODUMP_FL | F2FS_NOATIME_FL)
 
 static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b94f19b3fa8..7b8fb31086c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -686,16 +686,16 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
 	}
 
-	flags = fi->i_flags & (FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
-	if (flags & FS_APPEND_FL)
+	flags = fi->i_flags & (F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL);
+	if (flags & F2FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-	if (flags & FS_COMPR_FL)
+	if (flags & F2FS_COMPR_FL)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 	if (f2fs_encrypted_inode(inode))
 		stat->attributes |= STATX_ATTR_ENCRYPTED;
-	if (flags & FS_IMMUTABLE_FL)
+	if (flags & F2FS_IMMUTABLE_FL)
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
-	if (flags & FS_NODUMP_FL)
+	if (flags & F2FS_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
@@ -1585,7 +1585,7 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int flags = fi->i_flags &
-			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
+			(F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL);
 	return put_user(flags, (int __user *)arg);
 }
 
@@ -1602,15 +1602,15 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	oldflags = fi->i_flags;
 
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL))
+	if ((flags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
 		if (!capable(CAP_LINUX_IMMUTABLE))
 			return -EPERM;
 
-	flags = flags & (FS_FL_USER_MODIFIABLE | FS_PROJINHERIT_FL);
-	flags |= oldflags & ~(FS_FL_USER_MODIFIABLE | FS_PROJINHERIT_FL);
+	flags = flags & (F2FS_FL_USER_MODIFIABLE | F2FS_PROJINHERIT_FL);
+	flags |= oldflags & ~(F2FS_FL_USER_MODIFIABLE | F2FS_PROJINHERIT_FL);
 	fi->i_flags = flags;
 
-	if (fi->i_flags & FS_PROJINHERIT_FL)
+	if (fi->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 	else
 		clear_inode_flag(inode, FI_PROJ_INHERIT);
@@ -2601,17 +2601,17 @@ static inline __u32 f2fs_iflags_to_xflags(unsigned long iflags)
 {
 	__u32 xflags = 0;
 
-	if (iflags & FS_SYNC_FL)
+	if (iflags & F2FS_SYNC_FL)
 		xflags |= FS_XFLAG_SYNC;
-	if (iflags & FS_IMMUTABLE_FL)
+	if (iflags & F2FS_IMMUTABLE_FL)
 		xflags |= FS_XFLAG_IMMUTABLE;
-	if (iflags & FS_APPEND_FL)
+	if (iflags & F2FS_APPEND_FL)
 		xflags |= FS_XFLAG_APPEND;
-	if (iflags & FS_NODUMP_FL)
+	if (iflags & F2FS_NODUMP_FL)
 		xflags |= FS_XFLAG_NODUMP;
-	if (iflags & FS_NOATIME_FL)
+	if (iflags & F2FS_NOATIME_FL)
 		xflags |= FS_XFLAG_NOATIME;
-	if (iflags & FS_PROJINHERIT_FL)
+	if (iflags & F2FS_PROJINHERIT_FL)
 		xflags |= FS_XFLAG_PROJINHERIT;
 	return xflags;
 }
@@ -2620,31 +2620,23 @@ static inline __u32 f2fs_iflags_to_xflags(unsigned long iflags)
 				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
 				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
 
-/* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
-#define F2FS_FL_XFLAG_VISIBLE		(FS_SYNC_FL | \
-					 FS_IMMUTABLE_FL | \
-					 FS_APPEND_FL | \
-					 FS_NODUMP_FL | \
-					 FS_NOATIME_FL | \
-					 FS_PROJINHERIT_FL)
-
 /* Transfer xflags flags to internal */
 static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
 {
 	unsigned long iflags = 0;
 
 	if (xflags & FS_XFLAG_SYNC)
-		iflags |= FS_SYNC_FL;
+		iflags |= F2FS_SYNC_FL;
 	if (xflags & FS_XFLAG_IMMUTABLE)
-		iflags |= FS_IMMUTABLE_FL;
+		iflags |= F2FS_IMMUTABLE_FL;
 	if (xflags & FS_XFLAG_APPEND)
-		iflags |= FS_APPEND_FL;
+		iflags |= F2FS_APPEND_FL;
 	if (xflags & FS_XFLAG_NODUMP)
-		iflags |= FS_NODUMP_FL;
+		iflags |= F2FS_NODUMP_FL;
 	if (xflags & FS_XFLAG_NOATIME)
-		iflags |= FS_NOATIME_FL;
+		iflags |= F2FS_NOATIME_FL;
 	if (xflags & FS_XFLAG_PROJINHERIT)
-		iflags |= FS_PROJINHERIT_FL;
+		iflags |= F2FS_PROJINHERIT_FL;
 
 	return iflags;
 }
@@ -2657,7 +2649,7 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 
 	memset(&fa, 0, sizeof(struct fsxattr));
 	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
-				(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL));
+				(F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL));
 
 	if (f2fs_sb_has_project_quota(inode->i_sb))
 		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 21d444feec2c..ecd4c9ab18db 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -36,15 +36,15 @@ void f2fs_set_inode_flags(struct inode *inode)
 	unsigned int flags = F2FS_I(inode)->i_flags;
 	unsigned int new_fl = 0;
 
-	if (flags & FS_SYNC_FL)
+	if (flags & F2FS_SYNC_FL)
 		new_fl |= S_SYNC;
-	if (flags & FS_APPEND_FL)
+	if (flags & F2FS_APPEND_FL)
 		new_fl |= S_APPEND;
-	if (flags & FS_IMMUTABLE_FL)
+	if (flags & F2FS_IMMUTABLE_FL)
 		new_fl |= S_IMMUTABLE;
-	if (flags & FS_NOATIME_FL)
+	if (flags & F2FS_NOATIME_FL)
 		new_fl |= S_NOATIME;
-	if (flags & FS_DIRSYNC_FL)
+	if (flags & F2FS_DIRSYNC_FL)
 		new_fl |= S_DIRSYNC;
 	if (f2fs_encrypted_inode(inode))
 		new_fl |= S_ENCRYPTED;
@@ -272,7 +272,7 @@ static int do_read_inode(struct inode *inode)
 	if (!need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
 
-	if (fi->i_flags & FS_PROJINHERIT_FL)
+	if (fi->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_project_quota(sbi->sb) &&
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d5098efe577c..98a7979f5fd9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -61,7 +61,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	}
 
 	if (f2fs_sb_has_project_quota(sbi->sb) &&
-		(F2FS_I(dir)->i_flags & FS_PROJINHERIT_FL))
+		(F2FS_I(dir)->i_flags & F2FS_PROJINHERIT_FL))
 		F2FS_I(inode)->i_projid = F2FS_I(dir)->i_projid;
 	else
 		F2FS_I(inode)->i_projid = make_kprojid(&init_user_ns,
@@ -116,9 +116,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
 
 	if (S_ISDIR(inode->i_mode))
-		F2FS_I(inode)->i_flags |= FS_INDEX_FL;
+		F2FS_I(inode)->i_flags |= F2FS_INDEX_FL;
 
-	if (F2FS_I(inode)->i_flags & FS_PROJINHERIT_FL)
+	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
 	trace_f2fs_new_inode(inode, 0);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42d564c5ccd0..d01c11f5e9c1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1800,7 +1800,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	inode = d_inode(path->dentry);
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags |= FS_NOATIME_FL | FS_IMMUTABLE_FL;
+	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
 	inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
 					S_NOATIME | S_IMMUTABLE);
 	inode_unlock(inode);
@@ -1824,7 +1824,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 		goto out_put;
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags &= ~(FS_NOATIME_FL | FS_IMMUTABLE_FL);
+	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
 	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-- 
2.15.0.55.gc2ece9dc4de6

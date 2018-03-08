Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935573AbeCHGXe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:23:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47792 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S935418AbeCHGXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:23:30 -0500
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: wrap all options with f2fs_sb_info.mount_opt
Date: Thu, 8 Mar 2018 14:22:56 +0800
Message-ID: <20180308062256.97208-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges miscellaneous mount options into struct f2fs_mount_info,
After this patch, once we add new mount option, we don't need to worry
about recovery of it in remount_fs(), since we will recover the
f2fs_sb_info.mount_opt including all options.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c          |   2 +-
 fs/f2fs/dir.c           |   2 +-
 fs/f2fs/f2fs.h          |  64 +++++++-------
 fs/f2fs/file.c          |   4 +-
 fs/f2fs/namei.c         |   6 +-
 fs/f2fs/segment.c       |   8 +-
 fs/f2fs/super.c         | 226 +++++++++++++++++++++++-------------------------
 fs/f2fs/sysfs.c         |   4 +-
 include/linux/f2fs_fs.h |   8 +-
 9 files changed, 154 insertions(+), 170 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6c3c9784de06..3d6ae3173f98 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2300,7 +2300,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	int rw = iov_iter_rw(iter);
 	int err;
 	enum rw_hint hint = iocb->ki_hint;
-	int whint_mode = sbi->whint_mode;
+	int whint_mode = F2FS_OPTION(sbi).whint_mode;
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 87c51709bc48..3644db9177cb 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -704,7 +704,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 
-	if (F2FS_I_SB(dir)->fsync_mode == FSYNC_MODE_STRICT)
+	if (F2FS_OPTION(F2FS_I_SB(dir)).fsync_mode == FSYNC_MODE_STRICT)
 		add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c14b0166beda..2eafda0987ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -98,9 +98,10 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 
-#define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
-#define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
-#define test_opt(sbi, option)	((sbi)->mount_opt.opt & F2FS_MOUNT_##option)
+#define F2FS_OPTION(sbi)	((sbi)->mount_opt)
+#define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
+#define set_opt(sbi, option)	(F2FS_OPTION(sbi).opt |= F2FS_MOUNT_##option)
+#define test_opt(sbi, option)	(F2FS_OPTION(sbi).opt & F2FS_MOUNT_##option)
 
 #define ver_after(a, b)	(typecheck(unsigned long long, a) &&		\
 		typecheck(unsigned long long, b) &&			\
@@ -113,7 +114,25 @@ typedef u32 block_t;	/*
 typedef u32 nid_t;
 
 struct f2fs_mount_info {
-	unsigned int	opt;
+	unsigned int opt;
+	int write_io_size_bits;		/* Write IO size bits */
+	block_t root_reserved_blocks;	/* root reserved blocks */
+	kuid_t s_resuid;		/* reserved blocks for uid */
+	kgid_t s_resgid;		/* reserved blocks for gid */
+	int active_logs;		/* # of active logs */
+	int inline_xattr_size;		/* inline xattr size */
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	struct f2fs_fault_info fault_info;	/* For fault injection */
+#endif
+#ifdef CONFIG_QUOTA
+	/* Names of quota files with journalled quota */
+	char *s_qf_names[MAXQUOTAS];
+	int s_jquota_fmt;			/* Format of quota to use */
+#endif
+	/* For which write hints are passed down to block layer */
+	int whint_mode;
+	int alloc_mode;			/* segment allocation policy */
+	int fsync_mode;			/* fsync policy */
 };
 
 #define F2FS_FEATURE_ENCRYPT		0x0001
@@ -1081,7 +1100,6 @@ struct f2fs_sb_info {
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
 						/* bio ordering for NODE/DATA */
-	int write_io_size_bits;			/* Write IO size bits */
 	mempool_t *write_io_dummy;		/* Dummy pages */
 
 	/* for checkpoint */
@@ -1131,9 +1149,7 @@ struct f2fs_sb_info {
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	loff_t max_file_blocks;			/* max block index of file */
-	int active_logs;			/* # of active logs */
 	int dir_level;				/* directory level */
-	int inline_xattr_size;			/* inline xattr size */
 	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
 	int readdir_ra;				/* readahead inode in readdir */
 
@@ -1143,9 +1159,6 @@ struct f2fs_sb_info {
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
-	block_t root_reserved_blocks;		/* root reserved blocks */
-	kuid_t s_resuid;			/* reserved blocks for uid */
-	kgid_t s_resgid;			/* reserved blocks for gid */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
@@ -1230,25 +1243,6 @@ struct f2fs_sb_info {
 
 	/* Precomputed FS UUID checksum for seeding other checksums */
 	__u32 s_chksum_seed;
-
-	/* For fault injection */
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	struct f2fs_fault_info fault_info;
-#endif
-
-#ifdef CONFIG_QUOTA
-	/* Names of quota files with journalled quota */
-	char *s_qf_names[MAXQUOTAS];
-	int s_jquota_fmt;			/* Format of quota to use */
-#endif
-	/* For which write hints are passed down to block layer */
-	int whint_mode;
-
-	/* segment allocation policy */
-	int alloc_mode;
-
-	/* fsync policy */
-	int fsync_mode;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -1258,7 +1252,7 @@ struct f2fs_sb_info {
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
-	struct f2fs_fault_info *ffi = &sbi->fault_info;
+	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
 	if (!ffi->inject_rate)
 		return false;
@@ -1617,10 +1611,10 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 		return true;
 	if (capable(CAP_SYS_RESOURCE))
 		return true;
-	if (uid_eq(sbi->s_resuid, current_fsuid()))
+	if (uid_eq(F2FS_OPTION(sbi).s_resuid, current_fsuid()))
 		return true;
-	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
-					in_group_p(sbi->s_resgid))
+	if (!gid_eq(F2FS_OPTION(sbi).s_resgid, GLOBAL_ROOT_GID) &&
+					in_group_p(F2FS_OPTION(sbi).s_resgid))
 		return true;
 	return false;
 }
@@ -1656,7 +1650,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 					sbi->current_reserved_blocks;
 
 	if (!__allow_reserved_blocks(sbi, inode))
-		avail_user_block_count -= sbi->root_reserved_blocks;
+		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
@@ -1863,7 +1857,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					sbi->current_reserved_blocks + 1;
 
 	if (!__allow_reserved_blocks(sbi, inode))
-		valid_block_count += sbi->root_reserved_blocks;
+		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 99fa207fc310..3072837744b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -163,9 +163,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		cp_reason = CP_NODE_NEED_CP;
 	else if (test_opt(sbi, FASTBOOT))
 		cp_reason = CP_FASTBOOT_MODE;
-	else if (sbi->active_logs == 2)
+	else if (F2FS_OPTION(sbi).active_logs == 2)
 		cp_reason = CP_SPEC_LOG_NUM;
-	else if (sbi->fsync_mode == FSYNC_MODE_STRICT &&
+	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
 		need_dentry_mark(sbi, inode->i_ino) &&
 		exist_written_data(sbi, F2FS_I(inode)->i_pino, TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 9d7df9f99332..226d6aa9d18a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -97,7 +97,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)) {
 		f2fs_bug_on(sbi, !f2fs_has_extra_attr(inode));
 		if (f2fs_has_inline_xattr(inode))
-			xattr_size = sbi->inline_xattr_size;
+			xattr_size = F2FS_OPTION(sbi).inline_xattr_size;
 		/* Otherwise, will be 0 */
 	} else if (f2fs_has_inline_xattr(inode) ||
 				f2fs_has_inline_dentry(inode)) {
@@ -972,7 +972,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		}
 		f2fs_i_links_write(old_dir, false);
 	}
-	if (sbi->fsync_mode == FSYNC_MODE_STRICT)
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
 		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 
 	f2fs_unlock_op(sbi);
@@ -1125,7 +1125,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 	f2fs_mark_inode_dirty_sync(new_dir, false);
 
-	if (sbi->fsync_mode == FSYNC_MODE_STRICT) {
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
 		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f61c77bd673c..d39f1aee2536 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2171,7 +2171,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
 
 	/* find segments from 0 to reuse freed segments */
-	if (sbi->alloc_mode == ALLOC_MODE_REUSE)
+	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
 		return 0;
 
 	return CURSEG_I(sbi, type)->segno;
@@ -2524,7 +2524,7 @@ int rw_hint_to_seg_type(enum rw_hint hint)
 enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 				enum page_type type, enum temp_type temp)
 {
-	if (sbi->whint_mode == WHINT_MODE_USER) {
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER) {
 		if (type == DATA) {
 			if (temp == WARM)
 				return WRITE_LIFE_NOT_SET;
@@ -2535,7 +2535,7 @@ enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 		} else {
 			return WRITE_LIFE_NOT_SET;
 		}
-	} else if (sbi->whint_mode == WHINT_MODE_FS) {
+	} else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS) {
 		if (type == DATA) {
 			if (temp == WARM)
 				return WRITE_LIFE_LONG;
@@ -2603,7 +2603,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 {
 	int type = 0;
 
-	switch (fio->sbi->active_logs) {
+	switch (F2FS_OPTION(fio->sbi).active_logs) {
 	case 2:
 		type = __get_segment_type_2(fio);
 		break;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bada17cb0fb3..419eaacf3366 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -60,7 +60,7 @@ char *fault_name[FAULT_MAX] = {
 static void f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
 						unsigned int rate)
 {
-	struct f2fs_fault_info *ffi = &sbi->fault_info;
+	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
 	if (rate) {
 		atomic_set(&ffi->inject_ops, 0);
@@ -208,21 +208,24 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 	block_t limit = (sbi->user_block_count << 1) / 1000;
 
 	/* limit is 0.2% */
-	if (test_opt(sbi, RESERVE_ROOT) && sbi->root_reserved_blocks > limit) {
-		sbi->root_reserved_blocks = limit;
+	if (test_opt(sbi, RESERVE_ROOT) &&
+			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
+		F2FS_OPTION(sbi).root_reserved_blocks = limit;
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"Reduce reserved blocks for root = %u",
-				sbi->root_reserved_blocks);
+			F2FS_OPTION(sbi).root_reserved_blocks);
 	}
 	if (!test_opt(sbi, RESERVE_ROOT) &&
-		(!uid_eq(sbi->s_resuid,
+		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
 				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
-		!gid_eq(sbi->s_resgid,
+		!gid_eq(F2FS_OPTION(sbi).s_resgid,
 				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
-				from_kuid_munged(&init_user_ns, sbi->s_resuid),
-				from_kgid_munged(&init_user_ns, sbi->s_resgid));
+				from_kuid_munged(&init_user_ns,
+					F2FS_OPTION(sbi).s_resuid),
+				from_kgid_munged(&init_user_ns,
+					F2FS_OPTION(sbi).s_resgid));
 }
 
 static void init_once(void *foo)
@@ -242,7 +245,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 	char *qname;
 	int ret = -EINVAL;
 
-	if (sb_any_quota_loaded(sb) && !sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && !F2FS_OPTION(sbi).s_qf_names[qtype]) {
 		f2fs_msg(sb, KERN_ERR,
 			"Cannot change journaled "
 			"quota options when quota turned on");
@@ -260,8 +263,8 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 			"Not enough memory for storing quotafile name");
 		return -EINVAL;
 	}
-	if (sbi->s_qf_names[qtype]) {
-		if (strcmp(sbi->s_qf_names[qtype], qname) == 0)
+	if (F2FS_OPTION(sbi).s_qf_names[qtype]) {
+		if (strcmp(F2FS_OPTION(sbi).s_qf_names[qtype], qname) == 0)
 			ret = 0;
 		else
 			f2fs_msg(sb, KERN_ERR,
@@ -274,7 +277,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 			"quotafile must be on filesystem root");
 		goto errout;
 	}
-	sbi->s_qf_names[qtype] = qname;
+	F2FS_OPTION(sbi).s_qf_names[qtype] = qname;
 	set_opt(sbi, QUOTA);
 	return 0;
 errout:
@@ -286,13 +289,13 @@ static int f2fs_clear_qf_name(struct super_block *sb, int qtype)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
-	if (sb_any_quota_loaded(sb) && sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && F2FS_OPTION(sbi).s_qf_names[qtype]) {
 		f2fs_msg(sb, KERN_ERR, "Cannot change journaled quota options"
 			" when quota turned on");
 		return -EINVAL;
 	}
-	kfree(sbi->s_qf_names[qtype]);
-	sbi->s_qf_names[qtype] = NULL;
+	kfree(F2FS_OPTION(sbi).s_qf_names[qtype]);
+	F2FS_OPTION(sbi).s_qf_names[qtype] = NULL;
 	return 0;
 }
 
@@ -308,15 +311,19 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 			 "Cannot enable project quota enforcement.");
 		return -1;
 	}
-	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA] ||
-			sbi->s_qf_names[PRJQUOTA]) {
-		if (test_opt(sbi, USRQUOTA) && sbi->s_qf_names[USRQUOTA])
+	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
+			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
+			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]) {
+		if (test_opt(sbi, USRQUOTA) &&
+				F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
 			clear_opt(sbi, USRQUOTA);
 
-		if (test_opt(sbi, GRPQUOTA) && sbi->s_qf_names[GRPQUOTA])
+		if (test_opt(sbi, GRPQUOTA) &&
+				F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
 			clear_opt(sbi, GRPQUOTA);
 
-		if (test_opt(sbi, PRJQUOTA) && sbi->s_qf_names[PRJQUOTA])
+		if (test_opt(sbi, PRJQUOTA) &&
+				F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
 			clear_opt(sbi, PRJQUOTA);
 
 		if (test_opt(sbi, GRPQUOTA) || test_opt(sbi, USRQUOTA) ||
@@ -326,17 +333,17 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 			return -1;
 		}
 
-		if (!sbi->s_jquota_fmt) {
+		if (!F2FS_OPTION(sbi).s_jquota_fmt) {
 			f2fs_msg(sbi->sb, KERN_ERR, "journaled quota format "
 					"not specified");
 			return -1;
 		}
 	}
 
-	if (f2fs_sb_has_quota_ino(sbi->sb) && sbi->s_jquota_fmt) {
+	if (f2fs_sb_has_quota_ino(sbi->sb) && F2FS_OPTION(sbi).s_jquota_fmt) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"QUOTA feature is enabled, so ignore jquota_fmt");
-		sbi->s_jquota_fmt = 0;
+		F2FS_OPTION(sbi).s_jquota_fmt = 0;
 	}
 	if (f2fs_sb_has_quota_ino(sbi->sb) && f2fs_readonly(sbi->sb)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
@@ -446,7 +453,7 @@ static int parse_options(struct super_block *sb, char *options)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 			set_opt(sbi, INLINE_XATTR_SIZE);
-			sbi->inline_xattr_size = arg;
+			F2FS_OPTION(sbi).inline_xattr_size = arg;
 			break;
 #else
 		case Opt_user_xattr:
@@ -486,7 +493,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 			if (arg != 2 && arg != 4 && arg != NR_CURSEG_TYPE)
 				return -EINVAL;
-			sbi->active_logs = arg;
+			F2FS_OPTION(sbi).active_logs = arg;
 			break;
 		case Opt_disable_ext_identify:
 			set_opt(sbi, DISABLE_EXT_IDENTIFY);
@@ -530,9 +537,9 @@ static int parse_options(struct super_block *sb, char *options)
 			if (test_opt(sbi, RESERVE_ROOT)) {
 				f2fs_msg(sb, KERN_INFO,
 					"Preserve previous reserve_root=%u",
-					sbi->root_reserved_blocks);
+					F2FS_OPTION(sbi).root_reserved_blocks);
 			} else {
-				sbi->root_reserved_blocks = arg;
+				F2FS_OPTION(sbi).root_reserved_blocks = arg;
 				set_opt(sbi, RESERVE_ROOT);
 			}
 			break;
@@ -545,7 +552,7 @@ static int parse_options(struct super_block *sb, char *options)
 					"Invalid uid value %d", arg);
 				return -EINVAL;
 			}
-			sbi->s_resuid = uid;
+			F2FS_OPTION(sbi).s_resuid = uid;
 			break;
 		case Opt_resgid:
 			if (args->from && match_int(args, &arg))
@@ -556,7 +563,7 @@ static int parse_options(struct super_block *sb, char *options)
 					"Invalid gid value %d", arg);
 				return -EINVAL;
 			}
-			sbi->s_resgid = gid;
+			F2FS_OPTION(sbi).s_resgid = gid;
 			break;
 		case Opt_mode:
 			name = match_strdup(&args[0]);
@@ -591,7 +598,7 @@ static int parse_options(struct super_block *sb, char *options)
 					1 << arg, BIO_MAX_PAGES);
 				return -EINVAL;
 			}
-			sbi->write_io_size_bits = arg;
+			F2FS_OPTION(sbi).write_io_size_bits = arg;
 			break;
 		case Opt_fault_injection:
 			if (args->from && match_int(args, &arg))
@@ -652,13 +659,13 @@ static int parse_options(struct super_block *sb, char *options)
 				return ret;
 			break;
 		case Opt_jqfmt_vfsold:
-			sbi->s_jquota_fmt = QFMT_VFS_OLD;
+			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_OLD;
 			break;
 		case Opt_jqfmt_vfsv0:
-			sbi->s_jquota_fmt = QFMT_VFS_V0;
+			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_V0;
 			break;
 		case Opt_jqfmt_vfsv1:
-			sbi->s_jquota_fmt = QFMT_VFS_V1;
+			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_V1;
 			break;
 		case Opt_noquota:
 			clear_opt(sbi, QUOTA);
@@ -691,13 +698,13 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 10 &&
 					!strncmp(name, "user-based", 10)) {
-				sbi->whint_mode = WHINT_MODE_USER;
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_USER;
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "off", 3)) {
-				sbi->whint_mode = WHINT_MODE_OFF;
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 			} else if (strlen(name) == 8 &&
 					!strncmp(name, "fs-based", 8)) {
-				sbi->whint_mode = WHINT_MODE_FS;
+				F2FS_OPTION(sbi).whint_mode = WHINT_MODE_FS;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -711,10 +718,10 @@ static int parse_options(struct super_block *sb, char *options)
 
 			if (strlen(name) == 7 &&
 					!strncmp(name, "default", 7)) {
-				sbi->alloc_mode = ALLOC_MODE_DEFAULT;
+				F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
 			} else if (strlen(name) == 5 &&
 					!strncmp(name, "reuse", 5)) {
-				sbi->alloc_mode = ALLOC_MODE_REUSE;
+				F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -727,10 +734,10 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 5 &&
 					!strncmp(name, "posix", 5)) {
-				sbi->fsync_mode = FSYNC_MODE_POSIX;
+				F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 			} else if (strlen(name) == 6 &&
 					!strncmp(name, "strict", 6)) {
-				sbi->fsync_mode = FSYNC_MODE_STRICT;
+				F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_STRICT;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -770,8 +777,9 @@ static int parse_options(struct super_block *sb, char *options)
 					"set with inline_xattr option");
 			return -EINVAL;
 		}
-		if (!sbi->inline_xattr_size ||
-			sbi->inline_xattr_size >= DEF_ADDRS_PER_INODE -
+		if (!F2FS_OPTION(sbi).inline_xattr_size ||
+			F2FS_OPTION(sbi).inline_xattr_size >=
+					DEF_ADDRS_PER_INODE -
 					F2FS_TOTAL_EXTRA_ATTR_SIZE -
 					DEF_INLINE_RESERVED_SIZE -
 					DEF_MIN_INLINE_SIZE) {
@@ -784,8 +792,8 @@ static int parse_options(struct super_block *sb, char *options)
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_TYPE.
 	 */
-	if (sbi->active_logs != NR_CURSEG_TYPE)
-		sbi->whint_mode = WHINT_MODE_OFF;
+	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
+		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 	return 0;
 }
 
@@ -1027,7 +1035,7 @@ static void f2fs_put_super(struct super_block *sb)
 	mempool_destroy(sbi->write_io_dummy);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
-		kfree(sbi->s_qf_names[i]);
+		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	destroy_percpu_info(sbi);
 	for (i = 0; i < NR_PAGE_TYPE; i++)
@@ -1141,8 +1149,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
-	if (buf->f_bfree > sbi->root_reserved_blocks)
-		buf->f_bavail = buf->f_bfree - sbi->root_reserved_blocks;
+	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
+		buf->f_bavail = buf->f_bfree -
+				F2FS_OPTION(sbi).root_reserved_blocks;
 	else
 		buf->f_bavail = 0;
 
@@ -1177,10 +1186,10 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 #ifdef CONFIG_QUOTA
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
-	if (sbi->s_jquota_fmt) {
+	if (F2FS_OPTION(sbi).s_jquota_fmt) {
 		char *fmtname = "";
 
-		switch (sbi->s_jquota_fmt) {
+		switch (F2FS_OPTION(sbi).s_jquota_fmt) {
 		case QFMT_VFS_OLD:
 			fmtname = "vfsold";
 			break;
@@ -1194,14 +1203,17 @@ static inline void f2fs_show_quota_options(struct seq_file *seq,
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
-	if (sbi->s_qf_names[USRQUOTA])
-		seq_show_option(seq, "usrjquota", sbi->s_qf_names[USRQUOTA]);
+	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA])
+		seq_show_option(seq, "usrjquota",
+			F2FS_OPTION(sbi).s_qf_names[USRQUOTA]);
 
-	if (sbi->s_qf_names[GRPQUOTA])
-		seq_show_option(seq, "grpjquota", sbi->s_qf_names[GRPQUOTA]);
+	if (F2FS_OPTION(sbi).s_qf_names[GRPQUOTA])
+		seq_show_option(seq, "grpjquota",
+			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA]);
 
-	if (sbi->s_qf_names[PRJQUOTA])
-		seq_show_option(seq, "prjjquota", sbi->s_qf_names[PRJQUOTA]);
+	if (F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
+		seq_show_option(seq, "prjjquota",
+			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA]);
 #endif
 }
 
@@ -1236,7 +1248,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",noinline_xattr");
 	if (test_opt(sbi, INLINE_XATTR_SIZE))
 		seq_printf(seq, ",inline_xattr_size=%u",
-					sbi->inline_xattr_size);
+					F2FS_OPTION(sbi).inline_xattr_size);
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 	if (test_opt(sbi, POSIX_ACL))
@@ -1272,18 +1284,20 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "adaptive");
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
-	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
 	if (test_opt(sbi, RESERVE_ROOT))
 		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
-				sbi->root_reserved_blocks,
-				from_kuid_munged(&init_user_ns, sbi->s_resuid),
-				from_kgid_munged(&init_user_ns, sbi->s_resgid));
+				F2FS_OPTION(sbi).root_reserved_blocks,
+				from_kuid_munged(&init_user_ns,
+					F2FS_OPTION(sbi).s_resuid),
+				from_kgid_munged(&init_user_ns,
+					F2FS_OPTION(sbi).s_resgid));
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (test_opt(sbi, FAULT_INJECTION))
 		seq_printf(seq, ",fault_injection=%u",
-				sbi->fault_info.inject_rate);
+				F2FS_OPTION(sbi).fault_info.inject_rate);
 #endif
 #ifdef CONFIG_QUOTA
 	if (test_opt(sbi, QUOTA))
@@ -1296,19 +1310,19 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
-	if (sbi->whint_mode == WHINT_MODE_USER)
+	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER)
 		seq_printf(seq, ",whint_mode=%s", "user-based");
-	else if (sbi->whint_mode == WHINT_MODE_FS)
+	else if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_FS)
 		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
-	if (sbi->alloc_mode == ALLOC_MODE_DEFAULT)
+	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_DEFAULT)
 		seq_printf(seq, ",alloc_mode=%s", "default");
-	else if (sbi->alloc_mode == ALLOC_MODE_REUSE)
+	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
 		seq_printf(seq, ",alloc_mode=%s", "reuse");
 
-	if (sbi->fsync_mode == FSYNC_MODE_POSIX)
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
 		seq_printf(seq, ",fsync_mode=%s", "posix");
-	else if (sbi->fsync_mode == FSYNC_MODE_STRICT)
+	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
 		seq_printf(seq, ",fsync_mode=%s", "strict");
 	return 0;
 }
@@ -1316,11 +1330,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
-	sbi->active_logs = NR_CURSEG_TYPE;
-	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
-	sbi->whint_mode = WHINT_MODE_OFF;
-	sbi->alloc_mode = ALLOC_MODE_DEFAULT;
-	sbi->fsync_mode = FSYNC_MODE_POSIX;
+	F2FS_OPTION(sbi).active_logs = NR_CURSEG_TYPE;
+	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
+	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
+	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
+	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
 	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
@@ -1358,24 +1372,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
 	unsigned long old_sb_flags;
-	int err, active_logs;
+	int err;
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
-	int old_whint_mode = sbi->whint_mode;
-	int old_alloc_mode = sbi->alloc_mode;
-	int old_fsync_mode = sbi->fsync_mode;
-	int old_inline_xattr_size = sbi->inline_xattr_size;
-	block_t old_root_reserved_blocks = sbi->root_reserved_blocks;
-	kuid_t old_resuid = sbi->s_resuid;
-	kgid_t old_resgid = sbi->s_resgid;
-	int old_write_io_size_bits = sbi->write_io_size_bits;
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	struct f2fs_fault_info ffi = sbi->fault_info;
-#endif
 #ifdef CONFIG_QUOTA
-	int s_jquota_fmt;
-	char *s_qf_names[MAXQUOTAS];
 	int i, j;
 #endif
 
@@ -1385,21 +1386,21 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	org_mount_opt = sbi->mount_opt;
 	old_sb_flags = sb->s_flags;
-	active_logs = sbi->active_logs;
 
 #ifdef CONFIG_QUOTA
-	s_jquota_fmt = sbi->s_jquota_fmt;
+	org_mount_opt.s_jquota_fmt = F2FS_OPTION(sbi).s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
-		if (sbi->s_qf_names[i]) {
-			s_qf_names[i] = kstrdup(sbi->s_qf_names[i],
-							 GFP_KERNEL);
-			if (!s_qf_names[i]) {
+		if (F2FS_OPTION(sbi).s_qf_names[i]) {
+			org_mount_opt.s_qf_names[i] =
+				kstrdup(F2FS_OPTION(sbi).s_qf_names[i],
+				GFP_KERNEL);
+			if (!org_mount_opt.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
-					kfree(s_qf_names[j]);
+					kfree(org_mount_opt.s_qf_names[j]);
 				return -ENOMEM;
 			}
 		} else {
-			s_qf_names[i] = NULL;
+			org_mount_opt.s_qf_names[i] = NULL;
 		}
 	}
 #endif
@@ -1469,7 +1470,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
-	if (*flags & SB_RDONLY || sbi->whint_mode != old_whint_mode) {
+	if (*flags & SB_RDONLY ||
+		F2FS_OPTION(sbi).whint_mode != org_mount_opt.whint_mode) {
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 		sync_inodes_sb(sb);
 
@@ -1495,7 +1497,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 #ifdef CONFIG_QUOTA
 	/* Release old quota file names */
 	for (i = 0; i < MAXQUOTAS; i++)
-		kfree(s_qf_names[i]);
+		kfree(org_mount_opt.s_qf_names[i]);
 #endif
 	/* Update the POSIXACL Flag */
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
@@ -1513,26 +1515,14 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	}
 restore_opts:
 #ifdef CONFIG_QUOTA
-	sbi->s_jquota_fmt = s_jquota_fmt;
+	F2FS_OPTION(sbi).s_jquota_fmt = org_mount_opt.s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
-		kfree(sbi->s_qf_names[i]);
-		sbi->s_qf_names[i] = s_qf_names[i];
+		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
+		F2FS_OPTION(sbi).s_qf_names[i] = org_mount_opt.s_qf_names[i];
 	}
 #endif
-	sbi->write_io_size_bits = old_write_io_size_bits;
-	sbi->s_resgid = old_resgid;
-	sbi->s_resuid = old_resuid;
-	sbi->root_reserved_blocks = old_root_reserved_blocks;
-	sbi->inline_xattr_size = old_inline_xattr_size;
-	sbi->fsync_mode = old_fsync_mode;
-	sbi->alloc_mode = old_alloc_mode;
-	sbi->whint_mode = old_whint_mode;
 	sbi->mount_opt = org_mount_opt;
-	sbi->active_logs = active_logs;
 	sb->s_flags = old_sb_flags;
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	sbi->fault_info = ffi;
-#endif
 	return err;
 }
 
@@ -1654,8 +1644,8 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
 
 static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
 {
-	return dquot_quota_on_mount(sbi->sb, sbi->s_qf_names[type],
-						sbi->s_jquota_fmt, type);
+	return dquot_quota_on_mount(sbi->sb, F2FS_OPTION(sbi).s_qf_names[type],
+					F2FS_OPTION(sbi).s_jquota_fmt, type);
 }
 
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
@@ -1674,7 +1664,7 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
 	}
 
 	for (i = 0; i < MAXQUOTAS; i++) {
-		if (sbi->s_qf_names[i]) {
+		if (F2FS_OPTION(sbi).s_qf_names[i]) {
 			err = f2fs_quota_on_mount(sbi, i);
 			if (!err) {
 				enabled = 1;
@@ -2558,7 +2548,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 
 	/* adjust parameters according to the volume size */
 	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
-		sbi->alloc_mode = ALLOC_MODE_REUSE;
+		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 		sm_i->dcc_info->discard_granularity = 1;
 		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
 	}
@@ -2611,8 +2601,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
-	sbi->s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
-	sbi->s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
+	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
+	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
 
 	/* precompute checksum seed for metadata */
 	if (f2fs_sb_has_inode_chksum(sb))
@@ -2970,7 +2960,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_options:
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
-		kfree(sbi->s_qf_names[i]);
+		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	kfree(options);
 free_sb_buf:
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 23a2d8d66c43..7d983ad19da4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -58,7 +58,7 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	else if (struct_type == FAULT_INFO_RATE ||
 					struct_type == FAULT_INFO_TYPE)
-		return (unsigned char *)&sbi->fault_info;
+		return (unsigned char *)&F2FS_OPTION(sbi).fault_info;
 #endif
 	return NULL;
 }
@@ -222,7 +222,7 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
 		if (t > (unsigned long)(sbi->user_block_count -
-					sbi->root_reserved_blocks)) {
+				F2FS_OPTION(sbi).root_reserved_blocks)) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index b06ab1f04ff6..124787e8db58 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -39,10 +39,10 @@
 
 #define F2FS_MAX_QUOTAS		3
 
-#define F2FS_IO_SIZE(sbi)	(1 << (sbi)->write_io_size_bits) /* Blocks */
-#define F2FS_IO_SIZE_KB(sbi)	(1 << ((sbi)->write_io_size_bits + 2)) /* KB */
-#define F2FS_IO_SIZE_BYTES(sbi)	(1 << ((sbi)->write_io_size_bits + 12)) /* B */
-#define F2FS_IO_SIZE_BITS(sbi)	((sbi)->write_io_size_bits) /* power of 2 */
+#define F2FS_IO_SIZE(sbi)	(1 << F2FS_OPTION(sbi).write_io_size_bits) /* Blocks */
+#define F2FS_IO_SIZE_KB(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 2)) /* KB */
+#define F2FS_IO_SIZE_BYTES(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 12)) /* B */
+#define F2FS_IO_SIZE_BITS(sbi)	(F2FS_OPTION(sbi).write_io_size_bits) /* power of 2 */
 #define F2FS_IO_SIZE_MASK(sbi)	(F2FS_IO_SIZE(sbi) - 1)
 
 /* This flag is used by node and meta inodes, and by recovery */
-- 
2.15.0.55.gc2ece9dc4de6

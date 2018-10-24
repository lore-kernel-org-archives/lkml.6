Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33132C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E472082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E472082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJXTCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:02:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbeJXTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:02:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0FAE58E6C05;
        Wed, 24 Oct 2018 18:34:35 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Oct 2018 18:34:31 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: clean up f2fs_sb_has_##feature_name
Date:   Wed, 24 Oct 2018 18:34:26 +0800
Message-ID: <20181024103426.9172-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In F2FS_HAS_FEATURE(), we will use F2FS_SB(sb) to get sbi pointer to
access .raw_super field, to avoid unneeded pointer conversion, this
patch changes to F2FS_HAS_FEATURE() accept sbi parameter directly.

Just do cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       | 23 ++++++++++----------
 fs/f2fs/file.c       | 13 +++++------
 fs/f2fs/inode.c      | 18 +++++++--------
 fs/f2fs/namei.c      |  6 ++---
 fs/f2fs/node.c       |  6 ++---
 fs/f2fs/recovery.c   |  2 +-
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/super.c      | 52 ++++++++++++++++++++++----------------------
 fs/f2fs/sysfs.c      | 20 ++++++++---------
 10 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9c28ea439e0b..3a25cf22d732 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1465,7 +1465,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * invalidate intermediate page cache borrowed from meta inode
 	 * which are used for migration of encrypted inode's blocks.
 	 */
-	if (f2fs_sb_has_encrypt(sbi->sb))
+	if (f2fs_sb_has_encrypt(sbi))
 		invalidate_mapping_pages(META_MAPPING(sbi),
 				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ada394395676..b60ab0b78be5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -152,12 +152,13 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
 #define F2FS_FEATURE_SB_CHKSUM		0x0800
 
-#define F2FS_HAS_FEATURE(sb, mask)					\
-	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
-#define F2FS_SET_FEATURE(sb, mask)					\
-	(F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask))
-#define F2FS_CLEAR_FEATURE(sb, mask)					\
-	(F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask))
+#define __F2FS_HAS_FEATURE(raw_super, mask)				\
+	((raw_super->feature & cpu_to_le32(mask)) != 0)
+#define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
+#define F2FS_SET_FEATURE(sbi, mask)					\
+	(sbi->raw_super->feature |= cpu_to_le32(mask))
+#define F2FS_CLEAR_FEATURE(sbi, mask)					\
+	(sbi->raw_super->feature &= ~cpu_to_le32(mask))
 
 /*
  * Default values for user and/or group using reserved blocks
@@ -3464,9 +3465,9 @@ static inline bool f2fs_post_read_required(struct inode *inode)
 }
 
 #define F2FS_FEATURE_FUNCS(name, flagname) \
-static inline int f2fs_sb_has_##name(struct super_block *sb) \
+static inline int f2fs_sb_has_##name(struct f2fs_sb_info *sbi) \
 { \
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_##flagname); \
+	return F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_##flagname); \
 }
 
 F2FS_FEATURE_FUNCS(encrypt, ENCRYPT);
@@ -3496,7 +3497,7 @@ static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 
 static inline bool f2fs_hw_should_discard(struct f2fs_sb_info *sbi)
 {
-	return f2fs_sb_has_blkzoned(sbi->sb);
+	return f2fs_sb_has_blkzoned(sbi);
 }
 
 static inline bool f2fs_hw_support_discard(struct f2fs_sb_info *sbi)
@@ -3571,7 +3572,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi->sb))
+	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
 	if (test_opt(sbi, LFS) && (rw == WRITE) &&
 				block_unaligned_IO(inode, iocb, iter))
@@ -3594,7 +3595,7 @@ extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 {
 #ifdef CONFIG_QUOTA
-	if (f2fs_sb_has_quota_ino(sbi->sb))
+	if (f2fs_sb_has_quota_ino(sbi))
 		return true;
 	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
 		F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 88b124677189..82f144052fce 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -696,7 +696,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	unsigned int flags;
 
 	if (f2fs_has_extra_attr(inode) &&
-			f2fs_sb_has_inode_crtime(inode->i_sb) &&
+			f2fs_sb_has_inode_crtime(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime.tv_sec = fi->i_crtime.tv_sec;
@@ -2030,7 +2030,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	if (!f2fs_sb_has_encrypt(inode->i_sb))
+	if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
@@ -2040,7 +2040,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
 {
-	if (!f2fs_sb_has_encrypt(file_inode(filp)->i_sb))
+	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
 		return -EOPNOTSUPP;
 	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
 }
@@ -2051,7 +2051,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
-	if (!f2fs_sb_has_encrypt(inode->i_sb))
+	if (!f2fs_sb_has_encrypt(sbi))
 		return -EOPNOTSUPP;
 
 	err = mnt_want_write_file(filp);
@@ -2635,12 +2635,11 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct super_block *sb = sbi->sb;
 	struct page *ipage;
 	kprojid_t kprojid;
 	int err;
 
-	if (!f2fs_sb_has_project_quota(sb)) {
+	if (!f2fs_sb_has_project_quota(sbi)) {
 		if (projid != F2FS_DEF_PROJID)
 			return -EOPNOTSUPP;
 		else
@@ -2757,7 +2756,7 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
 				F2FS_FL_USER_VISIBLE);
 
-	if (f2fs_sb_has_project_quota(inode->i_sb))
+	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
 							fi->i_projid);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 91ceee0ed4c4..f63d4fe6156d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -118,7 +118,7 @@ static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page
 {
 	struct f2fs_inode *ri = &F2FS_NODE(page)->i;
 
-	if (!f2fs_sb_has_inode_chksum(sbi->sb))
+	if (!f2fs_sb_has_inode_chksum(sbi))
 		return false;
 
 	if (!IS_INODE(page) || !(ri->i_inline & F2FS_EXTRA_ATTR))
@@ -218,7 +218,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
-	if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)
+	if (f2fs_sb_has_flexible_inline_xattr(sbi)
 			&& !f2fs_has_extra_attr(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_msg(sbi->sb, KERN_WARNING,
@@ -228,7 +228,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 	}
 
 	if (f2fs_has_extra_attr(inode) &&
-			!f2fs_sb_has_extra_attr(sbi->sb)) {
+			!f2fs_sb_has_extra_attr(sbi)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"%s: inode (ino=%lx) is with extra_attr, "
@@ -340,7 +340,7 @@ static int do_read_inode(struct inode *inode)
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
 
-	if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)) {
+	if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
 		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
 	} else if (f2fs_has_inline_xattr(inode) ||
 				f2fs_has_inline_dentry(inode)) {
@@ -390,14 +390,14 @@ static int do_read_inode(struct inode *inode)
 	if (fi->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
-	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_project_quota(sbi->sb) &&
+	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_project_quota(sbi) &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_projid))
 		i_projid = (projid_t)le32_to_cpu(ri->i_projid);
 	else
 		i_projid = F2FS_DEF_PROJID;
 	fi->i_projid = make_kprojid(&init_user_ns, i_projid);
 
-	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_inode_crtime(sbi->sb) &&
+	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_inode_crtime(sbi) &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
 		fi->i_crtime.tv_sec = le64_to_cpu(ri->i_crtime);
 		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
@@ -542,11 +542,11 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	if (f2fs_has_extra_attr(inode)) {
 		ri->i_extra_isize = cpu_to_le16(F2FS_I(inode)->i_extra_isize);
 
-		if (f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb))
+		if (f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)))
 			ri->i_inline_xattr_size =
 				cpu_to_le16(F2FS_I(inode)->i_inline_xattr_size);
 
-		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
+		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 								i_projid)) {
 			projid_t i_projid;
@@ -556,7 +556,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 			ri->i_projid = cpu_to_le32(i_projid);
 		}
 
-		if (f2fs_sb_has_inode_crtime(F2FS_I_SB(inode)->sb) &&
+		if (f2fs_sb_has_inode_crtime(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
 								i_crtime)) {
 			ri->i_crtime =
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 99299ede7429..2d5626939893 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -61,7 +61,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		goto fail;
 	}
 
-	if (f2fs_sb_has_project_quota(sbi->sb) &&
+	if (f2fs_sb_has_project_quota(sbi) &&
 		(F2FS_I(dir)->i_flags & F2FS_PROJINHERIT_FL))
 		F2FS_I(inode)->i_projid = F2FS_I(dir)->i_projid;
 	else
@@ -79,7 +79,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 				f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
-	if (f2fs_sb_has_extra_attr(sbi->sb)) {
+	if (f2fs_sb_has_extra_attr(sbi)) {
 		set_inode_flag(inode, FI_EXTRA_ATTR);
 		F2FS_I(inode)->i_extra_isize = F2FS_TOTAL_EXTRA_ATTR_SIZE;
 	}
@@ -92,7 +92,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(inode, FI_INLINE_DENTRY);
 
-	if (f2fs_sb_has_flexible_inline_xattr(sbi->sb)) {
+	if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
 		f2fs_bug_on(sbi, !f2fs_has_extra_attr(inode));
 		if (f2fs_has_inline_xattr(inode))
 			xattr_size = F2FS_OPTION(sbi).inline_xattr_size;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2b34206486d8..904f4b97a1aa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2563,17 +2563,17 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (dst->i_inline & F2FS_EXTRA_ATTR) {
 		dst->i_extra_isize = src->i_extra_isize;
 
-		if (f2fs_sb_has_flexible_inline_xattr(sbi->sb) &&
+		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 							i_inline_xattr_size))
 			dst->i_inline_xattr_size = src->i_inline_xattr_size;
 
-		if (f2fs_sb_has_project_quota(sbi->sb) &&
+		if (f2fs_sb_has_project_quota(sbi) &&
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 								i_projid))
 			dst->i_projid = src->i_projid;
 
-		if (f2fs_sb_has_inode_crtime(sbi->sb) &&
+		if (f2fs_sb_has_inode_crtime(sbi) &&
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 							i_crtime_nsec)) {
 			dst->i_crtime = src->i_crtime;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 1dfb17f9f9ff..c22f9d0011ba 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -250,7 +250,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 	i_gid_write(inode, le32_to_cpu(raw->i_gid));
 
 	if (raw->i_inline & F2FS_EXTRA_ATTR) {
-		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
+		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)) &&
 			F2FS_FITS_IN_INODE(raw, le16_to_cpu(raw->i_extra_isize),
 								i_projid)) {
 			projid_t i_projid;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c04a06e08330..63b109679281 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1736,7 +1736,7 @@ static int __issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 #ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi->sb) &&
+	if (f2fs_sb_has_blkzoned(sbi) &&
 				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
 		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
 #endif
@@ -1948,7 +1948,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					sbi->blocks_per_seg, cur_pos);
 			len = next_pos - cur_pos;
 
-			if (f2fs_sb_has_blkzoned(sbi->sb) ||
+			if (f2fs_sb_has_blkzoned(sbi) ||
 			    (force && len < cpc->trim_minlen))
 				goto skip;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..5b297f3b55e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -259,7 +259,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 			"quota options when quota turned on");
 		return -EINVAL;
 	}
-	if (f2fs_sb_has_quota_ino(sb)) {
+	if (f2fs_sb_has_quota_ino(sbi)) {
 		f2fs_msg(sb, KERN_INFO,
 			"QUOTA feature is enabled, so ignore qf_name");
 		return 0;
@@ -314,7 +314,7 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 	 * 'grpquota' mount options are allowed even without quota feature
 	 * to support legacy quotas in quota files.
 	 */
-	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi->sb)) {
+	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi)) {
 		f2fs_msg(sbi->sb, KERN_ERR, "Project quota feature not enabled. "
 			 "Cannot enable project quota enforcement.");
 		return -1;
@@ -348,7 +348,7 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 		}
 	}
 
-	if (f2fs_sb_has_quota_ino(sbi->sb) && F2FS_OPTION(sbi).s_jquota_fmt) {
+	if (f2fs_sb_has_quota_ino(sbi) && F2FS_OPTION(sbi).s_jquota_fmt) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"QUOTA feature is enabled, so ignore jquota_fmt");
 		F2FS_OPTION(sbi).s_jquota_fmt = 0;
@@ -417,7 +417,7 @@ static int parse_options(struct super_block *sb, char *options)
 			set_opt(sbi, DISCARD);
 			break;
 		case Opt_nodiscard:
-			if (f2fs_sb_has_blkzoned(sb)) {
+			if (f2fs_sb_has_blkzoned(sbi)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"discard is required for zoned block devices");
 				return -EINVAL;
@@ -566,7 +566,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 8 &&
 					!strncmp(name, "adaptive", 8)) {
-				if (f2fs_sb_has_blkzoned(sb)) {
+				if (f2fs_sb_has_blkzoned(sbi)) {
 					f2fs_msg(sb, KERN_WARNING,
 						 "adaptive mode is not allowed with "
 						 "zoned block device feature");
@@ -758,7 +758,7 @@ static int parse_options(struct super_block *sb, char *options)
 			break;
 		case Opt_test_dummy_encryption:
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
-			if (!f2fs_sb_has_encrypt(sb)) {
+			if (!f2fs_sb_has_encrypt(sbi)) {
 				f2fs_msg(sb, KERN_ERR, "Encrypt feature is off");
 				return -EINVAL;
 			}
@@ -799,13 +799,13 @@ static int parse_options(struct super_block *sb, char *options)
 	if (f2fs_check_quota_options(sbi))
 		return -EINVAL;
 #else
-	if (f2fs_sb_has_quota_ino(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			 "Filesystem with quota feature cannot be mounted RDWR "
 			 "without CONFIG_QUOTA");
 		return -EINVAL;
 	}
-	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+	if (f2fs_sb_has_project_quota(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_msg(sb, KERN_ERR,
 			"Filesystem with project quota feature cannot be "
 			"mounted RDWR without CONFIG_QUOTA");
@@ -821,8 +821,8 @@ static int parse_options(struct super_block *sb, char *options)
 	}
 
 	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
-		if (!f2fs_sb_has_extra_attr(sb) ||
-			!f2fs_sb_has_flexible_inline_xattr(sb)) {
+		if (!f2fs_sb_has_extra_attr(sbi) ||
+			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
 			f2fs_msg(sb, KERN_ERR,
 					"extra_attr or flexible_inline_xattr "
 					"feature is off");
@@ -1431,7 +1431,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
 	set_opt(sbi, DISCARD);
-	if (f2fs_sb_has_blkzoned(sbi->sb))
+	if (f2fs_sb_has_blkzoned(sbi))
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
 	else
 		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
@@ -1575,7 +1575,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		sb->s_flags &= ~SB_RDONLY;
 		if (sb_any_quota_suspended(sb)) {
 			dquot_resume(sb, -1);
-		} else if (f2fs_sb_has_quota_ino(sb)) {
+		} else if (f2fs_sb_has_quota_ino(sbi)) {
 			err = f2fs_enable_quotas(sb);
 			if (err)
 				goto restore_opts;
@@ -1817,7 +1817,7 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
 	int enabled = 0;
 	int i, err;
 
-	if (f2fs_sb_has_quota_ino(sbi->sb) && rdonly) {
+	if (f2fs_sb_has_quota_ino(sbi) && rdonly) {
 		err = f2fs_enable_quotas(sbi->sb);
 		if (err) {
 			f2fs_msg(sbi->sb, KERN_ERR,
@@ -1848,7 +1848,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	unsigned long qf_inum;
 	int err;
 
-	BUG_ON(!f2fs_sb_has_quota_ino(sb));
+	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
 
 	qf_inum = f2fs_qf_ino(sb, type);
 	if (!qf_inum)
@@ -1993,7 +1993,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 		goto out_put;
 
 	err = dquot_quota_off(sb, type);
-	if (err || f2fs_sb_has_quota_ino(sb))
+	if (err || f2fs_sb_has_quota_ino(F2FS_SB(sb)))
 		goto out_put;
 
 	inode_lock(inode);
@@ -2173,7 +2173,7 @@ static int f2fs_set_context(struct inode *inode, const void *ctx, size_t len,
 	 * if LOST_FOUND feature is enabled.
 	 *
 	 */
-	if (f2fs_sb_has_lost_found(sbi->sb) &&
+	if (f2fs_sb_has_lost_found(sbi) &&
 			inode->i_ino == F2FS_ROOT_INO(sbi))
 		return -EPERM;
 
@@ -2396,7 +2396,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	__u32 crc = 0;
 
 	/* Check checksum_offset and crc in superblock */
-	if (le32_to_cpu(raw_super->feature) & F2FS_FEATURE_SB_CHKSUM) {
+	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
 		crc_offset = le32_to_cpu(raw_super->checksum_offset);
 		if (crc_offset !=
 			offsetof(struct f2fs_super_block, crc)) {
@@ -2749,7 +2749,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	unsigned int n = 0;
 	int err = -EIO;
 
-	if (!f2fs_sb_has_blkzoned(sbi->sb))
+	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
@@ -2880,7 +2880,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	}
 
 	/* we should update superblock crc here */
-	if (!recover && f2fs_sb_has_sb_chksum(sbi->sb)) {
+	if (!recover && f2fs_sb_has_sb_chksum(sbi)) {
 		crc = f2fs_crc32(sbi, F2FS_RAW_SUPER(sbi),
 				offsetof(struct f2fs_super_block, crc));
 		F2FS_RAW_SUPER(sbi)->crc = cpu_to_le32(crc);
@@ -2968,7 +2968,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
-				!f2fs_sb_has_blkzoned(sbi->sb)) {
+				!f2fs_sb_has_blkzoned(sbi)) {
 			f2fs_msg(sbi->sb, KERN_ERR,
 				"Zoned block device feature not enabled\n");
 			return -EINVAL;
@@ -3064,7 +3064,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->raw_super = raw_super;
 
 	/* precompute checksum seed for metadata */
-	if (f2fs_sb_has_inode_chksum(sb))
+	if (f2fs_sb_has_inode_chksum(sbi))
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
 						sizeof(raw_super->uuid));
 
@@ -3074,7 +3074,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * devices, but mandatory for host-managed zoned block devices.
 	 */
 #ifndef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sb)) {
+	if (f2fs_sb_has_blkzoned(sbi)) {
 		f2fs_msg(sb, KERN_ERR,
 			 "Zoned block device support is not enabled\n");
 		err = -EOPNOTSUPP;
@@ -3101,13 +3101,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &f2fs_quota_operations;
-	if (f2fs_sb_has_quota_ino(sb))
+	if (f2fs_sb_has_quota_ino(sbi))
 		sb->s_qcop = &dquot_quotactl_sysfile_ops;
 	else
 		sb->s_qcop = &f2fs_quotactl_ops;
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 
-	if (f2fs_sb_has_quota_ino(sbi->sb)) {
+	if (f2fs_sb_has_quota_ino(sbi)) {
 		for (i = 0; i < MAXQUOTAS; i++) {
 			if (f2fs_qf_ino(sbi->sb, i))
 				sbi->nquota_files++;
@@ -3297,7 +3297,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount */
-	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
+	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
 		if (err)
 			f2fs_msg(sb, KERN_ERR,
@@ -3392,7 +3392,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_meta:
 #ifdef CONFIG_QUOTA
 	f2fs_truncate_quota_inode_pages(sb);
-	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb))
+	if (f2fs_sb_has_quota_ino(sbi) && !f2fs_readonly(sb))
 		f2fs_quota_off_umount(sbi->sb);
 #endif
 	/*
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b777cbdd796b..240e4881279e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -90,34 +90,34 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 
-	if (f2fs_sb_has_encrypt(sb))
+	if (f2fs_sb_has_encrypt(sbi))
 		len += snprintf(buf, PAGE_SIZE - len, "%s",
 						"encryption");
-	if (f2fs_sb_has_blkzoned(sb))
+	if (f2fs_sb_has_blkzoned(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "blkzoned");
-	if (f2fs_sb_has_extra_attr(sb))
+	if (f2fs_sb_has_extra_attr(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "extra_attr");
-	if (f2fs_sb_has_project_quota(sb))
+	if (f2fs_sb_has_project_quota(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "projquota");
-	if (f2fs_sb_has_inode_chksum(sb))
+	if (f2fs_sb_has_inode_chksum(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "inode_checksum");
-	if (f2fs_sb_has_flexible_inline_xattr(sb))
+	if (f2fs_sb_has_flexible_inline_xattr(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "flexible_inline_xattr");
-	if (f2fs_sb_has_quota_ino(sb))
+	if (f2fs_sb_has_quota_ino(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "quota_ino");
-	if (f2fs_sb_has_inode_crtime(sb))
+	if (f2fs_sb_has_inode_crtime(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "inode_crtime");
-	if (f2fs_sb_has_lost_found(sb))
+	if (f2fs_sb_has_lost_found(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "lost_found");
-	if (f2fs_sb_has_sb_chksum(sb))
+	if (f2fs_sb_has_sb_chksum(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "sb_checksum");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
-- 
2.18.0.rc1


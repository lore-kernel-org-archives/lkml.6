Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3C7218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3C7218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeHQMVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:21:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbeHQMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:21:35 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 89696F8F2111F;
        Fri, 17 Aug 2018 17:18:53 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 17:18:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH 2/2] f2fs: guarantee journalled quota data by checkpoint
Date:   Fri, 17 Aug 2018 17:18:40 +0800
Message-ID: <20180817091840.50792-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180817091840.50792-1-yuchao0@huawei.com>
References: <20180817091840.50792-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For journalled quota mode, let checkpoint to flush dquot dirty data
and quota file data to keep all file quota info are consisting in
last checkpoint, so that we can avoid quota file being corrupted
after SPO.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 12 ++++++++
 fs/f2fs/data.c       |  4 ++-
 fs/f2fs/f2fs.h       |  2 ++
 fs/f2fs/super.c      | 67 ++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0274446f585e..cf8d1bb8ec3e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1100,7 +1100,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	blk_start_plug(&plug);
 
 retry_flush_dents:
+	if (is_sbi_flag_set(sbi, SBI_NEED_FLUSH_QUOTA)) {
+		clear_sbi_flag(sbi, SBI_NEED_FLUSH_QUOTA);
+		err = f2fs_quota_sync(sbi->sb, -1);
+		if (err)
+			goto out;
+	}
+
 	f2fs_lock_all(sbi);
+	if (is_sbi_flag_set(sbi, SBI_NEED_FLUSH_QUOTA)) {
+		f2fs_unlock_all(sbi);
+		goto retry_flush_dents;
+	}
+
 	/* write all the dirty dentry pages */
 	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8e754710c746..0bfb10cd9ad2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -49,7 +49,7 @@ static bool __is_cp_guaranteed(struct page *page)
 			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
 			S_ISDIR(inode->i_mode) ||
 			(S_ISREG(inode->i_mode) &&
-			is_inode_flag_set(inode, FI_ATOMIC_FILE)) ||
+			(f2fs_is_atomic_file(inode) || IS_NOQUOTA(inode))) ||
 			is_cold_data(page))
 		return true;
 	return false;
@@ -1721,6 +1721,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	}
 	if (S_ISDIR(inode->i_mode))
 		return true;
+	if (IS_NOQUOTA(inode))
+		return true;
 	if (f2fs_is_atomic_file(inode))
 		return true;
 	if (fio) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 54ee8217092e..b7ba5aaeb61e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1093,6 +1093,7 @@ enum {
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 	SBI_CP_DISABLED,			/* CP was disabled last mount */
+	SBI_NEED_FLUSH_QUOTA,			/* need to flush quota info in CP */
 };
 
 enum {
@@ -2888,6 +2889,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 int f2fs_inode_dirtied(struct inode *inode, bool sync);
 void f2fs_inode_synced(struct inode *inode);
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
+int f2fs_quota_sync(struct super_block *sb, int type);
 void f2fs_quota_off_umount(struct super_block *sb);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9647bbcdfd2b..f1482363b4eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1886,7 +1886,7 @@ static int f2fs_enable_quotas(struct super_block *sb)
 	return 0;
 }
 
-static int f2fs_quota_sync(struct super_block *sb, int type)
+int f2fs_quota_sync(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
@@ -1988,6 +1988,61 @@ void f2fs_quota_off_umount(struct super_block *sb)
 	}
 }
 
+static int f2fs_dquot_commit(struct dquot *dquot)
+{
+	int ret;
+
+	ret = dquot_commit(dquot);
+	if (ret == -ENOSPC || ret == -EIO)
+		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
+	return ret;
+}
+
+static int f2fs_dquot_acquire(struct dquot *dquot)
+{
+	int ret;
+
+	ret = dquot_acquire(dquot);
+	if (ret == -ENOSPC || ret == -EIO)
+		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
+	return ret;
+}
+
+static int f2fs_dquot_release(struct dquot *dquot)
+{
+	int ret;
+
+	ret = dquot_release(dquot);
+	if (ret == -ENOSPC || ret == -EIO)
+		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
+	return ret;
+}
+
+static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
+{
+	struct super_block *sb = dquot->dq_sb;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	/* if we are using journalled quota */
+	if (f2fs_sb_has_quota_ino(sbi) ||
+		F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
+		F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
+		F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
+		set_sbi_flag(sbi, SBI_NEED_FLUSH_QUOTA);
+
+	return dquot_mark_dquot_dirty(dquot);
+}
+
+static int f2fs_dquot_commit_info(struct super_block *sb, int type)
+{
+	int ret;
+
+	ret = dquot_commit_info(sb, type);
+	if (ret == -ENOSPC || ret == -EIO)
+		set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
+	return ret;
+}
+
 static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
 {
 	*projid = F2FS_I(inode)->i_projid;
@@ -1996,11 +2051,11 @@ static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
 
 static const struct dquot_operations f2fs_quota_operations = {
 	.get_reserved_space = f2fs_get_reserved_space,
-	.write_dquot	= dquot_commit,
-	.acquire_dquot	= dquot_acquire,
-	.release_dquot	= dquot_release,
-	.mark_dirty	= dquot_mark_dquot_dirty,
-	.write_info	= dquot_commit_info,
+	.write_dquot	= f2fs_dquot_commit,
+	.acquire_dquot	= f2fs_dquot_acquire,
+	.release_dquot	= f2fs_dquot_release,
+	.mark_dirty	= f2fs_dquot_mark_dquot_dirty,
+	.write_info	= f2fs_dquot_commit_info,
 	.alloc_dquot	= dquot_alloc,
 	.destroy_dquot	= dquot_destroy,
 	.get_projid	= f2fs_get_projid,
-- 
2.18.0.rc1


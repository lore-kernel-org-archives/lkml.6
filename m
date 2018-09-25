Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A073C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF97220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF97220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeIYNmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:42:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbeIYNmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:42:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5DA90F1965319;
        Tue, 25 Sep 2018 15:36:18 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Tue, 25 Sep 2018 15:36:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/6] f2fs: fix to keep project quota consistent
Date:   Tue, 25 Sep 2018 15:36:02 +0800
Message-ID: <20180925073603.102125-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does below changes to keep consistence of project quota data
in sudden power-cut case:
- update inode.i_projid and project quota atomically under lock_op() in
f2fs_ioc_setproject()
- recover inode.i_projid and project quota in recover_inode()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/file.c     | 37 ++++++++++++++++++++++++++++---------
 fs/f2fs/recovery.c | 12 ++++++++++--
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index be16a49c8b62..171917c0961c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2793,6 +2793,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid);
 int f2fs_pin_file_control(struct inode *inode, bool inc);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a388866e71ee..6f02c8daff76 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2604,13 +2604,29 @@ static int f2fs_ioc_get_features(struct file *filp, unsigned long arg)
 }
 
 #ifdef CONFIG_QUOTA
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	struct dquot *transfer_to[MAXQUOTAS] = {};
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct super_block *sb = sbi->sb;
+	int err = 0;
+
+	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
+	if (!IS_ERR(transfer_to[PRJQUOTA])) {
+		err = __dquot_transfer(inode, transfer_to);
+		if (err)
+			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+		dqput(transfer_to[PRJQUOTA]);
+	}
+	return err;
+}
+
 static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct page *ipage;
 	kprojid_t kprojid;
 	int err;
@@ -2651,21 +2667,24 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	if (err)
 		return err;
 
-	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
-	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-		err = __dquot_transfer(inode, transfer_to);
-		dqput(transfer_to[PRJQUOTA]);
-		if (err)
-			goto out_dirty;
-	}
+	f2fs_lock_op(sbi);
+	err = f2fs_transfer_project_quota(inode, kprojid);
+	if (err)
+		goto out_unlock;
 
 	F2FS_I(inode)->i_projid = kprojid;
 	inode->i_ctime = current_time(inode);
-out_dirty:
 	f2fs_mark_inode_dirty_sync(inode, true);
+out_unlock:
+	f2fs_unlock_op(sbi);
 	return err;
 }
 #else
+int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
+{
+	return 0;
+}
+
 static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 {
 	if (projid != F2FS_DEF_PROJID)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 71577f30a889..5e68e31989c8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -250,10 +250,18 @@ static int recover_inode(struct inode *inode, struct page *page)
 			F2FS_FITS_IN_INODE(raw, le16_to_cpu(raw->i_extra_isize),
 								i_projid)) {
 			projid_t i_projid;
+			kprojid_t kprojid;
 
 			i_projid = (projid_t)le32_to_cpu(raw->i_projid);
-			F2FS_I(inode)->i_projid =
-				make_kprojid(&init_user_ns, i_projid);
+			kprojid = make_kprojid(&init_user_ns, i_projid);
+
+			if (!projid_eq(kprojid, F2FS_I(inode)->i_projid)) {
+				err = f2fs_transfer_project_quota(inode,
+								kprojid);
+				if (err)
+					return err;
+				F2FS_I(inode)->i_projid = kprojid;
+			}
 		}
 	}
 
-- 
2.18.0.rc1


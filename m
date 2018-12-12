Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D77FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B9C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B9C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeLLKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:20:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbeLLKUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:20:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75629B52D322D;
        Wed, 12 Dec 2018 18:20:45 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Wed, 12 Dec 2018 18:20:36 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: rebuild nat_bits during umount
Date:   Wed, 12 Dec 2018 18:20:10 +0800
Message-ID: <20181212102010.109055-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all free_nat_bitmap are available, we can rebuild nat_bits from
free_nat_bitmap entirely during umount, let's make another chance
to reenable nat_bits for image.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 10 +++++---
 fs/f2fs/f2fs.h       |  4 +--
 fs/f2fs/node.c       | 60 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 623536b8e0c0..b9a95b9dd573 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1227,10 +1227,14 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	spin_lock_irqsave(&sbi->cp_lock, flags);
 
-	if ((cpc->reason & CP_UMOUNT) &&
-			le32_to_cpu(ckpt->cp_pack_total_block_count) >
+	if (cpc->reason & CP_UMOUNT) {
+		if (le32_to_cpu(ckpt->cp_pack_total_block_count) >
 			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
-		disable_nat_bits(sbi, false);
+			disable_nat_bits(sbi, false);
+		else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
+						f2fs_nat_bitmap_enabled(sbi))
+			f2fs_enable_nat_bits(sbi);
+	}
 
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7cec897146a3..d00473f917a7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1631,8 +1631,6 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 	if (lock)
 		spin_lock_irqsave(&sbi->cp_lock, flags);
 	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
-	kfree(NM_I(sbi)->nat_bits);
-	NM_I(sbi)->nat_bits = NULL;
 	if (lock)
 		spin_unlock_irqrestore(&sbi->cp_lock, flags);
 }
@@ -2952,6 +2950,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
 int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
+bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
@@ -2975,6 +2974,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
+void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 30a4427aaa94..5a4db4d6bf2e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2036,6 +2036,24 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
 	}
 }
 
+bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int i;
+	bool ret = true;
+
+	down_read(&nm_i->nat_tree_lock);
+	for (i = 0; i < nm_i->nat_blocks; i++) {
+		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
+			ret = false;
+			break;
+		}
+	}
+	up_read(&nm_i->nat_tree_lock);
+
+	return ret;
+}
+
 static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 							bool set, bool build)
 {
@@ -2720,6 +2738,42 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 }
 
+void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int valid = 0;
+	int nat_ofs, nid_ofs = 0;
+
+	down_read(&nm_i->nat_tree_lock);
+
+	for (nat_ofs = 0, nid_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
+		if (nat_ofs == 0) {
+			valid = 1;
+			nid_ofs = 1;
+		}
+
+		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
+			if (!test_bit_le(nid_ofs,
+					nm_i->free_nid_bitmap[nat_ofs]))
+				valid++;
+		}
+
+		if (valid == 0) {
+			__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
+			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
+			continue;
+		}
+
+		__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
+		if (valid == NAT_ENTRY_PER_BLOCK)
+			__set_bit_le(nat_ofs, nm_i->full_nat_bits);
+		else
+			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
+	}
+
+	up_read(&nm_i->nat_tree_lock);
+}
+
 static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		struct nat_entry_set *set, struct cp_control *cpc)
 {
@@ -2862,15 +2916,15 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	__u64 cp_ver = cur_cp_version(ckpt);
 	block_t nat_bits_addr;
 
-	if (!enabled_nat_bits(sbi, NULL))
-		return 0;
-
 	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kzalloc(sbi,
 			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;
 
+	if (!enabled_nat_bits(sbi, NULL))
+		return 0;
+
 	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
-- 
2.18.0.rc1


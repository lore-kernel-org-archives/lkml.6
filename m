Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D429C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AF42177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550585569;
	bh=nZ/TmPh7/H5Nq0Wb39hSqaiuFUCGpKa/inBari9fBGs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KTFEk2gGMGXKuiDXY4FbpD4WFgzuAiLAOai6htv8GfP01j2CPD7zne0twqYnM0Fwc
	 bD5PibcjRyUnZ7JLCdGdquShsTnGuWAms1kaj34als/KxaqxGOpgN5HkkLa5VRGUm3
	 ZSwC8069j5XP7Bjy7/x/chY2Nob79kXGKm70EYXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBSOMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfBSOMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:12:44 -0500
Received: from localhost.localdomain (unknown [49.77.183.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F54521773;
        Tue, 19 Feb 2019 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550585563;
        bh=nZ/TmPh7/H5Nq0Wb39hSqaiuFUCGpKa/inBari9fBGs=;
        h=From:To:Cc:Subject:Date:From;
        b=kE+9M/z+GzqLub8j6jwdL9rddtLSgpt+ei7vmxxl0/LDwdzZrCTpQX1rUIwwKDmcj
         H1piDu0z/Y5DTKZbVsHPjboYEmyXD6lGu7VSf9AaTvsZa0/E3zBhMKJuSLbx8qAjPY
         Cq3zkSS6wE05bqRXegUV+87aBYGoOs58oDpFKBmk=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: rebuild nat_bits during umount
Date:   Sun, 17 Feb 2019 06:26:45 +0800
Message-Id: <20190216222645.18341-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If all free_nat_bitmap are available, we can rebuild nat_bits from
free_nat_bitmap entirely during umount, let's make another chance
to reenable nat_bits for image.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- fix to remove nat journal during umount.
 fs/f2fs/checkpoint.c | 23 +++++++++----
 fs/f2fs/f2fs.h       | 29 ++--------------
 fs/f2fs/node.c       | 82 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 10a3ada28715..b4c9de4e6eb0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1225,12 +1225,22 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sbi->cp_lock, flags);
+	if (cpc->reason & CP_UMOUNT) {
+		if (le32_to_cpu(ckpt->cp_pack_total_block_count) >
+			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
+			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+			f2fs_msg(sbi->sb, KERN_NOTICE,
+				"Disable nat_bits due to no space");
+		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
+						f2fs_nat_bitmap_enabled(sbi)) {
+			f2fs_enable_nat_bits(sbi);
+			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+			f2fs_msg(sbi->sb, KERN_NOTICE,
+				"Rebuild and enable nat_bits");
+		}
+	}
 
-	if ((cpc->reason & CP_UMOUNT) &&
-			le32_to_cpu(ckpt->cp_pack_total_block_count) >
-			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
-		disable_nat_bits(sbi, false);
+	spin_lock_irqsave(&sbi->cp_lock, flags);
 
 	if (cpc->reason & CP_TRIMMED)
 		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
@@ -1395,7 +1405,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk = __start_cp_next_addr(sbi);
 
 	/* write nat bits */
-	if (enabled_nat_bits(sbi, cpc)) {
+	if ((cpc->reason & CP_UMOUNT) &&
+			is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
 		__u64 cp_ver = cur_cp_version(ckpt);
 		block_t blk;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c0d30810ef8a..a543354fc6bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1615,33 +1615,6 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 }
 
-static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
-{
-	unsigned long flags;
-
-	/*
-	 * In order to re-enable nat_bits we need to call fsck.f2fs by
-	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
-	 * so let's rely on regular fsck or unclean shutdown.
-	 */
-
-	if (lock)
-		spin_lock_irqsave(&sbi->cp_lock, flags);
-	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
-	kvfree(NM_I(sbi)->nat_bits);
-	NM_I(sbi)->nat_bits = NULL;
-	if (lock)
-		spin_unlock_irqrestore(&sbi->cp_lock, flags);
-}
-
-static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
-					struct cp_control *cpc)
-{
-	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
-
-	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
-}
-
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	down_read(&sbi->cp_rwsem);
@@ -2970,6 +2943,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
 int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
+bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
@@ -2993,6 +2967,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
+void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f6ff84e29749..e364c6a84f3c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2038,6 +2038,24 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
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
@@ -2698,7 +2716,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 	int valid = 0;
 	int i = 0;
 
-	if (!enabled_nat_bits(sbi, NULL))
+	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
 		return;
 
 	if (nat_index == 0) {
@@ -2722,6 +2740,43 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 }
 
+void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int nat_ofs;
+
+	down_read(&nm_i->nat_tree_lock);
+
+	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
+		int valid = 0, nid_ofs = 0;
+
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
@@ -2738,7 +2793,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
-	if (enabled_nat_bits(sbi, cpc) ||
+	if ((cpc->reason & CP_UMOUNT) ||
 		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
@@ -2813,7 +2868,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	int err = 0;
 
 	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
-	if (enabled_nat_bits(sbi, cpc)) {
+	if (cpc->reason & CP_UMOUNT) {
 		down_write(&nm_i->nat_tree_lock);
 		remove_nats_in_journal(sbi);
 		up_write(&nm_i->nat_tree_lock);
@@ -2829,7 +2884,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and merge them
 	 * into nat entry set.
 	 */
-	if (enabled_nat_bits(sbi, cpc) ||
+	if ((cpc->reason & CP_UMOUNT) ||
 		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
@@ -2864,15 +2919,18 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
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
 
+	nm_i->full_nat_bits = nm_i->nat_bits + 8;
+	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
+
+	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
+		return 0;
+
 	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
@@ -2889,13 +2947,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 
 	cp_ver |= (cur_cp_crc(ckpt) << 32);
 	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
-		disable_nat_bits(sbi, true);
+		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
+		f2fs_msg(sbi->sb, KERN_NOTICE,
+			"Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
+			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
 		return 0;
 	}
 
-	nm_i->full_nat_bits = nm_i->nat_bits + 8;
-	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
-
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Found nat_bits in checkpoint");
 	return 0;
 }
@@ -2906,7 +2964,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 	unsigned int i = 0;
 	nid_t nid, last_nid;
 
-	if (!enabled_nat_bits(sbi, NULL))
+	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
 		return;
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
-- 
2.18.0


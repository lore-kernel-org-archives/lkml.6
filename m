Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeCJSX5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:23:57 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37805 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932943AbeCJSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:53 -0500
X-Google-Smtp-Source: AG47ELvPjld8CYl7tLkfXZvZtMA1Bu2MlhsHYfmRk/SBQ64CpCvX9QzWOS0akN/cT6Jg+7FPgDwwSA==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 80/83] Failure recovery: bitmap operations.
Date: Sat, 10 Mar 2018 10:19:01 -0800
Message-Id: <1520705944-6723-81-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

Upon system failure, NOVA needs to scan all the inode logs
to rebuild the allocator. During the scanning, NOVA stores allocated
log/data pages in a bitmap, and uses the bitmap to rebuild the allocator
once scan finishes.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/bbuild.c | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/bbuild.h |  18 ++++
 2 files changed, 270 insertions(+)

diff --git a/fs/nova/bbuild.c b/fs/nova/bbuild.c
index ca51dca..35c661a 100644
--- a/fs/nova/bbuild.c
+++ b/fs/nova/bbuild.c
@@ -414,6 +414,258 @@ void nova_save_blocknode_mappings_to_log(struct super_block *sb)
 		  pi->log_head, pi->log_tail);
 }
 
+/************************** Bitmap operations ****************************/
+
+static inline void set_scan_bm(unsigned long bit,
+	struct single_scan_bm *scan_bm)
+{
+	set_bit(bit, scan_bm->bitmap);
+}
+
+inline void set_bm(unsigned long bit, struct scan_bitmap *bm,
+	enum bm_type type)
+{
+	switch (type) {
+	case BM_4K:
+		set_scan_bm(bit, &bm->scan_bm_4K);
+		break;
+	case BM_2M:
+		set_scan_bm(bit, &bm->scan_bm_2M);
+		break;
+	case BM_1G:
+		set_scan_bm(bit, &bm->scan_bm_1G);
+		break;
+	default:
+		break;
+	}
+}
+
+static int nova_insert_blocknode_map(struct super_block *sb,
+	int cpuid, unsigned long low, unsigned long high)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct free_list *free_list;
+	struct rb_root *tree;
+	struct nova_range_node *blknode = NULL;
+	unsigned long num_blocks = 0;
+	int ret;
+
+	num_blocks = high - low + 1;
+	nova_dbgv("%s: cpu %d, low %lu, high %lu, num %lu\n",
+		__func__, cpuid, low, high, num_blocks);
+	free_list = nova_get_free_list(sb, cpuid);
+	tree = &(free_list->block_free_tree);
+
+	blknode = nova_alloc_blocknode(sb);
+	if (blknode == NULL)
+		return -ENOMEM;
+	blknode->range_low = low;
+	blknode->range_high = high;
+	ret = nova_insert_blocktree(sbi, tree, blknode);
+	if (ret) {
+		nova_err(sb, "%s failed\n", __func__);
+		nova_free_blocknode(sb, blknode);
+		goto out;
+	}
+	if (!free_list->first_node)
+		free_list->first_node = blknode;
+	free_list->last_node = blknode;
+	free_list->num_blocknode++;
+	free_list->num_free_blocks += num_blocks;
+out:
+	return ret;
+}
+
+static int __nova_build_blocknode_map(struct super_block *sb,
+	unsigned long *bitmap, unsigned long bsize, unsigned long scale)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct free_list *free_list;
+	unsigned long next = 0;
+	unsigned long low = 0;
+	unsigned long start, end;
+	int cpuid = 0;
+
+	free_list = nova_get_free_list(sb, cpuid);
+	start = free_list->block_start;
+	end = free_list->block_end + 1;
+	while (1) {
+		next = find_next_zero_bit(bitmap, end, start);
+		if (next == bsize)
+			break;
+		if (next == end) {
+			if (cpuid == sbi->cpus - 1)
+				break;
+
+			cpuid++;
+			free_list = nova_get_free_list(sb, cpuid);
+			start = free_list->block_start;
+			end = free_list->block_end + 1;
+			continue;
+		}
+
+		low = next;
+		next = find_next_bit(bitmap, end, next);
+		if (nova_insert_blocknode_map(sb, cpuid,
+				low << scale, (next << scale) - 1)) {
+			nova_dbg("Error: could not insert %lu - %lu\n",
+				low << scale, ((next << scale) - 1));
+		}
+		start = next;
+		if (next == bsize)
+			break;
+		if (next == end) {
+			if (cpuid == sbi->cpus - 1)
+				break;
+
+			cpuid++;
+			free_list = nova_get_free_list(sb, cpuid);
+			start = free_list->block_start;
+			end = free_list->block_end + 1;
+		}
+	}
+	return 0;
+}
+
+static void nova_update_4K_map(struct super_block *sb,
+	struct scan_bitmap *bm,	unsigned long *bitmap,
+	unsigned long bsize, unsigned long scale)
+{
+	unsigned long next = 0;
+	unsigned long low = 0;
+	int i;
+
+	while (1) {
+		next = find_next_bit(bitmap, bsize, next);
+		if (next == bsize)
+			break;
+		low = next;
+		next = find_next_zero_bit(bitmap, bsize, next);
+		for (i = (low << scale); i < (next << scale); i++)
+			set_bm(i, bm, BM_4K);
+		if (next == bsize)
+			break;
+	}
+}
+
+struct scan_bitmap *global_bm[MAX_CPUS];
+
+static int nova_build_blocknode_map(struct super_block *sb,
+	unsigned long initsize)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct scan_bitmap *bm;
+	struct scan_bitmap *final_bm;
+	unsigned long *src, *dst;
+	int i, j;
+	int num;
+	int ret;
+
+	final_bm = kzalloc(sizeof(struct scan_bitmap), GFP_KERNEL);
+	if (!final_bm)
+		return -ENOMEM;
+
+	final_bm->scan_bm_4K.bitmap_size =
+				(initsize >> (PAGE_SHIFT + 0x3));
+
+	/* Alloc memory to hold the block alloc bitmap */
+	final_bm->scan_bm_4K.bitmap = kzalloc(final_bm->scan_bm_4K.bitmap_size,
+							GFP_KERNEL);
+
+	if (!final_bm->scan_bm_4K.bitmap) {
+		kfree(final_bm);
+		return -ENOMEM;
+	}
+
+	/*
+	 * We are using free lists. Set 2M and 1G blocks in 4K map,
+	 * and use 4K map to rebuild block map.
+	 */
+	for (i = 0; i < sbi->cpus; i++) {
+		bm = global_bm[i];
+		nova_update_4K_map(sb, bm, bm->scan_bm_2M.bitmap,
+			bm->scan_bm_2M.bitmap_size * 8, PAGE_SHIFT_2M - 12);
+		nova_update_4K_map(sb, bm, bm->scan_bm_1G.bitmap,
+			bm->scan_bm_1G.bitmap_size * 8, PAGE_SHIFT_1G - 12);
+	}
+
+	/* Merge per-CPU bms to the final single bm */
+	num = final_bm->scan_bm_4K.bitmap_size / sizeof(unsigned long);
+	if (final_bm->scan_bm_4K.bitmap_size % sizeof(unsigned long))
+		num++;
+
+	for (i = 0; i < sbi->cpus; i++) {
+		bm = global_bm[i];
+		src = (unsigned long *)bm->scan_bm_4K.bitmap;
+		dst = (unsigned long *)final_bm->scan_bm_4K.bitmap;
+
+		for (j = 0; j < num; j++)
+			dst[j] |= src[j];
+	}
+
+	ret = __nova_build_blocknode_map(sb, final_bm->scan_bm_4K.bitmap,
+			final_bm->scan_bm_4K.bitmap_size * 8, PAGE_SHIFT - 12);
+
+	kfree(final_bm->scan_bm_4K.bitmap);
+	kfree(final_bm);
+
+	return ret;
+}
+
+static void free_bm(struct super_block *sb)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct scan_bitmap *bm;
+	int i;
+
+	for (i = 0; i < sbi->cpus; i++) {
+		bm = global_bm[i];
+		if (bm) {
+			kfree(bm->scan_bm_4K.bitmap);
+			kfree(bm->scan_bm_2M.bitmap);
+			kfree(bm->scan_bm_1G.bitmap);
+			kfree(bm);
+		}
+	}
+}
+
+static int alloc_bm(struct super_block *sb, unsigned long initsize)
+{
+	struct nova_sb_info *sbi = NOVA_SB(sb);
+	struct scan_bitmap *bm;
+	int i;
+
+	for (i = 0; i < sbi->cpus; i++) {
+		bm = kzalloc(sizeof(struct scan_bitmap), GFP_KERNEL);
+		if (!bm)
+			return -ENOMEM;
+
+		global_bm[i] = bm;
+
+		bm->scan_bm_4K.bitmap_size =
+				(initsize >> (PAGE_SHIFT + 0x3));
+		bm->scan_bm_2M.bitmap_size =
+				(initsize >> (PAGE_SHIFT_2M + 0x3));
+		bm->scan_bm_1G.bitmap_size =
+				(initsize >> (PAGE_SHIFT_1G + 0x3));
+
+		/* Alloc memory to hold the block alloc bitmap */
+		bm->scan_bm_4K.bitmap = kzalloc(bm->scan_bm_4K.bitmap_size,
+							GFP_KERNEL);
+		bm->scan_bm_2M.bitmap = kzalloc(bm->scan_bm_2M.bitmap_size,
+							GFP_KERNEL);
+		bm->scan_bm_1G.bitmap = kzalloc(bm->scan_bm_1G.bitmap_size,
+							GFP_KERNEL);
+
+		if (!bm->scan_bm_4K.bitmap || !bm->scan_bm_2M.bitmap ||
+				!bm->scan_bm_1G.bitmap)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+
 /*********************** Recovery entrance *************************/
 
 /* Return TRUE if we can do a normal unmount recovery */
diff --git a/fs/nova/bbuild.h b/fs/nova/bbuild.h
index 2c3deb0..b093e05 100644
--- a/fs/nova/bbuild.h
+++ b/fs/nova/bbuild.h
@@ -1,6 +1,24 @@
 #ifndef __BBUILD_H
 #define __BBUILD_H
 
+enum bm_type {
+	BM_4K = 0,
+	BM_2M,
+	BM_1G,
+};
+
+struct single_scan_bm {
+	unsigned long bitmap_size;
+	unsigned long *bitmap;
+};
+
+struct scan_bitmap {
+	struct single_scan_bm scan_bm_4K;
+	struct single_scan_bm scan_bm_2M;
+	struct single_scan_bm scan_bm_1G;
+};
+
+
 void nova_init_header(struct super_block *sb,
 	struct nova_inode_info_header *sih, u16 i_mode);
 void nova_save_inode_list_to_log(struct super_block *sb);
-- 
2.7.4

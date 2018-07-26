Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA5B2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA5B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeGZMKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:10:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729155AbeGZMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:10:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49F2E5B9EFE40;
        Thu, 26 Jul 2018 18:54:22 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.382.0; Thu, 26 Jul 2018 18:54:16 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: relocate f2fs_sanity_check_ckpt() and make it static
Date:   Thu, 26 Jul 2018 18:54:11 +0800
Message-ID: <20180726105411.115343-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 93 +++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h       |  1 -
 fs/f2fs/super.c      | 91 -------------------------------------------
 3 files changed, 92 insertions(+), 93 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index e010fecce097..7d16cb36be47 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -833,6 +833,97 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	return NULL;
 }
 
+static int sanity_check_ckpt(struct f2fs_sb_info *sbi)
+{
+	unsigned int total, fsmeta;
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	unsigned int ovp_segments, reserved_segments;
+	unsigned int main_segs, blocks_per_seg;
+	unsigned int sit_segs, nat_segs;
+	unsigned int sit_bitmap_size, nat_bitmap_size;
+	unsigned int log_blocks_per_seg;
+	unsigned int user_block_count;
+	unsigned int segment_count_main;
+	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
+	int i;
+
+	total = le32_to_cpu(raw_super->segment_count);
+	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
+	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
+	fsmeta += sit_segs;
+	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
+	fsmeta += nat_segs;
+	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
+	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
+
+	if (unlikely(fsmeta >= total))
+		return 1;
+
+	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
+	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
+
+	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
+			ovp_segments == 0 || reserved_segments == 0)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong layout: check mkfs.f2fs version");
+		return 1;
+	}
+
+	user_block_count = le32_to_cpu(ckpt->user_block_count);
+	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
+	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
+	if (!user_block_count || user_block_count >=
+			segment_count_main << log_blocks_per_seg) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong user_block_count: %u", user_block_count);
+		return 1;
+	}
+
+	main_segs = le32_to_cpu(raw_super->segment_count_main);
+	blocks_per_seg = sbi->blocks_per_seg;
+
+	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
+		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
+			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
+			return 1;
+	}
+	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
+		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
+			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
+			return 1;
+	}
+
+	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
+	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
+
+	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
+		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong bitmap size: sit: %u, nat:%u",
+			sit_bitmap_size, nat_bitmap_size);
+		return 1;
+	}
+
+	cp_pack_start_sum = __start_sum_addr(sbi);
+	cp_blkaddr = __start_cp_addr(sbi);
+	cp_payload = __cp_payload(sbi);
+	if (cp_pack_start_sum < cp_payload + 1 ||
+		cp_pack_start_sum > blocks_per_seg - 1 -
+			NR_CURSEG_TYPE) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong cp_pack_start_sum: %u",
+			cp_pack_start_sum);
+		return 1;
+	}
+
+	if (unlikely(f2fs_cp_error(sbi))) {
+		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
+		return 1;
+	}
+	return 0;
+}
+
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp_block;
@@ -883,7 +974,7 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		sbi->cur_cp_pack = 2;
 
 	/* Sanity checking of checkpoint */
-	if (f2fs_sanity_check_ckpt(sbi))
+	if (sanity_check_ckpt(sbi))
 		goto free_fail_no_cp;
 
 	if (cp_blks <= 1)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index adee43288593..fa5d0ebf8998 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2817,7 +2817,6 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
-int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 622acaab46b2..0eb5c9b659f7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2295,97 +2295,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
-{
-	unsigned int total, fsmeta;
-	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	unsigned int ovp_segments, reserved_segments;
-	unsigned int main_segs, blocks_per_seg;
-	unsigned int sit_segs, nat_segs;
-	unsigned int sit_bitmap_size, nat_bitmap_size;
-	unsigned int log_blocks_per_seg;
-	unsigned int user_block_count;
-	unsigned int segment_count_main;
-	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
-	int i;
-
-	total = le32_to_cpu(raw_super->segment_count);
-	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
-	sit_segs = le32_to_cpu(raw_super->segment_count_sit);
-	fsmeta += sit_segs;
-	nat_segs = le32_to_cpu(raw_super->segment_count_nat);
-	fsmeta += nat_segs;
-	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
-	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
-
-	if (unlikely(fsmeta >= total))
-		return 1;
-
-	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
-	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
-
-	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
-			ovp_segments == 0 || reserved_segments == 0)) {
-		f2fs_msg(sbi->sb, KERN_ERR,
-			"Wrong layout: check mkfs.f2fs version");
-		return 1;
-	}
-
-	user_block_count = le32_to_cpu(ckpt->user_block_count);
-	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
-	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
-	if (!user_block_count || user_block_count >=
-			segment_count_main << log_blocks_per_seg) {
-		f2fs_msg(sbi->sb, KERN_ERR,
-			"Wrong user_block_count: %u", user_block_count);
-		return 1;
-	}
-
-	main_segs = le32_to_cpu(raw_super->segment_count_main);
-	blocks_per_seg = sbi->blocks_per_seg;
-
-	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
-		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
-			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
-			return 1;
-	}
-	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
-		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
-			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
-			return 1;
-	}
-
-	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
-	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
-
-	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
-		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
-		f2fs_msg(sbi->sb, KERN_ERR,
-			"Wrong bitmap size: sit: %u, nat:%u",
-			sit_bitmap_size, nat_bitmap_size);
-		return 1;
-	}
-
-	cp_pack_start_sum = __start_sum_addr(sbi);
-	cp_blkaddr = __start_cp_addr(sbi);
-	cp_payload = __cp_payload(sbi);
-	if (cp_pack_start_sum < cp_payload + 1 ||
-		cp_pack_start_sum > blocks_per_seg - 1 -
-			NR_CURSEG_TYPE) {
-		f2fs_msg(sbi->sb, KERN_ERR,
-			"Wrong cp_pack_start_sum: %u",
-			cp_pack_start_sum);
-		return 1;
-	}
-
-	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
-		return 1;
-	}
-	return 0;
-}
-
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
-- 
2.18.0.rc1


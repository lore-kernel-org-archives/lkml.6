Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE00C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205BB21486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205BB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeHWMCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:02:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbeHWMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:02:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9059C8B1;
        Thu, 23 Aug 2018 08:33:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 202/217] f2fs: return error during fill_super
Date:   Thu, 23 Aug 2018 09:55:15 +0200
Message-Id: <20180823075514.745785998@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit c39a1b348c4fe172729eff77c533dabc3c7cdaa7 upstream.

Let's avoid BUG_ON during fill_super, when on-disk was totall corrupted.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |   16 ++++++++++++----
 fs/f2fs/segment.h |   22 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3240,7 +3240,7 @@ static int build_curseg(struct f2fs_sb_i
 	return restore_curseg_summaries(sbi);
 }
 
-static void build_sit_entries(struct f2fs_sb_info *sbi)
+static int build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
@@ -3250,6 +3250,7 @@ static void build_sit_entries(struct f2f
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
+	int err = 0;
 
 	do {
 		readed = ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
@@ -3268,7 +3269,9 @@ static void build_sit_entries(struct f2f
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
 
-			check_block_count(sbi, start, &sit);
+			err = check_block_count(sbi, start, &sit);
+			if (err)
+				return err;
 			seg_info_from_raw_sit(se, &sit);
 
 			/* build discard map only one time */
@@ -3303,7 +3306,9 @@ static void build_sit_entries(struct f2f
 
 		old_valid_blocks = se->valid_blocks;
 
-		check_block_count(sbi, start, &sit);
+		err = check_block_count(sbi, start, &sit);
+		if (err)
+			break;
 		seg_info_from_raw_sit(se, &sit);
 
 		if (f2fs_discard_en(sbi)) {
@@ -3323,6 +3328,7 @@ static void build_sit_entries(struct f2f
 				se->valid_blocks - old_valid_blocks;
 	}
 	up_read(&curseg->journal_rwsem);
+	return err;
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)
@@ -3492,7 +3498,9 @@ int build_segment_manager(struct f2fs_sb
 		return err;
 
 	/* reinit free segmap based on SIT */
-	build_sit_entries(sbi);
+	err = build_sit_entries(sbi);
+	if (err)
+		return err;
 
 	init_free_segmap(sbi);
 	err = build_dirty_segmap(sbi);
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -625,7 +625,7 @@ static inline void verify_block_addr(str
 /*
  * Summary block is always treated as an invalid block
  */
-static inline void check_block_count(struct f2fs_sb_info *sbi,
+static inline int check_block_count(struct f2fs_sb_info *sbi,
 		int segno, struct f2fs_sit_entry *raw_sit)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -647,11 +647,25 @@ static inline void check_block_count(str
 		cur_pos = next_pos;
 		is_valid = !is_valid;
 	} while (cur_pos < sbi->blocks_per_seg);
-	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);
+
+	if (unlikely(GET_SIT_VBLOCKS(raw_sit) != valid_blocks)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"Mismatch valid blocks %d vs. %d",
+					GET_SIT_VBLOCKS(raw_sit), valid_blocks);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EINVAL;
+	}
 #endif
 	/* check segment usage, and check boundary of a given segment number */
-	f2fs_bug_on(sbi, GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
-					|| segno > TOTAL_SEGS(sbi) - 1);
+	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
+					|| segno > TOTAL_SEGS(sbi) - 1)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"Wrong valid blocks %d or segno %u",
+					GET_SIT_VBLOCKS(raw_sit), segno);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,



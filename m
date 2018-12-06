Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4239C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DBE20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107822;
	bh=6PK/xrCNPwPoqh9EIF5yrbVeT5lNIC1f4xJfZgqsEmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQ3qGmgrso8hDnQeo7f06IHaIoHS/43Cz+3mkLfzanVE25ZwkGIB1hfrJjm0/+zZt
	 WcUvFVFRANcckOR3vIrm122ZobSV+Zw4165nK7wdFsqVJehK3k9OcnezPOFBrqbUrA
	 dmdLw9P4++q5FBixd0TArjYeociQdFf/HFvwG8wQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DBE20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeLFOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbeLFOr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35722082B;
        Thu,  6 Dec 2018 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107647;
        bh=6PK/xrCNPwPoqh9EIF5yrbVeT5lNIC1f4xJfZgqsEmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NT3w1WAJs4VhPCtSjXO3TwXvrG2iDvWe01T8UkUi78ycBda3VKhUFQdHFGu4i6SdL
         IJW9dnA8V6q5Mo5Zpwx/FHmT4SitmXpCn7dprw/MR/JDW4vpCb63dLdAP0UCgSYI0K
         hEKbwkBPfq/ZBm24DPowfi0OBxGRtxFM9NdY4QVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 086/101] f2fs: return error during fill_super
Date:   Thu,  6 Dec 2018 15:39:25 +0100
Message-Id: <20181206143017.666919759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit c39a1b348c4fe172729eff77c533dabc3c7cdaa7 upstream.

Let's avoid BUG_ON during fill_super, when on-disk was totall corrupted.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |   16 ++++++++++++----
 fs/f2fs/segment.h |   22 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2322,7 +2322,7 @@ static int build_curseg(struct f2fs_sb_i
 	return restore_curseg_summaries(sbi);
 }
 
-static void build_sit_entries(struct f2fs_sb_info *sbi)
+static int build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
@@ -2333,6 +2333,7 @@ static void build_sit_entries(struct f2f
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
 	int nrpages = MAX_BIO_BLOCKS(sbi) * 8;
+	int err = 0;
 
 	do {
 		readed = ra_meta_pages(sbi, start_blk, nrpages, META_SIT, true);
@@ -2350,7 +2351,9 @@ static void build_sit_entries(struct f2f
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
 
-			check_block_count(sbi, start, &sit);
+			err = check_block_count(sbi, start, &sit);
+			if (err)
+				return err;
 			seg_info_from_raw_sit(se, &sit);
 
 			/* build discard map only one time */
@@ -2378,7 +2381,9 @@ static void build_sit_entries(struct f2f
 
 		old_valid_blocks = se->valid_blocks;
 
-		check_block_count(sbi, start, &sit);
+		err = check_block_count(sbi, start, &sit);
+		if (err)
+			break;
 		seg_info_from_raw_sit(se, &sit);
 
 		if (f2fs_discard_en(sbi)) {
@@ -2393,6 +2398,7 @@ static void build_sit_entries(struct f2f
 				se->valid_blocks - old_valid_blocks;
 	}
 	up_read(&curseg->journal_rwsem);
+	return err;
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)
@@ -2559,7 +2565,9 @@ int build_segment_manager(struct f2fs_sb
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
@@ -600,7 +600,7 @@ static inline void verify_block_addr(str
 /*
  * Summary block is always treated as an invalid block
  */
-static inline void check_block_count(struct f2fs_sb_info *sbi,
+static inline int check_block_count(struct f2fs_sb_info *sbi,
 		int segno, struct f2fs_sit_entry *raw_sit)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -622,11 +622,25 @@ static inline void check_block_count(str
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



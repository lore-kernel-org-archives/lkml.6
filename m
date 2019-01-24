Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBCFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595BF21900
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357864;
	bh=PotRsZniAXVx3B/5LYo/B768hRF4hwCEEQqXCh+LqB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGIMxp6HWmLLwhWCT+x9NMnuUZyKyQRkSUp0J/ADEqhyMXM9Eaoo1GqPaozfhNleh
	 7JbQZGYjp0I/b5PIW+4HUeV5gwVeo11fslTEhyVSny73de5Aj2muER1GXiB7zllItq
	 JwUrYaT6QcvFw7K3hl+4H/gY+V3q4la67XJCKbZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfAXTYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbfAXTYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29357218D2;
        Thu, 24 Jan 2019 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357859;
        bh=PotRsZniAXVx3B/5LYo/B768hRF4hwCEEQqXCh+LqB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bt+jeR9J66eYruEEr5KxeKKNm6RDEWzwyNiOpa8CTndiXzNWjp/AmuKC/8iBZx0qn
         QT0F7+Q8zUgS5eQpQ1Xr2X5+aIc+eNkzHImJVnghcP1u40c02Ld8N3Dv4ZKcphel2e
         mDmi//6p+wlq8FKbTlNWwKlXSJE65rit4QSsvveY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 014/104] f2fs: use crc and cp version to determine roll-forward recovery
Date:   Thu, 24 Jan 2019 20:19:03 +0100
Message-Id: <20190124190156.414555113@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit a468f0ef516fda9c7d91bb550d458e853d76955e upstream.

Previously, we used cp_version only to detect recoverable dnodes.
In order to avoid same garbage cp_version, we needed to truncate the next
dnode during checkpoint, resulting in additional discard or data write.
If we can distinguish this by using crc in addition to cp_version, we can
remove this overhead.

There is backward compatibility concern where it changes node_footer layout.
So, this patch introduces a new checkpoint flag, CP_CRC_RECOVERY_FLAG, to
detect new layout. New layout will be activated only when this flag is set.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c    |   21 +------------
 fs/f2fs/f2fs.h          |    1 
 fs/f2fs/node.h          |   77 ++++++++++++++++++++++++++++++------------------
 fs/f2fs/recovery.c      |   30 +++---------------
 fs/f2fs/segment.c       |   22 -------------
 fs/f2fs/super.c         |    5 ++-
 include/linux/f2fs_fs.h |    1 
 7 files changed, 63 insertions(+), 94 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -902,7 +902,6 @@ static void wait_on_all_pages_writeback(
 static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
 	nid_t last_nid = nm_i->next_scan_nid;
@@ -911,15 +910,6 @@ static void do_checkpoint(struct f2fs_sb
 	__u32 crc32 = 0;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
-	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
-	bool invalidate = false;
-
-	/*
-	 * This avoids to conduct wrong roll-forward operations and uses
-	 * metapages, so should be called prior to sync_meta_pages below.
-	 */
-	if (discard_next_dnode(sbi, discard_blk))
-		invalidate = true;
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
@@ -996,6 +986,9 @@ static void do_checkpoint(struct f2fs_sb
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
+	/* set this flag to activate crc|cp_ver for recovery */
+	set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
+
 	/* update SIT/NAT bitmap */
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
@@ -1053,14 +1046,6 @@ static void do_checkpoint(struct f2fs_sb
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
-	/*
-	 * invalidate meta page which is used temporarily for zeroing out
-	 * block at the end of warm node chain.
-	 */
-	if (invalidate)
-		invalidate_mapping_pages(META_MAPPING(sbi), discard_blk,
-								discard_blk);
-
 	release_dirty_inode(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1780,7 +1780,6 @@ bool is_checkpointed_data(struct f2fs_sb
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
 void release_discard_addrs(struct f2fs_sb_info *);
-bool discard_next_dnode(struct f2fs_sb_info *, block_t);
 int npages_for_summary_flush(struct f2fs_sb_info *, bool);
 void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -212,6 +212,37 @@ static inline void set_to_next_nat(struc
 	f2fs_change_bit(block_off, nm_i->nat_bitmap);
 }
 
+static inline nid_t ino_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.ino);
+}
+
+static inline nid_t nid_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.nid);
+}
+
+static inline unsigned int ofs_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	unsigned flag = le32_to_cpu(rn->footer.flag);
+	return flag >> OFFSET_BIT_SHIFT;
+}
+
+static inline __u64 cpver_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le64_to_cpu(rn->footer.cp_ver);
+}
+
+static inline block_t next_blkaddr_of_node(struct page *node_page)
+{
+	struct f2fs_node *rn = F2FS_NODE(node_page);
+	return le32_to_cpu(rn->footer.next_blkaddr);
+}
+
 static inline void fill_node_footer(struct page *page, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
@@ -242,40 +273,30 @@ static inline void fill_node_footer_blka
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
 	struct f2fs_node *rn = F2FS_NODE(page);
+	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
+	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
 
-	rn->footer.cp_ver = ckpt->checkpoint_ver;
+	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
+		__u64 crc = le32_to_cpu(*((__le32 *)
+				((unsigned char *)ckpt + crc_offset)));
+		cp_ver |= (crc << 32);
+	}
+	rn->footer.cp_ver = cpu_to_le64(cp_ver);
 	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
 }
 
-static inline nid_t ino_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.ino);
-}
-
-static inline nid_t nid_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.nid);
-}
-
-static inline unsigned int ofs_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	unsigned flag = le32_to_cpu(rn->footer.flag);
-	return flag >> OFFSET_BIT_SHIFT;
-}
-
-static inline unsigned long long cpver_of_node(struct page *node_page)
+static inline bool is_recoverable_dnode(struct page *page)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le64_to_cpu(rn->footer.cp_ver);
-}
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
+	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
+	__u64 cp_ver = cur_cp_version(ckpt);
 
-static inline block_t next_blkaddr_of_node(struct page *node_page)
-{
-	struct f2fs_node *rn = F2FS_NODE(node_page);
-	return le32_to_cpu(rn->footer.next_blkaddr);
+	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
+		__u64 crc = le32_to_cpu(*((__le32 *)
+				((unsigned char *)ckpt + crc_offset)));
+		cp_ver |= (crc << 32);
+	}
+	return cpu_to_le64(cp_ver) == cpver_of_node(page);
 }
 
 /*
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -193,7 +193,6 @@ static void recover_inode(struct inode *
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
-	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct inode *inode;
 	struct page *page = NULL;
@@ -214,7 +213,7 @@ static int find_fsync_dnodes(struct f2fs
 
 		page = get_tmp_page(sbi, blkaddr);
 
-		if (cp_ver != cpver_of_node(page))
+		if (!is_recoverable_dnode(page))
 			break;
 
 		if (!is_fsync_dnode(page))
@@ -483,7 +482,6 @@ out:
 static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 						struct list_head *dir_list)
 {
-	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
 	struct page *page = NULL;
 	int err = 0;
@@ -503,7 +501,7 @@ static int recover_data(struct f2fs_sb_i
 
 		page = get_tmp_page(sbi, blkaddr);
 
-		if (cp_ver != cpver_of_node(page)) {
+		if (!is_recoverable_dnode(page)) {
 			f2fs_put_page(page, 1);
 			break;
 		}
@@ -595,31 +593,15 @@ out:
 	}
 
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-	if (err) {
-		bool invalidate = false;
-
-		if (discard_next_dnode(sbi, blkaddr))
-			invalidate = true;
-
-		/* Flush all the NAT/SIT pages */
-		while (get_pages(sbi, F2FS_DIRTY_META))
-			sync_meta_pages(sbi, META, LONG_MAX);
-
-		/* invalidate temporary meta page */
-		if (invalidate)
-			invalidate_mapping_pages(META_MAPPING(sbi),
-							blkaddr, blkaddr);
-
+	if (err)
 		set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
-		mutex_unlock(&sbi->cp_mutex);
-	} else if (need_writecp) {
+	mutex_unlock(&sbi->cp_mutex);
+
+	if (!err && need_writecp) {
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
 		};
-		mutex_unlock(&sbi->cp_mutex);
 		write_checkpoint(sbi, &cpc);
-	} else {
-		mutex_unlock(&sbi->cp_mutex);
 	}
 
 	destroy_fsync_dnodes(&dir_list);
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -519,28 +519,6 @@ static int f2fs_issue_discard(struct f2f
 	return blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
 }
 
-bool discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
-{
-	int err = -ENOTSUPP;
-
-	if (test_opt(sbi, DISCARD)) {
-		struct seg_entry *se = get_seg_entry(sbi,
-				GET_SEGNO(sbi, blkaddr));
-		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
-
-		if (f2fs_test_bit(offset, se->discard_map))
-			return false;
-
-		err = f2fs_issue_discard(sbi, blkaddr, 1);
-	}
-
-	if (err) {
-		update_meta_page(sbi, NULL, blkaddr);
-		return true;
-	}
-	return false;
-}
-
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
 		struct cp_control *cpc, struct seg_entry *se,
 		unsigned int start, unsigned int end)
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1457,6 +1457,9 @@ try_onemore:
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
+		if (!retry)
+			goto skip_recovery;
+
 		err = recover_fsync_data(sbi, false);
 		if (err < 0) {
 			need_fsck = true;
@@ -1474,7 +1477,7 @@ try_onemore:
 			goto free_kobj;
 		}
 	}
-
+skip_recovery:
 	/* recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -99,6 +99,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008



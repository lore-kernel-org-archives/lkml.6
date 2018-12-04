Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FCC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9507F214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrzhrW6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9507F214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeLDLDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeLDLDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F1E214DA;
        Tue,  4 Dec 2018 11:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921379;
        bh=NR0iDfwIxQILiPWOxrlR+C2MvMy4kKUx9+c7S8meiIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrzhrW6cRYlUSoJ2ysqLYz/LOdCujDk8jUv/MuSArPd9KgDQFdBuRmwP/fgMnVi8N
         BAKNpbw8tECjaKHnskOmVuBu/DRFYwxeuU0lGxKj+xdf2lKrcz7aLjZoLwZ6StOYzv
         ty4cozoFmtj2G7KKu6NdEu3fNXNwG8Kxk4FzZ06U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/146] f2fs: introduce and spread verify_blkaddr
Date:   Tue,  4 Dec 2018 11:48:54 +0100
Message-Id: <20181204103728.787395274@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit e1da7872f6eda977bd812346bf588c35e4495a1e upstream.

This patch introduces verify_blkaddr to check meta/data block address
with valid range to detect bug earlier.

In addition, once we encounter an invalid blkaddr, notice user to run
fsck to fix, and let the kernel panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.14: I skipped an earlier renaming of
 is_valid_meta_blkaddr() to f2fs_is_valid_meta_blkaddr()]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 11 +++++++++--
 fs/f2fs/data.c       |  8 ++++----
 fs/f2fs/f2fs.h       | 32 +++++++++++++++++++++++++++++---
 fs/f2fs/file.c       |  9 +++++----
 fs/f2fs/inode.c      |  7 ++++---
 fs/f2fs/node.c       |  4 ++--
 fs/f2fs/recovery.c   |  6 +++---
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    |  8 +++-----
 9 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2b951046657e..d7bd9745e883 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -118,7 +118,8 @@ struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
-bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
@@ -138,10 +139,16 @@ bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 			return false;
 		break;
 	case META_POR:
+	case DATA_GENERIC:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi)))
 			return false;
 		break;
+	case META_GENERIC:
+		if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
+			blkaddr >= MAIN_BLKADDR(sbi)))
+			return false;
+		break;
 	default:
 		BUG();
 	}
@@ -174,7 +181,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!is_valid_meta_blkaddr(sbi, blkno, type))
+		if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f7b2909e9c5f..615878806611 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -413,7 +413,7 @@ next:
 		spin_unlock(&io->io_lock);
 	}
 
-	if (is_valid_blkaddr(fio->old_blkaddr))
+	if (__is_valid_data_blkaddr(fio->old_blkaddr))
 		verify_block_addr(fio, fio->old_blkaddr);
 	verify_block_addr(fio, fio->new_blkaddr);
 
@@ -946,7 +946,7 @@ next_dnode:
 next_block:
 	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
-	if (!is_valid_blkaddr(blkaddr)) {
+	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -1402,7 +1402,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
-		if (is_valid_blkaddr(fio->old_blkaddr)) {
+		if (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr)) {
 			ipu_force = true;
 			fio->need_lock = LOCK_DONE;
 			goto got_it;
@@ -1429,7 +1429,7 @@ got_it:
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (is_valid_blkaddr(fio->old_blkaddr) &&
+	if (ipu_force || (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr) &&
 					need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d74c77b51b71..d15d79457f5c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -162,7 +162,7 @@ struct cp_control {
 };
 
 /*
- * For CP/NAT/SIT/SSA readahead
+ * indicate meta/data type
  */
 enum {
 	META_CP,
@@ -170,6 +170,8 @@ enum {
 	META_SIT,
 	META_SSA,
 	META_POR,
+	DATA_GENERIC,
+	META_GENERIC,
 };
 
 /* for the list of ino */
@@ -2355,13 +2357,36 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_unlock(&sbi->iostat_lock);
 }
 
-static inline bool is_valid_blkaddr(block_t blkaddr)
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type);
+void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
+static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
+{
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"invalid blkaddr: %u, type: %d, run fsck to fix.",
+			blkaddr, type);
+		f2fs_bug_on(sbi, 1);
+	}
+}
+
+static inline bool __is_valid_data_blkaddr(block_t blkaddr)
 {
 	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
 		return false;
 	return true;
 }
 
+static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
+						block_t blkaddr)
+{
+	if (!__is_valid_data_blkaddr(blkaddr))
+		return false;
+	verify_blkaddr(sbi, blkaddr, DATA_GENERIC);
+	return true;
+}
+
 /*
  * file.c
  */
@@ -2572,7 +2597,8 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
 struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
-bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type);
 int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d368eda462bb..e9c575ef70b5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -328,13 +328,13 @@ static pgoff_t __get_first_dirty_index(struct address_space *mapping,
 	return pgofs;
 }
 
-static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
-							int whence)
+static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
+				pgoff_t dirty, pgoff_t pgofs, int whence)
 {
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			is_valid_blkaddr(blkaddr))
+			is_valid_data_blkaddr(sbi, blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
@@ -397,7 +397,8 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 			blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
 
-			if (__found_offset(blkaddr, dirty, pgofs, whence)) {
+			if (__found_offset(F2FS_I_SB(inode), blkaddr, dirty,
+							pgofs, whence)) {
 				f2fs_put_dnode(&dn);
 				goto found;
 			}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2bcbbf566f0c..b1c0eb433841 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -62,11 +62,12 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 	}
 }
 
-static bool __written_first_block(struct f2fs_inode *ri)
+static bool __written_first_block(struct f2fs_sb_info *sbi,
+					struct f2fs_inode *ri)
 {
 	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
 
-	if (is_valid_blkaddr(addr))
+	if (is_valid_data_blkaddr(sbi, addr))
 		return true;
 	return false;
 }
@@ -235,7 +236,7 @@ static int do_read_inode(struct inode *inode)
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
-	if (__written_first_block(ri))
+	if (__written_first_block(sbi, ri))
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	if (!need_inode_block_update(sbi, inode->i_ino))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5f212fb2d62b..999814c8cbea 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -334,7 +334,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, is_valid_blkaddr(nat_get_blkaddr(e)) &&
+	f2fs_bug_on(sbi, is_valid_data_blkaddr(sbi, nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -349,7 +349,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (!is_valid_blkaddr(new_blkaddr))
+	if (!is_valid_data_blkaddr(sbi, new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 53f41ad4cbe1..6ea445377767 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -236,7 +236,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
@@ -479,7 +479,7 @@ retry_dn:
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_meta_blkaddr(sbi, dest, META_POR)) {
+		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -540,7 +540,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		ra_meta_pages_cond(sbi, blkaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 483d7a869679..5c698757e116 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1758,7 +1758,7 @@ bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (!is_valid_blkaddr(blkaddr))
+	if (!is_valid_data_blkaddr(sbi, blkaddr))
 		return true;
 
 	mutex_lock(&sit_i->sentry_lock);
@@ -2571,7 +2571,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct page *cpage;
 
-	if (!is_valid_blkaddr(blkaddr))
+	if (!is_valid_data_blkaddr(sbi, blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f977774338c3..dd8f977fc273 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -85,7 +85,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((!is_valid_blkaddr(blk_addr)) ?			\
+	((!is_valid_data_blkaddr(sbi, blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
@@ -631,11 +631,9 @@ static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
 
 	if (PAGE_TYPE_OF_BIO(fio->type) == META &&
 				(!is_read_io(fio->op) || fio->is_meta))
-		BUG_ON(blk_addr < SEG0_BLKADDR(sbi) ||
-				blk_addr >= MAIN_BLKADDR(sbi));
+		verify_blkaddr(sbi, blk_addr, META_GENERIC);
 	else
-		BUG_ON(blk_addr < MAIN_BLKADDR(sbi) ||
-				blk_addr >= MAX_BLKADDR(sbi));
+		verify_blkaddr(sbi, blk_addr, DATA_GENERIC);
 }
 
 /*
-- 
2.17.1




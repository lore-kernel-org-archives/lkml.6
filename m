Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34974C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97B5214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCpn7L2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97B5214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeLDLDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbeLDLC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726A02087F;
        Tue,  4 Dec 2018 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921377;
        bh=p5SlJ7SMQaTCLgmgvX17dSo+1PZpaPK+wF6G8i7VpcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCpn7L2LnkOkEqlHRzN4OCPYYs56YXTjsO9tidlUT+Snu+Ubx/mrlqysyFZjkSWHg
         5X9esXY4EFqVSGbkxnFRDS8Df4lo0d73TOAeO1D/Lb0NO1NerJ8bknhfsMvT2xFmny
         Wv1XdWFt73hAyr7SoL3AmzDEkyNWf1Yx4noIxZ4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 047/146] f2fs: clean up with is_valid_blkaddr()
Date:   Tue,  4 Dec 2018 11:48:53 +0100
Message-Id: <20181204103728.750030350@linuxfoundation.org>
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

commit 7b525dd01365c6764018e374d391c92466be1b7a upstream.

- rename is_valid_blkaddr() to is_valid_meta_blkaddr() for readability.
- introduce is_valid_blkaddr() for cleanup.

No logic change in this patch.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 18 +++++-------------
 fs/f2fs/f2fs.h       |  9 ++++++++-
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  5 ++---
 fs/f2fs/recovery.c   |  6 +++---
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    |  2 +-
 9 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1bd4cd8c79c6..2b951046657e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -118,7 +118,7 @@ struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
-bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
@@ -174,7 +174,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!is_valid_blkaddr(sbi, blkno, type))
+		if (!is_valid_meta_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5913de3f661d..f7b2909e9c5f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -413,7 +413,7 @@ next:
 		spin_unlock(&io->io_lock);
 	}
 
-	if (fio->old_blkaddr != NEW_ADDR)
+	if (is_valid_blkaddr(fio->old_blkaddr))
 		verify_block_addr(fio, fio->old_blkaddr);
 	verify_block_addr(fio, fio->new_blkaddr);
 
@@ -946,7 +946,7 @@ next_dnode:
 next_block:
 	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
+	if (!is_valid_blkaddr(blkaddr)) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -1388,15 +1388,6 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 	return need_inplace_update_policy(inode, fio);
 }
 
-static inline bool valid_ipu_blkaddr(struct f2fs_io_info *fio)
-{
-	if (fio->old_blkaddr == NEW_ADDR)
-		return false;
-	if (fio->old_blkaddr == NULL_ADDR)
-		return false;
-	return true;
-}
-
 int do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
@@ -1411,7 +1402,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
-		if (valid_ipu_blkaddr(fio)) {
+		if (is_valid_blkaddr(fio->old_blkaddr)) {
 			ipu_force = true;
 			fio->need_lock = LOCK_DONE;
 			goto got_it;
@@ -1438,7 +1429,8 @@ got_it:
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (valid_ipu_blkaddr(fio) && need_inplace_update(fio))) {
+	if (ipu_force || (is_valid_blkaddr(fio->old_blkaddr) &&
+					need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
 			goto out_writepage;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aa7b033af1b0..d74c77b51b71 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2355,6 +2355,13 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_unlock(&sbi->iostat_lock);
 }
 
+static inline bool is_valid_blkaddr(block_t blkaddr)
+{
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+		return false;
+	return true;
+}
+
 /*
  * file.c
  */
@@ -2565,7 +2572,7 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
 struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
-bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
 int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6f589730782d..d368eda462bb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -334,7 +334,7 @@ static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			(blkaddr != NEW_ADDR && blkaddr != NULL_ADDR))
+			is_valid_blkaddr(blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 259b0aa283f0..2bcbbf566f0c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -66,7 +66,7 @@ static bool __written_first_block(struct f2fs_inode *ri)
 {
 	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
 
-	if (addr != NEW_ADDR && addr != NULL_ADDR)
+	if (is_valid_blkaddr(addr))
 		return true;
 	return false;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 712505ec5de4..5f212fb2d62b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -334,8 +334,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, nat_get_blkaddr(e) != NEW_ADDR &&
-			nat_get_blkaddr(e) != NULL_ADDR &&
+	f2fs_bug_on(sbi, is_valid_blkaddr(nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -350,7 +349,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 765fadf954af..53f41ad4cbe1 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -236,7 +236,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
@@ -479,7 +479,7 @@ retry_dn:
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_blkaddr(sbi, dest, META_POR)) {
+		if (is_valid_meta_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -540,7 +540,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		ra_meta_pages_cond(sbi, blkaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1104a6c80251..483d7a869679 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1758,7 +1758,7 @@ bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return true;
 
 	mutex_lock(&sit_i->sentry_lock);
@@ -2571,7 +2571,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct page *cpage;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 4b635e8c91b0..f977774338c3 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -85,7 +85,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((((blk_addr) == NULL_ADDR) || ((blk_addr) == NEW_ADDR)) ?	\
+	((!is_valid_blkaddr(blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
-- 
2.17.1




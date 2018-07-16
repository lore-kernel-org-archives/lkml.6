Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C569ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B35320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1NWhuavd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B35320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeGPQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeGPQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:30:55 -0400
Received: from localhost.localdomain (unknown [222.94.210.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06CF9208FA;
        Mon, 16 Jul 2018 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531756970;
        bh=urBghobGcIcwItlHyFquz35OjxLOg7iVwePaVw0jhYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=1NWhuavdiL8Iax3wd0Qrm/0aEacKnWOQuj2X7uEGVBWv5HP4aSEx45qHOdhqqo4wP
         yx8LWMQsiVsJuJo2eZH4luHnhrVJD9PVB2iFIupjGq3yw+LdIicUGDgDN0tVVdeNlo
         DPEEMjmMNW+jV7yBU5nN3pnE8fexbF14vL2BN2u0=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 5/5] f2fs: fix to propagate error from __get_meta_page()
Date:   Tue, 17 Jul 2018 00:02:17 +0800
Message-Id: <20180716160217.3681-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If caller of __get_meta_page() can handle error, let's propagate error
from __get_meta_page().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- propagate error to f2fs_get_node_info()
- introduce f2fs_get_meta_page_nofail()
 fs/f2fs/checkpoint.c | 55 ++++++++++++++++++++++++--------
 fs/f2fs/data.c       | 24 ++++++++++++--
 fs/f2fs/f2fs.h       |  8 +++--
 fs/f2fs/file.c       |  7 +++-
 fs/f2fs/gc.c         | 16 ++++++++--
 fs/f2fs/inline.c     | 14 +++++++-
 fs/f2fs/inode.c      | 12 +++++--
 fs/f2fs/node.c       | 90 +++++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/recovery.c   | 13 +++++++-
 fs/f2fs/segment.c    | 37 +++++++++++++++------
 10 files changed, 220 insertions(+), 56 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 09446ac38f5c..e1c0fef4ba9a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -71,6 +71,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.encrypted_page = NULL,
 		.is_meta = is_meta,
 	};
+	int err;
 
 	if (unlikely(!is_meta))
 		fio.op_flags &= ~REQ_META;
@@ -85,11 +86,10 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 
 	fio.page = page;
 
-	if (f2fs_submit_page_bio(&fio)) {
-		memset(page_address(page), 0, PAGE_SIZE);
-		f2fs_stop_checkpoint(sbi, false);
-		f2fs_bug_on(sbi, 1);
-		return page;
+	err = f2fs_submit_page_bio(&fio);
+	if (err) {
+		f2fs_put_page(page, 1);
+		return ERR_PTR(err);
 	}
 
 	lock_page(page);
@@ -98,14 +98,9 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		goto repeat;
 	}
 
-	/*
-	 * if there is any IO error when accessing device, make our filesystem
-	 * readonly and make sure do not write checkpoint with non-uptodate
-	 * meta page.
-	 */
 	if (unlikely(!PageUptodate(page))) {
-		memset(page_address(page), 0, PAGE_SIZE);
-		f2fs_stop_checkpoint(sbi, false);
+		f2fs_put_page(page, 1);
+		return ERR_PTR(-EIO);
 	}
 out:
 	return page;
@@ -116,6 +111,25 @@ struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, true);
 }
 
+struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
+{
+	struct page *page;
+	int count = 0;
+
+retry:
+	page = __get_meta_page(sbi, index, true);
+	if (IS_ERR(page)) {
+		if (PTR_ERR(page) == -EIO &&
+				++count <= DEFAULT_RETRY_IO_COUNT)
+			goto retry;
+
+		f2fs_stop_checkpoint(sbi, false);
+		f2fs_bug_on(sbi, 1);
+	}
+
+	return page;
+}
+
 /* for POR only */
 struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
@@ -607,7 +621,9 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	/* truncate all the data during iput */
 	iput(inode);
 
-	f2fs_get_node_info(sbi, ino, &ni);
+	err = f2fs_get_node_info(sbi, ino, &ni);
+	if (err)
+		goto err_out;
 
 	/* ENOMEM was fully retried in f2fs_evict_inode. */
 	if (ni.blk_addr != NULL_ADDR) {
@@ -655,9 +671,15 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	f2fs_ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP, true);
 
 	for (i = 0; i < orphan_blocks; i++) {
-		struct page *page = f2fs_get_meta_page(sbi, start_blk + i);
+		struct page *page;
 		struct f2fs_orphan_block *orphan_blk;
 
+		page = f2fs_get_meta_page(sbi, start_blk + i);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			goto out;
+		}
+
 		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
 		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
@@ -748,6 +770,9 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	__u32 crc = 0;
 
 	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
+	if (IS_ERR(*cp_page))
+		return PTR_ERR(*cp_page);
+
 	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
@@ -873,6 +898,8 @@ int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		unsigned char *ckpt = (unsigned char *)sbi->ckpt;
 
 		cur_page = f2fs_get_meta_page(sbi, cp_blk_no + i);
+		if (IS_ERR(cur_page))
+			goto free_fail_no_cp;
 		sit_bitmap_ptr = page_address(cur_page);
 		memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
 		f2fs_put_page(cur_page, 1);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a1b55d8d31d5..572c91e43337 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -884,6 +884,10 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
 
+	err = f2fs_get_node_info(sbi, dn->nid, &ni);
+	if (err)
+		return err;
+
 	dn->data_blkaddr = datablock_addr(dn->inode,
 				dn->node_page, dn->ofs_in_node);
 	if (dn->data_blkaddr == NEW_ADDR)
@@ -893,7 +897,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		return err;
 
 alloc:
-	f2fs_get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
 	f2fs_allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
@@ -1296,7 +1299,11 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!page)
 			return -ENOMEM;
 
-		f2fs_get_node_info(sbi, inode->i_ino, &ni);
+		err = f2fs_get_node_info(sbi, inode->i_ino, &ni);
+		if (err) {
+			f2fs_put_page(page, 1);
+			return err;
+		}
 
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
@@ -1323,7 +1330,11 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!page)
 			return -ENOMEM;
 
-		f2fs_get_node_info(sbi, xnid, &ni);
+		err = f2fs_get_node_info(sbi, xnid, &ni);
+		if (err) {
+			f2fs_put_page(page, 1);
+			return err;
+		}
 
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
@@ -1710,6 +1721,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct inode *inode = page->mapping->host;
 	struct dnode_of_data dn;
 	struct extent_info ei = {0,0,0};
+	struct node_info ni;
 	bool ipu_force = false;
 	int err = 0;
 
@@ -1778,6 +1790,12 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		fio->need_lock = LOCK_REQ;
 	}
 
+	err = f2fs_get_node_info(fio->sbi, dn.nid, &ni);
+	if (err)
+		goto out_writepage;
+
+	fio->version = ni.version;
+
 	err = encrypt_one_page(fio);
 	if (err)
 		goto out_writepage;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9f8c600442f0..806006ed0d0a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -518,6 +518,8 @@ enum {
 					 */
 };
 
+#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
+
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
@@ -1024,6 +1026,7 @@ struct f2fs_io_info {
 	bool retry;		/* need to reallocate block address */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
+	unsigned char version;		/* version of the node */
 };
 
 #define is_read_io(rw) ((rw) == READ)
@@ -2837,7 +2840,7 @@ void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
 int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
-void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
+int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 						struct node_info *ni);
 pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
 int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
@@ -2866,7 +2869,7 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_recover_inline_xattr(struct inode *inode, struct page *page);
 int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
-void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
+int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
 void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
@@ -2944,6 +2947,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
+struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2e433958da69..d55fa25fc2f1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1059,7 +1059,12 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			if (ret)
 				return ret;
 
-			f2fs_get_node_info(sbi, dn.nid, &ni);
+			ret = f2fs_get_node_info(sbi, dn.nid, &ni);
+			if (ret) {
+				f2fs_put_dnode(&dn);
+				return ret;
+			}
+
 			ilen = min((pgoff_t)
 				ADDRS_PER_PAGE(dn.node_page, dst_inode) -
 						dn.ofs_in_node, len - i);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2ba470df419b..fe0da3e05ef1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -517,7 +517,11 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 			continue;
 		}
 
-		f2fs_get_node_info(sbi, nid, &ni);
+		if (f2fs_get_node_info(sbi, nid, &ni)) {
+			f2fs_put_page(node_page, 1);
+			continue;
+		}
+
 		if (ni.blk_addr != start_addr + off) {
 			f2fs_put_page(node_page, 1);
 			continue;
@@ -576,7 +580,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	if (IS_ERR(node_page))
 		return false;
 
-	f2fs_get_node_info(sbi, nid, dni);
+	if (f2fs_get_node_info(sbi, nid, dni)) {
+		f2fs_put_page(node_page, 1);
+		return false;
+	}
 
 	if (sum->version != dni->version) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
@@ -654,7 +661,10 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
-	f2fs_get_node_info(fio.sbi, dn.nid, &ni);
+	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
+	if (err)
+		goto put_out;
+
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
 	/* read page */
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 2bcb2d36f024..115dc219344b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -121,6 +121,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		.encrypted_page = NULL,
 		.io_type = FS_DATA_IO,
 	};
+	struct node_info ni;
 	int dirty, err;
 
 	if (!f2fs_exist_data(dn->inode))
@@ -130,6 +131,14 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	if (err)
 		return err;
 
+	err = f2fs_get_node_info(fio.sbi, dn->nid, &ni);
+	if (err) {
+		f2fs_put_dnode(dn);
+		return err;
+	}
+
+	fio.version = ni.version;
+
 	if (unlikely(dn->data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(dn);
 		set_sbi_flag(fio.sbi, SBI_NEED_FSCK);
@@ -690,7 +699,10 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 		ilen = start + len;
 	ilen -= start;
 
-	f2fs_get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
+	err = f2fs_get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
+	if (err)
+		goto out;
+
 	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 50a9e279dfed..f0fcfed817b5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -727,6 +727,7 @@ void f2fs_handle_failed_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct node_info ni;
+	int err;
 
 	/*
 	 * clear nlink of inode in order to release resource of inode
@@ -749,10 +750,16 @@ void f2fs_handle_failed_inode(struct inode *inode)
 	 * so we can prevent losing this orphan when encoutering checkpoint
 	 * and following suddenly power-off.
 	 */
-	f2fs_get_node_info(sbi, inode->i_ino, &ni);
+	err = f2fs_get_node_info(sbi, inode->i_ino, &ni);
+	if (err) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"May loss orphan inode, run fsck to fix.");
+		goto out;
+	}
 
 	if (ni.blk_addr != NULL_ADDR) {
-		int err = f2fs_acquire_orphan_inode(sbi);
+		err = f2fs_acquire_orphan_inode(sbi);
 		if (err) {
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_msg(sbi->sb, KERN_WARNING,
@@ -765,6 +772,7 @@ void f2fs_handle_failed_inode(struct inode *inode)
 		set_inode_flag(inode, FI_FREE_NID);
 	}
 
+out:
 	f2fs_unlock_op(sbi);
 
 	/* iput will drop the inode object */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a794125058c9..99dc1a1d02e3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -114,7 +114,7 @@ static void clear_node_page_dirty(struct page *page)
 static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	pgoff_t index = current_nat_addr(sbi, nid);
-	return f2fs_get_meta_page(sbi, index);
+	return f2fs_get_meta_page_nofail(sbi, index);
 }
 
 static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
@@ -486,7 +486,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 /*
  * This function always returns success
  */
-void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
+int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 						struct node_info *ni)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -510,7 +510,7 @@ void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 		ni->blk_addr = nat_get_blkaddr(e);
 		ni->version = nat_get_version(e);
 		up_read(&nm_i->nat_tree_lock);
-		return;
+		return 0;
 	}
 
 	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
@@ -533,6 +533,9 @@ void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	up_read(&nm_i->nat_tree_lock);
 
 	page = f2fs_get_meta_page(sbi, index);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
 	nat_blk = (struct f2fs_nat_block *)page_address(page);
 	ne = nat_blk->entries[nid - start_nid];
 	node_info_from_raw_nat(ni, &ne);
@@ -540,6 +543,7 @@ void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 cache:
 	/* cache nat entry */
 	cache_nat_entry(sbi, nid, &ne);
+	return 0;
 }
 
 /*
@@ -789,12 +793,15 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	return err;
 }
 
-static void truncate_node(struct dnode_of_data *dn)
+static int truncate_node(struct dnode_of_data *dn)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
+	int err;
 
-	f2fs_get_node_info(sbi, dn->nid, &ni);
+	err = f2fs_get_node_info(sbi, dn->nid, &ni);
+	if (err)
+		return err;
 
 	/* Deallocate node address */
 	f2fs_invalidate_blocks(sbi, ni.blk_addr);
@@ -817,11 +824,14 @@ static void truncate_node(struct dnode_of_data *dn)
 
 	dn->node_page = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);
+
+	return 0;
 }
 
 static int truncate_dnode(struct dnode_of_data *dn)
 {
 	struct page *page;
+	int err;
 
 	if (dn->nid == 0)
 		return 1;
@@ -837,7 +847,10 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	dn->node_page = page;
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks(dn);
-	truncate_node(dn);
+	err = truncate_node(dn);
+	if (err)
+		return err;
+
 	return 1;
 }
 
@@ -902,7 +915,9 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 	if (!ofs) {
 		/* remove current indirect node */
 		dn->node_page = page;
-		truncate_node(dn);
+		ret = truncate_node(dn);
+		if (ret)
+			goto out_err;
 		freed++;
 	} else {
 		f2fs_put_page(page, 1);
@@ -960,7 +975,9 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	if (offset[idx + 1] == 0) {
 		dn->node_page = pages[idx];
 		dn->nid = nid[idx];
-		truncate_node(dn);
+		err = truncate_node(dn);
+		if (err)
+			goto fail;
 	} else {
 		f2fs_put_page(pages[idx], 1);
 	}
@@ -1081,6 +1098,7 @@ int f2fs_truncate_xattr_node(struct inode *inode)
 	nid_t nid = F2FS_I(inode)->i_xattr_nid;
 	struct dnode_of_data dn;
 	struct page *npage;
+	int err;
 
 	if (!nid)
 		return 0;
@@ -1089,10 +1107,15 @@ int f2fs_truncate_xattr_node(struct inode *inode)
 	if (IS_ERR(npage))
 		return PTR_ERR(npage);
 
+	set_new_dnode(&dn, inode, NULL, npage, nid);
+	err = truncate_node(&dn);
+	if (err) {
+		f2fs_put_page(npage, 1);
+		return err;
+	}
+
 	f2fs_i_xnid_write(inode, 0);
 
-	set_new_dnode(&dn, inode, NULL, npage, nid);
-	truncate_node(&dn);
 	return 0;
 }
 
@@ -1126,7 +1149,11 @@ int f2fs_remove_inode_page(struct inode *inode)
 			inode->i_blocks != 0 && inode->i_blocks != 8);
 
 	/* will put inode & node pages */
-	truncate_node(&dn);
+	err = truncate_node(&dn);
+	if (err) {
+		f2fs_put_dnode(&dn);
+		return err;
+	}
 	return 0;
 }
 
@@ -1159,7 +1186,11 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		goto fail;
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	f2fs_get_node_info(sbi, dn->nid, &new_ni);
+	err = f2fs_get_node_info(sbi, dn->nid, &new_ni);
+	if (err) {
+		dec_valid_node_count(sbi, dn->inode, !ofs);
+		goto fail;
+	}
 	f2fs_bug_on(sbi, new_ni.blk_addr != NULL_ADDR);
 #endif
 	new_ni.nid = dn->nid;
@@ -1207,6 +1238,7 @@ static int read_node_page(struct page *page, int op_flags)
 		.page = page,
 		.encrypted_page = NULL,
 	};
+	int err;
 
 	if (PageUptodate(page)) {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -1215,7 +1247,9 @@ static int read_node_page(struct page *page, int op_flags)
 		return LOCKED_PAGE;
 	}
 
-	f2fs_get_node_info(sbi, page->index, &ni);
+	err = f2fs_get_node_info(sbi, page->index, &ni);
+	if (err)
+		return err;
 
 	if (unlikely(ni.blk_addr == NULL_ADDR) ||
 			is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
@@ -1455,6 +1489,9 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
 
+	if (f2fs_get_node_info(sbi, nid, &ni))
+		goto redirty_out;
+
 	if (wbc->for_reclaim) {
 		if (!down_read_trylock(&sbi->node_write))
 			goto redirty_out;
@@ -1462,8 +1499,6 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		down_read(&sbi->node_write);
 	}
 
-	f2fs_get_node_info(sbi, nid, &ni);
-
 	/* This page is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
 		ClearPageUptodate(page);
@@ -2401,12 +2436,16 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
 	struct dnode_of_data dn;
 	struct node_info ni;
 	struct page *xpage;
+	int err;
 
 	if (!prev_xnid)
 		goto recover_xnid;
 
 	/* 1: invalidate the previous xattr nid */
-	f2fs_get_node_info(sbi, prev_xnid, &ni);
+	err = f2fs_get_node_info(sbi, prev_xnid, &ni);
+	if (err)
+		return err;
+
 	f2fs_invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, inode, false);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
@@ -2441,8 +2480,11 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	nid_t ino = ino_of_node(page);
 	struct node_info old_ni, new_ni;
 	struct page *ipage;
+	int err;
 
-	f2fs_get_node_info(sbi, ino, &old_ni);
+	err = f2fs_get_node_info(sbi, ino, &old_ni);
+	if (err)
+		return err;
 
 	if (unlikely(old_ni.blk_addr != NULL_ADDR))
 		return -EINVAL;
@@ -2496,7 +2538,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	return 0;
 }
 
-void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
+int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
 	struct f2fs_node *rn;
@@ -2518,6 +2560,9 @@ void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 		for (idx = addr; idx < addr + nrpages; idx++) {
 			struct page *page = f2fs_get_tmp_page(sbi, idx);
 
+			if (IS_ERR(page))
+				return PTR_ERR(page);
+
 			rn = F2FS_NODE(page);
 			sum_entry->nid = rn->footer.nid;
 			sum_entry->version = 0;
@@ -2529,6 +2574,7 @@ void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 		invalidate_mapping_pages(META_MAPPING(sbi), addr,
 							addr + nrpages);
 	}
+	return 0;
 }
 
 static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
@@ -2765,7 +2811,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
-		struct page *page = f2fs_get_meta_page(sbi, nat_bits_addr++);
+		struct page *page;
+
+		page = f2fs_get_meta_page(sbi, nat_bits_addr++);
+		if (IS_ERR(page)) {
+			disable_nat_bits(sbi, true);
+			return PTR_ERR(page);
+		}
 
 		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
 					page_address(page), F2FS_BLKSIZE);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 0d927ae26c48..956f34c87082 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -256,6 +256,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			return 0;
 
 		page = f2fs_get_tmp_page(sbi, blkaddr);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			break;
+		}
 
 		if (!is_recoverable_dnode(page))
 			break;
@@ -471,7 +475,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 
-	f2fs_get_node_info(sbi, dn.nid, &ni);
+	err = f2fs_get_node_info(sbi, dn.nid, &ni);
+	if (err)
+		goto err;
+
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
 	f2fs_bug_on(sbi, ofs_of_node(dn.node_page) != ofs_of_node(page));
 
@@ -574,6 +581,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		f2fs_ra_meta_pages_cond(sbi, blkaddr);
 
 		page = f2fs_get_tmp_page(sbi, blkaddr);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			break;
+		}
 
 		if (!is_recoverable_dnode(page)) {
 			f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fd3272e51a6f..0adab2ec5c5e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -250,7 +250,13 @@ static int __revoke_inmem_pages(struct inode *inode,
 				err = -EAGAIN;
 				goto next;
 			}
-			f2fs_get_node_info(sbi, dn.nid, &ni);
+
+			err = f2fs_get_node_info(sbi, dn.nid, &ni);
+			if (err) {
+				f2fs_put_dnode(&dn);
+				return err;
+			}
+
 			if (cur->old_addr == NEW_ADDR) {
 				f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
 				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
@@ -2097,7 +2103,7 @@ int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
  */
 struct page *f2fs_get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	return f2fs_get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
+	return f2fs_get_meta_page_nofail(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
 void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
@@ -2957,11 +2963,9 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	struct f2fs_summary sum;
-	struct node_info ni;
 
 	f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
-	f2fs_get_node_info(sbi, dn->nid, &ni);
-	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
+	set_summary(&sum, dn->nid, dn->ofs_in_node, fio->version);
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 
@@ -3123,7 +3127,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 	}
 }
 
-static void read_compacted_summaries(struct f2fs_sb_info *sbi)
+static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *seg_i;
@@ -3135,6 +3139,8 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 	start = start_sum_block(sbi);
 
 	page = f2fs_get_meta_page(sbi, start++);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 	kaddr = (unsigned char *)page_address(page);
 
 	/* Step 1: restore nat cache */
@@ -3175,11 +3181,14 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 			page = NULL;
 
 			page = f2fs_get_meta_page(sbi, start++);
+			if (IS_ERR(page))
+				return PTR_ERR(page);
 			kaddr = (unsigned char *)page_address(page);
 			offset = 0;
 		}
 	}
 	f2fs_put_page(page, 1);
+	return 0;
 }
 
 static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
@@ -3191,6 +3200,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	unsigned short blk_off;
 	unsigned int segno = 0;
 	block_t blk_addr = 0;
+	int err = 0;
 
 	/* get segment number and block addr */
 	if (IS_DATASEG(type)) {
@@ -3214,6 +3224,8 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	}
 
 	new = f2fs_get_meta_page(sbi, blk_addr);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
 	sum = (struct f2fs_summary_block *)page_address(new);
 
 	if (IS_NODESEG(type)) {
@@ -3225,7 +3237,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 				ns->ofs_in_node = 0;
 			}
 		} else {
-			f2fs_restore_node_summary(sbi, segno, sum);
+			err = f2fs_restore_node_summary(sbi, segno, sum);
+			if (err)
+				goto out;
 		}
 	}
 
@@ -3245,8 +3259,9 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	curseg->alloc_type = ckpt->alloc_type[type];
 	curseg->next_blkoff = blk_off;
 	mutex_unlock(&curseg->curseg_mutex);
+out:
 	f2fs_put_page(new, 1);
-	return 0;
+	return err;
 }
 
 static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
@@ -3264,7 +3279,9 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 							META_CP, true);
 
 		/* restore for compacted data summary */
-		read_compacted_summaries(sbi);
+		err = read_compacted_summaries(sbi);
+		if (err)
+			return err;
 		type = CURSEG_HOT_NODE;
 	}
 
@@ -3395,7 +3412,7 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
-	return f2fs_get_meta_page(sbi, current_sit_addr(sbi, segno));
+	return f2fs_get_meta_page_nofail(sbi, current_sit_addr(sbi, segno));
 }
 
 static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
-- 
2.16.2.17.g38e79b1fd


Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C59C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908EE208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908EE208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeGLLLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:47 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58400 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeGLLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 53F66181878B4;
        Thu, 12 Jul 2018 13:02:29 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/5] ubifs: Pass struct ubifs_info to ubifs_assert()
Date:   Thu, 12 Jul 2018 13:01:57 +0200
Message-Id: <20180712110200.13054-3-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110200.13054-1-richard@nod.at>
References: <20180712110200.13054-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to have more context in ubifs_assert()
and take different actions depending on the configuration.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/budget.c     |  68 ++++++++++++-------------
 fs/ubifs/commit.c     |   8 +--
 fs/ubifs/crypto.c     |   4 +-
 fs/ubifs/debug.c      |  20 ++++----
 fs/ubifs/debug.h      |   4 +-
 fs/ubifs/dir.c        |  35 ++++++-------
 fs/ubifs/file.c       |  47 ++++++++++--------
 fs/ubifs/find.c       |  54 ++++++++++----------
 fs/ubifs/gc.c         |  64 ++++++++++++------------
 fs/ubifs/io.c         |  97 ++++++++++++++++++------------------
 fs/ubifs/journal.c    |  52 ++++++++++----------
 fs/ubifs/key.h        |  14 +++---
 fs/ubifs/log.c        |  12 ++---
 fs/ubifs/lprops.c     |  86 ++++++++++++++++----------------
 fs/ubifs/lpt.c        | 112 +++++++++++++++++++++---------------------
 fs/ubifs/lpt_commit.c |  50 ++++++++++---------
 fs/ubifs/master.c     |   2 +-
 fs/ubifs/misc.h       |  14 +++---
 fs/ubifs/orphan.c     |  26 +++++-----
 fs/ubifs/recovery.c   |  14 +++---
 fs/ubifs/replay.c     |  13 ++---
 fs/ubifs/sb.c         |  12 ++---
 fs/ubifs/scan.c       |   2 +-
 fs/ubifs/shrinker.c   |  10 ++--
 fs/ubifs/super.c      |  45 ++++++++---------
 fs/ubifs/tnc.c        | 107 ++++++++++++++++++++--------------------
 fs/ubifs/tnc_commit.c |  28 +++++------
 fs/ubifs/tnc_misc.c   |  38 ++++++++------
 fs/ubifs/ubifs.h      |  17 ++++---
 fs/ubifs/xattr.c      |  16 +++---
 30 files changed, 550 insertions(+), 521 deletions(-)

diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index 11a11b32a2a9..7ef22baf9d15 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -439,16 +439,16 @@ int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req)
 {
 	int err, idx_growth, data_growth, dd_growth, retried = 0;
 
-	ubifs_assert(req->new_page <= 1);
-	ubifs_assert(req->dirtied_page <= 1);
-	ubifs_assert(req->new_dent <= 1);
-	ubifs_assert(req->mod_dent <= 1);
-	ubifs_assert(req->new_ino <= 1);
-	ubifs_assert(req->new_ino_d <= UBIFS_MAX_INO_DATA);
-	ubifs_assert(req->dirtied_ino <= 4);
-	ubifs_assert(req->dirtied_ino_d <= UBIFS_MAX_INO_DATA * 4);
-	ubifs_assert(!(req->new_ino_d & 7));
-	ubifs_assert(!(req->dirtied_ino_d & 7));
+	ubifs_assert(c, req->new_page <= 1);
+	ubifs_assert(c, req->dirtied_page <= 1);
+	ubifs_assert(c, req->new_dent <= 1);
+	ubifs_assert(c, req->mod_dent <= 1);
+	ubifs_assert(c, req->new_ino <= 1);
+	ubifs_assert(c, req->new_ino_d <= UBIFS_MAX_INO_DATA);
+	ubifs_assert(c, req->dirtied_ino <= 4);
+	ubifs_assert(c, req->dirtied_ino_d <= UBIFS_MAX_INO_DATA * 4);
+	ubifs_assert(c, !(req->new_ino_d & 7));
+	ubifs_assert(c, !(req->dirtied_ino_d & 7));
 
 	data_growth = calc_data_growth(c, req);
 	dd_growth = calc_dd_growth(c, req);
@@ -458,9 +458,9 @@ int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req)
 
 again:
 	spin_lock(&c->space_lock);
-	ubifs_assert(c->bi.idx_growth >= 0);
-	ubifs_assert(c->bi.data_growth >= 0);
-	ubifs_assert(c->bi.dd_growth >= 0);
+	ubifs_assert(c, c->bi.idx_growth >= 0);
+	ubifs_assert(c, c->bi.data_growth >= 0);
+	ubifs_assert(c, c->bi.dd_growth >= 0);
 
 	if (unlikely(c->bi.nospace) && (c->bi.nospace_rp || !can_use_rp(c))) {
 		dbg_budg("no space");
@@ -526,20 +526,20 @@ int ubifs_budget_space(struct ubifs_info *c, struct ubifs_budget_req *req)
  */
 void ubifs_release_budget(struct ubifs_info *c, struct ubifs_budget_req *req)
 {
-	ubifs_assert(req->new_page <= 1);
-	ubifs_assert(req->dirtied_page <= 1);
-	ubifs_assert(req->new_dent <= 1);
-	ubifs_assert(req->mod_dent <= 1);
-	ubifs_assert(req->new_ino <= 1);
-	ubifs_assert(req->new_ino_d <= UBIFS_MAX_INO_DATA);
-	ubifs_assert(req->dirtied_ino <= 4);
-	ubifs_assert(req->dirtied_ino_d <= UBIFS_MAX_INO_DATA * 4);
-	ubifs_assert(!(req->new_ino_d & 7));
-	ubifs_assert(!(req->dirtied_ino_d & 7));
+	ubifs_assert(c, req->new_page <= 1);
+	ubifs_assert(c, req->dirtied_page <= 1);
+	ubifs_assert(c, req->new_dent <= 1);
+	ubifs_assert(c, req->mod_dent <= 1);
+	ubifs_assert(c, req->new_ino <= 1);
+	ubifs_assert(c, req->new_ino_d <= UBIFS_MAX_INO_DATA);
+	ubifs_assert(c, req->dirtied_ino <= 4);
+	ubifs_assert(c, req->dirtied_ino_d <= UBIFS_MAX_INO_DATA * 4);
+	ubifs_assert(c, !(req->new_ino_d & 7));
+	ubifs_assert(c, !(req->dirtied_ino_d & 7));
 	if (!req->recalculate) {
-		ubifs_assert(req->idx_growth >= 0);
-		ubifs_assert(req->data_growth >= 0);
-		ubifs_assert(req->dd_growth >= 0);
+		ubifs_assert(c, req->idx_growth >= 0);
+		ubifs_assert(c, req->data_growth >= 0);
+		ubifs_assert(c, req->dd_growth >= 0);
 	}
 
 	if (req->recalculate) {
@@ -561,13 +561,13 @@ void ubifs_release_budget(struct ubifs_info *c, struct ubifs_budget_req *req)
 	c->bi.dd_growth -= req->dd_growth;
 	c->bi.min_idx_lebs = ubifs_calc_min_idx_lebs(c);
 
-	ubifs_assert(c->bi.idx_growth >= 0);
-	ubifs_assert(c->bi.data_growth >= 0);
-	ubifs_assert(c->bi.dd_growth >= 0);
-	ubifs_assert(c->bi.min_idx_lebs < c->main_lebs);
-	ubifs_assert(!(c->bi.idx_growth & 7));
-	ubifs_assert(!(c->bi.data_growth & 7));
-	ubifs_assert(!(c->bi.dd_growth & 7));
+	ubifs_assert(c, c->bi.idx_growth >= 0);
+	ubifs_assert(c, c->bi.data_growth >= 0);
+	ubifs_assert(c, c->bi.dd_growth >= 0);
+	ubifs_assert(c, c->bi.min_idx_lebs < c->main_lebs);
+	ubifs_assert(c, !(c->bi.idx_growth & 7));
+	ubifs_assert(c, !(c->bi.data_growth & 7));
+	ubifs_assert(c, !(c->bi.dd_growth & 7));
 	spin_unlock(&c->space_lock);
 }
 
@@ -680,7 +680,7 @@ long long ubifs_get_free_space_nolock(struct ubifs_info *c)
 	int rsvd_idx_lebs, lebs;
 	long long available, outstanding, free;
 
-	ubifs_assert(c->bi.min_idx_lebs == ubifs_calc_min_idx_lebs(c));
+	ubifs_assert(c, c->bi.min_idx_lebs == ubifs_calc_min_idx_lebs(c));
 	outstanding = c->bi.data_growth + c->bi.dd_growth;
 	available = ubifs_calc_available(c, c->bi.min_idx_lebs);
 
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index 63f56619991d..591f2c7a48f0 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -91,9 +91,9 @@ static int nothing_to_commit(struct ubifs_info *c)
 	if (c->nroot && test_bit(DIRTY_CNODE, &c->nroot->flags))
 		return 0;
 
-	ubifs_assert(atomic_long_read(&c->dirty_zn_cnt) == 0);
-	ubifs_assert(c->dirty_pn_cnt == 0);
-	ubifs_assert(c->dirty_nn_cnt == 0);
+	ubifs_assert(c, atomic_long_read(&c->dirty_zn_cnt) == 0);
+	ubifs_assert(c, c->dirty_pn_cnt == 0);
+	ubifs_assert(c, c->dirty_nn_cnt == 0);
 
 	return 1;
 }
@@ -113,7 +113,7 @@ static int do_commit(struct ubifs_info *c)
 	struct ubifs_lp_stats lst;
 
 	dbg_cmt("start");
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 
 	if (c->ro_error) {
 		err = -EROFS;
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 55c508fe8131..4aaedf2d7f44 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -32,7 +32,7 @@ int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
 	struct page *ret;
 	unsigned int pad_len = round_up(in_len, UBIFS_CIPHER_BLOCK_SIZE);
 
-	ubifs_assert(pad_len <= *out_len);
+	ubifs_assert(c, pad_len <= *out_len);
 	dn->compr_size = cpu_to_le16(in_len);
 
 	/* pad to full block cipher length */
@@ -63,7 +63,7 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 		return -EINVAL;
 	}
 
-	ubifs_assert(dlen <= UBIFS_BLOCK_SIZE);
+	ubifs_assert(c, dlen <= UBIFS_BLOCK_SIZE);
 	err = fscrypt_decrypt_page(inode, virt_to_page(&dn->data), dlen,
 			offset_in_page(&dn->data), block);
 	if (err) {
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 7cd8a7b95299..1a626484f8ae 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -134,7 +134,7 @@ const char *dbg_snprintf_key(const struct ubifs_info *c,
 		}
 	} else
 		len -= snprintf(p, len, "bad key format %d", c->key_fmt);
-	ubifs_assert(len > 0);
+	ubifs_assert(c, len > 0);
 	return p;
 }
 
@@ -276,7 +276,7 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 		return;
 
 	pr_err("List of directory entries:\n");
-	ubifs_assert(!mutex_is_locked(&c->tnc_mutex));
+	ubifs_assert(c, !mutex_is_locked(&c->tnc_mutex));
 
 	lowest_dent_key(c, &key, inode->i_ino);
 	while (1) {
@@ -931,7 +931,7 @@ void ubifs_dump_tnc(struct ubifs_info *c)
 
 	pr_err("\n");
 	pr_err("(pid %d) start dumping TNC tree\n", current->pid);
-	znode = ubifs_tnc_levelorder_next(c->zroot.znode, NULL);
+	znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, NULL);
 	level = znode->level;
 	pr_err("== Level %d ==\n", level);
 	while (znode) {
@@ -940,7 +940,7 @@ void ubifs_dump_tnc(struct ubifs_info *c)
 			pr_err("== Level %d ==\n", level);
 		}
 		ubifs_dump_znode(c, znode);
-		znode = ubifs_tnc_levelorder_next(c->zroot.znode, znode);
+		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
 	}
 	pr_err("(pid %d) finish dumping TNC tree\n", current->pid);
 }
@@ -1183,7 +1183,7 @@ static int dbg_check_key_order(struct ubifs_info *c, struct ubifs_zbranch *zbr1,
 	union ubifs_key key;
 	char key_buf[DBG_KEY_BUF_LEN];
 
-	ubifs_assert(!keys_cmp(c, &zbr1->key, &zbr2->key));
+	ubifs_assert(c, !keys_cmp(c, &zbr1->key, &zbr2->key));
 	dent1 = kmalloc(UBIFS_MAX_DENT_NODE_SZ, GFP_NOFS);
 	if (!dent1)
 		return -ENOMEM;
@@ -1479,7 +1479,7 @@ int dbg_check_tnc(struct ubifs_info *c, int extra)
 	if (!dbg_is_chk_index(c))
 		return 0;
 
-	ubifs_assert(mutex_is_locked(&c->tnc_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->tnc_mutex));
 	if (!c->zroot.znode)
 		return 0;
 
@@ -1505,7 +1505,7 @@ int dbg_check_tnc(struct ubifs_info *c, int extra)
 		}
 
 		prev = znode;
-		znode = ubifs_tnc_postorder_next(znode);
+		znode = ubifs_tnc_postorder_next(c, znode);
 		if (!znode)
 			break;
 
@@ -2036,7 +2036,7 @@ static int check_leaf(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 		long long blk_offs;
 		struct ubifs_data_node *dn = node;
 
-		ubifs_assert(zbr->len >= UBIFS_DATA_NODE_SZ);
+		ubifs_assert(c, zbr->len >= UBIFS_DATA_NODE_SZ);
 
 		/*
 		 * Search the inode node this data node belongs to and insert
@@ -2066,7 +2066,7 @@ static int check_leaf(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 		struct ubifs_dent_node *dent = node;
 		struct fsck_inode *fscki1;
 
-		ubifs_assert(zbr->len >= UBIFS_DENT_NODE_SZ);
+		ubifs_assert(c, zbr->len >= UBIFS_DENT_NODE_SZ);
 
 		err = ubifs_validate_entry(c, dent);
 		if (err)
@@ -2461,7 +2461,7 @@ static int power_cut_emulated(struct ubifs_info *c, int lnum, int write)
 {
 	struct ubifs_debug_info *d = c->dbg;
 
-	ubifs_assert(dbg_is_tst_rcvry(c));
+	ubifs_assert(c, dbg_is_tst_rcvry(c));
 
 	if (!d->pc_cnt) {
 		/* First call - decide delay to the power cut */
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index e03d5179769a..981a3fa081f3 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -148,7 +148,7 @@ struct ubifs_global_debug_info {
 	unsigned int tst_rcvry:1;
 };
 
-#define ubifs_assert(expr) do {                                                \
+#define ubifs_assert(c, expr) do {                                             \
 	if (unlikely(!(expr))) {                                               \
 		pr_crit("UBIFS assert failed in %s at %u (pid %d)\n",          \
 		       __func__, __LINE__, current->pid);                      \
@@ -160,7 +160,7 @@ struct ubifs_global_debug_info {
 	if (unlikely(down_write_trylock(&(c)->commit_sem))) {                  \
 		up_write(&(c)->commit_sem);                                    \
 		pr_crit("commit lock is not locked!\n");                       \
-		ubifs_assert(0);                                               \
+		ubifs_assert(c, 0);                                            \
 	}                                                                      \
 } while (0)
 
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9da224d4f2da..674403342456 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -240,8 +240,8 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	if (nm.hash) {
-		ubifs_assert(fname_len(&nm) == 0);
-		ubifs_assert(fname_name(&nm) == NULL);
+		ubifs_assert(c, fname_len(&nm) == 0);
+		ubifs_assert(c, fname_name(&nm) == NULL);
 		dent_key_init_hash(c, &key, dir->i_ino, nm.hash);
 		err = ubifs_tnc_lookup_dh(c, &key, dent, nm.minor_hash);
 	} else {
@@ -404,7 +404,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 
 	if (whiteout) {
 		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
-		ubifs_assert(inode->i_op == &ubifs_file_inode_operations);
+		ubifs_assert(c, inode->i_op == &ubifs_file_inode_operations);
 	}
 
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
@@ -421,7 +421,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	} else {
 		d_tmpfile(dentry, inode);
 	}
-	ubifs_assert(ui->dirty);
+	ubifs_assert(c, ui->dirty);
 
 	instantiated = 1;
 	mutex_unlock(&ui->ui_mutex);
@@ -556,7 +556,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 
 	/* File positions 0 and 1 correspond to "." and ".." */
 	if (ctx->pos < 2) {
-		ubifs_assert(!file->private_data);
+		ubifs_assert(c, !file->private_data);
 		if (!dir_emit_dots(file, ctx)) {
 			if (encrypted)
 				fscrypt_fname_free_buffer(&fstr);
@@ -597,7 +597,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		dbg_gen("ino %llu, new f_pos %#x",
 			(unsigned long long)le64_to_cpu(dent->inum),
 			key_hash_flash(c, &dent->key));
-		ubifs_assert(le64_to_cpu(dent->ch.sqnum) >
+		ubifs_assert(c, le64_to_cpu(dent->ch.sqnum) >
 			     ubifs_inode(dir)->creat_sqnum);
 
 		fname_len(&nm) = le16_to_cpu(dent->nlen);
@@ -716,8 +716,8 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 	dbg_gen("dent '%pd' to ino %lu (nlink %d) in dir ino %lu",
 		dentry, inode->i_ino,
 		inode->i_nlink, dir->i_ino);
-	ubifs_assert(inode_is_locked(dir));
-	ubifs_assert(inode_is_locked(inode));
+	ubifs_assert(c, inode_is_locked(dir));
+	ubifs_assert(c, inode_is_locked(inode));
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
 	if (err)
@@ -804,8 +804,8 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	ubifs_assert(inode_is_locked(dir));
-	ubifs_assert(inode_is_locked(inode));
+	ubifs_assert(c, inode_is_locked(dir));
+	ubifs_assert(c, inode_is_locked(inode));
 	err = dbg_check_synced_i_size(c, inode);
 	if (err)
 		goto out_fname;
@@ -896,8 +896,8 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 
 	dbg_gen("directory '%pd', ino %lu in dir ino %lu", dentry,
 		inode->i_ino, dir->i_ino);
-	ubifs_assert(inode_is_locked(dir));
-	ubifs_assert(inode_is_locked(inode));
+	ubifs_assert(c, inode_is_locked(dir));
+	ubifs_assert(c, inode_is_locked(inode));
 	err = ubifs_check_dir_empty(d_inode(dentry));
 	if (err)
 		return err;
@@ -1294,7 +1294,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 		new_dentry, new_dir->i_ino, flags);
 
 	if (unlink)
-		ubifs_assert(inode_is_locked(new_inode));
+		ubifs_assert(c, inode_is_locked(new_inode));
 
 	if (unlink && is_dir) {
 		err = ubifs_check_dir_empty(new_inode);
@@ -1348,7 +1348,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 		whiteout_ui = ubifs_inode(whiteout);
 		whiteout_ui->data = dev;
 		whiteout_ui->data_len = ubifs_encode_dev(dev, MKDEV(0, 0));
-		ubifs_assert(!whiteout_ui->dirty);
+		ubifs_assert(c, !whiteout_ui->dirty);
 	}
 
 	lock_4_inodes(old_dir, new_dir, new_inode, whiteout);
@@ -1508,7 +1508,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	int err;
 	struct fscrypt_name fst_nm, snd_nm;
 
-	ubifs_assert(fst_inode && snd_inode);
+	ubifs_assert(c, fst_inode && snd_inode);
 
 	err = fscrypt_setup_filename(old_dir, &old_dentry->d_name, 0, &fst_nm);
 	if (err)
@@ -1555,12 +1555,13 @@ static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			unsigned int flags)
 {
 	int err;
+	struct ubifs_info *c = old_dir->i_sb->s_fs_info;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_WHITEOUT | RENAME_EXCHANGE))
 		return -EINVAL;
 
-	ubifs_assert(inode_is_locked(old_dir));
-	ubifs_assert(inode_is_locked(new_dir));
+	ubifs_assert(c, inode_is_locked(old_dir));
+	ubifs_assert(c, inode_is_locked(new_dir));
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
 				     flags);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index fd7eb6fe9090..5649a727e545 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -71,7 +71,7 @@ static int read_block(struct inode *inode, void *addr, unsigned int block,
 		return err;
 	}
 
-	ubifs_assert(le64_to_cpu(dn->ch.sqnum) >
+	ubifs_assert(c, le64_to_cpu(dn->ch.sqnum) >
 		     ubifs_inode(inode)->creat_sqnum);
 	len = le32_to_cpu(dn->size);
 	if (len <= 0 || len > UBIFS_BLOCK_SIZE)
@@ -115,12 +115,13 @@ static int do_readpage(struct page *page)
 	unsigned int block, beyond;
 	struct ubifs_data_node *dn;
 	struct inode *inode = page->mapping->host;
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	loff_t i_size = i_size_read(inode);
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld, flags %#lx",
 		inode->i_ino, page->index, i_size, page->flags);
-	ubifs_assert(!PageChecked(page));
-	ubifs_assert(!PagePrivate(page));
+	ubifs_assert(c, !PageChecked(page));
+	ubifs_assert(c, !PagePrivate(page));
 
 	addr = kmap(page);
 
@@ -441,8 +442,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 	int skipped_read = 0;
 	struct page *page;
 
-	ubifs_assert(ubifs_inode(inode)->ui_size == inode->i_size);
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, ubifs_inode(inode)->ui_size == inode->i_size);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 
 	if (unlikely(c->ro_error))
 		return -EROFS;
@@ -481,7 +482,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 
 	err = allocate_budget(c, page, ui, appending);
 	if (unlikely(err)) {
-		ubifs_assert(err == -ENOSPC);
+		ubifs_assert(c, err == -ENOSPC);
 		/*
 		 * If we skipped reading the page because we were going to
 		 * write all of it, then it is not up to date.
@@ -498,7 +499,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		 * everything and fall-back to slow-path.
 		 */
 		if (appending) {
-			ubifs_assert(mutex_is_locked(&ui->ui_mutex));
+			ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 			mutex_unlock(&ui->ui_mutex);
 		}
 		unlock_page(page);
@@ -595,7 +596,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		 * '__set_page_dirty_nobuffers()'.
 		 */
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-		ubifs_assert(mutex_is_locked(&ui->ui_mutex));
+		ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 		mutex_unlock(&ui->ui_mutex);
 	}
 
@@ -648,7 +649,7 @@ static int populate_page(struct ubifs_info *c, struct page *page,
 
 			dn = bu->buf + (bu->zbranch[nn].offs - offs);
 
-			ubifs_assert(le64_to_cpu(dn->ch.sqnum) >
+			ubifs_assert(c, le64_to_cpu(dn->ch.sqnum) >
 				     ubifs_inode(inode)->creat_sqnum);
 
 			len = le32_to_cpu(dn->size);
@@ -767,8 +768,8 @@ static int ubifs_do_bulk_read(struct ubifs_info *c, struct bu_info *bu,
 			bu->buf_len = bu->zbranch[bu->cnt - 1].offs +
 				      bu->zbranch[bu->cnt - 1].len -
 				      bu->zbranch[0].offs;
-			ubifs_assert(bu->buf_len > 0);
-			ubifs_assert(bu->buf_len <= c->leb_size);
+			ubifs_assert(c, bu->buf_len > 0);
+			ubifs_assert(c, bu->buf_len <= c->leb_size);
 			bu->buf = kmalloc(bu->buf_len, GFP_NOFS | __GFP_NOWARN);
 			if (!bu->buf)
 				goto out_bu_off;
@@ -920,7 +921,7 @@ static int do_writepage(struct page *page, int len)
 #ifdef UBIFS_DEBUG
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	spin_lock(&ui->ui_lock);
-	ubifs_assert(page->index <= ui->synced_i_size >> PAGE_SHIFT);
+	ubifs_assert(c, page->index <= ui->synced_i_size >> PAGE_SHIFT);
 	spin_unlock(&ui->ui_lock);
 #endif
 
@@ -949,7 +950,7 @@ static int do_writepage(struct page *page, int len)
 		ubifs_ro_mode(c, err);
 	}
 
-	ubifs_assert(PagePrivate(page));
+	ubifs_assert(c, PagePrivate(page));
 	if (PageChecked(page))
 		release_new_page_budget(c);
 	else
@@ -1014,6 +1015,7 @@ static int do_writepage(struct page *page, int len)
 static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	loff_t i_size =  i_size_read(inode), synced_i_size;
 	pgoff_t end_index = i_size >> PAGE_SHIFT;
@@ -1022,7 +1024,7 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 
 	dbg_gen("ino %lu, pg %lu, pg flags %#lx",
 		inode->i_ino, page->index, page->flags);
-	ubifs_assert(PagePrivate(page));
+	ubifs_assert(c, PagePrivate(page));
 
 	/* Is the page fully outside @i_size? (truncate in progress) */
 	if (page->index > end_index || (page->index == end_index && !len)) {
@@ -1167,7 +1169,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 				 * 'ubifs_jnl_truncate()' will see an already
 				 * truncated (and up to date) data node.
 				 */
-				ubifs_assert(PagePrivate(page));
+				ubifs_assert(c, PagePrivate(page));
 
 				clear_page_dirty_for_io(page);
 				if (UBIFS_BLOCKS_PER_PAGE_SHIFT)
@@ -1303,7 +1305,7 @@ static void ubifs_invalidatepage(struct page *page, unsigned int offset,
 	struct inode *inode = page->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
-	ubifs_assert(PagePrivate(page));
+	ubifs_assert(c, PagePrivate(page));
 	if (offset || length < PAGE_SIZE)
 		/* Partial page remains dirty */
 		return;
@@ -1462,13 +1464,15 @@ static ssize_t ubifs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int ubifs_set_page_dirty(struct page *page)
 {
 	int ret;
+	struct inode *inode = page->mapping->host;
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
 	ret = __set_page_dirty_nobuffers(page);
 	/*
 	 * An attempt to dirty a page without budgeting for it - should not
 	 * happen.
 	 */
-	ubifs_assert(ret == 0);
+	ubifs_assert(c, ret == 0);
 	return ret;
 }
 
@@ -1497,14 +1501,17 @@ static int ubifs_migrate_page(struct address_space *mapping,
 
 static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
 {
+	struct inode *inode = page->mapping->host;
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
+
 	/*
 	 * An attempt to release a dirty page without budgeting for it - should
 	 * not happen.
 	 */
 	if (PageWriteback(page))
 		return 0;
-	ubifs_assert(PagePrivate(page));
-	ubifs_assert(0);
+	ubifs_assert(c, PagePrivate(page));
+	ubifs_assert(c, 0);
 	ClearPagePrivate(page);
 	ClearPageChecked(page);
 	return 1;
@@ -1525,7 +1532,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	dbg_gen("ino %lu, pg %lu, i_size %lld",	inode->i_ino, page->index,
 		i_size_read(inode));
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 
 	if (unlikely(c->ro_error))
 		return VM_FAULT_SIGBUS; /* -EROFS */
diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 9571616b5dda..df1f978207a3 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -183,18 +183,18 @@ static const struct ubifs_lprops *scan_for_dirty(struct ubifs_info *c,
 				    &data);
 	if (err)
 		return ERR_PTR(err);
-	ubifs_assert(data.lnum >= c->main_first && data.lnum < c->leb_cnt);
+	ubifs_assert(c, data.lnum >= c->main_first && data.lnum < c->leb_cnt);
 	c->lscan_lnum = data.lnum;
 	lprops = ubifs_lpt_lookup_dirty(c, data.lnum);
 	if (IS_ERR(lprops))
 		return lprops;
-	ubifs_assert(lprops->lnum == data.lnum);
-	ubifs_assert(lprops->free + lprops->dirty >= min_space);
-	ubifs_assert(lprops->dirty >= c->dead_wm ||
+	ubifs_assert(c, lprops->lnum == data.lnum);
+	ubifs_assert(c, lprops->free + lprops->dirty >= min_space);
+	ubifs_assert(c, lprops->dirty >= c->dead_wm ||
 		     (pick_free &&
 		      lprops->free + lprops->dirty == c->leb_size));
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!exclude_index || !(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !exclude_index || !(lprops->flags & LPROPS_INDEX));
 	return lprops;
 }
 
@@ -315,7 +315,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
 		lp = idx_lp;
 
 	if (lp) {
-		ubifs_assert(lp->free + lp->dirty >= c->dead_wm);
+		ubifs_assert(c, lp->free + lp->dirty >= c->dead_wm);
 		goto found;
 	}
 
@@ -326,7 +326,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
 		err = PTR_ERR(lp);
 		goto out;
 	}
-	ubifs_assert(lp->dirty >= c->dead_wm ||
+	ubifs_assert(c, lp->dirty >= c->dead_wm ||
 		     (pick_free && lp->free + lp->dirty == c->leb_size));
 
 found:
@@ -462,15 +462,15 @@ const struct ubifs_lprops *do_find_free_space(struct ubifs_info *c,
 				    &data);
 	if (err)
 		return ERR_PTR(err);
-	ubifs_assert(data.lnum >= c->main_first && data.lnum < c->leb_cnt);
+	ubifs_assert(c, data.lnum >= c->main_first && data.lnum < c->leb_cnt);
 	c->lscan_lnum = data.lnum;
 	lprops = ubifs_lpt_lookup_dirty(c, data.lnum);
 	if (IS_ERR(lprops))
 		return lprops;
-	ubifs_assert(lprops->lnum == data.lnum);
-	ubifs_assert(lprops->free >= min_space);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->lnum == data.lnum);
+	ubifs_assert(c, lprops->free >= min_space);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
 	return lprops;
 }
 
@@ -574,7 +574,7 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
 	}
 
 	dbg_find("found LEB %d, free %d", lnum, c->leb_size - *offs);
-	ubifs_assert(*offs <= c->leb_size - min_space);
+	ubifs_assert(c, *offs <= c->leb_size - min_space);
 	return lnum;
 
 out:
@@ -642,15 +642,15 @@ static const struct ubifs_lprops *scan_for_leb_for_idx(struct ubifs_info *c)
 				    &data);
 	if (err)
 		return ERR_PTR(err);
-	ubifs_assert(data.lnum >= c->main_first && data.lnum < c->leb_cnt);
+	ubifs_assert(c, data.lnum >= c->main_first && data.lnum < c->leb_cnt);
 	c->lscan_lnum = data.lnum;
 	lprops = ubifs_lpt_lookup_dirty(c, data.lnum);
 	if (IS_ERR(lprops))
 		return lprops;
-	ubifs_assert(lprops->lnum == data.lnum);
-	ubifs_assert(lprops->free + lprops->dirty == c->leb_size);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->lnum == data.lnum);
+	ubifs_assert(c, lprops->free + lprops->dirty == c->leb_size);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
 	return lprops;
 }
 
@@ -690,7 +690,7 @@ int ubifs_find_free_leb_for_idx(struct ubifs_info *c)
 			 */
 			if (c->in_a_category_cnt != c->main_lebs ||
 			    c->lst.empty_lebs - c->lst.taken_empty_lebs > 0) {
-				ubifs_assert(c->freeable_cnt == 0);
+				ubifs_assert(c, c->freeable_cnt == 0);
 				lprops = scan_for_leb_for_idx(c);
 				if (IS_ERR(lprops)) {
 					err = PTR_ERR(lprops);
@@ -870,15 +870,15 @@ static int find_dirty_idx_leb(struct ubifs_info *c)
 	if (err)
 		return err;
 found:
-	ubifs_assert(data.lnum >= c->main_first && data.lnum < c->leb_cnt);
+	ubifs_assert(c, data.lnum >= c->main_first && data.lnum < c->leb_cnt);
 	c->lscan_lnum = data.lnum;
 	lprops = ubifs_lpt_lookup_dirty(c, data.lnum);
 	if (IS_ERR(lprops))
 		return PTR_ERR(lprops);
-	ubifs_assert(lprops->lnum == data.lnum);
-	ubifs_assert(lprops->free + lprops->dirty >= c->min_idx_node_sz);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert((lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->lnum == data.lnum);
+	ubifs_assert(c, lprops->free + lprops->dirty >= c->min_idx_node_sz);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, (lprops->flags & LPROPS_INDEX));
 
 	dbg_find("found dirty LEB %d, free %d, dirty %d, flags %#x",
 		 lprops->lnum, lprops->free, lprops->dirty, lprops->flags);
@@ -947,8 +947,8 @@ static int find_dirtiest_idx_leb(struct ubifs_info *c)
 	}
 	dbg_find("LEB %d, dirty %d and free %d flags %#x", lp->lnum, lp->dirty,
 		 lp->free, lp->flags);
-	ubifs_assert(lp->flags & LPROPS_TAKEN);
-	ubifs_assert(lp->flags & LPROPS_INDEX);
+	ubifs_assert(c, lp->flags & LPROPS_TAKEN);
+	ubifs_assert(c, lp->flags & LPROPS_INDEX);
 	return lnum;
 }
 
diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index a03a47cf880d..6e3f07b9ecec 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -83,7 +83,7 @@ static int switch_gc_head(struct ubifs_info *c)
 	int err, gc_lnum = c->gc_lnum;
 	struct ubifs_wbuf *wbuf = &c->jheads[GCHD].wbuf;
 
-	ubifs_assert(gc_lnum != -1);
+	ubifs_assert(c, gc_lnum != -1);
 	dbg_gc("switch GC head from LEB %d:%d to LEB %d (waste %d bytes)",
 	       wbuf->lnum, wbuf->offs + wbuf->used, gc_lnum,
 	       c->leb_size - wbuf->offs - wbuf->used);
@@ -131,10 +131,10 @@ static int data_nodes_cmp(void *priv, struct list_head *a, struct list_head *b)
 	sa = list_entry(a, struct ubifs_scan_node, list);
 	sb = list_entry(b, struct ubifs_scan_node, list);
 
-	ubifs_assert(key_type(c, &sa->key) == UBIFS_DATA_KEY);
-	ubifs_assert(key_type(c, &sb->key) == UBIFS_DATA_KEY);
-	ubifs_assert(sa->type == UBIFS_DATA_NODE);
-	ubifs_assert(sb->type == UBIFS_DATA_NODE);
+	ubifs_assert(c, key_type(c, &sa->key) == UBIFS_DATA_KEY);
+	ubifs_assert(c, key_type(c, &sb->key) == UBIFS_DATA_KEY);
+	ubifs_assert(c, sa->type == UBIFS_DATA_NODE);
+	ubifs_assert(c, sb->type == UBIFS_DATA_NODE);
 
 	inuma = key_inum(c, &sa->key);
 	inumb = key_inum(c, &sb->key);
@@ -175,9 +175,9 @@ static int nondata_nodes_cmp(void *priv, struct list_head *a,
 	sa = list_entry(a, struct ubifs_scan_node, list);
 	sb = list_entry(b, struct ubifs_scan_node, list);
 
-	ubifs_assert(key_type(c, &sa->key) != UBIFS_DATA_KEY &&
+	ubifs_assert(c, key_type(c, &sa->key) != UBIFS_DATA_KEY &&
 		     key_type(c, &sb->key) != UBIFS_DATA_KEY);
-	ubifs_assert(sa->type != UBIFS_DATA_NODE &&
+	ubifs_assert(c, sa->type != UBIFS_DATA_NODE &&
 		     sb->type != UBIFS_DATA_NODE);
 
 	/* Inodes go before directory entries */
@@ -189,13 +189,13 @@ static int nondata_nodes_cmp(void *priv, struct list_head *a,
 	if (sb->type == UBIFS_INO_NODE)
 		return 1;
 
-	ubifs_assert(key_type(c, &sa->key) == UBIFS_DENT_KEY ||
+	ubifs_assert(c, key_type(c, &sa->key) == UBIFS_DENT_KEY ||
 		     key_type(c, &sa->key) == UBIFS_XENT_KEY);
-	ubifs_assert(key_type(c, &sb->key) == UBIFS_DENT_KEY ||
+	ubifs_assert(c, key_type(c, &sb->key) == UBIFS_DENT_KEY ||
 		     key_type(c, &sb->key) == UBIFS_XENT_KEY);
-	ubifs_assert(sa->type == UBIFS_DENT_NODE ||
+	ubifs_assert(c, sa->type == UBIFS_DENT_NODE ||
 		     sa->type == UBIFS_XENT_NODE);
-	ubifs_assert(sb->type == UBIFS_DENT_NODE ||
+	ubifs_assert(c, sb->type == UBIFS_DENT_NODE ||
 		     sb->type == UBIFS_XENT_NODE);
 
 	inuma = key_inum(c, &sa->key);
@@ -250,7 +250,7 @@ static int sort_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 
 	/* Separate data nodes and non-data nodes */
 	list_for_each_entry_safe(snod, tmp, &sleb->nodes, list) {
-		ubifs_assert(snod->type == UBIFS_INO_NODE  ||
+		ubifs_assert(c, snod->type == UBIFS_INO_NODE  ||
 			     snod->type == UBIFS_DATA_NODE ||
 			     snod->type == UBIFS_DENT_NODE ||
 			     snod->type == UBIFS_XENT_NODE ||
@@ -266,7 +266,7 @@ static int sort_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 			continue;
 		}
 
-		ubifs_assert(key_type(c, &snod->key) == UBIFS_DATA_KEY ||
+		ubifs_assert(c, key_type(c, &snod->key) == UBIFS_DATA_KEY ||
 			     key_type(c, &snod->key) == UBIFS_INO_KEY  ||
 			     key_type(c, &snod->key) == UBIFS_DENT_KEY ||
 			     key_type(c, &snod->key) == UBIFS_XENT_KEY);
@@ -469,15 +469,15 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
 	struct ubifs_wbuf *wbuf = &c->jheads[GCHD].wbuf;
 	int err = 0, lnum = lp->lnum;
 
-	ubifs_assert(c->gc_lnum != -1 || wbuf->offs + wbuf->used == 0 ||
+	ubifs_assert(c, c->gc_lnum != -1 || wbuf->offs + wbuf->used == 0 ||
 		     c->need_recovery);
-	ubifs_assert(c->gc_lnum != lnum);
-	ubifs_assert(wbuf->lnum != lnum);
+	ubifs_assert(c, c->gc_lnum != lnum);
+	ubifs_assert(c, wbuf->lnum != lnum);
 
 	if (lp->free + lp->dirty == c->leb_size) {
 		/* Special case - a free LEB  */
 		dbg_gc("LEB %d is free, return it", lp->lnum);
-		ubifs_assert(!(lp->flags & LPROPS_INDEX));
+		ubifs_assert(c, !(lp->flags & LPROPS_INDEX));
 
 		if (lp->free != c->leb_size) {
 			/*
@@ -513,7 +513,7 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
 	if (IS_ERR(sleb))
 		return PTR_ERR(sleb);
 
-	ubifs_assert(!list_empty(&sleb->nodes));
+	ubifs_assert(c, !list_empty(&sleb->nodes));
 	snod = list_entry(sleb->nodes.next, struct ubifs_scan_node, list);
 
 	if (snod->type == UBIFS_IDX_NODE) {
@@ -525,7 +525,7 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
 			struct ubifs_idx_node *idx = snod->node;
 			int level = le16_to_cpu(idx->level);
 
-			ubifs_assert(snod->type == UBIFS_IDX_NODE);
+			ubifs_assert(c, snod->type == UBIFS_IDX_NODE);
 			key_read(c, ubifs_idx_key(c, idx), &snod->key);
 			err = ubifs_dirty_idx_node(c, &snod->key, level, lnum,
 						   snod->offs);
@@ -648,7 +648,7 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 	struct ubifs_wbuf *wbuf = &c->jheads[GCHD].wbuf;
 
 	ubifs_assert_cmt_locked(c);
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 
 	if (ubifs_gc_should_commit(c))
 		return -EAGAIN;
@@ -661,7 +661,7 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 	}
 
 	/* We expect the write-buffer to be empty on entry */
-	ubifs_assert(!wbuf->used);
+	ubifs_assert(c, !wbuf->used);
 
 	for (i = 0; ; i++) {
 		int space_before, space_after;
@@ -752,7 +752,7 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 			continue;
 		}
 
-		ubifs_assert(ret == LEB_RETAINED);
+		ubifs_assert(c, ret == LEB_RETAINED);
 		space_after = c->leb_size - wbuf->offs - wbuf->used;
 		dbg_gc("LEB %d retained, freed %d bytes", lp.lnum,
 		       space_after - space_before);
@@ -812,8 +812,8 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 	return ret;
 
 out:
-	ubifs_assert(ret < 0);
-	ubifs_assert(ret != -ENOSPC && ret != -EAGAIN);
+	ubifs_assert(c, ret < 0);
+	ubifs_assert(c, ret != -ENOSPC && ret != -EAGAIN);
 	ubifs_wbuf_sync_nolock(wbuf);
 	ubifs_ro_mode(c, ret);
 	mutex_unlock(&wbuf->io_mutex);
@@ -848,8 +848,8 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 		lp = ubifs_fast_find_freeable(c);
 		if (!lp)
 			break;
-		ubifs_assert(!(lp->flags & LPROPS_TAKEN));
-		ubifs_assert(!(lp->flags & LPROPS_INDEX));
+		ubifs_assert(c, !(lp->flags & LPROPS_TAKEN));
+		ubifs_assert(c, !(lp->flags & LPROPS_INDEX));
 		err = ubifs_leb_unmap(c, lp->lnum);
 		if (err)
 			goto out;
@@ -858,8 +858,8 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 			err = PTR_ERR(lp);
 			goto out;
 		}
-		ubifs_assert(!(lp->flags & LPROPS_TAKEN));
-		ubifs_assert(!(lp->flags & LPROPS_INDEX));
+		ubifs_assert(c, !(lp->flags & LPROPS_TAKEN));
+		ubifs_assert(c, !(lp->flags & LPROPS_INDEX));
 	}
 
 	/* Mark GC'd index LEBs OK to unmap after this commit finishes */
@@ -880,8 +880,8 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 			err = -ENOMEM;
 			goto out;
 		}
-		ubifs_assert(!(lp->flags & LPROPS_TAKEN));
-		ubifs_assert(lp->flags & LPROPS_INDEX);
+		ubifs_assert(c, !(lp->flags & LPROPS_TAKEN));
+		ubifs_assert(c, lp->flags & LPROPS_INDEX);
 		/* Don't release the LEB until after the next commit */
 		flags = (lp->flags | LPROPS_TAKEN) ^ LPROPS_INDEX;
 		lp = ubifs_change_lp(c, lp, c->leb_size, 0, flags, 1);
@@ -890,8 +890,8 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 			kfree(idx_gc);
 			goto out;
 		}
-		ubifs_assert(lp->flags & LPROPS_TAKEN);
-		ubifs_assert(!(lp->flags & LPROPS_INDEX));
+		ubifs_assert(c, lp->flags & LPROPS_TAKEN);
+		ubifs_assert(c, !(lp->flags & LPROPS_INDEX));
 		idx_gc->lnum = lp->lnum;
 		idx_gc->unmap = 1;
 		list_add(&idx_gc->list, &c->idx_gc);
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index fe77e9625e84..099bec94b820 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -119,7 +119,7 @@ int ubifs_leb_write(struct ubifs_info *c, int lnum, const void *buf, int offs,
 {
 	int err;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
 	if (!dbg_is_tst_rcvry(c))
@@ -139,7 +139,7 @@ int ubifs_leb_change(struct ubifs_info *c, int lnum, const void *buf, int len)
 {
 	int err;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
 	if (!dbg_is_tst_rcvry(c))
@@ -159,7 +159,7 @@ int ubifs_leb_unmap(struct ubifs_info *c, int lnum)
 {
 	int err;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
 	if (!dbg_is_tst_rcvry(c))
@@ -178,7 +178,7 @@ int ubifs_leb_map(struct ubifs_info *c, int lnum)
 {
 	int err;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
 	if (!dbg_is_tst_rcvry(c))
@@ -241,8 +241,8 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 	uint32_t crc, node_crc, magic;
 	const struct ubifs_ch *ch = buf;
 
-	ubifs_assert(lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(!(offs & 7) && offs < c->leb_size);
+	ubifs_assert(c, lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
+	ubifs_assert(c, !(offs & 7) && offs < c->leb_size);
 
 	magic = le32_to_cpu(ch->magic);
 	if (magic != UBIFS_NODE_MAGIC) {
@@ -319,7 +319,7 @@ void ubifs_pad(const struct ubifs_info *c, void *buf, int pad)
 {
 	uint32_t crc;
 
-	ubifs_assert(pad >= 0 && !(pad & 7));
+	ubifs_assert(c, pad >= 0 && !(pad & 7));
 
 	if (pad >= UBIFS_PAD_NODE_SZ) {
 		struct ubifs_ch *ch = buf;
@@ -382,7 +382,7 @@ void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
 	struct ubifs_ch *ch = node;
 	unsigned long long sqnum = next_sqnum(c);
 
-	ubifs_assert(len >= UBIFS_CH_SZ);
+	ubifs_assert(c, len >= UBIFS_CH_SZ);
 
 	ch->magic = cpu_to_le32(UBIFS_NODE_MAGIC);
 	ch->len = cpu_to_le32(len);
@@ -415,7 +415,7 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
 	struct ubifs_ch *ch = node;
 	unsigned long long sqnum = next_sqnum(c);
 
-	ubifs_assert(len >= UBIFS_CH_SZ);
+	ubifs_assert(c, len >= UBIFS_CH_SZ);
 
 	ch->magic = cpu_to_le32(UBIFS_NODE_MAGIC);
 	ch->len = cpu_to_le32(len);
@@ -448,9 +448,10 @@ static enum hrtimer_restart wbuf_timer_callback_nolock(struct hrtimer *timer)
 
 /**
  * new_wbuf_timer - start new write-buffer timer.
+ * @c: UBIFS file-system description object
  * @wbuf: write-buffer descriptor
  */
-static void new_wbuf_timer_nolock(struct ubifs_wbuf *wbuf)
+static void new_wbuf_timer_nolock(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
 {
 	ktime_t softlimit = ms_to_ktime(dirty_writeback_interval * 10);
 	unsigned long long delta = dirty_writeback_interval;
@@ -458,8 +459,8 @@ static void new_wbuf_timer_nolock(struct ubifs_wbuf *wbuf)
 	/* centi to milli, milli to nano, then 10% */
 	delta *= 10ULL * NSEC_PER_MSEC / 10ULL;
 
-	ubifs_assert(!hrtimer_active(&wbuf->timer));
-	ubifs_assert(delta <= ULONG_MAX);
+	ubifs_assert(c, !hrtimer_active(&wbuf->timer));
+	ubifs_assert(c, delta <= ULONG_MAX);
 
 	if (wbuf->no_timer)
 		return;
@@ -508,14 +509,14 @@ int ubifs_wbuf_sync_nolock(struct ubifs_wbuf *wbuf)
 
 	dbg_io("LEB %d:%d, %d bytes, jhead %s",
 	       wbuf->lnum, wbuf->offs, wbuf->used, dbg_jhead(wbuf->jhead));
-	ubifs_assert(!(wbuf->avail & 7));
-	ubifs_assert(wbuf->offs + wbuf->size <= c->leb_size);
-	ubifs_assert(wbuf->size >= c->min_io_size);
-	ubifs_assert(wbuf->size <= c->max_write_size);
-	ubifs_assert(wbuf->size % c->min_io_size == 0);
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !(wbuf->avail & 7));
+	ubifs_assert(c, wbuf->offs + wbuf->size <= c->leb_size);
+	ubifs_assert(c, wbuf->size >= c->min_io_size);
+	ubifs_assert(c, wbuf->size <= c->max_write_size);
+	ubifs_assert(c, wbuf->size % c->min_io_size == 0);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->leb_size - wbuf->offs >= c->max_write_size)
-		ubifs_assert(!((wbuf->offs + wbuf->size) % c->max_write_size));
+		ubifs_assert(c, !((wbuf->offs + wbuf->size) % c->max_write_size));
 
 	if (c->ro_error)
 		return -EROFS;
@@ -576,11 +577,11 @@ int ubifs_wbuf_seek_nolock(struct ubifs_wbuf *wbuf, int lnum, int offs)
 	const struct ubifs_info *c = wbuf->c;
 
 	dbg_io("LEB %d:%d, jhead %s", lnum, offs, dbg_jhead(wbuf->jhead));
-	ubifs_assert(lnum >= 0 && lnum < c->leb_cnt);
-	ubifs_assert(offs >= 0 && offs <= c->leb_size);
-	ubifs_assert(offs % c->min_io_size == 0 && !(offs & 7));
-	ubifs_assert(lnum != wbuf->lnum);
-	ubifs_assert(wbuf->used == 0);
+	ubifs_assert(c, lnum >= 0 && lnum < c->leb_cnt);
+	ubifs_assert(c, offs >= 0 && offs <= c->leb_size);
+	ubifs_assert(c, offs % c->min_io_size == 0 && !(offs & 7));
+	ubifs_assert(c, lnum != wbuf->lnum);
+	ubifs_assert(c, wbuf->used == 0);
 
 	spin_lock(&wbuf->lock);
 	wbuf->lnum = lnum;
@@ -610,7 +611,7 @@ int ubifs_bg_wbufs_sync(struct ubifs_info *c)
 {
 	int err, i;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (!c->need_wbuf_sync)
 		return 0;
 	c->need_wbuf_sync = 0;
@@ -686,18 +687,18 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 	dbg_io("%d bytes (%s) to jhead %s wbuf at LEB %d:%d", len,
 	       dbg_ntype(((struct ubifs_ch *)buf)->node_type),
 	       dbg_jhead(wbuf->jhead), wbuf->lnum, wbuf->offs + wbuf->used);
-	ubifs_assert(len > 0 && wbuf->lnum >= 0 && wbuf->lnum < c->leb_cnt);
-	ubifs_assert(wbuf->offs >= 0 && wbuf->offs % c->min_io_size == 0);
-	ubifs_assert(!(wbuf->offs & 7) && wbuf->offs <= c->leb_size);
-	ubifs_assert(wbuf->avail > 0 && wbuf->avail <= wbuf->size);
-	ubifs_assert(wbuf->size >= c->min_io_size);
-	ubifs_assert(wbuf->size <= c->max_write_size);
-	ubifs_assert(wbuf->size % c->min_io_size == 0);
-	ubifs_assert(mutex_is_locked(&wbuf->io_mutex));
-	ubifs_assert(!c->ro_media && !c->ro_mount);
-	ubifs_assert(!c->space_fixup);
+	ubifs_assert(c, len > 0 && wbuf->lnum >= 0 && wbuf->lnum < c->leb_cnt);
+	ubifs_assert(c, wbuf->offs >= 0 && wbuf->offs % c->min_io_size == 0);
+	ubifs_assert(c, !(wbuf->offs & 7) && wbuf->offs <= c->leb_size);
+	ubifs_assert(c, wbuf->avail > 0 && wbuf->avail <= wbuf->size);
+	ubifs_assert(c, wbuf->size >= c->min_io_size);
+	ubifs_assert(c, wbuf->size <= c->max_write_size);
+	ubifs_assert(c, wbuf->size % c->min_io_size == 0);
+	ubifs_assert(c, mutex_is_locked(&wbuf->io_mutex));
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->space_fixup);
 	if (c->leb_size - wbuf->offs >= c->max_write_size)
-		ubifs_assert(!((wbuf->offs + wbuf->size) % c->max_write_size));
+		ubifs_assert(c, !((wbuf->offs + wbuf->size) % c->max_write_size));
 
 	if (c->leb_size - wbuf->offs - wbuf->used < aligned_len) {
 		err = -ENOSPC;
@@ -834,7 +835,7 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 	}
 
 	if (wbuf->used)
-		new_wbuf_timer_nolock(wbuf);
+		new_wbuf_timer_nolock(c, wbuf);
 
 	return 0;
 
@@ -869,10 +870,10 @@ int ubifs_write_node(struct ubifs_info *c, void *buf, int len, int lnum,
 	dbg_io("LEB %d:%d, %s, length %d (aligned %d)",
 	       lnum, offs, dbg_ntype(((struct ubifs_ch *)buf)->node_type), len,
 	       buf_len);
-	ubifs_assert(lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(offs % c->min_io_size == 0 && offs < c->leb_size);
-	ubifs_assert(!c->ro_media && !c->ro_mount);
-	ubifs_assert(!c->space_fixup);
+	ubifs_assert(c, lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
+	ubifs_assert(c, offs % c->min_io_size == 0 && offs < c->leb_size);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->space_fixup);
 
 	if (c->ro_error)
 		return -EROFS;
@@ -909,9 +910,9 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 
 	dbg_io("LEB %d:%d, %s, length %d, jhead %s", lnum, offs,
 	       dbg_ntype(type), len, dbg_jhead(wbuf->jhead));
-	ubifs_assert(wbuf && lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(!(offs & 7) && offs < c->leb_size);
-	ubifs_assert(type >= 0 && type < UBIFS_NODE_TYPES_CNT);
+	ubifs_assert(c, wbuf && lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
+	ubifs_assert(c, !(offs & 7) && offs < c->leb_size);
+	ubifs_assert(c, type >= 0 && type < UBIFS_NODE_TYPES_CNT);
 
 	spin_lock(&wbuf->lock);
 	overlap = (lnum == wbuf->lnum && offs + len > wbuf->offs);
@@ -984,10 +985,10 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
 	struct ubifs_ch *ch = buf;
 
 	dbg_io("LEB %d:%d, %s, length %d", lnum, offs, dbg_ntype(type), len);
-	ubifs_assert(lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(len >= UBIFS_CH_SZ && offs + len <= c->leb_size);
-	ubifs_assert(!(offs & 7) && offs < c->leb_size);
-	ubifs_assert(type >= 0 && type < UBIFS_NODE_TYPES_CNT);
+	ubifs_assert(c, lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
+	ubifs_assert(c, len >= UBIFS_CH_SZ && offs + len <= c->leb_size);
+	ubifs_assert(c, !(offs & 7) && offs < c->leb_size);
+	ubifs_assert(c, type >= 0 && type < UBIFS_NODE_TYPES_CNT);
 
 	err = ubifs_leb_read(c, lnum, buf, offs, len, 0);
 	if (err && err != -EBADMSG)
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 07b4956e0425..e7314e798696 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -111,7 +111,7 @@ static int reserve_space(struct ubifs_info *c, int jhead, int len)
 	 * better to try to allocate space at the ends of eraseblocks. This is
 	 * what the squeeze parameter does.
 	 */
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	squeeze = (jhead == BASEHD);
 again:
 	mutex_lock_nested(&wbuf->io_mutex, wbuf->jhead);
@@ -215,7 +215,7 @@ static int reserve_space(struct ubifs_info *c, int jhead, int len)
 
 out_return:
 	/* An error occurred and the LEB has to be returned to lprops */
-	ubifs_assert(err < 0);
+	ubifs_assert(c, err < 0);
 	err1 = ubifs_return_leb(c, lnum);
 	if (err1 && err == -EAGAIN)
 		/*
@@ -246,7 +246,7 @@ static int write_node(struct ubifs_info *c, int jhead, void *node, int len,
 {
 	struct ubifs_wbuf *wbuf = &c->jheads[jhead].wbuf;
 
-	ubifs_assert(jhead != GCHD);
+	ubifs_assert(c, jhead != GCHD);
 
 	*lnum = c->jheads[jhead].wbuf.lnum;
 	*offs = c->jheads[jhead].wbuf.offs + c->jheads[jhead].wbuf.used;
@@ -278,7 +278,7 @@ static int write_head(struct ubifs_info *c, int jhead, void *buf, int len,
 	int err;
 	struct ubifs_wbuf *wbuf = &c->jheads[jhead].wbuf;
 
-	ubifs_assert(jhead != GCHD);
+	ubifs_assert(c, jhead != GCHD);
 
 	*lnum = c->jheads[jhead].wbuf.lnum;
 	*offs = c->jheads[jhead].wbuf.offs + c->jheads[jhead].wbuf.used;
@@ -548,7 +548,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	struct ubifs_ino_node *ino;
 	union ubifs_key dent_key, ino_key;
 
-	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
+	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
 
 	dlen = UBIFS_DENT_NODE_SZ + fname_len(nm) + 1;
 	ilen = UBIFS_INO_NODE_SZ;
@@ -707,7 +707,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 
 	dbg_jnlk(key, "ino %lu, blk %u, len %d, key ",
 		(unsigned long)key_inum(c, key), key_block(c, key), len);
-	ubifs_assert(len <= UBIFS_BLOCK_SIZE);
+	ubifs_assert(c, len <= UBIFS_BLOCK_SIZE);
 
 	if (encrypted)
 		dlen += UBIFS_CIPHER_BLOCK_SIZE;
@@ -738,7 +738,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 
 	out_len = compr_len = dlen - UBIFS_DATA_NODE_SZ;
 	ubifs_compress(c, buf, len, &data->data, &compr_len, &compr_type);
-	ubifs_assert(compr_len <= UBIFS_BLOCK_SIZE);
+	ubifs_assert(c, compr_len <= UBIFS_BLOCK_SIZE);
 
 	if (encrypted) {
 		err = ubifs_encrypt(inode, data, compr_len, &out_len, key_block(c, key));
@@ -898,7 +898,7 @@ int ubifs_jnl_delete_inode(struct ubifs_info *c, const struct inode *inode)
 	int err;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
-	ubifs_assert(inode->i_nlink == 0);
+	ubifs_assert(c, inode->i_nlink == 0);
 
 	if (ui->del_cmtno != c->cmt_no)
 		/* A commit happened for sure */
@@ -953,10 +953,10 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	int twoparents = (fst_dir != snd_dir);
 	void *p;
 
-	ubifs_assert(ubifs_inode(fst_dir)->data_len == 0);
-	ubifs_assert(ubifs_inode(snd_dir)->data_len == 0);
-	ubifs_assert(mutex_is_locked(&ubifs_inode(fst_dir)->ui_mutex));
-	ubifs_assert(mutex_is_locked(&ubifs_inode(snd_dir)->ui_mutex));
+	ubifs_assert(c, ubifs_inode(fst_dir)->data_len == 0);
+	ubifs_assert(c, ubifs_inode(snd_dir)->data_len == 0);
+	ubifs_assert(c, mutex_is_locked(&ubifs_inode(fst_dir)->ui_mutex));
+	ubifs_assert(c, mutex_is_locked(&ubifs_inode(snd_dir)->ui_mutex));
 
 	dlen1 = UBIFS_DENT_NODE_SZ + fname_len(snd_nm) + 1;
 	dlen2 = UBIFS_DENT_NODE_SZ + fname_len(fst_nm) + 1;
@@ -1096,16 +1096,16 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	int move = (old_dir != new_dir);
 	struct ubifs_inode *uninitialized_var(new_ui);
 
-	ubifs_assert(ubifs_inode(old_dir)->data_len == 0);
-	ubifs_assert(ubifs_inode(new_dir)->data_len == 0);
-	ubifs_assert(mutex_is_locked(&ubifs_inode(old_dir)->ui_mutex));
-	ubifs_assert(mutex_is_locked(&ubifs_inode(new_dir)->ui_mutex));
+	ubifs_assert(c, ubifs_inode(old_dir)->data_len == 0);
+	ubifs_assert(c, ubifs_inode(new_dir)->data_len == 0);
+	ubifs_assert(c, mutex_is_locked(&ubifs_inode(old_dir)->ui_mutex));
+	ubifs_assert(c, mutex_is_locked(&ubifs_inode(new_dir)->ui_mutex));
 
 	dlen1 = UBIFS_DENT_NODE_SZ + fname_len(new_nm) + 1;
 	dlen2 = UBIFS_DENT_NODE_SZ + fname_len(old_nm) + 1;
 	if (new_inode) {
 		new_ui = ubifs_inode(new_inode);
-		ubifs_assert(mutex_is_locked(&new_ui->ui_mutex));
+		ubifs_assert(c, mutex_is_locked(&new_ui->ui_mutex));
 		ilen = UBIFS_INO_NODE_SZ;
 		if (!last_reference)
 			ilen += new_ui->data_len;
@@ -1319,7 +1319,7 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 		dn->compr_size = 0;
 	}
 
-	ubifs_assert(out_len <= UBIFS_BLOCK_SIZE);
+	ubifs_assert(c, out_len <= UBIFS_BLOCK_SIZE);
 	dn->compr_type = cpu_to_le16(compr_type);
 	dn->size = cpu_to_le32(*new_len);
 	*new_len = UBIFS_DATA_NODE_SZ + out_len;
@@ -1358,9 +1358,9 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 
 	dbg_jnl("ino %lu, size %lld -> %lld",
 		(unsigned long)inum, old_size, new_size);
-	ubifs_assert(!ui->data_len);
-	ubifs_assert(S_ISREG(inode->i_mode));
-	ubifs_assert(mutex_is_locked(&ui->ui_mutex));
+	ubifs_assert(c, !ui->data_len);
+	ubifs_assert(c, S_ISREG(inode->i_mode));
+	ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 
 	sz = UBIFS_TRUN_NODE_SZ + UBIFS_INO_NODE_SZ +
 	     UBIFS_MAX_DATA_NODE_SZ * WORST_COMPR_FACTOR;
@@ -1488,8 +1488,8 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	int sync = IS_DIRSYNC(host);
 	struct ubifs_inode *host_ui = ubifs_inode(host);
 
-	ubifs_assert(inode->i_nlink == 0);
-	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
+	ubifs_assert(c, inode->i_nlink == 0);
+	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
 
 	/*
 	 * Since we are deleting the inode, we do not bother to attach any data
@@ -1598,9 +1598,9 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	int sync = IS_DIRSYNC(host);
 
 	dbg_jnl("ino %lu, ino %lu", host->i_ino, inode->i_ino);
-	ubifs_assert(host->i_nlink > 0);
-	ubifs_assert(inode->i_nlink > 0);
-	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
+	ubifs_assert(c, host->i_nlink > 0);
+	ubifs_assert(c, inode->i_nlink > 0);
+	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
 
 	len1 = UBIFS_INO_NODE_SZ + host_ui->data_len;
 	len2 = UBIFS_INO_NODE_SZ + ubifs_inode(inode)->data_len;
diff --git a/fs/ubifs/key.h b/fs/ubifs/key.h
index b1f7c0caa3ac..2feff6cbbb77 100644
--- a/fs/ubifs/key.h
+++ b/fs/ubifs/key.h
@@ -161,8 +161,8 @@ static inline void dent_key_init(const struct ubifs_info *c,
 {
 	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
 
-	ubifs_assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
-	ubifs_assert(!nm->hash && !nm->minor_hash);
+	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
+	ubifs_assert(c, !nm->hash && !nm->minor_hash);
 	key->u32[0] = inum;
 	key->u32[1] = hash | (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS);
 }
@@ -179,7 +179,7 @@ static inline void dent_key_init_hash(const struct ubifs_info *c,
 				      union ubifs_key *key, ino_t inum,
 				      uint32_t hash)
 {
-	ubifs_assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
+	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
 	key->u32[0] = inum;
 	key->u32[1] = hash | (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS);
 }
@@ -198,7 +198,7 @@ static inline void dent_key_init_flash(const struct ubifs_info *c, void *k,
 	union ubifs_key *key = k;
 	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
 
-	ubifs_assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
+	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
 	key->j32[0] = cpu_to_le32(inum);
 	key->j32[1] = cpu_to_le32(hash |
 				  (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS));
@@ -231,7 +231,7 @@ static inline void xent_key_init(const struct ubifs_info *c,
 {
 	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
 
-	ubifs_assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
+	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
 	key->u32[0] = inum;
 	key->u32[1] = hash | (UBIFS_XENT_KEY << UBIFS_S_KEY_HASH_BITS);
 }
@@ -249,7 +249,7 @@ static inline void xent_key_init_flash(const struct ubifs_info *c, void *k,
 	union ubifs_key *key = k;
 	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
 
-	ubifs_assert(!(hash & ~UBIFS_S_KEY_HASH_MASK));
+	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
 	key->j32[0] = cpu_to_le32(inum);
 	key->j32[1] = cpu_to_le32(hash |
 				  (UBIFS_XENT_KEY << UBIFS_S_KEY_HASH_BITS));
@@ -280,7 +280,7 @@ static inline void data_key_init(const struct ubifs_info *c,
 				 union ubifs_key *key, ino_t inum,
 				 unsigned int block)
 {
-	ubifs_assert(!(block & ~UBIFS_S_KEY_BLOCK_MASK));
+	ubifs_assert(c, !(block & ~UBIFS_S_KEY_BLOCK_MASK));
 	key->u32[0] = inum;
 	key->u32[1] = block | (UBIFS_DATA_KEY << UBIFS_S_KEY_BLOCK_BITS);
 }
diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 7cffa120a750..86b0828f5499 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -132,7 +132,7 @@ void ubifs_add_bud(struct ubifs_info *c, struct ubifs_bud *bud)
 	while (*p) {
 		parent = *p;
 		b = rb_entry(parent, struct ubifs_bud, rb);
-		ubifs_assert(bud->lnum != b->lnum);
+		ubifs_assert(c, bud->lnum != b->lnum);
 		if (bud->lnum < b->lnum)
 			p = &(*p)->rb_left;
 		else
@@ -145,7 +145,7 @@ void ubifs_add_bud(struct ubifs_info *c, struct ubifs_bud *bud)
 		jhead = &c->jheads[bud->jhead];
 		list_add_tail(&bud->list, &jhead->buds_list);
 	} else
-		ubifs_assert(c->replaying && c->ro_mount);
+		ubifs_assert(c, c->replaying && c->ro_mount);
 
 	/*
 	 * Note, although this is a new bud, we anyway account this space now,
@@ -189,7 +189,7 @@ int ubifs_add_bud_to_log(struct ubifs_info *c, int jhead, int lnum, int offs)
 	}
 
 	mutex_lock(&c->log_mutex);
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error) {
 		err = -EROFS;
 		goto out_unlock;
@@ -244,7 +244,7 @@ int ubifs_add_bud_to_log(struct ubifs_info *c, int jhead, int lnum, int offs)
 
 	if (c->lhead_offs > c->leb_size - c->ref_node_alsz) {
 		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
-		ubifs_assert(c->lhead_lnum != c->ltail_lnum);
+		ubifs_assert(c, c->lhead_lnum != c->ltail_lnum);
 		c->lhead_offs = 0;
 	}
 
@@ -301,7 +301,7 @@ static void remove_buds(struct ubifs_info *c)
 {
 	struct rb_node *p;
 
-	ubifs_assert(list_empty(&c->old_buds));
+	ubifs_assert(c, list_empty(&c->old_buds));
 	c->cmt_bud_bytes = 0;
 	spin_lock(&c->buds_lock);
 	p = rb_first(&c->buds);
@@ -409,7 +409,7 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 	/* Switch to the next log LEB */
 	if (c->lhead_offs) {
 		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
-		ubifs_assert(c->lhead_lnum != c->ltail_lnum);
+		ubifs_assert(c, c->lhead_lnum != c->ltail_lnum);
 		c->lhead_offs = 0;
 	}
 
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index f5a46844340c..e7e77a823009 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -187,9 +187,9 @@ static int add_to_lpt_heap(struct ubifs_info *c, struct ubifs_lprops *lprops,
 		/* Compare to some other LEB on the bottom of heap */
 		/* Pick a position kind of randomly */
 		cpos = (((size_t)lprops >> 4) & b) + b;
-		ubifs_assert(cpos >= b);
-		ubifs_assert(cpos < LPT_HEAP_SZ);
-		ubifs_assert(cpos < heap->cnt);
+		ubifs_assert(c, cpos >= b);
+		ubifs_assert(c, cpos < LPT_HEAP_SZ);
+		ubifs_assert(c, cpos < heap->cnt);
 
 		val1 = get_heap_comp_val(lprops, cat);
 		val2 = get_heap_comp_val(heap->arr[cpos], cat);
@@ -230,8 +230,8 @@ static void remove_from_lpt_heap(struct ubifs_info *c,
 	int hpos = lprops->hpos;
 
 	heap = &c->lpt_heap[cat - 1];
-	ubifs_assert(hpos >= 0 && hpos < heap->cnt);
-	ubifs_assert(heap->arr[hpos] == lprops);
+	ubifs_assert(c, hpos >= 0 && hpos < heap->cnt);
+	ubifs_assert(c, heap->arr[hpos] == lprops);
 	heap->cnt -= 1;
 	if (hpos < heap->cnt) {
 		heap->arr[hpos] = heap->arr[heap->cnt];
@@ -296,13 +296,13 @@ void ubifs_add_to_cat(struct ubifs_info *c, struct ubifs_lprops *lprops,
 		list_add(&lprops->list, &c->frdi_idx_list);
 		break;
 	default:
-		ubifs_assert(0);
+		ubifs_assert(c, 0);
 	}
 
 	lprops->flags &= ~LPROPS_CAT_MASK;
 	lprops->flags |= cat;
 	c->in_a_category_cnt += 1;
-	ubifs_assert(c->in_a_category_cnt <= c->main_lebs);
+	ubifs_assert(c, c->in_a_category_cnt <= c->main_lebs);
 }
 
 /**
@@ -324,20 +324,20 @@ static void ubifs_remove_from_cat(struct ubifs_info *c,
 		break;
 	case LPROPS_FREEABLE:
 		c->freeable_cnt -= 1;
-		ubifs_assert(c->freeable_cnt >= 0);
+		ubifs_assert(c, c->freeable_cnt >= 0);
 		/* Fall through */
 	case LPROPS_UNCAT:
 	case LPROPS_EMPTY:
 	case LPROPS_FRDI_IDX:
-		ubifs_assert(!list_empty(&lprops->list));
+		ubifs_assert(c, !list_empty(&lprops->list));
 		list_del(&lprops->list);
 		break;
 	default:
-		ubifs_assert(0);
+		ubifs_assert(c, 0);
 	}
 
 	c->in_a_category_cnt -= 1;
-	ubifs_assert(c->in_a_category_cnt >= 0);
+	ubifs_assert(c, c->in_a_category_cnt >= 0);
 }
 
 /**
@@ -369,7 +369,7 @@ void ubifs_replace_cat(struct ubifs_info *c, struct ubifs_lprops *old_lprops,
 		list_replace(&old_lprops->list, &new_lprops->list);
 		break;
 	default:
-		ubifs_assert(0);
+		ubifs_assert(c, 0);
 	}
 }
 
@@ -412,7 +412,7 @@ int ubifs_categorize_lprops(const struct ubifs_info *c,
 		return LPROPS_UNCAT;
 
 	if (lprops->free == c->leb_size) {
-		ubifs_assert(!(lprops->flags & LPROPS_INDEX));
+		ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
 		return LPROPS_EMPTY;
 	}
 
@@ -478,7 +478,7 @@ static void change_category(struct ubifs_info *c, struct ubifs_lprops *lprops)
  */
 int ubifs_calc_dark(const struct ubifs_info *c, int spc)
 {
-	ubifs_assert(!(spc & 7));
+	ubifs_assert(c, !(spc & 7));
 
 	if (spc < c->dark_wm)
 		return spc;
@@ -543,27 +543,27 @@ const struct ubifs_lprops *ubifs_change_lp(struct ubifs_info *c,
 	dbg_lp("LEB %d, free %d, dirty %d, flags %d",
 	       lprops->lnum, free, dirty, flags);
 
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
-	ubifs_assert(c->lst.empty_lebs >= 0 &&
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, c->lst.empty_lebs >= 0 &&
 		     c->lst.empty_lebs <= c->main_lebs);
-	ubifs_assert(c->freeable_cnt >= 0);
-	ubifs_assert(c->freeable_cnt <= c->main_lebs);
-	ubifs_assert(c->lst.taken_empty_lebs >= 0);
-	ubifs_assert(c->lst.taken_empty_lebs <= c->lst.empty_lebs);
-	ubifs_assert(!(c->lst.total_free & 7) && !(c->lst.total_dirty & 7));
-	ubifs_assert(!(c->lst.total_dead & 7) && !(c->lst.total_dark & 7));
-	ubifs_assert(!(c->lst.total_used & 7));
-	ubifs_assert(free == LPROPS_NC || free >= 0);
-	ubifs_assert(dirty == LPROPS_NC || dirty >= 0);
+	ubifs_assert(c, c->freeable_cnt >= 0);
+	ubifs_assert(c, c->freeable_cnt <= c->main_lebs);
+	ubifs_assert(c, c->lst.taken_empty_lebs >= 0);
+	ubifs_assert(c, c->lst.taken_empty_lebs <= c->lst.empty_lebs);
+	ubifs_assert(c, !(c->lst.total_free & 7) && !(c->lst.total_dirty & 7));
+	ubifs_assert(c, !(c->lst.total_dead & 7) && !(c->lst.total_dark & 7));
+	ubifs_assert(c, !(c->lst.total_used & 7));
+	ubifs_assert(c, free == LPROPS_NC || free >= 0);
+	ubifs_assert(c, dirty == LPROPS_NC || dirty >= 0);
 
 	if (!is_lprops_dirty(c, lprops)) {
 		lprops = ubifs_lpt_lookup_dirty(c, lprops->lnum);
 		if (IS_ERR(lprops))
 			return lprops;
 	} else
-		ubifs_assert(lprops == ubifs_lpt_lookup_dirty(c, lprops->lnum));
+		ubifs_assert(c, lprops == ubifs_lpt_lookup_dirty(c, lprops->lnum));
 
-	ubifs_assert(!(lprops->free & 7) && !(lprops->dirty & 7));
+	ubifs_assert(c, !(lprops->free & 7) && !(lprops->dirty & 7));
 
 	spin_lock(&c->space_lock);
 	if ((lprops->flags & LPROPS_TAKEN) && lprops->free == c->leb_size)
@@ -768,15 +768,15 @@ const struct ubifs_lprops *ubifs_fast_find_free(struct ubifs_info *c)
 	struct ubifs_lprops *lprops;
 	struct ubifs_lpt_heap *heap;
 
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
 
 	heap = &c->lpt_heap[LPROPS_FREE - 1];
 	if (heap->cnt == 0)
 		return NULL;
 
 	lprops = heap->arr[0];
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
 	return lprops;
 }
 
@@ -791,15 +791,15 @@ const struct ubifs_lprops *ubifs_fast_find_empty(struct ubifs_info *c)
 {
 	struct ubifs_lprops *lprops;
 
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
 
 	if (list_empty(&c->empty_list))
 		return NULL;
 
 	lprops = list_entry(c->empty_list.next, struct ubifs_lprops, list);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!(lprops->flags & LPROPS_INDEX));
-	ubifs_assert(lprops->free == c->leb_size);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->free == c->leb_size);
 	return lprops;
 }
 
@@ -814,16 +814,16 @@ const struct ubifs_lprops *ubifs_fast_find_freeable(struct ubifs_info *c)
 {
 	struct ubifs_lprops *lprops;
 
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
 
 	if (list_empty(&c->freeable_list))
 		return NULL;
 
 	lprops = list_entry(c->freeable_list.next, struct ubifs_lprops, list);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert(!(lprops->flags & LPROPS_INDEX));
-	ubifs_assert(lprops->free + lprops->dirty == c->leb_size);
-	ubifs_assert(c->freeable_cnt > 0);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, !(lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->free + lprops->dirty == c->leb_size);
+	ubifs_assert(c, c->freeable_cnt > 0);
 	return lprops;
 }
 
@@ -838,15 +838,15 @@ const struct ubifs_lprops *ubifs_fast_find_frdi_idx(struct ubifs_info *c)
 {
 	struct ubifs_lprops *lprops;
 
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
 
 	if (list_empty(&c->frdi_idx_list))
 		return NULL;
 
 	lprops = list_entry(c->frdi_idx_list.next, struct ubifs_lprops, list);
-	ubifs_assert(!(lprops->flags & LPROPS_TAKEN));
-	ubifs_assert((lprops->flags & LPROPS_INDEX));
-	ubifs_assert(lprops->free + lprops->dirty == c->leb_size);
+	ubifs_assert(c, !(lprops->flags & LPROPS_TAKEN));
+	ubifs_assert(c, (lprops->flags & LPROPS_INDEX));
+	ubifs_assert(c, lprops->free + lprops->dirty == c->leb_size);
 	return lprops;
 }
 
diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 8e99dad18880..31393370e334 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -225,21 +225,22 @@ static int calc_dflt_lpt_geom(struct ubifs_info *c, int *main_lebs,
 
 /**
  * pack_bits - pack bit fields end-to-end.
+ * @c: UBIFS file-system description object
  * @addr: address at which to pack (passed and next address returned)
  * @pos: bit position at which to pack (passed and next position returned)
  * @val: value to pack
  * @nrbits: number of bits of value to pack (1-32)
  */
-static void pack_bits(uint8_t **addr, int *pos, uint32_t val, int nrbits)
+static void pack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos, uint32_t val, int nrbits)
 {
 	uint8_t *p = *addr;
 	int b = *pos;
 
-	ubifs_assert(nrbits > 0);
-	ubifs_assert(nrbits <= 32);
-	ubifs_assert(*pos >= 0);
-	ubifs_assert(*pos < 8);
-	ubifs_assert((val >> nrbits) == 0 || nrbits == 32);
+	ubifs_assert(c, nrbits > 0);
+	ubifs_assert(c, nrbits <= 32);
+	ubifs_assert(c, *pos >= 0);
+	ubifs_assert(c, *pos < 8);
+	ubifs_assert(c, (val >> nrbits) == 0 || nrbits == 32);
 	if (b) {
 		*p |= ((uint8_t)val) << b;
 		nrbits += b;
@@ -274,13 +275,14 @@ static void pack_bits(uint8_t **addr, int *pos, uint32_t val, int nrbits)
 
 /**
  * ubifs_unpack_bits - unpack bit fields.
+ * @c: UBIFS file-system description object
  * @addr: address at which to unpack (passed and next address returned)
  * @pos: bit position at which to unpack (passed and next position returned)
  * @nrbits: number of bits of value to unpack (1-32)
  *
  * This functions returns the value unpacked.
  */
-uint32_t ubifs_unpack_bits(uint8_t **addr, int *pos, int nrbits)
+uint32_t ubifs_unpack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos, int nrbits)
 {
 	const int k = 32 - nrbits;
 	uint8_t *p = *addr;
@@ -288,10 +290,10 @@ uint32_t ubifs_unpack_bits(uint8_t **addr, int *pos, int nrbits)
 	uint32_t uninitialized_var(val);
 	const int bytes = (nrbits + b + 7) >> 3;
 
-	ubifs_assert(nrbits > 0);
-	ubifs_assert(nrbits <= 32);
-	ubifs_assert(*pos >= 0);
-	ubifs_assert(*pos < 8);
+	ubifs_assert(c, nrbits > 0);
+	ubifs_assert(c, nrbits <= 32);
+	ubifs_assert(c, *pos >= 0);
+	ubifs_assert(c, *pos < 8);
 	if (b) {
 		switch (bytes) {
 		case 2:
@@ -337,7 +339,7 @@ uint32_t ubifs_unpack_bits(uint8_t **addr, int *pos, int nrbits)
 	p += nrbits >> 3;
 	*addr = p;
 	*pos = b;
-	ubifs_assert((val >> nrbits) == 0 || nrbits - b == 32);
+	ubifs_assert(c, (val >> nrbits) == 0 || nrbits - b == 32);
 	return val;
 }
 
@@ -354,24 +356,24 @@ void ubifs_pack_pnode(struct ubifs_info *c, void *buf,
 	int i, pos = 0;
 	uint16_t crc;
 
-	pack_bits(&addr, &pos, UBIFS_LPT_PNODE, UBIFS_LPT_TYPE_BITS);
+	pack_bits(c, &addr, &pos, UBIFS_LPT_PNODE, UBIFS_LPT_TYPE_BITS);
 	if (c->big_lpt)
-		pack_bits(&addr, &pos, pnode->num, c->pcnt_bits);
+		pack_bits(c, &addr, &pos, pnode->num, c->pcnt_bits);
 	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
-		pack_bits(&addr, &pos, pnode->lprops[i].free >> 3,
+		pack_bits(c, &addr, &pos, pnode->lprops[i].free >> 3,
 			  c->space_bits);
-		pack_bits(&addr, &pos, pnode->lprops[i].dirty >> 3,
+		pack_bits(c, &addr, &pos, pnode->lprops[i].dirty >> 3,
 			  c->space_bits);
 		if (pnode->lprops[i].flags & LPROPS_INDEX)
-			pack_bits(&addr, &pos, 1, 1);
+			pack_bits(c, &addr, &pos, 1, 1);
 		else
-			pack_bits(&addr, &pos, 0, 1);
+			pack_bits(c, &addr, &pos, 0, 1);
 	}
 	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 		    c->pnode_sz - UBIFS_LPT_CRC_BYTES);
 	addr = buf;
 	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
+	pack_bits(c, &addr, &pos, crc, UBIFS_LPT_CRC_BITS);
 }
 
 /**
@@ -387,23 +389,23 @@ void ubifs_pack_nnode(struct ubifs_info *c, void *buf,
 	int i, pos = 0;
 	uint16_t crc;
 
-	pack_bits(&addr, &pos, UBIFS_LPT_NNODE, UBIFS_LPT_TYPE_BITS);
+	pack_bits(c, &addr, &pos, UBIFS_LPT_NNODE, UBIFS_LPT_TYPE_BITS);
 	if (c->big_lpt)
-		pack_bits(&addr, &pos, nnode->num, c->pcnt_bits);
+		pack_bits(c, &addr, &pos, nnode->num, c->pcnt_bits);
 	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
 		int lnum = nnode->nbranch[i].lnum;
 
 		if (lnum == 0)
 			lnum = c->lpt_last + 1;
-		pack_bits(&addr, &pos, lnum - c->lpt_first, c->lpt_lnum_bits);
-		pack_bits(&addr, &pos, nnode->nbranch[i].offs,
+		pack_bits(c, &addr, &pos, lnum - c->lpt_first, c->lpt_lnum_bits);
+		pack_bits(c, &addr, &pos, nnode->nbranch[i].offs,
 			  c->lpt_offs_bits);
 	}
 	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 		    c->nnode_sz - UBIFS_LPT_CRC_BYTES);
 	addr = buf;
 	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
+	pack_bits(c, &addr, &pos, crc, UBIFS_LPT_CRC_BITS);
 }
 
 /**
@@ -419,16 +421,16 @@ void ubifs_pack_ltab(struct ubifs_info *c, void *buf,
 	int i, pos = 0;
 	uint16_t crc;
 
-	pack_bits(&addr, &pos, UBIFS_LPT_LTAB, UBIFS_LPT_TYPE_BITS);
+	pack_bits(c, &addr, &pos, UBIFS_LPT_LTAB, UBIFS_LPT_TYPE_BITS);
 	for (i = 0; i < c->lpt_lebs; i++) {
-		pack_bits(&addr, &pos, ltab[i].free, c->lpt_spc_bits);
-		pack_bits(&addr, &pos, ltab[i].dirty, c->lpt_spc_bits);
+		pack_bits(c, &addr, &pos, ltab[i].free, c->lpt_spc_bits);
+		pack_bits(c, &addr, &pos, ltab[i].dirty, c->lpt_spc_bits);
 	}
 	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 		    c->ltab_sz - UBIFS_LPT_CRC_BYTES);
 	addr = buf;
 	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
+	pack_bits(c, &addr, &pos, crc, UBIFS_LPT_CRC_BITS);
 }
 
 /**
@@ -443,14 +445,14 @@ void ubifs_pack_lsave(struct ubifs_info *c, void *buf, int *lsave)
 	int i, pos = 0;
 	uint16_t crc;
 
-	pack_bits(&addr, &pos, UBIFS_LPT_LSAVE, UBIFS_LPT_TYPE_BITS);
+	pack_bits(c, &addr, &pos, UBIFS_LPT_LSAVE, UBIFS_LPT_TYPE_BITS);
 	for (i = 0; i < c->lsave_cnt; i++)
-		pack_bits(&addr, &pos, lsave[i], c->lnum_bits);
+		pack_bits(c, &addr, &pos, lsave[i], c->lnum_bits);
 	crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 		    c->lsave_sz - UBIFS_LPT_CRC_BYTES);
 	addr = buf;
 	pos = 0;
-	pack_bits(&addr, &pos, crc, UBIFS_LPT_CRC_BITS);
+	pack_bits(c, &addr, &pos, crc, UBIFS_LPT_CRC_BITS);
 }
 
 /**
@@ -465,7 +467,7 @@ void ubifs_add_lpt_dirt(struct ubifs_info *c, int lnum, int dirty)
 		return;
 	dbg_lp("LEB %d add %d to %d",
 	       lnum, dirty, c->ltab[lnum - c->lpt_first].dirty);
-	ubifs_assert(lnum >= c->lpt_first && lnum <= c->lpt_last);
+	ubifs_assert(c, lnum >= c->lpt_first && lnum <= c->lpt_last);
 	c->ltab[lnum - c->lpt_first].dirty += dirty;
 }
 
@@ -481,7 +483,7 @@ static void set_ltab(struct ubifs_info *c, int lnum, int free, int dirty)
 	dbg_lp("LEB %d free %d dirty %d to %d %d",
 	       lnum, c->ltab[lnum - c->lpt_first].free,
 	       c->ltab[lnum - c->lpt_first].dirty, free, dirty);
-	ubifs_assert(lnum >= c->lpt_first && lnum <= c->lpt_last);
+	ubifs_assert(c, lnum >= c->lpt_first && lnum <= c->lpt_last);
 	c->ltab[lnum - c->lpt_first].free = free;
 	c->ltab[lnum - c->lpt_first].dirty = dirty;
 }
@@ -639,7 +641,7 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
 		goto out;
 	}
 
-	ubifs_assert(!c->ltab);
+	ubifs_assert(c, !c->ltab);
 	c->ltab = ltab; /* Needed by set_ltab */
 
 	/* Initialize LPT's own lprops */
@@ -918,7 +920,7 @@ static int check_lpt_crc(const struct ubifs_info *c, void *buf, int len)
 	uint8_t *addr = buf;
 	uint16_t crc, calc_crc;
 
-	crc = ubifs_unpack_bits(&addr, &pos, UBIFS_LPT_CRC_BITS);
+	crc = ubifs_unpack_bits(c, &addr, &pos, UBIFS_LPT_CRC_BITS);
 	calc_crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 			 len - UBIFS_LPT_CRC_BYTES);
 	if (crc != calc_crc) {
@@ -944,7 +946,7 @@ static int check_lpt_type(const struct ubifs_info *c, uint8_t **addr,
 {
 	int node_type;
 
-	node_type = ubifs_unpack_bits(addr, pos, UBIFS_LPT_TYPE_BITS);
+	node_type = ubifs_unpack_bits(c, addr, pos, UBIFS_LPT_TYPE_BITS);
 	if (node_type != type) {
 		ubifs_err(c, "invalid type (%d) in LPT node type %d",
 			  node_type, type);
@@ -972,16 +974,16 @@ static int unpack_pnode(const struct ubifs_info *c, void *buf,
 	if (err)
 		return err;
 	if (c->big_lpt)
-		pnode->num = ubifs_unpack_bits(&addr, &pos, c->pcnt_bits);
+		pnode->num = ubifs_unpack_bits(c, &addr, &pos, c->pcnt_bits);
 	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
 		struct ubifs_lprops * const lprops = &pnode->lprops[i];
 
-		lprops->free = ubifs_unpack_bits(&addr, &pos, c->space_bits);
+		lprops->free = ubifs_unpack_bits(c, &addr, &pos, c->space_bits);
 		lprops->free <<= 3;
-		lprops->dirty = ubifs_unpack_bits(&addr, &pos, c->space_bits);
+		lprops->dirty = ubifs_unpack_bits(c, &addr, &pos, c->space_bits);
 		lprops->dirty <<= 3;
 
-		if (ubifs_unpack_bits(&addr, &pos, 1))
+		if (ubifs_unpack_bits(c, &addr, &pos, 1))
 			lprops->flags = LPROPS_INDEX;
 		else
 			lprops->flags = 0;
@@ -1009,16 +1011,16 @@ int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
 	if (err)
 		return err;
 	if (c->big_lpt)
-		nnode->num = ubifs_unpack_bits(&addr, &pos, c->pcnt_bits);
+		nnode->num = ubifs_unpack_bits(c, &addr, &pos, c->pcnt_bits);
 	for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
 		int lnum;
 
-		lnum = ubifs_unpack_bits(&addr, &pos, c->lpt_lnum_bits) +
+		lnum = ubifs_unpack_bits(c, &addr, &pos, c->lpt_lnum_bits) +
 		       c->lpt_first;
 		if (lnum == c->lpt_last + 1)
 			lnum = 0;
 		nnode->nbranch[i].lnum = lnum;
-		nnode->nbranch[i].offs = ubifs_unpack_bits(&addr, &pos,
+		nnode->nbranch[i].offs = ubifs_unpack_bits(c, &addr, &pos,
 						     c->lpt_offs_bits);
 	}
 	err = check_lpt_crc(c, buf, c->nnode_sz);
@@ -1041,8 +1043,8 @@ static int unpack_ltab(const struct ubifs_info *c, void *buf)
 	if (err)
 		return err;
 	for (i = 0; i < c->lpt_lebs; i++) {
-		int free = ubifs_unpack_bits(&addr, &pos, c->lpt_spc_bits);
-		int dirty = ubifs_unpack_bits(&addr, &pos, c->lpt_spc_bits);
+		int free = ubifs_unpack_bits(c, &addr, &pos, c->lpt_spc_bits);
+		int dirty = ubifs_unpack_bits(c, &addr, &pos, c->lpt_spc_bits);
 
 		if (free < 0 || free > c->leb_size || dirty < 0 ||
 		    dirty > c->leb_size || free + dirty > c->leb_size)
@@ -1073,7 +1075,7 @@ static int unpack_lsave(const struct ubifs_info *c, void *buf)
 	if (err)
 		return err;
 	for (i = 0; i < c->lsave_cnt; i++) {
-		int lnum = ubifs_unpack_bits(&addr, &pos, c->lnum_bits);
+		int lnum = ubifs_unpack_bits(c, &addr, &pos, c->lnum_bits);
 
 		if (lnum < c->main_first || lnum >= c->leb_cnt)
 			return -EINVAL;
@@ -1515,7 +1517,7 @@ static struct ubifs_nnode *dirty_cow_nnode(struct ubifs_info *c,
 			branch->cnode->parent = n;
 	}
 
-	ubifs_assert(!test_bit(OBSOLETE_CNODE, &nnode->flags));
+	ubifs_assert(c, !test_bit(OBSOLETE_CNODE, &nnode->flags));
 	__set_bit(OBSOLETE_CNODE, &nnode->flags);
 
 	c->dirty_nn_cnt += 1;
@@ -1558,7 +1560,7 @@ static struct ubifs_pnode *dirty_cow_pnode(struct ubifs_info *c,
 	__clear_bit(COW_CNODE, &p->flags);
 	replace_cats(c, pnode, p);
 
-	ubifs_assert(!test_bit(OBSOLETE_CNODE, &pnode->flags));
+	ubifs_assert(c, !test_bit(OBSOLETE_CNODE, &pnode->flags));
 	__set_bit(OBSOLETE_CNODE, &pnode->flags);
 
 	c->dirty_pn_cnt += 1;
@@ -1613,7 +1615,7 @@ struct ubifs_lprops *ubifs_lpt_lookup_dirty(struct ubifs_info *c, int lnum)
 	dbg_lp("LEB %d, free %d, dirty %d, flags %d", lnum,
 	       pnode->lprops[iip].free, pnode->lprops[iip].dirty,
 	       pnode->lprops[iip].flags);
-	ubifs_assert(test_bit(DIRTY_CNODE, &pnode->flags));
+	ubifs_assert(c, test_bit(DIRTY_CNODE, &pnode->flags));
 	return &pnode->lprops[iip];
 }
 
@@ -1889,9 +1891,9 @@ static struct ubifs_pnode *scan_get_pnode(struct ubifs_info *c,
 			lprops->flags = ubifs_categorize_lprops(c, lprops);
 		}
 	} else {
-		ubifs_assert(branch->lnum >= c->lpt_first &&
+		ubifs_assert(c, branch->lnum >= c->lpt_first &&
 			     branch->lnum <= c->lpt_last);
-		ubifs_assert(branch->offs >= 0 && branch->offs < c->leb_size);
+		ubifs_assert(c, branch->offs >= 0 && branch->offs < c->leb_size);
 		err = ubifs_leb_read(c, branch->lnum, buf, branch->offs,
 				     c->pnode_sz, 1);
 		if (err)
@@ -1935,8 +1937,8 @@ int ubifs_lpt_scan_nolock(struct ubifs_info *c, int start_lnum, int end_lnum,
 			start_lnum = c->main_first;
 	}
 
-	ubifs_assert(start_lnum >= c->main_first && start_lnum < c->leb_cnt);
-	ubifs_assert(end_lnum >= c->main_first && end_lnum < c->leb_cnt);
+	ubifs_assert(c, start_lnum >= c->main_first && start_lnum < c->leb_cnt);
+	ubifs_assert(c, end_lnum >= c->main_first && end_lnum < c->leb_cnt);
 
 	if (!c->nroot) {
 		err = ubifs_read_nnode(c, NULL, 0);
@@ -2055,7 +2057,7 @@ int ubifs_lpt_scan_nolock(struct ubifs_info *c, int start_lnum, int end_lnum,
 		iip = pnode->iip;
 		while (1) {
 			h -= 1;
-			ubifs_assert(h >= 0);
+			ubifs_assert(c, h >= 0);
 			nnode = path[h].ptr.nnode;
 			if (iip + 1 < UBIFS_LPT_FANOUT)
 				break;
@@ -2234,7 +2236,7 @@ int dbg_check_lpt_nodes(struct ubifs_info *c, struct ubifs_cnode *cnode,
 		return 0;
 
 	while (cnode) {
-		ubifs_assert(row >= 0);
+		ubifs_assert(c, row >= 0);
 		nnode = cnode->parent;
 		if (cnode->level) {
 			/* cnode is a nnode */
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index 78da65b2fb85..7ce30994bbba 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -34,13 +34,14 @@ static int dbg_populate_lsave(struct ubifs_info *c);
 
 /**
  * first_dirty_cnode - find first dirty cnode.
+ * @c: UBIFS file-system description object
  * @nnode: nnode at which to start
  *
  * This function returns the first dirty cnode or %NULL if there is not one.
  */
-static struct ubifs_cnode *first_dirty_cnode(struct ubifs_nnode *nnode)
+static struct ubifs_cnode *first_dirty_cnode(const struct ubifs_info *c, struct ubifs_nnode *nnode)
 {
-	ubifs_assert(nnode);
+	ubifs_assert(c, nnode);
 	while (1) {
 		int i, cont = 0;
 
@@ -64,16 +65,17 @@ static struct ubifs_cnode *first_dirty_cnode(struct ubifs_nnode *nnode)
 
 /**
  * next_dirty_cnode - find next dirty cnode.
+ * @c: UBIFS file-system description object
  * @cnode: cnode from which to begin searching
  *
  * This function returns the next dirty cnode or %NULL if there is not one.
  */
-static struct ubifs_cnode *next_dirty_cnode(struct ubifs_cnode *cnode)
+static struct ubifs_cnode *next_dirty_cnode(const struct ubifs_info *c, struct ubifs_cnode *cnode)
 {
 	struct ubifs_nnode *nnode;
 	int i;
 
-	ubifs_assert(cnode);
+	ubifs_assert(c, cnode);
 	nnode = cnode->parent;
 	if (!nnode)
 		return NULL;
@@ -83,7 +85,7 @@ static struct ubifs_cnode *next_dirty_cnode(struct ubifs_cnode *cnode)
 			if (cnode->level == 0)
 				return cnode; /* cnode is a pnode */
 			/* cnode is a nnode */
-			return first_dirty_cnode((struct ubifs_nnode *)cnode);
+			return first_dirty_cnode(c, (struct ubifs_nnode *)cnode);
 		}
 	}
 	return (struct ubifs_cnode *)nnode;
@@ -106,15 +108,15 @@ static int get_cnodes_to_commit(struct ubifs_info *c)
 	if (!test_bit(DIRTY_CNODE, &c->nroot->flags))
 		return 0;
 
-	c->lpt_cnext = first_dirty_cnode(c->nroot);
+	c->lpt_cnext = first_dirty_cnode(c, c->nroot);
 	cnode = c->lpt_cnext;
 	if (!cnode)
 		return 0;
 	cnt += 1;
 	while (1) {
-		ubifs_assert(!test_bit(COW_CNODE, &cnode->flags));
+		ubifs_assert(c, !test_bit(COW_CNODE, &cnode->flags));
 		__set_bit(COW_CNODE, &cnode->flags);
-		cnext = next_dirty_cnode(cnode);
+		cnext = next_dirty_cnode(c, cnode);
 		if (!cnext) {
 			cnode->cnext = c->lpt_cnext;
 			break;
@@ -125,7 +127,7 @@ static int get_cnodes_to_commit(struct ubifs_info *c)
 	}
 	dbg_cmt("committing %d cnodes", cnt);
 	dbg_lp("committing %d cnodes", cnt);
-	ubifs_assert(cnt == c->dirty_nn_cnt + c->dirty_pn_cnt);
+	ubifs_assert(c, cnt == c->dirty_nn_cnt + c->dirty_pn_cnt);
 	return cnt;
 }
 
@@ -141,7 +143,7 @@ static void upd_ltab(struct ubifs_info *c, int lnum, int free, int dirty)
 	dbg_lp("LEB %d free %d dirty %d to %d +%d",
 	       lnum, c->ltab[lnum - c->lpt_first].free,
 	       c->ltab[lnum - c->lpt_first].dirty, free, dirty);
-	ubifs_assert(lnum >= c->lpt_first && lnum <= c->lpt_last);
+	ubifs_assert(c, lnum >= c->lpt_first && lnum <= c->lpt_last);
 	c->ltab[lnum - c->lpt_first].free = free;
 	c->ltab[lnum - c->lpt_first].dirty += dirty;
 }
@@ -237,7 +239,7 @@ static int layout_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 			/* Try to place lsave and ltab nicely */
 			if (!done_lsave) {
@@ -280,7 +282,7 @@ static int layout_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 		}
 		done_lsave = 1;
@@ -300,7 +302,7 @@ static int layout_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 		}
 		c->ltab_lnum = lnum;
@@ -423,7 +425,7 @@ static int write_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = from = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 			err = ubifs_leb_unmap(c, lnum);
 			if (err)
@@ -480,7 +482,7 @@ static int write_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = from = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 			err = ubifs_leb_unmap(c, lnum);
 			if (err)
@@ -506,7 +508,7 @@ static int write_cnodes(struct ubifs_info *c)
 			if (err)
 				goto no_space;
 			offs = from = 0;
-			ubifs_assert(lnum >= c->lpt_first &&
+			ubifs_assert(c, lnum >= c->lpt_first &&
 				     lnum <= c->lpt_last);
 			err = ubifs_leb_unmap(c, lnum);
 			if (err)
@@ -806,7 +808,7 @@ static void populate_lsave(struct ubifs_info *c)
 	struct ubifs_lpt_heap *heap;
 	int i, cnt = 0;
 
-	ubifs_assert(c->big_lpt);
+	ubifs_assert(c, c->big_lpt);
 	if (!(c->lpt_drty_flgs & LSAVE_DIRTY)) {
 		c->lpt_drty_flgs |= LSAVE_DIRTY;
 		ubifs_add_lpt_dirt(c, c->lsave_lnum, c->lsave_sz);
@@ -1095,8 +1097,8 @@ static int get_lpt_node_type(const struct ubifs_info *c, uint8_t *buf,
 	uint8_t *addr = buf + UBIFS_LPT_CRC_BYTES;
 	int pos = 0, node_type;
 
-	node_type = ubifs_unpack_bits(&addr, &pos, UBIFS_LPT_TYPE_BITS);
-	*node_num = ubifs_unpack_bits(&addr, &pos, c->pcnt_bits);
+	node_type = ubifs_unpack_bits(c, &addr, &pos, UBIFS_LPT_TYPE_BITS);
+	*node_num = ubifs_unpack_bits(c, &addr, &pos, c->pcnt_bits);
 	return node_type;
 }
 
@@ -1116,7 +1118,7 @@ static int is_a_node(const struct ubifs_info *c, uint8_t *buf, int len)
 
 	if (len < UBIFS_LPT_CRC_BYTES + (UBIFS_LPT_TYPE_BITS + 7) / 8)
 		return 0;
-	node_type = ubifs_unpack_bits(&addr, &pos, UBIFS_LPT_TYPE_BITS);
+	node_type = ubifs_unpack_bits(c, &addr, &pos, UBIFS_LPT_TYPE_BITS);
 	if (node_type == UBIFS_LPT_NOT_A_NODE)
 		return 0;
 	node_len = get_lpt_node_len(c, node_type);
@@ -1124,7 +1126,7 @@ static int is_a_node(const struct ubifs_info *c, uint8_t *buf, int len)
 		return 0;
 	pos = 0;
 	addr = buf;
-	crc = ubifs_unpack_bits(&addr, &pos, UBIFS_LPT_CRC_BITS);
+	crc = ubifs_unpack_bits(c, &addr, &pos, UBIFS_LPT_CRC_BITS);
 	calc_crc = crc16(-1, buf + UBIFS_LPT_CRC_BYTES,
 			 node_len - UBIFS_LPT_CRC_BYTES);
 	if (crc != calc_crc)
@@ -1170,7 +1172,7 @@ static int lpt_gc_lnum(struct ubifs_info *c, int lnum)
 		node_type = get_lpt_node_type(c, buf, &node_num);
 		node_len = get_lpt_node_len(c, node_type);
 		offs = c->leb_size - len;
-		ubifs_assert(node_len != 0);
+		ubifs_assert(c, node_len != 0);
 		mutex_lock(&c->lp_mutex);
 		err = make_node_dirty(c, node_type, node_num, lnum, offs);
 		mutex_unlock(&c->lp_mutex);
@@ -1195,7 +1197,7 @@ static int lpt_gc(struct ubifs_info *c)
 
 	mutex_lock(&c->lp_mutex);
 	for (i = 0; i < c->lpt_lebs; i++) {
-		ubifs_assert(!c->ltab[i].tgc);
+		ubifs_assert(c, !c->ltab[i].tgc);
 		if (i + c->lpt_first == c->nhead_lnum ||
 		    c->ltab[i].free + c->ltab[i].dirty == c->leb_size)
 			continue;
@@ -1271,7 +1273,7 @@ int ubifs_lpt_start_commit(struct ubifs_info *c)
 		populate_lsave(c);
 
 	cnt = get_cnodes_to_commit(c);
-	ubifs_assert(cnt != 0);
+	ubifs_assert(c, cnt != 0);
 
 	err = layout_cnodes(c);
 	if (err)
diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index c6a5e39e2ba5..9df4a41bba52 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -360,7 +360,7 @@ int ubifs_write_master(struct ubifs_info *c)
 {
 	int err, lnum, offs, len;
 
-	ubifs_assert(!c->ro_media && !c->ro_mount);
+	ubifs_assert(c, !c->ro_media && !c->ro_mount);
 	if (c->ro_error)
 		return -EROFS;
 
diff --git a/fs/ubifs/misc.h b/fs/ubifs/misc.h
index caf83d68fb38..f5d180c0c52e 100644
--- a/fs/ubifs/misc.h
+++ b/fs/ubifs/misc.h
@@ -105,25 +105,27 @@ static inline struct ubifs_inode *ubifs_inode(const struct inode *inode)
 /**
  * ubifs_compr_present - check if compressor was compiled in.
  * @compr_type: compressor type to check
+ * @c: the UBIFS file-system description object
  *
  * This function returns %1 of compressor of type @compr_type is present, and
  * %0 if not.
  */
-static inline int ubifs_compr_present(int compr_type)
+static inline int ubifs_compr_present(struct ubifs_info *c, int compr_type)
 {
-	ubifs_assert(compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
+	ubifs_assert(c, compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
 	return !!ubifs_compressors[compr_type]->capi_name;
 }
 
 /**
  * ubifs_compr_name - get compressor name string by its type.
  * @compr_type: compressor type
+ * @c: the UBIFS file-system description object
  *
  * This function returns compressor type string.
  */
-static inline const char *ubifs_compr_name(int compr_type)
+static inline const char *ubifs_compr_name(struct ubifs_info *c, int compr_type)
 {
-	ubifs_assert(compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
+	ubifs_assert(c, compr_type >= 0 && compr_type < UBIFS_COMPR_TYPES_CNT);
 	return ubifs_compressors[compr_type]->name;
 }
 
@@ -262,8 +264,8 @@ static inline void ubifs_get_lprops(struct ubifs_info *c)
  */
 static inline void ubifs_release_lprops(struct ubifs_info *c)
 {
-	ubifs_assert(mutex_is_locked(&c->lp_mutex));
-	ubifs_assert(c->lst.empty_lebs >= 0 &&
+	ubifs_assert(c, mutex_is_locked(&c->lp_mutex));
+	ubifs_assert(c, c->lst.empty_lebs >= 0 &&
 		     c->lst.empty_lebs <= c->main_lebs);
 	mutex_unlock(&c->lp_mutex);
 }
diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index caf2d123e9ee..8f70494efb0c 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -172,8 +172,8 @@ int ubifs_orphan_start_commit(struct ubifs_info *c)
 	spin_lock(&c->orphan_lock);
 	last = &c->orph_cnext;
 	list_for_each_entry(orphan, &c->orph_new, new_list) {
-		ubifs_assert(orphan->new);
-		ubifs_assert(!orphan->cmt);
+		ubifs_assert(c, orphan->new);
+		ubifs_assert(c, !orphan->cmt);
 		orphan->new = 0;
 		orphan->cmt = 1;
 		*last = orphan;
@@ -244,7 +244,7 @@ static int do_write_orph_node(struct ubifs_info *c, int len, int atomic)
 	int err = 0;
 
 	if (atomic) {
-		ubifs_assert(c->ohead_offs == 0);
+		ubifs_assert(c, c->ohead_offs == 0);
 		ubifs_prepare_node(c, c->orph_buf, len, 1);
 		len = ALIGN(len, c->min_io_size);
 		err = ubifs_leb_change(c, c->ohead_lnum, c->orph_buf, len);
@@ -276,7 +276,7 @@ static int write_orph_node(struct ubifs_info *c, int atomic)
 	struct ubifs_orph_node *orph;
 	int gap, err, len, cnt, i;
 
-	ubifs_assert(c->cmt_orphans > 0);
+	ubifs_assert(c, c->cmt_orphans > 0);
 	gap = c->leb_size - c->ohead_offs;
 	if (gap < UBIFS_ORPH_NODE_SZ + sizeof(__le64)) {
 		c->ohead_lnum += 1;
@@ -295,14 +295,14 @@ static int write_orph_node(struct ubifs_info *c, int atomic)
 	if (cnt > c->cmt_orphans)
 		cnt = c->cmt_orphans;
 	len = UBIFS_ORPH_NODE_SZ + cnt * sizeof(__le64);
-	ubifs_assert(c->orph_buf);
+	ubifs_assert(c, c->orph_buf);
 	orph = c->orph_buf;
 	orph->ch.node_type = UBIFS_ORPH_NODE;
 	spin_lock(&c->orphan_lock);
 	cnext = c->orph_cnext;
 	for (i = 0; i < cnt; i++) {
 		orphan = cnext;
-		ubifs_assert(orphan->cmt);
+		ubifs_assert(c, orphan->cmt);
 		orph->inos[i] = cpu_to_le64(orphan->inum);
 		orphan->cmt = 0;
 		cnext = orphan->cnext;
@@ -316,9 +316,9 @@ static int write_orph_node(struct ubifs_info *c, int atomic)
 	else
 		/* Mark the last node of the commit */
 		orph->cmt_no = cpu_to_le64((c->cmt_no) | (1ULL << 63));
-	ubifs_assert(c->ohead_offs + len <= c->leb_size);
-	ubifs_assert(c->ohead_lnum >= c->orph_first);
-	ubifs_assert(c->ohead_lnum <= c->orph_last);
+	ubifs_assert(c, c->ohead_offs + len <= c->leb_size);
+	ubifs_assert(c, c->ohead_lnum >= c->orph_first);
+	ubifs_assert(c, c->ohead_lnum <= c->orph_last);
 	err = do_write_orph_node(c, len, atomic);
 	c->ohead_offs += ALIGN(len, c->min_io_size);
 	c->ohead_offs = ALIGN(c->ohead_offs, 8);
@@ -388,7 +388,7 @@ static int consolidate(struct ubifs_info *c)
 			cnt += 1;
 		}
 		*last = NULL;
-		ubifs_assert(cnt == c->tot_orphans - c->new_orphans);
+		ubifs_assert(c, cnt == c->tot_orphans - c->new_orphans);
 		c->cmt_orphans = cnt;
 		c->ohead_lnum = c->orph_first;
 		c->ohead_offs = 0;
@@ -415,7 +415,7 @@ static int commit_orphans(struct ubifs_info *c)
 {
 	int avail, atomic = 0, err;
 
-	ubifs_assert(c->cmt_orphans > 0);
+	ubifs_assert(c, c->cmt_orphans > 0);
 	avail = avail_orphs(c);
 	if (avail < c->cmt_orphans) {
 		/* Not enough space to write new orphans, so consolidate */
@@ -446,8 +446,8 @@ static void erase_deleted(struct ubifs_info *c)
 	while (dnext) {
 		orphan = dnext;
 		dnext = orphan->dnext;
-		ubifs_assert(!orphan->new);
-		ubifs_assert(orphan->del);
+		ubifs_assert(c, !orphan->new);
+		ubifs_assert(c, orphan->del);
 		rb_erase(&orphan->rb, &c->orph_tree);
 		list_del(&orphan->list);
 		c->tot_orphans -= 1;
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 3af4472061cc..984e30e83c0b 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -444,7 +444,7 @@ static void clean_buf(const struct ubifs_info *c, void **buf, int lnum,
 
 	dbg_rcvry("cleaning corruption at %d:%d", lnum, *offs);
 
-	ubifs_assert(!(*offs & 7));
+	ubifs_assert(c, !(*offs & 7));
 	empty_offs = ALIGN(*offs, c->min_io_size);
 	pad_len = empty_offs - *offs;
 	ubifs_pad(c, *buf, pad_len);
@@ -644,7 +644,7 @@ struct ubifs_scan_leb *ubifs_recover_leb(struct ubifs_info *c, int lnum,
 	if (IS_ERR(sleb))
 		return sleb;
 
-	ubifs_assert(len >= 8);
+	ubifs_assert(c, len >= 8);
 	while (len >= 8) {
 		dbg_scan("look at LEB %d:%d (%d bytes left)",
 			 lnum, offs, len);
@@ -966,7 +966,7 @@ int ubifs_recover_inl_heads(struct ubifs_info *c, void *sbuf)
 {
 	int err;
 
-	ubifs_assert(!c->ro_mount || c->remounting_rw);
+	ubifs_assert(c, !c->ro_mount || c->remounting_rw);
 
 	dbg_rcvry("checking index head at %d:%d", c->ihead_lnum, c->ihead_offs);
 	err = recover_head(c, c->ihead_lnum, c->ihead_offs, sbuf);
@@ -1187,8 +1187,8 @@ int ubifs_rcvry_gc_commit(struct ubifs_info *c)
 		return grab_empty_leb(c);
 	}
 
-	ubifs_assert(!(lp.flags & LPROPS_INDEX));
-	ubifs_assert(lp.free + lp.dirty >= wbuf->offs);
+	ubifs_assert(c, !(lp.flags & LPROPS_INDEX));
+	ubifs_assert(c, lp.free + lp.dirty >= wbuf->offs);
 
 	/*
 	 * We run the commit before garbage collection otherwise subsequent
@@ -1216,7 +1216,7 @@ int ubifs_rcvry_gc_commit(struct ubifs_info *c)
 		return err;
 	}
 
-	ubifs_assert(err == LEB_RETAINED);
+	ubifs_assert(c, err == LEB_RETAINED);
 	if (err != LEB_RETAINED)
 		return -EINVAL;
 
@@ -1507,7 +1507,7 @@ int ubifs_recover_size(struct ubifs_info *c)
 				struct inode *inode;
 				struct ubifs_inode *ui;
 
-				ubifs_assert(!e->inode);
+				ubifs_assert(c, !e->inode);
 
 				inode = ubifs_iget(c->vfs_sb, e->inum);
 				if (IS_ERR(inode))
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 85c2a43082b7..4844538eb926 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -273,6 +273,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 static int replay_entries_cmp(void *priv, struct list_head *a,
 			      struct list_head *b)
 {
+	struct ubifs_info *c = priv;
 	struct replay_entry *ra, *rb;
 
 	cond_resched();
@@ -281,7 +282,7 @@ static int replay_entries_cmp(void *priv, struct list_head *a,
 
 	ra = list_entry(a, struct replay_entry, list);
 	rb = list_entry(b, struct replay_entry, list);
-	ubifs_assert(ra->sqnum != rb->sqnum);
+	ubifs_assert(c, ra->sqnum != rb->sqnum);
 	if (ra->sqnum > rb->sqnum)
 		return 1;
 	return -1;
@@ -668,9 +669,9 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			goto out;
 	}
 
-	ubifs_assert(ubifs_search_bud(c, lnum));
-	ubifs_assert(sleb->endpt - offs >= used);
-	ubifs_assert(sleb->endpt % c->min_io_size == 0);
+	ubifs_assert(c, ubifs_search_bud(c, lnum));
+	ubifs_assert(c, sleb->endpt - offs >= used);
+	ubifs_assert(c, sleb->endpt % c->min_io_size == 0);
 
 	b->dirty = sleb->endpt - offs - used;
 	b->free = c->leb_size - sleb->endpt;
@@ -706,7 +707,7 @@ static int replay_buds(struct ubifs_info *c)
 		if (err)
 			return err;
 
-		ubifs_assert(b->sqnum > prev_sqnum);
+		ubifs_assert(c, b->sqnum > prev_sqnum);
 		prev_sqnum = b->sqnum;
 	}
 
@@ -1067,7 +1068,7 @@ int ubifs_replay_journal(struct ubifs_info *c)
 	c->bi.uncommitted_idx = atomic_long_read(&c->dirty_zn_cnt);
 	c->bi.uncommitted_idx *= c->max_idx_node_sz;
 
-	ubifs_assert(c->bud_bytes <= c->max_bud_bytes || c->need_recovery);
+	ubifs_assert(c, c->bud_bytes <= c->max_bud_bytes || c->need_recovery);
 	dbg_mnt("finished, log head LEB %d:%d, max_sqnum %llu, highest_inum %lu",
 		c->lhead_lnum, c->lhead_offs, c->max_sqnum,
 		(unsigned long)c->highest_inum);
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 8c25081a5109..4a89428bff88 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -563,7 +563,7 @@ int ubifs_read_superblock(struct ubifs_info *c)
 	 * due to the unavailability of time-travelling equipment.
 	 */
 	if (c->fmt_version > UBIFS_FORMAT_VERSION) {
-		ubifs_assert(!c->ro_media || c->ro_mount);
+		ubifs_assert(c, !c->ro_media || c->ro_mount);
 		if (!c->ro_mount ||
 		    c->ro_compat_version > UBIFS_RO_COMPAT_VERSION) {
 			ubifs_err(c, "on-flash format version is w%d/r%d, but software only supports up to version w%d/r%d",
@@ -705,9 +705,9 @@ static int fixup_leb(struct ubifs_info *c, int lnum, int len)
 {
 	int err;
 
-	ubifs_assert(len >= 0);
-	ubifs_assert(len % c->min_io_size == 0);
-	ubifs_assert(len < c->leb_size);
+	ubifs_assert(c, len >= 0);
+	ubifs_assert(c, len % c->min_io_size == 0);
+	ubifs_assert(c, len < c->leb_size);
 
 	if (len == 0) {
 		dbg_mnt("unmap empty LEB %d", lnum);
@@ -817,8 +817,8 @@ int ubifs_fixup_free_space(struct ubifs_info *c)
 	int err;
 	struct ubifs_sb_node *sup;
 
-	ubifs_assert(c->space_fixup);
-	ubifs_assert(!c->ro_mount);
+	ubifs_assert(c, c->space_fixup);
+	ubifs_assert(c, !c->ro_mount);
 
 	ubifs_msg(c, "start fixing up free space");
 
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index 16f03d9929e5..ea88926163f4 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -176,7 +176,7 @@ void ubifs_end_scan(const struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 		    int lnum, int offs)
 {
 	dbg_scan("stop scanning LEB %d at offset %d", lnum, offs);
-	ubifs_assert(offs % c->min_io_size == 0);
+	ubifs_assert(c, offs % c->min_io_size == 0);
 
 	sleb->endpt = ALIGN(offs, c->min_io_size);
 }
diff --git a/fs/ubifs/shrinker.c b/fs/ubifs/shrinker.c
index 9a9fb94a41c6..3e55cf52d569 100644
--- a/fs/ubifs/shrinker.c
+++ b/fs/ubifs/shrinker.c
@@ -73,8 +73,8 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 	struct ubifs_znode *znode, *zprev;
 	int time = get_seconds();
 
-	ubifs_assert(mutex_is_locked(&c->umount_mutex));
-	ubifs_assert(mutex_is_locked(&c->tnc_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->umount_mutex));
+	ubifs_assert(c, mutex_is_locked(&c->tnc_mutex));
 
 	if (!c->zroot.znode || atomic_long_read(&c->clean_zn_cnt) == 0)
 		return 0;
@@ -89,7 +89,7 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 	 * changed only when the 'c->tnc_mutex' is held.
 	 */
 	zprev = NULL;
-	znode = ubifs_tnc_levelorder_next(c->zroot.znode, NULL);
+	znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, NULL);
 	while (znode && total_freed < nr &&
 	       atomic_long_read(&c->clean_zn_cnt) > 0) {
 		int freed;
@@ -125,7 +125,7 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 			else
 				c->zroot.znode = NULL;
 
-			freed = ubifs_destroy_tnc_subtree(znode);
+			freed = ubifs_destroy_tnc_subtree(c, znode);
 			atomic_long_sub(freed, &ubifs_clean_zn_cnt);
 			atomic_long_sub(freed, &c->clean_zn_cnt);
 			total_freed += freed;
@@ -136,7 +136,7 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
 			break;
 
 		zprev = znode;
-		znode = ubifs_tnc_levelorder_next(c->zroot.znode, znode);
+		znode = ubifs_tnc_levelorder_next(c, c->zroot.znode, znode);
 		cond_resched();
 	}
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 90ebfcc8a8ea..c2796373b837 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -89,9 +89,9 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	if (ui->xattr && !S_ISREG(inode->i_mode))
 		return 5;
 
-	if (!ubifs_compr_present(ui->compr_type)) {
+	if (!ubifs_compr_present(c, ui->compr_type)) {
 		ubifs_warn(c, "inode %lu uses '%s' compression, but it was not compiled in",
-			   inode->i_ino, ubifs_compr_name(ui->compr_type));
+			   inode->i_ino, ubifs_compr_name(c, ui->compr_type));
 	}
 
 	err = dbg_check_dir(c, inode);
@@ -296,7 +296,7 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
-	ubifs_assert(!ui->xattr);
+	ubifs_assert(c, !ui->xattr);
 	if (is_bad_inode(inode))
 		return 0;
 
@@ -349,7 +349,7 @@ static void ubifs_evict_inode(struct inode *inode)
 		goto out;
 
 	dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
-	ubifs_assert(!atomic_read(&inode->i_count));
+	ubifs_assert(c, !atomic_read(&inode->i_count));
 
 	truncate_inode_pages_final(&inode->i_data);
 
@@ -384,9 +384,10 @@ static void ubifs_evict_inode(struct inode *inode)
 
 static void ubifs_dirty_inode(struct inode *inode, int flags)
 {
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
-	ubifs_assert(mutex_is_locked(&ui->ui_mutex));
+	ubifs_assert(c, mutex_is_locked(&ui->ui_mutex));
 	if (!ui->dirty) {
 		ui->dirty = 1;
 		dbg_gen("inode %lu",  inode->i_ino);
@@ -416,7 +417,7 @@ static int ubifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = UBIFS_MAX_NLEN;
 	buf->f_fsid.val[0] = le32_to_cpu(uuid[0]) ^ le32_to_cpu(uuid[2]);
 	buf->f_fsid.val[1] = le32_to_cpu(uuid[1]) ^ le32_to_cpu(uuid[3]);
-	ubifs_assert(buf->f_bfree <= c->block_cnt);
+	ubifs_assert(c, buf->f_bfree <= c->block_cnt);
 	return 0;
 }
 
@@ -441,7 +442,7 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
 
 	if (c->mount_opts.override_compr) {
 		seq_printf(s, ",compr=%s",
-			   ubifs_compr_name(c->mount_opts.compr_type));
+			   ubifs_compr_name(c, c->mount_opts.compr_type));
 	}
 
 	seq_printf(s, ",ubi=%d,vol=%d", c->vi.ubi_num, c->vi.vol_id);
@@ -1103,7 +1104,7 @@ static void destroy_journal(struct ubifs_info *c)
  */
 static void bu_init(struct ubifs_info *c)
 {
-	ubifs_assert(c->bulk_read == 1);
+	ubifs_assert(c, c->bulk_read == 1);
 
 	if (c->bu.buf)
 		return; /* Already initialized */
@@ -1134,7 +1135,7 @@ static void bu_init(struct ubifs_info *c)
  */
 static int check_free_space(struct ubifs_info *c)
 {
-	ubifs_assert(c->dark_wm > 0);
+	ubifs_assert(c, c->dark_wm > 0);
 	if (c->lst.total_free + c->lst.total_dirty < c->dark_wm) {
 		ubifs_err(c, "insufficient free space to mount in R/W mode");
 		ubifs_dump_budg(c, &c->bi);
@@ -1234,9 +1235,9 @@ static int mount_ubifs(struct ubifs_info *c)
 	 * Make sure the compressor which is set as default in the superblock
 	 * or overridden by mount options is actually compiled in.
 	 */
-	if (!ubifs_compr_present(c->default_compr)) {
+	if (!ubifs_compr_present(c, c->default_compr)) {
 		ubifs_err(c, "'compressor \"%s\" is not compiled in",
-			  ubifs_compr_name(c->default_compr));
+			  ubifs_compr_name(c, c->default_compr));
 		err = -ENOTSUPP;
 		goto out_free;
 	}
@@ -1396,10 +1397,10 @@ static int mount_ubifs(struct ubifs_info *c)
 			 * the journal head LEBs may also be accounted as
 			 * "empty taken" if they are empty.
 			 */
-			ubifs_assert(c->lst.taken_empty_lebs > 0);
+			ubifs_assert(c, c->lst.taken_empty_lebs > 0);
 		}
 	} else
-		ubifs_assert(c->lst.taken_empty_lebs > 0);
+		ubifs_assert(c, c->lst.taken_empty_lebs > 0);
 
 	err = dbg_check_filesystem(c);
 	if (err)
@@ -1429,7 +1430,7 @@ static int mount_ubifs(struct ubifs_info *c)
 		  UBIFS_FORMAT_VERSION, UBIFS_RO_COMPAT_VERSION, c->uuid,
 		  c->big_lpt ? ", big LPT model" : ", small LPT model");
 
-	dbg_gen("default compressor:  %s", ubifs_compr_name(c->default_compr));
+	dbg_gen("default compressor:  %s", ubifs_compr_name(c, c->default_compr));
 	dbg_gen("data journal heads:  %d",
 		c->jhead_cnt - NONDATA_JHEADS_CNT);
 	dbg_gen("log LEBs:            %d (%d - %d)",
@@ -1610,7 +1611,7 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 			goto out;
 	} else {
 		/* A readonly mount is not allowed to have orphans */
-		ubifs_assert(c->tot_orphans == 0);
+		ubifs_assert(c, c->tot_orphans == 0);
 		err = ubifs_clear_orphans(c);
 		if (err)
 			goto out;
@@ -1727,8 +1728,8 @@ static void ubifs_remount_ro(struct ubifs_info *c)
 {
 	int i, err;
 
-	ubifs_assert(!c->need_recovery);
-	ubifs_assert(!c->ro_mount);
+	ubifs_assert(c, !c->need_recovery);
+	ubifs_assert(c, !c->ro_mount);
 
 	mutex_lock(&c->umount_mutex);
 	if (c->bgt) {
@@ -1778,9 +1779,9 @@ static void ubifs_put_super(struct super_block *sb)
 	 * to write them back because of I/O errors.
 	 */
 	if (!c->ro_error) {
-		ubifs_assert(c->bi.idx_growth == 0);
-		ubifs_assert(c->bi.dd_growth == 0);
-		ubifs_assert(c->bi.data_growth == 0);
+		ubifs_assert(c, c->bi.idx_growth == 0);
+		ubifs_assert(c, c->bi.dd_growth == 0);
+		ubifs_assert(c, c->bi.data_growth == 0);
 	}
 
 	/*
@@ -1887,7 +1888,7 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 		mutex_unlock(&c->bu_mutex);
 	}
 
-	ubifs_assert(c->lst.taken_empty_lebs > 0);
+	ubifs_assert(c, c->lst.taken_empty_lebs > 0);
 	return 0;
 }
 
@@ -2061,7 +2062,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_lock(&c->umount_mutex);
 	err = mount_ubifs(c);
 	if (err) {
-		ubifs_assert(err < 0);
+		ubifs_assert(c, err < 0);
 		goto out_unlock;
 	}
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 4a21e7f75e7a..e3f874e7f9ad 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -211,7 +211,7 @@ static struct ubifs_znode *copy_znode(struct ubifs_info *c,
 	__set_bit(DIRTY_ZNODE, &zn->flags);
 	__clear_bit(COW_ZNODE, &zn->flags);
 
-	ubifs_assert(!ubifs_zn_obsolete(znode));
+	ubifs_assert(c, !ubifs_zn_obsolete(znode));
 	__set_bit(OBSOLETE_ZNODE, &znode->flags);
 
 	if (znode->level != 0) {
@@ -321,9 +321,9 @@ static int lnc_add(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 	void *lnc_node;
 	const struct ubifs_dent_node *dent = node;
 
-	ubifs_assert(!zbr->leaf);
-	ubifs_assert(zbr->len != 0);
-	ubifs_assert(is_hash_key(c, &zbr->key));
+	ubifs_assert(c, !zbr->leaf);
+	ubifs_assert(c, zbr->len != 0);
+	ubifs_assert(c, is_hash_key(c, &zbr->key));
 
 	err = ubifs_validate_entry(c, dent);
 	if (err) {
@@ -355,8 +355,8 @@ static int lnc_add_directly(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 {
 	int err;
 
-	ubifs_assert(!zbr->leaf);
-	ubifs_assert(zbr->len != 0);
+	ubifs_assert(c, !zbr->leaf);
+	ubifs_assert(c, zbr->len != 0);
 
 	err = ubifs_validate_entry(c, node);
 	if (err) {
@@ -398,11 +398,11 @@ static int tnc_read_hashed_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 {
 	int err;
 
-	ubifs_assert(is_hash_key(c, &zbr->key));
+	ubifs_assert(c, is_hash_key(c, &zbr->key));
 
 	if (zbr->leaf) {
 		/* Read from the leaf node cache */
-		ubifs_assert(zbr->len != 0);
+		ubifs_assert(c, zbr->len != 0);
 		memcpy(node, zbr->leaf, zbr->len);
 		return 0;
 	}
@@ -721,7 +721,7 @@ static int resolve_collision(struct ubifs_info *c, const union ubifs_key *key,
 		while (1) {
 			err = tnc_prev(c, zn, n);
 			if (err == -ENOENT) {
-				ubifs_assert(*n == 0);
+				ubifs_assert(c, *n == 0);
 				*n = -1;
 				return 0;
 			}
@@ -761,12 +761,12 @@ static int resolve_collision(struct ubifs_info *c, const union ubifs_key *key,
 					err = tnc_next(c, zn, n);
 					if (err) {
 						/* Should be impossible */
-						ubifs_assert(0);
+						ubifs_assert(c, 0);
 						if (err == -ENOENT)
 							err = -EINVAL;
 						return err;
 					}
-					ubifs_assert(*n == 0);
+					ubifs_assert(c, *n == 0);
 					*n = -1;
 				}
 				return 0;
@@ -778,7 +778,7 @@ static int resolve_collision(struct ubifs_info *c, const union ubifs_key *key,
 				return 0;
 			if (err == NAME_MATCHES)
 				return 1;
-			ubifs_assert(err == NAME_GREATER);
+			ubifs_assert(c, err == NAME_GREATER);
 		}
 	} else {
 		int nn = *n;
@@ -802,7 +802,7 @@ static int resolve_collision(struct ubifs_info *c, const union ubifs_key *key,
 			*n = nn;
 			if (err == NAME_MATCHES)
 				return 1;
-			ubifs_assert(err == NAME_LESS);
+			ubifs_assert(c, err == NAME_LESS);
 		}
 	}
 }
@@ -843,7 +843,7 @@ static int fallible_matches_name(struct ubifs_info *c,
 			err = NOT_ON_MEDIA;
 			goto out_free;
 		}
-		ubifs_assert(err == 1);
+		ubifs_assert(c, err == 1);
 
 		err = lnc_add_directly(c, zbr, dent);
 		if (err)
@@ -923,7 +923,7 @@ static int fallible_resolve_collision(struct ubifs_info *c,
 		while (1) {
 			err = tnc_prev(c, zn, n);
 			if (err == -ENOENT) {
-				ubifs_assert(*n == 0);
+				ubifs_assert(c, *n == 0);
 				*n = -1;
 				break;
 			}
@@ -935,12 +935,12 @@ static int fallible_resolve_collision(struct ubifs_info *c,
 					err = tnc_next(c, zn, n);
 					if (err) {
 						/* Should be impossible */
-						ubifs_assert(0);
+						ubifs_assert(c, 0);
 						if (err == -ENOENT)
 							err = -EINVAL;
 						return err;
 					}
-					ubifs_assert(*n == 0);
+					ubifs_assert(c, *n == 0);
 					*n = -1;
 				}
 				break;
@@ -1100,8 +1100,8 @@ static struct ubifs_znode *dirty_cow_bottom_up(struct ubifs_info *c,
 	struct ubifs_znode *zp;
 	int *path = c->bottom_up_buf, p = 0;
 
-	ubifs_assert(c->zroot.znode);
-	ubifs_assert(znode);
+	ubifs_assert(c, c->zroot.znode);
+	ubifs_assert(c, znode);
 	if (c->zroot.znode->level > BOTTOM_UP_HEIGHT) {
 		kfree(c->bottom_up_buf);
 		c->bottom_up_buf = kmalloc_array(c->zroot.znode->level,
@@ -1120,7 +1120,7 @@ static struct ubifs_znode *dirty_cow_bottom_up(struct ubifs_info *c,
 			if (!zp)
 				break;
 			n = znode->iip;
-			ubifs_assert(p < c->zroot.znode->level);
+			ubifs_assert(c, p < c->zroot.znode->level);
 			path[p++] = n;
 			if (!zp->cnext && ubifs_zn_dirty(znode))
 				break;
@@ -1134,18 +1134,18 @@ static struct ubifs_znode *dirty_cow_bottom_up(struct ubifs_info *c,
 
 		zp = znode->parent;
 		if (zp) {
-			ubifs_assert(path[p - 1] >= 0);
-			ubifs_assert(path[p - 1] < zp->child_cnt);
+			ubifs_assert(c, path[p - 1] >= 0);
+			ubifs_assert(c, path[p - 1] < zp->child_cnt);
 			zbr = &zp->zbranch[path[--p]];
 			znode = dirty_cow_znode(c, zbr);
 		} else {
-			ubifs_assert(znode == c->zroot.znode);
+			ubifs_assert(c, znode == c->zroot.znode);
 			znode = dirty_cow_znode(c, &c->zroot);
 		}
 		if (IS_ERR(znode) || !p)
 			break;
-		ubifs_assert(path[p - 1] >= 0);
-		ubifs_assert(path[p - 1] < znode->child_cnt);
+		ubifs_assert(c, path[p - 1] >= 0);
+		ubifs_assert(c, path[p - 1] < znode->child_cnt);
 		znode = znode->zbranch[path[p - 1]].znode;
 	}
 
@@ -1182,7 +1182,7 @@ int ubifs_lookup_level0(struct ubifs_info *c, const union ubifs_key *key,
 	unsigned long time = get_seconds();
 
 	dbg_tnck(key, "search key ");
-	ubifs_assert(key_type(c, key) < UBIFS_INVALID_KEY);
+	ubifs_assert(c, key_type(c, key) < UBIFS_INVALID_KEY);
 
 	znode = c->zroot.znode;
 	if (unlikely(!znode)) {
@@ -1658,9 +1658,9 @@ static int read_wbuf(struct ubifs_wbuf *wbuf, void *buf, int len, int lnum,
 	int rlen, overlap;
 
 	dbg_io("LEB %d:%d, length %d", lnum, offs, len);
-	ubifs_assert(wbuf && lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
-	ubifs_assert(!(offs & 7) && offs < c->leb_size);
-	ubifs_assert(offs + len <= c->leb_size);
+	ubifs_assert(c, wbuf && lnum >= 0 && lnum < c->leb_cnt && offs >= 0);
+	ubifs_assert(c, !(offs & 7) && offs < c->leb_size);
+	ubifs_assert(c, offs + len <= c->leb_size);
 
 	spin_lock(&wbuf->lock);
 	overlap = (lnum == wbuf->lnum && offs + len > wbuf->offs);
@@ -1824,7 +1824,7 @@ static int do_lookup_nm(struct ubifs_info *c, const union ubifs_key *key,
 		goto out_unlock;
 	}
 
-	ubifs_assert(n >= 0);
+	ubifs_assert(c, n >= 0);
 
 	err = resolve_collision(c, key, &znode, &n, nm);
 	dbg_tnc("rc returned %d, znode %p, n %d", err, znode, n);
@@ -1922,7 +1922,7 @@ static int do_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
 	struct ubifs_znode *znode;
 	union ubifs_key start_key;
 
-	ubifs_assert(is_hash_key(c, key));
+	ubifs_assert(c, is_hash_key(c, key));
 
 	lowest_dent_key(c, &start_key, key_inum(c, key));
 
@@ -1993,8 +1993,8 @@ static void correct_parent_keys(const struct ubifs_info *c,
 {
 	union ubifs_key *key, *key1;
 
-	ubifs_assert(znode->parent);
-	ubifs_assert(znode->iip == 0);
+	ubifs_assert(c, znode->parent);
+	ubifs_assert(c, znode->iip == 0);
 
 	key = &znode->zbranch[0].key;
 	key1 = &znode->parent->zbranch[0].key;
@@ -2011,6 +2011,7 @@ static void correct_parent_keys(const struct ubifs_info *c,
 
 /**
  * insert_zbranch - insert a zbranch into a znode.
+ * @c: UBIFS file-system description object
  * @znode: znode into which to insert
  * @zbr: zbranch to insert
  * @n: slot number to insert to
@@ -2020,12 +2021,12 @@ static void correct_parent_keys(const struct ubifs_info *c,
  * zbranch has to be inserted to the @znode->zbranches[]' array at the @n-th
  * slot, zbranches starting from @n have to be moved right.
  */
-static void insert_zbranch(struct ubifs_znode *znode,
+static void insert_zbranch(struct ubifs_info *c, struct ubifs_znode *znode,
 			   const struct ubifs_zbranch *zbr, int n)
 {
 	int i;
 
-	ubifs_assert(ubifs_zn_dirty(znode));
+	ubifs_assert(c, ubifs_zn_dirty(znode));
 
 	if (znode->level) {
 		for (i = znode->child_cnt; i > n; i--) {
@@ -2079,16 +2080,16 @@ static int tnc_insert(struct ubifs_info *c, struct ubifs_znode *znode,
 	int i, keep, move, appending = 0;
 	union ubifs_key *key = &zbr->key, *key1;
 
-	ubifs_assert(n >= 0 && n <= c->fanout);
+	ubifs_assert(c, n >= 0 && n <= c->fanout);
 
 	/* Implement naive insert for now */
 again:
 	zp = znode->parent;
 	if (znode->child_cnt < c->fanout) {
-		ubifs_assert(n != c->fanout);
+		ubifs_assert(c, n != c->fanout);
 		dbg_tnck(key, "inserted at %d level %d, key ", n, znode->level);
 
-		insert_zbranch(znode, zbr, n);
+		insert_zbranch(c, znode, zbr, n);
 
 		/* Ensure parent's key is correct */
 		if (n == 0 && zp && znode->iip == 0)
@@ -2197,7 +2198,7 @@ static int tnc_insert(struct ubifs_info *c, struct ubifs_znode *znode,
 	/* Insert new key and branch */
 	dbg_tnck(key, "inserting at %d level %d, key ", n, zn->level);
 
-	insert_zbranch(zi, zbr, n);
+	insert_zbranch(c, zi, zbr, n);
 
 	/* Insert new znode (produced by spitting) into the parent */
 	if (zp) {
@@ -2495,8 +2496,8 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 	int i, err;
 
 	/* Delete without merge for now */
-	ubifs_assert(znode->level == 0);
-	ubifs_assert(n >= 0 && n < c->fanout);
+	ubifs_assert(c, znode->level == 0);
+	ubifs_assert(c, n >= 0 && n < c->fanout);
 	dbg_tnck(&znode->zbranch[n].key, "deleting key ");
 
 	zbr = &znode->zbranch[n];
@@ -2522,8 +2523,8 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 	 */
 
 	do {
-		ubifs_assert(!ubifs_zn_obsolete(znode));
-		ubifs_assert(ubifs_zn_dirty(znode));
+		ubifs_assert(c, !ubifs_zn_obsolete(znode));
+		ubifs_assert(c, ubifs_zn_dirty(znode));
 
 		zp = znode->parent;
 		n = znode->iip;
@@ -2545,7 +2546,7 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 
 	/* Remove from znode, entry n - 1 */
 	znode->child_cnt -= 1;
-	ubifs_assert(znode->level != 0);
+	ubifs_assert(c, znode->level != 0);
 	for (i = n; i < znode->child_cnt; i++) {
 		znode->zbranch[i] = znode->zbranch[i + 1];
 		if (znode->zbranch[i].znode)
@@ -2578,8 +2579,8 @@ static int tnc_delete(struct ubifs_info *c, struct ubifs_znode *znode, int n)
 			c->zroot.offs = zbr->offs;
 			c->zroot.len = zbr->len;
 			c->zroot.znode = znode;
-			ubifs_assert(!ubifs_zn_obsolete(zp));
-			ubifs_assert(ubifs_zn_dirty(zp));
+			ubifs_assert(c, !ubifs_zn_obsolete(zp));
+			ubifs_assert(c, ubifs_zn_dirty(zp));
 			atomic_long_dec(&c->dirty_zn_cnt);
 
 			if (zp->cnext) {
@@ -2944,7 +2945,7 @@ struct ubifs_dent_node *ubifs_tnc_next_ent(struct ubifs_info *c,
 	union ubifs_key *dkey;
 
 	dbg_tnck(key, "key ");
-	ubifs_assert(is_hash_key(c, key));
+	ubifs_assert(c, is_hash_key(c, key));
 
 	mutex_lock(&c->tnc_mutex);
 	err = ubifs_lookup_level0(c, key, &znode, &n);
@@ -3031,7 +3032,7 @@ static void tnc_destroy_cnext(struct ubifs_info *c)
 
 	if (!c->cnext)
 		return;
-	ubifs_assert(c->cmt_state == COMMIT_BROKEN);
+	ubifs_assert(c, c->cmt_state == COMMIT_BROKEN);
 	cnext = c->cnext;
 	do {
 		struct ubifs_znode *znode = cnext;
@@ -3053,8 +3054,8 @@ void ubifs_tnc_close(struct ubifs_info *c)
 		long n, freed;
 
 		n = atomic_long_read(&c->clean_zn_cnt);
-		freed = ubifs_destroy_tnc_subtree(c->zroot.znode);
-		ubifs_assert(freed == n);
+		freed = ubifs_destroy_tnc_subtree(c, c->zroot.znode);
+		ubifs_assert(c, freed == n);
 		atomic_long_sub(n, &ubifs_clean_zn_cnt);
 	}
 	kfree(c->gap_lebs);
@@ -3167,7 +3168,7 @@ static struct ubifs_znode *lookup_znode(struct ubifs_info *c,
 	struct ubifs_znode *znode, *zn;
 	int n, nn;
 
-	ubifs_assert(key_type(c, key) < UBIFS_INVALID_KEY);
+	ubifs_assert(c, key_type(c, key) < UBIFS_INVALID_KEY);
 
 	/*
 	 * The arguments have probably been read off flash, so don't assume
@@ -3206,7 +3207,7 @@ static struct ubifs_znode *lookup_znode(struct ubifs_info *c,
 			if (IS_ERR(znode))
 				return znode;
 			ubifs_search_zbranch(c, znode, key, &n);
-			ubifs_assert(n >= 0);
+			ubifs_assert(c, n >= 0);
 		}
 		if (znode->level == level + 1)
 			break;
@@ -3497,7 +3498,7 @@ int dbg_check_inode_size(struct ubifs_info *c, const struct inode *inode,
 	if (err < 0)
 		goto out_unlock;
 
-	ubifs_assert(err == 0);
+	ubifs_assert(c, err == 0);
 	key = &znode->zbranch[n].key;
 	if (!key_in_range(c, key, &from_key, &to_key))
 		goto out_unlock;
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a9df94ad46a3..dba87d09b989 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -87,8 +87,8 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
 
 	atomic_long_dec(&c->dirty_zn_cnt);
 
-	ubifs_assert(ubifs_zn_dirty(znode));
-	ubifs_assert(ubifs_zn_cow(znode));
+	ubifs_assert(c, ubifs_zn_dirty(znode));
+	ubifs_assert(c, ubifs_zn_cow(znode));
 
 	/*
 	 * Note, unlike 'write_index()' we do not add memory barriers here
@@ -115,9 +115,9 @@ static int fill_gap(struct ubifs_info *c, int lnum, int gap_start, int gap_end,
 {
 	int len, gap_remains, gap_pos, written, pad_len;
 
-	ubifs_assert((gap_start & 7) == 0);
-	ubifs_assert((gap_end & 7) == 0);
-	ubifs_assert(gap_end >= gap_start);
+	ubifs_assert(c, (gap_start & 7) == 0);
+	ubifs_assert(c, (gap_end & 7) == 0);
+	ubifs_assert(c, gap_end >= gap_start);
 
 	gap_remains = gap_end - gap_start;
 	if (!gap_remains)
@@ -131,7 +131,7 @@ static int fill_gap(struct ubifs_info *c, int lnum, int gap_start, int gap_end,
 			const int alen = ALIGN(len, 8);
 			int err;
 
-			ubifs_assert(alen <= gap_remains);
+			ubifs_assert(c, alen <= gap_remains);
 			err = make_idx_node(c, c->ileb_buf + gap_pos, znode,
 					    lnum, gap_pos, len);
 			if (err)
@@ -259,7 +259,7 @@ static int layout_leb_in_gaps(struct ubifs_info *c, int *p)
 		struct ubifs_idx_node *idx;
 		int in_use, level;
 
-		ubifs_assert(snod->type == UBIFS_IDX_NODE);
+		ubifs_assert(c, snod->type == UBIFS_IDX_NODE);
 		idx = snod->node;
 		key_read(c, ubifs_idx_key(c, idx), &snod->key);
 		level = le16_to_cpu(idx->level);
@@ -373,7 +373,7 @@ static int layout_in_gaps(struct ubifs_info *c, int cnt)
 
 	p = c->gap_lebs;
 	do {
-		ubifs_assert(p < c->gap_lebs + c->lst.idx_lebs);
+		ubifs_assert(c, p < c->gap_lebs + c->lst.idx_lebs);
 		written = layout_leb_in_gaps(c, p);
 		if (written < 0) {
 			err = written;
@@ -639,7 +639,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 	}
 	cnt += 1;
 	while (1) {
-		ubifs_assert(!ubifs_zn_cow(znode));
+		ubifs_assert(c, !ubifs_zn_cow(znode));
 		__set_bit(COW_ZNODE, &znode->flags);
 		znode->alt = 0;
 		cnext = find_next_dirty(znode);
@@ -652,7 +652,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 		cnt += 1;
 	}
 	dbg_cmt("committing %d znodes", cnt);
-	ubifs_assert(cnt == atomic_long_read(&c->dirty_zn_cnt));
+	ubifs_assert(c, cnt == atomic_long_read(&c->dirty_zn_cnt));
 	return cnt;
 }
 
@@ -760,7 +760,7 @@ int ubifs_tnc_start_commit(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 		err = layout_commit(c, no_space, cnt);
 		if (err)
 			goto out_free;
-		ubifs_assert(atomic_long_read(&c->dirty_zn_cnt) == 0);
+		ubifs_assert(c, atomic_long_read(&c->dirty_zn_cnt) == 0);
 		err = free_unused_idx_lebs(c);
 		if (err)
 			goto out;
@@ -781,7 +781,7 @@ int ubifs_tnc_start_commit(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 	 * budgeting subsystem to assume the index is already committed,
 	 * even though it is not.
 	 */
-	ubifs_assert(c->bi.min_idx_lebs == ubifs_calc_min_idx_lebs(c));
+	ubifs_assert(c, c->bi.min_idx_lebs == ubifs_calc_min_idx_lebs(c));
 	c->bi.old_idx_sz = c->calc_idx_sz;
 	c->bi.uncommitted_idx = 0;
 	c->bi.min_idx_lebs = ubifs_calc_min_idx_lebs(c);
@@ -887,8 +887,8 @@ static int write_index(struct ubifs_info *c)
 		/* Grab some stuff from znode while we still can */
 		cnext = znode->cnext;
 
-		ubifs_assert(ubifs_zn_dirty(znode));
-		ubifs_assert(ubifs_zn_cow(znode));
+		ubifs_assert(c, ubifs_zn_dirty(znode));
+		ubifs_assert(c, ubifs_zn_cow(znode));
 
 		/*
 		 * It is important that other threads should see %DIRTY_ZNODE
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 93f5b7859e6f..0826a25dcffc 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -31,19 +31,21 @@
 
 /**
  * ubifs_tnc_levelorder_next - next TNC tree element in levelorder traversal.
+ * @c: UBIFS file-system description object
  * @zr: root of the subtree to traverse
  * @znode: previous znode
  *
  * This function implements levelorder TNC traversal. The LNC is ignored.
  * Returns the next element or %NULL if @znode is already the last one.
  */
-struct ubifs_znode *ubifs_tnc_levelorder_next(struct ubifs_znode *zr,
+struct ubifs_znode *ubifs_tnc_levelorder_next(const struct ubifs_info *c,
+					      struct ubifs_znode *zr,
 					      struct ubifs_znode *znode)
 {
 	int level, iip, level_search = 0;
 	struct ubifs_znode *zn;
 
-	ubifs_assert(zr);
+	ubifs_assert(c, zr);
 
 	if (unlikely(!znode))
 		return zr;
@@ -58,7 +60,7 @@ struct ubifs_znode *ubifs_tnc_levelorder_next(struct ubifs_znode *zr,
 
 	iip = znode->iip;
 	while (1) {
-		ubifs_assert(znode->level <= zr->level);
+		ubifs_assert(c, znode->level <= zr->level);
 
 		/*
 		 * First walk up until there is a znode with next branch to
@@ -85,7 +87,7 @@ struct ubifs_znode *ubifs_tnc_levelorder_next(struct ubifs_znode *zr,
 			level_search = 1;
 			iip = -1;
 			znode = ubifs_tnc_find_child(zr, 0);
-			ubifs_assert(znode);
+			ubifs_assert(c, znode);
 		}
 
 		/* Switch to the next index */
@@ -111,7 +113,7 @@ struct ubifs_znode *ubifs_tnc_levelorder_next(struct ubifs_znode *zr,
 		}
 
 		if (zn) {
-			ubifs_assert(zn->level >= 0);
+			ubifs_assert(c, zn->level >= 0);
 			return zn;
 		}
 	}
@@ -140,7 +142,7 @@ int ubifs_search_zbranch(const struct ubifs_info *c,
 	int uninitialized_var(cmp);
 	const struct ubifs_zbranch *zbr = &znode->zbranch[0];
 
-	ubifs_assert(end > beg);
+	ubifs_assert(c, end > beg);
 
 	while (end > beg) {
 		mid = (beg + end) >> 1;
@@ -158,13 +160,13 @@ int ubifs_search_zbranch(const struct ubifs_info *c,
 	*n = end - 1;
 
 	/* The insert point is after *n */
-	ubifs_assert(*n >= -1 && *n < znode->child_cnt);
+	ubifs_assert(c, *n >= -1 && *n < znode->child_cnt);
 	if (*n == -1)
-		ubifs_assert(keys_cmp(c, key, &zbr[0].key) < 0);
+		ubifs_assert(c, keys_cmp(c, key, &zbr[0].key) < 0);
 	else
-		ubifs_assert(keys_cmp(c, key, &zbr[*n].key) > 0);
+		ubifs_assert(c, keys_cmp(c, key, &zbr[*n].key) > 0);
 	if (*n + 1 < znode->child_cnt)
-		ubifs_assert(keys_cmp(c, key, &zbr[*n + 1].key) < 0);
+		ubifs_assert(c, keys_cmp(c, key, &zbr[*n + 1].key) < 0);
 
 	return 0;
 }
@@ -195,16 +197,18 @@ struct ubifs_znode *ubifs_tnc_postorder_first(struct ubifs_znode *znode)
 
 /**
  * ubifs_tnc_postorder_next - next TNC tree element in postorder traversal.
+ * @c: UBIFS file-system description object
  * @znode: previous znode
  *
  * This function implements postorder TNC traversal. The LNC is ignored.
  * Returns the next element or %NULL if @znode is already the last one.
  */
-struct ubifs_znode *ubifs_tnc_postorder_next(struct ubifs_znode *znode)
+struct ubifs_znode *ubifs_tnc_postorder_next(const struct ubifs_info *c,
+					     struct ubifs_znode *znode)
 {
 	struct ubifs_znode *zn;
 
-	ubifs_assert(znode);
+	ubifs_assert(c, znode);
 	if (unlikely(!znode->parent))
 		return NULL;
 
@@ -220,18 +224,20 @@ struct ubifs_znode *ubifs_tnc_postorder_next(struct ubifs_znode *znode)
 
 /**
  * ubifs_destroy_tnc_subtree - destroy all znodes connected to a subtree.
+ * @c: UBIFS file-system description object
  * @znode: znode defining subtree to destroy
  *
  * This function destroys subtree of the TNC tree. Returns number of clean
  * znodes in the subtree.
  */
-long ubifs_destroy_tnc_subtree(struct ubifs_znode *znode)
+long ubifs_destroy_tnc_subtree(const struct ubifs_info *c,
+			       struct ubifs_znode *znode)
 {
 	struct ubifs_znode *zn = ubifs_tnc_postorder_first(znode);
 	long clean_freed = 0;
 	int n;
 
-	ubifs_assert(zn);
+	ubifs_assert(c, zn);
 	while (1) {
 		for (n = 0; n < zn->child_cnt; n++) {
 			if (!zn->zbranch[n].znode)
@@ -252,7 +258,7 @@ long ubifs_destroy_tnc_subtree(struct ubifs_znode *znode)
 			return clean_freed;
 		}
 
-		zn = ubifs_tnc_postorder_next(zn);
+		zn = ubifs_tnc_postorder_next(c, zn);
 	}
 }
 
@@ -410,7 +416,7 @@ struct ubifs_znode *ubifs_load_znode(struct ubifs_info *c,
 	int err;
 	struct ubifs_znode *znode;
 
-	ubifs_assert(!zbr->znode);
+	ubifs_assert(c, !zbr->znode);
 	/*
 	 * A slab cache is not presently used for znodes because the znode size
 	 * depends on the fanout which is stored in the superblock.
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 04bf84d71e7b..5bdf5ba146cb 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1608,14 +1608,17 @@ int ubifs_tnc_get_bu_keys(struct ubifs_info *c, struct bu_info *bu);
 int ubifs_tnc_bulk_read(struct ubifs_info *c, struct bu_info *bu);
 
 /* tnc_misc.c */
-struct ubifs_znode *ubifs_tnc_levelorder_next(struct ubifs_znode *zr,
+struct ubifs_znode *ubifs_tnc_levelorder_next(const struct ubifs_info *c,
+					      struct ubifs_znode *zr,
 					      struct ubifs_znode *znode);
 int ubifs_search_zbranch(const struct ubifs_info *c,
 			 const struct ubifs_znode *znode,
 			 const union ubifs_key *key, int *n);
 struct ubifs_znode *ubifs_tnc_postorder_first(struct ubifs_znode *znode);
-struct ubifs_znode *ubifs_tnc_postorder_next(struct ubifs_znode *znode);
-long ubifs_destroy_tnc_subtree(struct ubifs_znode *zr);
+struct ubifs_znode *ubifs_tnc_postorder_next(const struct ubifs_info *c,
+					     struct ubifs_znode *znode);
+long ubifs_destroy_tnc_subtree(const struct ubifs_info *c,
+			       struct ubifs_znode *zr);
 struct ubifs_znode *ubifs_load_znode(struct ubifs_info *c,
 				     struct ubifs_zbranch *zbr,
 				     struct ubifs_znode *parent, int iip);
@@ -1698,7 +1701,7 @@ struct ubifs_nnode *ubifs_get_nnode(struct ubifs_info *c,
 int ubifs_read_nnode(struct ubifs_info *c, struct ubifs_nnode *parent, int iip);
 void ubifs_add_lpt_dirt(struct ubifs_info *c, int lnum, int dirty);
 void ubifs_add_nnode_dirt(struct ubifs_info *c, struct ubifs_nnode *nnode);
-uint32_t ubifs_unpack_bits(uint8_t **addr, int *pos, int nrbits);
+uint32_t ubifs_unpack_bits(const struct ubifs_info *c, uint8_t **addr, int *pos, int nrbits);
 struct ubifs_nnode *ubifs_first_nnode(struct ubifs_info *c, int *hght);
 /* Needed only in debugging code in lpt_commit.c */
 int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
@@ -1812,14 +1815,16 @@ static inline int ubifs_encrypt(const struct inode *inode,
 				unsigned int in_len, unsigned int *out_len,
 				int block)
 {
-	ubifs_assert(0);
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	ubifs_assert(c, 0);
 	return -EOPNOTSUPP;
 }
 static inline int ubifs_decrypt(const struct inode *inode,
 				struct ubifs_data_node *dn,
 				unsigned int *out_len, int block)
 {
-	ubifs_assert(0);
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	ubifs_assert(c, 0);
 	return -EOPNOTSUPP;
 }
 #else
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 6f720fdf5020..f5ad1ede7990 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -216,7 +216,7 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
 	struct ubifs_budget_req req = { .dirtied_ino = 2,
 		.dirtied_ino_d = ALIGN(size, 8) + ALIGN(host_ui->data_len, 8) };
 
-	ubifs_assert(ui->data_len == inode->i_size);
+	ubifs_assert(c, ui->data_len == inode->i_size);
 	err = ubifs_budget_space(c, &req);
 	if (err)
 		return err;
@@ -291,7 +291,7 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 	int err;
 
 	if (check_lock)
-		ubifs_assert(inode_is_locked(host));
+		ubifs_assert(c, inode_is_locked(host));
 
 	if (size > UBIFS_MAX_INO_DATA)
 		return -ERANGE;
@@ -374,8 +374,8 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 	}
 
 	ui = ubifs_inode(inode);
-	ubifs_assert(inode->i_size == ui->data_len);
-	ubifs_assert(ubifs_inode(host)->xattr_size > ui->data_len);
+	ubifs_assert(c, inode->i_size == ui->data_len);
+	ubifs_assert(c, ubifs_inode(host)->xattr_size > ui->data_len);
 
 	mutex_lock(&ui->ui_mutex);
 	if (buf) {
@@ -462,7 +462,7 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	ubifs_assert(written <= size);
+	ubifs_assert(c, written <= size);
 	return written;
 }
 
@@ -475,7 +475,7 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
 	struct ubifs_budget_req req = { .dirtied_ino = 2, .mod_dent = 1,
 				.dirtied_ino_d = ALIGN(host_ui->data_len, 8) };
 
-	ubifs_assert(ui->data_len == inode->i_size);
+	ubifs_assert(c, ui->data_len == inode->i_size);
 
 	err = ubifs_budget_space(c, &req);
 	if (err)
@@ -538,7 +538,7 @@ static int ubifs_xattr_remove(struct inode *host, const char *name)
 	union ubifs_key key;
 	int err;
 
-	ubifs_assert(inode_is_locked(host));
+	ubifs_assert(c, inode_is_locked(host));
 
 	if (fname_len(&nm) > UBIFS_MAX_NLEN)
 		return -ENAMETOOLONG;
@@ -561,7 +561,7 @@ static int ubifs_xattr_remove(struct inode *host, const char *name)
 		goto out_free;
 	}
 
-	ubifs_assert(inode->i_nlink == 1);
+	ubifs_assert(c, inode->i_nlink == 1);
 	clear_nlink(inode);
 	err = remove_xattr(c, host, inode, &nm);
 	if (err)
-- 
2.18.0


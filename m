Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1299FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E74208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E74208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeGDMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:47:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59141 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934471AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dU-La; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Zb-It; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 12/25] ubifs: Add hashes to the tree node cache
Date:   Wed,  4 Jul 2018 14:41:24 +0200
Message-Id: <20180704124137.13396-13-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704124137.13396-1-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the UBIFS authentication support every branch in the index
gets a hash covering the referenced node. To make that happen the tree
node cache needs hashes over the nodes. This patch adds a hash argument
to ubifs_tnc_add() and ubifs_tnc_add_nm(). The hashes are calculated
from the callers of these functions which actually prepare the nodes.
With this patch all the leaf nodes of the index tree get hashes, but
currently nothing is done with these hashes, this is left for a later
patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/journal.c | 93 ++++++++++++++++++++++++++++++++++------------
 fs/ubifs/replay.c  |  4 +-
 fs/ubifs/tnc.c     | 10 ++++-
 fs/ubifs/ubifs.h   |  7 +++-
 4 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 754d969eb27e..55b35bc33c31 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -517,6 +517,9 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	struct ubifs_dent_node *dent;
 	struct ubifs_ino_node *ino;
 	union ubifs_key dent_key, ino_key;
+	u8 hash_dent[UBIFS_MAX_HASH_LEN];
+	u8 hash_ino[UBIFS_MAX_HASH_LEN];
+	u8 hash_ino_host[UBIFS_MAX_HASH_LEN];
 
 	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
 
@@ -571,11 +574,14 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 
 	zero_dent_node_unused(dent);
 	ubifs_prep_grp_node(c, dent, dlen, 0);
+	ubifs_node_calc_hash(c, dent, hash_dent);
 
 	ino = (void *)dent + aligned_dlen;
 	pack_inode(c, ino, inode, 0);
+	ubifs_node_calc_hash(c, ino, hash_ino);
 	ino = (void *)ino + aligned_ilen;
 	pack_inode(c, ino, dir, 1);
+	ubifs_node_calc_hash(c, ino, hash_ino_host);
 
 	if (last_reference) {
 		err = ubifs_add_orphan(c, inode->i_ino);
@@ -607,7 +613,8 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 			goto out_ro;
 		err = ubifs_add_dirt(c, lnum, dlen);
 	} else
-		err = ubifs_tnc_add_nm(c, &dent_key, lnum, dent_offs, dlen, nm);
+		err = ubifs_tnc_add_nm(c, &dent_key, lnum, dent_offs, dlen,
+				       hash_dent, nm);
 	if (err)
 		goto out_ro;
 
@@ -619,14 +626,14 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	 */
 	ino_key_init(c, &ino_key, inode->i_ino);
 	ino_offs = dent_offs + aligned_dlen;
-	err = ubifs_tnc_add(c, &ino_key, lnum, ino_offs, ilen);
+	err = ubifs_tnc_add(c, &ino_key, lnum, ino_offs, ilen, hash_ino);
 	if (err)
 		goto out_ro;
 
 	ino_key_init(c, &ino_key, dir->i_ino);
 	ino_offs += aligned_ilen;
 	err = ubifs_tnc_add(c, &ino_key, lnum, ino_offs,
-			    UBIFS_INO_NODE_SZ + host_ui->data_len);
+			    UBIFS_INO_NODE_SZ + host_ui->data_len, hash_ino_host);
 	if (err)
 		goto out_ro;
 
@@ -674,6 +681,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	int dlen = COMPRESSED_DATA_NODE_BUF_SZ, allocated = 1;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	bool encrypted = ubifs_crypt_is_encrypted(inode);
+	u8 hash[UBIFS_MAX_HASH_LEN];
 
 	dbg_jnlk(key, "ino %lu, blk %u, len %d, key ",
 		(unsigned long)key_inum(c, key), key_block(c, key), len);
@@ -732,10 +740,13 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	err = write_head(c, DATAHD, data, dlen, &lnum, &offs, 0);
 	if (err)
 		goto out_release;
+
+	ubifs_node_calc_hash(c, data, hash);
+
 	ubifs_wbuf_add_ino_nolock(&c->jheads[DATAHD].wbuf, key_inum(c, key));
 	release_head(c, DATAHD);
 
-	err = ubifs_tnc_add(c, key, lnum, offs, dlen);
+	err = ubifs_tnc_add(c, key, lnum, offs, dlen, hash);
 	if (err)
 		goto out_ro;
 
@@ -774,6 +785,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	struct ubifs_ino_node *ino;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	int sync = 0, len = UBIFS_INO_NODE_SZ, last_reference = !inode->i_nlink;
+	u8 hash[UBIFS_MAX_HASH_LEN];
 
 	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
 
@@ -795,6 +807,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 		goto out_free;
 
 	pack_inode(c, ino, inode, 1);
+	ubifs_node_calc_hash(c, ino, hash);
 	err = write_head(c, BASEHD, ino, len, &lnum, &offs, sync);
 	if (err)
 		goto out_release;
@@ -813,7 +826,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 		union ubifs_key key;
 
 		ino_key_init(c, &key, inode->i_ino);
-		err = ubifs_tnc_add(c, &key, lnum, offs, len);
+		err = ubifs_tnc_add(c, &key, lnum, offs, len, hash);
 	}
 	if (err)
 		goto out_ro;
@@ -923,6 +936,10 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	int aligned_dlen1, aligned_dlen2;
 	int twoparents = (fst_dir != snd_dir);
 	void *p;
+	u8 hash_dent1[UBIFS_MAX_HASH_LEN];
+	u8 hash_dent2[UBIFS_MAX_HASH_LEN];
+	u8 hash_p1[UBIFS_MAX_HASH_LEN];
+	u8 hash_p2[UBIFS_MAX_HASH_LEN];
 
 	ubifs_assert(ubifs_inode(fst_dir)->data_len == 0);
 	ubifs_assert(ubifs_inode(snd_dir)->data_len == 0);
@@ -958,6 +975,7 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	set_dent_cookie(c, dent1);
 	zero_dent_node_unused(dent1);
 	ubifs_prep_grp_node(c, dent1, dlen1, 0);
+	ubifs_node_calc_hash(c, dent1, hash_dent1);
 
 	/* Make new dent for 2nd entry */
 	dent2 = (void *)dent1 + aligned_dlen1;
@@ -971,14 +989,18 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	set_dent_cookie(c, dent2);
 	zero_dent_node_unused(dent2);
 	ubifs_prep_grp_node(c, dent2, dlen2, 0);
+	ubifs_node_calc_hash(c, dent2, hash_dent2);
 
 	p = (void *)dent2 + aligned_dlen2;
-	if (!twoparents)
+	if (!twoparents) {
 		pack_inode(c, p, fst_dir, 1);
-	else {
+		ubifs_node_calc_hash(c, p, hash_p1);
+	} else {
 		pack_inode(c, p, fst_dir, 0);
+		ubifs_node_calc_hash(c, p, hash_p1);
 		p += ALIGN(plen, 8);
 		pack_inode(c, p, snd_dir, 1);
+		ubifs_node_calc_hash(c, p, hash_p2);
 	}
 
 	err = write_head(c, BASEHD, dent1, len, &lnum, &offs, sync);
@@ -993,27 +1015,27 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	release_head(c, BASEHD);
 
 	dent_key_init(c, &key, snd_dir->i_ino, snd_nm);
-	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, snd_nm);
+	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, hash_dent1, snd_nm);
 	if (err)
 		goto out_ro;
 
 	offs += aligned_dlen1;
 	dent_key_init(c, &key, fst_dir->i_ino, fst_nm);
-	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen2, fst_nm);
+	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen2, hash_dent2, fst_nm);
 	if (err)
 		goto out_ro;
 
 	offs += aligned_dlen2;
 
 	ino_key_init(c, &key, fst_dir->i_ino);
-	err = ubifs_tnc_add(c, &key, lnum, offs, plen);
+	err = ubifs_tnc_add(c, &key, lnum, offs, plen, hash_p1);
 	if (err)
 		goto out_ro;
 
 	if (twoparents) {
 		offs += ALIGN(plen, 8);
 		ino_key_init(c, &key, snd_dir->i_ino);
-		err = ubifs_tnc_add(c, &key, lnum, offs, plen);
+		err = ubifs_tnc_add(c, &key, lnum, offs, plen, hash_p2);
 		if (err)
 			goto out_ro;
 	}
@@ -1066,6 +1088,11 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	int last_reference = !!(new_inode && new_inode->i_nlink == 0);
 	int move = (old_dir != new_dir);
 	struct ubifs_inode *uninitialized_var(new_ui);
+	u8 hash_old_dir[UBIFS_MAX_HASH_LEN];
+	u8 hash_new_dir[UBIFS_MAX_HASH_LEN];
+	u8 hash_new_inode[UBIFS_MAX_HASH_LEN];
+	u8 hash_dent1[UBIFS_MAX_HASH_LEN];
+	u8 hash_dent2[UBIFS_MAX_HASH_LEN];
 
 	ubifs_assert(ubifs_inode(old_dir)->data_len == 0);
 	ubifs_assert(ubifs_inode(new_dir)->data_len == 0);
@@ -1108,6 +1135,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	set_dent_cookie(c, dent);
 	zero_dent_node_unused(dent);
 	ubifs_prep_grp_node(c, dent, dlen1, 0);
+	ubifs_node_calc_hash(c, dent, hash_dent1);
 
 	dent2 = (void *)dent + aligned_dlen1;
 	dent2->ch.node_type = UBIFS_DENT_NODE;
@@ -1127,19 +1155,24 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	set_dent_cookie(c, dent2);
 	zero_dent_node_unused(dent2);
 	ubifs_prep_grp_node(c, dent2, dlen2, 0);
+	ubifs_node_calc_hash(c, dent2, hash_dent2);
 
 	p = (void *)dent2 + aligned_dlen2;
 	if (new_inode) {
 		pack_inode(c, p, new_inode, 0);
+		ubifs_node_calc_hash(c, p, hash_new_inode);
 		p += ALIGN(ilen, 8);
 	}
 
-	if (!move)
+	if (!move) {
 		pack_inode(c, p, old_dir, 1);
-	else {
+		ubifs_node_calc_hash(c, p, hash_old_dir);
+	} else {
 		pack_inode(c, p, old_dir, 0);
+		ubifs_node_calc_hash(c, p, hash_old_dir);
 		p += ALIGN(plen, 8);
 		pack_inode(c, p, new_dir, 1);
+		ubifs_node_calc_hash(c, p, hash_new_dir);
 	}
 
 	if (last_reference) {
@@ -1166,14 +1199,14 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	release_head(c, BASEHD);
 
 	dent_key_init(c, &key, new_dir->i_ino, new_nm);
-	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, new_nm);
+	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, hash_dent1, new_nm);
 	if (err)
 		goto out_ro;
 
 	offs += aligned_dlen1;
 	if (whiteout) {
 		dent_key_init(c, &key, old_dir->i_ino, old_nm);
-		err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen2, old_nm);
+		err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen2, hash_dent2, old_nm);
 		if (err)
 			goto out_ro;
 
@@ -1192,21 +1225,21 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	offs += aligned_dlen2;
 	if (new_inode) {
 		ino_key_init(c, &key, new_inode->i_ino);
-		err = ubifs_tnc_add(c, &key, lnum, offs, ilen);
+		err = ubifs_tnc_add(c, &key, lnum, offs, ilen, hash_new_inode);
 		if (err)
 			goto out_ro;
 		offs += ALIGN(ilen, 8);
 	}
 
 	ino_key_init(c, &key, old_dir->i_ino);
-	err = ubifs_tnc_add(c, &key, lnum, offs, plen);
+	err = ubifs_tnc_add(c, &key, lnum, offs, plen, hash_old_dir);
 	if (err)
 		goto out_ro;
 
 	if (move) {
 		offs += ALIGN(plen, 8);
 		ino_key_init(c, &key, new_dir->i_ino);
-		err = ubifs_tnc_add(c, &key, lnum, offs, plen);
+		err = ubifs_tnc_add(c, &key, lnum, offs, plen, hash_new_dir);
 		if (err)
 			goto out_ro;
 	}
@@ -1326,6 +1359,8 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	ino_t inum = inode->i_ino;
 	unsigned int blk;
+	u8 hash_ino[UBIFS_MAX_HASH_LEN];
+	u8 hash_dn[UBIFS_MAX_HASH_LEN];
 
 	dbg_jnl("ino %lu, size %lld -> %lld",
 		(unsigned long)inum, old_size, new_size);
@@ -1378,9 +1413,13 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 		goto out_free;
 
 	pack_inode(c, ino, inode, 0);
+	ubifs_node_calc_hash(c, ino, hash_ino);
+
 	ubifs_prep_grp_node(c, trun, UBIFS_TRUN_NODE_SZ, dlen ? 0 : 1);
-	if (dlen)
+	if (dlen) {
 		ubifs_prep_grp_node(c, dn, dlen, 1);
+		ubifs_node_calc_hash(c, dn, hash_dn);
+	}
 
 	err = write_head(c, BASEHD, ino, len, &lnum, &offs, sync);
 	if (err)
@@ -1391,13 +1430,13 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 
 	if (dlen) {
 		sz = offs + UBIFS_INO_NODE_SZ + UBIFS_TRUN_NODE_SZ;
-		err = ubifs_tnc_add(c, &key, lnum, sz, dlen);
+		err = ubifs_tnc_add(c, &key, lnum, sz, dlen, hash_dn);
 		if (err)
 			goto out_ro;
 	}
 
 	ino_key_init(c, &key, inum);
-	err = ubifs_tnc_add(c, &key, lnum, offs, UBIFS_INO_NODE_SZ);
+	err = ubifs_tnc_add(c, &key, lnum, offs, UBIFS_INO_NODE_SZ, hash_ino);
 	if (err)
 		goto out_ro;
 
@@ -1458,6 +1497,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	union ubifs_key xent_key, key1, key2;
 	int sync = IS_DIRSYNC(host);
 	struct ubifs_inode *host_ui = ubifs_inode(host);
+	u8 hash[UBIFS_MAX_HASH_LEN];
 
 	ubifs_assert(inode->i_nlink == 0);
 	ubifs_assert(mutex_is_locked(&host_ui->ui_mutex));
@@ -1497,6 +1537,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	pack_inode(c, ino, inode, 0);
 	ino = (void *)ino + UBIFS_INO_NODE_SZ;
 	pack_inode(c, ino, host, 1);
+	ubifs_node_calc_hash(c, ino, hash);
 
 	err = write_head(c, BASEHD, xent, len, &lnum, &xent_offs, sync);
 	if (!sync && !err)
@@ -1529,7 +1570,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 
 	/* And update TNC with the new host inode position */
 	ino_key_init(c, &key1, host->i_ino);
-	err = ubifs_tnc_add(c, &key1, lnum, xent_offs + len - hlen, hlen);
+	err = ubifs_tnc_add(c, &key1, lnum, xent_offs + len - hlen, hlen, hash);
 	if (err)
 		goto out_ro;
 
@@ -1567,6 +1608,8 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	struct ubifs_ino_node *ino;
 	union ubifs_key key;
 	int sync = IS_DIRSYNC(host);
+	u8 hash_host[UBIFS_MAX_HASH_LEN];
+	u8 hash[UBIFS_MAX_HASH_LEN];
 
 	dbg_jnl("ino %lu, ino %lu", host->i_ino, inode->i_ino);
 	ubifs_assert(host->i_nlink > 0);
@@ -1588,7 +1631,9 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 		goto out_free;
 
 	pack_inode(c, ino, host, 0);
+	ubifs_node_calc_hash(c, ino, hash_host);
 	pack_inode(c, (void *)ino + aligned_len1, inode, 1);
+	ubifs_node_calc_hash(c, (void *)ino + aligned_len1, hash);
 
 	err = write_head(c, BASEHD, ino, aligned_len, &lnum, &offs, 0);
 	if (!sync && !err) {
@@ -1602,12 +1647,12 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 		goto out_ro;
 
 	ino_key_init(c, &key, host->i_ino);
-	err = ubifs_tnc_add(c, &key, lnum, offs, len1);
+	err = ubifs_tnc_add(c, &key, lnum, offs, len1, hash_host);
 	if (err)
 		goto out_ro;
 
 	ino_key_init(c, &key, inode->i_ino);
-	err = ubifs_tnc_add(c, &key, lnum, offs + aligned_len1, len2);
+	err = ubifs_tnc_add(c, &key, lnum, offs + aligned_len1, len2, hash);
 	if (err)
 		goto out_ro;
 
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 85c2a43082b7..7693556e5bd3 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -228,7 +228,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			err = ubifs_tnc_remove_nm(c, &r->key, &r->nm);
 		else
 			err = ubifs_tnc_add_nm(c, &r->key, r->lnum, r->offs,
-					       r->len, &r->nm);
+					       r->len, NULL, &r->nm);
 	} else {
 		if (r->deletion)
 			switch (key_type(c, &r->key)) {
@@ -248,7 +248,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			}
 		else
 			err = ubifs_tnc_add(c, &r->key, r->lnum, r->offs,
-					    r->len);
+					    r->len, NULL);
 		if (err)
 			return err;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 2c42d1a1842a..a47fced47823 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -2259,13 +2259,14 @@ static int tnc_insert(struct ubifs_info *c, struct ubifs_znode *znode,
  * @lnum: LEB number of node
  * @offs: node offset
  * @len: node length
+ * @hash: The hash over the node
  *
  * This function adds a node with key @key to TNC. The node may be new or it may
  * obsolete some existing one. Returns %0 on success or negative error code on
  * failure.
  */
 int ubifs_tnc_add(struct ubifs_info *c, const union ubifs_key *key, int lnum,
-		  int offs, int len)
+		  int offs, int len, const u8 *hash)
 {
 	int found, n, err = 0;
 	struct ubifs_znode *znode;
@@ -2280,6 +2281,7 @@ int ubifs_tnc_add(struct ubifs_info *c, const union ubifs_key *key, int lnum,
 		zbr.lnum = lnum;
 		zbr.offs = offs;
 		zbr.len = len;
+		ubifs_copy_hash(c, hash, zbr.hash);
 		key_copy(c, key, &zbr.key);
 		err = tnc_insert(c, znode, &zbr, n + 1);
 	} else if (found == 1) {
@@ -2290,6 +2292,7 @@ int ubifs_tnc_add(struct ubifs_info *c, const union ubifs_key *key, int lnum,
 		zbr->lnum = lnum;
 		zbr->offs = offs;
 		zbr->len = len;
+		ubifs_copy_hash(c, hash, zbr->hash);
 	} else
 		err = found;
 	if (!err)
@@ -2391,13 +2394,14 @@ int ubifs_tnc_replace(struct ubifs_info *c, const union ubifs_key *key,
  * @lnum: LEB number of node
  * @offs: node offset
  * @len: node length
+ * @hash: The hash over the node
  * @nm: node name
  *
  * This is the same as 'ubifs_tnc_add()' but it should be used with keys which
  * may have collisions, like directory entry keys.
  */
 int ubifs_tnc_add_nm(struct ubifs_info *c, const union ubifs_key *key,
-		     int lnum, int offs, int len,
+		     int lnum, int offs, int len, const u8 *hash,
 		     const struct fscrypt_name *nm)
 {
 	int found, n, err = 0;
@@ -2440,6 +2444,7 @@ int ubifs_tnc_add_nm(struct ubifs_info *c, const union ubifs_key *key,
 			zbr->lnum = lnum;
 			zbr->offs = offs;
 			zbr->len = len;
+			ubifs_copy_hash(c, hash, zbr->hash);
 			goto out_unlock;
 		}
 	}
@@ -2451,6 +2456,7 @@ int ubifs_tnc_add_nm(struct ubifs_info *c, const union ubifs_key *key,
 		zbr.lnum = lnum;
 		zbr.offs = offs;
 		zbr.len = len;
+		ubifs_copy_hash(c, hash, zbr.hash);
 		key_copy(c, key, &zbr.key);
 		err = tnc_insert(c, znode, &zbr, n + 1);
 		if (err)
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index d8a7276e83df..24ee376147e1 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -727,6 +727,7 @@ struct ubifs_jhead {
  * @lnum: LEB number of the target node (indexing node or data node)
  * @offs: target node offset within @lnum
  * @len: target node length
+ * @hash: the hash of the target node
  */
 struct ubifs_zbranch {
 	union ubifs_key key;
@@ -737,6 +738,7 @@ struct ubifs_zbranch {
 	int lnum;
 	int offs;
 	int len;
+	u8 hash[UBIFS_MAX_HASH_LEN];
 };
 
 /**
@@ -1773,11 +1775,12 @@ int ubifs_tnc_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
 int ubifs_tnc_locate(struct ubifs_info *c, const union ubifs_key *key,
 		     void *node, int *lnum, int *offs);
 int ubifs_tnc_add(struct ubifs_info *c, const union ubifs_key *key, int lnum,
-		  int offs, int len);
+		  int offs, int len, const u8 *hash);
 int ubifs_tnc_replace(struct ubifs_info *c, const union ubifs_key *key,
 		      int old_lnum, int old_offs, int lnum, int offs, int len);
 int ubifs_tnc_add_nm(struct ubifs_info *c, const union ubifs_key *key,
-		     int lnum, int offs, int len, const struct fscrypt_name *nm);
+		     int lnum, int offs, int len, const u8 *hash,
+		     const struct fscrypt_name *nm);
 int ubifs_tnc_remove(struct ubifs_info *c, const union ubifs_key *key);
 int ubifs_tnc_remove_nm(struct ubifs_info *c, const union ubifs_key *key,
 			const struct fscrypt_name *nm);
-- 
2.18.0


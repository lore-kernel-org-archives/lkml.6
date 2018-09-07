Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0013D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeIGRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59253 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbeIGRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007c0-NK; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00062L-H2; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 15/25] ubifs: Add authentication nodes to journal
Date:   Fri,  7 Sep 2018 14:36:36 +0200
Message-Id: <20180907123646.12688-16-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907123646.12688-1-s.hauer@pengutronix.de>
References: <20180907123646.12688-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes that are written to flash can only be authenticated through the
index after the next commit. When a journal replay is necessary the
nodes are not yet referenced by the index and thus can't be
authenticated.

This patch overcomes this situation by creating a hash over all nodes
beginning from the commit start node over the reference node(s) and
the buds themselves. From
time to time we insert authentication nodes. Authentication nodes
contain a HMAC from the current hash state, so that they can be
used to authenticate a journal replay up to the point where the
authentication node is. The hash is continued afterwards
so that theoretically we would only have to check the HMAC of
the last authentication node we find.

Overall we get this picture:

,,,,,,,,
,......,...........................................
,. CS  ,               hash1.----.           hash2.----.
,.  |  ,                    .    |hmac            .    |hmac
,.  v  ,                    .    v                .    v
,.REF#0,-> bud -> bud -> bud.-> auth -> bud -> bud.-> auth ...
,..|...,...........................................
,  |   ,
,  |   ,,,,,,,,,,,,,,,
.  |            hash3,----.
,  |                 ,    |hmac
,  v                 ,    v
, REF#1 -> bud -> bud,-> auth ...
,,,|,,,,,,,,,,,,,,,,,,
   v
  REF#2 -> ...
   |
   V
  ...

Note how hash3 covers CS, REF#0 and REF#1 so that it is not possible to
exchange or skip any reference nodes. Unlike the picture suggests the
auth nodes themselves are not hashed.

With this it is possible for an offline attacker to cut each journal
head or to drop the last reference node(s), but not to skip any journal
heads or to reorder any operations.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/gc.c      |   3 +-
 fs/ubifs/journal.c | 124 ++++++++++++++++++++++++++++++++++++++-------
 fs/ubifs/log.c     |  24 +++++++++
 fs/ubifs/replay.c  |   2 +
 fs/ubifs/super.c   |  10 ++++
 fs/ubifs/ubifs.h   |   8 +++
 6 files changed, 153 insertions(+), 18 deletions(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index d2680e0b4a36..399d764f83cb 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -254,7 +254,8 @@ static int sort_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 			     snod->type == UBIFS_DATA_NODE ||
 			     snod->type == UBIFS_DENT_NODE ||
 			     snod->type == UBIFS_XENT_NODE ||
-			     snod->type == UBIFS_TRUN_NODE);
+			     snod->type == UBIFS_TRUN_NODE ||
+			     snod->type == UBIFS_AUTH_NODE);
 
 		if (snod->type != UBIFS_INO_NODE  &&
 		    snod->type != UBIFS_DATA_NODE &&
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 7c12bdfa9a7a..729dc76c83df 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -90,6 +90,12 @@ static inline void zero_trun_node_unused(struct ubifs_trun_node *trun)
 	memset(trun->padding, 0, 12);
 }
 
+static void ubifs_add_auth_dirt(struct ubifs_info *c, int lnum)
+{
+	if (ubifs_authenticated(c))
+		ubifs_add_dirt(c, lnum, ubifs_auth_node_sz(c));
+}
+
 /**
  * reserve_space - reserve space in the journal.
  * @c: UBIFS file-system description object
@@ -228,6 +234,35 @@ static int reserve_space(struct ubifs_info *c, int jhead, int len)
 	return err;
 }
 
+static int ubifs_hash_nodes(struct ubifs_info *c, void *node,
+			     int len, struct shash_desc *hash)
+{
+	int auth_node_size = ubifs_auth_node_sz(c);
+	int err;
+
+	while (1) {
+		const struct ubifs_ch *ch = node;
+		int nodelen = le32_to_cpu(ch->len);
+
+		ubifs_assert(c, len >= auth_node_size);
+
+		if (len == auth_node_size)
+			break;
+
+		ubifs_assert(c, len > nodelen);
+		ubifs_assert(c, ch->magic == cpu_to_le32(UBIFS_NODE_MAGIC));
+
+		err = ubifs_shash_update(c, hash, (void *)node, nodelen);
+		if (err)
+			return err;
+
+		node += ALIGN(nodelen, 8);
+		len -= ALIGN(nodelen, 8);
+	}
+
+	return ubifs_prepare_auth_node(c, node, hash);
+}
+
 /**
  * write_head - write data to a journal head.
  * @c: UBIFS file-system description object
@@ -255,6 +290,12 @@ static int write_head(struct ubifs_info *c, int jhead, void *buf, int len,
 	dbg_jnl("jhead %s, LEB %d:%d, len %d",
 		dbg_jhead(jhead), *lnum, *offs, len);
 
+	if (ubifs_authenticated(c)) {
+		err = ubifs_hash_nodes(c, buf, len, c->jheads[jhead].log_hash);
+		if (err)
+			return err;
+	}
+
 	err = ubifs_wbuf_write_nolock(wbuf, buf, len);
 	if (err)
 		return err;
@@ -543,7 +584,10 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 
 	len = aligned_dlen + aligned_ilen + UBIFS_INO_NODE_SZ;
 	/* Make sure to also account for extended attributes */
-	len += host_ui->data_len;
+	if (ubifs_authenticated(c))
+		len += ALIGN(host_ui->data_len, 8) + ubifs_auth_node_sz(c);
+	else
+		len += host_ui->data_len;
 
 	dent = kzalloc(len, GFP_NOFS);
 	if (!dent)
@@ -611,6 +655,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	}
 	release_head(c, BASEHD);
 	kfree(dent);
+	ubifs_add_auth_dirt(c, lnum);
 
 	if (deletion) {
 		if (nm->hash)
@@ -690,8 +735,9 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 			 const union ubifs_key *key, const void *buf, int len)
 {
 	struct ubifs_data_node *data;
-	int err, lnum, offs, compr_type, out_len, compr_len;
+	int err, lnum, offs, compr_type, out_len, compr_len, auth_len;
 	int dlen = COMPRESSED_DATA_NODE_BUF_SZ, allocated = 1;
+	int write_len;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	bool encrypted = ubifs_crypt_is_encrypted(inode);
 	u8 hash[UBIFS_HASH_ARR_SZ];
@@ -703,7 +749,9 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	if (encrypted)
 		dlen += UBIFS_CIPHER_BLOCK_SIZE;
 
-	data = kmalloc(dlen, GFP_NOFS | __GFP_NOWARN);
+	auth_len = ubifs_auth_node_sz(c);
+
+	data = kmalloc(dlen + auth_len, GFP_NOFS | __GFP_NOWARN);
 	if (!data) {
 		/*
 		 * Fall-back to the write reserve buffer. Note, we might be
@@ -742,15 +790,20 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	}
 
 	dlen = UBIFS_DATA_NODE_SZ + out_len;
+	if (ubifs_authenticated(c))
+		write_len = ALIGN(dlen, 8) + auth_len;
+	else
+		write_len = dlen;
+
 	data->compr_type = cpu_to_le16(compr_type);
 
 	/* Make reservation before allocating sequence numbers */
-	err = make_reservation(c, DATAHD, dlen);
+	err = make_reservation(c, DATAHD, write_len);
 	if (err)
 		goto out_free;
 
 	ubifs_prepare_node(c, data, dlen, 0);
-	err = write_head(c, DATAHD, data, dlen, &lnum, &offs, 0);
+	err = write_head(c, DATAHD, data, write_len, &lnum, &offs, 0);
 	if (err)
 		goto out_release;
 
@@ -761,6 +814,8 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	ubifs_wbuf_add_ino_nolock(&c->jheads[DATAHD].wbuf, key_inum(c, key));
 	release_head(c, DATAHD);
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	err = ubifs_tnc_add(c, key, lnum, offs, dlen, hash);
 	if (err)
 		goto out_ro;
@@ -799,7 +854,8 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	int err, lnum, offs;
 	struct ubifs_ino_node *ino;
 	struct ubifs_inode *ui = ubifs_inode(inode);
-	int sync = 0, len = UBIFS_INO_NODE_SZ, last_reference = !inode->i_nlink;
+	int sync = 0, write_len, ilen = UBIFS_INO_NODE_SZ;
+	int last_reference = !inode->i_nlink;
 	u8 hash[UBIFS_HASH_ARR_SZ];
 
 	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
@@ -809,15 +865,21 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	 * need to synchronize the write-buffer either.
 	 */
 	if (!last_reference) {
-		len += ui->data_len;
+		ilen += ui->data_len;
 		sync = IS_SYNC(inode);
 	}
-	ino = kmalloc(len, GFP_NOFS);
+
+	if (ubifs_authenticated(c))
+		write_len = ALIGN(ilen, 8) + ubifs_auth_node_sz(c);
+	else
+		write_len = ilen;
+
+	ino = kmalloc(write_len, GFP_NOFS);
 	if (!ino)
 		return -ENOMEM;
 
 	/* Make reservation before allocating sequence numbers */
-	err = make_reservation(c, BASEHD, len);
+	err = make_reservation(c, BASEHD, write_len);
 	if (err)
 		goto out_free;
 
@@ -826,7 +888,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	if (err)
 		goto out_release;
 
-	err = write_head(c, BASEHD, ino, len, &lnum, &offs, sync);
+	err = write_head(c, BASEHD, ino, write_len, &lnum, &offs, sync);
 	if (err)
 		goto out_release;
 	if (!sync)
@@ -834,17 +896,19 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 					  inode->i_ino);
 	release_head(c, BASEHD);
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	if (last_reference) {
 		err = ubifs_tnc_remove_ino(c, inode->i_ino);
 		if (err)
 			goto out_ro;
 		ubifs_delete_orphan(c, inode->i_ino);
-		err = ubifs_add_dirt(c, lnum, len);
+		err = ubifs_add_dirt(c, lnum, ilen);
 	} else {
 		union ubifs_key key;
 
 		ino_key_init(c, &key, inode->i_ino);
-		err = ubifs_tnc_add(c, &key, lnum, offs, len, hash);
+		err = ubifs_tnc_add(c, &key, lnum, offs, ilen, hash);
 	}
 	if (err)
 		goto out_ro;
@@ -973,6 +1037,8 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	if (twoparents)
 		len += plen;
 
+	len += ubifs_auth_node_sz(c);
+
 	dent1 = kzalloc(len, GFP_NOFS);
 	if (!dent1)
 		return -ENOMEM;
@@ -1042,6 +1108,8 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
 	}
 	release_head(c, BASEHD);
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	dent_key_init(c, &key, snd_dir->i_ino, snd_nm);
 	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, hash_dent1, snd_nm);
 	if (err)
@@ -1143,6 +1211,9 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	len = aligned_dlen1 + aligned_dlen2 + ALIGN(ilen, 8) + ALIGN(plen, 8);
 	if (move)
 		len += plen;
+
+	len += ubifs_auth_node_sz(c);
+
 	dent = kzalloc(len, GFP_NOFS);
 	if (!dent)
 		return -ENOMEM;
@@ -1240,6 +1311,8 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 	}
 	release_head(c, BASEHD);
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	dent_key_init(c, &key, new_dir->i_ino, new_nm);
 	err = ubifs_tnc_add_nm(c, &key, lnum, offs, dlen1, hash_dent1, new_nm);
 	if (err)
@@ -1411,6 +1484,9 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 
 	sz = UBIFS_TRUN_NODE_SZ + UBIFS_INO_NODE_SZ +
 	     UBIFS_MAX_DATA_NODE_SZ * WORST_COMPR_FACTOR;
+
+	sz += ubifs_auth_node_sz(c);
+
 	ino = kmalloc(sz, GFP_NOFS);
 	if (!ino)
 		return -ENOMEM;
@@ -1456,8 +1532,12 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 
 	/* Must make reservation before allocating sequence numbers */
 	len = UBIFS_TRUN_NODE_SZ + UBIFS_INO_NODE_SZ;
-	if (dlen)
+
+	if (ubifs_authenticated(c))
+		len += ALIGN(dlen, 8) + ubifs_auth_node_sz(c);
+	else
 		len += dlen;
+
 	err = make_reservation(c, BASEHD, len);
 	if (err)
 		goto out_free;
@@ -1482,6 +1562,8 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 		ubifs_wbuf_add_ino_nolock(&c->jheads[BASEHD].wbuf, inum);
 	release_head(c, BASEHD);
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	if (dlen) {
 		sz = offs + UBIFS_INO_NODE_SZ + UBIFS_TRUN_NODE_SZ;
 		err = ubifs_tnc_add(c, &key, lnum, sz, dlen, hash_dn);
@@ -1545,7 +1627,7 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 			   const struct inode *inode,
 			   const struct fscrypt_name *nm)
 {
-	int err, xlen, hlen, len, lnum, xent_offs, aligned_xlen;
+	int err, xlen, hlen, len, lnum, xent_offs, aligned_xlen, write_len;
 	struct ubifs_dent_node *xent;
 	struct ubifs_ino_node *ino;
 	union ubifs_key xent_key, key1, key2;
@@ -1565,12 +1647,14 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	hlen = host_ui->data_len + UBIFS_INO_NODE_SZ;
 	len = aligned_xlen + UBIFS_INO_NODE_SZ + ALIGN(hlen, 8);
 
-	xent = kzalloc(len, GFP_NOFS);
+	write_len = len + ubifs_auth_node_sz(c);
+
+	xent = kzalloc(write_len, GFP_NOFS);
 	if (!xent)
 		return -ENOMEM;
 
 	/* Make reservation before allocating sequence numbers */
-	err = make_reservation(c, BASEHD, len);
+	err = make_reservation(c, BASEHD, write_len);
 	if (err) {
 		kfree(xent);
 		return err;
@@ -1595,10 +1679,12 @@ int ubifs_jnl_delete_xattr(struct ubifs_info *c, const struct inode *host,
 	if (err)
 		goto out_release;
 
-	err = write_head(c, BASEHD, xent, len, &lnum, &xent_offs, sync);
+	err = write_head(c, BASEHD, xent, write_len, &lnum, &xent_offs, sync);
 	if (!sync && !err)
 		ubifs_wbuf_add_ino_nolock(&c->jheads[BASEHD].wbuf, host->i_ino);
 	release_head(c, BASEHD);
+
+	ubifs_add_auth_dirt(c, lnum);
 	kfree(xent);
 	if (err)
 		goto out_ro;
@@ -1680,6 +1766,8 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	aligned_len1 = ALIGN(len1, 8);
 	aligned_len = aligned_len1 + ALIGN(len2, 8);
 
+	aligned_len += ubifs_auth_node_sz(c);
+
 	ino = kzalloc(aligned_len, GFP_NOFS);
 	if (!ino)
 		return -ENOMEM;
@@ -1709,6 +1797,8 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	if (err)
 		goto out_ro;
 
+	ubifs_add_auth_dirt(c, lnum);
+
 	ino_key_init(c, &key, host->i_ino);
 	err = ubifs_tnc_add(c, &key, lnum, offs, len1, hash_host);
 	if (err)
diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 86b0828f5499..15fd854149bb 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -236,6 +236,7 @@ int ubifs_add_bud_to_log(struct ubifs_info *c, int jhead, int lnum, int offs)
 	bud->lnum = lnum;
 	bud->start = offs;
 	bud->jhead = jhead;
+	bud->log_hash = NULL;
 
 	ref->ch.node_type = UBIFS_REF_NODE;
 	ref->lnum = cpu_to_le32(bud->lnum);
@@ -275,6 +276,14 @@ int ubifs_add_bud_to_log(struct ubifs_info *c, int jhead, int lnum, int offs)
 	if (err)
 		goto out_unlock;
 
+	err = ubifs_shash_update(c, c->log_hash, ref, UBIFS_REF_NODE_SZ);
+	if (err)
+		goto out_unlock;
+
+	err = ubifs_shash_copy_state(c, c->log_hash, c->jheads[jhead].log_hash);
+	if (err)
+		goto out_unlock;
+
 	c->lhead_offs += c->ref_node_alsz;
 
 	ubifs_add_bud(c, bud);
@@ -377,6 +386,14 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 	cs->cmt_no = cpu_to_le64(c->cmt_no);
 	ubifs_prepare_node(c, cs, UBIFS_CS_NODE_SZ, 0);
 
+	err = ubifs_shash_init(c, c->log_hash);
+	if (err)
+		goto out;
+
+	err = ubifs_shash_update(c, c->log_hash, cs, UBIFS_CS_NODE_SZ);
+	if (err < 0)
+		goto out;
+
 	/*
 	 * Note, we do not lock 'c->log_mutex' because this is the commit start
 	 * phase and we are exclusively using the log. And we do not lock
@@ -402,6 +419,12 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 
 		ubifs_prepare_node(c, ref, UBIFS_REF_NODE_SZ, 0);
 		len += UBIFS_REF_NODE_SZ;
+
+		err = ubifs_shash_update(c, c->log_hash, ref,
+					 UBIFS_REF_NODE_SZ);
+		if (err)
+			goto out;
+		ubifs_shash_copy_state(c, c->log_hash, c->jheads[i].log_hash);
 	}
 
 	ubifs_pad(c, buf + len, ALIGN(len, c->min_io_size) - len);
@@ -516,6 +539,7 @@ int ubifs_log_post_commit(struct ubifs_info *c, int old_ltail_lnum)
 		if (err)
 			return err;
 		list_del(&bud->list);
+		kfree(bud->log_hash);
 		kfree(bud);
 	}
 	mutex_lock(&c->log_mutex);
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 1c6ceb6265aa..db489d93439c 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -666,6 +666,8 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 					  old_size, new_size);
 			break;
 		}
+		case UBIFS_AUTH_NODE:
+			break;
 		default:
 			ubifs_err(c, "unexpected node type %d in bud LEB %d:%d",
 				  snod->type, lnum, snod->offs);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 143044e0378f..46d0d375cf8d 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -817,6 +817,9 @@ static int alloc_wbufs(struct ubifs_info *c)
 		c->jheads[i].wbuf.sync_callback = &bud_wbuf_callback;
 		c->jheads[i].wbuf.jhead = i;
 		c->jheads[i].grouped = 1;
+		c->jheads[i].log_hash = ubifs_hash_get_desc(c);
+		if (IS_ERR(c->jheads[i].log_hash))
+			goto out;
 	}
 
 	/*
@@ -827,6 +830,12 @@ static int alloc_wbufs(struct ubifs_info *c)
 	c->jheads[GCHD].grouped = 0;
 
 	return 0;
+
+out:
+	while (i--)
+		kfree(c->jheads[i].log_hash);
+
+	return err;
 }
 
 /**
@@ -841,6 +850,7 @@ static void free_wbufs(struct ubifs_info *c)
 		for (i = 0; i < c->jhead_cnt; i++) {
 			kfree(c->jheads[i].wbuf.buf);
 			kfree(c->jheads[i].wbuf.inodes);
+			kfree(c->jheads[i].log_hash);
 		}
 		kfree(c->jheads);
 		c->jheads = NULL;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 67bfd58d28d4..600a25b93a80 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -717,6 +717,7 @@ struct ubifs_wbuf {
  * @jhead: journal head number this bud belongs to
  * @list: link in the list buds belonging to the same journal head
  * @rb: link in the tree of all buds
+ * @log_hash: the log hash from the commit start node up to this bud
  */
 struct ubifs_bud {
 	int lnum;
@@ -724,6 +725,7 @@ struct ubifs_bud {
 	int jhead;
 	struct list_head list;
 	struct rb_node rb;
+	struct shash_desc *log_hash;
 };
 
 /**
@@ -731,6 +733,7 @@ struct ubifs_bud {
  * @wbuf: head's write-buffer
  * @buds_list: list of bud LEBs belonging to this journal head
  * @grouped: non-zero if UBIFS groups nodes when writing to this journal head
+ * @log_hash: the log hash from the commit start node up to this journal head
  *
  * Note, the @buds list is protected by the @c->buds_lock.
  */
@@ -738,6 +741,7 @@ struct ubifs_jhead {
 	struct ubifs_wbuf wbuf;
 	struct list_head buds_list;
 	unsigned int grouped:1;
+	struct shash_desc *log_hash;
 };
 
 /**
@@ -1236,6 +1240,8 @@ struct ubifs_debug_info;
  * @auth_key_name: the authentication key name
  * @auth_hash_name: the name of the hash algorithm used for authentication
  * @auth_hash_algo: the authentication hash used for this fs
+ * @log_hash: the log hash from the commit start node up to the latest reference
+ *            node.
  *
  * @empty: %1 if the UBI device is empty
  * @need_recovery: %1 if the file-system needs recovery
@@ -1478,6 +1484,8 @@ struct ubifs_info {
 	char *auth_hash_name;
 	enum hash_algo auth_hash_algo;
 
+	struct shash_desc *log_hash;
+
 	/* The below fields are used only during mounting and re-mounting */
 	unsigned int empty:1;
 	unsigned int need_recovery:1;
-- 
2.18.0


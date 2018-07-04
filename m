Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54244C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06144208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06144208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeGDMnb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:43:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44943 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934713AbeGDMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dV-Ra; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Zm-JO; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 13/25] ubifs: authentication: Add hashes to index nodes
Date:   Wed,  4 Jul 2018 14:41:25 +0200
Message-Id: <20180704124137.13396-14-s.hauer@pengutronix.de>
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

With this patch the hashes over the index nodes stored in the tree node
cache are written to flash and are checked when read back from flash.
The hash of the root index node is stored in the master node.

During journal replay the hashes are regenerated from the read nodes
and stored in the tree node cache. This means the nodes must previously
be authenticated by other means. This is done in a later patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/master.c     |  3 +++
 fs/ubifs/misc.h       |  5 +++--
 fs/ubifs/replay.c     | 29 ++++++++++++++++++-----------
 fs/ubifs/tnc.c        | 13 +++++++++++++
 fs/ubifs/tnc_commit.c | 26 ++++++++++++++++++++++++++
 fs/ubifs/tnc_misc.c   | 16 +++++++++++++++-
 fs/ubifs/ubifs.h      |  4 ++++
 7 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index c6a5e39e2ba5..f1a96b50ec68 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -305,6 +305,8 @@ int ubifs_read_master(struct ubifs_info *c)
 	c->lst.total_dead  = le64_to_cpu(c->mst_node->total_dead);
 	c->lst.total_dark  = le64_to_cpu(c->mst_node->total_dark);
 
+	ubifs_copy_hash(c, c->mst_node->hash_root_idx, c->zroot.hash);
+
 	c->calc_idx_sz = c->bi.old_idx_sz;
 
 	if (c->mst_node->flags & cpu_to_le32(UBIFS_MST_NO_ORPHS))
@@ -378,6 +380,7 @@ int ubifs_write_master(struct ubifs_info *c)
 	c->mst_offs = offs;
 	c->mst_node->highest_inum = cpu_to_le64(c->highest_inum);
 
+	ubifs_copy_hash(c, c->zroot.hash, c->mst_node->hash_root_idx);
 	err = ubifs_write_node(c, c->mst_node, len, lnum, offs);
 	if (err)
 		return err;
diff --git a/fs/ubifs/misc.h b/fs/ubifs/misc.h
index caf83d68fb38..8b00418f3197 100644
--- a/fs/ubifs/misc.h
+++ b/fs/ubifs/misc.h
@@ -195,7 +195,8 @@ static inline int ubifs_return_leb(struct ubifs_info *c, int lnum)
  */
 static inline int ubifs_idx_node_sz(const struct ubifs_info *c, int child_cnt)
 {
-	return UBIFS_IDX_NODE_SZ + (UBIFS_BRANCH_SZ + c->key_len) * child_cnt;
+	return UBIFS_IDX_NODE_SZ + (UBIFS_BRANCH_SZ + c->key_len + c->hash_len)
+				   * child_cnt;
 }
 
 /**
@@ -210,7 +211,7 @@ struct ubifs_branch *ubifs_idx_branch(const struct ubifs_info *c,
 				      int bnum)
 {
 	return (struct ubifs_branch *)((void *)idx->branches +
-				       (UBIFS_BRANCH_SZ + c->key_len) * bnum);
+			(UBIFS_BRANCH_SZ + c->key_len + c->hash_len) * bnum);
 }
 
 /**
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 7693556e5bd3..9e9ff753515f 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -56,6 +56,7 @@ struct replay_entry {
 	int lnum;
 	int offs;
 	int len;
+	u8 hash[UBIFS_MAX_HASH_LEN];
 	unsigned int deletion:1;
 	unsigned long long sqnum;
 	struct list_head list;
@@ -228,7 +229,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			err = ubifs_tnc_remove_nm(c, &r->key, &r->nm);
 		else
 			err = ubifs_tnc_add_nm(c, &r->key, r->lnum, r->offs,
-					       r->len, NULL, &r->nm);
+					       r->len, r->hash, &r->nm);
 	} else {
 		if (r->deletion)
 			switch (key_type(c, &r->key)) {
@@ -248,7 +249,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
 			}
 		else
 			err = ubifs_tnc_add(c, &r->key, r->lnum, r->offs,
-					    r->len, NULL);
+					    r->len, r->hash);
 		if (err)
 			return err;
 
@@ -351,9 +352,9 @@ static void destroy_replay_list(struct ubifs_info *c)
  * in case of success and a negative error code in case of failure.
  */
 static int insert_node(struct ubifs_info *c, int lnum, int offs, int len,
-		       union ubifs_key *key, unsigned long long sqnum,
-		       int deletion, int *used, loff_t old_size,
-		       loff_t new_size)
+		       const u8 *hash, union ubifs_key *key,
+		       unsigned long long sqnum, int deletion, int *used,
+		       loff_t old_size, loff_t new_size)
 {
 	struct replay_entry *r;
 
@@ -371,6 +372,7 @@ static int insert_node(struct ubifs_info *c, int lnum, int offs, int len,
 	r->lnum = lnum;
 	r->offs = offs;
 	r->len = len;
+	ubifs_copy_hash(c, hash, r->hash);
 	r->deletion = !!deletion;
 	r->sqnum = sqnum;
 	key_copy(c, key, &r->key);
@@ -399,8 +401,9 @@ static int insert_node(struct ubifs_info *c, int lnum, int offs, int len,
  * negative error code in case of failure.
  */
 static int insert_dent(struct ubifs_info *c, int lnum, int offs, int len,
-		       union ubifs_key *key, const char *name, int nlen,
-		       unsigned long long sqnum, int deletion, int *used)
+		       const u8 *hash, union ubifs_key *key,
+		       const char *name, int nlen, unsigned long long sqnum,
+		       int deletion, int *used)
 {
 	struct replay_entry *r;
 	char *nbuf;
@@ -424,6 +427,7 @@ static int insert_dent(struct ubifs_info *c, int lnum, int offs, int len,
 	r->lnum = lnum;
 	r->offs = offs;
 	r->len = len;
+	ubifs_copy_hash(c, hash, r->hash);
 	r->deletion = !!deletion;
 	r->sqnum = sqnum;
 	key_copy(c, key, &r->key);
@@ -581,6 +585,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 	 */
 
 	list_for_each_entry(snod, &sleb->nodes, list) {
+		u8 hash[UBIFS_MAX_HASH_LEN];
 		int deletion = 0;
 
 		cond_resched();
@@ -590,6 +595,8 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			goto out_dump;
 		}
 
+		ubifs_node_calc_hash(c, snod->node, hash);
+
 		if (snod->sqnum > c->max_sqnum)
 			c->max_sqnum = snod->sqnum;
 
@@ -601,7 +608,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 
 			if (le32_to_cpu(ino->nlink) == 0)
 				deletion = 1;
-			err = insert_node(c, lnum, snod->offs, snod->len,
+			err = insert_node(c, lnum, snod->offs, snod->len, hash,
 					  &snod->key, snod->sqnum, deletion,
 					  &used, 0, new_size);
 			break;
@@ -613,7 +620,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 					  key_block(c, &snod->key) *
 					  UBIFS_BLOCK_SIZE;
 
-			err = insert_node(c, lnum, snod->offs, snod->len,
+			err = insert_node(c, lnum, snod->offs, snod->len, hash,
 					  &snod->key, snod->sqnum, deletion,
 					  &used, 0, new_size);
 			break;
@@ -627,7 +634,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			if (err)
 				goto out_dump;
 
-			err = insert_dent(c, lnum, snod->offs, snod->len,
+			err = insert_dent(c, lnum, snod->offs, snod->len, hash,
 					  &snod->key, dent->name,
 					  le16_to_cpu(dent->nlen), snod->sqnum,
 					  !le64_to_cpu(dent->inum), &used);
@@ -653,7 +660,7 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			 * functions which expect nodes to have keys.
 			 */
 			trun_key_init(c, &key, le32_to_cpu(trun->inum));
-			err = insert_node(c, lnum, snod->offs, snod->len,
+			err = insert_node(c, lnum, snod->offs, snod->len, hash,
 					  &key, snod->sqnum, 1, &used,
 					  old_size, new_size);
 			break;
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index a47fced47823..a00809d4fe6f 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -488,6 +488,12 @@ static int try_read_node(const struct ubifs_info *c, void *buf, int type,
 	if (crc != node_crc)
 		return 0;
 
+	err = ubifs_node_check_hash(c, buf, zbr->hash);
+	if (err) {
+		ubifs_err(c, "hash mismatch on node at LEB %d:%d", lnum, offs);
+		return 0;
+	}
+
 	return 1;
 }
 
@@ -1713,6 +1719,13 @@ static int validate_data_node(struct ubifs_info *c, void *buf,
 		goto out;
 	}
 
+	err = ubifs_node_check_hash(c, buf, zbr->hash);
+	if (err) {
+		ubifs_err(c, "hash mismatch on node at LEB %d:%d",
+			  zbr->lnum, zbr->offs);
+		return err;
+	}
+
 	len = le32_to_cpu(ch->len);
 	if (len != zbr->len) {
 		ubifs_err(c, "bad node length %d, expected %d", len, zbr->len);
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a9df94ad46a3..3ad78d538885 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -38,6 +38,7 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
 			 struct ubifs_znode *znode, int lnum, int offs, int len)
 {
 	struct ubifs_znode *zp;
+	u8 hash[UBIFS_MAX_HASH_LEN];
 	int i, err;
 
 	/* Make index node */
@@ -62,6 +63,7 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
 		}
 	}
 	ubifs_prepare_node(c, idx, len, 0);
+	ubifs_node_calc_hash(c, idx, hash);
 
 	znode->lnum = lnum;
 	znode->offs = offs;
@@ -78,10 +80,12 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
 		zbr->lnum = lnum;
 		zbr->offs = offs;
 		zbr->len = len;
+		ubifs_copy_hash(c, hash, zbr->hash);
 	} else {
 		c->zroot.lnum = lnum;
 		c->zroot.offs = offs;
 		c->zroot.len = len;
+		ubifs_copy_hash(c, hash, c->zroot.hash);
 	}
 	c->calc_idx_sz += ALIGN(len, 8);
 
@@ -647,6 +651,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 			znode->cnext = c->cnext;
 			break;
 		}
+		znode->cparent = znode->parent;
+		znode->ciip = znode->iip;
 		znode->cnext = cnext;
 		znode = cnext;
 		cnt += 1;
@@ -840,6 +846,8 @@ static int write_index(struct ubifs_info *c)
 	}
 
 	while (1) {
+		u8 hash[UBIFS_MAX_HASH_LEN];
+
 		cond_resched();
 
 		znode = cnext;
@@ -857,6 +865,7 @@ static int write_index(struct ubifs_info *c)
 			br->lnum = cpu_to_le32(zbr->lnum);
 			br->offs = cpu_to_le32(zbr->offs);
 			br->len = cpu_to_le32(zbr->len);
+			ubifs_copy_hash(c, zbr->hash, ubifs_branch_hash(c, br));
 			if (!zbr->lnum || !zbr->len) {
 				ubifs_err(c, "bad ref in znode");
 				ubifs_dump_znode(c, znode);
@@ -868,6 +877,23 @@ static int write_index(struct ubifs_info *c)
 		}
 		len = ubifs_idx_node_sz(c, znode->child_cnt);
 		ubifs_prepare_node(c, idx, len, 0);
+		ubifs_node_calc_hash(c, idx, hash);
+
+		mutex_lock(&c->tnc_mutex);
+
+		if (znode->cparent)
+			ubifs_copy_hash(c, hash,
+					znode->cparent->zbranch[znode->ciip].hash);
+
+		if (znode->parent) {
+			if (!ubifs_zn_obsolete(znode))
+				ubifs_copy_hash(c, hash,
+					znode->parent->zbranch[znode->iip].hash);
+		} else {
+			ubifs_copy_hash(c, hash, c->zroot.hash);
+		}
+
+		mutex_unlock(&c->tnc_mutex);
 
 		/* Determine the index node position */
 		if (lnum == -1) {
diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 7e18d459906c..c3c3794c4e5a 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -287,6 +287,12 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 		return err;
 	}
 
+	err = ubifs_node_check_hash(c, idx, zzbr->hash);
+	if (err) {
+		ubifs_err(c, "hash mismatch on node at LEB %d:%d", lnum, offs);
+		return err;
+	}
+
 	znode->child_cnt = le16_to_cpu(idx->child_cnt);
 	znode->level = le16_to_cpu(idx->level);
 
@@ -303,13 +309,14 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 	}
 
 	for (i = 0; i < znode->child_cnt; i++) {
-		const struct ubifs_branch *br = ubifs_idx_branch(c, idx, i);
+		struct ubifs_branch *br = ubifs_idx_branch(c, idx, i);
 		struct ubifs_zbranch *zbr = &znode->zbranch[i];
 
 		key_read(c, &br->key, &zbr->key);
 		zbr->lnum = le32_to_cpu(br->lnum);
 		zbr->offs = le32_to_cpu(br->offs);
 		zbr->len  = le32_to_cpu(br->len);
+		ubifs_copy_hash(c, ubifs_branch_hash(c, br), zbr->hash);
 		zbr->znode = NULL;
 
 		/* Validate branch */
@@ -491,5 +498,12 @@ int ubifs_tnc_read_node(struct ubifs_info *c, struct ubifs_zbranch *zbr,
 		return -EINVAL;
 	}
 
+	err = ubifs_node_check_hash(c, node, zbr->hash);
+	if (err) {
+		ubifs_err(c, "hash mismatch on node at LEB %d:%d",
+			  zbr->lnum, zbr->offs);
+		return err;
+	}
+
 	return 0;
 }
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 24ee376147e1..bf4a99d799a1 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -745,6 +745,8 @@ struct ubifs_zbranch {
  * struct ubifs_znode - in-memory representation of an indexing node.
  * @parent: parent znode or NULL if it is the root
  * @cnext: next znode to commit
+ * @cparent: parent node for this commit
+ * @ciip: index in cparent's zbranch array
  * @flags: znode flags (%DIRTY_ZNODE, %COW_ZNODE or %OBSOLETE_ZNODE)
  * @time: last access time (seconds)
  * @level: level of the entry in the TNC tree
@@ -762,6 +764,8 @@ struct ubifs_zbranch {
 struct ubifs_znode {
 	struct ubifs_znode *parent;
 	struct ubifs_znode *cnext;
+	struct ubifs_znode *cparent;
+	int ciip;
 	unsigned long flags;
 	unsigned long time;
 	int level;
-- 
2.18.0


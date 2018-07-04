Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09055C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEDC208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEDC208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbeGDMna (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:43:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44927 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934717AbeGDMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6n-0001dZ-0x; Wed, 04 Jul 2018 14:42:09 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005aF-LT; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 17/25] ubifs: authentication: authenticate LPT
Date:   Wed,  4 Jul 2018 14:41:29 +0200
Message-Id: <20180704124137.13396-18-s.hauer@pengutronix.de>
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

The LPT needs to be authenticated aswell. Since the LPT is only written
during commit it is enough to authenticate the whole LPT with a single
hash which is stored in the master node. Only the leaf nodes (pnodes)
are hashed which makes the implementation much simpler than it would be
to hash the complete LPT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/lpt.c        | 127 ++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/lpt_commit.c |   4 ++
 fs/ubifs/ubifs.h      |   1 +
 3 files changed, 132 insertions(+)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index cde7b9484157..2c440bb31d69 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1633,6 +1633,129 @@ struct ubifs_lprops *ubifs_lpt_lookup_dirty(struct ubifs_info *c, int lnum)
 	return &pnode->lprops[iip];
 }
 
+/**
+ * ubifs_lpt_calc_hash - Calculate hash of the LPT pnodes
+ * @c: UBIFS file-system description object
+ * @hash: the returned hash of the LPT pnodes
+ *
+ * This function iterates over the LPT pnodes and creates a hash over them.
+ * Returns 0 for success or a negative error code otherwise.
+ */
+int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash)
+{
+	struct ubifs_nnode *nnode, *nn;
+	struct ubifs_cnode *cnode;
+	struct shash_desc *desc;
+	int iip = 0, i;
+	int bufsiz = max_t(int, c->nnode_sz, c->pnode_sz);
+	void *buf;
+	int err;
+
+	if (!ubifs_authenticated(c))
+		return 0;
+
+	desc = ubifs_hash_get_desc(c);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	buf = kmalloc(bufsiz, GFP_NOFS);
+	if (!buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (!c->nroot) {
+		err = ubifs_read_nnode(c, NULL, 0);
+		if (err)
+			return err;
+	}
+
+	cnode = (struct ubifs_cnode *)c->nroot;
+
+	while (cnode) {
+		nnode = cnode->parent;
+		nn = (struct ubifs_nnode *)cnode;
+		if (cnode->level > 1) {
+			while (iip < UBIFS_LPT_FANOUT) {
+				if (nn->nbranch[iip].lnum == 0) {
+					/* Go right */
+					iip++;
+					continue;
+				}
+
+				nnode = ubifs_get_nnode(c, nn, iip);
+				if (IS_ERR(nnode)) {
+					err = PTR_ERR(nnode);
+					goto out;
+				}
+
+				/* Go down */
+				iip = 0;
+				cnode = (struct ubifs_cnode *)nnode;
+				break;
+			}
+			if (iip < UBIFS_LPT_FANOUT)
+				continue;
+		} else {
+			struct ubifs_pnode *pnode;
+
+			for (i = 0; i < UBIFS_LPT_FANOUT; i++) {
+				if (nn->nbranch[i].lnum == 0)
+					continue;
+				pnode = ubifs_get_pnode(c, nn, i);
+				if (IS_ERR(pnode)) {
+					err = PTR_ERR(pnode);
+					goto out;
+				}
+
+				ubifs_pack_pnode(c, buf, pnode);
+				ubifs_shash_update(c, desc, buf, c->pnode_sz);
+			}
+		}
+		/* Go up and to the right */
+		iip = cnode->iip + 1;
+		cnode = (struct ubifs_cnode *)nnode;
+	}
+
+	err = 0;
+	ubifs_shash_final(c, desc, hash);
+out:
+	kfree(desc);
+	kfree(buf);
+
+	return err;
+}
+
+/**
+ * lpt_check_hash - check the hash of the LPT.
+ * @c: UBIFS file-system description object
+ *
+ * This function calculates a hash over all pnodes in the LPT and compares it with
+ * the hash stored in the master node. Returns %0 on success and a negative error
+ * code on failure.
+ */
+static int lpt_check_hash(struct ubifs_info *c)
+{
+	int err;
+	u8 hash[UBIFS_MAX_HASH_LEN];
+
+	if (!ubifs_authenticated(c))
+		return 0;
+
+	err = ubifs_lpt_calc_hash(c, hash);
+	if (err)
+		return err;
+
+	if (ubifs_check_hash(c, c->mst_node->hash_lpt, hash)) {
+		err = -EPERM;
+		ubifs_err(c, "Failed to authenticate LPT");
+	} else {
+		err = 0;
+	}
+
+	return err;
+}
+
 /**
  * lpt_init_rd - initialize the LPT for reading.
  * @c: UBIFS file-system description object
@@ -1674,6 +1797,10 @@ static int lpt_init_rd(struct ubifs_info *c)
 	if (err)
 		return err;
 
+	err = lpt_check_hash(c);
+	if (err)
+		return err;
+
 	dbg_lp("space_bits %d", c->space_bits);
 	dbg_lp("lpt_lnum_bits %d", c->lpt_lnum_bits);
 	dbg_lp("lpt_offs_bits %d", c->lpt_offs_bits);
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index 14e72d09b6b3..817586f4962c 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1245,6 +1245,10 @@ int ubifs_lpt_start_commit(struct ubifs_info *c)
 	if (err)
 		goto out;
 
+	err = ubifs_lpt_calc_hash(c, c->mst_node->hash_lpt);
+	if (err)
+		goto out;
+
 	/* Copy the LPT's own lprops for end commit to write */
 	memcpy(c->ltab_cmt, c->ltab,
 	       sizeof(struct ubifs_lpt_lprops) * c->lpt_lebs);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5390d087da3a..5234a7c9380c 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1913,6 +1913,7 @@ struct ubifs_nnode *ubifs_first_nnode(struct ubifs_info *c, int *hght);
 /* Needed only in debugging code in lpt_commit.c */
 int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
 		       struct ubifs_nnode *nnode);
+int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash);
 
 /* lpt_commit.c */
 int ubifs_lpt_start_commit(struct ubifs_info *c);
-- 
2.18.0


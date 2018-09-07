Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEA22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEA22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeIGRTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35615 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeIGRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007c3-RO; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00062U-IU; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 18/25] ubifs: authentication: authenticate LPT
Date:   Fri,  7 Sep 2018 14:36:39 +0200
Message-Id: <20180907123646.12688-19-s.hauer@pengutronix.de>
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

The LPT needs to be authenticated aswell. Since the LPT is only written
during commit it is enough to authenticate the whole LPT with a single
hash which is stored in the master node. Only the leaf nodes (pnodes)
are hashed which makes the implementation much simpler than it would be
to hash the complete LPT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/lpt.c        | 129 ++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/lpt_commit.c |   4 ++
 fs/ubifs/ubifs.h      |   1 +
 3 files changed, 134 insertions(+)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 5f57af224b8f..ee18305a6152 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1635,6 +1635,131 @@ struct ubifs_lprops *ubifs_lpt_lookup_dirty(struct ubifs_info *c, int lnum)
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
+				err = ubifs_shash_update(c, desc, buf,
+							 c->pnode_sz);
+				if (err)
+					goto out;
+			}
+		}
+		/* Go up and to the right */
+		iip = cnode->iip + 1;
+		cnode = (struct ubifs_cnode *)nnode;
+	}
+
+	err = ubifs_shash_final(c, desc, hash);
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
+	u8 hash[UBIFS_HASH_ARR_SZ];
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
@@ -1676,6 +1801,10 @@ static int lpt_init_rd(struct ubifs_info *c)
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
index 62d6a87d4f5d..1f88caffdf2a 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1247,6 +1247,10 @@ int ubifs_lpt_start_commit(struct ubifs_info *c)
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
index 600a25b93a80..7e519a4885a8 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1961,6 +1961,7 @@ struct ubifs_nnode *ubifs_first_nnode(struct ubifs_info *c, int *hght);
 /* Needed only in debugging code in lpt_commit.c */
 int ubifs_unpack_nnode(const struct ubifs_info *c, void *buf,
 		       struct ubifs_nnode *nnode);
+int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash);
 
 /* lpt_commit.c */
 int ubifs_lpt_start_commit(struct ubifs_info *c);
-- 
2.18.0


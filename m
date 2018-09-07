Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60905C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5552083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5552083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeIGRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbeIGRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007bq-F8; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00061q-CC; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/25] ubifs: export pnode_lookup as ubifs_pnode_lookup
Date:   Fri,  7 Sep 2018 14:36:26 +0200
Message-Id: <20180907123646.12688-6-s.hauer@pengutronix.de>
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

ubifs_lpt_lookup could be implemented using pnode_lookup. To make that
possible move pnode_lookup from lpt.c to lpt_commit.c. Rename it to
ubifs_pnode_lookup since it's now exported.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/lpt.c        | 32 ++++++++++++++++++++++++++++++++
 fs/ubifs/lpt_commit.c | 40 ++++------------------------------------
 fs/ubifs/ubifs.h      |  1 +
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 31393370e334..ed0c67fe7500 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1438,6 +1438,38 @@ struct ubifs_pnode *ubifs_get_pnode(struct ubifs_info *c,
 	return branch->pnode;
 }
 
+/**
+ * ubifs_pnode_lookup - lookup a pnode in the LPT.
+ * @c: UBIFS file-system description object
+ * @i: pnode number (0 to (main_lebs - 1) / UBIFS_LPT_FANOUT)
+ *
+ * This function returns a pointer to the pnode on success or a negative
+ * error code on failure.
+ */
+struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i)
+{
+	int err, h, iip, shft;
+	struct ubifs_nnode *nnode;
+
+	if (!c->nroot) {
+		err = ubifs_read_nnode(c, NULL, 0);
+		if (err)
+			return ERR_PTR(err);
+	}
+	i <<= UBIFS_LPT_FANOUT_SHIFT;
+	nnode = c->nroot;
+	shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
+	for (h = 1; h < c->lpt_hght; h++) {
+		iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
+		shft -= UBIFS_LPT_FANOUT_SHIFT;
+		nnode = ubifs_get_nnode(c, nnode, iip);
+		if (IS_ERR(nnode))
+			return ERR_CAST(nnode);
+	}
+	iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
+	return ubifs_get_pnode(c, nnode, iip);
+}
+
 /**
  * ubifs_lpt_lookup - lookup LEB properties in the LPT.
  * @c: UBIFS file-system description object
diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index 7ce30994bbba..62d6a87d4f5d 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -618,38 +618,6 @@ static struct ubifs_pnode *next_pnode_to_dirty(struct ubifs_info *c,
 	return ubifs_get_pnode(c, nnode, iip);
 }
 
-/**
- * pnode_lookup - lookup a pnode in the LPT.
- * @c: UBIFS file-system description object
- * @i: pnode number (0 to (main_lebs - 1) / UBIFS_LPT_FANOUT))
- *
- * This function returns a pointer to the pnode on success or a negative
- * error code on failure.
- */
-static struct ubifs_pnode *pnode_lookup(struct ubifs_info *c, int i)
-{
-	int err, h, iip, shft;
-	struct ubifs_nnode *nnode;
-
-	if (!c->nroot) {
-		err = ubifs_read_nnode(c, NULL, 0);
-		if (err)
-			return ERR_PTR(err);
-	}
-	i <<= UBIFS_LPT_FANOUT_SHIFT;
-	nnode = c->nroot;
-	shft = c->lpt_hght * UBIFS_LPT_FANOUT_SHIFT;
-	for (h = 1; h < c->lpt_hght; h++) {
-		iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
-		shft -= UBIFS_LPT_FANOUT_SHIFT;
-		nnode = ubifs_get_nnode(c, nnode, iip);
-		if (IS_ERR(nnode))
-			return ERR_CAST(nnode);
-	}
-	iip = ((i >> shft) & (UBIFS_LPT_FANOUT - 1));
-	return ubifs_get_pnode(c, nnode, iip);
-}
-
 /**
  * add_pnode_dirt - add dirty space to LPT LEB properties.
  * @c: UBIFS file-system description object
@@ -702,7 +670,7 @@ static int make_tree_dirty(struct ubifs_info *c)
 {
 	struct ubifs_pnode *pnode;
 
-	pnode = pnode_lookup(c, 0);
+	pnode = ubifs_pnode_lookup(c, 0);
 	if (IS_ERR(pnode))
 		return PTR_ERR(pnode);
 
@@ -956,7 +924,7 @@ static int make_pnode_dirty(struct ubifs_info *c, int node_num, int lnum,
 	struct ubifs_pnode *pnode;
 	struct ubifs_nbranch *branch;
 
-	pnode = pnode_lookup(c, node_num);
+	pnode = ubifs_pnode_lookup(c, node_num);
 	if (IS_ERR(pnode))
 		return PTR_ERR(pnode);
 	branch = &pnode->parent->nbranch[pnode->iip];
@@ -1558,7 +1526,7 @@ static int dbg_is_pnode_dirty(struct ubifs_info *c, int lnum, int offs)
 		struct ubifs_nbranch *branch;
 
 		cond_resched();
-		pnode = pnode_lookup(c, i);
+		pnode = ubifs_pnode_lookup(c, i);
 		if (IS_ERR(pnode))
 			return PTR_ERR(pnode);
 		branch = &pnode->parent->nbranch[pnode->iip];
@@ -1710,7 +1678,7 @@ int dbg_check_ltab(struct ubifs_info *c)
 	for (i = 0; i < cnt; i++) {
 		struct ubifs_pnode *pnode;
 
-		pnode = pnode_lookup(c, i);
+		pnode = ubifs_pnode_lookup(c, i);
 		if (IS_ERR(pnode))
 			return PTR_ERR(pnode);
 		cond_resched();
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4368cde476b0..306cc7a4f725 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1712,6 +1712,7 @@ struct ubifs_pnode *ubifs_get_pnode(struct ubifs_info *c,
 				    struct ubifs_nnode *parent, int iip);
 struct ubifs_nnode *ubifs_get_nnode(struct ubifs_info *c,
 				    struct ubifs_nnode *parent, int iip);
+struct ubifs_pnode *ubifs_pnode_lookup(struct ubifs_info *c, int i);
 int ubifs_read_nnode(struct ubifs_info *c, struct ubifs_nnode *parent, int iip);
 void ubifs_add_lpt_dirt(struct ubifs_info *c, int lnum, int dirty);
 void ubifs_add_nnode_dirt(struct ubifs_info *c, struct ubifs_nnode *nnode);
-- 
2.18.0


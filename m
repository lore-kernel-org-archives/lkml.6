Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332EC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F382087C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F382087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934899AbeGDMnf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:43:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934689AbeGDMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001da-T9; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005aR-M3; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 18/25] ubfis: authentication: authenticate master node
Date:   Wed,  4 Jul 2018 14:41:30 +0200
Message-Id: <20180704124137.13396-19-s.hauer@pengutronix.de>
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

The master node contains hashes over the root index node and the LPT.
This patch adds a HMAC to authenticate the master node itself.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/master.c   | 61 ++++++++++++++++++++++++++++++++++++++++-----
 fs/ubifs/recovery.c |  7 +++---
 fs/ubifs/ubifs.h    |  1 +
 3 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index f1a96b50ec68..1f633601e95b 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -24,6 +24,42 @@
 
 #include "ubifs.h"
 
+/**
+ * ubifs_compare_master_node - compare two UBIFS master nodes
+ * @c: UBIFS file-system description object
+ * @m1: the first node
+ * @m2: the second node
+ *
+ * This function compares two UBIFS master nodes. Returns 0 if they are equal
+ * and nonzero if not.
+ */
+int ubifs_compare_master_node(struct ubifs_info *c, void *m1, void *m2)
+{
+	int ret;
+	int behind;
+	int hmac_offs = offsetof(struct ubifs_mst_node, hmac);
+
+	/*
+	 * Do not compare the common node header since the sequence number and
+	 * hence the CRC are different.
+	 */
+	ret = memcmp(m1 + UBIFS_CH_SZ, m2 + UBIFS_CH_SZ,
+		     hmac_offs - UBIFS_CH_SZ);
+	if (ret)
+		return ret;
+
+	/*
+	 * Do not compare the embedded HMAC aswell which also must be different
+	 * due to the different common node header.
+	 */
+	behind = hmac_offs + UBIFS_MAX_HMAC_LEN;
+
+	if (UBIFS_MST_NODE_SZ > behind)
+		return memcmp(m1 + behind, m2 + behind, UBIFS_MST_NODE_SZ - behind);
+
+	return 0;
+}
+
 /**
  * scan_for_master - search the valid master node.
  * @c: UBIFS file-system description object
@@ -37,7 +73,7 @@ static int scan_for_master(struct ubifs_info *c)
 {
 	struct ubifs_scan_leb *sleb;
 	struct ubifs_scan_node *snod;
-	int lnum, offs = 0, nodes_cnt;
+	int lnum, offs = 0, nodes_cnt, err;
 
 	lnum = UBIFS_MST_LNUM;
 
@@ -69,12 +105,23 @@ static int scan_for_master(struct ubifs_info *c)
 		goto out_dump;
 	if (snod->offs != offs)
 		goto out;
-	if (memcmp((void *)c->mst_node + UBIFS_CH_SZ,
-		   (void *)snod->node + UBIFS_CH_SZ,
-		   UBIFS_MST_NODE_SZ - UBIFS_CH_SZ))
+	if (ubifs_compare_master_node(c, c->mst_node, snod->node))
 		goto out;
+
 	c->mst_offs = offs;
 	ubifs_scan_destroy(sleb);
+
+	if (!ubifs_authenticated(c))
+		return 0;
+
+	err = ubifs_node_verify_hmac(c, c->mst_node,
+				     sizeof(struct ubifs_mst_node),
+				     offsetof(struct ubifs_mst_node, hmac));
+	if (err) {
+		ubifs_err(c, "Failed to verify master node HMAC");
+		return -EPERM;
+	}
+
 	return 0;
 
 out:
@@ -381,7 +428,8 @@ int ubifs_write_master(struct ubifs_info *c)
 	c->mst_node->highest_inum = cpu_to_le64(c->highest_inum);
 
 	ubifs_copy_hash(c, c->zroot.hash, c->mst_node->hash_root_idx);
-	err = ubifs_write_node(c, c->mst_node, len, lnum, offs);
+	err = ubifs_write_node_hmac(c, c->mst_node, len, lnum, offs,
+				    offsetof(struct ubifs_mst_node, hmac));
 	if (err)
 		return err;
 
@@ -392,7 +440,8 @@ int ubifs_write_master(struct ubifs_info *c)
 		if (err)
 			return err;
 	}
-	err = ubifs_write_node(c, c->mst_node, len, lnum, offs);
+	err = ubifs_write_node_hmac(c, c->mst_node, len, lnum, offs,
+				    offsetof(struct ubifs_mst_node, hmac));
 
 	return err;
 }
diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 3af4472061cc..3fa7c2cd96b9 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -212,7 +212,8 @@ static int write_rcvrd_mst_node(struct ubifs_info *c,
 	save_flags = mst->flags;
 	mst->flags |= cpu_to_le32(UBIFS_MST_RCVRY);
 
-	ubifs_prepare_node(c, mst, UBIFS_MST_NODE_SZ, 1);
+	ubifs_prepare_node_hmac(c, mst, UBIFS_MST_NODE_SZ,
+				offsetof(struct ubifs_mst_node, hmac), 1);
 	err = ubifs_leb_change(c, lnum, mst, sz);
 	if (err)
 		goto out;
@@ -264,9 +265,7 @@ int ubifs_recover_master_node(struct ubifs_info *c)
 			offs2 = (void *)mst2 - buf2;
 			if (offs1 == offs2) {
 				/* Same offset, so must be the same */
-				if (memcmp((void *)mst1 + UBIFS_CH_SZ,
-					   (void *)mst2 + UBIFS_CH_SZ,
-					   UBIFS_MST_NODE_SZ - UBIFS_CH_SZ))
+				if (ubifs_compare_master_node(c, mst1, mst2))
 					goto out_err;
 				mst = mst1;
 			} else if (offs2 + sz == offs1) {
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5234a7c9380c..a2805dec8aee 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1852,6 +1852,7 @@ int ubifs_gc_should_commit(struct ubifs_info *c);
 void ubifs_wait_for_commit(struct ubifs_info *c);
 
 /* master.c */
+int ubifs_compare_master_node(struct ubifs_info *c, void *m1, void *m2);
 int ubifs_read_master(struct ubifs_info *c);
 int ubifs_write_master(struct ubifs_info *c);
 
-- 
2.18.0


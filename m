Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B0208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221B0208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeGDMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:47:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934498AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dJ-9P; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005YJ-Ct; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 01/25] ubifs: refactor create_default_filesystem()
Date:   Wed,  4 Jul 2018 14:41:13 +0200
Message-Id: <20180704124137.13396-2-s.hauer@pengutronix.de>
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

create_default_filesystem() allocates memory for a node, writes that
node and frees the memory directly afterwards. With this patch we
allocate memory for all nodes at the beginning of the function and
free the memory at the end. This makes it easier to implement
authentication support since with authentication support we'll need
the contents of some nodes when creating other nodes.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/sb.c | 95 +++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 8c25081a5109..a32408f2f5c3 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -82,6 +82,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	int err, tmp, jnl_lebs, log_lebs, max_buds, main_lebs, main_first;
 	int lpt_lebs, lpt_first, orph_lebs, big_lpt, ino_waste, sup_flags = 0;
 	int min_leb_cnt = UBIFS_MIN_LEB_CNT;
+	int idx_node_size;
 	long long tmp64, main_bytes;
 	__le64 tmp_le64;
 	__le32 tmp_le32;
@@ -156,11 +157,19 @@ static int create_default_filesystem(struct ubifs_info *c)
 
 	main_first = c->leb_cnt - main_lebs;
 
+	sup = kzalloc(ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
+	idx_node_size = ubifs_idx_node_sz(c, 1);
+	idx = kzalloc(ALIGN(tmp, c->min_io_size), GFP_KERNEL);
+	ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
+
+	if (!sup || !mst || !idx || !ino || !cs) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	/* Create default superblock */
-	tmp = ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size);
-	sup = kzalloc(tmp, GFP_KERNEL);
-	if (!sup)
-		return -ENOMEM;
 
 	tmp64 = (long long)max_buds * c->leb_size;
 	if (big_lpt)
@@ -197,17 +206,9 @@ static int create_default_filesystem(struct ubifs_info *c)
 	sup->rp_size = cpu_to_le64(tmp64);
 	sup->ro_compat_version = cpu_to_le32(UBIFS_RO_COMPAT_VERSION);
 
-	err = ubifs_write_node(c, sup, UBIFS_SB_NODE_SZ, 0, 0);
-	kfree(sup);
-	if (err)
-		return err;
-
 	dbg_gen("default superblock created at LEB 0:0");
 
 	/* Create default master node */
-	mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
-	if (!mst)
-		return -ENOMEM;
 
 	mst->ch.node_type = UBIFS_MST_NODE;
 	mst->log_lnum     = cpu_to_le32(UBIFS_LOG_LNUM);
@@ -253,24 +254,9 @@ static int create_default_filesystem(struct ubifs_info *c)
 
 	mst->total_used = cpu_to_le64(UBIFS_INO_NODE_SZ);
 
-	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0);
-	if (err) {
-		kfree(mst);
-		return err;
-	}
-	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM + 1,
-			       0);
-	kfree(mst);
-	if (err)
-		return err;
-
 	dbg_gen("default master node created at LEB %d:0", UBIFS_MST_LNUM);
 
 	/* Create the root indexing node */
-	tmp = ubifs_idx_node_sz(c, 1);
-	idx = kzalloc(ALIGN(tmp, c->min_io_size), GFP_KERNEL);
-	if (!idx)
-		return -ENOMEM;
 
 	c->key_fmt = UBIFS_SIMPLE_KEY_FMT;
 	c->key_hash = key_r5_hash;
@@ -282,19 +268,11 @@ static int create_default_filesystem(struct ubifs_info *c)
 	key_write_idx(c, &key, &br->key);
 	br->lnum = cpu_to_le32(main_first + DEFAULT_DATA_LEB);
 	br->len  = cpu_to_le32(UBIFS_INO_NODE_SZ);
-	err = ubifs_write_node(c, idx, tmp, main_first + DEFAULT_IDX_LEB, 0);
-	kfree(idx);
-	if (err)
-		return err;
 
 	dbg_gen("default root indexing node created LEB %d:0",
 		main_first + DEFAULT_IDX_LEB);
 
 	/* Create default root inode */
-	tmp = ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size);
-	ino = kzalloc(tmp, GFP_KERNEL);
-	if (!ino)
-		return -ENOMEM;
 
 	ino_key_init_flash(c, &ino->key, UBIFS_ROOT_INO);
 	ino->ch.node_type = UBIFS_INO_NODE;
@@ -317,12 +295,6 @@ static int create_default_filesystem(struct ubifs_info *c)
 	/* Set compression enabled by default */
 	ino->flags = cpu_to_le32(UBIFS_COMPR_FL);
 
-	err = ubifs_write_node(c, ino, UBIFS_INO_NODE_SZ,
-			       main_first + DEFAULT_DATA_LEB, 0);
-	kfree(ino);
-	if (err)
-		return err;
-
 	dbg_gen("root inode created at LEB %d:0",
 		main_first + DEFAULT_DATA_LEB);
 
@@ -331,19 +303,46 @@ static int create_default_filesystem(struct ubifs_info *c)
 	 * always the case during normal file-system operation. Write a fake
 	 * commit start node to the log.
 	 */
-	tmp = ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size);
-	cs = kzalloc(tmp, GFP_KERNEL);
-	if (!cs)
-		return -ENOMEM;
 
 	cs->ch.node_type = UBIFS_CS_NODE;
+
+	err = ubifs_write_node(c, sup, UBIFS_SB_NODE_SZ, 0, 0);
+	if (err)
+		goto out;
+
+	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0);
+	if (err)
+		goto out;
+
+	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM + 1,
+			       0);
+	if (err)
+		goto out;
+
+	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
+	if (err)
+		goto out;
+
+	err = ubifs_write_node(c, ino, UBIFS_INO_NODE_SZ,
+			       main_first + DEFAULT_DATA_LEB, 0);
+	if (err)
+		goto out;
+
 	err = ubifs_write_node(c, cs, UBIFS_CS_NODE_SZ, UBIFS_LOG_LNUM, 0);
-	kfree(cs);
 	if (err)
-		return err;
+		goto out;
 
 	ubifs_msg(c, "default file-system created");
-	return 0;
+
+	err = 0;
+out:
+	kfree(sup);
+	kfree(mst);
+	kfree(idx);
+	kfree(ino);
+	kfree(cs);
+
+	return err;
 }
 
 /**
-- 
2.18.0


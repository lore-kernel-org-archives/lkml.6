Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF909C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C093208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C093208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeGDMpb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:45:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38823 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934481AbeGDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6n-0001dd-3K; Wed, 04 Jul 2018 14:42:09 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005b9-Np; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 21/25] ubifs: Add hashes and HMACs to default filesystem
Date:   Wed,  4 Jul 2018 14:41:33 +0200
Message-Id: <20180704124137.13396-22-s.hauer@pengutronix.de>
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

This patch calculates the necessary hashes and HMACs for the default
filesystem so that the dynamically created default fs can be
authenticated.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/sb.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 2e814b5fb5d1..99f857224255 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -87,6 +87,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	__le64 tmp_le64;
 	__le32 tmp_le32;
 	struct timespec ts;
+	u8 hash[UBIFS_MAX_HASH_LEN];
 	u8 hash_lpt[UBIFS_MAX_HASH_LEN];
 
 	/* Some functions called from here depend on the @c->key_len filed */
@@ -177,6 +178,14 @@ static int create_default_filesystem(struct ubifs_info *c)
 		sup_flags |= UBIFS_FLG_BIGLPT;
 	sup_flags |= UBIFS_FLG_DOUBLE_HASH;
 
+	if (ubifs_authenticated(c)) {
+		sup_flags |= UBIFS_FLG_AUTHENTICATION;
+		sup->hash_algo = cpu_to_le16(c->auth_hash_algo);
+		ubifs_hmac_wkm(c, sup->hmac_wkm);
+	} else {
+		sup->hash_algo = 0xffff;
+	}
+
 	sup->ch.node_type  = UBIFS_SB_NODE;
 	sup->key_hash      = UBIFS_KEY_HASH_R5;
 	sup->flags         = cpu_to_le32(sup_flags);
@@ -235,6 +244,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	mst->empty_lebs   = cpu_to_le32(main_lebs - 2);
 	mst->idx_lebs     = cpu_to_le32(1);
 	mst->leb_cnt      = cpu_to_le32(c->leb_cnt);
+	ubifs_copy_hash(c, hash_lpt, mst->hash_lpt);
 
 	/* Calculate lprops statistics */
 	tmp64 = main_bytes;
@@ -307,25 +317,33 @@ static int create_default_filesystem(struct ubifs_info *c)
 
 	cs->ch.node_type = UBIFS_CS_NODE;
 
-	err = ubifs_write_node(c, sup, UBIFS_SB_NODE_SZ, 0, 0);
+	err = ubifs_write_node_hmac(c, sup, UBIFS_SB_NODE_SZ, 0, 0,
+				    offsetof(struct ubifs_sb_node, hmac));
 	if (err)
 		goto out;
 
-	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0);
+	err = ubifs_write_node(c, ino, UBIFS_INO_NODE_SZ,
+			       main_first + DEFAULT_DATA_LEB, 0);
 	if (err)
 		goto out;
 
-	err = ubifs_write_node(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM + 1,
-			       0);
+	ubifs_node_calc_hash(c, ino, hash);
+	ubifs_copy_hash(c, hash, ubifs_branch_hash(c, br));
+
+	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
 	if (err)
 		goto out;
 
-	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
+	ubifs_node_calc_hash(c, idx, hash);
+	ubifs_copy_hash(c, hash, mst->hash_root_idx);
+
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0,
+		offsetof(struct ubifs_mst_node, hmac));
 	if (err)
 		goto out;
 
-	err = ubifs_write_node(c, ino, UBIFS_INO_NODE_SZ,
-			       main_first + DEFAULT_DATA_LEB, 0);
+	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM + 1,
+			       0, offsetof(struct ubifs_mst_node, hmac));
 	if (err)
 		goto out;
 
-- 
2.18.0


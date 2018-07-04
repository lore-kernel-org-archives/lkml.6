Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA90C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF350208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF350208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeGDMp3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:45:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934700AbeGDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6n-0001dc-0F; Wed, 04 Jul 2018 14:42:09 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005au-ND; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 20/25] ubifs: authentication: Authenticate super block node
Date:   Wed,  4 Jul 2018 14:41:32 +0200
Message-Id: <20180704124137.13396-21-s.hauer@pengutronix.de>
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

This adds a HMAC covering the super block node and adds the logic that
decides if a filesystem shall be mounted unauthenticated or
authenticated.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/sb.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 155480f62fac..2e814b5fb5d1 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -517,6 +517,62 @@ static struct ubifs_sb_node *ubifs_read_sb_node(struct ubifs_info *c)
 	return sup;
 }
 
+static int authenticate_sb_node(struct ubifs_info *c,
+				const struct ubifs_sb_node *sup)
+{
+	unsigned int sup_flags = le32_to_cpu(sup->flags);
+	u8 hmac_wkm[UBIFS_MAX_HMAC_LEN];
+	int authenticated = !!(sup_flags & UBIFS_FLG_AUTHENTICATION);
+	int hash_algo;
+	int err;
+
+	if (c->authenticated && !authenticated) {
+		ubifs_err(c, "authenticated FS forced, but found FS without authentication");
+		return -EINVAL;
+	}
+
+	if (!c->authenticated && authenticated) {
+		ubifs_err(c, "authenticated FS found, but no key given");
+		return -EINVAL;
+	}
+
+	ubifs_msg(c, "Mounting in %sauthenticated mode",
+		  c->authenticated ? "" : "un");
+
+	if (!c->authenticated)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_UBIFS_FS_AUTHENTICATION))
+		return -EOPNOTSUPP;
+
+	hash_algo = le16_to_cpu(sup->hash_algo);
+	if (hash_algo >= HASH_ALGO__LAST) {
+		ubifs_err(c, "superblock uses unknown hash algo %d",
+			  hash_algo);
+		return -EINVAL;
+	}
+
+	if (strcmp(hash_algo_name[hash_algo], c->auth_hash_name)) {
+		ubifs_err(c, "This filesystem uses %s for hashing,"
+			     " but %s is specified", hash_algo_name[hash_algo],
+			     c->auth_hash_name);
+		return -EINVAL;
+	}
+
+	ubifs_hmac_wkm(c, hmac_wkm);
+	if (ubifs_check_hmac(c, hmac_wkm, sup->hmac_wkm)) {
+		ubifs_err(c, "provided key does not fit");
+		return -ENOKEY;
+	}
+
+	err = ubifs_node_verify_hmac(c, sup, sizeof(*sup),
+				     offsetof(struct ubifs_sb_node, hmac));
+	if (err)
+		ubifs_err(c, "Failed to authenticate superblock: %d", err);
+
+	return err;
+}
+
 /**
  * ubifs_write_sb_node - write superblock node.
  * @c: UBIFS file-system description object
@@ -528,7 +584,8 @@ int ubifs_write_sb_node(struct ubifs_info *c, struct ubifs_sb_node *sup)
 {
 	int len = ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size);
 
-	ubifs_prepare_node(c, sup, UBIFS_SB_NODE_SZ, 1);
+	ubifs_prepare_node_hmac(c, sup, UBIFS_SB_NODE_SZ,
+				offsetof(struct ubifs_sb_node, hmac), 1);
 	return ubifs_leb_change(c, UBIFS_SB_LNUM, sup, len);
 }
 
@@ -642,6 +699,10 @@ int ubifs_read_superblock(struct ubifs_info *c)
 	c->double_hash = !!(sup_flags & UBIFS_FLG_DOUBLE_HASH);
 	c->encrypted = !!(sup_flags & UBIFS_FLG_ENCRYPTION);
 
+	err = authenticate_sb_node(c, sup);
+	if (err)
+		goto out;
+
 	if ((sup_flags & ~UBIFS_FLG_MASK) != 0) {
 		ubifs_err(c, "Unknown feature flags found: %#x",
 			  sup_flags & ~UBIFS_FLG_MASK);
-- 
2.18.0


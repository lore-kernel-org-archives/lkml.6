Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A26C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1491E208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1491E208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeGDMp1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:45:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51277 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934667AbeGDMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6n-0001dg-2R; Wed, 04 Jul 2018 14:42:09 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005bX-PM; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 24/25] ubifs: support offline signed images
Date:   Wed,  4 Jul 2018 14:41:36 +0200
Message-Id: <20180704124137.13396-25-s.hauer@pengutronix.de>
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

HMACs can only be generated on the system the UBIFS image is running on.
To support offline signed images we add a PKCS#7 signature to the UBIFS
image which can be created by mkfs.ubifs.

Both the master node and the superblock need to be authenticated, during
normal runtime both are protected with HMACs. For offline signature
support however only a single signature is desired. We add a signature
covering the superblock node directly behind it. To protect the master
node a hash of the master node is added to the superblock which is used
when the master node doesn't contain a HMAC.

Transition to a read/write filesystem is also supported. During
transition first the master node is rewritten with a HMAC (implicitly,
it is written anyway as the FS is marked dirty). Afterwards the
superblock is rewritten with a HMAC. Once after the image has been
mounted read/write it is HMAC only, the signature is no longer required
or even present on the filesystem.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/Kconfig       |  1 +
 fs/ubifs/auth.c        | 76 ++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/master.c      | 11 ++++--
 fs/ubifs/sb.c          | 22 ++++++++----
 fs/ubifs/super.c       | 15 +++++++++
 fs/ubifs/ubifs-media.h | 21 +++++++++++-
 fs/ubifs/ubifs.h       |  3 ++
 7 files changed, 139 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 9da1e7c21b7f..73423317026b 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -79,6 +79,7 @@ config UBIFS_FS_SECURITY
 config UBIFS_FS_AUTHENTICATION
 	bool "UBIFS authentication support"
 	select CRYPTO_HMAC
+	select SYSTEM_DATA_VERIFICATION
 	help
 	  Enable authentication support for UBIFS. This feature offers protection
 	  against offline changes for both data and metadata of the filesystem.
diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index fd21f2ec8734..070a02591cca 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -10,10 +10,12 @@
  */
 
 #include <linux/crypto.h>
+#include <linux/verification.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <crypto/algapi.h>
 #include <keys/user-type.h>
+#include <keys/asymmetric-type.h>
 
 #include "ubifs.h"
 
@@ -157,6 +159,61 @@ int __ubifs_node_check_hash(const struct ubifs_info *c, void *node,
 	return 0;
 }
 
+/**
+ * ubifs_sb_verify_signature - verify the signature of a superblock
+ * @c: UBIFS file-system description object
+ * @sup: The superblock node
+ *
+ * To support offline signed images the superblock can be signed with a
+ * PKCS#7 signature. The signature is placed directly behind the superblock
+ * node in an ubifs_sig_node.
+ *
+ * Returns 0 when the signature can be successfully verified or a negative
+ * error code if not.
+ */
+int ubifs_sb_verify_signature(struct ubifs_info *c,
+			      const struct ubifs_sb_node *sup)
+{
+	int err;
+	struct ubifs_scan_leb *sleb;
+	struct ubifs_scan_node *snod;
+	const struct ubifs_sig_node *signode;
+
+	err = ubifs_leb_read(c, UBIFS_SB_LNUM, c->sbuf, 0, c->leb_size, 1);
+
+	sleb = ubifs_scan(c, UBIFS_SB_LNUM, UBIFS_SB_NODE_SZ, c->sbuf, 0);
+	if (IS_ERR(sleb)) {
+		err = PTR_ERR(sleb);
+		return err;
+	}
+
+	if (sleb->nodes_cnt == 0) {
+		ubifs_err(c, "Unable to find signature node");
+		err = -EINVAL;
+		goto out_destroy;
+	}
+
+	snod = list_entry(sleb->nodes.next, struct ubifs_scan_node, list);
+
+	if (snod->type != UBIFS_SIG_NODE) {
+		ubifs_err(c, "Signature node is of wrong type");
+		err = -EINVAL;
+		goto out_destroy;
+	}
+
+	signode = snod->node;
+
+	err = verify_pkcs7_signature(sup, sizeof(struct ubifs_sb_node),
+				     signode->sig, signode->len,
+				     NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
+				     NULL, NULL);
+
+out_destroy:
+	ubifs_scan_destroy(sleb);
+
+	return err;
+}
+
 /**
  * ubifs_init_authentication - initialize UBIFS authentication support
  * @c: UBIFS file-system description object
@@ -411,3 +468,22 @@ void ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac)
 
 	crypto_shash_final(shash, hmac);
 }
+
+/*
+ * ubifs_hmac_zero - test if a HMAC is zero
+ * @c: UBIFS file-system description object
+ * @hmac: the HMAC to test
+ *
+ * This function tests if a HMAC is zero and returns true if it is
+ * and false otherwise.
+ */
+bool ubifs_hmac_zero(struct ubifs_info *c, const u8 *hmac)
+{
+	int i;
+
+	for (i = 0; i < c->hmac_desc_len; i++)
+		if (hmac[i] != 0)
+			return false;
+
+	return true;
+}
diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index 1f633601e95b..8129bef973bc 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -114,9 +114,14 @@ static int scan_for_master(struct ubifs_info *c)
 	if (!ubifs_authenticated(c))
 		return 0;
 
-	err = ubifs_node_verify_hmac(c, c->mst_node,
-				     sizeof(struct ubifs_mst_node),
-				     offsetof(struct ubifs_mst_node, hmac));
+	if (ubifs_hmac_zero(c, c->mst_node->hmac))
+		err = ubifs_node_check_hash(c, c->mst_node,
+					    c->superblock->hash_mst);
+	else
+		err = ubifs_node_verify_hmac(c, c->mst_node,
+					sizeof(struct ubifs_mst_node),
+					offsetof(struct ubifs_mst_node, hmac));
+
 	if (err) {
 		ubifs_err(c, "Failed to verify master node HMAC");
 		return -EPERM;
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 99f857224255..d38cd58b71bb 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -577,14 +577,24 @@ static int authenticate_sb_node(struct ubifs_info *c,
 		return -EINVAL;
 	}
 
-	ubifs_hmac_wkm(c, hmac_wkm);
-	if (ubifs_check_hmac(c, hmac_wkm, sup->hmac_wkm)) {
-		ubifs_err(c, "provided key does not fit");
-		return -ENOKEY;
+	/*
+	 * The super block node can either be authenticated by a HMAC or
+	 * by a signature in a ubifs_sig_node directly following the
+	 * super block node to support offline image creation.
+	 */
+	if (ubifs_hmac_zero(c, sup->hmac)) {
+		err = ubifs_sb_verify_signature(c, sup);
+	} else {
+		ubifs_hmac_wkm(c, hmac_wkm);
+		if (ubifs_check_hmac(c, hmac_wkm, sup->hmac_wkm)) {
+			ubifs_err(c, "provided key does not fit");
+			return -ENOKEY;
+		}
+		err = ubifs_node_verify_hmac(c, sup, sizeof(*sup),
+					     offsetof(struct ubifs_sb_node,
+						      hmac));
 	}
 
-	err = ubifs_node_verify_hmac(c, sup, sizeof(*sup),
-				     offsetof(struct ubifs_sb_node, hmac));
 	if (err)
 		ubifs_err(c, "Failed to authenticate superblock: %d", err);
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b2ccd2d7ce4d..df4da55db998 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -580,6 +580,8 @@ static int init_constants_early(struct ubifs_info *c)
 	c->ranges[UBIFS_AUTH_NODE].min_len = UBIFS_AUTH_NODE_SZ;
 	c->ranges[UBIFS_AUTH_NODE].max_len = UBIFS_AUTH_NODE_SZ +
 				UBIFS_MAX_HMAC_LEN;
+	c->ranges[UBIFS_SIG_NODE].min_len = UBIFS_SIG_NODE_SZ;
+	c->ranges[UBIFS_SIG_NODE].max_len = c->leb_size - UBIFS_SB_NODE_SZ;
 
 	c->ranges[UBIFS_INO_NODE].min_len  = UBIFS_INO_NODE_SZ;
 	c->ranges[UBIFS_INO_NODE].max_len  = UBIFS_MAX_INO_NODE_SZ;
@@ -1349,6 +1351,19 @@ static int mount_ubifs(struct ubifs_info *c)
 		err = ubifs_write_master(c);
 		if (err)
 			goto out_lpt;
+
+		/*
+		 * Handle offline signed images: Now that the master node is
+		 * written and its validation no longer depends on the hash
+		 * in the superblock, we can update the offline signed
+		 * superblock with a HMAC version,
+		 */
+		if (ubifs_authenticated(c) &&
+		    ubifs_hmac_zero(c, c->superblock->hmac)) {
+			err = ubifs_write_sb_node(c, c->superblock);
+			if (err)
+				goto out_lpt;
+		}
 	}
 
 	err = dbg_check_idx_size(c, c->bi.old_idx_sz);
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 8b7c1844014f..3a73eb59859f 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -287,6 +287,8 @@ enum {
 #define UBIFS_CS_NODE_SZ   sizeof(struct ubifs_cs_node)
 #define UBIFS_ORPH_NODE_SZ sizeof(struct ubifs_orph_node)
 #define UBIFS_AUTH_NODE_SZ sizeof(struct ubifs_auth_node)
+#define UBIFS_SIG_NODE_SZ  sizeof(struct ubifs_sig_node)
+
 /* Extended attribute entry nodes are identical to directory entry nodes */
 #define UBIFS_XENT_NODE_SZ UBIFS_DENT_NODE_SZ
 /* Only this does not have to be multiple of 8 bytes */
@@ -373,6 +375,7 @@ enum {
  * UBIFS_CS_NODE: commit start node
  * UBIFS_ORPH_NODE: orphan node
  * UBIFS_AUTH_NODE: authentication node
+ * UBIFS_SIG_NODE: signature node
  * UBIFS_NODE_TYPES_CNT: count of supported node types
  *
  * Note, we index arrays by these numbers, so keep them low and contiguous.
@@ -393,6 +396,7 @@ enum {
 	UBIFS_CS_NODE,
 	UBIFS_ORPH_NODE,
 	UBIFS_AUTH_NODE,
+	UBIFS_SIG_NODE,
 	UBIFS_NODE_TYPES_CNT,
 };
 
@@ -650,6 +654,8 @@ struct ubifs_pad_node {
  * @hmac_wkm: HMAC of a well known message (the string "UBIFS") as a convenience
  *            to the user to check if the correct key is passed.
  * @hash_algo: The hash algo used for this filesystem (one of enum hash_algo)
+ * @hash_mst: hash of the master node, only valid for signed images in which the
+ *            master node does not contain a hmac
  */
 struct ubifs_sb_node {
 	struct ubifs_ch ch;
@@ -680,7 +686,8 @@ struct ubifs_sb_node {
 	__u8 hmac[UBIFS_MAX_HMAC_LEN];
 	__u8 hmac_wkm[UBIFS_MAX_HMAC_LEN];
 	__le16 hash_algo;
-	__u8 padding2[3838];
+	__u8 hash_mst[UBIFS_MAX_HASH_LEN];
+	__u8 padding2[3774];
 } __packed;
 
 /**
@@ -782,6 +789,18 @@ struct ubifs_auth_node {
 	__u8 hmac[];
 } __packed;
 
+/**
+ * struct ubifs_sig_node - node for signing other nodes
+ * @ch: common header
+ * @len: The length of the signature data
+ * @sig: The signature data
+ */
+struct ubifs_sig_node {
+	struct ubifs_ch ch;
+	__le32 len;
+	__u8 sig[];
+} __packed;
+
 /**
  * struct ubifs_branch - key/reference/length branch
  * @lnum: LEB number of the target node
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index afe1b0904683..f511066214df 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1645,6 +1645,9 @@ static inline int ubifs_auth_node_sz(const struct ubifs_info *c)
 	else
 		return 0;
 }
+int ubifs_sb_verify_signature(struct ubifs_info *c,
+			      const struct ubifs_sb_node *sup);
+bool ubifs_hmac_zero(struct ubifs_info *c, const u8 *hmac);
 
 void ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac);
 
-- 
2.18.0


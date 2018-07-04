Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246BC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC389208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC389208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeGDMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:46:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36453 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934644AbeGDMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:24 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dQ-Lm; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Z7-Gd; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 08/25] ubifs: Format changes for authentication support
Date:   Wed,  4 Jul 2018 14:41:20 +0200
Message-Id: <20180704124137.13396-9-s.hauer@pengutronix.de>
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

This patch adds the changes to the on disk format needed for
authentication support. We'll add:

* a HMAC covering super block node
* a HMAC covering the master node
* a hash over the root index node to the master node
* a hash over the LPT to the master node
* a flag to the filesystem flag indicating the filesystem is
  authenticated
* an authentication node necessary to authenticate the nodes written
  to the journal heads while they are written.
* a HMAC of a well known message to the super block node to be able
  to check if the correct key is provided

And finally, not visible in this patch, nevertheless explained here:

* hashes over the referenced child nodes in each branch of a index node

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/debug.c       |  6 ++++++
 fs/ubifs/super.c       |  1 +
 fs/ubifs/ubifs-media.h | 46 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 7cd8a7b95299..249c9e71252c 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -165,6 +165,8 @@ const char *dbg_ntype(int type)
 		return "commit start node";
 	case UBIFS_ORPH_NODE:
 		return "orphan node";
+	case UBIFS_AUTH_NODE:
+		return "auth node";
 	default:
 		return "unknown node";
 	}
@@ -542,6 +544,10 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node)
 			       (unsigned long long)le64_to_cpu(orph->inos[i]));
 		break;
 	}
+	case UBIFS_AUTH_NODE:
+	{
+		break;
+	}
 	default:
 		pr_err("node type %d was not recognized\n",
 		       (int)ch->node_type);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 9e44baec30a3..6b2d80391111 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -577,6 +577,7 @@ static int init_constants_early(struct ubifs_info *c)
 	c->ranges[UBIFS_REF_NODE].len  = UBIFS_REF_NODE_SZ;
 	c->ranges[UBIFS_TRUN_NODE].len = UBIFS_TRUN_NODE_SZ;
 	c->ranges[UBIFS_CS_NODE].len   = UBIFS_CS_NODE_SZ;
+	c->ranges[UBIFS_AUTH_NODE].len = UBIFS_AUTH_NODE_SZ;
 
 	c->ranges[UBIFS_INO_NODE].min_len  = UBIFS_INO_NODE_SZ;
 	c->ranges[UBIFS_INO_NODE].max_len  = UBIFS_MAX_INO_NODE_SZ;
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index e8c23c9d4f4a..8b7c1844014f 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -286,6 +286,7 @@ enum {
 #define UBIFS_IDX_NODE_SZ  sizeof(struct ubifs_idx_node)
 #define UBIFS_CS_NODE_SZ   sizeof(struct ubifs_cs_node)
 #define UBIFS_ORPH_NODE_SZ sizeof(struct ubifs_orph_node)
+#define UBIFS_AUTH_NODE_SZ sizeof(struct ubifs_auth_node)
 /* Extended attribute entry nodes are identical to directory entry nodes */
 #define UBIFS_XENT_NODE_SZ UBIFS_DENT_NODE_SZ
 /* Only this does not have to be multiple of 8 bytes */
@@ -300,6 +301,12 @@ enum {
 /* The largest UBIFS node */
 #define UBIFS_MAX_NODE_SZ UBIFS_MAX_INO_NODE_SZ
 
+/* The maxmimum size of a hash, enough for sha512 */
+#define UBIFS_MAX_HASH_LEN 64
+
+/* The maxmimum size of a hmac, enough for hmac(sha512) */
+#define UBIFS_MAX_HMAC_LEN 64
+
 /*
  * xattr name of UBIFS encryption context, we don't use a prefix
  * nor a long name to not waste space on the flash.
@@ -365,6 +372,7 @@ enum {
  * UBIFS_IDX_NODE: index node
  * UBIFS_CS_NODE: commit start node
  * UBIFS_ORPH_NODE: orphan node
+ * UBIFS_AUTH_NODE: authentication node
  * UBIFS_NODE_TYPES_CNT: count of supported node types
  *
  * Note, we index arrays by these numbers, so keep them low and contiguous.
@@ -384,6 +392,7 @@ enum {
 	UBIFS_IDX_NODE,
 	UBIFS_CS_NODE,
 	UBIFS_ORPH_NODE,
+	UBIFS_AUTH_NODE,
 	UBIFS_NODE_TYPES_CNT,
 };
 
@@ -421,15 +430,19 @@ enum {
  * UBIFS_FLG_DOUBLE_HASH: store a 32bit cookie in directory entry nodes to
  *			  support 64bit cookies for lookups by hash
  * UBIFS_FLG_ENCRYPTION: this filesystem contains encrypted files
+ * UBIFS_FLG_AUTHENTICATION: this filesystem contains hashes for authentication
  */
 enum {
 	UBIFS_FLG_BIGLPT = 0x02,
 	UBIFS_FLG_SPACE_FIXUP = 0x04,
 	UBIFS_FLG_DOUBLE_HASH = 0x08,
 	UBIFS_FLG_ENCRYPTION = 0x10,
+	UBIFS_FLG_AUTHENTICATION = 0x20,
 };
 
-#define UBIFS_FLG_MASK (UBIFS_FLG_BIGLPT|UBIFS_FLG_SPACE_FIXUP|UBIFS_FLG_DOUBLE_HASH|UBIFS_FLG_ENCRYPTION)
+#define UBIFS_FLG_MASK (UBIFS_FLG_BIGLPT | UBIFS_FLG_SPACE_FIXUP | \
+		UBIFS_FLG_DOUBLE_HASH | UBIFS_FLG_ENCRYPTION | \
+		UBIFS_FLG_AUTHENTICATION)
 
 /**
  * struct ubifs_ch - common header node.
@@ -633,6 +646,10 @@ struct ubifs_pad_node {
  * @time_gran: time granularity in nanoseconds
  * @uuid: UUID generated when the file system image was created
  * @ro_compat_version: UBIFS R/O compatibility version
+ * @hmac: HMAC to authenticate the superblock node
+ * @hmac_wkm: HMAC of a well known message (the string "UBIFS") as a convenience
+ *            to the user to check if the correct key is passed.
+ * @hash_algo: The hash algo used for this filesystem (one of enum hash_algo)
  */
 struct ubifs_sb_node {
 	struct ubifs_ch ch;
@@ -660,7 +677,10 @@ struct ubifs_sb_node {
 	__le32 time_gran;
 	__u8 uuid[16];
 	__le32 ro_compat_version;
-	__u8 padding2[3968];
+	__u8 hmac[UBIFS_MAX_HMAC_LEN];
+	__u8 hmac_wkm[UBIFS_MAX_HMAC_LEN];
+	__le16 hash_algo;
+	__u8 padding2[3838];
 } __packed;
 
 /**
@@ -695,6 +715,9 @@ struct ubifs_sb_node {
  * @empty_lebs: number of empty logical eraseblocks
  * @idx_lebs: number of indexing logical eraseblocks
  * @leb_cnt: count of LEBs used by file-system
+ * @hash_root_idx: the hash of the root index node
+ * @hash_lpt: the hash of the LPT
+ * @hmac: HMAC to authenticate the master node
  * @padding: reserved for future, zeroes
  */
 struct ubifs_mst_node {
@@ -727,7 +750,10 @@ struct ubifs_mst_node {
 	__le32 empty_lebs;
 	__le32 idx_lebs;
 	__le32 leb_cnt;
-	__u8 padding[344];
+	__u8 hash_root_idx[UBIFS_MAX_HASH_LEN];
+	__u8 hash_lpt[UBIFS_MAX_HASH_LEN];
+	__u8 hmac[UBIFS_MAX_HMAC_LEN];
+	__u8 padding[152];
 } __packed;
 
 /**
@@ -746,12 +772,26 @@ struct ubifs_ref_node {
 	__u8 padding[28];
 } __packed;
 
+/**
+ * struct ubifs_auth_node - node for authenticating other nodes
+ * @ch: common header
+ * @hmac: The HMAC
+ */
+struct ubifs_auth_node {
+	struct ubifs_ch ch;
+	__u8 hmac[];
+} __packed;
+
 /**
  * struct ubifs_branch - key/reference/length branch
  * @lnum: LEB number of the target node
  * @offs: offset within @lnum
  * @len: target node length
  * @key: key
+ *
+ * In an authenticated UBIFS we have the hash of the referenced node after @key.
+ * This can't be added to the struct type definition because @key is a
+ * dynamically sized element already.
  */
 struct ubifs_branch {
 	__le32 lnum;
-- 
2.18.0


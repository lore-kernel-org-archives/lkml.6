Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7023F55
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C7023F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964785AbeGDMm6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46879 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934727AbeGDMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:27 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dS-KP; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005ZD-Hl; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 10/25] ubifs: add helper functions for authentication support
Date:   Wed,  4 Jul 2018 14:41:22 +0200
Message-Id: <20180704124137.13396-11-s.hauer@pengutronix.de>
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

This patch adds the various helper functions needed for authentication
support. We need functions to hash nodes, to embed HMACs into a node and
to compare hashes and HMACs. Most functions first check if this
filesystem is authenticated and bail out early if not, which makes the
functions safe to be called with disabled authentication.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/Kconfig  |   1 +
 fs/ubifs/Makefile |   1 +
 fs/ubifs/auth.c   | 413 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h  | 187 +++++++++++++++++++++
 4 files changed, 602 insertions(+)
 create mode 100644 fs/ubifs/auth.c

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 83a961bf7280..2a0b5f1134a4 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -7,6 +7,7 @@ config UBIFS_FS
 	select CRYPTO if UBIFS_FS_ZLIB
 	select CRYPTO_LZO if UBIFS_FS_LZO
 	select CRYPTO_DEFLATE if UBIFS_FS_ZLIB
+	select CRYPTO_HASH_INFO
 	depends on MTD_UBI
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 9758f709c736..2bdb8ae2f435 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -7,3 +7,4 @@ ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
 ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o xattr.o debug.o
 ubifs-y += misc.o
 ubifs-$(CONFIG_UBIFS_FS_ENCRYPTION) += crypto.o
+ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
new file mode 100644
index 000000000000..fd21f2ec8734
--- /dev/null
+++ b/fs/ubifs/auth.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2018 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ */
+
+/*
+ * This file implements various helper functions for UBIFS authentication support
+ */
+
+#include <linux/crypto.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
+#include <crypto/algapi.h>
+#include <keys/user-type.h>
+
+#include "ubifs.h"
+
+/**
+ * ubifs_node_calc_hash - calculate the hash of a UBIFS node
+ * @c: UBIFS file-system description object
+ * @node: the node to calculate a hash for
+ * @hash: the returned hash
+ */
+void __ubifs_node_calc_hash(const struct ubifs_info *c, const void *node,
+			    u8 *hash)
+{
+	const struct ubifs_ch *ch = node;
+	SHASH_DESC_ON_STACK(shash, c->hash_tfm);
+
+	shash->tfm = c->hash_tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	crypto_shash_digest(shash, node, le32_to_cpu(ch->len), hash);
+}
+
+/**
+ * ubifs_hash_calc_hmac - calculate a HMAC from a hash
+ * @c: UBIFS file-system description object
+ * @hash: the node to calculate a HMAC for
+ * @hmac: the returned HMAC
+ */
+static void ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
+				 u8 *hmac)
+{
+	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
+
+	shash->tfm = c->hmac_tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	crypto_shash_digest(shash, hash, c->hash_len, hmac);
+}
+
+/**
+ * ubifs_prepare_auth_node - Prepare an authentication node
+ * @c: UBIFS file-system description object
+ * @node: the node to calculate a hash for
+ * @hash: input hash of previous nodes
+ *
+ * This function prepares an authentication node for writing onto flash.
+ * It creates a HMAC from the given input hash and writes it to the node.
+ */
+void ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
+			     struct shash_desc *inhash)
+{
+	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
+	struct ubifs_auth_node *auth = node;
+	u8 hash[crypto_shash_descsize(c->hash_tfm)];
+
+	hash_desc->tfm = c->hash_tfm;
+	hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	ubifs_shash_copy_state(c, inhash, hash_desc);
+	crypto_shash_final(hash_desc, hash);
+
+	ubifs_hash_calc_hmac(c, hash, auth->hmac);
+
+	auth->ch.node_type = UBIFS_AUTH_NODE;
+	ubifs_prepare_node(c, auth, ubifs_auth_node_sz(c), 0);
+}
+
+static struct shash_desc *ubifs_get_desc(const struct ubifs_info *c,
+					 struct crypto_shash *tfm)
+{
+	struct shash_desc *desc;
+	int err;
+
+	if (!ubifs_authenticated(c))
+		return NULL;
+
+	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	desc->tfm = tfm;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	err = crypto_shash_init(desc);
+	if (err) {
+		kfree(desc);
+		return ERR_PTR(err);
+	}
+
+	return desc;
+}
+
+/**
+ * __ubifs_hash_get_desc - get a descriptor suitable for hashing a node
+ * @c: UBIFS file-system description object
+ *
+ * This function returns a descriptor suitable for hashing a node. Free after use
+ * with kfree.
+ */
+struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
+{
+	return ubifs_get_desc(c, c->hash_tfm);
+}
+
+/**
+ * __ubifs_shash_final - finalize shash
+ * @c: UBIFS file-system description object
+ * @desc: the descriptor
+ * @out: the output hash
+ *
+ * Simple wrapper around crypto_shash_final(), safe to be called with
+ * disabled authentication.
+ */
+int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
+			u8 *out)
+{
+	if (ubifs_authenticated(c))
+		return crypto_shash_final(desc, out);
+
+	return 0;
+}
+
+/**
+ * __ubifs_node_check_hash - check the hash of a node against given hash
+ * @c: UBIFS file-system description object
+ * @node: the node
+ * @expected: the expected hash
+ *
+ * This function calculates a hash over a node and compares it to the given hash.
+ * Returns 0 if both hashes are equal or authentication is disabled, otherwise a
+ * negative error code is returned.
+ */
+int __ubifs_node_check_hash(const struct ubifs_info *c, void *node,
+			    const u8 *expected)
+{
+	u8 calc[UBIFS_MAX_HASH_LEN];
+
+	__ubifs_node_calc_hash(c, node, calc);
+
+	if (ubifs_check_hash(c, expected, calc))
+		return -EPERM;
+
+	return 0;
+}
+
+/**
+ * ubifs_init_authentication - initialize UBIFS authentication support
+ * @c: UBIFS file-system description object
+ *
+ * This function returns 0 for success or a negative error code otherwise.
+ */
+int ubifs_init_authentication(struct ubifs_info *c)
+{
+	struct key *keyring_key;
+	const struct user_key_payload *ukp;
+	int err;
+	char hmac_name[CRYPTO_MAX_ALG_NAME];
+
+	if (!c->auth_hash_name) {
+		ubifs_err(c, "authentication hash name needed with authentication");
+		return -EINVAL;
+	}
+
+	c->auth_hash_algo = match_string(hash_algo_name, HASH_ALGO__LAST,
+					 c->auth_hash_name);
+	if ((int)c->auth_hash_algo < 0) {
+		ubifs_err(c, "Unknown hash algo %s specified",
+			  c->auth_hash_name);
+		return -EINVAL;
+	}
+
+	snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
+		 c->auth_hash_name);
+
+	keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);
+
+	if (IS_ERR(keyring_key)) {
+		ubifs_err(c, "Failed to request key: %ld",
+			  PTR_ERR(keyring_key));
+		return PTR_ERR(keyring_key);
+	}
+
+	down_read(&keyring_key->sem);
+
+	if (keyring_key->type != &key_type_logon) {
+		ubifs_err(c, "key type must be logon");
+		err = -ENOKEY;
+		goto out;
+	}
+
+	ukp = user_key_payload_locked(keyring_key);
+	if (!ukp) {
+		/* key was revoked before we acquired its semaphore */
+		err = -EKEYREVOKED;
+		goto out;
+	}
+
+	c->hash_tfm = crypto_alloc_shash(c->auth_hash_name, 0,
+					 CRYPTO_ALG_ASYNC);
+	if (IS_ERR(c->hash_tfm)) {
+		err = PTR_ERR(c->hash_tfm);
+		ubifs_err(c, "Can not allocate %s: %d",
+			  c->auth_hash_name, err);
+		goto out;
+	}
+
+	c->hash_len = crypto_shash_digestsize(c->hash_tfm);
+	if (c->hash_len > UBIFS_MAX_HASH_LEN) {
+		ubifs_err(c, "hash %s is bigger than maximum allowed hash size (%d > %d)",
+			  c->auth_hash_name, c->hash_len, UBIFS_MAX_HASH_LEN);
+		err = -EINVAL;
+		goto out_free_hash;
+	}
+
+	c->hmac_tfm = crypto_alloc_shash(hmac_name, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(c->hmac_tfm)) {
+		err = PTR_ERR(c->hmac_tfm);
+		ubifs_err(c, "Can not allocate %s: %d", hmac_name, err);
+		goto out_free_hash;
+	}
+
+	c->hmac_desc_len = crypto_shash_digestsize(c->hmac_tfm);
+	if (c->hmac_desc_len > UBIFS_MAX_HMAC_LEN) {
+		ubifs_err(c, "hmac %s is bigger than maximum allowed hmac size (%d > %d)",
+			  hmac_name, c->hmac_desc_len, UBIFS_MAX_HMAC_LEN);
+		err = -EINVAL;
+		goto out_free_hash;
+	}
+
+	err = crypto_shash_setkey(c->hmac_tfm, ukp->data, ukp->datalen);
+	if (err)
+		goto out_free_hmac;
+
+	c->authenticated = true;
+
+	c->log_hash = ubifs_hash_get_desc(c);
+	if (IS_ERR(c->log_hash))
+		goto out_free_hmac;
+
+	err = 0;
+
+out_free_hmac:
+	if (err)
+		crypto_free_shash(c->hmac_tfm);
+out_free_hash:
+	if (err)
+		crypto_free_shash(c->hash_tfm);
+out:
+	up_read(&keyring_key->sem);
+	key_put(keyring_key);
+
+	return err;
+}
+
+/**
+ * __ubifs_exit_authentication - release resource
+ * @c: UBIFS file-system description object
+ *
+ * This function releases the authentication related resources.
+ */
+void __ubifs_exit_authentication(struct ubifs_info *c)
+{
+	if (!ubifs_authenticated(c))
+		return;
+
+	crypto_free_shash(c->hmac_tfm);
+	crypto_free_shash(c->hash_tfm);
+	kfree(c->log_hash);
+}
+
+/**
+ * ubifs_node_calc_hmac - calculate the HMAC of a UBIFS node
+ * @c: UBIFS file-system description object
+ * @node: the node to insert a HMAC into.
+ * @len: the length of the node
+ * @ofs_hmac: the offset in the node where the HMAC is inserted
+ * @hmac: returned HMAC
+ *
+ * This function calculates a HMAC of a UBIFS node. The HMAC is expected to be
+ * embedded into the node, so this area is not covered by the HMAC. Also not
+ * covered is the UBIFS_NODE_MAGIC and the CRC of the node.
+ */
+static void ubifs_node_calc_hmac(const struct ubifs_info *c, const void *node,
+				 int len, int ofs_hmac, void *hmac)
+{
+	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
+	int hmac_len = c->hmac_desc_len;
+
+	ubifs_assert(ofs_hmac > 8);
+	ubifs_assert(ofs_hmac + hmac_len < len);
+
+	shash->tfm = c->hmac_tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	crypto_shash_init(shash);
+
+	/* behind common node header CRC up to HMAC begin */
+	crypto_shash_update(shash, node + 8, ofs_hmac - 8);
+
+	/* behind HMAC, if any */
+	if (len - ofs_hmac - hmac_len > 0)
+		crypto_shash_update(shash, node + ofs_hmac + hmac_len,
+			    len - ofs_hmac - hmac_len);
+
+	crypto_shash_final(shash, hmac);
+}
+
+/**
+ * __ubifs_node_insert_hmac - insert a HMAC into a UBIFS node
+ * @c: UBIFS file-system description object
+ * @node: the node to insert a HMAC into.
+ * @len: the length of the node
+ * @ofs_hmac: the offset in the node where the HMAC is inserted
+ *
+ * This function inserts a HMAC at offset @ofs_hmac into the node given in
+ * @node.
+ */
+void __ubifs_node_insert_hmac(const struct ubifs_info *c, void *node, int len,
+			    int ofs_hmac)
+{
+	ubifs_node_calc_hmac(c, node, len, ofs_hmac, node + ofs_hmac);
+}
+
+/**
+ * __ubifs_node_verify_hmac - verify the HMAC of UBIFS node
+ * @c: UBIFS file-system description object
+ * @node: the node to insert a HMAC into.
+ * @len: the length of the node
+ * @ofs_hmac: the offset in the node where the HMAC is inserted
+ *
+ * This function verifies the HMAC at offset @ofs_hmac of the node given in
+ * @node. Returns 0 if successful or a negative error code otherwise.
+ */
+int __ubifs_node_verify_hmac(const struct ubifs_info *c, const void *node,
+			     int len, int ofs_hmac)
+{
+	int hmac_len = c->hmac_desc_len;
+	u8 *hmac;
+	int err;
+
+	hmac = kmalloc(hmac_len, GFP_NOFS);
+	if (!hmac)
+		return -ENOMEM;
+
+	ubifs_node_calc_hmac(c, node, len, ofs_hmac, hmac);
+
+	err = crypto_memneq(hmac, node + ofs_hmac, hmac_len);
+
+	kfree(hmac);
+
+	if (!err)
+		return 0;
+
+	return -EPERM;
+}
+
+int __ubifs_shash_copy_state(const struct ubifs_info *c, struct shash_desc *src,
+			     struct shash_desc *target)
+{
+	u8 state[crypto_shash_descsize(src->tfm)];
+	int err;
+
+	err = crypto_shash_export(src, state);
+	if (err)
+		return err;
+
+	return crypto_shash_import(target, state);
+}
+
+/**
+ * ubifs_hmac_wkm - Create a HMAC of the well known message
+ * @c: UBIFS file-system description object
+ * @hmac: The HMAC of the well known message
+ *
+ * This function creates a HMAC of a well known message. This is used
+ * to check if the provided key is suitable to authenticate a UBIFS
+ * image. This is only a convenience to the user to provide a better
+ * error message when the wrong key is provided.
+ */
+void ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac)
+{
+	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
+	int err;
+	const char well_known_message[] = "UBIFS";
+
+	if (!ubifs_authenticated(c))
+		return;
+
+	shash->tfm = c->hmac_tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	err = crypto_shash_init(shash);
+	BUG_ON(err);
+
+	crypto_shash_update(shash, well_known_message,
+			    sizeof(well_known_message) - 1);
+
+	crypto_shash_final(shash, hmac);
+}
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 485de4e27f96..2086cb8f7115 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -39,6 +39,9 @@
 #include <linux/security.h>
 #include <linux/xattr.h>
 #include <linux/random.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+#include <crypto/algapi.h>
 
 #define __FS_HAS_ENCRYPTION IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION)
 #include <linux/fscrypt.h>
@@ -1016,6 +1019,7 @@ struct ubifs_debug_info;
  * @bulk_read: enable bulk-reads
  * @default_compr: default compression algorithm (%UBIFS_COMPR_LZO, etc)
  * @rw_incompat: the media is not R/W compatible
+ * @authenticated: flag indigating the FS is mounted in authenticated mode
  *
  * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, and
  *             @calc_idx_sz
@@ -1063,6 +1067,7 @@ struct ubifs_debug_info;
  * @key_hash: direntry key hash function
  * @key_fmt: key format
  * @key_len: key length
+ * @hash_len: The length of the index node hashes
  * @fanout: fanout of the index tree (number of links per indexing node)
  *
  * @min_io_size: minimal input/output unit size
@@ -1198,6 +1203,13 @@ struct ubifs_debug_info;
  * @rp_uid: reserved pool user ID
  * @rp_gid: reserved pool group ID
  *
+ * @hash_tfm: the hash transformation used for hashing nodes
+ * @hmac_tfm: the HMAC transformation for this filesystem
+ * @hmac_desc_len: length of the HMAC used for authentication
+ * @auth_key_name: the authentication key name
+ * @auth_hash_name: the name of the hash algorithm used for authentication
+ * @auth_hash_algo: the authentication hash used for this fs
+ *
  * @empty: %1 if the UBI device is empty
  * @need_recovery: %1 if the file-system needs recovery
  * @replaying: %1 during journal replay
@@ -1258,6 +1270,7 @@ struct ubifs_info {
 	unsigned int bulk_read:1;
 	unsigned int default_compr:2;
 	unsigned int rw_incompat:1;
+	unsigned int authenticated:1;
 
 	struct mutex tnc_mutex;
 	struct ubifs_zbranch zroot;
@@ -1302,6 +1315,7 @@ struct ubifs_info {
 	uint32_t (*key_hash)(const char *str, int len);
 	int key_fmt;
 	int key_len;
+	int hash_len;
 	int fanout;
 
 	int min_io_size;
@@ -1429,6 +1443,13 @@ struct ubifs_info {
 	kuid_t rp_uid;
 	kgid_t rp_gid;
 
+	struct crypto_shash *hash_tfm;
+	struct crypto_shash *hmac_tfm;
+	int hmac_desc_len;
+	char *auth_key_name;
+	char *auth_hash_name;
+	enum hash_algo auth_hash_algo;
+
 	/* The below fields are used only during mounting and re-mounting */
 	unsigned int empty:1;
 	unsigned int need_recovery:1;
@@ -1459,6 +1480,172 @@ extern const struct inode_operations ubifs_dir_inode_operations;
 extern const struct inode_operations ubifs_symlink_inode_operations;
 extern struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
 
+/* auth.c */
+static inline int ubifs_authenticated(const struct ubifs_info *c)
+{
+	return (IS_ENABLED(CONFIG_UBIFS_FS_AUTHENTICATION)) && c->authenticated;
+}
+
+struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c);
+static inline struct shash_desc *ubifs_hash_get_desc(const struct ubifs_info *c)
+{
+	return ubifs_authenticated(c) ? __ubifs_hash_get_desc(c) : NULL;
+}
+
+static inline void ubifs_shash_update(const struct ubifs_info *c,
+				      struct shash_desc *desc, const void *buf,
+				      unsigned int len)
+{
+	if (ubifs_authenticated(c))
+		crypto_shash_update(desc, buf, len);
+}
+
+static inline int ubifs_shash_final(const struct ubifs_info *c,
+				    struct shash_desc *desc, u8 *out)
+{
+	return ubifs_authenticated(c) ? crypto_shash_final(desc, out) : 0;
+}
+
+void __ubifs_node_calc_hash(const struct ubifs_info *c, const void *buf,
+			  u8 *hash);
+static inline void ubifs_node_calc_hash(const struct ubifs_info *c,
+					const void *buf, u8 *hash)
+{
+	if (ubifs_authenticated(c))
+		__ubifs_node_calc_hash(c, buf, hash);
+}
+
+void ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
+			     struct shash_desc *inhash);
+
+/**
+ * ubifs_check_hash - compare two hashes
+ * @c: UBIFS file-system description object
+ * @expected: first hash
+ * @got: second hash
+ *
+ * Compare two hashes @expected and @got. Returns 0 when they are equal, a
+ * negative error code otherwise.
+ */
+static inline int ubifs_check_hash(const struct ubifs_info *c,
+				   const u8 *expected, const u8 *got)
+{
+	return crypto_memneq(expected, got, c->hash_len);
+}
+
+/**
+ * ubifs_check_hmac - compare two HMACs
+ * @c: UBIFS file-system description object
+ * @expected: first HMAC
+ * @got: second HMAC
+ *
+ * Compare two hashes @expected and @got. Returns 0 when they are equal, a
+ * negative error code otherwise.
+ */
+static inline int ubifs_check_hmac(const struct ubifs_info *c,
+				   const u8 *expected, const u8 *got)
+{
+	return crypto_memneq(expected, got, c->hmac_desc_len);
+}
+
+int __ubifs_node_check_hash(const struct ubifs_info *c, void *buf,
+			  const u8 *expected);
+static inline int ubifs_node_check_hash(const struct ubifs_info *c, void *buf,
+			  const u8 *expected)
+{
+	if (ubifs_authenticated(c))
+		return __ubifs_node_check_hash(c, buf, expected);
+	else
+		return 0;
+}
+
+int ubifs_init_authentication(struct ubifs_info *c);
+void __ubifs_exit_authentication(struct ubifs_info *c);
+static inline void ubifs_exit_authentication(struct ubifs_info *c)
+{
+	if (ubifs_authenticated(c))
+		__ubifs_exit_authentication(c);
+}
+
+/**
+ * ubifs_branch_hash - returns a pointer to the hash of a branch
+ * @c: UBIFS file-system description object
+ * @br: branch to get the hash from
+ *
+ * This returns a pointer to the hash of a branch. Since the key already is a
+ * dynamically sized object we cannot use a struct member here.
+ */
+static inline u8 *ubifs_branch_hash(struct ubifs_info *c,
+				    struct ubifs_branch *br)
+{
+	return (void *)br + sizeof(*br) + c->key_len;
+}
+
+/**
+ * ubifs_copy_hash - copy a hash
+ * @c: UBIFS file-system description object
+ * @from: source hash
+ * @to: destination hash
+ *
+ * With authentication this copies a hash, otherwise does nothing.
+ */
+static inline void ubifs_copy_hash(const struct ubifs_info *c, const u8 *from,
+				   u8 *to)
+{
+	if (ubifs_authenticated(c))
+		memcpy(to, from, c->hash_len);
+}
+
+void __ubifs_node_insert_hmac(const struct ubifs_info *c, void *buf,
+			      int len, int ofs_hmac);
+static inline void ubifs_node_insert_hmac(const struct ubifs_info *c, void *buf,
+					  int len, int ofs_hmac)
+{
+	if (ubifs_authenticated(c))
+		__ubifs_node_insert_hmac(c, buf, len, ofs_hmac);
+}
+
+int __ubifs_node_verify_hmac(const struct ubifs_info *c, const void *buf,
+			     int len, int ofs_hmac);
+static inline int ubifs_node_verify_hmac(const struct ubifs_info *c,
+					 const void *buf, int len, int ofs_hmac)
+{
+	if (ubifs_authenticated(c))
+		return __ubifs_node_verify_hmac(c, buf, len, ofs_hmac);
+	else
+		return 0;
+}
+
+/**
+ * ubifs_auth_node_sz - returns the size of an authentication node
+ * @c: UBIFS file-system description object
+ *
+ * This function returns the size of an authentication node which can
+ * be 0 for unauthenticated filesystems or the real size of an auth node
+ * authentication is enabled.
+ */
+static inline int ubifs_auth_node_sz(const struct ubifs_info *c)
+{
+	if (ubifs_authenticated(c))
+		return sizeof(struct ubifs_auth_node) + c->hmac_desc_len;
+	else
+		return 0;
+}
+
+void ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac);
+
+int __ubifs_shash_copy_state(const struct ubifs_info *c, struct shash_desc *src,
+			     struct shash_desc *target);
+static inline int ubifs_shash_copy_state(const struct ubifs_info *c,
+					   struct shash_desc *src,
+					   struct shash_desc *target)
+{
+	if (ubifs_authenticated(c))
+		return __ubifs_shash_copy_state(c, src, target);
+	else
+		return 0;
+}
+
 /* io.c */
 void ubifs_ro_mode(struct ubifs_info *c, int err);
 int ubifs_leb_read(const struct ubifs_info *c, int lnum, void *buf, int offs,
-- 
2.18.0


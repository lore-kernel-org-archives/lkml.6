Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CCCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B10208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B10208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH0QhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:37:15 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:54252 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeH0QhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:37:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 99577609199C;
        Mon, 27 Aug 2018 14:50:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eMVm7ePAcfkQ; Mon, 27 Aug 2018 14:50:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A1194608D734;
        Mon, 27 Aug 2018 14:50:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WpQxS9v7QxlR; Mon, 27 Aug 2018 14:50:38 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5E2F7609199C;
        Mon, 27 Aug 2018 14:50:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/25] ubifs: add helper functions for authentication support
Date:   Mon, 27 Aug 2018 14:50:37 +0200
Message-ID: <1675445.itdTWD7r8S@blindfold>
In-Reply-To: <20180704124137.13396-11-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-11-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 14:41:22 CEST schrieb Sascha Hauer:
> This patch adds the various helper functions needed for authentication
> support. We need functions to hash nodes, to embed HMACs into a node and
> to compare hashes and HMACs. Most functions first check if this
> filesystem is authenticated and bail out early if not, which makes the
> functions safe to be called with disabled authentication.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/Kconfig  |   1 +
>  fs/ubifs/Makefile |   1 +
>  fs/ubifs/auth.c   | 413 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ubifs/ubifs.h  | 187 +++++++++++++++++++++
>  4 files changed, 602 insertions(+)
>  create mode 100644 fs/ubifs/auth.c
> 
> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
> index 83a961bf7280..2a0b5f1134a4 100644
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@ -7,6 +7,7 @@ config UBIFS_FS
>  	select CRYPTO if UBIFS_FS_ZLIB
>  	select CRYPTO_LZO if UBIFS_FS_LZO
>  	select CRYPTO_DEFLATE if UBIFS_FS_ZLIB
> +	select CRYPTO_HASH_INFO
>  	depends on MTD_UBI
>  	help
>  	  UBIFS is a file system for flash devices which works on top of UBI.
> diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
> index 9758f709c736..2bdb8ae2f435 100644
> --- a/fs/ubifs/Makefile
> +++ b/fs/ubifs/Makefile
> @@ -7,3 +7,4 @@ ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
>  ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o xattr.o debug.o
>  ubifs-y += misc.o
>  ubifs-$(CONFIG_UBIFS_FS_ENCRYPTION) += crypto.o
> +ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> new file mode 100644
> index 000000000000..fd21f2ec8734
> --- /dev/null
> +++ b/fs/ubifs/auth.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file is part of UBIFS.
> + *
> + * Copyright (C) 2018 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
> + */
> +
> +/*
> + * This file implements various helper functions for UBIFS authentication support
> + */
> +
> +#include <linux/crypto.h>
> +#include <crypto/hash.h>
> +#include <crypto/sha.h>
> +#include <crypto/algapi.h>
> +#include <keys/user-type.h>
> +
> +#include "ubifs.h"
> +
> +/**
> + * ubifs_node_calc_hash - calculate the hash of a UBIFS node
> + * @c: UBIFS file-system description object
> + * @node: the node to calculate a hash for
> + * @hash: the returned hash
> + */
> +void __ubifs_node_calc_hash(const struct ubifs_info *c, const void *node,
> +			    u8 *hash)
> +{
> +	const struct ubifs_ch *ch = node;
> +	SHASH_DESC_ON_STACK(shash, c->hash_tfm);
> +
> +	shash->tfm = c->hash_tfm;
> +	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +	crypto_shash_digest(shash, node, le32_to_cpu(ch->len), hash);
> +}
> +
> +/**
> + * ubifs_hash_calc_hmac - calculate a HMAC from a hash
> + * @c: UBIFS file-system description object
> + * @hash: the node to calculate a HMAC for
> + * @hmac: the returned HMAC
> + */
> +static void ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
> +				 u8 *hmac)
> +{
> +	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
> +
> +	shash->tfm = c->hmac_tfm;
> +	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +	crypto_shash_digest(shash, hash, c->hash_len, hmac);

Crypto functions can fail, you need to check the return value.
(Please check also other call sites)

> +}
> +
> +/**
> + * ubifs_prepare_auth_node - Prepare an authentication node
> + * @c: UBIFS file-system description object
> + * @node: the node to calculate a hash for
> + * @hash: input hash of previous nodes
> + *
> + * This function prepares an authentication node for writing onto flash.
> + * It creates a HMAC from the given input hash and writes it to the node.
> + */
> +void ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
> +			     struct shash_desc *inhash)
> +{
> +	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
> +	struct ubifs_auth_node *auth = node;
> +	u8 hash[crypto_shash_descsize(c->hash_tfm)];

Doesn't this introduce a new VLA?
Not that me make Kees unhappy. ;-)

> +	hash_desc->tfm = c->hash_tfm;
> +	hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +	ubifs_shash_copy_state(c, inhash, hash_desc);
> +	crypto_shash_final(hash_desc, hash);
> +
> +	ubifs_hash_calc_hmac(c, hash, auth->hmac);
> +
> +	auth->ch.node_type = UBIFS_AUTH_NODE;
> +	ubifs_prepare_node(c, auth, ubifs_auth_node_sz(c), 0);
> +}
> +
> +static struct shash_desc *ubifs_get_desc(const struct ubifs_info *c,
> +					 struct crypto_shash *tfm)
> +{
> +	struct shash_desc *desc;
> +	int err;
> +
> +	if (!ubifs_authenticated(c))
> +		return NULL;
> +
> +	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
> +	if (!desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	desc->tfm = tfm;
> +	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +	err = crypto_shash_init(desc);
> +	if (err) {
> +		kfree(desc);
> +		return ERR_PTR(err);
> +	}
> +
> +	return desc;
> +}
> +
> +/**
> + * __ubifs_hash_get_desc - get a descriptor suitable for hashing a node
> + * @c: UBIFS file-system description object
> + *
> + * This function returns a descriptor suitable for hashing a node. Free after use
> + * with kfree.
> + */
> +struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
> +{
> +	return ubifs_get_desc(c, c->hash_tfm);
> +}
> +
> +/**
> + * __ubifs_shash_final - finalize shash
> + * @c: UBIFS file-system description object
> + * @desc: the descriptor
> + * @out: the output hash
> + *
> + * Simple wrapper around crypto_shash_final(), safe to be called with
> + * disabled authentication.
> + */
> +int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
> +			u8 *out)
> +{
> +	if (ubifs_authenticated(c))
> +		return crypto_shash_final(desc, out);
> +
> +	return 0;
> +}
> +
> +/**
> + * __ubifs_node_check_hash - check the hash of a node against given hash
> + * @c: UBIFS file-system description object
> + * @node: the node
> + * @expected: the expected hash
> + *
> + * This function calculates a hash over a node and compares it to the given hash.
> + * Returns 0 if both hashes are equal or authentication is disabled, otherwise a
> + * negative error code is returned.
> + */
> +int __ubifs_node_check_hash(const struct ubifs_info *c, void *node,
> +			    const u8 *expected)
> +{
> +	u8 calc[UBIFS_MAX_HASH_LEN];
> +
> +	__ubifs_node_calc_hash(c, node, calc);
> +
> +	if (ubifs_check_hash(c, expected, calc))
> +		return -EPERM;

Not sure if this action isn't a little too weak.
If a node's hash is not valid we are already in deep trouble and I'm not sure
whether it makes sense to trust the filesystem at all anymore.

But that's in general something I need to sort out with VFS/fscrypt folks.

> +	return 0;
> +}
> +
> +/**
> + * ubifs_init_authentication - initialize UBIFS authentication support
> + * @c: UBIFS file-system description object
> + *
> + * This function returns 0 for success or a negative error code otherwise.
> + */
> +int ubifs_init_authentication(struct ubifs_info *c)
> +{
> +	struct key *keyring_key;
> +	const struct user_key_payload *ukp;
> +	int err;
> +	char hmac_name[CRYPTO_MAX_ALG_NAME];
> +
> +	if (!c->auth_hash_name) {
> +		ubifs_err(c, "authentication hash name needed with authentication");
> +		return -EINVAL;
> +	}
> +
> +	c->auth_hash_algo = match_string(hash_algo_name, HASH_ALGO__LAST,
> +					 c->auth_hash_name);
> +	if ((int)c->auth_hash_algo < 0) {
> +		ubifs_err(c, "Unknown hash algo %s specified",
> +			  c->auth_hash_name);
> +		return -EINVAL;
> +	}
> +
> +	snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
> +		 c->auth_hash_name);
> +
> +	keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);
> +
> +	if (IS_ERR(keyring_key)) {
> +		ubifs_err(c, "Failed to request key: %ld",
> +			  PTR_ERR(keyring_key));
> +		return PTR_ERR(keyring_key);
> +	}
> +
> +	down_read(&keyring_key->sem);
> +
> +	if (keyring_key->type != &key_type_logon) {
> +		ubifs_err(c, "key type must be logon");
> +		err = -ENOKEY;
> +		goto out;
> +	}
> +
> +	ukp = user_key_payload_locked(keyring_key);
> +	if (!ukp) {
> +		/* key was revoked before we acquired its semaphore */
> +		err = -EKEYREVOKED;
> +		goto out;
> +	}
> +
> +	c->hash_tfm = crypto_alloc_shash(c->auth_hash_name, 0,
> +					 CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(c->hash_tfm)) {
> +		err = PTR_ERR(c->hash_tfm);
> +		ubifs_err(c, "Can not allocate %s: %d",
> +			  c->auth_hash_name, err);
> +		goto out;
> +	}
> +
> +	c->hash_len = crypto_shash_digestsize(c->hash_tfm);
> +	if (c->hash_len > UBIFS_MAX_HASH_LEN) {
> +		ubifs_err(c, "hash %s is bigger than maximum allowed hash size (%d > %d)",
> +			  c->auth_hash_name, c->hash_len, UBIFS_MAX_HASH_LEN);
> +		err = -EINVAL;
> +		goto out_free_hash;
> +	}
> +
> +	c->hmac_tfm = crypto_alloc_shash(hmac_name, 0, CRYPTO_ALG_ASYNC);
> +	if (IS_ERR(c->hmac_tfm)) {
> +		err = PTR_ERR(c->hmac_tfm);
> +		ubifs_err(c, "Can not allocate %s: %d", hmac_name, err);
> +		goto out_free_hash;
> +	}
> +
> +	c->hmac_desc_len = crypto_shash_digestsize(c->hmac_tfm);
> +	if (c->hmac_desc_len > UBIFS_MAX_HMAC_LEN) {
> +		ubifs_err(c, "hmac %s is bigger than maximum allowed hmac size (%d > %d)",
> +			  hmac_name, c->hmac_desc_len, UBIFS_MAX_HMAC_LEN);
> +		err = -EINVAL;
> +		goto out_free_hash;
> +	}
> +
> +	err = crypto_shash_setkey(c->hmac_tfm, ukp->data, ukp->datalen);
> +	if (err)
> +		goto out_free_hmac;
> +
> +	c->authenticated = true;
> +
> +	c->log_hash = ubifs_hash_get_desc(c);
> +	if (IS_ERR(c->log_hash))
> +		goto out_free_hmac;
> +
> +	err = 0;
> +
> +out_free_hmac:
> +	if (err)
> +		crypto_free_shash(c->hmac_tfm);
> +out_free_hash:
> +	if (err)
> +		crypto_free_shash(c->hash_tfm);
> +out:
> +	up_read(&keyring_key->sem);
> +	key_put(keyring_key);
> +
> +	return err;
> +}
> +
> +/**
> + * __ubifs_exit_authentication - release resource
> + * @c: UBIFS file-system description object
> + *
> + * This function releases the authentication related resources.
> + */
> +void __ubifs_exit_authentication(struct ubifs_info *c)
> +{
> +	if (!ubifs_authenticated(c))
> +		return;
> +
> +	crypto_free_shash(c->hmac_tfm);
> +	crypto_free_shash(c->hash_tfm);
> +	kfree(c->log_hash);
> +}
> +
> +/**
> + * ubifs_node_calc_hmac - calculate the HMAC of a UBIFS node
> + * @c: UBIFS file-system description object
> + * @node: the node to insert a HMAC into.
> + * @len: the length of the node
> + * @ofs_hmac: the offset in the node where the HMAC is inserted
> + * @hmac: returned HMAC
> + *
> + * This function calculates a HMAC of a UBIFS node. The HMAC is expected to be
> + * embedded into the node, so this area is not covered by the HMAC. Also not
> + * covered is the UBIFS_NODE_MAGIC and the CRC of the node.
> + */
> +static void ubifs_node_calc_hmac(const struct ubifs_info *c, const void *node,
> +				 int len, int ofs_hmac, void *hmac)
> +{
> +	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
> +	int hmac_len = c->hmac_desc_len;
> +
> +	ubifs_assert(ofs_hmac > 8);
> +	ubifs_assert(ofs_hmac + hmac_len < len);
> +
> +	shash->tfm = c->hmac_tfm;
> +	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +	crypto_shash_init(shash);
> +
> +	/* behind common node header CRC up to HMAC begin */
> +	crypto_shash_update(shash, node + 8, ofs_hmac - 8);
> +
> +	/* behind HMAC, if any */
> +	if (len - ofs_hmac - hmac_len > 0)
> +		crypto_shash_update(shash, node + ofs_hmac + hmac_len,
> +			    len - ofs_hmac - hmac_len);
> +
> +	crypto_shash_final(shash, hmac);
> +}
> +
> +/**
> + * __ubifs_node_insert_hmac - insert a HMAC into a UBIFS node
> + * @c: UBIFS file-system description object
> + * @node: the node to insert a HMAC into.
> + * @len: the length of the node
> + * @ofs_hmac: the offset in the node where the HMAC is inserted
> + *
> + * This function inserts a HMAC at offset @ofs_hmac into the node given in
> + * @node.
> + */
> +void __ubifs_node_insert_hmac(const struct ubifs_info *c, void *node, int len,
> +			    int ofs_hmac)
> +{
> +	ubifs_node_calc_hmac(c, node, len, ofs_hmac, node + ofs_hmac);
> +}
> +
> +/**
> + * __ubifs_node_verify_hmac - verify the HMAC of UBIFS node
> + * @c: UBIFS file-system description object
> + * @node: the node to insert a HMAC into.
> + * @len: the length of the node
> + * @ofs_hmac: the offset in the node where the HMAC is inserted
> + *
> + * This function verifies the HMAC at offset @ofs_hmac of the node given in
> + * @node. Returns 0 if successful or a negative error code otherwise.
> + */
> +int __ubifs_node_verify_hmac(const struct ubifs_info *c, const void *node,
> +			     int len, int ofs_hmac)
> +{
> +	int hmac_len = c->hmac_desc_len;
> +	u8 *hmac;
> +	int err;
> +
> +	hmac = kmalloc(hmac_len, GFP_NOFS);
> +	if (!hmac)
> +		return -ENOMEM;
> +
> +	ubifs_node_calc_hmac(c, node, len, ofs_hmac, hmac);
> +
> +	err = crypto_memneq(hmac, node + ofs_hmac, hmac_len);
> +
> +	kfree(hmac);
> +
> +	if (!err)
> +		return 0;
> +
> +	return -EPERM;

Same.

> +}
> +
> +int __ubifs_shash_copy_state(const struct ubifs_info *c, struct shash_desc *src,
> +			     struct shash_desc *target)
> +{
> +	u8 state[crypto_shash_descsize(src->tfm)];
> +	int err;
> +
> +	err = crypto_shash_export(src, state);
> +	if (err)
> +		return err;
> +
> +	return crypto_shash_import(target, state);
> +}
> +
> +/**
> + * ubifs_hmac_wkm - Create a HMAC of the well known message
> + * @c: UBIFS file-system description object
> + * @hmac: The HMAC of the well known message
> + *
> + * This function creates a HMAC of a well known message. This is used
> + * to check if the provided key is suitable to authenticate a UBIFS
> + * image. This is only a convenience to the user to provide a better
> + * error message when the wrong key is provided.
> + */
> +void ubifs_hmac_wkm(struct ubifs_info *c, u8 *hmac)
> +{
> +	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
> +	int err;
> +	const char well_known_message[] = "UBIFS";
> +
> +	if (!ubifs_authenticated(c))
> +		return;
> +
> +	shash->tfm = c->hmac_tfm;
> +	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +	err = crypto_shash_init(shash);
> +	BUG_ON(err);

Huh? Do we really have to shoot the kernel in the head here?

Thanks,
//richard



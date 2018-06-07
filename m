Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1B7RDcZEGVvTGAAAmS7hNA
	; Thu, 07 Jun 2018 14:45:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B8A5C608BF; Thu,  7 Jun 2018 14:45:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3F35607DC;
	Thu,  7 Jun 2018 14:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3F35607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934945AbeFGOo5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:44:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40724 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbeFGOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:44:55 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbp-0005Zs-M9; Thu, 07 Jun 2018 15:09:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002rG-CE; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Biggers" <ebiggers@google.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.800807524@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 124/410] crypto: hash - prevent using keyed hashes
 without setting key
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 9fa68f620041be04720d0cbfb1bd3ddfc6310b24 upstream.

Currently, almost none of the keyed hash algorithms check whether a key
has been set before proceeding.  Some algorithms are okay with this and
will effectively just use a key of all 0's or some other bogus default.
However, others will severely break, as demonstrated using
"hmac(sha3-512-generic)", the unkeyed use of which causes a kernel crash
via a (potentially exploitable) stack buffer overflow.

A while ago, this problem was solved for AF_ALG by pairing each hash
transform with a 'has_key' bool.  However, there are still other places
in the kernel where userspace can specify an arbitrary hash algorithm by
name, and the kernel uses it as unkeyed hash without checking whether it
is really unkeyed.  Examples of this include:

    - KEYCTL_DH_COMPUTE, via the KDF extension
    - dm-verity
    - dm-crypt, via the ESSIV support
    - dm-integrity, via the "internal hash" mode with no key given
    - drbd (Distributed Replicated Block Device)

This bug is especially bad for KEYCTL_DH_COMPUTE as that requires no
privileges to call.

Fix the bug for all users by adding a flag CRYPTO_TFM_NEED_KEY to the
->crt_flags of each hash transform that indicates whether the transform
still needs to be keyed or not.  Then, make the hash init, import, and
digest functions return -ENOKEY if the key is still needed.

The new flag also replaces the 'has_key' bool which algif_hash was
previously using, thereby simplifying the algif_hash implementation.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[bwh: Backported to 3.16:
 - In hash_accept_parent_nokey(), update initialisation of ds to use tfm
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -203,11 +203,18 @@ int crypto_ahash_setkey(struct crypto_ah
 			unsigned int keylen)
 {
 	unsigned long alignmask = crypto_ahash_alignmask(tfm);
+	int err;
 
 	if ((unsigned long)key & alignmask)
-		return ahash_setkey_unaligned(tfm, key, keylen);
+		err = ahash_setkey_unaligned(tfm, key, keylen);
+	else
+		err = tfm->setkey(tfm, key, keylen);
+
+	if (err)
+		return err;
 
-	return tfm->setkey(tfm, key, keylen);
+	crypto_ahash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_setkey);
 
@@ -380,7 +387,12 @@ EXPORT_SYMBOL_GPL(crypto_ahash_finup);
 
 int crypto_ahash_digest(struct ahash_request *req)
 {
-	return crypto_ahash_op(req, crypto_ahash_reqtfm(req)->digest);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_ahash_op(req, tfm->digest);
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_digest);
 
@@ -466,7 +478,6 @@ static int crypto_ahash_init_tfm(struct
 	struct ahash_alg *alg = crypto_ahash_alg(hash);
 
 	hash->setkey = ahash_nosetkey;
-	hash->has_setkey = false;
 	hash->export = ahash_no_export;
 	hash->import = ahash_no_import;
 
@@ -481,7 +492,8 @@ static int crypto_ahash_init_tfm(struct
 
 	if (alg->setkey) {
 		hash->setkey = alg->setkey;
-		hash->has_setkey = true;
+		if (!(alg->halg.base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+			crypto_ahash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
 	}
 	if (alg->export)
 		hash->export = alg->export;
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -34,11 +34,6 @@ struct hash_ctx {
 	struct ahash_request req;
 };
 
-struct algif_hash_tfm {
-	struct crypto_ahash *hash;
-	bool has_key;
-};
-
 static int hash_sendmsg(struct kiocb *unused, struct socket *sock,
 			struct msghdr *msg, size_t ignored)
 {
@@ -258,7 +253,7 @@ static int hash_check_key(struct socket
 	int err = 0;
 	struct sock *psk;
 	struct alg_sock *pask;
-	struct algif_hash_tfm *tfm;
+	struct crypto_ahash *tfm;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 
@@ -272,7 +267,7 @@ static int hash_check_key(struct socket
 
 	err = -ENOKEY;
 	lock_sock_nested(psk, SINGLE_DEPTH_NESTING);
-	if (!tfm->has_key)
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		goto unlock;
 
 	if (!pask->refcnt++)
@@ -363,41 +358,17 @@ static struct proto_ops algif_hash_ops_n
 
 static void *hash_bind(const char *name, u32 type, u32 mask)
 {
-	struct algif_hash_tfm *tfm;
-	struct crypto_ahash *hash;
-
-	tfm = kzalloc(sizeof(*tfm), GFP_KERNEL);
-	if (!tfm)
-		return ERR_PTR(-ENOMEM);
-
-	hash = crypto_alloc_ahash(name, type, mask);
-	if (IS_ERR(hash)) {
-		kfree(tfm);
-		return ERR_CAST(hash);
-	}
-
-	tfm->hash = hash;
-
-	return tfm;
+	return crypto_alloc_ahash(name, type, mask);
 }
 
 static void hash_release(void *private)
 {
-	struct algif_hash_tfm *tfm = private;
-
-	crypto_free_ahash(tfm->hash);
-	kfree(tfm);
+	crypto_free_ahash(private);
 }
 
 static int hash_setkey(void *private, const u8 *key, unsigned int keylen)
 {
-	struct algif_hash_tfm *tfm = private;
-	int err;
-
-	err = crypto_ahash_setkey(tfm->hash, key, keylen);
-	tfm->has_key = !err;
-
-	return err;
+	return crypto_ahash_setkey(private, key, keylen);
 }
 
 static void hash_sock_destruct(struct sock *sk)
@@ -413,12 +384,11 @@ static void hash_sock_destruct(struct so
 
 static int hash_accept_parent_nokey(void *private, struct sock *sk)
 {
-	struct hash_ctx *ctx;
+	struct crypto_ahash *tfm = private;
 	struct alg_sock *ask = alg_sk(sk);
-	struct algif_hash_tfm *tfm = private;
-	struct crypto_ahash *hash = tfm->hash;
-	unsigned len = sizeof(*ctx) + crypto_ahash_reqsize(hash);
-	unsigned ds = crypto_ahash_digestsize(hash);
+	struct hash_ctx *ctx;
+	unsigned int len = sizeof(*ctx) + crypto_ahash_reqsize(tfm);
+	unsigned ds = crypto_ahash_digestsize(tfm);
 
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
@@ -438,7 +408,7 @@ static int hash_accept_parent_nokey(void
 
 	ask->private = ctx;
 
-	ahash_request_set_tfm(&ctx->req, hash);
+	ahash_request_set_tfm(&ctx->req, tfm);
 	ahash_request_set_callback(&ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   af_alg_complete, &ctx->completion);
 
@@ -449,9 +419,9 @@ static int hash_accept_parent_nokey(void
 
 static int hash_accept_parent(void *private, struct sock *sk)
 {
-	struct algif_hash_tfm *tfm = private;
+	struct crypto_ahash *tfm = private;
 
-	if (!tfm->has_key && crypto_ahash_has_setkey(tfm->hash))
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
 
 	return hash_accept_parent_nokey(private, sk);
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -57,11 +57,18 @@ int crypto_shash_setkey(struct crypto_sh
 {
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
+	int err;
 
 	if ((unsigned long)key & alignmask)
-		return shash_setkey_unaligned(tfm, key, keylen);
+		err = shash_setkey_unaligned(tfm, key, keylen);
+	else
+		err = shash->setkey(tfm, key, keylen);
+
+	if (err)
+		return err;
 
-	return shash->setkey(tfm, key, keylen);
+	crypto_shash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_setkey);
 
@@ -180,6 +187,9 @@ int crypto_shash_digest(struct shash_des
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
 	if (((unsigned long)data | (unsigned long)out) & alignmask)
 		return shash_digest_unaligned(desc, data, len, out);
 
@@ -359,7 +369,8 @@ int crypto_init_shash_ops_async(struct c
 	crt->digest = shash_async_digest;
 	crt->setkey = shash_async_setkey;
 
-	crt->has_setkey = alg->setkey != shash_no_setkey;
+	crypto_ahash_set_flags(crt, crypto_shash_get_flags(shash) &
+				    CRYPTO_TFM_NEED_KEY);
 
 	if (alg->export)
 		crt->export = shash_async_export;
@@ -519,8 +530,14 @@ static unsigned int crypto_shash_ctxsize
 static int crypto_shash_init_tfm(struct crypto_tfm *tfm)
 {
 	struct crypto_shash *hash = __crypto_shash_cast(tfm);
+	struct shash_alg *alg = crypto_shash_alg(hash);
+
+	hash->descsize = alg->descsize;
+
+	if (crypto_shash_alg_has_setkey(alg) &&
+	    !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+		crypto_shash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
 
-	hash->descsize = crypto_shash_alg(hash)->descsize;
 	return 0;
 }
 
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -94,7 +94,6 @@ struct crypto_ahash {
 		      unsigned int keylen);
 
 	unsigned int reqsize;
-	bool has_setkey;
 	struct crypto_tfm base;
 };
 
@@ -183,11 +182,6 @@ static inline void *ahash_request_ctx(st
 int crypto_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 			unsigned int keylen);
 
-static inline bool crypto_ahash_has_setkey(struct crypto_ahash *tfm)
-{
-	return tfm->has_setkey;
-}
-
 int crypto_ahash_finup(struct ahash_request *req);
 int crypto_ahash_final(struct ahash_request *req);
 int crypto_ahash_digest(struct ahash_request *req);
@@ -199,12 +193,22 @@ static inline int crypto_ahash_export(st
 
 static inline int crypto_ahash_import(struct ahash_request *req, const void *in)
 {
-	return crypto_ahash_reqtfm(req)->import(req, in);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return tfm->import(req, in);
 }
 
 static inline int crypto_ahash_init(struct ahash_request *req)
 {
-	return crypto_ahash_reqtfm(req)->init(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return tfm->init(req);
 }
 
 static inline int crypto_ahash_update(struct ahash_request *req)
@@ -343,12 +347,22 @@ static inline int crypto_shash_export(st
 
 static inline int crypto_shash_import(struct shash_desc *desc, const void *in)
 {
-	return crypto_shash_alg(desc->tfm)->import(desc, in);
+	struct crypto_shash *tfm = desc->tfm;
+
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_shash_alg(tfm)->import(desc, in);
 }
 
 static inline int crypto_shash_init(struct shash_desc *desc)
 {
-	return crypto_shash_alg(desc->tfm)->init(desc);
+	struct crypto_shash *tfm = desc->tfm;
+
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_shash_alg(tfm)->init(desc);
 }
 
 int crypto_shash_update(struct shash_desc *desc, const u8 *data,
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -103,6 +103,8 @@
 /*
  * Transform masks and values (for crt_flags).
  */
+#define CRYPTO_TFM_NEED_KEY		0x00000001
+
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
 #define CRYPTO_TFM_RES_MASK		0xfff00000
 

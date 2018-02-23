Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416088-2-9436263387996672301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519416087; b=N5NCUf8ezyrNJmNSbeJw8SpUgattWNiDfmNDEWLxt82zkjN
    7gF7jY3qZzyYTNQbE+jfVuk8zd2gKdn5+rTsdoo4Jy/cvI4ofHj5j5qwrdbqY6HM
    brs67Ss68zCpSzC0ZrsGzDrn8pyZcCUpijeiZ2/sQAzNKaSv2cqwFyA+12R36kMU
    /hKx3GP3HurHfIZ9FbxEQwPka70X5JwTka3yVfJy/8hMloqWiwu9mQmttKBY/uB/
    nXE0yi8gR6sFlEuapHRvE9PfiFsU+b6Dyg2Bhfg4ngwS1vbdguHRXWwsvqhjYCpA
    gW5V4oP6Dg1avBRUpeNUFM/zSX+SLoOAugHuyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416087; bh=V3QyDPCHiYogN9ShKNDZ/y6XvG
    V5K0W5H5MWFB9/y/I=; b=bYkAC6VT4HNxA++w18LBZwzMEn0aS1u9/MLhn/XjhE
    Z+I0LbJrkVYE1zmlzHoX4KhsYK+qUtOtf5QlmQlERVINRKmlx0Fg0Jz7bMqyMC+S
    ttPu+c+GiTGzhxv7pbQ3XBbLxWS0xnT/DYnFHVmQWduDQ8HT0PesfsJKv+fPufic
    TSc2PecpOeYNfmgblnDSUzj8xtkywvw7bpCp7Q4OlNdtLZ1V4c/S/ZtMsvyDrEnk
    McM52LHP4flioT8uYYKlpcorQgkOVYs68PLIc/g7XxnoZ40LygXt+mkNzgEN27HN
    /4ICSOBFe5ViP9VzEUfXfeLC6443Z8FXdrg359+Wpzpw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755092AbeBWUBM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:01:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933289AbeBWSnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 031/145] crypto: hash - prevent using keyed hashes without setting key
Date: Fri, 23 Feb 2018 19:25:37 +0100
Message-Id: <20180223170728.909550166@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 crypto/ahash.c         |   22 ++++++++++++++++----
 crypto/algif_hash.c    |   52 ++++++++++---------------------------------------
 crypto/shash.c         |   25 +++++++++++++++++++----
 include/crypto/hash.h  |   34 ++++++++++++++++++++++----------
 include/linux/crypto.h |    2 +
 5 files changed, 75 insertions(+), 60 deletions(-)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -192,11 +192,18 @@ int crypto_ahash_setkey(struct crypto_ah
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
 
@@ -369,7 +376,12 @@ EXPORT_SYMBOL_GPL(crypto_ahash_finup);
 
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
 
@@ -455,7 +467,6 @@ static int crypto_ahash_init_tfm(struct
 	struct ahash_alg *alg = crypto_ahash_alg(hash);
 
 	hash->setkey = ahash_nosetkey;
-	hash->has_setkey = false;
 	hash->export = ahash_no_export;
 	hash->import = ahash_no_import;
 
@@ -470,7 +481,8 @@ static int crypto_ahash_init_tfm(struct
 
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
 static int hash_alloc_result(struct sock *sk, struct hash_ctx *ctx)
 {
 	unsigned ds;
@@ -308,7 +303,7 @@ static int hash_check_key(struct socket
 	int err = 0;
 	struct sock *psk;
 	struct alg_sock *pask;
-	struct algif_hash_tfm *tfm;
+	struct crypto_ahash *tfm;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 
@@ -322,7 +317,7 @@ static int hash_check_key(struct socket
 
 	err = -ENOKEY;
 	lock_sock_nested(psk, SINGLE_DEPTH_NESTING);
-	if (!tfm->has_key)
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		goto unlock;
 
 	if (!pask->refcnt++)
@@ -413,41 +408,17 @@ static struct proto_ops algif_hash_ops_n
 
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
@@ -462,11 +433,10 @@ static void hash_sock_destruct(struct so
 
 static int hash_accept_parent_nokey(void *private, struct sock *sk)
 {
-	struct hash_ctx *ctx;
+	struct crypto_ahash *tfm = private;
 	struct alg_sock *ask = alg_sk(sk);
-	struct algif_hash_tfm *tfm = private;
-	struct crypto_ahash *hash = tfm->hash;
-	unsigned len = sizeof(*ctx) + crypto_ahash_reqsize(hash);
+	struct hash_ctx *ctx;
+	unsigned int len = sizeof(*ctx) + crypto_ahash_reqsize(tfm);
 
 	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
@@ -479,7 +449,7 @@ static int hash_accept_parent_nokey(void
 
 	ask->private = ctx;
 
-	ahash_request_set_tfm(&ctx->req, hash);
+	ahash_request_set_tfm(&ctx->req, tfm);
 	ahash_request_set_callback(&ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   af_alg_complete, &ctx->completion);
 
@@ -490,9 +460,9 @@ static int hash_accept_parent_nokey(void
 
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
@@ -374,8 +385,14 @@ int crypto_init_shash_ops_async(struct c
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
@@ -205,7 +205,6 @@ struct crypto_ahash {
 		      unsigned int keylen);
 
 	unsigned int reqsize;
-	bool has_setkey;
 	struct crypto_tfm base;
 };
 
@@ -399,11 +398,6 @@ static inline void *ahash_request_ctx(st
 int crypto_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 			unsigned int keylen);
 
-static inline bool crypto_ahash_has_setkey(struct crypto_ahash *tfm)
-{
-	return tfm->has_setkey;
-}
-
 /**
  * crypto_ahash_finup() - update and finalize message digest
  * @req: reference to the ahash_request handle that holds all information
@@ -475,7 +469,12 @@ static inline int crypto_ahash_export(st
  */
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
 
 /**
@@ -492,7 +491,12 @@ static inline int crypto_ahash_import(st
  */
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
 
 /**
@@ -845,7 +849,12 @@ static inline int crypto_shash_export(st
  */
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
 
 /**
@@ -861,7 +870,12 @@ static inline int crypto_shash_import(st
  */
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
 
 /**
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -111,6 +111,8 @@
 /*
  * Transform masks and values (for crt_flags).
  */
+#define CRYPTO_TFM_NEED_KEY		0x00000001
+
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
 #define CRYPTO_TFM_RES_MASK		0xfff00000
 

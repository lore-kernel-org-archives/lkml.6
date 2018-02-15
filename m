Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Dej1YBwFZhputM3M//k7hYB7K0rxBtmVzgEe+DIiIYkh6oKPm8EZUCK9awD4AYZBB7mv6
ARC-Seal: i=1; a=rsa-sha256; t=1518708413; cv=none;
        d=google.com; s=arc-20160816;
        b=MsbOIgzSwtrqcXuhtDIrvO44Bus2mXU5HmKmGKCJ9ii53uRWJF2EJCainrtjD3CKID
         ALYypAvYPRb6wqxPvYmaK/4wH5kK0lsumJmOyK2A7J3j27XAAKOZb+A2k+AUT9Rrn5HH
         bbv00StPwSE3LDICRvGoNVQjxjyh6hPHMMuX/mchaouh6XXWhqVj0QeJzXUUDypjQXLv
         Wuh42uAK3nWPPPWlX55S08hxRK/YfUeA8IqpNcxgm85h+Qpbn/lbdgdUaCJ7drAujxBx
         GSoh1Won0tWAdh17tU6b0TKE2hcaecGS++5zrxmJZdrH2p6uoTmnYSNBohrpxARj5Yvv
         4YgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kfmJKAckRQ2lJm9ZmTjdoE03sR7wsBrSEvqIp9o9VTM=;
        b=s6mOtxsUtnM+Rd1n080wuj/p164Ze595L9SS9FV5xaNMUJt5QueJN/fuM17B9D+Pxq
         8wCiovOrmKdlUM9MtrOYjnY8rFgfIKKbqbCD/hs//hTa3Pxt+Vj/ZwdHZXLcQwFGnKzD
         4OSuXpKLB38T7t0SZVpgqxRu2ACyBdhWsAQk0jNzTeE12fexFyA+GeVMTATsSHcL1B6u
         ynQ0OkustZlBXHeycg4vw9Tu5e/caYMUrEszIz4xZ9Ce9ZGY3i8btzSnA9V2GEQPlHgA
         +yVl3rK2kA6WZwxV9a6ZC7AeXlkdyXhAtPfGBaEcICF974n+X951AFz89ILtmh5XBI8B
         bSng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 34/88] crypto: poly1305 - remove ->setkey() method
Date: Thu, 15 Feb 2018 16:17:01 +0100
Message-Id: <20180215151227.366442927@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480998733653142?=
X-GMAIL-MSGID: =?utf-8?q?1592481193239018730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a16e772e664b9a261424107784804cffc8894977 upstream.

Since Poly1305 requires a nonce per invocation, the Linux kernel
implementations of Poly1305 don't use the crypto API's keying mechanism
and instead expect the key and nonce as the first 32 bytes of the data.
But ->setkey() is still defined as a stub returning an error code.  This
prevents Poly1305 from being used through AF_ALG and will also break it
completely once we start enforcing that all crypto API users (not just
AF_ALG) call ->setkey() if present.

Fix it by removing crypto_poly1305_setkey(), leaving ->setkey as NULL.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/poly1305_glue.c |    1 -
 crypto/poly1305_generic.c       |   17 +++++------------
 include/crypto/poly1305.h       |    2 --
 3 files changed, 5 insertions(+), 15 deletions(-)

--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -164,7 +164,6 @@ static struct shash_alg alg = {
 	.init		= poly1305_simd_init,
 	.update		= poly1305_simd_update,
 	.final		= crypto_poly1305_final,
-	.setkey		= crypto_poly1305_setkey,
 	.descsize	= sizeof(struct poly1305_simd_desc_ctx),
 	.base		= {
 		.cra_name		= "poly1305",
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -51,17 +51,6 @@ int crypto_poly1305_init(struct shash_de
 }
 EXPORT_SYMBOL_GPL(crypto_poly1305_init);
 
-int crypto_poly1305_setkey(struct crypto_shash *tfm,
-			   const u8 *key, unsigned int keylen)
-{
-	/* Poly1305 requires a unique key for each tag, which implies that
-	 * we can't set it on the tfm that gets accessed by multiple users
-	 * simultaneously. Instead we expect the key as the first 32 bytes in
-	 * the update() call. */
-	return -ENOTSUPP;
-}
-EXPORT_SYMBOL_GPL(crypto_poly1305_setkey);
-
 static void poly1305_setrkey(struct poly1305_desc_ctx *dctx, const u8 *key)
 {
 	/* r &= 0xffffffc0ffffffc0ffffffc0fffffff */
@@ -80,6 +69,11 @@ static void poly1305_setskey(struct poly
 	dctx->s[3] = le32_to_cpuvp(key + 12);
 }
 
+/*
+ * Poly1305 requires a unique key for each tag, which implies that we can't set
+ * it on the tfm that gets accessed by multiple users simultaneously. Instead we
+ * expect the key as the first 32 bytes in the update() call.
+ */
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen)
 {
@@ -285,7 +279,6 @@ static struct shash_alg poly1305_alg = {
 	.init		= crypto_poly1305_init,
 	.update		= crypto_poly1305_update,
 	.final		= crypto_poly1305_final,
-	.setkey		= crypto_poly1305_setkey,
 	.descsize	= sizeof(struct poly1305_desc_ctx),
 	.base		= {
 		.cra_name		= "poly1305",
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -30,8 +30,6 @@ struct poly1305_desc_ctx {
 };
 
 int crypto_poly1305_init(struct shash_desc *desc);
-int crypto_poly1305_setkey(struct crypto_shash *tfm,
-			   const u8 *key, unsigned int keylen);
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen);
 int crypto_poly1305_update(struct shash_desc *desc,

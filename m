Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227zoYCwdQUydyA//rcFvSB14scqMjXcjkEd8qRruJXUfHYupLbKzKkHW9Mwne5BfBrn82Ex
ARC-Seal: i=1; a=rsa-sha256; t=1518708892; cv=none;
        d=google.com; s=arc-20160816;
        b=vr+KGUFhNv798s/6T86o02aRSZ7hYQMibXISBL1txmJwPdlC2favA5itXYoWC4DQ2W
         dw0xR8nq2yqz8VZLyGIpQJF/uFs7iROUKcg3pjrTCTiyGiUV8HnuSs26QCDTybKHx4W4
         npL++ZsXpQuydD440t67t0gNAdJg/f02Rv2My7Axz2oML+e+3GGJ5bcoS672vpmTEwA+
         ikyD6Wd7dwOeJnXFs8gN7RcNAJniGakI8WTHss0bbfxl0dapc3WNcMz70+L6PQGXaJWz
         cSgdbc7dZINti3rpN/4YKEpKRWjtz3l1yaDIqngD29KqahtZkKvzD1dtLUzN3AjezUju
         kvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vqgWxxaYYQg0ehK9pj2lutv9yWfe+IN+cbei3stVc7Y=;
        b=DadSTHyffxA6f+GmxBfu5NCEpr9P4oaKjZL7zcQDvp5p6n/cL9tuYcUzXxdaKM7u4I
         O0rHYz9a2Bkl+7hkKnJ552VXBiDBh1twatE4yXotijvwPassOCdDY3dZZMyvJp+vaATo
         xfps/hky5ov/yRnYgY7u5uKwJ+TEmf616gzBJAvgf0hsgw14a8DtnJU8480Mt184g1fw
         aFU64jFfzWOLt8AZev6XrSGjb/DR2tncbjjfKMhlEmMPTwhp6P9ieB/+VWYwD5OeTXPd
         VHGdpgHZLVdtSWbqH9UzzH6hVbZyQVPaM3V4iJQLmyzl2AJhU7cJeOYgvlEyA9dr/3j/
         +qrw==
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
Subject: [PATCH 4.14 117/195] crypto: poly1305 - remove ->setkey() method
Date: Thu, 15 Feb 2018 16:16:48 +0100
Message-Id: <20180215151711.535617534@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480998733653142?=
X-GMAIL-MSGID: =?utf-8?q?1592481696132945031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -47,17 +47,6 @@ int crypto_poly1305_init(struct shash_de
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
@@ -76,6 +65,11 @@ static void poly1305_setskey(struct poly
 	dctx->s[3] = get_unaligned_le32(key + 12);
 }
 
+/*
+ * Poly1305 requires a unique key for each tag, which implies that we can't set
+ * it on the tfm that gets accessed by multiple users simultaneously. Instead we
+ * expect the key as the first 32 bytes in the update() call.
+ */
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen)
 {
@@ -281,7 +275,6 @@ static struct shash_alg poly1305_alg = {
 	.init		= crypto_poly1305_init,
 	.update		= crypto_poly1305_update,
 	.final		= crypto_poly1305_final,
-	.setkey		= crypto_poly1305_setkey,
 	.descsize	= sizeof(struct poly1305_desc_ctx),
 	.base		= {
 		.cra_name		= "poly1305",
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -31,8 +31,6 @@ struct poly1305_desc_ctx {
 };
 
 int crypto_poly1305_init(struct shash_desc *desc);
-int crypto_poly1305_setkey(struct crypto_shash *tfm,
-			   const u8 *key, unsigned int keylen);
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen);
 int crypto_poly1305_update(struct shash_desc *desc,

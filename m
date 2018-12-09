Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33591C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBC220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBC220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeLIW15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34644 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002io-QB; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003DN-8m; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        "Daniel Borkmann" <dborkman@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Julia Lawall" <julia.lawall@lip6.fr>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.751545262@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 016/328] crypto: memzero_explicit - make sure to
 clear out sensitive data
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <dborkman@redhat.com>

commit 7185ad2672a7d50bc384de0e38d90b75d99f3d82 upstream.

Recently, in commit 13aa93c70e71 ("random: add and use memzero_explicit()
for clearing data"), we have found that GCC may optimize some memset()
cases away when it detects a stack variable is not being used anymore
and going out of scope. This can happen, for example, in cases when we
are clearing out sensitive information such as keying material or any
e.g. intermediate results from crypto computations, etc.

With the help of Coccinelle, we can figure out and fix such occurences
in the crypto subsytem as well. Julia Lawall provided the following
Coccinelle program:

  @@
  type T;
  identifier x;
  @@

  T x;
  ... when exists
      when any
  -memset
  +memzero_explicit
     (&x,
  -0,
     ...)
  ... when != x
      when strict

  @@
  type T;
  identifier x;
  @@

  T x[...];
  ... when exists
      when any
  -memset
  +memzero_explicit
     (x,
  -0,
     ...)
  ... when != x
      when strict

Therefore, make use of the drop-in replacement memzero_explicit() for
exactly such cases instead of using memset().

Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/cts.c            | 3 ++-
 crypto/sha1_generic.c   | 2 +-
 crypto/sha256_generic.c | 5 ++---
 crypto/sha512_generic.c | 2 +-
 crypto/tgr192.c         | 4 ++--
 crypto/vmac.c           | 2 +-
 crypto/wp512.c          | 8 ++++----
 7 files changed, 13 insertions(+), 13 deletions(-)

--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -202,7 +202,8 @@ static int cts_cbc_decrypt(struct crypto
 	/* 5. Append the tail (BB - Ln) bytes of Xn (tmp) to Cn to create En */
 	memcpy(s + bsize + lastn, tmp + lastn, bsize - lastn);
 	/* 6. Decrypt En to create Pn-1 */
-	memset(iv, 0, sizeof(iv));
+	memzero_explicit(iv, sizeof(iv));
+
 	sg_set_buf(&sgsrc[0], s + bsize, bsize);
 	sg_set_buf(&sgdst[0], d, bsize);
 	err = crypto_blkcipher_decrypt_iv(&lcldesc, sgdst, sgsrc, bsize);
--- a/crypto/sha1_generic.c
+++ b/crypto/sha1_generic.c
@@ -64,7 +64,7 @@ int crypto_sha1_update(struct shash_desc
 			src = data + done;
 		} while (done + SHA1_BLOCK_SIZE <= len);
 
-		memset(temp, 0, sizeof(temp));
+		memzero_explicit(temp, sizeof(temp));
 		partial = 0;
 	}
 	memcpy(sctx->buffer + partial, src, len - done);
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -210,10 +210,9 @@ static void sha256_transform(u32 *state,
 
 	/* clear any sensitive info... */
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
-	memset(W, 0, 64 * sizeof(u32));
+	memzero_explicit(W, 64 * sizeof(u32));
 }
 
-
 static int sha224_init(struct shash_desc *desc)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
@@ -316,7 +315,7 @@ static int sha224_final(struct shash_des
 	sha256_final(desc, D);
 
 	memcpy(hash, D, SHA224_DIGEST_SIZE);
-	memset(D, 0, SHA256_DIGEST_SIZE);
+	memzero_explicit(D, SHA256_DIGEST_SIZE);
 
 	return 0;
 }
--- a/crypto/sha512_generic.c
+++ b/crypto/sha512_generic.c
@@ -238,7 +238,7 @@ static int sha384_final(struct shash_des
 	sha512_final(desc, D);
 
 	memcpy(hash, D, 48);
-	memset(D, 0, 64);
+	memzero_explicit(D, 64);
 
 	return 0;
 }
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -612,7 +612,7 @@ static int tgr160_final(struct shash_des
 
 	tgr192_final(desc, D);
 	memcpy(out, D, TGR160_DIGEST_SIZE);
-	memset(D, 0, TGR192_DIGEST_SIZE);
+	memzero_explicit(D, TGR192_DIGEST_SIZE);
 
 	return 0;
 }
@@ -623,7 +623,7 @@ static int tgr128_final(struct shash_des
 
 	tgr192_final(desc, D);
 	memcpy(out, D, TGR128_DIGEST_SIZE);
-	memset(D, 0, TGR192_DIGEST_SIZE);
+	memzero_explicit(D, TGR192_DIGEST_SIZE);
 
 	return 0;
 }
--- a/crypto/vmac.c
+++ b/crypto/vmac.c
@@ -613,7 +613,7 @@ static int vmac_final(struct shash_desc
 	}
 	mac = vmac(ctx->partial, ctx->partial_size, nonce, NULL, ctx);
 	memcpy(out, &mac, sizeof(vmac_t));
-	memset(&mac, 0, sizeof(vmac_t));
+	memzero_explicit(&mac, sizeof(vmac_t));
 	memset(&ctx->__vmac_ctx, 0, sizeof(struct vmac_ctx));
 	ctx->partial_size = 0;
 	return 0;
--- a/crypto/wp512.c
+++ b/crypto/wp512.c
@@ -1102,8 +1102,8 @@ static int wp384_final(struct shash_desc
 	u8 D[64];
 
 	wp512_final(desc, D);
-	memcpy (out, D, WP384_DIGEST_SIZE);
-	memset (D, 0, WP512_DIGEST_SIZE);
+	memcpy(out, D, WP384_DIGEST_SIZE);
+	memzero_explicit(D, WP512_DIGEST_SIZE);
 
 	return 0;
 }
@@ -1113,8 +1113,8 @@ static int wp256_final(struct shash_desc
 	u8 D[64];
 
 	wp512_final(desc, D);
-	memcpy (out, D, WP256_DIGEST_SIZE);
-	memset (D, 0, WP512_DIGEST_SIZE);
+	memcpy(out, D, WP256_DIGEST_SIZE);
+	memzero_explicit(D, WP512_DIGEST_SIZE);
 
 	return 0;
 }


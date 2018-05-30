Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeE3LN7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:13:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60723 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752231AbeE3LHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:30 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Biggers" <ebiggers@google.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.685610822@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 044/153] crypto: hash - annotate algorithms taking
 optional key
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a208fa8f33031b9e0aba44c7d1b7e68eb0cbd29e upstream.

We need to consistently enforce that keyed hashes cannot be used without
setting the key.  To do this we need a reliable way to determine whether
a given hash algorithm is keyed or not.  AF_ALG currently does this by
checking for the presence of a ->setkey() method.  However, this is
actually slightly broken because the CRC-32 algorithms implement
->setkey() but can also be used without a key.  (The CRC-32 "key" is not
actually a cryptographic key but rather represents the initial state.
If not overridden, then a default initial state is used.)

Prepare to fix this by introducing a flag CRYPTO_ALG_OPTIONAL_KEY which
indicates that the algorithm has a ->setkey() method, but it is not
required to be called.  Then set it on all the CRC-32 algorithms.

The same also applies to the Adler-32 implementation in Lustre.

Also, the cryptd and mcryptd templates have to pass through the flag
from their underlying algorithm.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[bwh: Backported to 3.2:
 - Drop changes to nonexistent drivers
 - There's no CRYPTO_ALG_INTERNAL flag
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/crypto/crc32c-intel.c
+++ b/arch/x86/crypto/crc32c-intel.c
@@ -166,6 +166,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-intel",
 		.cra_priority		=	200,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_module		=	THIS_MODULE,
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -234,6 +234,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-generic",
 		.cra_priority		=	100,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_alignmask		=	3,
 		.cra_ctxsize		=	sizeof(struct chksum_ctx),
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -603,7 +603,8 @@ static int cryptd_create_hash(struct cry
 	if (err)
 		goto out_free_inst;
 
-	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC;
+	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & CRYPTO_ALG_OPTIONAL_KEY);
 
 	inst->alg.halg.digestsize = salg->digestsize;
 	inst->alg.halg.base.cra_ctxsize = sizeof(struct cryptd_hash_ctx);
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -89,6 +89,12 @@
 #define CRYPTO_ALG_INSTANCE		0x00000800
 
 /*
+ * Set if the algorithm has a ->setkey() method but can be used without
+ * calling it first, i.e. there is a default key.
+ */
+#define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
+
+/*
  * Transform masks and values (for crt_flags).
  */
 #define CRYPTO_TFM_REQ_MASK		0x000fff00

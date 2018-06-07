Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yVMYJEhNGVs/cQAAmS7hNA
	; Thu, 07 Jun 2018 15:20:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C6D5D607E7; Thu,  7 Jun 2018 15:20:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2D930606DD;
	Thu,  7 Jun 2018 15:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D930606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeFGPUt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:20:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41256 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935034AbeFGO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:14 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbp-0005Zm-NK; Thu, 07 Jun 2018 15:09:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002rA-BR; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Biggers" <ebiggers@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.562731195@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 123/410] crypto: hash - annotate algorithms taking
 optional key
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
[bwh: Backported to 3.16:
 - Drop changes to nonexistent drivers
 - There's no CRYPTO_ALG_INTERNAL flag
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/sparc/crypto/crc32c_glue.c
+++ b/arch/sparc/crypto/crc32c_glue.c
@@ -133,6 +133,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-sparc64",
 		.cra_priority		=	SPARC_CR_OPCODE_PRIORITY,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_alignmask		=	7,
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -162,6 +162,7 @@ static struct shash_alg alg = {
 			.cra_name		= "crc32",
 			.cra_driver_name	= "crc32-pclmul",
 			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 			.cra_ctxsize		= sizeof(u32),
 			.cra_module		= THIS_MODULE,
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -240,6 +240,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-intel",
 		.cra_priority		=	200,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_module		=	THIS_MODULE,
--- a/crypto/crc32.c
+++ b/crypto/crc32.c
@@ -133,6 +133,7 @@ static struct shash_alg alg = {
 		.cra_name		= "crc32",
 		.cra_driver_name	= "crc32-table",
 		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/crypto/crc32c_generic.c
+++ b/crypto/crc32c_generic.c
@@ -146,6 +146,7 @@ static struct shash_alg alg = {
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
--- a/drivers/crypto/bfin_crc.c
+++ b/drivers/crypto/bfin_crc.c
@@ -514,7 +514,8 @@ static struct ahash_alg algs = {
 		.cra_driver_name	= DRIVER_NAME,
 		.cra_priority		= 100,
 		.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
-						CRYPTO_ALG_ASYNC,
+						CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct bfin_crypto_crc_ctx),
 		.cra_alignmask		= 3,
--- a/drivers/staging/lustre/lustre/libcfs/linux/linux-crypto-adler.c
+++ b/drivers/staging/lustre/lustre/libcfs/linux/linux-crypto-adler.c
@@ -123,6 +123,7 @@ static struct shash_alg alg = {
 		.cra_name		= "adler32",
 		.cra_driver_name	= "adler32-zlib",
 		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -95,6 +95,12 @@
 #define CRYPTO_ALG_KERN_DRIVER_ONLY	0x00001000
 
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

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226uJ1AYZVutZqZhsiULgZWVbi3So0oz7ABJhYjHyTwjWDBoVnH2/4sCPfWgVvB+ojKrjiDN
ARC-Seal: i=1; a=rsa-sha256; t=1518708895; cv=none;
        d=google.com; s=arc-20160816;
        b=FbEeTUmJGcjHqveJT/LINcJ7M/nRHaUjPcQh1zimbrVUhBWR6vAeR24fshpIcZCqbl
         mRG7CWtDKuL72nSfpw5CkOGAn66RvSkmYy522tlgz9J1XoNTxn/JEGQTHVBkHjzAQLYd
         lwGSESa39L6pPrJ3E3GD//UZlADwaWLgLXEzjU9nJMmma8T9qyBWR780U4Imnid2eWrT
         MCM51RQeH7brY1okhWycx/yDS7F5+yP/RsvyoyYXTGv8cm/AT5AwmqnXAm5v+YDPuvUE
         h5yGLGSJrerGBGeeUZZWojaEqdHGuGL8HzPI3BtYv2/MydowIg3mEDX+2gPbGJs+7FB9
         rDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vc3wngX793LyYsc4XIubSnBeaPdra2sc9FL/k/bIkHo=;
        b=mhFOfJGgFbYyupmphv0nDACvqa992epAYo6Yr884wXZvaOxKAcAdUMvcMKfDCs5sv6
         jmXkjhi2rQrMHJCt705+OcZDrRpn9MX2/MaVX0vWiVWljq/1FAutRvhOI/iCQsHJFXdD
         uLcPBCYx1eR8OG689qqc2ssZnOCnQ/c/WtHABa7ikLoQtwLuze5dcKKzHQBD+xUasYjs
         Omt9PbPkbD/G580vqUAs94ly3Jsn5jYcdS6rmLwXzB3CvsdXibBG3oE6uY8JwV5EnN4q
         rNgtZuphbOtB0LjpvcU6lc1lelhkd5tZvvfPP6kqSjD8XCSq96Dcm6pBmcj83U1VMk64
         lkxQ==
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
Subject: [PATCH 4.14 118/195] crypto: hash - annotate algorithms taking optional key
Date: Thu, 15 Feb 2018 16:16:49 +0100
Message-Id: <20180215151711.584673444@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481698724229299?=
X-GMAIL-MSGID: =?utf-8?q?1592481698724229299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/crypto/crc32-ce-glue.c                               |    2 ++
 arch/arm64/crypto/crc32-ce-glue.c                             |    2 ++
 arch/powerpc/crypto/crc32c-vpmsum_glue.c                      |    1 +
 arch/s390/crypto/crc32-vx.c                                   |    3 +++
 arch/sparc/crypto/crc32c_glue.c                               |    1 +
 arch/x86/crypto/crc32-pclmul_glue.c                           |    1 +
 arch/x86/crypto/crc32c-intel_glue.c                           |    1 +
 crypto/crc32_generic.c                                        |    1 +
 crypto/crc32c_generic.c                                       |    1 +
 crypto/cryptd.c                                               |    7 +++----
 crypto/mcryptd.c                                              |    7 +++----
 drivers/crypto/bfin_crc.c                                     |    3 ++-
 drivers/crypto/stm32/stm32_crc32.c                            |    2 ++
 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c |    1 +
 include/linux/crypto.h                                        |    6 ++++++
 15 files changed, 30 insertions(+), 9 deletions(-)

--- a/arch/arm/crypto/crc32-ce-glue.c
+++ b/arch/arm/crypto/crc32-ce-glue.c
@@ -188,6 +188,7 @@ static struct shash_alg crc32_pmull_algs
 	.base.cra_name		= "crc32",
 	.base.cra_driver_name	= "crc32-arm-ce",
 	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= 1,
 	.base.cra_module	= THIS_MODULE,
 }, {
@@ -203,6 +204,7 @@ static struct shash_alg crc32_pmull_algs
 	.base.cra_name		= "crc32c",
 	.base.cra_driver_name	= "crc32c-arm-ce",
 	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= 1,
 	.base.cra_module	= THIS_MODULE,
 } };
--- a/arch/arm64/crypto/crc32-ce-glue.c
+++ b/arch/arm64/crypto/crc32-ce-glue.c
@@ -185,6 +185,7 @@ static struct shash_alg crc32_pmull_algs
 	.base.cra_name		= "crc32",
 	.base.cra_driver_name	= "crc32-arm64-ce",
 	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= 1,
 	.base.cra_module	= THIS_MODULE,
 }, {
@@ -200,6 +201,7 @@ static struct shash_alg crc32_pmull_algs
 	.base.cra_name		= "crc32c",
 	.base.cra_driver_name	= "crc32c-arm64-ce",
 	.base.cra_priority	= 200,
+	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= 1,
 	.base.cra_module	= THIS_MODULE,
 } };
--- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
@@ -141,6 +141,7 @@ static struct shash_alg alg = {
 		.cra_name		= "crc32c",
 		.cra_driver_name	= "crc32c-vpmsum",
 		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -238,6 +238,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32",
 			.cra_driver_name = "crc32-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
@@ -258,6 +259,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32be",
 			.cra_driver_name = "crc32be-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
@@ -278,6 +280,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32c",
 			.cra_driver_name = "crc32c-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
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
@@ -226,6 +226,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-intel",
 		.cra_priority		=	200,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_module		=	THIS_MODULE,
--- a/crypto/crc32_generic.c
+++ b/crypto/crc32_generic.c
@@ -133,6 +133,7 @@ static struct shash_alg alg = {
 		.cra_name		= "crc32",
 		.cra_driver_name	= "crc32-generic",
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
@@ -895,10 +895,9 @@ static int cryptd_create_hash(struct cry
 	if (err)
 		goto out_free_inst;
 
-	type = CRYPTO_ALG_ASYNC;
-	if (alg->cra_flags & CRYPTO_ALG_INTERNAL)
-		type |= CRYPTO_ALG_INTERNAL;
-	inst->alg.halg.base.cra_flags = type;
+	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & (CRYPTO_ALG_INTERNAL |
+				   CRYPTO_ALG_OPTIONAL_KEY));
 
 	inst->alg.halg.digestsize = salg->digestsize;
 	inst->alg.halg.statesize = salg->statesize;
--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -517,10 +517,9 @@ static int mcryptd_create_hash(struct cr
 	if (err)
 		goto out_free_inst;
 
-	type = CRYPTO_ALG_ASYNC;
-	if (alg->cra_flags & CRYPTO_ALG_INTERNAL)
-		type |= CRYPTO_ALG_INTERNAL;
-	inst->alg.halg.base.cra_flags = type;
+	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & (CRYPTO_ALG_INTERNAL |
+				   CRYPTO_ALG_OPTIONAL_KEY));
 
 	inst->alg.halg.digestsize = halg->digestsize;
 	inst->alg.halg.statesize = halg->statesize;
--- a/drivers/crypto/bfin_crc.c
+++ b/drivers/crypto/bfin_crc.c
@@ -494,7 +494,8 @@ static struct ahash_alg algs = {
 		.cra_driver_name	= DRIVER_NAME,
 		.cra_priority		= 100,
 		.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
-						CRYPTO_ALG_ASYNC,
+						CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct bfin_crypto_crc_ctx),
 		.cra_alignmask		= 3,
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -208,6 +208,7 @@ static struct shash_alg algs[] = {
 			.cra_name               = "crc32",
 			.cra_driver_name        = DRIVER_NAME,
 			.cra_priority           = 200,
+			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize          = CHKSUM_BLOCK_SIZE,
 			.cra_alignmask          = 3,
 			.cra_ctxsize            = sizeof(struct stm32_crc_ctx),
@@ -229,6 +230,7 @@ static struct shash_alg algs[] = {
 			.cra_name               = "crc32c",
 			.cra_driver_name        = DRIVER_NAME,
 			.cra_priority           = 200,
+			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize          = CHKSUM_BLOCK_SIZE,
 			.cra_alignmask          = 3,
 			.cra_ctxsize            = sizeof(struct stm32_crc_ctx),
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c
@@ -119,6 +119,7 @@ static struct shash_alg alg = {
 		.cra_name		= "adler32",
 		.cra_driver_name	= "adler32-zlib",
 		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -106,6 +106,12 @@
 #define CRYPTO_ALG_INTERNAL		0x00002000
 
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

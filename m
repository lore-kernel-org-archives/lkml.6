Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeBSOv4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:51:56 -0500
Received: from foss.arm.com ([217.140.101.70]:60210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752492AbeBSOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:51:51 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: ccree: add support for older HW revs
Date: Mon, 19 Feb 2018 14:51:23 +0000
Message-Id: <1519051887-4668-4-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
References: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the legacy CryptoCell 630 and 710 revs.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/Kconfig                  |   6 +-
 drivers/crypto/ccree/cc_aead.c          |  34 ++++++--
 drivers/crypto/ccree/cc_cipher.c        |  25 +++++-
 drivers/crypto/ccree/cc_crypto_ctx.h    |  16 ----
 drivers/crypto/ccree/cc_driver.c        |  68 ++++++++++++---
 drivers/crypto/ccree/cc_driver.h        |  23 ++++-
 drivers/crypto/ccree/cc_fips.c          |  13 ++-
 drivers/crypto/ccree/cc_hash.c          | 149 ++++++++++++++++----------------
 drivers/crypto/ccree/cc_hash.h          |  12 +--
 drivers/crypto/ccree/cc_host_regs.h     |   3 +
 drivers/crypto/ccree/cc_hw_queue_defs.h |   2 +-
 drivers/crypto/ccree/cc_kernel_regs.h   |   1 +
 drivers/crypto/ccree/cc_request_mgr.c   |   6 +-
 drivers/crypto/ccree/cc_sram_mgr.c      |  14 +++
 14 files changed, 237 insertions(+), 135 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b26e5d2..5c41069 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -750,9 +750,9 @@ config CRYPTO_DEV_CCREE
 	select CRYPTO_CTR
 	select CRYPTO_XTS
 	help
-	  Say 'Y' to enable a driver for the Arm TrustZone CryptoCell
-	  family of processors. Currently only the CryptoCell 712 REE
-	  is supported.
+	  Say 'Y' to enable a driver for the REE interface of the Arm
+	  TrustZone CryptoCell family of processors. Currently the
+	  CryptoCell 712, 710 and 630 are supported.
 	  Choose this if you wish to use hardware acceleration of
 	  cryptographic operations on the system REE.
 	  If unsure say Y.
diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 3e1046a..03f4b9f 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -327,7 +327,7 @@ static int hmac_setkey(struct cc_hw_desc *desc, struct cc_aead_ctx *ctx)
 		/* Load the hash current length*/
 		hw_desc_init(&desc[idx]);
 		set_cipher_mode(&desc[idx], hash_mode);
-		set_din_const(&desc[idx], 0, HASH_LEN_SIZE);
+		set_din_const(&desc[idx], 0, ctx->drvdata->hash_len_sz);
 		set_flow_mode(&desc[idx], S_DIN_to_HASH);
 		set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
 		idx++;
@@ -465,7 +465,7 @@ static int cc_get_plain_hmac_key(struct crypto_aead *tfm, const u8 *key,
 			/* Load the hash current length*/
 			hw_desc_init(&desc[idx]);
 			set_cipher_mode(&desc[idx], hashmode);
-			set_din_const(&desc[idx], 0, HASH_LEN_SIZE);
+			set_din_const(&desc[idx], 0, ctx->drvdata->hash_len_sz);
 			set_cipher_config1(&desc[idx], HASH_PADDING_ENABLED);
 			set_flow_mode(&desc[idx], S_DIN_to_HASH);
 			set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
@@ -877,7 +877,7 @@ static void cc_proc_digest_desc(struct aead_request *req,
 		set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 		set_dout_dlli(&desc[idx], req_ctx->icv_dma_addr, ctx->authsize,
 			      NS_BIT, 1);
-		set_queue_last_ind(&desc[idx]);
+		set_queue_last_ind(ctx->drvdata, &desc[idx]);
 		if (ctx->auth_mode == DRV_HASH_XCBC_MAC) {
 			set_aes_not_hash_mode(&desc[idx]);
 			set_cipher_mode(&desc[idx], DRV_CIPHER_XCBC_MAC);
@@ -893,7 +893,7 @@ static void cc_proc_digest_desc(struct aead_request *req,
 		set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 		set_dout_dlli(&desc[idx], req_ctx->mac_buf_dma_addr,
 			      ctx->authsize, NS_BIT, 1);
-		set_queue_last_ind(&desc[idx]);
+		set_queue_last_ind(ctx->drvdata, &desc[idx]);
 		set_cipher_config0(&desc[idx],
 				   HASH_DIGEST_RESULT_LITTLE_ENDIAN);
 		set_cipher_config1(&desc[idx], HASH_PADDING_DISABLED);
@@ -1001,7 +1001,7 @@ static void cc_set_hmac_desc(struct aead_request *req, struct cc_hw_desc desc[],
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], hash_mode);
 	set_din_sram(&desc[idx], cc_digest_len_addr(ctx->drvdata, hash_mode),
-		     HASH_LEN_SIZE);
+		     ctx->drvdata->hash_len_sz);
 	set_flow_mode(&desc[idx], S_DIN_to_HASH);
 	set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
 	idx++;
@@ -1098,7 +1098,7 @@ static void cc_proc_scheme_desc(struct aead_request *req,
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], hash_mode);
 	set_dout_sram(&desc[idx], aead_handle->sram_workspace_addr,
-		      HASH_LEN_SIZE);
+		      ctx->drvdata->hash_len_sz);
 	set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE1);
 	set_cipher_do(&desc[idx], DO_PAD);
@@ -1128,7 +1128,7 @@ static void cc_proc_scheme_desc(struct aead_request *req,
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], hash_mode);
 	set_din_sram(&desc[idx], cc_digest_len_addr(ctx->drvdata, hash_mode),
-		     HASH_LEN_SIZE);
+		     ctx->drvdata->hash_len_sz);
 	set_cipher_config1(&desc[idx], HASH_PADDING_ENABLED);
 	set_flow_mode(&desc[idx], S_DIN_to_HASH);
 	set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
@@ -1509,7 +1509,7 @@ static int cc_ccm(struct aead_request *req, struct cc_hw_desc desc[],
 	set_din_type(&desc[idx], DMA_DLLI, req_ctx->mac_buf_dma_addr,
 		     ctx->authsize, NS_BIT);
 	set_dout_dlli(&desc[idx], mac_result, ctx->authsize, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], DIN_AES_DOUT);
 	idx++;
 
@@ -1772,7 +1772,7 @@ static void cc_proc_gcm_result(struct aead_request *req,
 	set_din_type(&desc[idx], DMA_DLLI, req_ctx->mac_buf_dma_addr,
 		     AES_BLOCK_SIZE, NS_BIT);
 	set_dout_dlli(&desc[idx], mac_result, ctx->authsize, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], DIN_AES_DOUT);
 	idx++;
 
@@ -2358,6 +2358,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_SHA1,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(hmac(sha1),cbc(des3_ede))",
@@ -2377,6 +2378,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_DES,
 		.auth_mode = DRV_HASH_SHA1,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(hmac(sha256),cbc(aes))",
@@ -2396,6 +2398,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_SHA256,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(hmac(sha256),cbc(des3_ede))",
@@ -2415,6 +2418,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_DES,
 		.auth_mode = DRV_HASH_SHA256,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(xcbc(aes),cbc(aes))",
@@ -2434,6 +2438,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_XCBC_MAC,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(hmac(sha1),rfc3686(ctr(aes)))",
@@ -2453,6 +2458,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_SHA1,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(hmac(sha256),rfc3686(ctr(aes)))",
@@ -2472,6 +2478,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_SHA256,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "authenc(xcbc(aes),rfc3686(ctr(aes)))",
@@ -2491,6 +2498,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_XCBC_MAC,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "ccm(aes)",
@@ -2510,6 +2518,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CCM,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_NULL,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "rfc4309(ccm(aes))",
@@ -2529,6 +2538,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_CCM,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_NULL,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "gcm(aes)",
@@ -2548,6 +2558,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_GCTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_NULL,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "rfc4106(gcm(aes))",
@@ -2567,6 +2578,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_GCTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_NULL,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "rfc4543(gcm(aes))",
@@ -2586,6 +2598,7 @@ static struct cc_alg_template aead_algs[] = {
 		.cipher_mode = DRV_CIPHER_GCTR,
 		.flow_mode = S_DIN_to_AES,
 		.auth_mode = DRV_HASH_NULL,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 };
 
@@ -2671,6 +2684,9 @@ int cc_aead_alloc(struct cc_drvdata *drvdata)
 
 	/* Linux crypto */
 	for (alg = 0; alg < ARRAY_SIZE(aead_algs); alg++) {
+		if (aead_algs[alg].min_hw_rev > drvdata->hw_rev)
+			continue;
+
 		t_alg = cc_create_aead_alg(&aead_algs[alg], dev);
 		if (IS_ERR(t_alg)) {
 			rc = PTR_ERR(t_alg);
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 5760ca9..0405755 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -502,7 +502,7 @@ static void cc_setup_cipher_data(struct crypto_tfm *tfm,
 		set_dout_dlli(&desc[*seq_size], sg_dma_address(dst),
 			      nbytes, NS_BIT, (!areq ? 0 : 1));
 		if (areq)
-			set_queue_last_ind(&desc[*seq_size]);
+			set_queue_last_ind(ctx_p->drvdata, &desc[*seq_size]);
 
 		set_flow_mode(&desc[*seq_size], flow_mode);
 		(*seq_size)++;
@@ -547,7 +547,7 @@ static void cc_setup_cipher_data(struct crypto_tfm *tfm,
 				      (!areq ? 0 : 1));
 		}
 		if (areq)
-			set_queue_last_ind(&desc[*seq_size]);
+			set_queue_last_ind(ctx_p->drvdata, &desc[*seq_size]);
 
 		set_flow_mode(&desc[*seq_size], flow_mode);
 		(*seq_size)++;
@@ -749,6 +749,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_XTS,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "xts512(aes)",
@@ -765,6 +766,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_XTS,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 512,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "xts4096(aes)",
@@ -781,6 +783,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_XTS,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 4096,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "essiv(aes)",
@@ -796,6 +799,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_ESSIV,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "essiv512(aes)",
@@ -812,6 +816,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_ESSIV,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 512,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "essiv4096(aes)",
@@ -828,6 +833,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_ESSIV,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 4096,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "bitlocker(aes)",
@@ -843,6 +849,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_BITLOCKER,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "bitlocker512(aes)",
@@ -859,6 +866,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_BITLOCKER,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 512,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "bitlocker4096(aes)",
@@ -875,6 +883,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.cipher_mode = DRV_CIPHER_BITLOCKER,
 		.flow_mode = S_DIN_to_AES,
 		.data_unit = 4096,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "ecb(aes)",
@@ -891,6 +900,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_ECB,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "cbc(aes)",
@@ -907,6 +917,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 		},
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "ofb(aes)",
@@ -923,6 +934,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_OFB,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "cts1(cbc(aes))",
@@ -939,6 +951,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_CBC_CTS,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "ctr(aes)",
@@ -955,6 +968,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_CTR,
 		.flow_mode = S_DIN_to_AES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "cbc(des3_ede)",
@@ -971,6 +985,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_DES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "ecb(des3_ede)",
@@ -987,6 +1002,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_ECB,
 		.flow_mode = S_DIN_to_DES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "cbc(des)",
@@ -1003,6 +1019,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_CBC,
 		.flow_mode = S_DIN_to_DES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "ecb(des)",
@@ -1019,6 +1036,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 			},
 		.cipher_mode = DRV_CIPHER_ECB,
 		.flow_mode = S_DIN_to_DES,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 };
 
@@ -1095,6 +1113,9 @@ int cc_cipher_alloc(struct cc_drvdata *drvdata)
 	dev_dbg(dev, "Number of algorithms = %zu\n",
 		ARRAY_SIZE(skcipher_algs));
 	for (alg = 0; alg < ARRAY_SIZE(skcipher_algs); alg++) {
+		if (skcipher_algs[alg].min_hw_rev > drvdata->hw_rev)
+			continue;
+
 		dev_dbg(dev, "creating %s\n", skcipher_algs[alg].driver_name);
 		t_alg = cc_create_alg(&skcipher_algs[alg], dev);
 		if (IS_ERR(t_alg)) {
diff --git a/drivers/crypto/ccree/cc_crypto_ctx.h b/drivers/crypto/ccree/cc_crypto_ctx.h
index 06a7860..e032544 100644
--- a/drivers/crypto/ccree/cc_crypto_ctx.h
+++ b/drivers/crypto/ccree/cc_crypto_ctx.h
@@ -6,17 +6,6 @@
 
 #include <linux/types.h>
 
-/* context size */
-#ifndef CC_CTX_SIZE_LOG2
-#if (CC_DEV_SHA_MAX > 256)
-#define CC_CTX_SIZE_LOG2 8
-#else
-#define CC_CTX_SIZE_LOG2 7
-#endif
-#endif
-#define CC_CTX_SIZE BIT(CC_CTX_SIZE_LOG2)
-#define CC_DRV_CTX_SIZE_WORDS (CC_CTX_SIZE >> 2)
-
 #define CC_DRV_DES_IV_SIZE 8
 #define CC_DRV_DES_BLOCK_SIZE 8
 
@@ -59,13 +48,8 @@
 #define CC_SHA384_BLOCK_SIZE 128
 #define CC_SHA512_BLOCK_SIZE 128
 
-#if (CC_DEV_SHA_MAX > 256)
 #define CC_DIGEST_SIZE_MAX CC_SHA512_DIGEST_SIZE
 #define CC_HASH_BLOCK_SIZE_MAX CC_SHA512_BLOCK_SIZE /*1024b*/
-#else /* Only up to SHA256 */
-#define CC_DIGEST_SIZE_MAX CC_SHA256_DIGEST_SIZE
-#define CC_HASH_BLOCK_SIZE_MAX CC_SHA256_BLOCK_SIZE /*512b*/
-#endif
 
 #define CC_HMAC_BLOCK_SIZE_MAX CC_HASH_BLOCK_SIZE_MAX
 
diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 827e329..89ce013 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -35,6 +35,34 @@ bool cc_dump_bytes;
 module_param_named(dump_bytes, cc_dump_bytes, bool, 0600);
 MODULE_PARM_DESC(cc_dump_bytes, "Dump buffers to kernel log as debugging aid");
 
+struct cc_hw_data {
+	char *name;
+	enum cc_hw_rev rev;
+	u32 sig;
+};
+
+/* Hardware revisions defs. */
+
+static const struct cc_hw_data cc712_hw = {
+	.name = "712", .rev = CC_HW_REV_712, .sig =  0xDCC71200U
+};
+
+static const struct cc_hw_data cc710_hw = {
+	.name = "710", .rev = CC_HW_REV_710, .sig =  0xDCC63200U
+};
+
+static const struct cc_hw_data cc630p_hw = {
+	.name = "630P", .rev = CC_HW_REV_630, .sig = 0xDCC63000U
+};
+
+static const struct of_device_id arm_ccree_dev_of_match[] = {
+	{ .compatible = "arm,cryptocell-712-ree", .data = &cc712_hw },
+	{ .compatible = "arm,cryptocell-710-ree", .data = &cc710_hw },
+	{ .compatible = "arm,cryptocell-630p-ree", .data = &cc630p_hw },
+	{}
+};
+MODULE_DEVICE_TABLE(of, arm_ccree_dev_of_match);
+
 void __dump_byte_array(const char *name, const u8 *buf, size_t len)
 {
 	char prefix[64];
@@ -128,9 +156,12 @@ int init_cc_regs(struct cc_drvdata *drvdata, bool is_probe)
 	cc_iowrite(drvdata, CC_REG(HOST_ICR), val);
 
 	/* Unmask relevant interrupt cause */
-	val = (unsigned int)(~(CC_COMP_IRQ_MASK | CC_AXI_ERR_IRQ_MASK |
-			       CC_GPR0_IRQ_MASK));
-	cc_iowrite(drvdata, CC_REG(HOST_IMR), val);
+	val = CC_COMP_IRQ_MASK | CC_AXI_ERR_IRQ_MASK;
+
+	if (drvdata->hw_rev >= CC_HW_REV_712)
+		val |= CC_GPR0_IRQ_MASK;
+
+	cc_iowrite(drvdata, CC_REG(HOST_IMR), ~val);
 
 	cache_params = (drvdata->coherent ? CC_COHERENT_CACHE_PARAMS : 0x0);
 
@@ -157,12 +188,30 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	struct device_node *np = dev->of_node;
 	u32 signature_val;
 	u64 dma_mask;
+	const struct cc_hw_data *hw_rev;
+	const struct of_device_id *dev_id;
 	int rc = 0;
 
 	new_drvdata = devm_kzalloc(dev, sizeof(*new_drvdata), GFP_KERNEL);
 	if (!new_drvdata)
 		return -ENOMEM;
 
+	dev_id = of_match_node(arm_ccree_dev_of_match, np);
+	if (!dev_id)
+		return -ENODEV;
+
+	hw_rev = (struct cc_hw_data *)dev_id->data;
+	new_drvdata->hw_rev_name = hw_rev->name;
+	new_drvdata->hw_rev = hw_rev->rev;
+
+	if (hw_rev->rev >= CC_HW_REV_712) {
+		new_drvdata->hash_len_sz = HASH_LEN_SIZE_712;
+		new_drvdata->axim_mon_offset = CC_REG(AXIM_MON_COMP);
+	} else {
+		new_drvdata->hash_len_sz = HASH_LEN_SIZE_630;
+		new_drvdata->axim_mon_offset = CC_REG(AXIM_MON_COMP8);
+	}
+
 	platform_set_drvdata(plat_dev, new_drvdata);
 	new_drvdata->plat_dev = plat_dev;
 
@@ -228,9 +277,9 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	/* Verify correct mapping */
 	signature_val = cc_ioread(new_drvdata, CC_REG(HOST_SIGNATURE));
-	if (signature_val != CC_DEV_SIGNATURE) {
+	if (signature_val != hw_rev->sig) {
 		dev_err(dev, "Invalid CC signature: SIGNATURE=0x%08X != expected=0x%08X\n",
-			signature_val, (u32)CC_DEV_SIGNATURE);
+			signature_val, hw_rev->sig);
 		rc = -EINVAL;
 		goto post_clk_err;
 	}
@@ -238,8 +287,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	/* Display HW versions */
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X, Driver version %s\n",
-		 CC_DEV_NAME_STR,
-		 cc_ioread(new_drvdata, CC_REG(HOST_VERSION)),
+		 hw_rev->name, cc_ioread(new_drvdata, CC_REG(HOST_VERSION)),
 		 DRV_MODULE_VERSION);
 
 	rc = init_cc_regs(new_drvdata, true);
@@ -430,12 +478,6 @@ static int ccree_remove(struct platform_device *plat_dev)
 	return 0;
 }
 
-static const struct of_device_id arm_ccree_dev_of_match[] = {
-	{.compatible = "arm,cryptocell-712-ree"},
-	{}
-};
-MODULE_DEVICE_TABLE(of, arm_ccree_dev_of_match);
-
 static struct platform_driver ccree_driver = {
 	.driver = {
 		   .name = "ccree",
diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index 254a3cb..2048fde 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -36,16 +36,19 @@
 extern bool cc_dump_desc;
 extern bool cc_dump_bytes;
 
-#define DRV_MODULE_VERSION "3.0"
+#define DRV_MODULE_VERSION "4.0"
+
+enum cc_hw_rev {
+	CC_HW_REV_630 = 630,
+	CC_HW_REV_710 = 710,
+	CC_HW_REV_712 = 712
+};
 
-#define CC_DEV_NAME_STR "ccree"
 #define CC_COHERENT_CACHE_PARAMS 0xEEE
 
 /* Maximum DMA mask supported by IP */
 #define DMA_BIT_MASK_LEN 48
 
-#define CC_DEV_SIGNATURE 0xDCC71200UL
-
 #define CC_AXI_IRQ_MASK ((1 << CC_AXIM_CFG_BRESPMASK_BIT_SHIFT) | \
 			  (1 << CC_AXIM_CFG_RRESPMASK_BIT_SHIFT) | \
 			  (1 << CC_AXIM_CFG_INFLTMASK_BIT_SHIFT) | \
@@ -122,6 +125,10 @@ struct cc_drvdata {
 	void *debugfs;
 	struct clk *clk;
 	bool coherent;
+	char *hw_rev_name;
+	enum cc_hw_rev hw_rev;
+	u32 hash_len_sz;
+	u32 axim_mon_offset;
 };
 
 struct cc_crypto_alg {
@@ -147,6 +154,7 @@ struct cc_alg_template {
 	int cipher_mode;
 	int flow_mode; /* Note: currently, refers to the cipher mode only. */
 	int auth_mode;
+	u32 min_hw_rev;
 	unsigned int data_unit;
 	struct cc_drvdata *drvdata;
 };
@@ -190,4 +198,11 @@ static inline gfp_t cc_gfp_flags(struct crypto_async_request *req)
 			GFP_KERNEL : GFP_ATOMIC;
 }
 
+static inline void set_queue_last_ind(struct cc_drvdata *drvdata,
+				      struct cc_hw_desc *pdesc)
+{
+	if (drvdata->hw_rev >= CC_HW_REV_712)
+		set_queue_last_ind_bit(pdesc);
+}
+
 #endif /*__CC_DRIVER_H__*/
diff --git a/drivers/crypto/ccree/cc_fips.c b/drivers/crypto/ccree/cc_fips.c
index de08af9..b4d0a6d 100644
--- a/drivers/crypto/ccree/cc_fips.c
+++ b/drivers/crypto/ccree/cc_fips.c
@@ -32,6 +32,9 @@ void cc_set_ree_fips_status(struct cc_drvdata *drvdata, bool status)
 {
 	int val = CC_FIPS_SYNC_REE_STATUS;
 
+	if (drvdata->hw_rev < CC_HW_REV_712)
+		return;
+
 	val |= (status ? CC_FIPS_SYNC_MODULE_OK : CC_FIPS_SYNC_MODULE_ERROR);
 
 	cc_iowrite(drvdata, CC_REG(HOST_GPR0), val);
@@ -41,8 +44,8 @@ void cc_fips_fini(struct cc_drvdata *drvdata)
 {
 	struct cc_fips_handle *fips_h = drvdata->fips_handle;
 
-	if (!fips_h)
-		return; /* Not allocated */
+	if (drvdata->hw_rev < CC_HW_REV_712 || !fips_h)
+		return;
 
 	/* Kill tasklet */
 	tasklet_kill(&fips_h->tasklet);
@@ -55,6 +58,9 @@ void fips_handler(struct cc_drvdata *drvdata)
 {
 	struct cc_fips_handle *fips_handle_ptr = drvdata->fips_handle;
 
+	if (drvdata->hw_rev < CC_HW_REV_712)
+		return;
+
 	tasklet_schedule(&fips_handle_ptr->tasklet);
 }
 
@@ -95,6 +101,9 @@ int cc_fips_init(struct cc_drvdata *p_drvdata)
 	struct cc_fips_handle *fips_h;
 	struct device *dev = drvdata_to_dev(p_drvdata);
 
+	if (p_drvdata->hw_rev < CC_HW_REV_712)
+		return 0;
+
 	fips_h = kzalloc(sizeof(*fips_h), GFP_KERNEL);
 	if (!fips_h)
 		return -ENOMEM;
diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index 26bbbc6..96ff777 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -35,7 +35,6 @@ static const u32 sha224_init[] = {
 static const u32 sha256_init[] = {
 	SHA256_H7, SHA256_H6, SHA256_H5, SHA256_H4,
 	SHA256_H3, SHA256_H2, SHA256_H1, SHA256_H0 };
-#if (CC_DEV_SHA_MAX > 256)
 static const u32 digest_len_sha512_init[] = {
 	0x00000080, 0x00000000, 0x00000000, 0x00000000 };
 static u64 sha384_init[] = {
@@ -44,7 +43,6 @@ static u64 sha384_init[] = {
 static u64 sha512_init[] = {
 	SHA512_H7, SHA512_H6, SHA512_H5, SHA512_H4,
 	SHA512_H3, SHA512_H2, SHA512_H1, SHA512_H0 };
-#endif
 
 static void cc_setup_xcbc(struct ahash_request *areq, struct cc_hw_desc desc[],
 			  unsigned int *seq_size);
@@ -136,18 +134,14 @@ static void cc_init_req(struct device *dev, struct ahash_req_ctx *state,
 
 			memcpy(state->digest_buff, ctx->digest_buff,
 			       ctx->inter_digestsize);
-#if (CC_DEV_SHA_MAX > 256)
 			if (ctx->hash_mode == DRV_HASH_SHA512 ||
 			    ctx->hash_mode == DRV_HASH_SHA384)
 				memcpy(state->digest_bytes_len,
-				       digest_len_sha512_init, HASH_LEN_SIZE);
+				       digest_len_sha512_init,
+				       ctx->drvdata->hash_len_sz);
 			else
-				memcpy(state->digest_bytes_len,
-				       digest_len_init, HASH_LEN_SIZE);
-#else
-			memcpy(state->digest_bytes_len, digest_len_init,
-			       HASH_LEN_SIZE);
-#endif
+				memcpy(state->digest_bytes_len, digest_len_init,
+				       ctx->drvdata->hash_len_sz);
 		}
 
 		if (ctx->hash_mode != DRV_HASH_NULL) {
@@ -186,14 +180,14 @@ static int cc_map_req(struct device *dev, struct ahash_req_ctx *state,
 	if (ctx->hw_mode != DRV_CIPHER_XCBC_MAC) {
 		state->digest_bytes_len_dma_addr =
 			dma_map_single(dev, state->digest_bytes_len,
-				       HASH_LEN_SIZE, DMA_BIDIRECTIONAL);
+				       HASH_MAX_LEN_SIZE, DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(dev, state->digest_bytes_len_dma_addr)) {
 			dev_err(dev, "Mapping digest len %u B at va=%pK for DMA failed\n",
-				HASH_LEN_SIZE, state->digest_bytes_len);
+				HASH_MAX_LEN_SIZE, state->digest_bytes_len);
 			goto unmap_digest_buf;
 		}
 		dev_dbg(dev, "Mapped digest len %u B at va=%pK to dma=%pad\n",
-			HASH_LEN_SIZE, state->digest_bytes_len,
+			HASH_MAX_LEN_SIZE, state->digest_bytes_len,
 			&state->digest_bytes_len_dma_addr);
 	}
 
@@ -218,7 +212,7 @@ static int cc_map_req(struct device *dev, struct ahash_req_ctx *state,
 unmap_digest_len:
 	if (state->digest_bytes_len_dma_addr) {
 		dma_unmap_single(dev, state->digest_bytes_len_dma_addr,
-				 HASH_LEN_SIZE, DMA_BIDIRECTIONAL);
+				 HASH_MAX_LEN_SIZE, DMA_BIDIRECTIONAL);
 		state->digest_bytes_len_dma_addr = 0;
 	}
 unmap_digest_buf:
@@ -243,7 +237,7 @@ static void cc_unmap_req(struct device *dev, struct ahash_req_ctx *state,
 	}
 	if (state->digest_bytes_len_dma_addr) {
 		dma_unmap_single(dev, state->digest_bytes_len_dma_addr,
-				 HASH_LEN_SIZE, DMA_BIDIRECTIONAL);
+				 HASH_MAX_LEN_SIZE, DMA_BIDIRECTIONAL);
 		dev_dbg(dev, "Unmapped digest-bytes-len buffer: digest_bytes_len_dma_addr=%pad\n",
 			&state->digest_bytes_len_dma_addr);
 		state->digest_bytes_len_dma_addr = 0;
@@ -331,7 +325,7 @@ static int cc_fin_result(struct cc_hw_desc *desc, struct ahash_request *req,
 	/* TODO */
 	set_dout_dlli(&desc[idx], state->digest_result_dma_addr, digestsize,
 		      NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 	set_cipher_config1(&desc[idx], HASH_PADDING_DISABLED);
@@ -373,7 +367,7 @@ static int cc_fin_hmac(struct cc_hw_desc *desc, struct ahash_request *req,
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
 	set_din_sram(&desc[idx],
 		     cc_digest_len_addr(ctx->drvdata, ctx->hash_mode),
-		     HASH_LEN_SIZE);
+		     ctx->drvdata->hash_len_sz);
 	set_cipher_config1(&desc[idx], HASH_PADDING_ENABLED);
 	set_flow_mode(&desc[idx], S_DIN_to_HASH);
 	set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
@@ -464,10 +458,10 @@ static int cc_hash_digest(struct ahash_request *req)
 
 	if (is_hmac) {
 		set_din_type(&desc[idx], DMA_DLLI,
-			     state->digest_bytes_len_dma_addr, HASH_LEN_SIZE,
-			     NS_BIT);
+			     state->digest_bytes_len_dma_addr,
+			     ctx->drvdata->hash_len_sz, NS_BIT);
 	} else {
-		set_din_const(&desc[idx], 0, HASH_LEN_SIZE);
+		set_din_const(&desc[idx], 0, ctx->drvdata->hash_len_sz);
 		if (nbytes)
 			set_cipher_config1(&desc[idx], HASH_PADDING_ENABLED);
 		else
@@ -484,7 +478,7 @@ static int cc_hash_digest(struct ahash_request *req)
 		hw_desc_init(&desc[idx]);
 		set_cipher_mode(&desc[idx], ctx->hw_mode);
 		set_dout_dlli(&desc[idx], state->digest_buff_dma_addr,
-			      HASH_LEN_SIZE, NS_BIT, 0);
+			      ctx->drvdata->hash_len_sz, NS_BIT, 0);
 		set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 		set_setup_mode(&desc[idx], SETUP_WRITE_STATE1);
 		set_cipher_do(&desc[idx], DO_PAD);
@@ -522,7 +516,7 @@ static int cc_restore_hash(struct cc_hw_desc *desc, struct cc_hash_ctx *ctx,
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
 	set_cipher_config1(&desc[idx], HASH_PADDING_DISABLED);
 	set_din_type(&desc[idx], DMA_DLLI, state->digest_bytes_len_dma_addr,
-		     HASH_LEN_SIZE, NS_BIT);
+		     ctx->drvdata->hash_len_sz, NS_BIT);
 	set_flow_mode(&desc[idx], S_DIN_to_HASH);
 	set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
 	idx++;
@@ -593,8 +587,8 @@ static int cc_hash_update(struct ahash_request *req)
 	hw_desc_init(&desc[idx]);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
 	set_dout_dlli(&desc[idx], state->digest_bytes_len_dma_addr,
-		      HASH_LEN_SIZE, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+		      ctx->drvdata->hash_len_sz, NS_BIT, 1);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE1);
 	idx++;
@@ -717,7 +711,7 @@ static int cc_hash_final(struct ahash_request *req)
 	set_cipher_do(&desc[idx], DO_PAD);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
 	set_dout_dlli(&desc[idx], state->digest_bytes_len_dma_addr,
-		      HASH_LEN_SIZE, NS_BIT, 0);
+		      ctx->drvdata->hash_len_sz, NS_BIT, 0);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE1);
 	set_flow_mode(&desc[idx], S_HASH_to_DOUT);
 	idx++;
@@ -804,7 +798,7 @@ static int cc_hash_setkey(struct crypto_ahash *ahash, const u8 *key,
 			/* Load the hash current length*/
 			hw_desc_init(&desc[idx]);
 			set_cipher_mode(&desc[idx], ctx->hw_mode);
-			set_din_const(&desc[idx], 0, HASH_LEN_SIZE);
+			set_din_const(&desc[idx], 0, ctx->drvdata->hash_len_sz);
 			set_cipher_config1(&desc[idx], HASH_PADDING_ENABLED);
 			set_flow_mode(&desc[idx], S_DIN_to_HASH);
 			set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
@@ -886,7 +880,7 @@ static int cc_hash_setkey(struct crypto_ahash *ahash, const u8 *key,
 		/* Load the hash current length*/
 		hw_desc_init(&desc[idx]);
 		set_cipher_mode(&desc[idx], ctx->hw_mode);
-		set_din_const(&desc[idx], 0, HASH_LEN_SIZE);
+		set_din_const(&desc[idx], 0, ctx->drvdata->hash_len_sz);
 		set_flow_mode(&desc[idx], S_DIN_to_HASH);
 		set_setup_mode(&desc[idx], SETUP_LOAD_KEY0);
 		idx++;
@@ -1204,7 +1198,7 @@ static int cc_mac_update(struct ahash_request *req)
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
 	set_dout_dlli(&desc[idx], state->digest_buff_dma_addr,
 		      ctx->inter_digestsize, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_AES_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 	idx++;
@@ -1328,7 +1322,7 @@ static int cc_mac_final(struct ahash_request *req)
 	/* TODO */
 	set_dout_dlli(&desc[idx], state->digest_result_dma_addr,
 		      digestsize, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_AES_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
@@ -1410,7 +1404,7 @@ static int cc_mac_finup(struct ahash_request *req)
 	/* TODO */
 	set_dout_dlli(&desc[idx], state->digest_result_dma_addr,
 		      digestsize, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_AES_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 	set_cipher_mode(&desc[idx], ctx->hw_mode);
@@ -1488,7 +1482,7 @@ static int cc_mac_digest(struct ahash_request *req)
 	hw_desc_init(&desc[idx]);
 	set_dout_dlli(&desc[idx], state->digest_result_dma_addr,
 		      CC_AES_BLOCK_SIZE, NS_BIT, 1);
-	set_queue_last_ind(&desc[idx]);
+	set_queue_last_ind(ctx->drvdata, &desc[idx]);
 	set_flow_mode(&desc[idx], S_AES_to_DOUT);
 	set_setup_mode(&desc[idx], SETUP_WRITE_STATE0);
 	set_cipher_config0(&desc[idx], DESC_DIRECTION_ENCRYPT_ENCRYPT);
@@ -1520,8 +1514,8 @@ static int cc_hash_export(struct ahash_request *req, void *out)
 	memcpy(out, state->digest_buff, ctx->inter_digestsize);
 	out += ctx->inter_digestsize;
 
-	memcpy(out, state->digest_bytes_len, HASH_LEN_SIZE);
-	out += HASH_LEN_SIZE;
+	memcpy(out, state->digest_bytes_len, ctx->drvdata->hash_len_sz);
+	out += ctx->drvdata->hash_len_sz;
 
 	memcpy(out, &curr_buff_cnt, sizeof(u32));
 	out += sizeof(u32);
@@ -1549,8 +1543,8 @@ static int cc_hash_import(struct ahash_request *req, const void *in)
 	memcpy(state->digest_buff, in, ctx->inter_digestsize);
 	in += ctx->inter_digestsize;
 
-	memcpy(state->digest_bytes_len, in, HASH_LEN_SIZE);
-	in += HASH_LEN_SIZE;
+	memcpy(state->digest_bytes_len, in, ctx->drvdata->hash_len_sz);
+	in += ctx->drvdata->hash_len_sz;
 
 	/* Sanity check the data as much as possible */
 	memcpy(&tmp, in, sizeof(u32));
@@ -1576,10 +1570,11 @@ struct cc_hash_template {
 	int hw_mode;
 	int inter_digestsize;
 	struct cc_drvdata *drvdata;
+	u32 min_hw_rev;
 };
 
 #define CC_STATE_SIZE(_x) \
-	((_x) + HASH_LEN_SIZE + CC_MAX_HASH_BLCK_SIZE + (2 * sizeof(u32)))
+	((_x) + HASH_MAX_LEN_SIZE + CC_MAX_HASH_BLCK_SIZE + (2 * sizeof(u32)))
 
 /* hash descriptors */
 static struct cc_hash_template driver_hash[] = {
@@ -1608,6 +1603,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_SHA1,
 		.hw_mode = DRV_HASH_HW_SHA1,
 		.inter_digestsize = SHA1_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "sha256",
@@ -1632,6 +1628,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_SHA256,
 		.hw_mode = DRV_HASH_HW_SHA256,
 		.inter_digestsize = SHA256_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.name = "sha224",
@@ -1656,8 +1653,8 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_SHA224,
 		.hw_mode = DRV_HASH_HW_SHA256,
 		.inter_digestsize = SHA256_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
-#if (CC_DEV_SHA_MAX > 256)
 	{
 		.name = "sha384",
 		.driver_name = "sha384-ccree",
@@ -1681,6 +1678,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_SHA384,
 		.hw_mode = DRV_HASH_HW_SHA512,
 		.inter_digestsize = SHA512_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_712,
 	},
 	{
 		.name = "sha512",
@@ -1705,8 +1703,8 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_SHA512,
 		.hw_mode = DRV_HASH_HW_SHA512,
 		.inter_digestsize = SHA512_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_712,
 	},
-#endif
 	{
 		.name = "md5",
 		.driver_name = "md5-ccree",
@@ -1730,6 +1728,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_MD5,
 		.hw_mode = DRV_HASH_HW_MD5,
 		.inter_digestsize = MD5_DIGEST_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.mac_name = "xcbc(aes)",
@@ -1752,6 +1751,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_NULL,
 		.hw_mode = DRV_CIPHER_XCBC_MAC,
 		.inter_digestsize = AES_BLOCK_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 	{
 		.mac_name = "cmac(aes)",
@@ -1774,6 +1774,7 @@ static struct cc_hash_template driver_hash[] = {
 		.hash_mode = DRV_HASH_NULL,
 		.hw_mode = DRV_CIPHER_CMAC,
 		.inter_digestsize = AES_BLOCK_SIZE,
+		.min_hw_rev = CC_HW_REV_630,
 	},
 };
 
@@ -1829,6 +1830,7 @@ int cc_init_hash_sram(struct cc_drvdata *drvdata)
 	cc_sram_addr_t sram_buff_ofs = hash_handle->digest_len_sram_addr;
 	unsigned int larval_seq_len = 0;
 	struct cc_hw_desc larval_seq[CC_DIGEST_SIZE_MAX / sizeof(u32)];
+	bool large_sha_supported = (drvdata->hw_rev >= CC_HW_REV_712);
 	int rc = 0;
 
 	/* Copy-to-sram digest-len */
@@ -1842,18 +1844,18 @@ int cc_init_hash_sram(struct cc_drvdata *drvdata)
 	sram_buff_ofs += sizeof(digest_len_init);
 	larval_seq_len = 0;
 
-#if (CC_DEV_SHA_MAX > 256)
-	/* Copy-to-sram digest-len for sha384/512 */
-	cc_set_sram_desc(digest_len_sha512_init, sram_buff_ofs,
-			 ARRAY_SIZE(digest_len_sha512_init),
-			 larval_seq, &larval_seq_len);
-	rc = send_request_init(drvdata, larval_seq, larval_seq_len);
-	if (rc)
-		goto init_digest_const_err;
+	if (large_sha_supported) {
+		/* Copy-to-sram digest-len for sha384/512 */
+		cc_set_sram_desc(digest_len_sha512_init, sram_buff_ofs,
+				 ARRAY_SIZE(digest_len_sha512_init),
+				 larval_seq, &larval_seq_len);
+		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
+		if (rc)
+			goto init_digest_const_err;
 
-	sram_buff_ofs += sizeof(digest_len_sha512_init);
-	larval_seq_len = 0;
-#endif
+		sram_buff_ofs += sizeof(digest_len_sha512_init);
+		larval_seq_len = 0;
+	}
 
 	/* The initial digests offset */
 	hash_handle->larval_digest_sram_addr = sram_buff_ofs;
@@ -1894,23 +1896,23 @@ int cc_init_hash_sram(struct cc_drvdata *drvdata)
 	sram_buff_ofs += sizeof(sha256_init);
 	larval_seq_len = 0;
 
-#if (CC_DEV_SHA_MAX > 256)
-	cc_set_sram_desc((u32 *)sha384_init, sram_buff_ofs,
-			 (ARRAY_SIZE(sha384_init) * 2), larval_seq,
-			 &larval_seq_len);
-	rc = send_request_init(drvdata, larval_seq, larval_seq_len);
-	if (rc)
-		goto init_digest_const_err;
-	sram_buff_ofs += sizeof(sha384_init);
-	larval_seq_len = 0;
+	if (large_sha_supported) {
+		cc_set_sram_desc((u32 *)sha384_init, sram_buff_ofs,
+				 (ARRAY_SIZE(sha384_init) * 2), larval_seq,
+				 &larval_seq_len);
+		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
+		if (rc)
+			goto init_digest_const_err;
+		sram_buff_ofs += sizeof(sha384_init);
+		larval_seq_len = 0;
 
-	cc_set_sram_desc((u32 *)sha512_init, sram_buff_ofs,
-			 (ARRAY_SIZE(sha512_init) * 2), larval_seq,
-			 &larval_seq_len);
-	rc = send_request_init(drvdata, larval_seq, larval_seq_len);
-	if (rc)
-		goto init_digest_const_err;
-#endif
+		cc_set_sram_desc((u32 *)sha512_init, sram_buff_ofs,
+				 (ARRAY_SIZE(sha512_init) * 2), larval_seq,
+				 &larval_seq_len);
+		rc = send_request_init(drvdata, larval_seq, larval_seq_len);
+		if (rc)
+			goto init_digest_const_err;
+	}
 
 init_digest_const_err:
 	return rc;
@@ -1955,16 +1957,15 @@ int cc_hash_alloc(struct cc_drvdata *drvdata)
 	drvdata->hash_handle = hash_handle;
 
 	sram_size_to_alloc = sizeof(digest_len_init) +
-#if (CC_DEV_SHA_MAX > 256)
-			sizeof(digest_len_sha512_init) +
-			sizeof(sha384_init) +
-			sizeof(sha512_init) +
-#endif
 			sizeof(md5_init) +
 			sizeof(sha1_init) +
 			sizeof(sha224_init) +
 			sizeof(sha256_init);
 
+	if (drvdata->hw_rev >= CC_HW_REV_712)
+		sram_size_to_alloc += sizeof(digest_len_sha512_init) +
+			sizeof(sha384_init) + sizeof(sha512_init);
+
 	sram_buff = cc_sram_alloc(drvdata, sram_size_to_alloc);
 	if (sram_buff == NULL_SRAM_ADDR) {
 		dev_err(dev, "SRAM pool exhausted\n");
@@ -1987,6 +1988,10 @@ int cc_hash_alloc(struct cc_drvdata *drvdata)
 		struct cc_hash_alg *t_alg;
 		int hw_mode = driver_hash[alg].hw_mode;
 
+		/* We either support both HASH and MAC or none */
+		if (driver_hash[alg].min_hw_rev > drvdata->hw_rev)
+			continue;
+
 		/* register hmac version */
 		t_alg = cc_alloc_hash_alg(&driver_hash[alg], dev, true);
 		if (IS_ERR(t_alg)) {
@@ -2204,12 +2209,10 @@ static const void *cc_larval_digest(struct device *dev, u32 mode)
 		return sha224_init;
 	case DRV_HASH_SHA256:
 		return sha256_init;
-#if (CC_DEV_SHA_MAX > 256)
 	case DRV_HASH_SHA384:
 		return sha384_init;
 	case DRV_HASH_SHA512:
 		return sha512_init;
-#endif
 	default:
 		dev_err(dev, "Invalid hash mode (%d)\n", mode);
 		return md5_init;
@@ -2248,7 +2251,6 @@ cc_sram_addr_t cc_larval_digest_addr(void *drvdata, u32 mode)
 			sizeof(md5_init) +
 			sizeof(sha1_init) +
 			sizeof(sha224_init));
-#if (CC_DEV_SHA_MAX > 256)
 	case DRV_HASH_SHA384:
 		return (hash_handle->larval_digest_sram_addr +
 			sizeof(md5_init) +
@@ -2262,7 +2264,6 @@ cc_sram_addr_t cc_larval_digest_addr(void *drvdata, u32 mode)
 			sizeof(sha224_init) +
 			sizeof(sha256_init) +
 			sizeof(sha384_init));
-#endif
 	default:
 		dev_err(dev, "Invalid hash mode (%d)\n", mode);
 	}
diff --git a/drivers/crypto/ccree/cc_hash.h b/drivers/crypto/ccree/cc_hash.h
index a444710..2e5bf8b 100644
--- a/drivers/crypto/ccree/cc_hash.h
+++ b/drivers/crypto/ccree/cc_hash.h
@@ -12,15 +12,11 @@
 
 #define HMAC_IPAD_CONST	0x36363636
 #define HMAC_OPAD_CONST	0x5C5C5C5C
-#if (CC_DEV_SHA_MAX > 256)
-#define HASH_LEN_SIZE 16
+#define HASH_LEN_SIZE_712 16
+#define HASH_LEN_SIZE_630 8
+#define HASH_MAX_LEN_SIZE HASH_LEN_SIZE_712
 #define CC_MAX_HASH_DIGEST_SIZE	SHA512_DIGEST_SIZE
 #define CC_MAX_HASH_BLCK_SIZE SHA512_BLOCK_SIZE
-#else
-#define HASH_LEN_SIZE 8
-#define CC_MAX_HASH_DIGEST_SIZE	SHA256_DIGEST_SIZE
-#define CC_MAX_HASH_BLCK_SIZE SHA256_BLOCK_SIZE
-#endif
 
 #define XCBC_MAC_K1_OFFSET 0
 #define XCBC_MAC_K2_OFFSET 16
@@ -43,7 +39,7 @@ struct ahash_req_ctx {
 	u8 digest_result_buff[CC_MAX_HASH_DIGEST_SIZE] ____cacheline_aligned;
 	u8 digest_buff[CC_MAX_HASH_DIGEST_SIZE] ____cacheline_aligned;
 	u8 opad_digest_buff[CC_MAX_HASH_DIGEST_SIZE] ____cacheline_aligned;
-	u8 digest_bytes_len[HASH_LEN_SIZE] ____cacheline_aligned;
+	u8 digest_bytes_len[HASH_MAX_LEN_SIZE] ____cacheline_aligned;
 	struct async_gen_req_ctx gen_ctx ____cacheline_aligned;
 	enum cc_req_dma_buf_type data_dma_buf_type;
 	dma_addr_t opad_digest_dma_addr;
diff --git a/drivers/crypto/ccree/cc_host_regs.h b/drivers/crypto/ccree/cc_host_regs.h
index 69ef2fa..f510018 100644
--- a/drivers/crypto/ccree/cc_host_regs.h
+++ b/drivers/crypto/ccree/cc_host_regs.h
@@ -18,6 +18,9 @@
 #define CC_HOST_IRR_DSCRPTR_WATERMARK_INT_BIT_SIZE	0x1UL
 #define CC_HOST_IRR_AXIM_COMP_INT_BIT_SHIFT	0x17UL
 #define CC_HOST_IRR_AXIM_COMP_INT_BIT_SIZE	0x1UL
+#define CC_HOST_SEP_SRAM_THRESHOLD_REG_OFFSET	0xA10UL
+#define CC_HOST_SEP_SRAM_THRESHOLD_VALUE_BIT_SHIFT	0x0UL
+#define CC_HOST_SEP_SRAM_THRESHOLD_VALUE_BIT_SIZE	0xCUL
 #define CC_HOST_IMR_REG_OFFSET	0xA04UL
 #define CC_HOST_IMR_NOT_USED_MASK_BIT_SHIFT	0x1UL
 #define CC_HOST_IMR_NOT_USED_MASK_BIT_SIZE	0x1UL
diff --git a/drivers/crypto/ccree/cc_hw_queue_defs.h b/drivers/crypto/ccree/cc_hw_queue_defs.h
index a79f28ce..bf0d235 100644
--- a/drivers/crypto/ccree/cc_hw_queue_defs.h
+++ b/drivers/crypto/ccree/cc_hw_queue_defs.h
@@ -217,7 +217,7 @@ static inline void hw_desc_init(struct cc_hw_desc *pdesc)
  *
  * @pdesc: pointer HW descriptor struct
  */
-static inline void set_queue_last_ind(struct cc_hw_desc *pdesc)
+static inline void set_queue_last_ind_bit(struct cc_hw_desc *pdesc)
 {
 	pdesc->word[3] |= FIELD_PREP(WORD3_QUEUE_LAST_IND, 1);
 }
diff --git a/drivers/crypto/ccree/cc_kernel_regs.h b/drivers/crypto/ccree/cc_kernel_regs.h
index fa99440..8d7262a 100644
--- a/drivers/crypto/ccree/cc_kernel_regs.h
+++ b/drivers/crypto/ccree/cc_kernel_regs.h
@@ -118,6 +118,7 @@
 #define CC_AXIM_MON_INFLIGHTLAST_VALUE_BIT_SHIFT	0x0UL
 #define CC_AXIM_MON_INFLIGHTLAST_VALUE_BIT_SIZE	0x8UL
 #define CC_AXIM_MON_COMP_REG_OFFSET	0xB80UL
+#define CC_AXIM_MON_COMP8_REG_OFFSET	0xBA0UL
 #define CC_AXIM_MON_COMP_VALUE_BIT_SHIFT	0x0UL
 #define CC_AXIM_MON_COMP_VALUE_BIT_SIZE	0x10UL
 #define CC_AXIM_MON_ERR_REG_OFFSET	0xBC4UL
diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index 0bea57c..2fa0663 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -148,7 +148,7 @@ int cc_req_mgr_init(struct cc_drvdata *drvdata)
 	set_dout_dlli(&req_mgr_h->compl_desc, req_mgr_h->dummy_comp_buff_dma,
 		      sizeof(u32), NS_BIT, 1);
 	set_flow_mode(&req_mgr_h->compl_desc, BYPASS);
-	set_queue_last_ind(&req_mgr_h->compl_desc);
+	set_queue_last_ind(drvdata, &req_mgr_h->compl_desc);
 
 	return 0;
 
@@ -531,7 +531,7 @@ int send_request_init(struct cc_drvdata *drvdata, struct cc_hw_desc *desc,
 	if (rc)
 		return rc;
 
-	set_queue_last_ind(&desc[(len - 1)]);
+	set_queue_last_ind(drvdata, &desc[(len - 1)]);
 
 	/*
 	 * We are about to push command to the HW via the command registers
@@ -610,7 +610,7 @@ static void proc_completions(struct cc_drvdata *drvdata)
 static inline u32 cc_axi_comp_count(struct cc_drvdata *drvdata)
 {
 	return FIELD_GET(AXIM_MON_COMP_VALUE,
-			 cc_ioread(drvdata, CC_REG(AXIM_MON_COMP)));
+			 cc_ioread(drvdata, drvdata->axim_mon_offset));
 }
 
 /* Deferred service handler, run as interrupt-fired tasklet */
diff --git a/drivers/crypto/ccree/cc_sram_mgr.c b/drivers/crypto/ccree/cc_sram_mgr.c
index fed877d..c8c276f 100644
--- a/drivers/crypto/ccree/cc_sram_mgr.c
+++ b/drivers/crypto/ccree/cc_sram_mgr.c
@@ -33,6 +33,19 @@ void cc_sram_mgr_fini(struct cc_drvdata *drvdata)
 int cc_sram_mgr_init(struct cc_drvdata *drvdata)
 {
 	struct cc_sram_ctx *ctx;
+	dma_addr_t start = 0;
+	struct device *dev = drvdata_to_dev(drvdata);
+
+	if (drvdata->hw_rev < CC_HW_REV_712) {
+		/* Pool starts after ROM bytes */
+		start = (dma_addr_t)cc_ioread(drvdata,
+					      CC_REG(HOST_SEP_SRAM_THRESHOLD));
+
+		if ((start & 0x3) != 0) {
+			dev_err(dev, "Invalid SRAM offset %pad\n", &start);
+			return -EINVAL;
+		}
+	}
 
 	/* Allocate "this" context */
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
@@ -40,6 +53,7 @@ int cc_sram_mgr_init(struct cc_drvdata *drvdata)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->sram_free_offset = start;
 	drvdata->sram_mgr_handle = ctx;
 
 	return 0;
-- 
2.7.4

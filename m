Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B07275E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B07275E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeF1PWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:22:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53473 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967190AbeF1PWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:22:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5E4DE20A36; Thu, 28 Jun 2018 17:22:05 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E973203B4;
        Thu, 28 Jun 2018 17:22:05 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Ofer Heifetz <oferh@marvell.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, igall@marvell.com,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH 4/5] crypto: inside-secure - ecb(des3_ede) and cbc(des3_ede) support
Date:   Thu, 28 Jun 2018 17:21:56 +0200
Message-Id: <20180628152157.23769-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628152157.23769-1-antoine.tenart@bootlin.com>
References: <20180628152157.23769-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofer Heifetz <oferh@marvell.com>

This patch adds support for two new algorithms in the Inside Secure
SafeXcel cryptographic engine driver: ecb(des3_ede) and cbc(des3_ede).

Signed-off-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c       |   3 +
 drivers/crypto/inside-secure/safexcel.h       |   3 +
 .../crypto/inside-secure/safexcel_cipher.c    | 114 ++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index ecef32b726ba..db44b9593116 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -406,6 +406,7 @@ static int safexcel_hw_init(struct safexcel_crypto_priv *priv)
 		val |= EIP197_PROTOCOL_ENCRYPT_ONLY | EIP197_PROTOCOL_HASH_ONLY;
 		val |= EIP197_PROTOCOL_ENCRYPT_HASH | EIP197_PROTOCOL_HASH_DECRYPT;
 		val |= EIP197_ALG_DES_ECB | EIP197_ALG_DES_CBC;
+		val |= EIP197_ALG_3DES_ECB | EIP197_ALG_3DES_CBC;
 		val |= EIP197_ALG_AES_ECB | EIP197_ALG_AES_CBC;
 		val |= EIP197_ALG_MD5 | EIP197_ALG_HMAC_MD5;
 		val |= EIP197_ALG_SHA1 | EIP197_ALG_HMAC_SHA1;
@@ -843,6 +844,8 @@ static int safexcel_request_ring_irq(struct platform_device *pdev, const char *n
 static struct safexcel_alg_template *safexcel_algs[] = {
 	&safexcel_alg_ecb_des,
 	&safexcel_alg_cbc_des,
+	&safexcel_alg_ecb_des3_ede,
+	&safexcel_alg_cbc_des3_ede,
 	&safexcel_alg_ecb_aes,
 	&safexcel_alg_cbc_aes,
 	&safexcel_alg_md5,
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 31d4fd259229..839f63ef1556 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -312,6 +312,7 @@ struct safexcel_context_record {
 #define CONTEXT_CONTROL_SIZE(n)			((n) << 8)
 #define CONTEXT_CONTROL_KEY_EN			BIT(16)
 #define CONTEXT_CONTROL_CRYPTO_ALG_DES		(0x0 << 17)
+#define CONTEXT_CONTROL_CRYPTO_ALG_3DES		(0x2 << 17)
 #define CONTEXT_CONTROL_CRYPTO_ALG_AES128	(0x5 << 17)
 #define CONTEXT_CONTROL_CRYPTO_ALG_AES192	(0x6 << 17)
 #define CONTEXT_CONTROL_CRYPTO_ALG_AES256	(0x7 << 17)
@@ -694,6 +695,8 @@ int safexcel_hmac_setkey(const char *alg, const u8 *key, unsigned int keylen,
 /* available algorithms */
 extern struct safexcel_alg_template safexcel_alg_ecb_des;
 extern struct safexcel_alg_template safexcel_alg_cbc_des;
+extern struct safexcel_alg_template safexcel_alg_ecb_des3_ede;
+extern struct safexcel_alg_template safexcel_alg_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_ecb_aes;
 extern struct safexcel_alg_template safexcel_alg_cbc_aes;
 extern struct safexcel_alg_template safexcel_alg_md5;
diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index e27b689ee641..e175d0bf69d8 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -30,6 +30,7 @@ enum safexcel_cipher_direction {
 
 enum safexcel_cipher_alg {
 	SAFEXCEL_DES,
+	SAFEXCEL_3DES,
 	SAFEXCEL_AES,
 };
 
@@ -70,6 +71,12 @@ static void safexcel_skcipher_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 			memcpy(cdesc->control_data.token, iv, DES_BLOCK_SIZE);
 			cdesc->control_data.options |= EIP197_OPTION_2_TOKEN_IV_CMD;
 			break;
+		case SAFEXCEL_3DES:
+			offset = DES3_EDE_BLOCK_SIZE / sizeof(u32);
+			memcpy(cdesc->control_data.token, iv, DES3_EDE_BLOCK_SIZE);
+			cdesc->control_data.options |= EIP197_OPTION_2_TOKEN_IV_CMD;
+			break;
+
 		case SAFEXCEL_AES:
 			offset = AES_BLOCK_SIZE / sizeof(u32);
 			memcpy(cdesc->control_data.token, iv, AES_BLOCK_SIZE);
@@ -287,6 +294,8 @@ static int safexcel_context_control(struct safexcel_cipher_ctx *ctx,
 
 	if (ctx->alg == SAFEXCEL_DES) {
 		cdesc->control_data.control0 |= CONTEXT_CONTROL_CRYPTO_ALG_DES;
+	} else if (ctx->alg == SAFEXCEL_3DES) {
+		cdesc->control_data.control0 |= CONTEXT_CONTROL_CRYPTO_ALG_3DES;
 	} else if (ctx->alg == SAFEXCEL_AES) {
 		switch (ctx->key_len) {
 		case AES_KEYSIZE_128:
@@ -1030,6 +1039,111 @@ struct safexcel_alg_template safexcel_alg_ecb_des = {
 		},
 	},
 };
+
+static int safexcel_cbc_des3_ede_encrypt(struct skcipher_request *req)
+{
+	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
+			SAFEXCEL_ENCRYPT, CONTEXT_CONTROL_CRYPTO_MODE_CBC,
+			SAFEXCEL_3DES);
+}
+
+static int safexcel_cbc_des3_ede_decrypt(struct skcipher_request *req)
+{
+	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
+			SAFEXCEL_DECRYPT, CONTEXT_CONTROL_CRYPTO_MODE_CBC,
+			SAFEXCEL_3DES);
+}
+
+static int safexcel_des3_ede_setkey(struct crypto_skcipher *ctfm,
+				   const u8 *key, unsigned int len)
+{
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(ctfm);
+	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (len != DES3_EDE_KEY_SIZE) {
+		crypto_skcipher_set_flags(ctfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+
+	/* if context exits and key changed, need to invalidate it */
+	if (ctx->base.ctxr_dma) {
+		if (memcmp(ctx->key, key, len))
+			ctx->base.needs_inv = true;
+	}
+
+	memcpy(ctx->key, key, len);
+
+	ctx->key_len = len;
+
+	return 0;
+}
+
+struct safexcel_alg_template safexcel_alg_cbc_des3_ede = {
+	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
+	.engines = EIP97IES | EIP197B | EIP197D,
+	.alg.skcipher = {
+		.setkey = safexcel_des3_ede_setkey,
+		.encrypt = safexcel_cbc_des3_ede_encrypt,
+		.decrypt = safexcel_cbc_des3_ede_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize = DES3_EDE_BLOCK_SIZE,
+		.base = {
+			.cra_name = "cbc(des3_ede)",
+			.cra_driver_name = "safexcel-cbc-des3_ede",
+			.cra_priority = 300,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER | CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct safexcel_cipher_ctx),
+			.cra_alignmask = 0,
+			.cra_init = safexcel_skcipher_cra_init,
+			.cra_exit = safexcel_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
+static int safexcel_ecb_des3_ede_encrypt(struct skcipher_request *req)
+{
+	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
+			SAFEXCEL_ENCRYPT, CONTEXT_CONTROL_CRYPTO_MODE_ECB,
+			SAFEXCEL_3DES);
+}
+
+static int safexcel_ecb_des3_ede_decrypt(struct skcipher_request *req)
+{
+	return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
+			SAFEXCEL_DECRYPT, CONTEXT_CONTROL_CRYPTO_MODE_ECB,
+			SAFEXCEL_3DES);
+}
+
+struct safexcel_alg_template safexcel_alg_ecb_des3_ede = {
+	.type = SAFEXCEL_ALG_TYPE_SKCIPHER,
+	.engines = EIP97IES | EIP197B | EIP197D,
+	.alg.skcipher = {
+		.setkey = safexcel_des3_ede_setkey,
+		.encrypt = safexcel_ecb_des3_ede_encrypt,
+		.decrypt = safexcel_ecb_des3_ede_decrypt,
+		.min_keysize = DES3_EDE_KEY_SIZE,
+		.max_keysize = DES3_EDE_KEY_SIZE,
+		.ivsize = DES3_EDE_BLOCK_SIZE,
+		.base = {
+			.cra_name = "ecb(des3_ede)",
+			.cra_driver_name = "safexcel-ecb-des3_ede",
+			.cra_priority = 300,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER | CRYPTO_ALG_ASYNC |
+				     CRYPTO_ALG_KERN_DRIVER_ONLY,
+			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+			.cra_ctxsize = sizeof(struct safexcel_cipher_ctx),
+			.cra_alignmask = 0,
+			.cra_init = safexcel_skcipher_cra_init,
+			.cra_exit = safexcel_skcipher_cra_exit,
+			.cra_module = THIS_MODULE,
+		},
+	},
+};
+
 static int safexcel_aead_encrypt(struct aead_request *req)
 {
 	struct safexcel_cipher_req *creq = aead_request_ctx(req);
-- 
2.17.1


Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F4AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ME1YLMEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeISHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbeISHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so1943655pgo.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEyuJwkoQ2Dasx4pBI9qW1frw8ZMgAfw1aEB93hmkT4=;
        b=ME1YLMEcwVW5CvLK61JPV5xkx2Q6Ujl+0UmgSgMkpavx4ePc6fg/ZZfTqH08n4WubU
         UUfTsyou7rHs4y+JV8WUHjcdBFtHgNYwZt3Etcp7lD9nTzqgzoN5SOnNy56BplViDW+V
         bVGUUVjTRnQrPV6xNOKyKJ2fOT/e9SVMtleUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEyuJwkoQ2Dasx4pBI9qW1frw8ZMgAfw1aEB93hmkT4=;
        b=D7Rv4bIY8wRpLDRnGPiyYmxh7iAuDW0P2tHl+PjSpu3/J6p0dyDv0x0qiHkFigoFSY
         oistnJLMAs7YxjT6HPNfJE0ZlXMzb1ApG2OD+0jNBm5vPlR4Y8Kc1ujS7G93AeTklYI/
         0GUpxZKwIPoI2jnTRUqzhG/MCb0bZY5c3m8a0zMQ1O6rlqozYRSJaJHULBHkBvzgp36O
         rOWqW8IGTJvZUva6d+wkSpFCZhDGCIsUbne4eJwI41Eb4KKNU4TiPjgfY3CBYOvZorOm
         mdz/IN8oMzZ03uvmX3mIC/be3gkPLCc1mgkU6opYuV4Xu/v3gYXyEyI1gJixtIFlZ64M
         SAlQ==
X-Gm-Message-State: APzg51CRSg7M6StaLbNg1urhAf6m0clbBDlD++63r61PHJx3zgRPaaL6
        gdyYH1K/rTCfL31vheo2o24zIQ==
X-Google-Smtp-Source: ANB0VdYxsl+CFRim8nKheXmwe65x+ntbflgNz7j3EqkNewUXcAGWTouDggpJUCbxEXw2ScaJjgi8sQ==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr33896127pfu.134.1537323077349;
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r25-v6sm23107039pgm.59.2018.09.18.19.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 12/23] crypto: ccp - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:49 -0700
Message-Id: <20180919021100.3380-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
which uses a fixed stack size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Gary Hook <gary.hook@amd.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/ccp/ccp-crypto-aes-xts.c | 13 +++++++------
 drivers/crypto/ccp/ccp-crypto.h         |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes-xts.c b/drivers/crypto/ccp/ccp-crypto-aes-xts.c
index 94b5bcf5b628..ca4630b8395f 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes-xts.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes-xts.c
@@ -102,7 +102,7 @@ static int ccp_aes_xts_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	ctx->u.aes.key_len = key_len / 2;
 	sg_init_one(&ctx->u.aes.key_sg, ctx->u.aes.key, key_len);
 
-	return crypto_skcipher_setkey(ctx->u.aes.tfm_skcipher, key, key_len);
+	return crypto_sync_skcipher_setkey(ctx->u.aes.tfm_skcipher, key, key_len);
 }
 
 static int ccp_aes_xts_crypt(struct ablkcipher_request *req,
@@ -151,12 +151,13 @@ static int ccp_aes_xts_crypt(struct ablkcipher_request *req,
 	    (ctx->u.aes.key_len != AES_KEYSIZE_256))
 		fallback = 1;
 	if (fallback) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->u.aes.tfm_skcipher);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq,
+					       ctx->u.aes.tfm_skcipher);
 
 		/* Use the fallback to process the request for any
 		 * unsupported unit sizes or key sizes
 		 */
-		skcipher_request_set_tfm(subreq, ctx->u.aes.tfm_skcipher);
+		skcipher_request_set_sync_tfm(subreq, ctx->u.aes.tfm_skcipher);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -203,12 +204,12 @@ static int ccp_aes_xts_decrypt(struct ablkcipher_request *req)
 static int ccp_aes_xts_cra_init(struct crypto_tfm *tfm)
 {
 	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct crypto_skcipher *fallback_tfm;
+	struct crypto_sync_skcipher *fallback_tfm;
 
 	ctx->complete = ccp_aes_xts_complete;
 	ctx->u.aes.key_len = 0;
 
-	fallback_tfm = crypto_alloc_skcipher("xts(aes)", 0,
+	fallback_tfm = crypto_alloc_sync_skcipher("xts(aes)", 0,
 					     CRYPTO_ALG_ASYNC |
 					     CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback_tfm)) {
@@ -226,7 +227,7 @@ static void ccp_aes_xts_cra_exit(struct crypto_tfm *tfm)
 {
 	struct ccp_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(ctx->u.aes.tfm_skcipher);
+	crypto_free_sync_skcipher(ctx->u.aes.tfm_skcipher);
 }
 
 static int ccp_register_aes_xts_alg(struct list_head *head,
diff --git a/drivers/crypto/ccp/ccp-crypto.h b/drivers/crypto/ccp/ccp-crypto.h
index b9fd090c46c2..28819e11db96 100644
--- a/drivers/crypto/ccp/ccp-crypto.h
+++ b/drivers/crypto/ccp/ccp-crypto.h
@@ -88,7 +88,7 @@ static inline struct ccp_crypto_ahash_alg *
 /***** AES related defines *****/
 struct ccp_aes_ctx {
 	/* Fallback cipher for XTS with unsupported unit sizes */
-	struct crypto_skcipher *tfm_skcipher;
+	struct crypto_sync_skcipher *tfm_skcipher;
 
 	/* Cipher used to generate CMAC K1/K2 keys */
 	struct crypto_cipher *tfm_cipher;
-- 
2.17.1


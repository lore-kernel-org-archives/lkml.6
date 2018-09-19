Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B68BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C70214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLmB2yvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C70214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeISHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:54:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40189 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbeISHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so1947491pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAt4ak+cBBxaqpmD5vgsGq4R8X7Wa4bk4mC/M1a5dlE=;
        b=aLmB2yvkueyDDVRiK6KrCfRwxCSZn6MZHZfgN7XWNhgLDZs6Yihaq83wkD4417vvke
         ZjpT/64YvjR1NcXpQy1ohRyjTlRMTSEJX1QzcbnT4xypOim1mBL+q8JUP+5kiPXEIkDZ
         Onm7kCVNN5Vxv6pG0VSo/TKCjbbOfgBkvKTn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAt4ak+cBBxaqpmD5vgsGq4R8X7Wa4bk4mC/M1a5dlE=;
        b=W+8ns/gMmKG7nCVeaV9BYINqBq72zMrcxBgR26KPqvIt0TbCvuuqUAL6Lt2yig0V1n
         rCCN6S3rzVmKaTj53ngUw9dYX4jUQMfLTNe8+AHgO6Wbhgf6NXUe51EJDl4Y7f9HoTIg
         kXRplNULQcoj497My+fk36tatUZWC9FKe1eo4BFPcslzpnenUOEzDAMqW25Qt0u0jCGW
         Ius1HScT3NEs4TehddsigY3porXjQSmo/VRmnxwxnwe9GR2l0aDGLTRxAXzmde7FQcJ/
         kp4uFhiVlJJrZH309OrVVTIPvfPV1jNpG2HcZeGZd3eUa8ltPIKt6MSMwNGPpo0WL7O1
         a7Ag==
X-Gm-Message-State: APzg51DiMN0ETZSoni01J/Sx7UM4c/DyMbXG3ZwtsOcjc/nEX7ZjdK2P
        /PjTxD9M+SX00d6pJkiUkz7JVw==
X-Google-Smtp-Source: ANB0VdZ/FOhgLUsEd+wQf4Znf0HRRfMY4dBsT4O8c1P1NCadFdpt6NukVApk3vKmHfziNLEP6q/2VA==
X-Received: by 2002:a63:2bc9:: with SMTP id r192-v6mr30567287pgr.386.1537323563225;
        Tue, 18 Sep 2018 19:19:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d81-v6sm31074217pfj.122.2018.09.18.19.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Harsh Jain <harsh@chelsio.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 19/23] crypto: chelsio - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:56 -0700
Message-Id: <20180919021100.3380-20-keescook@chromium.org>
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

Cc: Harsh Jain <harsh@chelsio.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/chelsio/chcr_algo.c   | 27 ++++++++++++++-------------
 drivers/crypto/chelsio/chcr_crypto.h |  2 +-
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 5c539af8ed60..dfc3a10bb55b 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -671,7 +671,7 @@ static int chcr_sg_ent_in_wr(struct scatterlist *src,
 	return min(srclen, dstlen);
 }
 
-static int chcr_cipher_fallback(struct crypto_skcipher *cipher,
+static int chcr_cipher_fallback(struct crypto_sync_skcipher *cipher,
 				u32 flags,
 				struct scatterlist *src,
 				struct scatterlist *dst,
@@ -681,9 +681,9 @@ static int chcr_cipher_fallback(struct crypto_skcipher *cipher,
 {
 	int err;
 
-	SKCIPHER_REQUEST_ON_STACK(subreq, cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, cipher);
 
-	skcipher_request_set_tfm(subreq, cipher);
+	skcipher_request_set_sync_tfm(subreq, cipher);
 	skcipher_request_set_callback(subreq, flags, NULL, NULL);
 	skcipher_request_set_crypt(subreq, src, dst,
 				   nbytes, iv);
@@ -854,13 +854,14 @@ static int chcr_cipher_fallback_setkey(struct crypto_ablkcipher *cipher,
 	struct ablk_ctx *ablkctx = ABLK_CTX(c_ctx(cipher));
 	int err = 0;
 
-	crypto_skcipher_clear_flags(ablkctx->sw_cipher, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(ablkctx->sw_cipher, cipher->base.crt_flags &
-				  CRYPTO_TFM_REQ_MASK);
-	err = crypto_skcipher_setkey(ablkctx->sw_cipher, key, keylen);
+	crypto_sync_skcipher_clear_flags(ablkctx->sw_cipher,
+				CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(ablkctx->sw_cipher,
+				cipher->base.crt_flags & CRYPTO_TFM_REQ_MASK);
+	err = crypto_sync_skcipher_setkey(ablkctx->sw_cipher, key, keylen);
 	tfm->crt_flags &= ~CRYPTO_TFM_RES_MASK;
 	tfm->crt_flags |=
-		crypto_skcipher_get_flags(ablkctx->sw_cipher) &
+		crypto_sync_skcipher_get_flags(ablkctx->sw_cipher) &
 		CRYPTO_TFM_RES_MASK;
 	return err;
 }
@@ -1360,8 +1361,8 @@ static int chcr_cra_init(struct crypto_tfm *tfm)
 	struct chcr_context *ctx = crypto_tfm_ctx(tfm);
 	struct ablk_ctx *ablkctx = ABLK_CTX(ctx);
 
-	ablkctx->sw_cipher = crypto_alloc_skcipher(alg->cra_name, 0,
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+	ablkctx->sw_cipher = crypto_alloc_sync_skcipher(alg->cra_name, 0,
+				CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ablkctx->sw_cipher)) {
 		pr_err("failed to allocate fallback for %s\n", alg->cra_name);
 		return PTR_ERR(ablkctx->sw_cipher);
@@ -1390,8 +1391,8 @@ static int chcr_rfc3686_init(struct crypto_tfm *tfm)
 	/*RFC3686 initialises IV counter value to 1, rfc3686(ctr(aes))
 	 * cannot be used as fallback in chcr_handle_cipher_response
 	 */
-	ablkctx->sw_cipher = crypto_alloc_skcipher("ctr(aes)", 0,
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+	ablkctx->sw_cipher = crypto_alloc_sync_skcipher("ctr(aes)", 0,
+				CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ablkctx->sw_cipher)) {
 		pr_err("failed to allocate fallback for %s\n", alg->cra_name);
 		return PTR_ERR(ablkctx->sw_cipher);
@@ -1406,7 +1407,7 @@ static void chcr_cra_exit(struct crypto_tfm *tfm)
 	struct chcr_context *ctx = crypto_tfm_ctx(tfm);
 	struct ablk_ctx *ablkctx = ABLK_CTX(ctx);
 
-	crypto_free_skcipher(ablkctx->sw_cipher);
+	crypto_free_sync_skcipher(ablkctx->sw_cipher);
 	if (ablkctx->aes_generic)
 		crypto_free_cipher(ablkctx->aes_generic);
 }
diff --git a/drivers/crypto/chelsio/chcr_crypto.h b/drivers/crypto/chelsio/chcr_crypto.h
index 54835cb109e5..e26b72cfe4b6 100644
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -170,7 +170,7 @@ static inline struct chcr_context *h_ctx(struct crypto_ahash *tfm)
 }
 
 struct ablk_ctx {
-	struct crypto_skcipher *sw_cipher;
+	struct crypto_sync_skcipher *sw_cipher;
 	struct crypto_cipher *aes_generic;
 	__be32 key_ctx_hdr;
 	unsigned int enckey_len;
-- 
2.17.1


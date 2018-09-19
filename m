Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6488ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DD32146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9DjIL3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DD32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeISHyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:54:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39271 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbeISHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so1871367plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=raNi17qMsy3qz3vPZkj768GrqOCILiI6YaVltdqquAE=;
        b=A9DjIL3JTEHoLzAv2OHeypKei/INHBWQzqyqz6iiG4mq49wM7Y4eNEMqPpt0gksuLl
         thFtSZW5NcdJAk+PmxfC1n/UsAHOMY7Ma5XtHk3lHHUWg6QxkTYRnTFLtCFMFlYONZQh
         1NjMex7X8q1okNQWm+deh+2LIMKYWxmXXWyAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=raNi17qMsy3qz3vPZkj768GrqOCILiI6YaVltdqquAE=;
        b=Pf9hBO7qN1p3o+2x5vj+D1F0612M6HDDUapP/6gsHaPb4NB2YDjHAnEiORvsjlz9ZP
         pm+VfUte2cfIdtnrTQD5YlwiRYXk56FwqXd3GBIsVHt4fHpLvRJBe0QOsT+jvDMABZ6c
         cbu2aM8SZ+Nu/nfkU+aJyND3+HuChURhEtj+sQnjpwK4aNpgmaK6PlOii/cRJJiX2w3H
         1jHmP5joIhd4Vq9fuMGY4B6r7iEyawBuvt2U5z3BOspCYSrk/LLgs7GqRHiSejvi/1my
         QviJ+8tGKps5F8M+mvxx/nxpfIAd6zoFjTDj6Np/NiZCmCqj7lhm0XIHRONScKWgDNdw
         KZ0Q==
X-Gm-Message-State: APzg51DjKVBZwVTXUPtfB7blIDdiT01fnhuU01dxI21Boy/W+lmBL6Uc
        4uF7JL1yflwAkk6YXl+41p7JZQ==
X-Google-Smtp-Source: ANB0VdYkwPhSzdiZcF3NawZ/nZhJDnPNfmHeaa2Z36lULhaQfL/zFwIa7wf5TLl0TNvm2XzYmUndbg==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr32498180plz.49.1537323562272;
        Tue, 18 Sep 2018 19:19:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e26-v6sm24230287pfi.70.2018.09.18.19.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Jamie Iles <jamie@jamieiles.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 22/23] crypto: picoxcell - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:59 -0700
Message-Id: <20180919021100.3380-23-keescook@chromium.org>
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

Cc: Jamie Iles <jamie@jamieiles.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/picoxcell_crypto.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 321d5e2ac833..a28f1d18fe01 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -171,7 +171,7 @@ struct spacc_ablk_ctx {
 	 * The fallback cipher. If the operation can't be done in hardware,
 	 * fallback to a software version.
 	 */
-	struct crypto_skcipher		*sw_cipher;
+	struct crypto_sync_skcipher	*sw_cipher;
 };
 
 /* AEAD cipher context. */
@@ -799,17 +799,17 @@ static int spacc_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
 		 * Set the fallback transform to use the same request flags as
 		 * the hardware transform.
 		 */
-		crypto_skcipher_clear_flags(ctx->sw_cipher,
+		crypto_sync_skcipher_clear_flags(ctx->sw_cipher,
 					    CRYPTO_TFM_REQ_MASK);
-		crypto_skcipher_set_flags(ctx->sw_cipher,
+		crypto_sync_skcipher_set_flags(ctx->sw_cipher,
 					  cipher->base.crt_flags &
 					  CRYPTO_TFM_REQ_MASK);
 
-		err = crypto_skcipher_setkey(ctx->sw_cipher, key, len);
+		err = crypto_sync_skcipher_setkey(ctx->sw_cipher, key, len);
 
 		tfm->crt_flags &= ~CRYPTO_TFM_RES_MASK;
 		tfm->crt_flags |=
-			crypto_skcipher_get_flags(ctx->sw_cipher) &
+			crypto_sync_skcipher_get_flags(ctx->sw_cipher) &
 			CRYPTO_TFM_RES_MASK;
 
 		if (err)
@@ -914,7 +914,7 @@ static int spacc_ablk_do_fallback(struct ablkcipher_request *req,
 	struct crypto_tfm *old_tfm =
 	    crypto_ablkcipher_tfm(crypto_ablkcipher_reqtfm(req));
 	struct spacc_ablk_ctx *ctx = crypto_tfm_ctx(old_tfm);
-	SKCIPHER_REQUEST_ON_STACK(subreq, ctx->sw_cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->sw_cipher);
 	int err;
 
 	/*
@@ -922,7 +922,7 @@ static int spacc_ablk_do_fallback(struct ablkcipher_request *req,
 	 * the ciphering has completed, put the old transform back into the
 	 * request.
 	 */
-	skcipher_request_set_tfm(subreq, ctx->sw_cipher);
+	skcipher_request_set_sync_tfm(subreq, ctx->sw_cipher);
 	skcipher_request_set_callback(subreq, req->base.flags, NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst,
 				   req->nbytes, req->info);
@@ -1020,9 +1020,8 @@ static int spacc_ablk_cra_init(struct crypto_tfm *tfm)
 	ctx->generic.flags = spacc_alg->type;
 	ctx->generic.engine = engine;
 	if (alg->cra_flags & CRYPTO_ALG_NEED_FALLBACK) {
-		ctx->sw_cipher = crypto_alloc_skcipher(
-			alg->cra_name, 0, CRYPTO_ALG_ASYNC |
-					  CRYPTO_ALG_NEED_FALLBACK);
+		ctx->sw_cipher = crypto_alloc_sync_skcipher(
+			alg->cra_name, 0, CRYPTO_ALG_NEED_FALLBACK);
 		if (IS_ERR(ctx->sw_cipher)) {
 			dev_warn(engine->dev, "failed to allocate fallback for %s\n",
 				 alg->cra_name);
@@ -1041,7 +1040,7 @@ static void spacc_ablk_cra_exit(struct crypto_tfm *tfm)
 {
 	struct spacc_ablk_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(ctx->sw_cipher);
+	crypto_free_sync_skcipher(ctx->sw_cipher);
 }
 
 static int spacc_ablk_encrypt(struct ablkcipher_request *req)
-- 
2.17.1


Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D722ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AF22146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOvEDzQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AF22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeISHy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:54:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34565 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbeISHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so1929841pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nX8MhHJeg4eisDy8vxqN/vLEivEa4yzpbmxml8l/MbY=;
        b=FOvEDzQPfthxL8BZJgzRXyF0feGHmaPYxCQHydY70vlhsYm5YQqZM3fktVJ0sRa3mW
         KjZuAMBjuweI0ue3Qm8boYUD8jM6hGUVFvc0l3VMlGn9PEzxftaUdkBK9ngSAHzwyp8g
         meEXoXvEoVLHrGqRHSL6vkzJJpzFGDA0FxIyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nX8MhHJeg4eisDy8vxqN/vLEivEa4yzpbmxml8l/MbY=;
        b=Hlah3F1w0hnEXVcSGrMzVMuQRXZgbeG0dSG4jaUibV4/FI/1Ge3mcDTaMvCk8Fchn9
         MWFBUiXwy+IGqFtKSDaobdWmfKtkc2EkaBWDzn4/s0oRDTQJWFeJCih7LDXjGK+3NBFF
         IwwI5X/e91/UIv9EgVMiOTMXm5KnHASs/akN511y43owEPTsm9cEF5r7nHaLndbJwQQ9
         Vgwecpvu3rGOO3si7pcJd0IakS4uC3EePDIk+PSEIBYTa2nYBwhOsBcOriV6+z6p8K0w
         uEKo0rpft3PX892bF6Il5u830QLyjql/oWmxzjdvtjBOkJbGxZwZJm8LRsg0iU6QxCZy
         2XJw==
X-Gm-Message-State: APzg51Blmy7li8ilK5cssg+IzbWWDlREhXw0IjC3DLMr4XP2EDH0S+ik
        gbqj0++3ArCTrQgWmpyphq8gzA==
X-Google-Smtp-Source: ANB0VdYHHcQp3fcNwUTAshiSXh2NHB+9sPw3BSg9QWAOv53l+H1kwUkJaMzBEYtNBXEspTQXKtYWPQ==
X-Received: by 2002:a63:6ecf:: with SMTP id j198-v6mr29732918pgc.3.1537323564374;
        Tue, 18 Sep 2018 19:19:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z5-v6sm24605991pfh.83.2018.09.18.19.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 20/23] crypto: mxs-dcp - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:57 -0700
Message-Id: <20180919021100.3380-21-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/mxs-dcp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index a10c418d4e5c..430174be6f92 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -84,7 +84,7 @@ struct dcp_async_ctx {
 	unsigned int			hot:1;
 
 	/* Crypto-specific context */
-	struct crypto_skcipher		*fallback;
+	struct crypto_sync_skcipher	*fallback;
 	unsigned int			key_len;
 	uint8_t				key[AES_KEYSIZE_128];
 };
@@ -376,10 +376,10 @@ static int mxs_dcp_block_fallback(struct ablkcipher_request *req, int enc)
 {
 	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
 	struct dcp_async_ctx *ctx = crypto_ablkcipher_ctx(tfm);
-	SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 	int ret;
 
-	skcipher_request_set_tfm(subreq, ctx->fallback);
+	skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 	skcipher_request_set_callback(subreq, req->base.flags, NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst,
 				   req->nbytes, req->info);
@@ -460,16 +460,16 @@ static int mxs_dcp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	 * but is supported by in-kernel software implementation, we use
 	 * software fallback.
 	 */
-	crypto_skcipher_clear_flags(actx->fallback, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(actx->fallback,
+	crypto_sync_skcipher_clear_flags(actx->fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(actx->fallback,
 				  tfm->base.crt_flags & CRYPTO_TFM_REQ_MASK);
 
-	ret = crypto_skcipher_setkey(actx->fallback, key, len);
+	ret = crypto_sync_skcipher_setkey(actx->fallback, key, len);
 	if (!ret)
 		return 0;
 
 	tfm->base.crt_flags &= ~CRYPTO_TFM_RES_MASK;
-	tfm->base.crt_flags |= crypto_skcipher_get_flags(actx->fallback) &
+	tfm->base.crt_flags |= crypto_sync_skcipher_get_flags(actx->fallback) &
 			       CRYPTO_TFM_RES_MASK;
 
 	return ret;
@@ -478,11 +478,10 @@ static int mxs_dcp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 static int mxs_dcp_aes_fallback_init(struct crypto_tfm *tfm)
 {
 	const char *name = crypto_tfm_alg_name(tfm);
-	const uint32_t flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK;
 	struct dcp_async_ctx *actx = crypto_tfm_ctx(tfm);
-	struct crypto_skcipher *blk;
+	struct crypto_sync_skcipher *blk;
 
-	blk = crypto_alloc_skcipher(name, 0, flags);
+	blk = crypto_alloc_sync_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(blk))
 		return PTR_ERR(blk);
 
@@ -495,7 +494,7 @@ static void mxs_dcp_aes_fallback_exit(struct crypto_tfm *tfm)
 {
 	struct dcp_async_ctx *actx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(actx->fallback);
+	crypto_free_sync_skcipher(actx->fallback);
 }
 
 /*
-- 
2.17.1


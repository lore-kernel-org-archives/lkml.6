Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112FECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772721522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iA8yyiD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A772721522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeISHqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34794 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbeISHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so1875407plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Tj7v4HL+EFbAUO29Yph36tPWfB4V/ACZUQmXez3Df4=;
        b=iA8yyiD2vAOXymxeNdfJmuFil5rWrg8MFOi5/3KU/4OU9uY7AIYRcCs1yo67UEQDSx
         4IEdT5l/mFpCn7LrAJ++BVF/zuzFRWZxkyhwT/tE8r2WTqlEi17fganPKZ/8R5RM3sqd
         O6yzwe6IFDtaS0814LtXvRbcNRunj6cqMaHpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Tj7v4HL+EFbAUO29Yph36tPWfB4V/ACZUQmXez3Df4=;
        b=GSabvI95RHBBIbvmoND9JCCdu5m2us0QOqp0xFR7FbuKxBF3OEPzqm313UFqdFNMcr
         3FIwn2gEVY36zXEOleZxGnw+WxkV7c9JIj2RWbUFen16gA4it6kLQzyr3ksNcuRtlbbY
         RYyJjDjd3/JcpKchOtG4N0GNp8ZtCaR2/7Txcb7t8UpL00tdghebhTPUsPvFH2jPIrXm
         DEAuijoI0T1KjGC/ScipQr7v7aULfCB9BplAdnqiq1OTBHI3qkTPx/uJikVomKw108yA
         /SnDISuoQHmxYfvm1Fbi9ORV8fBcoI9ItifJl+WNGfUbhJ0RwR11LLyjdnG+5YLZvVzR
         JEVg==
X-Gm-Message-State: APzg51BmosqZDDAZPZcfOtebc7JmThojDMMO+h4VL4zAuiGpvxqFoBLc
        IKp9FzlBwchOGAtyd5NnwE+hFw==
X-Google-Smtp-Source: ANB0VdbkWc94GU+6bakmhLfgGguFd0wj442pWI65r1OEyxfkUFFCi8cC49x8pd0tDj5my7VJY9CEDg==
X-Received: by 2002:a17:902:74c8:: with SMTP id f8-v6mr16632282plt.95.1537323082521;
        Tue, 18 Sep 2018 19:11:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m21-v6sm36363389pgd.6.2018.09.18.19.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 21/23] crypto: omap-aes - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:58 -0700
Message-Id: <20180919021100.3380-22-keescook@chromium.org>
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
 drivers/crypto/omap-aes.c | 17 ++++++++---------
 drivers/crypto/omap-aes.h |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 9019f6b67986..a553ffddb11b 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -522,9 +522,9 @@ static int omap_aes_crypt(struct ablkcipher_request *req, unsigned long mode)
 		  !!(mode & FLAGS_CBC));
 
 	if (req->nbytes < aes_fallback_sz) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags, NULL,
 					      NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -564,11 +564,11 @@ static int omap_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	memcpy(ctx->key, key, keylen);
 	ctx->keylen = keylen;
 
-	crypto_skcipher_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(ctx->fallback, tfm->base.crt_flags &
+	crypto_sync_skcipher_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(ctx->fallback, tfm->base.crt_flags &
 						 CRYPTO_TFM_REQ_MASK);
 
-	ret = crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret = crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	if (!ret)
 		return 0;
 
@@ -613,11 +613,10 @@ static int omap_aes_crypt_req(struct crypto_engine *engine,
 static int omap_aes_cra_init(struct crypto_tfm *tfm)
 {
 	const char *name = crypto_tfm_alg_name(tfm);
-	const u32 flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK;
 	struct omap_aes_ctx *ctx = crypto_tfm_ctx(tfm);
-	struct crypto_skcipher *blk;
+	struct crypto_sync_skcipher *blk;
 
-	blk = crypto_alloc_skcipher(name, 0, flags);
+	blk = crypto_alloc_sync_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(blk))
 		return PTR_ERR(blk);
 
@@ -667,7 +666,7 @@ static void omap_aes_cra_exit(struct crypto_tfm *tfm)
 	struct omap_aes_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback)
-		crypto_free_skcipher(ctx->fallback);
+		crypto_free_sync_skcipher(ctx->fallback);
 
 	ctx->fallback = NULL;
 }
diff --git a/drivers/crypto/omap-aes.h b/drivers/crypto/omap-aes.h
index fc3b46a85809..7e02920ef6f8 100644
--- a/drivers/crypto/omap-aes.h
+++ b/drivers/crypto/omap-aes.h
@@ -101,7 +101,7 @@ struct omap_aes_ctx {
 	int		keylen;
 	u32		key[AES_KEYSIZE_256 / sizeof(u32)];
 	u8		nonce[4];
-	struct crypto_skcipher	*fallback;
+	struct crypto_sync_skcipher	*fallback;
 	struct crypto_skcipher	*ctr;
 };
 
-- 
2.17.1


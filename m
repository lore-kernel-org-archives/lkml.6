Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5004C43143
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43D2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3UJKfaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E43D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIGDgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:36:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33705 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGDgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:36:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so6016153pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3iq55GoU+tLApB726SD4i2dQYVt9A2ASC3TLsp01ZLo=;
        b=A3UJKfaDq/KIZ/jSL4CCz6gf6ItNwoNjslBKueg5aPG8kQGOubBHg7K7Il2pd/+Fo9
         m9SRDwWCZ+BNIMCbF6OCTkmwG7F2DPAHdEEOIrDOW+HHIZKef8WL5PAXkdZPAGRszfOL
         tD8KjyfeBs2oEjZcNVZLl2jtOXXzlWyWNbjgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3iq55GoU+tLApB726SD4i2dQYVt9A2ASC3TLsp01ZLo=;
        b=XhlBo/VyDxoMH9XyAZQb52R76c+LzoD8oXVGGrEH/8qW9bW9YfpARsq5RXyMs6J7Gm
         PG28YMBv9MBA1J///qhd6WywvcUR6KSQtH5CNJe4ek6woSUwsGUaEc5HyaasBZnmeCfx
         5IuHrGmdS2vB/tcr7v24N+Apa+/1sfVZE+yY0XkhDNjV5BAHabNcOL7vZOEMFmx3Xy/I
         d1lJOallUH18cjUAcpyAQ8Ko/DmqmKNKZZh6DjS/u/aNJ/ZAUl8VAG4EyYKoFm74G5aB
         5KxZK23gKzATjXFXUTGdj2zNjN8RkZFgFU9qHNr8tTskHV3gHjM0W/bYfZvRTxZm7853
         UW8A==
X-Gm-Message-State: APzg51DcXcSW0L3tAw8PhsI4PUSBwDpia0X3eYA9buE3kSkZgzGJBKbk
        Jzo8C7zwWYoceKBCr1osQ/krVjvHL5I=
X-Google-Smtp-Source: ANB0Vdb093qGdJ0xfu9GJ0+hy2cT35kwDytA4iv8Ph7ohgX2b1qNn+dNjq02qUNHOEwns4ge1kcbfg==
X-Received: by 2002:a62:1bc2:: with SMTP id b185-v6mr5445400pfb.170.1536274743739;
        Thu, 06 Sep 2018 15:59:03 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6535693pgp.34.2018.09.06.15.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:59:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] crypto: skcipher - Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Thu,  6 Sep 2018 15:58:53 -0700
Message-Id: <20180906225854.40989-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906225854.40989-1-keescook@chromium.org>
References: <20180906225854.40989-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this caps
the non-ASYNC skcipher request size similar to other limits and adds a
sanity check at usage. After a review of all non-ASYNC algorithm callers
of crypto_skcipher_set_reqsize(), the largest appears to be 384:

4       struct sun4i_cipher_req_ctx
96      struct crypto_rfc3686_req_ctx
375     cts:
                160     crypto_skcipher_blocksize(cipher) (max)
                152     struct crypto_cts_reqctx
                63      align_mask (max)
384     struct rctx (lrw, xts)

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/skcipher.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 3aabd5d098ed..cca216999bf1 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -144,9 +144,10 @@ struct skcipher_alg {
 /*
  * This must only ever be used with synchronous algorithms.
  */
+#define MAX_SYNC_SKCIPHER_REQSIZE	384
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR = { 1 }; \
+		MAX_SYNC_SKCIPHER_REQSIZE] CRYPTO_MINALIGN_ATTR = { 1 }; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
@@ -412,6 +413,17 @@ static inline unsigned int crypto_skcipher_default_keysize(
 	return tfm->keysize;
 }
 
+/**
+ * crypto_skcipher_reqsize() - obtain size of the request data structure
+ * @tfm: cipher handle
+ *
+ * Return: number of bytes
+ */
+static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
+{
+	return tfm->reqsize;
+}
+
 /**
  * crypto_skcipher_reqtfm() - obtain cipher handle from request
  * @req: skcipher_request out of which the cipher handle is to be obtained
@@ -446,6 +458,9 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
 		if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
 				CRYPTO_ALG_ASYNC))
 			return ERR_PTR(-EINVAL);
+		if (WARN_ON(crypto_skcipher_reqsize(tfm) >
+				MAX_SYNC_SKCIPHER_REQSIZE))
+			return ERR_PTR(-ENOSPC);
 	}
 
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
@@ -507,17 +522,6 @@ static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
  * skcipher handle to the crypto_skcipher_* API calls.
  */
 
-/**
- * crypto_skcipher_reqsize() - obtain size of the request data structure
- * @tfm: cipher handle
- *
- * Return: number of bytes
- */
-static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
-{
-	return tfm->reqsize;
-}
-
 /**
  * skcipher_request_set_tfm() - update cipher handle reference in request
  * @req: request handle to be modified
-- 
2.17.1


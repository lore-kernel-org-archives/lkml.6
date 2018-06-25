Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956B8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4922926155
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhk+Gm3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4922926155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755743AbeFYVLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:11:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45314 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755041AbeFYVKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id o18-v6so6713279pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXuGUo3CgtLCxU0uXrhmKWqGXnPR9Lzs5ZkCBgfB/Rg=;
        b=jhk+Gm3re/9Vs1IdGB9Ugw9VIGaTToLT8mKZotdUQNbDPHHx5WNQhy6rHy+eZuD3Uh
         KHwWLGi8k2VIG6+SaOpMFUTgYjG6el3E4udLtGGf7SrSXndZ7WCM6b1t9Xy4V+1K2ZLu
         pzR/2A9Wdntw70qDbOf35yrzXzD1oyhTgrtLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXuGUo3CgtLCxU0uXrhmKWqGXnPR9Lzs5ZkCBgfB/Rg=;
        b=mJN8pD3MczuB3+lbiouxPWZDe3JZszrPKzJwwz78NBKUhuLbnwh2Vwqqx9oeue9l78
         l8YHtyHRkJd0ledg4h1EOpCxUvB3AFSj9uqC0ljLeJLbZLZS3Bs8tKrka8PuVqpO18pC
         uRlG7j75ies/0eGUGVyHcWVFaRr3Cr7ZP9ezrjR6u86MCqSjQ0YFXkcIfwmlkQgU+CnI
         Evhm8OW+5czGuvOOxT9yUvbLly6MczVSoDKexBdYSKslml0lW/RYa0EbEtArDHL8smug
         cZ3hmNt52csSkPE0sQF4UY4WMX+JlsJRvhKs2HHVooZ0qJv2PFYYUy1MgHdemLCm3tfn
         +bbQ==
X-Gm-Message-State: APt69E1Rw6adWGEqaY3tyDxfIkGRDXi1VhG+f0XWKOKsYhJCvr6TZThT
        PoIXoKx/xMT5bwh+/o1TFTXUoQ==
X-Google-Smtp-Source: ADUXVKLu+zd9fGO/0bD1KlsIyBwVAKLT+oKTjFB6zq8dY0N2y8oATvQwC4WqV4FEhQwEn3nO/Dzmiw==
X-Received: by 2002:a17:902:7686:: with SMTP id m6-v6mr14124701pll.340.1529961046800;
        Mon, 25 Jun 2018 14:10:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m21-v6sm19240237pgv.27.2018.06.25.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rabin Vincent <rabinv@axis.com>,
        Lars Persson <larper@axis.com>, linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
Date:   Mon, 25 Jun 2018 14:10:25 -0700
Message-Id: <20180625211026.15819-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this caps
the ahash request size similar to the other limits and adds a sanity
check at registration. Unfortunately, these reqsizes can be huge. Looking
at all callers of crypto_ahash_set_reqsize(), the largest appears to be
664 bytes, based on a combination of manual inspection and pahole output:

4       dcp_sha_req_ctx
40      crypto4xx_ctx
52      hash_req_ctx
80      ahash_request
88      rk_ahash_rctx
104     sun4i_req_ctx
200     mcryptd_hash_request_ctx
216     safexcel_ahash_req
228     sha1_hash_ctx
228     sha256_hash_ctx
248     img_hash_request_ctx
252     mtk_sha_reqctx
276     sahara_sha_reqctx
304     mv_cesa_ahash_req
316     iproc_reqctx_s
320     caam_hash_state
320     qce_sha_reqctx
356     sha512_hash_ctx
384     ahash_req_ctx
400     chcr_ahash_req_ctx
416     stm32_hash_request_ctx
432     talitos_ahash_req_ctx
462     atmel_sha_reqctx
496     ccp_aes_cmac_req_ctx
616     ccp_sha_req_ctx
664     artpec6_hash_request_context

So, this chooses 720 as a larger "round" number for the max.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Rabin Vincent <rabinv@axis.com>
Cc: Lars Persson <larper@axis.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/hash.h          | 3 ++-
 include/crypto/internal/hash.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 5d79e2f0936e..b550077c4767 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -66,10 +66,11 @@ struct ahash_request {
 
 #define AHASH_MAX_DIGESTSIZE	512
 #define AHASH_MAX_STATESIZE	512
+#define AHASH_MAX_REQSIZE	720
 
 #define AHASH_REQUEST_ON_STACK(name, ahash) \
 	char __##name##_desc[sizeof(struct ahash_request) + \
-		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
+		AHASH_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct ahash_request *name = (void *)__##name##_desc
 
 /**
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index a0b0ad9d585e..d96ae5f52125 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -142,6 +142,7 @@ static inline struct ahash_alg *__crypto_ahash_alg(struct crypto_alg *alg)
 static inline void crypto_ahash_set_reqsize(struct crypto_ahash *tfm,
 					    unsigned int reqsize)
 {
+	BUG_ON(reqsize > AHASH_MAX_REQSIZE);
 	tfm->reqsize = reqsize;
 }
 
-- 
2.17.1


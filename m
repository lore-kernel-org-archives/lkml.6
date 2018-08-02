Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551921531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mTY19WAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C551921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeHCApO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43516 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeHCApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17-v6so1880200pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cYqwOJ7ESFIZwb4gd+/rbe5MIJRsMeh+zsX7Pq9yPAY=;
        b=mTY19WAXKcACv2jHRUfcKmGhLkXkq85tiOxXJpcFj0PAX9lWdyvUM9LqDcHa6iBIG/
         IiVeCwl6vqLnRdkeoxpKqO8dH/xl00FXb/lTnVVb0ztRX032O5A+wUw86q+fl6g1gK+e
         zB2UK6iF1LM/YHdusCOZ0lTsaU8j2aRNlKuyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cYqwOJ7ESFIZwb4gd+/rbe5MIJRsMeh+zsX7Pq9yPAY=;
        b=Pj7UPckBLsnPVjFyMycCmbdN2pbZ9tsNTK1UclRdM2j4HdLdTDdfnK6ln0I+/sVBHV
         LDarfdq0QP46J7wc0grcUs9p/M24NjBZgC+TnO56aEXSpb0ZD+6OJYh9zjwEtcmbcmlR
         xQ/L0Om84hJKm6RbyDyWkAZFXNPNsCdQ5dAgt6SvOCGloTfHye/TQEKruMFeZaw1HDEd
         fgrEDlAgbW19WNsqBecQhfLGXvKnH5YIzDGu1Ybf6oyPfItxZMdWltSWpZWiJdso9CLs
         mS+Y1GAtvDay5J4SLamH9uGrb4CspmYynJQtt9ADIIMXhceS9HUQhSB7Ff7/wnqWkkm1
         9jGw==
X-Gm-Message-State: AOUpUlFxPYaH2e0MFyd9cp68v9rSsUgtIhxq07IUlmR+vtzQCJhQRHaD
        DGM7bzygiG0B7FnNLGogChZciw==
X-Google-Smtp-Source: AAOMgpc8iy9cvq8p6m9TZlGMtkIL+1L6+pA1vJtJHEVUn52NqhF7WjFMgLggNV//Jd9BU8b0PMhiqA==
X-Received: by 2002:a63:f344:: with SMTP id t4-v6mr1222258pgj.428.1533250318354;
        Thu, 02 Aug 2018 15:51:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q10-v6sm4050397pfh.124.2018.08.02.15.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:51:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] crypto: ccm: Remove VLA usage
Date:   Thu,  2 Aug 2018 15:51:46 -0700
Message-Id: <20180802225152.19194-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802225152.19194-1-keescook@chromium.org>
References: <20180802225152.19194-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

In the quest to remove all stack VLA usage from the kernel[1], this drops
AHASH_REQUEST_ON_STACK by preallocating the ahash request area combined
with the skcipher area (which are not used at the same time).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ccm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/ccm.c b/crypto/ccm.c
index 0a083342ec8c..b242fd0d3262 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -50,7 +50,10 @@ struct crypto_ccm_req_priv_ctx {
 	u32 flags;
 	struct scatterlist src[3];
 	struct scatterlist dst[3];
-	struct skcipher_request skreq;
+	union {
+		struct ahash_request ahreq;
+		struct skcipher_request skreq;
+	};
 };
 
 struct cbcmac_tfm_ctx {
@@ -181,7 +184,7 @@ static int crypto_ccm_auth(struct aead_request *req, struct scatterlist *plain,
 	struct crypto_ccm_req_priv_ctx *pctx = crypto_ccm_reqctx(req);
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
 	struct crypto_ccm_ctx *ctx = crypto_aead_ctx(aead);
-	AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
+	struct ahash_request *ahreq = &pctx->ahreq;
 	unsigned int assoclen = req->assoclen;
 	struct scatterlist sg[3];
 	u8 *odata = pctx->odata;
@@ -427,7 +430,7 @@ static int crypto_ccm_init_tfm(struct crypto_aead *tfm)
 	crypto_aead_set_reqsize(
 		tfm,
 		align + sizeof(struct crypto_ccm_req_priv_ctx) +
-		crypto_skcipher_reqsize(ctr));
+		max(crypto_ahash_reqsize(mac), crypto_skcipher_reqsize(ctr)));
 
 	return 0;
 
-- 
2.17.1


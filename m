Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D65C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E721570
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zv2bO+EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E721570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHGXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so31708pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cYqwOJ7ESFIZwb4gd+/rbe5MIJRsMeh+zsX7Pq9yPAY=;
        b=Zv2bO+EVmzrhlM21vJwiHRJYvGXpTVd9Hkfi2ozX4bgt1kgLyS4x69k84MZQAaFu5/
         rVBPqEXFfYt+ujIFki/OJApGkEi+OiqVD8EtaQlq8fQAE6/sWtdNjk0Tlt1uJE7szewB
         Ll7wLkOdmIt/ZeTDS8XOyC0JeXjOxep+1Jlno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cYqwOJ7ESFIZwb4gd+/rbe5MIJRsMeh+zsX7Pq9yPAY=;
        b=Bth52cJ/KvzL61X7wE9ldkGp4d7diXRTvcAXbbYAxAMbqgHbEAJG3eeCf1GVnDhYLs
         Yw0rcBP0e70omkKd0caGpiN1uVA0cpwrKjioVXeW7k/MsnfpUtt/r0O77RBMTGozPhhj
         tOwgv3PqPhN+wZyWK9g7HVrOoR90Ya9U4guPORuJWuKLSFka/c46M9hV4eFzEyPc/Z+u
         wUFK/GPxpCBkrTZXg0e3vPfd2yMu1LADzLRoFt2xbJi56Ef6XZEM5t+844olAj0XvXOv
         Rs9LhuXm2ZdNMqhNCMjqQj25PR3iGx3V7C5ljcxAEUBM+L391A8dUK3kGSneB1DBGUE8
         1ntQ==
X-Gm-Message-State: AOUpUlEkIy1t22Q8HhHW3mWC/Qbnb7RZpcVvVLf5c8KXRKytaBdQmrgE
        r28MIbLXeYfAVc8dCPTasfJ04A==
X-Google-Smtp-Source: AA+uWPwI6gR03o6wXqR3s5ePfHIZtlWIz2JOu2KYxBWgqUu09/pueNIXYSRV2sMsshh5CODmT4qQug==
X-Received: by 2002:a63:1c13:: with SMTP id c19-v6mr76678pgc.332.1533676727360;
        Tue, 07 Aug 2018 14:18:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e126-v6sm5493576pfg.31.2018.08.07.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/9] crypto: ccm: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:37 -0700
Message-Id: <20180807211843.47586-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
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


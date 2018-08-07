Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE6C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC7215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nArgZqlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CC7215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHGXff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHGXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so19352pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=om28ZBbqlVOdWVGgbNqly+1dcj2BlW29w8AmBA0lHYw=;
        b=nArgZqlYDDgAq8YX/jvWimxGlDBI68qUF1jtzrItHrtzN3msuSa2epxNtb01j1mOa/
         ca39AMvJj1q9mhidQmpE/bdZxNACdzIxjOLkMyuwCfO8eV7kfrw85ZO3lfZXU/Z1ZpWP
         crX2EF+lPcXz/pZMXPOg/uW4XV4QfIoCAN1Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=om28ZBbqlVOdWVGgbNqly+1dcj2BlW29w8AmBA0lHYw=;
        b=f1QU7t8dRsl79llv7yKfgAcFFMliGIHCDgF1bGYz8kNIROxSa9ZwvWK1GZ+l2Ep2Dg
         KkE9iAOZqCZgSU2ttGej4CNQHDZ2PyvEXSHHofDUkU1mxGP9o599PCS1gJfvXcTkHVgN
         Z7jxIiIkxqGm0b9FSzVp19+ewdG3eQZnZ6cik/mIwWUy/zXfvPtA/URg12RknI6/nrLw
         gTq8BvYyGQHXJ90P3DuCUzioCzgaZt55Z4ajVQWvpw8ufg4Guz6KNWoxozWozyTysMpe
         Ph13V8iHiQKyJneugfmKpELDBq88ZcVwLaArvs4alBtf49t3eQ/jffEZL57x4XaGJOjx
         b0IQ==
X-Gm-Message-State: AOUpUlEn5/v4/jwiOO7pZnPB/F6aRbdWNqSuyTsdLTfkJB7cGb/tNDlv
        Gu65Wo1L1gBk8+np/W9Mh4DAKQ==
X-Google-Smtp-Source: AA+uWPxCZWHFGrG9CATf1gLBhHbwJ5GzpSEYlL5Eskb5hpUBJH8fTI6RS9rnBo5vAeWQvw/CzTVYWA==
X-Received: by 2002:a63:7a0a:: with SMTP id v10-v6mr71065pgc.444.1533676733215;
        Tue, 07 Aug 2018 14:18:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b64-v6sm3357099pfg.66.2018.08.07.14.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v8 6/9] crypto alg: Introduce generic max blocksize and alignmask
Date:   Tue,  7 Aug 2018 14:18:40 -0700
Message-Id: <20180807211843.47586-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
exposes a new general upper bound on crypto blocksize and alignmask
(higher than for the existing cipher limits) for VLA removal,
and introduces new checks.

At present, the highest cra_alignmask in the kernel is 63. The highest
cra_blocksize is 144 (SHA3_224_BLOCK_SIZE, 18 8-byte words). For the
new blocksize limit, I went with 160 (20 8-byte words).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/algapi.c         | 7 ++++++-
 include/crypto/algapi.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..496fc51bf215 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -57,9 +57,14 @@ static int crypto_check_alg(struct crypto_alg *alg)
 	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
 		return -EINVAL;
 
-	if (alg->cra_blocksize > PAGE_SIZE / 8)
+	/* General maximums for all algs. */
+	if (alg->cra_alignmask > MAX_ALGAPI_ALIGNMASK)
 		return -EINVAL;
 
+	if (alg->cra_blocksize > MAX_ALGAPI_BLOCKSIZE)
+		return -EINVAL;
+
+	/* Lower maximums for specific alg types. */
 	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
 			       CRYPTO_ALG_TYPE_CIPHER) {
 		if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index bd5e8ccf1687..21371ac8f355 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -20,8 +20,10 @@
 /*
  * Maximum values for blocksize and alignmask, used to allocate
  * static buffers that are big enough for any combination of
- * ciphers and architectures.
+ * algs and architectures. Ciphers have a lower maximum size.
  */
+#define MAX_ALGAPI_BLOCKSIZE		160
+#define MAX_ALGAPI_ALIGNMASK		63
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
-- 
2.17.1


Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE69C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015D421570
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQHeD2Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015D421570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeHGXfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37416 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeHGXfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so42956pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f6HZhbULuwp1ONQvXFzzLM5M+BCFj7xnBsodxU5HF/8=;
        b=AQHeD2EmOI4vzY7tE412tf3d4wZqk04hm56bZ/zFfnsovVcaoBMwGdDWkXviKDWyxJ
         ucqcMKo8jU+qU611qS/iWtCST1ndKdgUlDJ8W5SNkkumFu5u+Fdm0H5+jkUtByWcOIFw
         3wmThKCMx52Qi3kXdqdwF55mm1JDmlVlvitqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f6HZhbULuwp1ONQvXFzzLM5M+BCFj7xnBsodxU5HF/8=;
        b=ZivJjGw1ARBW7pWmfaEQb0DMiI9j0rW4LBpHBwGv9QSKon2DvIlg+S0wKnxMMsr68N
         DP2ITOqQpP49HqpK1vGdNb9PUIA0NNJoc3lwymXsEa4+UKil9FGWkxIVy4Jvg2qOnGZo
         4L26dEpUAnbqlJq/BlIfxfZ0aOYmHP87y6IKzXtuz8RiTuBsKkejo71ycdNSIcBb3sXQ
         nOSf3bf0iXWwemC9neZn++lBWauenk1jnpWHq16TLsu5sJeK926rALXRyRkCi+TBjXzA
         n+XSH+k5EMt55sq+bgC72ITijmQqRwtD02LeF49iAyxJMkupJNdXw8Q6T6rsgLZe5v6c
         v6Yg==
X-Gm-Message-State: AOUpUlE29a5zauT71t31Q5xv9j9W/cErIjCUPz8bFfc3mguFKXlbK0Hy
        ZXmZKVpZ1u+WDC4mg7CEyhFyMA==
X-Google-Smtp-Source: AA+uWPz7TlOZp/tUQOjm8R9P8CZVtiqrjZvWZABnvvBzUz2TYqWx7ZblM9dc7tVuqvb5ueDtsTT6CA==
X-Received: by 2002:a63:c50c:: with SMTP id f12-v6mr87199pgd.88.1533676729111;
        Tue, 07 Aug 2018 14:18:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v4-v6sm2382904pgr.36.2018.08.07.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:46 -0700 (PDT)
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
Subject: [PATCH v8 4/9] crypto: hash: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:38 -0700
Message-Id: <20180807211843.47586-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro), along with a few other cases. Similar limits are turned into
macros as well.

A review of existing sizes shows that SHA512_DIGEST_SIZE (64) is the
largest digest size and that sizeof(struct sha3_state) (360) is the
largest descriptor size. The corresponding maximums are reduced.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ahash.c        | 4 ++--
 crypto/algif_hash.c   | 2 +-
 crypto/shash.c        | 6 +++---
 include/crypto/hash.h | 6 +++++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index a64c143165b1..78aaf2158c43 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 {
 	struct crypto_alg *base = &alg->halg.base;
 
-	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
-	    alg->halg.statesize > PAGE_SIZE / 8 ||
+	if (alg->halg.digestsize > HASH_MAX_DIGESTSIZE ||
+	    alg->halg.statesize > HASH_MAX_STATESIZE ||
 	    alg->halg.statesize == 0)
 		return -EINVAL;
 
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index bfcf595fd8f9..d0cde541beb6 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct alg_sock *ask = alg_sk(sk);
 	struct hash_ctx *ctx = ask->private;
 	struct ahash_request *req = &ctx->req;
-	char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
+	char state[HASH_MAX_STATESIZE];
 	struct sock *sk2;
 	struct alg_sock *ask2;
 	struct hash_ctx *ctx2;
diff --git a/crypto/shash.c b/crypto/shash.c
index 5d732c6bb4b2..86d76b5c626c 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -458,9 +458,9 @@ static int shash_prepare_alg(struct shash_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
 
-	if (alg->digestsize > PAGE_SIZE / 8 ||
-	    alg->descsize > PAGE_SIZE / 8 ||
-	    alg->statesize > PAGE_SIZE / 8)
+	if (alg->digestsize > HASH_MAX_DIGESTSIZE ||
+	    alg->descsize > HASH_MAX_DESCSIZE ||
+	    alg->statesize > HASH_MAX_STATESIZE)
 		return -EINVAL;
 
 	base->cra_type = &crypto_shash_type;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 76e432cab75d..21587011ab0f 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define HASH_MAX_DIGESTSIZE	 64
+#define HASH_MAX_DESCSIZE	360
+#define HASH_MAX_STATESIZE	512
+
 #define SHASH_DESC_ON_STACK(shash, ctx)				  \
 	char __##shash##_desc[sizeof(struct shash_desc) +	  \
-		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
+		HASH_MAX_DESCSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
 
 /**
-- 
2.17.1


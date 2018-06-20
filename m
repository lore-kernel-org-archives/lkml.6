Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5420C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C8F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2z0MWfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C8F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFTTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38632 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeFTTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so256958pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7q4RlxtT0D8rqoeu3p8ZiPTEehwJx88+A2+6N5Izt8=;
        b=W2z0MWfpICqSr2ejWOQQjm3iQrCNhC2ZN/ZJBDD0m2T7O8MRH/U5uZnRxzTXbbgGiC
         F6Npt3S9UFE+3p41Pp7mNwQ9JcEXvlEkSMrPrp8hf1djbeuA2teSNSfXJ8ztLY0lqhLg
         gmY1eHzqQ+cLtsLds7dni4yT6RSEsJ9gt0NlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7q4RlxtT0D8rqoeu3p8ZiPTEehwJx88+A2+6N5Izt8=;
        b=UntkT3tYpk3nKcbrdcXfuBKtebUoxBfXSyyxKvRIOBgqX8s5tLo/tm+q/w0AO2vze0
         oENGPLeb92fsv+wkpDfn5fbwwRvfKvOYrl3Ygl7uZT3i0ztu/JiI+ZFifnxh5DTDv0HP
         i3f9L1lLUgv5NGq8Latuxs4DVuUDB3ATstJF990HUxDynvVKyixEdR6QgbY/+CjGhbwB
         MXNFrUE1G5o2CG6/SwVfQ8w9vcMoVhGAXGnrQ8i0EJBSEL4NpkZMaoUEFw910Tre1N+P
         ul8Ck6j/lsw+hmxeLfDDeYk5N0PMLtjaiNrCrGKD0Zk1w8gvc4PPhqXIsHJ9bVX26A+O
         ij5g==
X-Gm-Message-State: APt69E0X/oZXRlTRgQxi0Dhp9+gCJECicudvhcIyn7mG9bpIwULnkSPu
        CK/XxwnsZF5PVebdyhFxd7RWng==
X-Google-Smtp-Source: ADUXVKK09Rel+csT2wZrG7q8kQXXXJD+aAVAQ9kB8m7MmPo3U6ceQdUHM32yEb3GtvSEmveOj86rcw==
X-Received: by 2002:aa7:8058:: with SMTP id y24-v6mr15456127pfm.148.1529521458271;
        Wed, 20 Jun 2018 12:04:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h78-v6sm6298771pfh.141.2018.06.20.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] crypto: ahash: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:04:00 -0700
Message-Id: <20180620190408.45104-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
introduces max size macros for ahash, as already done for shash, and
adjust the crypto user to max state size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ahash.c        | 4 ++--
 crypto/algif_hash.c   | 2 +-
 include/crypto/hash.h | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index a64c143165b1..6435bdbe42fd 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 {
 	struct crypto_alg *base = &alg->halg.base;
 
-	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
-	    alg->halg.statesize > PAGE_SIZE / 8 ||
+	if (alg->halg.digestsize > AHASH_MAX_DIGESTSIZE ||
+	    alg->halg.statesize > AHASH_MAX_STATESIZE ||
 	    alg->halg.statesize == 0)
 		return -EINVAL;
 
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index bfcf595fd8f9..8974ee8ebead 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct alg_sock *ask = alg_sk(sk);
 	struct hash_ctx *ctx = ask->private;
 	struct ahash_request *req = &ctx->req;
-	char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
+	char state[AHASH_MAX_STATESIZE];
 	struct sock *sk2;
 	struct alg_sock *ask2;
 	struct hash_ctx *ctx2;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 308aad8bf523..b9df568dc98e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -64,6 +64,9 @@ struct ahash_request {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define AHASH_MAX_DIGESTSIZE	(PAGE_SIZE / 8)
+#define AHASH_MAX_STATESIZE	(PAGE_SIZE / 8)
+
 #define AHASH_REQUEST_ON_STACK(name, ahash) \
 	char __##name##_desc[sizeof(struct ahash_request) + \
 		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-- 
2.17.1


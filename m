Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9992C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC920C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fyt4rNCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDC920C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbeGKUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:43:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33994 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbeGKUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so3221678pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3HM8Tth/zRydJwOd6Lp6hlKsvHw6H8gx4o1bYaHJJ4=;
        b=Fyt4rNCbhYFb6mmlLsGJ3T2nFWu7xrk5MFVhAwdDwtUS3hlgwOvmSCRuRPrwAWtdIU
         FtbyVQzjhGUBpl6YCiB5swRpEMqPwK8S+RhvUtsGoxFoAQMb5Dkj4yVyewZVwlW/Bf2e
         u4jw0aBjKBaGobAnx+FjpulqXn93DgerkvnOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3HM8Tth/zRydJwOd6Lp6hlKsvHw6H8gx4o1bYaHJJ4=;
        b=LfShdzxD0Ol9MmXhzn2FxSo7ZZ1g9tuGi3G4vrv3610BFwwT5M7MBwEc9Rz6t+X+Ub
         RQ4U/dVVqv6Tct5EkJw5b4JuL8bGTCnRu/+LGK3KqEZ9/NmXaMxbQ80BIvBybdZ+JsP9
         htVPoxXknw2TZL8Fares8Wo8/jUGJJ2OUdsKmlJVHlpgeFHKifJjb8AGYG+Ob0Tk8i6W
         vsM2z/ijFkAUN58Y6jU9at6wXeI28cuWabPCDeyDl05lUS0YfSZbEb1l5Zk1SxYgXpU3
         FytG4hDS7AUkOeblGrYy/gEgO0RgY3lM67wht8IYmW5VcT4+EgO/InVlVUjMlUsMc6dQ
         RcjA==
X-Gm-Message-State: AOUpUlGOgB0q60tjX+ITjoavvSAr+g/fwY9Jd6fpFHBW/ItSPb+KCfIM
        HnVWButxm/wJ80V9JqidGrBj/Q==
X-Google-Smtp-Source: AAOMgpe5xznaPEP6sHVjweSvdZLFYoKgTDOFkIDxYRdSpElcGpB3kBOlw7H2yYKMt7Mp/sLjSdubmg==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr131043pfk.191.1531341391527;
        Wed, 11 Jul 2018 13:36:31 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d72-v6sm7771278pfj.115.2018.07.11.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/14] crypto: ahash: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:10 -0700
Message-Id: <20180711203619.1020-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
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
index ae14cc0e0cdb..4fcd0e2368cd 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -64,6 +64,9 @@ struct ahash_request {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define AHASH_MAX_DIGESTSIZE	512
+#define AHASH_MAX_STATESIZE	512
+
 #define AHASH_REQUEST_ON_STACK(name, ahash) \
 	char __##name##_desc[sizeof(struct ahash_request) + \
 		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
-- 
2.17.1


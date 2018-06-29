Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F50C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6868827746
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MkAQPvaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868827746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935819AbeF2A2v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:28:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40668 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeF2A2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so3355950pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FLR47NZKUpOfOHNU+o+a5PLOZJlTKUqZN/VmdUBfgs=;
        b=MkAQPvaqxyGks++34Jvs5iRnMVknuigdmi6qgS6qZsSecxqqSzmSqSDewi/i2++CPW
         Z9atPQ6gW6YyDeU1F/EsAcR3Vw2iE+0Mu+x55S3msanXqW9mc07xoEcmCRy2TTB9mSjf
         HbKmzYeEUOfrIxpnZJMmceEIkvjUwZOX1OjMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1FLR47NZKUpOfOHNU+o+a5PLOZJlTKUqZN/VmdUBfgs=;
        b=RvbLoQr3dR/a376086OaZZjHGQh1b0xiks9hw2B/fCumNeJmLAA+XjDESgwflF42N6
         rhwxf9x1xc6EPk7RbxfuGtNWiREXDqbbK6DpkFArASTIpUn8NVt0NAqvFqeq7YHriLKB
         e2K74bf7BwZqqtxYUifSe894Z3cpafbFultyGKq6hEHFz/go9vSc0Hhj++uUCa0wq2Gx
         iKQQ5seeg2+qBgBz/1GdpqBIhZpRUhhYcUXLTpkrvXH1U0uRhcLDJVhwXGQAWe5eoVn5
         yLVWh8F7zx7T8uZz3s9DT7lqZS0pCnIgNySjTUCwdGs+T5UmZDhIhtLqXAtIOv4rB6Qx
         q82w==
X-Gm-Message-State: APt69E3nxrH9QHBicMGL++idFoH76ReX2Yr+Vrl22EQUiZnJ+qhpBFRP
        c3g+iwaw2Ioq4SPnmwQE3gg9FA==
X-Google-Smtp-Source: AAOMgpfqKh/DeqajN1MA0ClR8XN59h8H9cvpsI5D+gyzFQgoB4+aaUKl1quIavGDKI7keB2pKKcciA==
X-Received: by 2002:a65:4304:: with SMTP id j4-v6mr3102693pgq.109.1530232129660;
        Thu, 28 Jun 2018 17:28:49 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 74-v6sm16771187pfj.127.2018.06.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:48 -0700 (PDT)
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
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] crypto: shash: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:37 -0700
Message-Id: <20180629002843.31095-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro). Similar limits are turned into macros as well.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/shash.c        | 6 +++---
 include/crypto/hash.h | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 5d732c6bb4b2..ab6902c6dae7 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -458,9 +458,9 @@ static int shash_prepare_alg(struct shash_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
 
-	if (alg->digestsize > PAGE_SIZE / 8 ||
-	    alg->descsize > PAGE_SIZE / 8 ||
-	    alg->statesize > PAGE_SIZE / 8)
+	if (alg->digestsize > SHASH_MAX_DIGESTSIZE ||
+	    alg->descsize > SHASH_MAX_DESCSIZE ||
+	    alg->statesize > SHASH_MAX_STATESIZE)
 		return -EINVAL;
 
 	base->cra_type = &crypto_shash_type;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 76e432cab75d..804e87a9510e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define SHASH_MAX_DIGESTSIZE    512
+#define SHASH_MAX_DESCSIZE      512
+#define SHASH_MAX_STATESIZE     512
+
 #define SHASH_DESC_ON_STACK(shash, ctx)				  \
 	char __##shash##_desc[sizeof(struct shash_desc) +	  \
-		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
+		SHASH_MAX_DESCSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
 
 /**
-- 
2.17.1


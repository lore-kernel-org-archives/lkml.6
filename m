Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B281AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6688B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIu6JHIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6688B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeGQEwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41529 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeGQEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id c21-v6so22759102pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrCDbQt0h3SDwmF/v9IF6YKRxfzI15nnHqkP77JIozM=;
        b=VIu6JHIPql6GKegNQ67lMUlfJMf+R4say1sJ6uTXDBx3SmKoGMPTiThbqVRCDjjDNC
         Pz4WoRC5pCTIJMC4PujEsP1RjSDW0KtfzBsQSOWVhEMQpLRklIvlnjrihsEmnBflz8cd
         /y2dDzos8A/rpgoM2IzBkaDpMm/dCZ41qNrPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrCDbQt0h3SDwmF/v9IF6YKRxfzI15nnHqkP77JIozM=;
        b=uNIEAw7OC5ctcm0YAAVOJXEBFZEljVW6lj78/25jmcUk0y0Ky4VUdtziiw5l3RuSvC
         6D78Bc3DcNt77142+sKKtc8vw2N5dJCgLJCvzv61EiyzEPIfFYVxep0i3O8uY9Y3uqIm
         4Cj2S0HbFS4dAj+ofcfCUu7kzTRhG4TnMp2WHZ5SACzGctla9gqedu9SX9UGi8aDCiO6
         izUaDZlmoMj3pbqE+HAGRGp7/qOFukKa1wm/No29vtCZi8kAWwMtmYbvTrwAtSjo5MLR
         Ifzk4RbOP2jP+s5WhqFrs+cYzrTphGST34DO2GKXDSMZYuuo+0+fOEQZmPciZrPHr5Vt
         0O/A==
X-Gm-Message-State: AOUpUlFmK644bwPJiVId0OKs1V3KuVTKQmh3loLg05+ZstIpquXYZ04C
        t0sEFQHZuWE1XJTx8BA2JWRfDg==
X-Google-Smtp-Source: AAOMgpfccYhXcA4RF9140EVHuPnm4MbMEzyCiRAD+qMqvKDqWssor+a4TgIqt0D2eGplvsV29PJCjg==
X-Received: by 2002:a62:6b44:: with SMTP id g65-v6mr17570pfc.226.1531801323844;
        Mon, 16 Jul 2018 21:22:03 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v6-v6sm96483872pfa.28.2018.07.16.21.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
Date:   Mon, 16 Jul 2018 21:21:49 -0700
Message-Id: <20180717042150.37761-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this caps
the ahash request size similar to the other limits and adds a sanity
check at initialization. AHASH_REQUEST_ON_STACK is special, though: it
is only ever used for shash-wrapped ahash, so its size is bounded only
by non-async hashes. A manual inspection of this shows the largest to be:
sizeof(struct shash_desc) + SHASH_MAX_DESCSIZE

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/shash.c        |  9 ++++++++-
 include/crypto/hash.h | 10 +++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index 8d4746b14dd5..e344560458cb 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -355,6 +355,7 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
 	struct crypto_ahash *crt = __crypto_ahash_cast(tfm);
 	struct crypto_shash **ctx = crypto_tfm_ctx(tfm);
 	struct crypto_shash *shash;
+	size_t reqsize;
 
 	if (!crypto_mod_get(calg))
 		return -EAGAIN;
@@ -365,6 +366,12 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
 		return PTR_ERR(shash);
 	}
 
+	reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
+	if (WARN_ON(reqsize > AHASH_MAX_REQSIZE)) {
+		crypto_mod_put(calg);
+		return -EINVAL;
+	}
+
 	*ctx = shash;
 	tfm->exit = crypto_exit_shash_ops_async;
 
@@ -383,7 +390,7 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
 	if (alg->import)
 		crt->import = shash_async_import;
 
-	crt->reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
+	crt->reqsize = reqsize;
 
 	return 0;
 }
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 4fcd0e2368cd..2181fb38eab9 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -67,9 +67,17 @@ struct ahash_request {
 #define AHASH_MAX_DIGESTSIZE	512
 #define AHASH_MAX_STATESIZE	512
 
+/*
+ * HASH_REQUEST_ON_STACK must only be used when wrapping shash (i.e.
+ * allocated with a CRYPTO_ALG_ASYNC mask), and is generally discouraged
+ * (just use shash directly). This is really only ever needed when using
+ * scatter/gather input sources.
+ */
+#define AHASH_MAX_REQSIZE	(sizeof(struct shash_desc) + \
+				 SHASH_MAX_DESCSIZE)
 #define AHASH_REQUEST_ON_STACK(name, ahash) \
 	char __##name##_desc[sizeof(struct ahash_request) + \
-		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
+		AHASH_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct ahash_request *name = (void *)__##name##_desc
 
 /**
-- 
2.17.1


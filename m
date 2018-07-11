Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9926FC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C06220C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f6XSLcCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C06220C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbeGKUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34232 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeGKUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id e10-v6so19141784pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nat8iTKWvSD4ychV4rEE2eDXAa7pi2+ftb1Ei0FCzN0=;
        b=f6XSLcCZzFFkl9VmUGai36J/3eribp7AA+EMJa/1Z9AL8S9bJqwdX7dDFjTD9Ehhq3
         DS7Sjyachtua2DsHkbXqCY73mGKRtPVwdas4hNmcHFf5NJHp0EGecjjvmxUWweDtk8kc
         WDtgCunxKER70BBOIo6B0tILqYoJubg20KZ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nat8iTKWvSD4ychV4rEE2eDXAa7pi2+ftb1Ei0FCzN0=;
        b=bBC6U5MunSE6kK6bG88nxeAlCetlnkgHLpAU1DCLrm7OCJci7U95LQYFrx1FDBH2Ol
         MnJH6coMDkSm3E8v4IT/Kmfp1bd2eNxPU95vlu8uN0w5GSCvA/l3kfCI0C9dTKaf1QFR
         WmGYj7GatWPDlrsvjAVnOQFEuYdjhziG6eJd14bqaa1EXAJrD9PeFeeP+UKuGIZ26jql
         8Y62kBIJRMgcgKjkXdTai6c6SXR1dQD31OTemG7WcnyObG51Gc6+ZK1uxGZY5DaK3CRN
         izmEZQX6iCJlICMw6DDLVpTCaIzJEg72+OEDp783DoVR3Pt844Gf6Mv0IM+Rw/DbNWgn
         oS3g==
X-Gm-Message-State: AOUpUlEvIYeXISBHhy7i3XlvqgGEblb4ryge8cvBrsKqxcuIuFvNWam3
        QvmSy0BBNYHNQ8yKlfMR3Chx5A==
X-Google-Smtp-Source: AAOMgpdNPHZqs+Qc80qSqYJnRfArvvxMggIqsQbRZi4pfhdUB/UAp+gsXzKaqx5vXS6pS4uhXN09ww==
X-Received: by 2002:a65:6645:: with SMTP id z5-v6mr126268pgv.71.1531341392429;
        Wed, 11 Jul 2018 13:36:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 84-v6sm34234208pfj.33.2018.07.11.13.36.27
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
Subject: [PATCH v4 12/14] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
Date:   Wed, 11 Jul 2018 13:36:17 -0700
Message-Id: <20180711203619.1020-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this caps
the ahash request size similar to the other limits and adds a sanity
check at registration. Unfortunately, these reqsizes can be very large.
Looking at instrumented tcrypt output, the largest is for sha512:

	crypt: testing sha512
	crypto_ahash_set_reqsize: 528
	crypto_ahash_set_reqsize: 728
	crypto_ahash_set_reqsize: 808

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/hash.h          | 3 ++-
 include/crypto/internal/hash.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 4fcd0e2368cd..9290120536cd 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -66,10 +66,11 @@ struct ahash_request {
 
 #define AHASH_MAX_DIGESTSIZE	512
 #define AHASH_MAX_STATESIZE	512
+#define AHASH_MAX_REQSIZE	808
 
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


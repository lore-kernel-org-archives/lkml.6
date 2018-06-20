Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF5C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A3208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gzzcO76V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5A3208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeFTTGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:06:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46389 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754756AbeFTTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so266727pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7XTHzlvX++hhCzFEcBaneBwfciVetek5Jcpe8JMVfk=;
        b=gzzcO76VOecwuPWc5PQhoVa86Y5OSnO0WwFsgjL5lg2Mq1Gt/B+ZnxeGMlJK5YYYzQ
         GSJIV/pdrafJmP8F+XH8pFvO+E+UzjTUuRQKtMSXNO0KGkA82CNKqInU27rh8iQ5E/eB
         DPifElPJGJhm48vKrQOXELGe2uquOE0j2RRls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7XTHzlvX++hhCzFEcBaneBwfciVetek5Jcpe8JMVfk=;
        b=cH5e14CKPb7sY8Bew7DFlZ1qpDTfwMDiRiOWNuHPjXJGpiW3BahZ+8kRgoLieU3ifg
         qxebSV/0tB+2n2JWobRm4nfdgaSU6B2y091th0Fn3NUOnxBU8fZAccass8m5ooTECNp/
         JuXxaLdKYduOBLjk5E2cKERhv5VVDib9v/w1ncw/63aJ5Ao8M5KWykChuVYiftvkWn2k
         voszUITkjfVcX9bWBf3qgV44mOxdz/R+f8dzWUBQPFj5FKK24F3jzkc34SpxwEnwwq3z
         MoV+NHIbRtOCFb0ivmNHTT8e6svTI4ZTcr/wN6xA5ajCj3PUYmEnUBYySzkJwmnv7/3J
         y21w==
X-Gm-Message-State: APt69E0HCi86eXLVhe3LT8cArKDIbxTzdvYGhzW58xcqOYffIIH0QdJ3
        h+zNBVjo4PYuw8AdGGrrfNMA4Q==
X-Google-Smtp-Source: ADUXVKJJ7ujQUSZrQOtRkEzKltVNhdJO/NW14MrQ65nQCtTJ2P1+NYrtfaSry0094ZGyuBsZx3dCpg==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9-v6mr25589394plb.245.1529521466346;
        Wed, 20 Jun 2018 12:04:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w11-v6sm4403077pfn.71.2018.06.20.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:22 -0700 (PDT)
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
Subject: [PATCH 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
Date:   Wed, 20 Jun 2018 12:04:07 -0700
Message-Id: <20180620190408.45104-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this caps
the ahash request size similar to the other limits and adds a sanity
check at registration.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/hash.h          | 3 ++-
 include/crypto/internal/hash.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index b9df568dc98e..7d62309baf0b 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -66,10 +66,11 @@ struct ahash_request {
 
 #define AHASH_MAX_DIGESTSIZE	(PAGE_SIZE / 8)
 #define AHASH_MAX_STATESIZE	(PAGE_SIZE / 8)
+#define AHASH_MAX_REQSIZE	(PAGE_SIZE / 8)
 
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


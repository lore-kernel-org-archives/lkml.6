Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE62C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D822F21531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eGPrL4Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D822F21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeHCApW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37682 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732322AbeHCApV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so1894825pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=eGPrL4Iqvi3fpF1UY/SdATbOG42TY0YaGFjLLGUxOxa7eMQXe+hgudakAAfjPgcNX7
         0zhtrJMEJmCqEGxJEoF3x/apLx+ZXnGBOE7RpL6dY57u0asc22zOwbYMf3Djpurzvmmb
         p4Sc0ZPKzdhueTt1z0KUh54g813kl0b4f61qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=A0lgPOQMY62eiAfqLrn1m7EXOubaQffEYdu1hO4zZpTMQtsjXa/4ZBhM2Dcx0o1kBJ
         czGgDy8assORYL8StnhDnpN2b+5xmFJqUx4TE/aApe4y9yNq1YLHf6b+wkb6U9jFOXS5
         7lqJy6HG1uK8LXNYm4+cpgGHIPVMhPvOPBYNqokvCuegUgIphMNgHzL4FaFjp292vC12
         zQ8wNqDRNMSGKPgzzYgVESvv+hejGTQyuAH9p0N4jG3A2+OjfGTAS+qICw6ZcxYsCoMi
         PVY4K1Z01eyGozrqpnYzP9K+MRLTTi7DKSfO9rIIe7PqzoeSiVnLAb6eiSoFy8FK/7Xp
         PcfQ==
X-Gm-Message-State: AOUpUlEsFBxLH3k/Q4+z4Bkkc9pTo6kcU1jJRSkvtV4i+tG22Sy5aPcm
        gKFZP5KdHQWRtjjTM48lwbKV0w==
X-Google-Smtp-Source: AAOMgpc/uRMA4sPxhEFJiLaj5SOCRI4SkxWo1T6OF/GJjTPO/dJWYQNE4mYnveDfWTGqXs7TfoSZAw==
X-Received: by 2002:a63:314f:: with SMTP id x76-v6mr1184591pgx.373.1533250325177;
        Thu, 02 Aug 2018 15:52:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n26-v6sm2848324pgv.78.2018.08.02.15.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:52:01 -0700 (PDT)
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
Subject: [PATCH v7 9/9] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Thu,  2 Aug 2018 15:51:52 -0700
Message-Id: <20180802225152.19194-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802225152.19194-1-keescook@chromium.org>
References: <20180802225152.19194-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
caps the skcipher request size similar to other limits and adds a sanity
check at registration. Looking at instrumented tcrypt output, the largest
is for lrw:

	crypt: testing lrw(aes)
	crypto_skcipher_set_reqsize: 8
	crypto_skcipher_set_reqsize: 88
	crypto_skcipher_set_reqsize: 472

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/internal/skcipher.h | 1 +
 include/crypto/skcipher.h          | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index e42f7063f245..5035482cbe68 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -130,6 +130,7 @@ static inline struct crypto_skcipher *crypto_spawn_skcipher(
 static inline void crypto_skcipher_set_reqsize(
 	struct crypto_skcipher *skcipher, unsigned int reqsize)
 {
+	BUG_ON(reqsize > SKCIPHER_MAX_REQSIZE);
 	skcipher->reqsize = reqsize;
 }
 
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 2f327f090c3e..c48e194438cf 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -139,9 +139,11 @@ struct skcipher_alg {
 	struct crypto_alg base;
 };
 
+#define SKCIPHER_MAX_REQSIZE	472
+
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+		SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
-- 
2.17.1


Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BCC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7023208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XoJKT0hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7023208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754965AbeFTTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:05:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36291 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754797AbeFTTEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id a12-v6so258660pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKyIVRr8+ICLpC4JInXUgLaGQojITv7p61XOFNO0BZU=;
        b=XoJKT0hS5T9iQ/8KrBq9m0KJmPh49hioryUDDy+cFEEWOiYt6MpLpXOWoNsAPMjiN8
         +A+lP5/nWCMTAdTmtzFu1oN0O6Fafw09tmZggXjvzHgNHfATilDVKQRIvnhk0hEJ8jvK
         etYQqc7EulfIXJA/7rTwZWqXG3kH7YOLCBD1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKyIVRr8+ICLpC4JInXUgLaGQojITv7p61XOFNO0BZU=;
        b=MbO8yaqE+C8A8jVKobMoESTTYtptimwi4DFlk3c2zKaRw4tHH6/9603dy+NNZBkpTl
         D/BuizuS6T4T3tvsjVdQ3v5mZsCgbL9I6HcUe+/EfP7OM54rvb699UyZqhLQg5afNqSw
         Qb4T7NIgdgbQcJFfaPzDI3raqARy6wcLS7qozrThsOFiRW6N65ipjjvPc9AhlliUazPJ
         uBqraYQMCFfYLSfvXi7WxRlMHs7xkk6glR1i9gZM4NeZffAbWa7wwPna/mPYJSZofaUi
         vSD9PDfvpwbiyCYtXi99cqOFcyGGyQZg/EMpGHb4RCayO/Iq2NZt+dFxZMhRg9hwTRVH
         KkgA==
X-Gm-Message-State: APt69E05k9hMTuaKlznOPi7b6JiD3NGvnqPGwh1qimrv5TB9zY4c3vnr
        DmFrulSQJskgKpqZg+DS+UJsz319SQw=
X-Google-Smtp-Source: ADUXVKLcenlKNcmHVjLubCj/4A8sqsyfH+EHc8VkMCQQEIfCdxY+O0RqOM2GoF0ySoDxxigs00b6Ug==
X-Received: by 2002:a62:8a83:: with SMTP id o3-v6mr24265418pfk.12.1529521469756;
        Wed, 20 Jun 2018 12:04:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x2-v6sm4589892pgq.33.2018.06.20.12.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:27 -0700 (PDT)
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
Subject: [PATCH 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Wed, 20 Jun 2018 12:04:08 -0700
Message-Id: <20180620190408.45104-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
caps the skcipher request size similar to other limits and adds a sanity
check at registration.

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
index 2f327f090c3e..25294d0089b2 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -139,9 +139,11 @@ struct skcipher_alg {
 	struct crypto_alg base;
 };
 
+#define SKCIPHER_MAX_REQSIZE	(PAGE_SIZE / 8)
+
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+		SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
-- 
2.17.1


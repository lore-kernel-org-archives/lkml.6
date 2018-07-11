Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F53C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9120C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NW7U48sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9120C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbeGKUml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46516 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390331AbeGKUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so19127248pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=NW7U48sxDmiQ8pX3SOZwI10vZPpyQfhJ8ZJnnQ8uq01C90eDMBj7PF5fD4x3CKbq0O
         mbHK7+YNxptMgbhT+7AVUTsCVwDVMMGY60UlXO4i9/K08LQUXWOMmxBpWdGQJEYL/qFf
         NtoDQJxE7XXbFzlPV+gXyCQRuqWcZWbFVgcbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=R4VWDMWj5GUPUZZ1PmYdvAPWzyFIaBD08CVNq5xZvFkES8OLl8eu6o/gTewimcmsVl
         Iqa2rYNVQn6IoFIyBu21PdwFx1Y9D1zDo0YvB8eVsNpupEgD84YRWPWj8KKEkPypB1Vo
         PdVszRhKdwga1EmXwqAibIC1WKTH4ygE7pc4eeWNkZNhAT+Jf+/YRYnZW+i87cbJe0kB
         b2eJYxKx8oJVFjxTbti9JheKjAoEK2abv1GBnm5vfESnLlXpnt2Ao/Hc7md71U3okNeQ
         OKN/SLEA8Y+prgdZReXeiexbedqEEhRDjRWN+au1RAaolDj5v73hKeJttKm7a6UAUddc
         8/CQ==
X-Gm-Message-State: AOUpUlEKFPw+KHqr4igHxF1nvq1dLBRKX+exWHywukru2m+O7U2tIxLS
        TW8Hglecp3Pg0AmI7cr8dNOVjw==
X-Google-Smtp-Source: AAOMgpe9F+WEAHsUt3SKq15qbyYR7eQihyh2YUrdzo9zjliNQNvEaQUYGfMn9T00d1rfx2YP/3AoQA==
X-Received: by 2002:a63:7847:: with SMTP id t68-v6mr116587pgc.329.1531341397477;
        Wed, 11 Jul 2018 13:36:37 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z76-v6sm915707pgz.16.2018.07.11.13.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:35 -0700 (PDT)
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
Subject: [PATCH v4 14/14] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Wed, 11 Jul 2018 13:36:19 -0700
Message-Id: <20180711203619.1020-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
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


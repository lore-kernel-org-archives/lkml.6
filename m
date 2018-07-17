Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB22ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3762208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQQKOAGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3762208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeGQEwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39008 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeGQEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id j8-v6so2737482pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=XQQKOAGqhVuqUwnAwIgQbZrwv28UgS7Du+ycYOqxDw2E/J/M9bUGXt9VitsDDrMonI
         VSSea6IYFmm2OxUaViLyYRDO04nelWXRXxin29NYNtqGJGY4RE8AmdGf/L2Mu0p/2A6A
         Ax3FuOMPHl/Hkz0biEofkxEm/W6wKvPWTKfYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xi1UiijgPtH3bEbgxLJTLT+H3zXPa7fDlbmxyBVC5QY=;
        b=QLrOvYH5sm/SXIBIbcnw+M23oPm7WuAnqqNDdqF1F5I55FX5QEZEpIAn/bRseDy8TR
         DRACJGNXDzaHdBUe1HZ6d//GmKFhaHkdWr7zi+uBGQQ3vMpsSOTUTvWA40X6kaS6IpRh
         NHfj080OfIAZSoveSK1Qb+6DTxzoLCejYtpyztFxC7xwHODrUmynS6QWPNujqhvOMKiy
         q7t44SOMn5DmSqypcW4wR5Z5/1TLwZbwJL+1P7jfMIheMebZu5qeUmh8covnatqq+0QC
         b4gSIiOKebxk2mkFGLUfNcUBzJAzVsC9LK7M7cfwSo1/pf9pCB3R7fbenodMHUgKzlbg
         XwRg==
X-Gm-Message-State: AOUpUlFfw6DwfkLb7F12SDy+Fb2Pb0EKVBpDbhg2zoHMZrAnxcm0bivK
        4RbyfwVE6TSSZahP56Ajl7wMVQ==
X-Google-Smtp-Source: AAOMgpd0LE11QA89hxd/yxkYSD8CmsgFpQ1UOsTe5cjrXHUhD4GynG1wNk8unt9FKlg7ShqDQVrWUQ==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr14207pgv.394.1531801324742;
        Mon, 16 Jul 2018 21:22:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p11-v6sm72711991pfj.72.2018.07.16.21.21.57
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
Subject: [PATCH v5 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Mon, 16 Jul 2018 21:21:50 -0700
Message-Id: <20180717042150.37761-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
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


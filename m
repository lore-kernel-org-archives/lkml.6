Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A17BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D62075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ThtCkZ2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6D62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeIDWmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:42:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44247 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeIDWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:42:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so1998341plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Grbq2zQ3A4RhONhGOZUwbxnQrSQ434BRDzK8+t1CT3o=;
        b=ThtCkZ2YkCZaLcEhmQ/Zr23+uw5rXcjk2HmjnCpWaiQIvxg13hkLbzdjgfEhbUn/VS
         KesgmKVo6v/JS1wbMSP6olTM9AOJEW9OnZQ1IzyfkVU9izj1FA/euGHLuooSpp6UR0if
         EN8fIByydxDx3Gu6VCAzBFpe2qp/cwtkiFyd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Grbq2zQ3A4RhONhGOZUwbxnQrSQ434BRDzK8+t1CT3o=;
        b=oJdcOppQ/lbUr+rFu4+JLYB0vca7AxbCY5AmpDQKjPoHth/Lqtf7ExqZLhEwuuUSuR
         Tjkthl3IR0cZGQYKAmlFmsPHcgJ5yAJxqGSPobQxhK/JmH2KoCVDyeg6ifJ1ANj43tks
         +jyMQdDZQ24ondjBQggyX0tLgFT8V1Qw2Nj7rMGXnD2na5KODiLHVrbxrmFY6nWKYESr
         KUoy1q/6g7nYADm+yz4J0R6wkqK+hGfa35kw2J8HjanWkqm4e0hQn5DTQg+N+NrDXFv1
         woOW+FXOUwb9L5OJ6mHaBArXlRQQEgV3z+S+g1XabLlQUbwVDg8+ZinseTU1+t/wGq0R
         MT6g==
X-Gm-Message-State: APzg51CuHakbGA0rQGTSPcM0YMF3wf1mtuxNesSveIjhefsyxes/rgNn
        cFIsBUJgabBbNZxEZNrRe797GA==
X-Google-Smtp-Source: ANB0VdZqhIyxgVgJ/wEoDsmFr44ZGNjpNJ2Fg7Mg6OTMFLfOQwhIwzN8isNxfWlaSEQ0CjFGhfoe2A==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr34176720plo.148.1536084994102;
        Tue, 04 Sep 2018 11:16:34 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r205-v6sm61545336pgr.11.2018.09.04.11.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 11:16:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Tue,  4 Sep 2018 11:16:29 -0700
Message-Id: <20180904181629.20712-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904181629.20712-1-keescook@chromium.org>
References: <20180904181629.20712-1-keescook@chromium.org>
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
 include/crypto/internal/skcipher.h | 3 +++
 include/crypto/skcipher.h          | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index d2926ecae2ac..6da811c0747e 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -130,6 +130,9 @@ static inline struct crypto_skcipher *crypto_spawn_skcipher(
 static inline int crypto_skcipher_set_reqsize(
 	struct crypto_skcipher *skcipher, unsigned int reqsize)
 {
+	if (WARN_ON(reqsize > SKCIPHER_MAX_REQSIZE))
+		return -EINVAL;
+
 	skcipher->reqsize = reqsize;
 
 	return 0;
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


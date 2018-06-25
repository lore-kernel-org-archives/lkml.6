Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A87C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB8926153
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EKf0VPww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB8926153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFYVLM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:11:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45735 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755135AbeFYVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so7013019pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ln4hOEvd50mVl63zM/2x7gZS+5BlOFDWDoaD3SpuM4A=;
        b=EKf0VPwwNq9bbtzU4actzj7SCaF589Q0lkcnZvT2Tl5tHeXj6/NuDwfkjRR4pDx6uG
         WA/z5vo1XlQVwE/6wmOO3txGa+Rme4h1tDPQ6EifRQNwOuWg2HGY61lKciY7FwtQgJwo
         8Y8GI4hlrZn8CErqAJ9s7Ws3jIUDsNGFQwY94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ln4hOEvd50mVl63zM/2x7gZS+5BlOFDWDoaD3SpuM4A=;
        b=mDtHhKLunkmwUkeNz90BcXFJxJ3Hd4dFEIhSiRwR9SAo5zPJ8o3T7y0dqJcmrZ9ANp
         YikmXgiWhTBMjtvzJV3iw5EEHoe4utdu5iBhqtpfqGoGeq4axCoISrZNbqP1WtgTOgrd
         cH1se32I8DE/DaR+Jdx8foclFUcbLk82XKnQM73iNbk/5diswc5pTL46mUIUhSh/u6x1
         Ba7luqjHtgMwIhU0dbCa27ugmEnPBMV2kE9JHTfajUz257UDByX/mlCO0dqAvp3YWLlh
         dZi5oCpZS6dd/75Bg7v1pExNioaseoedSOAI+Oab4lzxcb9RJsTL4/UxaOwRrqRa7JiH
         lC0w==
X-Gm-Message-State: APt69E0W5gsT+CZEhd5kRzAsWfOq0Jcr6obk0hodiAcqvDhYZOCu5FHf
        6Ubzks0TL95iigUfU9dGtdf59Q==
X-Google-Smtp-Source: ADUXVKKf3vLfG1UtT8QvQ+N0UBuCl3xuySvVb4i/1VZlf8O2MYrJnb0+4IzE1AZ9FnsQjUvi3cMjxQ==
X-Received: by 2002:a62:170c:: with SMTP id 12-v6mr3061639pfx.139.1529961048617;
        Mon, 25 Jun 2018 14:10:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m7-v6sm21111542pgr.5.2018.06.25.14.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Mon, 25 Jun 2018 14:10:26 -0700
Message-Id: <20180625211026.15819-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
caps the skcipher request size similar to other limits and adds a
sanity check at registration. In a manual review of the callers of
crypto_skcipher_set_reqsize(), the largest was 384:

4	sun4i_cipher_req_ctx
6	safexcel_cipher_req
8	cryptd_skcipher_request_ctx
80	cipher_req_ctx
80	skcipher_request
96	crypto_rfc3686_req_ctx
104	nitrox_kcrypt_request
144	mv_cesa_skcipher_std_req
384	rctx

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
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
index 2f327f090c3e..26eba8304d1d 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -139,9 +139,11 @@ struct skcipher_alg {
 	struct crypto_alg base;
 };
 
+#define SKCIPHER_MAX_REQSIZE	384
+
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+		SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
-- 
2.17.1


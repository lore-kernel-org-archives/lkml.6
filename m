Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D68208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekfQ+lwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D68208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeGQEwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44279 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeGQEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so16241758pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G4jXL4km6Y/TbO9Is9lhPTxGi63107svAQc+KKpomh0=;
        b=ekfQ+lwuOwRrnWLOlS5JbqOEL7/kcFEdEekNbEdMQ6jjJU1bgyGWwglBvF+1+NcIzW
         nmDKjzRaY5vsWmM5U2l5nJeTrA1VdN9UnZQi7fWLvhJP3eIhBXU6QHTNg3EcSKJ2K3lX
         BkB2aTvMMUGCMFGtzR6hxmEAONYEN+nHQdyOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G4jXL4km6Y/TbO9Is9lhPTxGi63107svAQc+KKpomh0=;
        b=dpCBgzrjR+lr9+Mftfawg+W9k2c2ixyDvxHn98DQDh0bXfdFlLD0Akbk2IjKBpsEqp
         qKQnLBXMUUqu9a+OKqQlH4HXCxv1367ZiJyOXowbQFQZCOXVPVGiqV4kSN6yVivqIKMY
         mLwrbNFD1wH7ML4ZIyliRWxn+gMcR0B3m9km6ZhoU+zpra6fKSEzSTvYsBuuZZh7sWU5
         MjaAlPicUe2AestrjAml/TKZFScabIfcptJKjFUuF36wbDGi/en1pwMdvw8aO8nZIqje
         cS0/wRzic94ucD+aCadnWzI7rHyrmOuIxIkzb0BnvqOLmycVXHggD41lP2MZhDCNujhd
         5+GA==
X-Gm-Message-State: AOUpUlEUlJQztnLhPMaAi1KFdUeHeKqxWR7N7uEVyQKSVff84iI6oswz
        7o9+5pmHfq7IjtCfhQBkFTmjwg==
X-Google-Smtp-Source: AAOMgpdO+iaE2YqDQeIVNG5lJRr3RHeivReZfd73zCvVF4GawhjijH1DEr/yKUFexaJecapxhS0dQA==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr30408plt.126.1531801314635;
        Mon, 16 Jul 2018 21:21:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o27-v6sm19170233pfj.35.2018.07.16.21.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:53 -0700 (PDT)
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
Subject: [PATCH v5 03/11] crypto: shash: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:42 -0700
Message-Id: <20180717042150.37761-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro). Similar limits are turned into macros as well.

A review of existing sizes shows that SHA512_DIGEST_SIZE (64) is the
largest digest size and that sizeof(struct sha3_state) (360) is the
largest descriptor size. The corresponding maximums are reduced.

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
index 76e432cab75d..ae14cc0e0cdb 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define SHASH_MAX_DIGESTSIZE     64
+#define SHASH_MAX_DESCSIZE      360
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


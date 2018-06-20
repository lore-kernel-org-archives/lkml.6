Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BDC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C9C208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZwVgjkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C9C208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeFTTHd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:07:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33891 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754696AbeFTTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so286018plq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hSSQKsxQQI1ld0pzwutyDZPaiNzz1h3Ackual/6AIY=;
        b=KZwVgjkS7JrKQ1TmkqaD5BIZfTtxfHvUDls97SuHTH4mgFxT0kXN/3ZTAZBdgQGQhX
         8c3x9FbFIaenn501OY1khxxBIfuSOLFKvZ8H23nzDKaWSpO1q97a/9nmPZmKtsXgf0QK
         eRFqh5QfLZaQ0F496PkaPNoGHWYuNtwqRVBeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1hSSQKsxQQI1ld0pzwutyDZPaiNzz1h3Ackual/6AIY=;
        b=Zm3pVdcAJx69t9eTodMAvAuJWyGnZrPEzcgmPnYkhZRKsUReJ+HJ+kxPlXSXitGGr0
         ZJz4q9QJGy5cC2gSY4eVE+wKXyhiTSI4xN+E8xlbNV942Q5uOCatpAhAVxb81f5OuwUd
         N5dj1nKPhHuR1qEp6ySHa/rdL5x/SpEEZciBuotk2Hmpz4v8/56a7sAB6E80iYawIWs3
         TgdokWWZK0Ny8Wy64qg5ax4eMF7GszHQ0RuO2TyE/BUQaWlmYwOdZ1wA0fjcY5dESbXp
         wzuPTxGykj5EXKWRg86OweH0YE2jNlWevrsm3Ea9TO0/MQ3H9D0eaaDm3kHDX365pKNH
         vobw==
X-Gm-Message-State: APt69E2U3B1Mr5FFaJi4udUWIe/6lUTUip9dWfRT3OksQrsjb0RL+Vpe
        k+YEmw4rO2mic9a7azTw/4bYhg==
X-Google-Smtp-Source: ADUXVKIUh4rWPS5hDresWBIE8xLG3o1YN0Flq9C6QF8ALYg4ZxPXDNXgwdZDQWZ/2p6hXPhSRjhGrg==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr24808879pll.234.1529521461906;
        Wed, 20 Jun 2018 12:04:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m11-v6sm8023588pfj.25.2018.06.20.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:16 -0700 (PDT)
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
Subject: [PATCH 01/11] crypto: shash: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:03:58 -0700
Message-Id: <20180620190408.45104-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro). Similar limits are turned into macros as well.

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
index 76e432cab75d..308aad8bf523 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define SHASH_MAX_DIGESTSIZE    (PAGE_SIZE / 8)
+#define SHASH_MAX_DESCSIZE      (PAGE_SIZE / 8)
+#define SHASH_MAX_STATESIZE     (PAGE_SIZE / 8)
+
 #define SHASH_DESC_ON_STACK(shash, ctx)				  \
 	char __##shash##_desc[sizeof(struct shash_desc) +	  \
-		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
+		SHASH_MAX_DESCSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
 
 /**
-- 
2.17.1


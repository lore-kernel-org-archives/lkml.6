Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E78C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2074120C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kdF2x9+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2074120C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbeGKUm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35283 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKUm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so3222616pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G4jXL4km6Y/TbO9Is9lhPTxGi63107svAQc+KKpomh0=;
        b=kdF2x9+FeWghYL3NF0CZACHph7t68rYPZSwiOeAtG3KeXXooSNVBLIGJ91Z9ZE2OxA
         ZXAjiGrrgteoFNHTiFCrfhmMuhGzBC7vAQY3sraLPWZCUw2TuwWn2VBO00390E5DHXU+
         R93b6J37idMWtGG6f1SSHd5MHkBhvtrSXQ26c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G4jXL4km6Y/TbO9Is9lhPTxGi63107svAQc+KKpomh0=;
        b=oXBvnSCACrxizjb+8Gv0BRCWgOc3r4vwLmaqjETv6vtnXesbSAAIb3H79W181kygDl
         s1PqRwVBR89D0qgszN8XzWQ9OSv5/E8Jgl4Hb5OgUjnKhnlwHI6AxER1lnrgWBX91/m3
         MF7u76zEeEPFOO1HXbDuHm0ErJAyOCavnKE5m1kqrcA8VfYxuKqnqqZ5kJulkFngJsNE
         XI++iUylEeQNWAz0QEOIkuLaTtqK0BFJ3CsATqzdHpymAyTjXPbdlrgjygHzFeUms1KL
         F9rUnVGWxqbbxmJA6hXyHbcD3C0j+nZCkzVH/sn9AX17c0NIoLVk9izhOHfFPWM3aw7x
         lhOw==
X-Gm-Message-State: AOUpUlFHGQ3y3PZwUYjIbT8oXMUISg+eq9gP6+8PlTrD4strss1rmoFU
        QNtq0womigmObW16EJjF2g3FLQ==
X-Google-Smtp-Source: AAOMgpcB9ApwQg7niGNtHPPsBaW7Nk4lEnCn9T3bilULi8uSpxffb7OjCq/wrpBEFB3ujL65z1JT+A==
X-Received: by 2002:a62:4b48:: with SMTP id y69-v6mr142006pfa.93.1531341384543;
        Wed, 11 Jul 2018 13:36:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o72-v6sm48321089pfk.76.2018.07.11.13.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:23 -0700 (PDT)
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
Subject: [PATCH v4 03/14] crypto: shash: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:08 -0700
Message-Id: <20180711203619.1020-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
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


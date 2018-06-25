Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295072615E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VwFKX9XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295072615E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbeFYVNC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:13:02 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38653 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeFYVKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id d10-v6so7414110plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JyFCExx4YIwrXC3WC/DTpMJFl/TmKZmmiJkqOFCtJTw=;
        b=VwFKX9XRRwMLDUa41wowcrMWTvcaQSC7DgBm38kwP7hmyxIdbcLV/15rEutSjdJWnY
         GQiw7nmkVA+9zMmc8OaWxlRF7qssKO3/Jw7OVR5pmVjwuAaYNevXNfo/ZUij2vVRTZdV
         YHI7vzVrnaNesHDv35dHIfZ3+pIWk44QruInw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JyFCExx4YIwrXC3WC/DTpMJFl/TmKZmmiJkqOFCtJTw=;
        b=HwT6grZL8TYT8Q2yAfcyZudBYOzJtaI1UbJE7g9Vspip6CjvmE7ns5lH6ILpivVfu8
         wIYC9DqVq6/0d42jriMNJauh0nj5vjfdIcVmLOejUP5vs/sYfgx7M4AMYD9sB+Je6MH3
         unB1NGqnBXv9sDwl45tCNlxWSEd2PHYdK1By0mg8OzsGoE+QXJXKwRX4MIvF66zlkIlj
         CUMreFz8sUuTpn0jXxgGxVtU7MrPN5QwBofwdJ8FBaeLM2Lh0ygp3vozwxnjIPBhpsjg
         7pX+2dBThj9fI27aFzEqSB9QPxLvkwwrY07ZGMO5fyQDpNJTTRVbQiUVwA0LkFOPRJut
         4RnQ==
X-Gm-Message-State: APt69E1TGomBF8U5kbmFBJPjMIreS8OBMjA7wtPqAZ+zOOokGy1zIRsa
        zhMB8eyyKlT6p2XHuq3Hm8jHVg==
X-Google-Smtp-Source: ADUXVKJq8AkN2865kdkDXD676d+DukpSBUkGhx/fACzmPQEueFHW2ZEhPgrNX9oRRlXmyGTi2vhkqw==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr13936502pld.134.1529961039379;
        Mon, 25 Jun 2018 14:10:39 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h10-v6sm22118569pgc.28.2018.06.25.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:35 -0700 (PDT)
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
Subject: [PATCH v2 03/11] crypto: shash: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:18 -0700
Message-Id: <20180625211026.15819-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro). Similar limits are turned into macros as well.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
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
index 76e432cab75d..804e87a9510e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define SHASH_MAX_DIGESTSIZE    512
+#define SHASH_MAX_DESCSIZE      512
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


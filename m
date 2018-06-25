Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDACC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F44A26157
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tky8X8wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F44A26157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeFYVMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:12:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40088 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeFYVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so7019752pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0FZrEaIUPJgf66KLv7byNxsLpp5pIqlXlh9kSGp1lg=;
        b=Tky8X8wCcqIIvZI3VRjDkHogeBZh/+26tohzF92fzKwQPlnoNKV+M4UgrGN0qRJqgV
         tnGX7fwfuVggFyTnwa+pjqwyTO6m081x05sGN4Q5+wpevkw31Qxw7WL4c4AX/Q41QWlR
         Z0tvdXNqolBNevUU+l84+AXvYjwrWYO3jCcJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0FZrEaIUPJgf66KLv7byNxsLpp5pIqlXlh9kSGp1lg=;
        b=ghdGlB2X8N4L3v3o4TeuaSYxOFsrF4IrqWhfKPfdtS75+pPzFFcxiYmdS1pFANoX5a
         W7TTf1wCPiOqBgquOivcL4KrKgdaqoqwq3sED4aeWc9BphbMgILfpuH/ePG8j5vIBgAw
         BU1GZY+nZ8u6DNHZ/fxHyCRoVDeEPoQ5UFLZK2N11dP07Ta4yLClhJanc6lEsamcLeRu
         rv3hZbzG9A/AGWf1LpuS5P9IZOWEQwbFMsgkKKi+VKzXMTuyZV617tU6SJFWcJt5XmQZ
         FSpSvUxOxt2eNWOT+72HcKYGeDsig58aEOMTjzO3YcXh6Ij8Wy2PMPJE5BPtCZ60Ha31
         RjnA==
X-Gm-Message-State: APt69E3NT8sMHrr+YzCUYzZn948k4YpFVWvhb6p5TRAm1SrH4HZ4TtIW
        rJWV01mv8QZyn73KdmntvEiswg==
X-Google-Smtp-Source: ADUXVKJzO589HE5bBH6TqI/XaNLoLX2FEonCPY7Kpp4NoIPqaeods+8um7ohSbnEY5lmSZY2+0SlQw==
X-Received: by 2002:a65:550d:: with SMTP id f13-v6mr11682196pgr.180.1529961043711;
        Mon, 25 Jun 2018 14:10:43 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k71-v6sm7497870pga.62.2018.06.25.14.10.39
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
Subject: [PATCH v2 07/11] crypto alg: Introduce generic max blocksize and alignmask
Date:   Mon, 25 Jun 2018 14:10:22 -0700
Message-Id: <20180625211026.15819-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
exposes a new general upper bound on crypto blocksize and alignmask
(higher than for the existing cipher limits) for VLA removal,
and introduces new checks.

At present, the highest cra_alignmask in the kernel is 63. The highest
cra_blocksize is 144 (SHA3_224_BLOCK_SIZE, 18 8-byte words). For the
new blocksize limit, I went with 160 (20 8-byte words).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/algapi.c         | 7 ++++++-
 include/crypto/algapi.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..496fc51bf215 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -57,9 +57,14 @@ static int crypto_check_alg(struct crypto_alg *alg)
 	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
 		return -EINVAL;
 
-	if (alg->cra_blocksize > PAGE_SIZE / 8)
+	/* General maximums for all algs. */
+	if (alg->cra_alignmask > MAX_ALGAPI_ALIGNMASK)
 		return -EINVAL;
 
+	if (alg->cra_blocksize > MAX_ALGAPI_BLOCKSIZE)
+		return -EINVAL;
+
+	/* Lower maximums for specific alg types. */
 	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
 			       CRYPTO_ALG_TYPE_CIPHER) {
 		if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index bd5e8ccf1687..21371ac8f355 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -20,8 +20,10 @@
 /*
  * Maximum values for blocksize and alignmask, used to allocate
  * static buffers that are big enough for any combination of
- * ciphers and architectures.
+ * algs and architectures. Ciphers have a lower maximum size.
  */
+#define MAX_ALGAPI_BLOCKSIZE		160
+#define MAX_ALGAPI_ALIGNMASK		63
 #define MAX_CIPHER_BLOCKSIZE		16
 #define MAX_CIPHER_ALIGNMASK		15
 
-- 
2.17.1


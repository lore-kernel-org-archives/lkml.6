Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D8C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D7420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YX69ayi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D7420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbeGKUmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390201AbeGKUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id m19-v6so3224565pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=om28ZBbqlVOdWVGgbNqly+1dcj2BlW29w8AmBA0lHYw=;
        b=YX69ayi8bd2LfrIENhAuA/1bW0GHLVnsqIJefN2lUpNMAvuOtkNZvu758y4bPMgL2e
         dC4OYRKJBKfkhgHKSiy12YOJnH+MJHOkmfnjhz7Z6Wun6qlRqAQ/A5SzpOM7knmGcGGL
         VtFmmByd/18y9PatKqVUWTLt5Kqung+Bq7XvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=om28ZBbqlVOdWVGgbNqly+1dcj2BlW29w8AmBA0lHYw=;
        b=qMcBHW3+zdIxtCjOYDYAjd2QjykSr+gP4sANXrO4TaQpUkJrIgWsNHs+u92neszNjU
         Z8XFGhqa6MLa4MTaWC0MsAVMPQ6ktZHYR/5xJYWLz0ab9zzb8A+XsG6ThWHhmxNLwTzq
         LLHZQ772FBzll14bxUoIed7qdAo5lQtA5Ipxq3xNBsYCxetzcatGbGAvkSS9Pb6lg5X3
         BeX43GUBM82AF+6ZCDKu5kqynjp2zhGTYz+8Awe3gekre438KCSXRRuZaYAij9M/tO8X
         V4nTTeIbqKq+BK4RvzO/jZCpfTb4VsB0ouHwjZWOdijB7bGwDidp50ZXIYgT8YKbmcoS
         i6zA==
X-Gm-Message-State: AOUpUlHQGt8TIhKjJP7b9GtYtXyH02L/FVQIzlt5TlpTG8aHEohPp8Nt
        f9600qocSqsWFd6JD1qT1UVU6g==
X-Google-Smtp-Source: AAOMgpeoUtdYN+60Sc8xsNY6M7QOpQTdhQfvAsJV/zO8OLSTHsIlV3Vcy9KAucvpSypuTixScztl3g==
X-Received: by 2002:a62:8389:: with SMTP id h131-v6mr139392pfe.105.1531341390369;
        Wed, 11 Jul 2018 13:36:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j75-v6sm5744234pfj.102.2018.07.11.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
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
Subject: [PATCH v4 07/14] crypto alg: Introduce generic max blocksize and alignmask
Date:   Wed, 11 Jul 2018 13:36:12 -0700
Message-Id: <20180711203619.1020-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
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


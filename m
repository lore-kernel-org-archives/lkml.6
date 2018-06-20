Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6618C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtmvCXS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9955E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeFTTGh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:06:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46710 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFTTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so231225pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yG5aybviBuPPbm4hUFlJLeIulnNClRZRG7IFfSv4RdI=;
        b=GtmvCXS4gzLVHgI//WNGTExd5/nQ7vznhaSM3pYNYe9JInLKuGTFDDpEBdLtCZueRn
         UJjBTspH/LM3ZJ8GoI8xOkPZW6fP23jVg8z6F/Mz1zEmrsBpPC7VV2xlLzPc49ceVSRe
         9qi6hrtMVUeWCf768ZKZZ9mJ4g0gqxFmsVuxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yG5aybviBuPPbm4hUFlJLeIulnNClRZRG7IFfSv4RdI=;
        b=uT7UGHXjFSr8Jo4ngyPLGX9r694GAObsSt4uTwhB9TVPhh3NbKSss0sgdaTdq+yquM
         EV1YYfcjjCZAhRLpKPoBBYI7XemNVvc8fSWF2vJN6TC1nTNBpEus00ujMgTIiDUllLjm
         NY075HZIxVbMveIXGwjv5ScxKsqUIk/Ka/j65rVfAeOd7HdQH3AarRqdO5J/2JvDe60t
         wIW8gVIx/5na+ilhNMdbr4+6CzTKxJoDJ6Mweets0Z/pj6ABeD/w2buu+z4S29iOEnIg
         PWpQ/C3HKMs/1VHsGjdqacEswYVyYMuGM5RNrLJvsnDEDWxmW9iEWIxz6YO54nkRTAUQ
         NrCw==
X-Gm-Message-State: APt69E1uw5BpdLzFlI+BXi4nSwd2iqIryzmnvuPv1S8UIc3PBRyrKE9o
        TgjusFmwmXkx3gvNMu4Ry+AjVQ==
X-Google-Smtp-Source: ADUXVKKMKQrFM8RIP5Tlf7ywdNgogzeibWCqjg/PpiVmt7ySl36l7NBdU9vTus48v7Ud5tJkAwTH8A==
X-Received: by 2002:a62:484d:: with SMTP id v74-v6mr24339476pfa.256.1529521465371;
        Wed, 20 Jun 2018 12:04:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o87-v6sm6689374pfa.106.2018.06.20.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:21 -0700 (PDT)
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
Subject: [PATCH 05/11] crypto alg: Introduce max blocksize and alignmask
Date:   Wed, 20 Jun 2018 12:04:02 -0700
Message-Id: <20180620190408.45104-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
exposes the existing upper bound on crypto block sizes for VLA removal,
and introduces a new check for alignmask (current maximum in the kernel
is 63 from manual inspection of all cra_alignmask settings).

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/algapi.c        | 5 ++++-
 include/linux/crypto.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0755cf4f53f..760a412b059c 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -57,7 +57,10 @@ static int crypto_check_alg(struct crypto_alg *alg)
 	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
 		return -EINVAL;
 
-	if (alg->cra_blocksize > PAGE_SIZE / 8)
+	if (alg->cra_blocksize > CRYPTO_ALG_MAX_BLOCKSIZE)
+		return -EINVAL;
+
+	if (alg->cra_alignmask > CRYPTO_ALG_MAX_ALIGNMASK)
 		return -EINVAL;
 
 	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 6eb06101089f..e76ffcbd5aa6 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -134,6 +134,10 @@
  */
 #define CRYPTO_MAX_ALG_NAME		128
 
+/* Maximum values for registered algorithms. */
+#define CRYPTO_ALG_MAX_BLOCKSIZE    (PAGE_SIZE / 8)
+#define CRYPTO_ALG_MAX_ALIGNMASK    63
+
 /*
  * The macro CRYPTO_MINALIGN_ATTR (along with the void * type in the actual
  * declaration) is used to ensure that the crypto_tfm context structure is
-- 
2.17.1


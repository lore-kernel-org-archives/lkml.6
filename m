Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75304C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aANn7a7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeFTTEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39990 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeFTTEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so275638plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dr1j6UHrKc/dNlmHD7L3RWPEdPEZ+eZBv3QE4bDFzwA=;
        b=aANn7a7goe5W/ssGOcEJY0FZdSCpAL+sH9uHmZBIyViY0uBcZfM1yY8TxsiTt232Vn
         F0GAUFGgPwI4MR2vdoNWXFXFDAwFtZONHojBUFgqsXboBU7CR2xXle54fcBbuM06d9F1
         fkkeRy4VmENeApwP2CVpeQdLbYM5EQxqQysxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dr1j6UHrKc/dNlmHD7L3RWPEdPEZ+eZBv3QE4bDFzwA=;
        b=CjnfuOML1BA7LVRguOnAjSCCOk3YR9+KDxu8C3U2XTLg/h3jQYChmzwZ/t2Nc4eJ3b
         EAusyKNszjw+6SSLmv6dOWszkawzFO3hasy3xa3heZ0oVWtiYEO6ydPLcVydi00MaiBZ
         VgDkaXzv0ISFRfjhSRdBtFEpy87/AMHZI989+hXdpP7Faygap2tBd/6vHeAV2ABd4mLf
         Rw2hwGsQCVFusJLK3Lg5c7jWV6IE7+0MEpOczVJ2wJQ7umBh6iDh3piH6fY4XXrtdm67
         us+9LRKpQdNqbWGQHria2qsveHkEbOQOoS+PS9XyG9GHvGsVV0kQrQBw6W5nEVSl5xc0
         wS7A==
X-Gm-Message-State: APt69E2USy4B9LlZJCqh4Q2G1Jq0T7KQ/qq8Ap0193byDJTwsryNl58+
        j/u95w4PeX7RnimqvLHcyvkMyA==
X-Google-Smtp-Source: ADUXVKLSM7AstO8by5eQdO/A5lYcZvs7RSj7nTND5QpqQhAfNj4W9vKc8gqelporGL1kGvYoHhAoyQ==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr25030671plb.74.1529521464487;
        Wed, 20 Jun 2018 12:04:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s28-v6sm5888318pfg.89.2018.06.20.12.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:22 -0700 (PDT)
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
Subject: [PATCH 07/11] crypto: xcbc: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:04:04 -0700
Message-Id: <20180620190408.45104-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the maximum blocksize and adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/xcbc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/xcbc.c b/crypto/xcbc.c
index 25c75af50d3f..016481b1f3ba 100644
--- a/crypto/xcbc.c
+++ b/crypto/xcbc.c
@@ -65,7 +65,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
 	int bs = crypto_shash_blocksize(parent);
 	u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
 	int err = 0;
-	u8 key1[bs];
+	u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
+
+	if (WARN_ON(bs > sizeof(key1)))
+		return -EINVAL;
 
 	if ((err = crypto_cipher_setkey(ctx->child, inkey, keylen)))
 		return err;
-- 
2.17.1


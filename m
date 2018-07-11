Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA2C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369C720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZxizZys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369C720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbeGKUmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37357 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389949AbeGKUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id x10-v6so9268606pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=LZxizZysaqjhOWIxeFwA+SNkmzWtqkU6HWaBWeLOGOHR4Iv8c3mZ94yY6tUIn0kQmr
         6nOw4mJTri/3KlysT+GdQriDwyBf60SZX95qS3QLUCwbgwIW5kfNgvNoKFD9nEZLZl8E
         9MnLqH2BfAe9iCl8ufxcHv3fSWwq5P9LdkCrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aHfzmuE3dXR4IAoiUCBdTyidzm+NOXbAHoWt0SfC0Yk=;
        b=TRgtZwnU5xdgQ/DjwteFVtmt/MoDb/pHh0ll0UEwA9nb66fCXOI3Qh1cch9eUPXn1c
         m83EFoAKNZ3AZuuCSxs2qXrhJuZMQF6w0Y+LUsvoJgf2kjsttl2YIePX+qGwbvvQzd6U
         9efngFNvjrONQjhCD4PLvRlYML4sihe3NaV6c8hglckTLB5ws6kKsQ7pBaCVVDkADQVf
         kGV05c4LcTc4jnr9l0wri1/9kux3tbM1HGGS3aNf55FkT5bJl5FSkWJxgEKhhxuqtF7v
         fIhRIXnTtXyFt/NqyWuWKfcbWPzUhRGNj2QEMvWKaSRQq+hmTJgZscKdk1P46+Y/Uw/I
         qY8Q==
X-Gm-Message-State: AOUpUlEYG/+ZJ3bZlnzrepA96sUpvCx8y9NaBrDlAKIcXPzUmqacA3jy
        003biWDQh2tQKpuJ1wMYTNBAlwjVYQs=
X-Google-Smtp-Source: AAOMgpcEpcOZIJefOALfPSil3w5uv/4TEYxwha9mmHWLsOXXVbgJWkVTz+ZQzSv8bed27oOW42W4UA==
X-Received: by 2002:a65:638a:: with SMTP id h10-v6mr120358pgv.269.1531341385295;
        Wed, 11 Jul 2018 13:36:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s25-v6sm33091910pgd.83.2018.07.11.13.36.22
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
Subject: [PATCH v4 02/14] crypto: cbc: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:07 -0700
Message-Id: <20180711203619.1020-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..47db0aac2ab9 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,9 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[MAX_CIPHER_BLOCKSIZE];
+
+	BUG_ON(bsize > sizeof(last_iv));
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1


Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A287EC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C8208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHhIYglv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1C8208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeFTTEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:04:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32821 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeFTTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so246714pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9cjOrduzYxUf4NLglgPfdcTigzsYw7XM56GeSsakqpI=;
        b=dHhIYglvKKsYFDu03No+W7WBXzfXC/d4YLnSx88OsYc77A8/jtYxGvoGbAXZL6O2Qp
         /A1LIROvQg192VUtjmKn686ai41BEm8ApXgwjaUm8W5o3yUkdlnO0jshtOWQ650rkGYC
         V1P8SgaLUqy8mW/9E80nw3QKjE9tOcoEqfCsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9cjOrduzYxUf4NLglgPfdcTigzsYw7XM56GeSsakqpI=;
        b=Bx4FK1CfgT/H25R1lKJFqCEPoB87CzDrz5Pekg4A2rEToowgWzf2HuFWKPG1jbUfRC
         C49pweTBXvD+L9+1RufmX0nIQ0wUGPrSsfQcESlpewZnkmpzdorIPeDrAESrAj7Sx1qt
         2mjiU8d7m1almcUyo8IfFhnk5gE9np/DB2VN7jBtT/5DR46EJjZQgxXlC6plT5gwiap7
         KKljGMJ+0zkXk3BnqxRZGZGF9aTANlYrlOUCNwvv9sZsz6l941dnm6esWVtKO/wmt9Aq
         plqoQMYdQX+tN2O799UgMRyVnUZBh1HHeANsBXXXZq2IETeEbaBeMPUtWrJkDWSMlKQD
         zE4Q==
X-Gm-Message-State: APt69E3+dF59wxaG7kS/WYN0LjD9Pi7C1+67+IGpoz64wogxQfgrqxx9
        187wgxPXCdKp9tHuhp1PwQaNxg==
X-Google-Smtp-Source: ADUXVKKRuQ5oXcU+DaxxLqOpP93LMjXAVNdajI//y/wZExzXVYSRB34VQKyAfqACG8ufd1cEnMGziQ==
X-Received: by 2002:a63:27c6:: with SMTP id n189-v6mr20013798pgn.164.1529521463574;
        Wed, 20 Jun 2018 12:04:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s75-v6sm6123983pfj.125.2018.06.20.12.04.18
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
Subject: [PATCH 06/11] crypto: cbc: Remove VLA usage
Date:   Wed, 20 Jun 2018 12:04:03 -0700
Message-Id: <20180620190408.45104-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..260096bcf99b 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,7 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[CRYPTO_ALG_MAX_BLOCKSIZE];
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1


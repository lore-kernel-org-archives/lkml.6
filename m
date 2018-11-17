Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020CC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EE0223C8
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5eLXGcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EE0223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeKQLnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbeKQLni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:43:38 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3633D214C1;
        Sat, 17 Nov 2018 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542418133;
        bh=+ervPETGkti/VwKM7z90Ynte+hq6Bej6lSNk5xOd0j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5eLXGcIkocRUqKKqxcCsOqgCxTmVs5EjNDF9majCEx31rRuePjE0HnqLq8qVazCW
         Hu43UfZDo3/cLWf/pESEQBB6v7HnwxqkIqyfOcecxCubaE8aXVE/rOwXgslekObuTv
         /oDHqqV+cN5S8C7x+Gu9VzdBizh01YW0q44HAnRk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 09/14] crypto: arm/chacha - add XChaCha12 support
Date:   Fri, 16 Nov 2018 17:26:26 -0800
Message-Id: <20181117012631.23528-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181117012631.23528-1-ebiggers@kernel.org>
References: <20181117012631.23528-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the 32-bit ARM NEON implementation of ChaCha20 and XChaCha20
has been refactored to support varying the number of rounds, add support
for XChaCha12.  This is identical to XChaCha20 except for the number of
rounds, which is 12 instead of 20.

XChaCha12 is faster than XChaCha20 but has a lower security margin,
though still greater than AES-256's since the best known attacks make it
through only 7 rounds.  See the patch "crypto: chacha - add XChaCha12
support" for more details about why we need XChaCha12 support.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/Kconfig            |  2 +-
 arch/arm/crypto/chacha-neon-glue.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index a08759c32cb9..59c674cf08ef 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -126,7 +126,7 @@ config CRYPTO_CRC32_ARM_CE
 	select CRYPTO_HASH
 
 config CRYPTO_CHACHA20_NEON
-	tristate "NEON accelerated ChaCha20 stream cipher algorithms"
+	tristate "NEON accelerated ChaCha stream cipher algorithms"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
diff --git a/arch/arm/crypto/chacha-neon-glue.c b/arch/arm/crypto/chacha-neon-glue.c
index 385557d38634..9d6fda81986d 100644
--- a/arch/arm/crypto/chacha-neon-glue.c
+++ b/arch/arm/crypto/chacha-neon-glue.c
@@ -1,5 +1,6 @@
 /*
- * ChaCha20 (RFC7539) and XChaCha20 stream ciphers, NEON accelerated
+ * ARM NEON accelerated ChaCha and XChaCha stream ciphers,
+ * including ChaCha20 (RFC7539)
  *
  * Copyright (C) 2016 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  *
@@ -154,6 +155,22 @@ static struct skcipher_alg algs[] = {
 		.setkey			= crypto_chacha20_setkey,
 		.encrypt		= xchacha_neon,
 		.decrypt		= xchacha_neon,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-neon",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.walksize		= 4 * CHACHA_BLOCK_SIZE,
+		.setkey			= crypto_chacha12_setkey,
+		.encrypt		= xchacha_neon,
+		.decrypt		= xchacha_neon,
 	}
 };
 
@@ -180,3 +197,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-neon");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-neon");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-neon");
-- 
2.19.1.1215.g8438c0b245-goog


Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9BC21A74
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYduDkWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9BC21A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbeHGAqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732382AbeHGAqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:46:13 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C84321A70;
        Mon,  6 Aug 2018 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533594900;
        bh=69ARqbIkf3tYzc5fBb5j9RP57lLwH6Z2F2ov684TlD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYduDkWnyEZ+S6VEntCjnH80y/06iyBMxl6Ic8kdPFriGUyEGHdGpBmcMAhiXSApm
         YQv68HgHjfZJhxFnN9EQ4aXYoV1+XDNKfpm6qJhbukN5WPlYhtEJQc54SmPc+6AkeO
         VjdH9SGATxuiGybI9muumZomviP//yDpkJR2okzE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH 7/9] crypto: arm/chacha - add XChaCha12 support
Date:   Mon,  6 Aug 2018 15:32:58 -0700
Message-Id: <20180806223300.113891-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180806223300.113891-1-ebiggers@kernel.org>
References: <20180806223300.113891-1-ebiggers@kernel.org>
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
rounds, which is reduced from 20 to 12.

As I explained in more detail in the patch which added XChaCha12 to the
generic code, "crypto: chacha - add XChaCha12 support", we'd prefer to
use XChaCha20, but unfortunately it is not fast enough for our use case.
Thus, we must settle for a reduced-round variant.  See that patch for a
more detailed explanation.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/Kconfig            |  2 +-
 arch/arm/crypto/chacha-neon-glue.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 896dcf142719..75c613413e31 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -116,7 +116,7 @@ config CRYPTO_CRC32_ARM_CE
 	select CRYPTO_HASH
 
 config CRYPTO_CHACHA20_NEON
-	tristate "NEON accelerated ChaCha20 stream cipher algorithms"
+	tristate "NEON accelerated ChaCha stream cipher algorithms"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
diff --git a/arch/arm/crypto/chacha-neon-glue.c b/arch/arm/crypto/chacha-neon-glue.c
index b236af4889c6..0b1b23822770 100644
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
@@ -160,6 +161,22 @@ static struct skcipher_alg algs[] = {
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
 
@@ -186,3 +203,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-neon");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-neon");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-neon");
-- 
2.18.0.597.ga71716f1ad-goog


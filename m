Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D734C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36172214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU1Dv1/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36172214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLDD4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeLDD4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:56:10 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED30E214DA;
        Tue,  4 Dec 2018 03:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543895769;
        bh=9sqEpCOjIyWA2Z9z1Qrp9WtcLxh4o/dxsqsNsRv+aLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cU1Dv1/qRyL4eZgfrDygHyWN/4hjxW/HvodmSXDhxFCAbUCcXPJrrQSnElIiIA84g
         7t0Fu/1yEHI3Ky4t/hTxqr3nb/7Tyz8URpRlCAURkcjLSNCF+C0U9HsEmxGiP9a44z
         muiw9cAiYJH05AmByrKVVmQvioy9ExR2I5DDMxH4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] crypto: arm64/chacha - add XChaCha12 support
Date:   Mon,  3 Dec 2018 19:52:52 -0800
Message-Id: <20181204035252.14853-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204035252.14853-1-ebiggers@kernel.org>
References: <20181204035252.14853-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the ARM64 NEON implementation of ChaCha20 and XChaCha20 has
been refactored to support varying the number of rounds, add support for
XChaCha12.  This is identical to XChaCha20 except for the number of
rounds, which is 12 instead of 20.  This can be used by Adiantum.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/Kconfig            |  2 +-
 arch/arm64/crypto/chacha-neon-glue.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index d54ddb8468ef..d9a523ecdd83 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -101,7 +101,7 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_SIMD
 
 config CRYPTO_CHACHA20_NEON
-	tristate "ChaCha20 and XChaCha20 stream ciphers using NEON instructions"
+	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
index 4d992029b912..346eb85498a1 100644
--- a/arch/arm64/crypto/chacha-neon-glue.c
+++ b/arch/arm64/crypto/chacha-neon-glue.c
@@ -161,6 +161,22 @@ static struct skcipher_alg algs[] = {
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
 
@@ -187,3 +203,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-neon");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-neon");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-neon");
-- 
2.19.2


Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478E3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABD520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJcLwtVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABD520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeJEPLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbeJEPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so1036453wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+1FdRMKX5kWT68MST48ZYdoIobJ5B3kYMhv71JKOAg=;
        b=PJcLwtVXRuyJPKWbbwJBGaYD/0+A6pH/bRN1v8Ky+MsOeDl1X8nZVqwwcKBgUCWjct
         PMh/eQPIxbpQRmrMSUG0NVWRyNWL60QRHPjdWY8s3j9dnprSTAVQeym8nwAdgE0Kfn39
         qt/i7giQasS5aiIXOxSLGpmt7KZ1soLYUoyuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+1FdRMKX5kWT68MST48ZYdoIobJ5B3kYMhv71JKOAg=;
        b=tluxwEiIPDSJloz+1X+IG6iOxivHJCcj7VFN3GI3k9ynxYazam65OuSDmD1tqpjFrD
         5gebJftGlpeApmHmueXgA6YLtF9JNym2F31lBl4viCwjQLERmTRkb4VkDUKFewIEQ3Fs
         mTc1qRayiXCbguKoSCzDyAcWHc/9Fd+xCFKx2x9/S/t9vspnweixVlNdTGvSsdybj3xL
         M+37WceBLO/GCstMm9bUfmcJzYm+aPF0LmTCkrTAIwITLdJeGm90QPkYKvswJ6mRsaXr
         wcEKQZAenow33QvJfepZN0fV3NEFyqGRYFK8lxabirZYh6EbfmDWPrEQUZzr7rJFL7NE
         MqkQ==
X-Gm-Message-State: ABuFfogglaQiDw746rUjizPb1/G/yZaL05+jdkyh9NM9AXzw0riiQoJ5
        baR9nVD+s/pEQSAARAXfnWfsHrNSEVE=
X-Google-Smtp-Source: ACcGV61whWAPedlj0YXt2r0zQodYfSJJwK7RNqx61OHr39dNjfuLTcFQbE9SyFx0akoRNcAg/V4cJg==
X-Received: by 2002:a1c:9e8f:: with SMTP id h137-v6mr380822wme.142.1538727232789;
        Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 9/9] crypto: crc-t10dif/x86 - move PMULL based code into core library
Date:   Fri,  5 Oct 2018 10:13:33 +0200
Message-Id: <20181005081333.15018-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PMULL based routines out of the crypto API into the core
CRC-T10DIF library.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/crypto/crct10dif-pclmul_glue.c | 98 +++-----------------
 1 file changed, 13 insertions(+), 85 deletions(-)

diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index cd4df9322501..47f0017ad7f3 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -25,7 +25,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
+#include <linux/ffp.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -36,90 +36,17 @@
 asmlinkage __u16 crc_t10dif_pcl(__u16 crc, const unsigned char *buf,
 				size_t len);
 
-struct chksum_desc_ctx {
-	__u16 crc;
-};
-
-/*
- * Steps through buffer one byte at at time, calculates reflected
- * crc using table.
- */
-
-static int chksum_init(struct shash_desc *desc)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	ctx->crc = 0;
-
-	return 0;
-}
-
-static int chksum_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	if (irq_fpu_usable()) {
-		kernel_fpu_begin();
-		ctx->crc = crc_t10dif_pcl(ctx->crc, data, length);
-		kernel_fpu_end();
-	} else
-		ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_final(struct shash_desc *desc, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	*(__u16 *)out = ctx->crc;
-	return 0;
-}
-
-static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
-			u8 *out)
+static __u16 crct10dif_update_x86(__u16 crc, const u8 *data, unsigned int length)
 {
 	if (irq_fpu_usable()) {
 		kernel_fpu_begin();
-		*(__u16 *)out = crc_t10dif_pcl(*crcp, data, len);
+		crc = crc_t10dif_pcl(crc, data, length);
 		kernel_fpu_end();
-	} else
-		*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
-	return 0;
-}
-
-static int chksum_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(&ctx->crc, data, len, out);
-}
-
-static int chksum_digest(struct shash_desc *desc, const u8 *data,
-			 unsigned int length, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(&ctx->crc, data, length, out);
-}
-
-static struct shash_alg alg = {
-	.digestsize		=	CRC_T10DIF_DIGEST_SIZE,
-	.init		=	chksum_init,
-	.update		=	chksum_update,
-	.final		=	chksum_final,
-	.finup		=	chksum_finup,
-	.digest		=	chksum_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crct10dif",
-		.cra_driver_name	=	"crct10dif-pclmul",
-		.cra_priority		=	200,
-		.cra_blocksize		=	CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		=	THIS_MODULE,
+	} else {
+		crc = crc_t10dif_generic(crc, data, length);
 	}
-};
+	return crc;
+}
 
 static const struct x86_cpu_id crct10dif_cpu_id[] = {
 	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ),
@@ -132,12 +59,16 @@ static int __init crct10dif_intel_mod_init(void)
 	if (!x86_match_cpu(crct10dif_cpu_id))
 		return -ENODEV;
 
-	return crypto_register_shash(&alg);
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_x86);
+
+	return 0;
 }
 
 static void __exit crct10dif_intel_mod_fini(void)
 {
-	crypto_unregister_shash(&alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_init(crct10dif_intel_mod_init);
@@ -146,6 +77,3 @@ module_exit(crct10dif_intel_mod_fini);
 MODULE_AUTHOR("Tim Chen <tim.c.chen@linux.intel.com>");
 MODULE_DESCRIPTION("T10 DIF CRC calculation accelerated with PCLMULQDQ.");
 MODULE_LICENSE("GPL");
-
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-pclmul");
-- 
2.11.0


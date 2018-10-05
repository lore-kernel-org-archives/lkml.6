Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD6C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF52098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnwyIatH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CF52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeJEPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeJEPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so12553743wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W4XNrL/HVz1JFq0EC5F2/AltrGoh1ZboRDNEWdxrwVU=;
        b=jnwyIatHaYA2n3cTx6guJoyPbr+L3fOA9AOBqx0Y2oMaeF96hobAONVdvSUned1y3s
         StByQ8z+FybmB6IbckDsErTVElZPazLc7iw2ihFw0/S6pZiXC3Q6LPbxewFO5smDCYZf
         uOH6PjRG3nJAjWfuYmqeU3mfvrJ5BOnGliwTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W4XNrL/HVz1JFq0EC5F2/AltrGoh1ZboRDNEWdxrwVU=;
        b=OIf9aQMLs19DcnnidxZLwv6T347RFRoG/dXws7ToGCpsQuLOTufIvcJBq25vFubTpR
         ZIHXHXs4DWI9FAUZ2Igw5W9+hj2R0Vb19jyu5e0YYv2wB+TSyltgos6IBRBNshCwiJ7J
         RPCTEsDBD7Q22f8+rOfU+u7D+hf0jivHi+iTjdH7dUiWSONHuZe7x9XC72rQPOu2Qwd8
         qb9ARxsI1XPqBTYw+sHmSTmheMOsJD3dMt77IC116tqOpn+CVVubRY/hv19CJHNUc3FH
         cvqTK0kxyRqJ/enswfsk8WrLj8vGjX7bq6zNLXfrMUE46M7xRr+eRUjPcnDidXO/zF5f
         S8qg==
X-Gm-Message-State: ABuFfoj9sFlN0Etl3LbvdhiSS7IwyDAPKV19SPoPQT2nes31YYugfcPi
        KCZJ0hlF00HzKtmW1PuRrxlvNVRRkj8=
X-Google-Smtp-Source: ACcGV61HoftJXzqiL1l8hk7uMWp9ORWuLz+n27+qFSZw8Ez8l1VEdbwmXm9/Fc00segej20s6XNxjA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13-v6mr7838866wrq.133.1538727228189;
        Fri, 05 Oct 2018 01:13:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:47 -0700 (PDT)
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
Subject: [RFC PATCH 6/9] crypto: crc-t10dif/arm - move PMULL based code into core library
Date:   Fri,  5 Oct 2018 10:13:30 +0200
Message-Id: <20181005081333.15018-7-ard.biesheuvel@linaro.org>
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
 arch/arm/crypto/crct10dif-ce-glue.c | 78 ++++++--------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/arch/arm/crypto/crct10dif-ce-glue.c b/arch/arm/crypto/crct10dif-ce-glue.c
index d428355cf38d..2020d9c29ff1 100644
--- a/arch/arm/crypto/crct10dif-ce-glue.c
+++ b/arch/arm/crypto/crct10dif-ce-glue.c
@@ -10,12 +10,11 @@
 
 #include <linux/crc-t10dif.h>
 #include <linux/init.h>
+#include <linux/ffp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 
-#include <crypto/internal/hash.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
@@ -23,74 +22,42 @@
 
 asmlinkage u16 crc_t10dif_pmull(u16 init_crc, const u8 buf[], u32 len);
 
-static int crct10dif_init(struct shash_desc *desc)
+static __u16 crct10dif_update_arm(__u16 crc, const u8 *data, unsigned int length)
 {
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
 	unsigned int l;
 
-	if (!may_use_simd()) {
-		*crc = crc_t10dif_generic(*crc, data, length);
-	} else {
-		if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-			l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-				  ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
+	if (!may_use_simd())
+		return crc_t10dif_generic(crc, data, length);
 
-			*crc = crc_t10dif_generic(*crc, data, l);
+	if (unlikely((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
+		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
+			  ((u32)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
 
-			length -= l;
-			data += l;
-		}
-		if (length > 0) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		}
-	}
-	return 0;
-}
+		crc = crc_t10dif_generic(crc, data, l);
 
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
+		length -= l;
+		data += l;
+	}
+	if (length > 0) {
+		kernel_neon_begin();
+		crc = crc_t10dif_pmull(crc, data, length);
+		kernel_neon_end();
+	}
+	return crc;
 }
 
-static struct shash_alg crc_t10dif_alg = {
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-};
-
 static int __init crc_t10dif_mod_init(void)
 {
-	if (!(elf_hwcap2 & HWCAP2_PMULL))
-		return -ENODEV;
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_arm);
 
-	return crypto_register_shash(&crc_t10dif_alg);
+	return 0;
 }
 
 static void __exit crc_t10dif_mod_exit(void)
 {
-	crypto_unregister_shash(&crc_t10dif_alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_init(crc_t10dif_mod_init);
@@ -98,4 +65,3 @@ module_exit(crc_t10dif_mod_exit);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
-- 
2.11.0


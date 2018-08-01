Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D002C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5750F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAryMb/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5750F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeHAJp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:45:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44318 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387671AbeHAJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:45:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so10419223pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oNyPwIsjRhf+ZiEWRkmri6ZF3DwmBYxfrK8HfgRNf3k=;
        b=ZAryMb/qZx0OKViN+b6ys0hiRqPvP8zCaMkL4ja0xTPB2q0UloM4GrkKFV5wiuNO/P
         lzmiVk6zOo54gMHgaJfh6aAMPLrzSFlU1lJnzV9iWudQz1+ZVQGcFC61vdHQrXMJUwDG
         M5DdkZHpJc6iwvCF+yPRD9d5rvirOXYE1lYBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNyPwIsjRhf+ZiEWRkmri6ZF3DwmBYxfrK8HfgRNf3k=;
        b=FEGUk8yZB3vnDDjFqmkdF8kY2krrOxBvjsET7liuDI7Yk7I9zLzn9gStFmwv+YE/6o
         UymbwmIvNLV1NocMFxI4W8W1L0FigQ0C75cndnj4UuaRfnTkvsJRo05mR59L2so31O7l
         QycLX2eu6nrOGhuGgSwcWIoDpjLvT5x/sxGJoHckO0/bnIGe/7WP5wEw8023iPwlnYtJ
         8xE1Oe+lvwKdRbQ5xJfOPUeQB9eJfkq5ULcPkZN9IOmKYwON8bb6ZNFyANVrVOipfg6b
         d0IHNkKFyv3sgbIhYghDLLD2XHa+fujy6PY+IWZq3UeKgxi6xxhRCL60OW07KZw9h87m
         mBtg==
X-Gm-Message-State: AOUpUlH2wbOiOs6jnxeVV9v538MKI5oq0y7IF6EYkHMyKKBtW47y0WDS
        wkqkDjE3MzFRCqCH7fd3WDXdVA==
X-Google-Smtp-Source: AAOMgpemPQwQ62AsUr1iIbdCW37PmGaLmw6hpdj7waRBisKK4PSZ/gLP/Aa01ZNPz2Qc2EDBSFagXg==
X-Received: by 2002:a62:3a5b:: with SMTP id h88-v6mr25710062pfa.61.1533110492352;
        Wed, 01 Aug 2018 01:01:32 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 70-v6sm12694141pfz.27.2018.08.01.01.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:01:31 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v13 15/16] arm64: kexec_file: add kernel signature verification support
Date:   Wed,  1 Aug 2018 16:58:19 +0900
Message-Id: <20180801075820.3753-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, kernel verification can be done without IMA security
subsystem enabled. Turn on CONFIG_KEXEC_VERIFY_SIG instead.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.

You can create a signed kernel image with:
    $ sbsign --key ${KEY} --cert ${CERT} Image

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5988e767526f..fdc4571c142d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -861,6 +861,30 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
+	  In addition to that option, you need to enable signature
+	  verification for the corresponding kernel image type being
+	  loaded in order for this to work.
+
+config KEXEC_IMAGE_VERIFY_SIG
+	bool "Enable Image signature verification support"
+	default y
+	depends on KEXEC_VERIFY_SIG
+	depends on EFI && SIGNED_PE_FILE_VERIFICATION
+	help
+	  Enable Image signature verification support.
+
+comment "Support for PE file signature verification disabled"
+	depends on KEXEC_VERIFY_SIG
+	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index d64f5e9f9d22..578d358632d0 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/string.h>
+#include <linux/verification.h>
 #include <asm/boot.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
@@ -28,6 +29,9 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&h->mz_magic, "MZ", 2) ?  "no" : "yes");
+
 	return 0;
 }
 
@@ -102,7 +106,18 @@ static void *image_load(struct kimage *image,
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+static int image_verify_sig(const char *kernel, unsigned long kernel_len)
+{
+	return verify_pefile_signature(kernel, kernel_len, NULL,
+				       VERIFYING_KEXEC_PE_SIGNATURE);
+}
+#endif
+
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = image_verify_sig,
+#endif
 };
-- 
2.18.0


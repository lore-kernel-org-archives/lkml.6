Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343120875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqMA37RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeGXIEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:04:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40373 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:04:10 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so1328531plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pwXt6vap8yHX0ws+sEoumnHhs6bkGBBWSifGoV32A7Y=;
        b=YqMA37RPrwDG7QMbekhUUHSkhSv6lFzDpMZn38BDZBonF4qxQNMpXVgwHX0+Qg4Oaf
         /3V2lz1+76QcGqE/OOehIRcxSCjbF29D+xDyrTkr7sDoabpzDYPx0ChmHhvLY1fX1Ugx
         nZr0y9zbP9jAzyB+admjVWsewji7m/SKzXCro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pwXt6vap8yHX0ws+sEoumnHhs6bkGBBWSifGoV32A7Y=;
        b=GdCZRROwano2Wq3HRr5FL/1OFAK4LvATN6YaaI0l10PbOLo1SKXl59fRoZRcmXYojk
         KkKaX4p7ZFXWFbTtio5qF3xKiM/L6OosDqUzd5un+pbXw+HTBH3twOy4pUxvqZdE8Tsm
         fbTh7fCUC8NLIjlkPNzoZ6d5WDBN+/J/0UJ3ObItLPrjA+aOogtPk9/4FxLw2OtBMtZd
         IYJuRVZnuPZAFrh9v3EDwtWNPmkesPepmTRGgmgwWmEjMTbqJKbiA7WmUVDz+2xPAY71
         bsRFMpiFj9nK2ROB6dV4vWNGKBPqFREiPY1HlpT7RrplkR/xz0yg855UxKxr+g6s1weS
         xSnw==
X-Gm-Message-State: AOUpUlHqb0SSHUpwPqaiNQxXpboBvp6rUOCFQdcxbnw4aWNVHuvh9XPZ
        IqEDsc9p2J2V9BtJUp0bbv8k8g==
X-Google-Smtp-Source: AAOMgpcb7hEP3pLLw18pY8MBctvEOFfhWftNlRycrBUzZ0Kk4b1IfHhUXCb9BVsnasaF7rHcXQUNog==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr15657253plo.283.1532415552316;
        Mon, 23 Jul 2018 23:59:12 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 21-v6sm21506976pgx.20.2018.07.23.23.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:59:11 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 15/16] arm64: kexec_file: add kernel signature verification support
Date:   Tue, 24 Jul 2018 15:57:58 +0900
Message-Id: <20180724065759.19186-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
---
 arch/arm64/Kconfig              | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c | 15 +++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a9a3a5583c8b..1445eb2fc833 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -844,6 +844,30 @@ config KEXEC_FILE
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


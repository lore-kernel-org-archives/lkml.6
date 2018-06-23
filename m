Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A56C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2436024ACC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8+e0NFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2436024ACC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbeFWCVw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45355 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeFWCVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so3986600pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iq0k8J5XruMuCEwI5GOPO4br/vpHgLgOsDlsPLUiok=;
        b=W8+e0NFMFkGddfjFaPG1FKSmMrI7Z40eg2qdQG8pnuZtGQ85tzz04ZNWG5JbnyHGTv
         JJwBwgapq3zQ/spzzYHxKJ+2Ou+QEIPuBoVwZWWmYgFnDBWpEFCQ790mxYfJ+R3Gfzzp
         TponLKQ5lPM0HVg7YVluoO2ZOrsh8OrbjDY0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iq0k8J5XruMuCEwI5GOPO4br/vpHgLgOsDlsPLUiok=;
        b=Hte7KiQe87ezM1vGPxf186Xj4LxKd7pS8KY+dzHPQFW4Y96fWsuTrDa48XqkrlkUsI
         rs0FcO1wWXO7eEsEzawrpOIPxeakXEngmfBsy+euHhKbgV/+qGqf+5+w+bp2YQgkc+gS
         V6fvOJgkFMiB5MvZ5nyw+JkkezfCIWt15hXLSlZwKYr6gRkic2Wr6GOV98Ln0vrBOUMM
         PS/pRWjgX7cVsVnKwjjSjpco/ZXStER5ofh8G8YPmPzM/QBrt17wyP3nwou7r6LclbTy
         ///2p536fXxN+AqErlGGaN9T4fxsSzJEutRE4xuLlmkom5lQ46v4y5YUX/BjZ63hKuB4
         qJDA==
X-Gm-Message-State: APt69E0hYqY1nmte0RDjHVV6+qdA6PNVYixcAvyNaPieZeIDUkleX/FS
        91dOwU/fpAZTnNZemEFwkFFJVg==
X-Google-Smtp-Source: ADUXVKLv/K01s4UDZALSdo36absYM2DLdjfK6Pe52MG0SC6lTDGYtAcMC/8dWKq1aKCwUXfz62Oykg==
X-Received: by 2002:a63:5ec4:: with SMTP id s187-v6mr3363726pgb.72.1529720508470;
        Fri, 22 Jun 2018 19:21:48 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id v15-v6sm24129368pfk.12.2018.06.22.19.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:47 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 13/14] arm64: kexec_file: add kernel signature verification support
Date:   Sat, 23 Jun 2018 11:20:57 +0900
Message-Id: <20180623022058.10935-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
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
index f68318f61c85..5133c22a01ab 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -845,6 +845,30 @@ config KEXEC_FILE
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
+comment "Image signature verification is missing yet"
+	depends on KEXEC_VERIFY_SIG
+	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index df1e341d3a28..bb0a95add197 100644
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
 			!memcmp(&h->magic, ARM64_MAGIC, sizeof(ARM64_MAGIC)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&h->mz_magic, "MZ", 2) ?  "no" : "yes");
+
 	return 0;
 }
 
@@ -107,7 +111,18 @@ static void *image_load(struct kimage *image,
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
2.17.0


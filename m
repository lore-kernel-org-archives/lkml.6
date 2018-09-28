Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1262172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KB4DyH3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1262172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeI1NLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35010 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1NLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so3647888pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+rOwpZAq7LVQH0becYmXtiL//qU2xu/pSqOkMjD4f0=;
        b=KB4DyH3/aOOCTeE+ulXend4IlnHljB8l5FxwaLh7zMawvTxl7hXakSbyIdy2GdfBCW
         TNu6W9rqd6YcC/Kpzk+yYa5fv0ttZ9AtOK1qLnCv7Fg6BTui3hGcYghBqoaFUVpmiYPY
         HiRibIaRnhkbDmMNt9I9kQiq9lvDDFVFZnlyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+rOwpZAq7LVQH0becYmXtiL//qU2xu/pSqOkMjD4f0=;
        b=ccYjIvUtwIlj3D9Y78rRHa4rB2awbtEJgwszJAX+uI1/ehkEpbxQJzlokDfeTXjep9
         Et7xvpMBZgyaLP9UQz9vj5QIViuoOPUyIGMoQQeCosTySSyPOjlDEiKnGfOYpLwQKzq4
         86irg46SuWpvLpQ2FqSDMS7CtR8LVexGbpE2cNp7OyuCZA/ZGKoHuMsqG4a6PQRYhcFi
         FIOmTkq31WnalfypsPU9PqTJf4lsi0DzR2/kdMZ3USQJjkgKJRn4HfCJ5/M3A9j3Jh2T
         2p3Mr35SGbL4PGXZW676EzLw4Icdxdsfz7bjYY6qD/Zk9dFoJEw+Dc3/AsqZBY8cNT1y
         lGlQ==
X-Gm-Message-State: ABuFfoiP5NWji3wvpRtPg5TNSJIn/d8nhBbKofRYl8nCMpahbnsykwPG
        S6eDzjoPfGR3rqh8rJgCVLpZVQ==
X-Google-Smtp-Source: ACcGV60SDpQTkxHCAGmUi4T9yL5fxZ5izgApfms5Yuq6163677NqEYfYEU7DiQUy9rUdcK58yn0tTg==
X-Received: by 2002:a17:902:4e:: with SMTP id 72-v6mr14655909pla.318.1538117371502;
        Thu, 27 Sep 2018 23:49:31 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id c79-v6sm195047pfc.92.2018.09.27.23.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:30 -0700 (PDT)
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
Subject: [PATCH v15 15/16] arm64: kexec_file: add kernel signature verification support
Date:   Fri, 28 Sep 2018 15:48:40 +0900
Message-Id: <20180928064841.14117-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 5eb18d0cb513..e7de9500bf0b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -852,6 +852,30 @@ config KEXEC_FILE
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
2.19.0


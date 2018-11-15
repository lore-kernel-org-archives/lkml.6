Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB192087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuBj4P2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB192087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeKOQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:00:09 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41302 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeKOQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:00:09 -0500
Received: by mail-yb1-f196.google.com with SMTP id t13-v6so7916506ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9P53Yj/xMXiy2VwbQPz0MnQUBccWU//quNYW0Ks+uWQ=;
        b=RuBj4P2KtbYJ5z9USSRs+7o18nA+07+01QwFh3UtWxMpEjf1sRCmIJdKeu9F7Dxe0b
         U4yhq1t6E5RWWBnY3EVAbaOpN+RsBs9HGRli3CY50P6r+V5BdeUIq1m6yrvOhnrJ4Snz
         kVhrmv1hMMApkndiuBYd7IAa8gpBE9Wml7WoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9P53Yj/xMXiy2VwbQPz0MnQUBccWU//quNYW0Ks+uWQ=;
        b=gCKT/i6QW/vpFxAvXM8hCuxXI7OUEG5cZcmhCAVfF0N6srD5bMidj6Iqx14pbW4jFf
         E7jm+JPj93L0iBWa9VaRJ0uaoQas9EnR61mZv6IrisqSP24btUa8wspkcpm3Pi8RT3Uo
         XxX2H9fT1Ypuk+HGkQS6grYlp4tZTzmdA4jAR+4oJw2F0qKEzAuwI8Th5X2Y+7j02/4h
         KQJ0ndWP2ssGapBOjuG+eF2Vaq3ZfksJyNJydG89VY+1G/53GzsO8EzG9UKTlP6e3WYG
         KoajPEjdIM9LLRYdIiMWK9yGzizEGssc/WFP+rCmeytm5b5/92vCBDAaBlvH2zMzVRiH
         KWHw==
X-Gm-Message-State: AGRZ1gLZSzuVMmojnfWBeut4WSzfZVcNMS+yEA2wmYort6qGDTRqTJZp
        7aqF7hATpNCtERr2ybAd1/3gCw==
X-Google-Smtp-Source: AJdET5fFdK8szs+B+qUJ3wdgWiLE4l4gaPySkRnftc2+aZxbkCEKtN3WDr30shmkoLh8Q0v+ims7Og==
X-Received: by 2002:a5b:40a:: with SMTP id m10-v6mr4520102ybp.21.1542261223143;
        Wed, 14 Nov 2018 21:53:43 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l35sm1837306ywh.48.2018.11.14.21.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:42 -0800 (PST)
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
Subject: [PATCH v16 15/16] arm64: kexec_file: add kernel signature verification support
Date:   Thu, 15 Nov 2018 14:52:54 +0900
Message-Id: <20181115055254.2812-16-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
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
 arch/arm64/kernel/kexec_image.c | 17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93dc4d36d6db..11f3e1a00588 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -867,6 +867,30 @@ config KEXEC_FILE
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
index 9f0d8b5d62d3..d1c6c54c22e3 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -12,7 +12,9 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/pe.h>
 #include <linux/string.h>
+#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -29,6 +31,10 @@ static int image_probe(const char *kernel_buf, unsigned long kernel_len)
 				sizeof(h->magic)))
 		return -EINVAL;
 
+	pr_debug("PE format: %s\n",
+			memcmp(&((struct mz_hdr *)h)->magic, "MZ", 2) ?
+							"no" : "yes");
+
 	return 0;
 }
 
@@ -107,7 +113,18 @@ static void *image_load(struct kimage *image,
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


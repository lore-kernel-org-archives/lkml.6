Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C060C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506662087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRM172Hv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506662087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeKOP7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:59:44 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35971 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKOP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:59:43 -0500
Received: by mail-yb1-f194.google.com with SMTP id g192-v6so7930726ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/2g1t2ZiuSybJx6NO3mxBVk7FXFeZVpACxhmjpzZl4=;
        b=WRM172Hvt4U1KKJWpGr+jhsdTHlND6n0dqnf7rnB7KR/ez937GBqOmCQCx1s21rU0p
         ujsZeGL5rIRXhbwM/XGgrEUm8q1RE20jG14eR764S9DPpUM1XDNxeOD3x8y8GSTl1UVZ
         1rt2/niMdKhX5PvrZYLdimEpAHH7VSWUy5rNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/2g1t2ZiuSybJx6NO3mxBVk7FXFeZVpACxhmjpzZl4=;
        b=R4EEZuY/upUA2pXLL/aNRIt4kVqkYZ1OecgrkuZapUhNJ0WfsK3m7fLNYM6eaZqIPg
         Lz/RA1SKCHllxWAAzBJh2LOgJB5rhOpyaQEalYlQVfuvTRsk181oBMnd5thbmb6Hzz9a
         RQavXdRtItvKTgSXaOY7xhzwdbmDuyCuOtbteHAVjnFiGG9EfX/gXYiNBPIl5nCXj6Vr
         4ZGUDarl/Ug2riot3Ufuj6vjMc8MSnRgQ97r0TMj0FawGNUgGsvOtg+0n+UKlu3yeQxw
         iVsPpo6dMVOXN6M3x9dDDY1VPWVcqLTZE++1ZN1p2XwbBXlRBDqxb8RGwMXX+bTu5ODb
         19GQ==
X-Gm-Message-State: AGRZ1gLIjH5rkjrzJ6tNsd89edyQkDq/aFtgf05YB4HkM0Fyxj/PlISG
        XA/YIE0KOJAbH1SJECwzuZHBtA==
X-Google-Smtp-Source: AJdET5eL4UvzIiUqLTSwJlF/faDVYgAhj41qDVfZC9x7FDJJIszpXTG+cTHyextEIIGCfJdne+plig==
X-Received: by 2002:a25:2d16:: with SMTP id t22-v6mr4345342ybt.352.1542261197591;
        Wed, 14 Nov 2018 21:53:17 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r5-v6sm8102379ywr.80.2018.11.14.21.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:17 -0800 (PST)
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
Subject: [PATCH v16 09/16] arm64: enable KEXEC_FILE config
Date:   Thu, 15 Nov 2018 14:52:48 +0900
Message-Id: <20181115055254.2812-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify arm64/Kconfig to enable kexec_file_load support.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig                     |  9 +++++++++
 arch/arm64/kernel/Makefile             |  3 ++-
 arch/arm64/kernel/machine_kexec_file.c | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..93dc4d36d6db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -858,6 +858,15 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	help
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4c8b13bede80..030a39bff117 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -49,8 +49,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..c38a8048ed00
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm64
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/kexec.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
-- 
2.19.0


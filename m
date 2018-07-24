Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F704C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0Z5Isxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AE720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeGXIDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46715 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbeGXIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so2176044pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KpsdpYdK4Ysd+TV+/RS+nNDg3tlVVRvIVtSFn8+W9VY=;
        b=C0Z5IsxhlehoOj3yXB1+CXNGBevv2cwHj7x6AgVewoFkRY3kQ0tSRABz0nl9YCj1A7
         dbVu0OsP4aLNOXDh73SV6cSH77OT6r6hfArvF0igrHylRoHNskMCSZJexXxcwKkK5zAa
         kiZ1NzeNxhvYrXTjlM3PLcerbGCrlh2W7MtMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KpsdpYdK4Ysd+TV+/RS+nNDg3tlVVRvIVtSFn8+W9VY=;
        b=V5i/4V7g8NdZJxfID8lmdKarPE38qwnY/u7P11AHiDKODUxDRy3wn3nwjCzgH3R2cU
         J3gHY/GRaCtMKOPsG6pyLvzaqUhm2G/Yhc/XQmsqyGXn3EeIIFnVayFIxZQxXDIgEY2J
         CcMWwpzG/LS14vn6ER+Hwp0SIsvbsjZWU6fMkBwizqfjjHUxVXX+9LQ93DYI1pQkzPjN
         hPAZLmmxGQhaZ14/XOVhRaY3DwHtikHe+9EVYiDv9dJAqmbeoakcLa6FMc8iQpcISs8D
         LAzV1yf+gNU0K6AdqEcztGK2NFsTanOG8WOoy/ltZ3mLgMTxNzso9R+LHSTNVK9PE+YK
         M85Q==
X-Gm-Message-State: AOUpUlHeLOQVp86uE1Hlg6OKp3Q0/pS47YiS2CriYqn3rd2cptZ/upuo
        66GMM6RciJ5BLOABjmCQGS6sSw==
X-Google-Smtp-Source: AAOMgpcULG9DUtF4Qj8tlxJwCcwKkpHAlGxDMh0oI9A/casaKsk54s8umNVVMPZ/tQO+WOGeKQZ2Lw==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr16287521pff.211.1532415506173;
        Mon, 23 Jul 2018 23:58:26 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u1-v6sm21299425pgk.25.2018.07.23.23.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:25 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 09/16] arm64: enable KEXEC_FILE config
Date:   Tue, 24 Jul 2018 15:57:52 +0900
Message-Id: <20180724065759.19186-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
index 42c090cf0292..a9a3a5583c8b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -835,6 +835,15 @@ config KEXEC
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
index 0025f8691046..06281e1ad7ed 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -48,8 +48,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
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
2.18.0


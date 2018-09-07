Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DF5206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMLoGtcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeIGMk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:40:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43742 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeIGMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:40:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3-v6so2872425plh.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wek53x727l+CC28Me3kZmv40INMNgym0MEOVv8aRsME=;
        b=aMLoGtcKbZtYcDTYknTxqNRmjzsz5TmpU8UWKlGEgq3ouS/mEmCdeUyli8+9dThfXm
         331KELwilkTkuU7ES4+trm/OnppENYt26MmHYfI5U7PogvC7XuwianlCKX3lWU4pV42N
         hI0QmcAvNmIyFcxP0XBOj904YNTV9anFCZLtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wek53x727l+CC28Me3kZmv40INMNgym0MEOVv8aRsME=;
        b=CQNHCcr8awDaulXZ8+NDmdNGP7nTbJw4Nl7y2mx8aLW3bYHFxTg8OimSvhrCqPgriV
         YjvwQeBJ2hAZYfLuxmj8jMddQTnyd92c6QSkqrjfiQgevCraAveRIo4NNYDesB0Not25
         tMT1FzeZJU/dl5Mjx7DGDwsk5rHRdx6qaNyNOw6KYKzD8DduThUzAX2PcCwFT/YDwPWp
         rBrgxIKaUOkgal0K3P5bAogjOh2vi8n41WKf5Hay7PqXBmH7q2pxGVnizdF4ki5dehEZ
         5tMD3/jsA3jNnbWNoknl9mWM2YjsD49B0uhflOr95OhjLZt5Z7b/WhrNDh4gYjKHFl2A
         IByA==
X-Gm-Message-State: APzg51CAFF2g8ISpKtFK7Zde00IvdhVUpapq4YygdnMA0XaVYCmcDENH
        QvCjGiqmI0fgZewX93xRwZL74w==
X-Google-Smtp-Source: ANB0VdaRLGOkhgdwdx5ZA853bM5ec5di05hYI5NIQX3kC/Mh1tlPBlsWe2J1CgjYl0U5po8U+DxUUA==
X-Received: by 2002:a17:902:464:: with SMTP id 91-v6mr6757431ple.125.1536307243989;
        Fri, 07 Sep 2018 01:00:43 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm9369907pgf.52.2018.09.07.01.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:00:43 -0700 (PDT)
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
Subject: [PATCH v14 09/16] arm64: enable KEXEC_FILE config
Date:   Fri,  7 Sep 2018 17:00:33 +0900
Message-Id: <20180907080040.4967-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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
index 1b1a0e95c751..5eb18d0cb513 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -843,6 +843,15 @@ config KEXEC
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
index 95ac7374d723..8f1326b2d327 100644
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
2.18.0


Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF377C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F5220841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvGOQIkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F5220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeHAJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:45:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42525 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeHAJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:45:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so10409523pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zriOn+WEEg9EazqAOYJi2TzU71K/MV/o6JIIMj34rno=;
        b=bvGOQIkvBmDgcU5RI5ZqVEOSB5GvKJdRU1fhcJKLV93+axy/cZ1PiiD3NNZDl/ziPl
         /6/wtfG6wc1FpL/b8nhxTUIIZ/s1R1Z5dokBhrcy8Tv/u8vTLYP9e/byweReQ7xqAfTx
         JkW3v0bv6J4jpyBeUp9+Xx+wJceiTDXkts/F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zriOn+WEEg9EazqAOYJi2TzU71K/MV/o6JIIMj34rno=;
        b=V0JxVyo52u5cZ+Gl0xSn6RFDrHMRo9x3vnns44xs3zpCrg/AeSlFQPQnp9S+fbpXjX
         lsjViiBaW5WJ4gicfoEYnlipr8ddZyz7tFJnI3SRq0USRj7n3O213e5lRCLGqk6z2KvL
         XIdBOTnoYymxUT9w52zX7kwJA/kiBpFTPWnla+PiP6U8q3FW9yJPBmDsoMgqAhABIDbI
         9re8IPt0nqo3VDhWCq0mmfjTIn2GlinzqBbdEe4YlH0a0JGhkLKk2aMlQaB8c5TH/I/J
         KvCAXOhiYXITN6Bm8hbdIF+bmqy2rnotZBJHA4Po498l6bEzvHmKwC9opAadF1WCTi63
         iOKA==
X-Gm-Message-State: AOUpUlHN9idp7B0LYRr3AZaqMRSD9wiwutUKqaltW/baCqIq783otqxv
        mB/dUQr0U55aGmhBsTsoeaaZxQ==
X-Google-Smtp-Source: AAOMgpdHFSgMIc0zWHMtsZGoCFGeEUhlkYGC6U/A20hTg3Ps7VQI585rzqHHoAHkb4/8n1FRB7QHaQ==
X-Received: by 2002:a63:5d58:: with SMTP id o24-v6mr23983744pgm.349.1533110442712;
        Wed, 01 Aug 2018 01:00:42 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g5-v6sm5201850pfh.63.2018.08.01.01.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:00:42 -0700 (PDT)
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
Subject: [PATCH v13 09/16] arm64: enable KEXEC_FILE config
Date:   Wed,  1 Aug 2018 16:58:13 +0900
Message-Id: <20180801075820.3753-10-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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
index 1494d5cfd681..5988e767526f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -852,6 +852,15 @@ config KEXEC
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


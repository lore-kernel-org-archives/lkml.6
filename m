Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C991F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAWLKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:10:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35959 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727237AbfAWLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:10:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651128"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:10:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A262A4BAC826;
        Wed, 23 Jan 2019 19:10:10 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:10:16 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>, <kasong@redhat.com>
Subject: [PATCH v16 5/7] x86/boot: Early parse RSDP and fill in boot_params
Date:   Wed, 23 Jan 2019 19:08:48 +0800
Message-ID: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A262A4BAC826.A90B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RSDP is needed by both KASLR, so parse it early and fill it in
boot_params before KASLR code.

RSDP is needed by lots of other code, it would be easier to have it
always built-in instead of a long "depends on" line in Kconfig.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/Makefile |  2 ++
 arch/x86/boot/compressed/acpi.c   | 22 ++++++++++++++++++++++
 arch/x86/boot/compressed/misc.c   |  7 +++++++
 arch/x86/boot/compressed/misc.h   |  7 +++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f0515ac895a4..96b71e52a2e8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,6 +84,8 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
 
+vmlinux-objs-y += $(obj)/acpi.o
+
 $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0c389a22bb86..c207791332c7 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -194,4 +194,26 @@ static acpi_physical_address bios_get_rsdp_addr(void)
 
 	return 0;
 }
+
+/*
+ * Very early parse RSDP, based on acpi_os_get_root_pointer().
+ * Return address of RSDP on success, 0 on failed to parse RSDP.
+ */
+acpi_physical_address get_rsdp_addr(void)
+{
+	acpi_physical_address pa;
+
+	pa = get_acpi_rsdp();
+
+	if (!pa)
+		pa = boot_params->acpi_rsdp_addr;
+
+	if (!pa)
+		pa = efi_get_rsdp_addr();
+
+	if (!pa)
+		pa = bios_get_rsdp_addr();
+
+	return pa;
+}
 #endif /* CONFIG_ACPI */
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..86fa8bf56d68 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -382,6 +382,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putaddr(trampoline_32bit);
 #endif
 
+	/*
+	 * Very early parse RSDP and fill in boot_params.
+	 * Early parsing is only executed once, and later anyone who
+	 * needs RSDP can gain RSDP address by boot_params but not parse again.
+	 */
+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+
 	/*
 	 * The memory hole needed for the kernel is the larger of either
 	 * the entire decompressed kernel plus relocation table, or the
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 764ad50c0119..e1dd15769cf3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -119,3 +119,10 @@ static inline void console_init(void)
 void set_sev_encryption_mask(void);
 
 #endif
+
+/* acpi.c */
+#ifdef CONFIG_ACPI
+acpi_physical_address get_rsdp_addr(void);
+#else
+static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
+#endif
-- 
2.20.1




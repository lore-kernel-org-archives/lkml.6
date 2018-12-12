Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E586C65BAE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2A82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeLLDLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:11:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52699 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbeLLDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:11:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="49566313"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Dec 2018 11:11:28 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0EAAF4B734D7;
        Wed, 12 Dec 2018 11:11:27 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 11:11:32 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
Date:   Wed, 12 Dec 2018 11:10:49 +0800
Message-ID: <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0EAAF4B734D7.AE6C9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory information in SRAT is necessary to fix the conflict between
KASLR and memory-hotremove.

ACPI SRAT (System/Static Resource Affinity Table) shows the details
about memory ranges, including ranges of memory provided by hot-added
memory devices. SRAT is introduced by Root System Description
Pointer(RSDP). So RSDP should be found firstly.

When booting form KEXEC/EFI/BIOS, the methods to find RSDP
are different. When booting from KEXEC, 'acpi_rsdp' may have been
added to cmdline, so parse cmdline to find RSDP.

Since 'RANDOMIZE_BASE' && 'MEMORY_HOTREMOVE' is needed, introduce
'CONFIG_EARLY_PARSE_RSDP' to make ifdeffery clear.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/Kconfig                | 10 ++++++++++
 arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  6 ++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpi.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..455da382fa9e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2149,6 +2149,16 @@ config X86_NEED_RELOCS
 	def_bool y
 	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
 
+config EARLY_PARSE_RSDP
+	bool "Parse RSDP pointer on compressed period for KASLR"
+	def_bool y
+	depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE
+	help
+	  This option parses RSDP in compressed period. Works
+	  for KASLR to get memory information from SRAT table and choose
+	  immovable memory to extract kernel.
+	  Say Y if you want to use both KASLR and memory-hotremove.
+
 config PHYSICAL_ALIGN
 	hex "Alignment value to which kernel should be aligned"
 	default "0x200000"
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
new file mode 100644
index 000000000000..cad15686f82c
--- /dev/null
+++ b/arch/x86/boot/compressed/acpi.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "error.h"
+
+#include <linux/efi.h>
+#include <linux/numa.h>
+#include <linux/acpi.h>
+#include <asm/efi.h>
+
+#define STATIC
+#include <linux/decompress/mm.h>
+
+#include "../string.h"
+
+static acpi_physical_address get_acpi_rsdp(void)
+{
+#ifdef CONFIG_KEXEC
+	unsigned long long res;
+	int len = 0;
+	char val[MAX_ADDRESS_LENGTH+1];
+
+	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
+	if (len > 0) {
+		val[len] = 0;
+		return (acpi_physical_address)kstrtoull(val, 16, &res);
+	}
+	return 0;
+#endif
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a1d5918765f3..72fcfbfec3c6 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -116,3 +116,9 @@ static inline void console_init(void)
 void set_sev_encryption_mask(void);
 
 #endif
+
+/* acpi.c */
+#ifdef CONFIG_EARLY_PARSE_RSDP
+/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digit. */
+#define MAX_ADDRESS_LENGTH 18
+#endif
-- 
2.19.2




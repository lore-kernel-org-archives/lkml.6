Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07092C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2020859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfAGDYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:24:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15462 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbfAGDXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:23:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,449,1539619200"; 
   d="scan'208";a="51438963"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 11:23:45 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 256BC4B7EC57;
        Mon,  7 Jan 2019 11:23:38 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 11:23:43 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find RSDP from EFI table
Date:   Mon, 7 Jan 2019 11:22:40 +0800
Message-ID: <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 256BC4B7EC57.A880F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory information in SRAT is necessary to fix the conflict between
KASLR and memory-hotremove. So RSDP and SRAT should be parsed.

When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
are different. When booting from EFI, EFI table points to RSDP.
So parse the EFI table and find the RSDP.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 7ca5001d7639..f74c5d033d79 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -5,6 +5,8 @@
 #include "../string.h"
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
+#include <asm/efi.h>
 
 /*
  * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
@@ -28,3 +30,84 @@ static acpi_physical_address get_acpi_rsdp(void)
 #endif
 	return 0;
 }
+
+/* Search EFI table for RSDP. */
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
+	acpi_physical_address rsdp_addr = 0;
+#ifdef CONFIG_EFI
+	efi_system_table_t *systab;
+	struct efi_info *ei;
+	bool efi_64;
+	char *sig;
+	int size;
+	int i;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		efi_64 = true;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		efi_64 = false;
+	} else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return 0;
+	}
+
+	/* Get systab from boot params. Based on efi_init(). */
+#ifdef CONFIG_X86_64
+	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
+#else
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
+		return 0;
+	}
+	systab = (efi_system_table_t *)ei->efi_systab;
+#endif
+
+	if (!systab)
+		error("EFI system table is not found.");
+
+	/*
+	 * Get EFI tables from systab. Based on efi_config_init() and
+	 * efi_config_parse_tables().
+	 */
+	size = efi_64 ? sizeof(efi_config_table_64_t) :
+			sizeof(efi_config_table_32_t);
+
+	for (i = 0; i < systab->nr_tables; i++) {
+		void *config_tables;
+		unsigned long table;
+		efi_guid_t guid;
+
+		config_tables = (void *)(systab->tables + size * i);
+		if (efi_64) {
+			efi_config_table_64_t *tmp_table;
+			u64 table64;
+
+			tmp_table = config_tables;
+			guid = tmp_table->guid;
+			table64 = tmp_table->table;
+			table = table64;
+
+			if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
+				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
+				return 0;
+			}
+		} else {
+			efi_config_table_32_t *tmp_table;
+
+			tmp_table = config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+		}
+
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+			rsdp_addr = table;
+		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+			return table;
+	}
+#endif
+	return rsdp_addr;
+}
-- 
2.20.1




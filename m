Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8220989
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A8220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeLLDLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:11:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51216 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbeLLDLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:11:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="49566318"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Dec 2018 11:11:28 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id CB8BA4B75BD3;
        Wed, 12 Dec 2018 11:11:28 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 11:11:33 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v13 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find RSDP from EFI table
Date:   Wed, 12 Dec 2018 11:10:50 +0800
Message-ID: <20181212031053.1815-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: CB8BA4B75BD3.AB884
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
 arch/x86/boot/compressed/acpi.c | 79 +++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index cad15686f82c..c96008712ec9 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -28,3 +28,82 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return 0;
 #endif
 }
+
+/* Search EFI table for RSDP. */
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
+#ifdef CONFIG_EFI
+	acpi_physical_address rsdp_addr = 0;
+	efi_system_table_t *systab;
+	struct efi_info *e;
+	bool efi_64;
+	char *sig;
+	int size;
+	int i;
+
+	e = &boot_params->efi_info;
+	sig = (char *)&e->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4))
+		efi_64 = true;
+	else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4))
+		efi_64 = false;
+	else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return 0;
+	}
+
+	/* Get systab from boot params. Based on efi_init(). */
+#ifdef CONFIG_X86_64
+	systab = (efi_system_table_t *)(e->efi_systab | ((__u64)e->efi_systab_hi<<32));
+#else
+	if (e->efi_systab_hi || e->efi_memmap_hi) {
+		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
+		return 0;
+	}
+	systab = (efi_system_table_t *)e->efi_systab;
+#endif
+
+	if (!systab)
+		return 0;
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
+
+			tmp_table = (efi_config_table_64_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+
+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
+				debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
+				return 0;
+			}
+		} else {
+			efi_config_table_32_t *tmp_table;
+
+			tmp_table = (efi_config_table_32_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+		}
+
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+			rsdp_addr = (acpi_physical_address)table;
+		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+			return (acpi_physical_address)table;
+	}
+	return rsdp_addr;
+#endif
+}
-- 
2.19.2




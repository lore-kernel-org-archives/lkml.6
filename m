Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F027EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1312150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1312150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJQSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:16:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62672 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbeJQSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:16:09 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46265548"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Oct 2018 18:21:05 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9AA654B6ED70;
        Wed, 17 Oct 2018 18:21:02 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 18:21:08 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 3/8] x86/boot: Add efi_get_rsdp_addr() to dig out RSDP from EFI table
Date:   Wed, 17 Oct 2018 18:20:07 +0800
Message-ID: <20181017102012.872-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9AA654B6ED70.AE76A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug that kaslr may randomly choose some positions
which are located in movable memory regions. This will break memory
hotplug feature and make the movable memory chosen by KASLR can't be
removed. So dig SRAT table from ACPI tables to get memory information.

Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
tables. Since some operations are not needed here, functions are
simplified. Functions will be used to dig only SRAT tables to get
information of memory, so that KASLR can the memory in immovable node.

This function works for EFI. Dig RSDP from EFI tabler, based on efi_init().

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.c | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.c

diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
new file mode 100644
index 000000000000..56b54b0e0889
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "error.h"
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include <linux/numa.h>
+#include <linux/acpi.h>
+
+/* Search EFI table for RSDP table. */
+static void efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+#ifdef CONFIG_EFI
+	efi_system_table_t *systab;
+	bool efi_64 = false;
+	void *config_tables;
+	struct efi_info *e;
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
+		return;
+	}
+
+	/* Get systab from boot params. Based on efi_init(). */
+#ifdef CONFIG_X86_64
+	systab = (efi_system_table_t *)(
+			e->efi_systab | ((__u64)e->efi_systab_hi<<32));
+#else
+	if (e->efi_systab_hi || e->efi_memmap_hi) {
+		debug_putstr("Table located above 4GB. EFI should be disabled.\n");
+		return;
+	}
+	systab = (efi_system_table_t *)e->efi_systab;
+#endif
+
+	if (!systab)
+		return;
+
+	/*
+	 * Get EFI tables from systab. Based on efi_config_init() and
+	 * efi_config_parse_tables(). Only dig out the config_table.
+	 */
+	size = efi_64 ? sizeof(efi_config_table_64_t) :
+			sizeof(efi_config_table_32_t);
+
+	for (i = 0; i < systab->nr_tables; i++) {
+		efi_guid_t guid;
+		unsigned long table;
+
+		config_tables = (void *)(systab->tables + size * i);
+		if (efi_64) {
+			efi_config_table_64_t *tmp_table;
+
+			tmp_table = (efi_config_table_64_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+#ifndef CONFIG_64BIT
+			if (table >> 32) {
+				debug_putstr("Table located above 4G. EFI should be disabled.\n");
+				return;
+			}
+#endif
+		} else {
+			efi_config_table_32_t *tmp_table;
+
+			tmp_table = (efi_config_table_32_t *)config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+		}
+
+		/*
+		 * Get RSDP from EFI tables.
+		 * If ACPI20 table found, use it.
+		 * If ACPI20 table not found, but ACPI table found,
+		 * use the ACPI table.
+		 */
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+			return;
+		}
+	}
+#endif
+}
-- 
2.17.2




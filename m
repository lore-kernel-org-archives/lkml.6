Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D2DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72F521906
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F521906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbeHGJFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:05:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51501 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeHGJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:05:30 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43158018"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2018 14:52:33 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id AFA324B6ADE3;
        Tue,  7 Aug 2018 14:52:31 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 14:52:30 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <n-horiguchi@ah.jp.nec.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v5 2/4] x86/boot: Add acpitb.c to parse acpi tables
Date:   Tue, 7 Aug 2018 14:49:58 +0800
Message-ID: <20180807065000.30958-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: AFA324B6ADE3.AD9E6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imitate the ACPI code to parse ACPI tables. Functions are simplified
cause some operations are not needed here.
And also, this method won't influence the initialization of ACPI.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/Makefile |   4 +
 arch/x86/boot/compressed/acpitb.c | 272 ++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 169c2feda14a..a382bb50f599 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -83,6 +83,10 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
 
+ifdef CONFIG_MEMORY_HOTREMOVE
+vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/acpitb.o
+endif
+
 $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
diff --git a/arch/x86/boot/compressed/acpitb.c b/arch/x86/boot/compressed/acpitb.c
new file mode 100644
index 000000000000..a1ec0d9313fe
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "acpitb.h"
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+#include <linux/numa.h>
+
+extern unsigned long get_cmd_line_ptr(void);
+
+#ifdef CONFIG_EFI
+/* Search EFI table for rsdp table. */
+static bool efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	efi_system_table_t *systab;
+	bool find_rsdp = false;
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
+		return false;
+	}
+
+	/* Get systab from boot params. Based on efi_init(). */
+#ifdef CONFIG_X86_32
+	if (e->efi_systab_hi || e->efi_memmap_hi) {
+		debug_putstr("Table located above 4GB, disabling EFI.\n");
+		return false;
+	}
+	systab = (efi_system_table_t *)e->efi_systab;
+#else
+	systab = (efi_system_table_t *)(
+			e->efi_systab | ((__u64)e->efi_systab_hi<<32));
+#endif
+
+	if (systab == NULL)
+		return false;
+
+	/*
+	 * Get EFI tables from systab. Based on efi_config_init() and
+	 * efi_config_parse_tables(). Only dig the useful tables but not
+	 * do the initialization jobs.
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
+				debug_putstr("Table located above 4G, disabling EFI.\n");
+				return false;
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
+		 * Get rsdp from EFI tables.
+		 * If ACPI20 table found, use it and return true.
+		 * If ACPI20 table not found, but ACPI table found,
+		 * use the ACPI table and return true.
+		 * If neither ACPI table nor ACPI20 table found,
+		 * return false.
+		 */
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+			find_rsdp = true;
+		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+			return true;
+		}
+	}
+	return find_rsdp;
+}
+#else
+static bool efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	return false;
+}
+#endif
+
+static u8 checksum(u8 *buffer, u32 length)
+{
+	u8 sum = 0;
+	u8 *end = buffer + length;
+
+	while (buffer < end)
+		sum = (u8)(sum + *(buffer++));
+
+	return sum;
+}
+
+/*
+ * Used to search a block of memory for the RSDP signature.
+ * Return Pointer to the RSDP if found, otherwise NULL.
+ * Based on acpi_tb_scan_memory_for_rsdp().
+ */
+static u8 *scan_mem_for_rsdp(u8 *start_address, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *end_address;
+	u8 *mem_rover;
+
+	end_address = start_address + length;
+
+	/* Search from given start address for the requested length */
+	for (mem_rover = start_address; mem_rover < end_address;
+	     mem_rover += ACPI_RSDP_SCAN_STEP) {
+		/* The RSDP signature and checksum must both be correct */
+		rsdp = (struct acpi_table_rsdp *)mem_rover;
+		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+			continue;
+		if (checksum((u8 *) rsdp, ACPI_RSDP_CHECKSUM_LENGTH) != 0)
+			continue;
+		if ((rsdp->revision >= 2) &&
+		    (checksum((u8 *) rsdp, ACPI_RSDP_XCHECKSUM_LENGTH) != 0))
+			continue;
+
+		/* Sig and checksum valid, we have found a real RSDP */
+		return mem_rover;
+	}
+	return NULL;
+}
+
+/*
+ * Used to search RSDP physical address.
+ * Based on acpi_find_root_pointer(). Since only use physical address
+ * in this period, so there is no need to do the memory map jobs.
+ */
+static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *table_ptr;
+	u8 *mem_rover;
+	u32 address;
+
+	/* Get the location of the Extended BIOS Data Area (EBDA) */
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	*(u32 *)(void *)&address = *(u16 *)(void *)table_ptr;
+	address <<= 4;
+	table_ptr = (u8 *)(acpi_physical_address)address;
+
+	/*
+	 * Search EBDA paragraphs (EBDA is required to be a minimum of
+	 * 1K length)
+	 */
+	if (address > 0x400) {
+		mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
+
+		if (mem_rover) {
+			address += (u32)ACPI_PTR_DIFF(mem_rover, table_ptr);
+			*rsdp_addr = (acpi_physical_address)address;
+			return;
+		}
+	}
+
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	mem_rover = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+
+	/*
+	 * Search upper memory: 16-byte boundaries in E0000h-FFFFFh
+	 */
+	if (mem_rover) {
+		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
+				ACPI_PTR_DIFF(mem_rover, table_ptr));
+		*rsdp_addr = (acpi_physical_address)address;
+		return;
+	}
+}
+
+/*
+ * Used to dig rsdp table from EFI table or BIOS.
+ * If rsdp table found in EFI table, use it. Or search BIOS.
+ * Based on acpi_os_get_root_pointer().
+ */
+static acpi_physical_address get_rsdp_addr(void)
+{
+	acpi_physical_address pa = 0;
+	bool status = false;
+
+	status = efi_get_rsdp_addr(&pa);
+
+	if (!status || pa == 0)
+		bios_get_rsdp_addr(&pa);
+
+	return pa;
+}
+
+struct acpi_table_header *get_acpi_srat_table(void)
+{
+	char *args = (char *)get_cmd_line_ptr();
+	acpi_physical_address acpi_table;
+	acpi_physical_address root_table;
+	struct acpi_table_header *header;
+	struct acpi_table_rsdp *rsdp;
+	char *signature;
+	u8 *entry;
+	u32 count;
+	u32 size;
+	int i, j;
+	u32 len;
+
+	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
+	if (!rsdp)
+		return NULL;
+
+	/* Get rsdt or xsdt from rsdp. */
+	if (!strstr(args, "acpi=rsdt") &&
+	    rsdp->xsdt_physical_address && rsdp->revision > 1) {
+		root_table = rsdp->xsdt_physical_address;
+		size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		root_table = rsdp->rsdt_physical_address;
+		size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	/* Get ACPI root table from rsdt or xsdt.*/
+	header = (struct acpi_table_header *)root_table;
+	len = header->length;
+	count = (u32)((len - sizeof(struct acpi_table_header)) / size);
+	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
+
+	for (i = 0; i < count; i++) {
+		u64 address64;
+
+		if (size == ACPI_RSDT_ENTRY_SIZE)
+			acpi_table = ((acpi_physical_address)
+				      (*ACPI_CAST_PTR(u32, entry)));
+		else {
+			*(u64 *)(void *)&address64 = *(u64 *)(void *)entry;
+			acpi_table = (acpi_physical_address) address64;
+		}
+
+		if (acpi_table) {
+			header = (struct acpi_table_header *)acpi_table;
+			signature = header->signature;
+
+			if (!strncmp(signature, "SRAT", 4))
+				return header;
+		}
+		entry += size;
+	}
+	return NULL;
+}
-- 
2.17.1




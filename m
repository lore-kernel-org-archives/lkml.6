Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A58C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A58C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeGWKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:32:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29981 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388151AbeGWKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:31:47 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42543719"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jul 2018 17:31:13 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id C12A54B66A09;
        Mon, 23 Jul 2018 17:31:12 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Mon, 23 Jul 2018
 17:31:13 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v4 2/4] x86/boot: Add acpitb.c to parse acpi tables
Date:   Mon, 23 Jul 2018 17:29:06 +0800
Message-ID: <20180723092908.32656-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: C12A54B66A09.AB5ED
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
 arch/x86/boot/compressed/acpitb.c | 251 ++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index fa42f895fdde..41017dc98b61 100644
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
index 000000000000..5f73c8711f89
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.c
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+/* Search efi table for rsdp table. */
+static bool efi_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	efi_system_table_t *systab;
+	bool find_rsdp = false;
+	bool acpi_20 = false;
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
+		debug_putstr("Wrong efi loader signature.\n");
+		return false;
+	}
+
+	/* Get systab from boot params. */
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
+	/* Get efi tables from systab. */
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
+		 * Get rsdp from efi tables.
+		 * If we find acpi table, go on searching for acpi20 table.
+		 * If we didn't get acpi20 table then use acpi table.
+		 * If neither acpi table nor acpi20 table found,
+		 * return false.
+		 */
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)) && !acpi_20) {
+			*rsdp_addr = (acpi_physical_address)table;
+			acpi_20 = false;
+			find_rsdp = true;
+		} else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID))) {
+			*rsdp_addr = (acpi_physical_address)table;
+			acpi_20 = true;
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
+static u8 *scan_memory_for_rsdp(u8 *start_address, u32 length)
+{
+	struct acpi_table_rsdp *rsdp;
+	u8 *end_address;
+	u8 *mem_rover;
+
+	end_address = start_address + length;
+
+	for (mem_rover = start_address; mem_rover < end_address;
+	     mem_rover += ACPI_RSDP_SCAN_STEP) {
+		rsdp = (struct acpi_table_rsdp *)mem_rover;
+		if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature))
+			continue;
+		if (checksum((u8 *) rsdp,
+		    ACPI_RSDP_CHECKSUM_LENGTH) != 0)
+			continue;
+		if ((rsdp->revision >= 2) && (checksum((u8 *)
+		    rsdp, ACPI_RSDP_XCHECKSUM_LENGTH) != 0))
+			continue;
+		return mem_rover;
+	}
+	return NULL;
+}
+
+static void bios_get_rsdp_addr(acpi_physical_address *rsdp_addr)
+{
+	struct acpi_table_rsdp *rsdp;
+	u32 physical_address;
+	u8 *table_ptr;
+	u8 *mem_rover;
+
+	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
+	*(u32 *)(void *)&physical_address = *(u16 *)(void *)table_ptr;
+	physical_address <<= 4;
+	table_ptr = (u8 *)(acpi_physical_address)physical_address;
+
+	if (physical_address > 0x400) {
+		mem_rover = scan_memory_for_rsdp(table_ptr,
+						 ACPI_EBDA_WINDOW_SIZE);
+
+		if (mem_rover) {
+			physical_address += (u32)ACPI_PTR_DIFF(mem_rover,
+							       table_ptr);
+			*rsdp_addr = (acpi_physical_address)physical_address;
+			return;
+		}
+	}
+
+	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
+	mem_rover = scan_memory_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
+
+	if (mem_rover) {
+		physical_address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
+					 ACPI_PTR_DIFF(mem_rover, table_ptr));
+		*rsdp_addr = (acpi_physical_address)physical_address;
+		return;
+	}
+}
+
+/*
+ * Used to dig rsdp table from efi table or bios.
+ * If rsdp table found in efi table, use it. Or search bios.
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
+	u32 size;
+	u8 *entry;
+	u32 count;
+	int i, j;
+	u32 len;
+
+	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
+	if (!rsdp)
+		return NULL;
+
+	/* Get rsdt or xsdt from rsdp. */
+	if (!strstr(args, "acpi=rsdt") &&
+	    rsdp->xsdt_physical_address &&
+	    rsdp->revision > 1) {
+		root_table = rsdp->xsdt_physical_address;
+		size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		root_table = rsdp->rsdt_physical_address;
+		size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	/* Get acpi root table from rsdt or xsdt.*/
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




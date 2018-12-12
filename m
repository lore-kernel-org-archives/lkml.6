Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E055FC65BAE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E7B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLLDLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:11:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51242 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726412AbeLLDLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:11:37 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="49566327"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Dec 2018 11:11:34 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3F94A4B714D5;
        Wed, 12 Dec 2018 11:11:32 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 11:11:37 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v13 5/6] x86/boot: Parse SRAT from RSDP and store immovable memory
Date:   Wed, 12 Dec 2018 11:10:52 +0800
Message-ID: <20181212031053.1815-6-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 3F94A4B714D5.A85D0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRAT should be parsed by RSDP to fix the conflict between KASLR
and memory-hotremove, then find the immovable memory regions and store
them in an array called immovable_mem[]. With immovable_mem[], KASLR
can avoid to extract kernel to specific regions.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/Makefile |   2 +
 arch/x86/boot/compressed/acpi.c   | 128 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c  |   4 -
 arch/x86/boot/compressed/misc.h   |  15 ++++
 4 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 466f66c8a7f8..bcc6560fb2ec 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -84,6 +84,8 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 endif
 
+vmlinux-objs-$(CONFIG_EARLY_PARSE_RSDP) += $(obj)/acpi.o
+
 $(obj)/eboot.o: KBUILD_CFLAGS += -fshort-wchar -mno-red-zone
 
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(obj)/eboot.o $(obj)/efi_stub_$(BITS).o \
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c546a463b8ba..6fa0a1ff5ba0 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -13,6 +13,9 @@
 
 #include "../string.h"
 
+/* Store the immovable memory regions. */
+struct mem_vector immovable_mem[MAX_NUMNODES*2];
+
 static acpi_physical_address get_acpi_rsdp(void)
 {
 #ifdef CONFIG_KEXEC
@@ -192,3 +195,128 @@ static acpi_physical_address bios_get_rsdp_addr(void)
 		return (acpi_physical_address)address;
 	}
 }
+
+/* Determine RSDP, based on acpi_os_get_root_pointer(). */
+static acpi_physical_address get_rsdp_addr(void)
+{
+	acpi_physical_address pa = 0;
+
+	pa = get_acpi_rsdp();
+
+	if (!pa)
+		pa = efi_get_rsdp_addr();
+
+	if (!pa)
+		pa = bios_get_rsdp_addr();
+
+	return pa;
+}
+
+/* Compute SRAT address from RSDP. */
+static struct acpi_table_header *get_acpi_srat_table(void)
+{
+	acpi_physical_address acpi_table;
+	acpi_physical_address root_table;
+	struct acpi_table_header *header;
+	struct acpi_table_rsdp *rsdp;
+	u32 num_entries;
+	char arg[10];
+	u8 *entry;
+	u32 size;
+	u32 len;
+
+	rsdp = (struct acpi_table_rsdp *)get_rsdp_addr();
+	if (!rsdp)
+		return NULL;
+
+	/* Get RSDT or XSDT from RSDP. */
+	if (!(cmdline_find_option("acpi", arg, sizeof(arg)) == 4 &&
+	    !strncmp(arg, "rsdt", 4)) &&
+	    rsdp->xsdt_physical_address &&
+	    rsdp->revision > 1) {
+		root_table = rsdp->xsdt_physical_address;
+		size = ACPI_XSDT_ENTRY_SIZE;
+	} else {
+		root_table = rsdp->rsdt_physical_address;
+		size = ACPI_RSDT_ENTRY_SIZE;
+	}
+
+	/* Get ACPI root table from RSDT or XSDT.*/
+	header = (struct acpi_table_header *)root_table;
+	if (!header)
+		return NULL;
+
+	len = header->length;
+	if (len < sizeof(struct acpi_table_header) + size)
+		return NULL;
+
+	num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);
+	entry = ACPI_ADD_PTR(u8, header, sizeof(struct acpi_table_header));
+
+	while (num_entries--) {
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
+
+			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
+				return header;
+		}
+		entry += size;
+	}
+	return NULL;
+}
+
+/*
+ * According to ACPI table, filter the immovable memory regions
+ * and store them in immovable_mem[].
+ */
+void get_immovable_mem(void)
+{
+	struct acpi_table_header *table_header;
+	struct acpi_subtable_header *table;
+	struct acpi_srat_mem_affinity *ma;
+	unsigned long table_end;
+	char arg[10];
+	int i = 0;
+
+	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
+	    !strncmp(arg, "off", 3))
+		return;
+
+	table_header = get_acpi_srat_table();
+	if (!table_header)
+		return;
+
+	table_end = (unsigned long)table_header + table_header->length;
+	table = (struct acpi_subtable_header *)
+		((unsigned long)table_header + sizeof(struct acpi_table_srat));
+
+	while (((unsigned long)table) +
+		       sizeof(struct acpi_subtable_header) < table_end) {
+		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
+			ma = (struct acpi_srat_mem_affinity *)table;
+			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
+				immovable_mem[i].start = ma->base_address;
+				immovable_mem[i].size = ma->length;
+				i++;
+			}
+
+			if (i >= MAX_NUMNODES*2) {
+				debug_putstr("Too many immovable memory regions, aborting.\n");
+				return;
+			}
+		}
+		table = (struct acpi_subtable_header *)
+			((unsigned long)table + table->length);
+	}
+	num_immovable_mem = i;
+}
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709d9947..b251572e77af 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -87,10 +87,6 @@ static unsigned long get_boot_seed(void)
 #define KASLR_COMPRESSED_BOOT
 #include "../../lib/kaslr.c"
 
-struct mem_vector {
-	unsigned long long start;
-	unsigned long long size;
-};
 
 /* Only supporting at most 4 unusable memmap regions with kaslr */
 #define MAX_MEMMAP_REGIONS	4
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 72fcfbfec3c6..c6b4c8c3c2fc 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -77,6 +77,11 @@ void choose_random_location(unsigned long input,
 			    unsigned long *output,
 			    unsigned long output_size,
 			    unsigned long *virt_addr);
+struct mem_vector {
+	unsigned long long start;
+	unsigned long long size;
+};
+
 /* cpuflags.c */
 bool has_cpuflag(int flag);
 #else
@@ -118,7 +123,17 @@ void set_sev_encryption_mask(void);
 #endif
 
 /* acpi.c */
+#ifdef CONFIG_RANDOMIZE_BASE
+/* Amount of immovable memory regions */
+int num_immovable_mem;
+#endif
+
 #ifdef CONFIG_EARLY_PARSE_RSDP
+void get_immovable_mem(void);
 /* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digit. */
 #define MAX_ADDRESS_LENGTH 18
+#else
+static void get_immovable_mem(void)
+{
+}
 #endif
-- 
2.19.2




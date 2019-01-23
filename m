Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B06C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C455E21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfAWLKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:10:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35959 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfAWLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:10:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651127"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:10:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 89FF14B4030E;
        Wed, 23 Jan 2019 19:10:12 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:10:18 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>, <kasong@redhat.com>
Subject: [PATCH v16 6/7] x86/boot: Parse SRAT address from RSDP and store immovable memory
Date:   Wed, 23 Jan 2019 19:08:49 +0800
Message-ID: <20190123110850.12433-7-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 89FF14B4030E.A94B8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SRAT should be parsed by RSDP to fix the conflict between KASLR and
memory-hotremove, then filter the immovable memory regions and
accoring to the memory information, KASLR can avoid to extract kernel
to movable memory regions.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c  | 122 +++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c |   4 -
 arch/x86/boot/compressed/misc.h  |  11 +++
 3 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c207791332c7..11dec68501c5 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -4,9 +4,23 @@
 #include "error.h"
 #include "../string.h"
 
+#include <linux/numa.h>
 #include <linux/efi.h>
 #include <asm/efi.h>
 
+/*
+ * Longest parameter of 'acpi=' is 'copy_dsdt', plus an extra '\0'
+ * for termination.
+ */
+#define MAX_ACPI_ARG_LENGTH 10
+
+/*
+ * Information of immovable memory regions.
+ * Max amount of memory regions is MAX_NUMNODES*2, so need such array
+ * to place immovable memory regions if all of the memory is immovable.
+ */
+struct mem_vector immovable_mem[MAX_NUMNODES*2];
+
 #ifdef CONFIG_ACPI
 
 /*
@@ -217,3 +231,111 @@ acpi_physical_address get_rsdp_addr(void)
 	return pa;
 }
 #endif /* CONFIG_ACPI */
+
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+/* Compute SRAT address from RSDP. */
+static unsigned long get_acpi_srat_table(void)
+{
+	unsigned long root_table, acpi_table;
+	struct acpi_table_header *header;
+	struct acpi_table_rsdp *rsdp;
+	u32 num_entries, size, len;
+	char arg[10];
+	u8 *entry;
+
+	rsdp = (struct acpi_table_rsdp *)(long)boot_params->acpi_rsdp_addr;
+	if (!rsdp)
+		return 0;
+
+	/* Get ACPI root table from RSDP.*/
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
+	if (!root_table)
+		return 0;
+
+	header = (struct acpi_table_header *)root_table;
+	len = header->length;
+	if (len < sizeof(struct acpi_table_header) + size)
+		return 0;
+
+	num_entries = (len - sizeof(struct acpi_table_header)) / size;
+	entry = (u8 *)(root_table + sizeof(struct acpi_table_header));
+
+	while (num_entries--) {
+		if (size == ACPI_RSDT_ENTRY_SIZE)
+			acpi_table = *(u32 *)entry;
+		else
+			acpi_table = *(u64 *)entry;
+
+		if (acpi_table) {
+			header = (struct acpi_table_header *)acpi_table;
+
+			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
+				return acpi_table;
+		}
+		entry += size;
+	}
+	return 0;
+}
+
+/**
+ * count_immovable_mem_regions - early parse SRAT, filter immovable
+ * memory regions
+ *
+ * Return amount of immovable memory regions on success, 0 on
+ * - Too many immovable memory regions
+ * - ACPI off or no SRAT found
+ * - No immovable memory region found
+ */
+int count_immovable_mem_regions(void)
+{
+	unsigned long table_addr, table_end, table;
+	struct acpi_subtable_header *sub_table;
+	struct acpi_table_header *table_header;
+	char arg[MAX_ACPI_ARG_LENGTH];
+	int num = 0;
+
+	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
+	    !strncmp(arg, "off", 3))
+		return 0;
+
+	table_addr = get_acpi_srat_table();
+	if (!table_addr)
+		return 0;
+
+	table_header = (struct acpi_table_header *)table_addr;
+	table_end = table_addr + table_header->length;
+	table = table_addr + sizeof(struct acpi_table_srat);
+
+	while (table + sizeof(struct acpi_subtable_header) < table_end) {
+		sub_table = (struct acpi_subtable_header *)table;
+		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
+			struct acpi_srat_mem_affinity *ma;
+
+			ma = (struct acpi_srat_mem_affinity *)sub_table;
+			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) &&
+			    ma->length) {
+				immovable_mem[num].start = ma->base_address;
+				immovable_mem[num].size = ma->length;
+				num++;
+			}
+
+			if (num >= MAX_NUMNODES*2) {
+				debug_putstr("Too many immovable memory regions, aborting.\n");
+				return 0;
+			}
+		}
+		table += sub_table->length;
+	}
+	return num;
+}
+#endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
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
index e1dd15769cf3..6fc51cebec7e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -80,6 +80,11 @@ void choose_random_location(unsigned long input,
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
@@ -126,3 +131,9 @@ acpi_physical_address get_rsdp_addr(void);
 #else
 static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
 #endif
+
+#if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+int count_immovable_mem_regions(void);
+#else
+static inline int count_immovable_mem_regions(void) { return 0; }
+#endif
-- 
2.20.1




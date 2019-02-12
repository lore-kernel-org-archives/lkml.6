Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1635B21855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUpiRDkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBLBb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:31:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35853 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBLBb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:31:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id r9so1162205qtt.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 17:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=se8DIhls4Mz2GTWYcHX5tB6yt7Dg/EP+UTRelAdQmeQ=;
        b=FUpiRDkU87J/DOUJGnvx4h9zW/uT7VlJL3L8G8uUKIWPVZzxYUbFhiWtxc6lDUZzzh
         BPgBtWbP5ihwFjR+3L/mYwIuvGMKqTCNFhe+72MLzB2CRqUBmZVztSSdQtGQ4w3NDqpe
         BOthZzZPuRvlrQxhll8VnSFsVC1z3lGW+HEVM94QDD5p6VugKY82UVttw+DgIhMINBln
         uuFmSFTWAcSZzzfnsPfQbjQ0Qom/Nk1yRya0OPE0s6ZQHq26yCFWnlMoUW4QQw2L0ZxR
         I4ff3czYtyaorte54d9wd+NMTK/534utmwXpjZ27/OaoexZAu42YURCrf3GQM0AIbOe3
         KWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=se8DIhls4Mz2GTWYcHX5tB6yt7Dg/EP+UTRelAdQmeQ=;
        b=ipb191zslBWAJ9o12bi0RvJKgfl++RmcNgyjxSAW2qFgSsmTHXVEd7aW1K1gK+cm4J
         u9sgn6+ePOCaMUh8M0MswP+fWyUrOZOED36uquhLgDhomZKKGBcEs4xO4kJ0m8JmlvZ4
         Ga5MxoSL3PDfAbk7Tg6UHnv55yQUKuizNmbFi1JxHb9iIU2hH1IfB0mG/hUaPVARJ4hL
         Xqs8rp7VRUxpIddGjBzeV2/VlcjjyIRXCH8Do5gXAz82sDMNCbMJGKfssO2aNym2XJyC
         PbR4xFREqGU8MVStwKZy2+nir2TYK8Ch6+N+xp2nCNN+llZKX288ew/r1c0j0kkexm1P
         PNuA==
X-Gm-Message-State: AHQUAubn4o1bXwGRE215E4IlmMeBBKxUIOjguJaPkaSQgmAobyEnOMQP
        JIf+WVgsHqrN1wlfawoiuw==
X-Google-Smtp-Source: AHgI3IYHfgrJpCEtiFZSkTWESUlDjyN5o+9OJl6qsSyga/y0HINaeM4Xh2dUnUwr9D7HA8MKRAMp6Q==
X-Received: by 2002:ac8:38fc:: with SMTP id g57mr909411qtc.39.1549935086872;
        Mon, 11 Feb 2019 17:31:26 -0800 (PST)
Received: from gabell.redhat.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id g189sm13072950qkb.3.2019.02.11.17.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 17:31:25 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v2] x86/mm: Adjust the padding size for KASLR
Date:   Mon, 11 Feb 2019 20:31:18 -0500
Message-Id: <20190212013118.28203-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system sometimes crashes while memory hot-adding on KASLR
enabled system. The crash happens because the regions pointed by
kaslr_regions[].base are overwritten by the hot-added memory.

It happens because of the padding size for kaslr_regions[].base isn't
enough for the system whose physical memory layout has huge space for
memory hotplug. kaslr_regions[].base points "actual installed
memory size + padding" or higher address. So, if the "actual + padding"
is lower address than the maximum memory address, which means the memory
address reachable by memory hot-add, kaslr_regions[].base is destroyed by
the overwritten.

  address
    ^
    |------- maximum memory address (Hotplug)
    |                                    ^
    |------- kaslr_regions[0].base       | Hotadd-able region
    |     ^                              |
    |     | padding                      |
    |     V                              V
    |------- actual memory address (Installed on boot)
    |

Fix it by getting the maximum memory address from SRAT and store
the value in boot_param, then set the padding size while kaslr
initializing if the default padding size isn't enough.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/x86/zero-page.txt       |  4 ++++
 arch/x86/boot/compressed/acpi.c       | 30 ++++++++++++++++++++-------
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/mm/kaslr.c                   | 29 +++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
index 68aed077f..6c107816c 100644
--- a/Documentation/x86/zero-page.txt
+++ b/Documentation/x86/zero-page.txt
@@ -15,6 +15,7 @@ Offset	Proto	Name		Meaning
 058/008	ALL	tboot_addr      Physical address of tboot shared page
 060/010	ALL	ist_info	Intel SpeedStep (IST) BIOS support information
 				(struct ist_info)
+078/010	ALL	max_addr	The possible maximum physical memory address[*].
 080/010	ALL	hd0_info	hd0 disk parameter, OBSOLETE!!
 090/010	ALL	hd1_info	hd1 disk parameter, OBSOLETE!!
 0A0/010	ALL	sys_desc_table	System description table (struct sys_desc_table),
@@ -38,3 +39,6 @@ Offset	Proto	Name		Meaning
 2D0/A00	ALL	e820_table	E820 memory map table
 				(array of struct e820_entry)
 D00/1EC	ALL	eddbuf		EDD data (array of struct edd_info)
+
+[*]: max_addr shows the maximum memory address to be reachable by memory
+     hot-add. max_addr is set by parsing ACPI SRAT.
diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c5a949335..3247c7153 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -272,6 +272,26 @@ static unsigned long get_acpi_srat_table(void)
 	return 0;
 }
 
+static void subtable_parse(struct acpi_subtable_header *sub_table, int *num,
+		unsigned long *max_addr)
+{
+	struct acpi_srat_mem_affinity *ma;
+	unsigned long addr;
+
+	ma = (struct acpi_srat_mem_affinity *)sub_table;
+	if (ma->length) {
+		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
+			addr = ma->base_address + ma->length;
+			if (addr > *max_addr)
+				*max_addr = addr;
+		} else {
+			immovable_mem[*num].start = ma->base_address;
+			immovable_mem[*num].size = ma->length;
+			(*num)++;
+		}
+	}
+}
+
 /**
  * count_immovable_mem_regions - Parse SRAT and cache the immovable
  * memory regions into the immovable_mem array.
@@ -288,6 +308,7 @@ int count_immovable_mem_regions(void)
 	struct acpi_subtable_header *sub_table;
 	struct acpi_table_header *table_header;
 	char arg[MAX_ACPI_ARG_LENGTH];
+	unsigned long max_addr = 0;
 	int num = 0;
 
 	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
@@ -305,14 +326,8 @@ int count_immovable_mem_regions(void)
 	while (table + sizeof(struct acpi_subtable_header) < table_end) {
 		sub_table = (struct acpi_subtable_header *)table;
 		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
-			struct acpi_srat_mem_affinity *ma;
 
-			ma = (struct acpi_srat_mem_affinity *)sub_table;
-			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
-				immovable_mem[num].start = ma->base_address;
-				immovable_mem[num].size = ma->length;
-				num++;
-			}
+			subtable_parse(sub_table, &num, &max_addr);
 
 			if (num >= MAX_NUMNODES*2) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
@@ -321,6 +336,7 @@ int count_immovable_mem_regions(void)
 		}
 		table += sub_table->length;
 	}
+	boot_params->max_addr = max_addr;
 	return num;
 }
 #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137..d4882e171 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -156,7 +156,7 @@ struct boot_params {
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
 	__u64 acpi_rsdp_addr;				/* 0x070 */
-	__u8  _pad3[8];					/* 0x078 */
+	__u64 max_addr;					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 3f452ffed..f44ebfcb7 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,6 +70,33 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+/*
+ * The padding size should set to get for kaslr_regions[].base bigger address
+ * than the maximum memory address the system can have.
+ * kaslr_regions[].base points "actual size + padding" or higher address.
+ * If "actual size + padding" points the lower address than the maximum
+ * memory size, fix the padding size.
+ */
+static unsigned long __init kaslr_padding(void)
+{
+	unsigned long padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unsigned long actual, maximum, base;
+
+	if (!boot_params.max_addr)
+		goto out;
+
+	actual = roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
+	maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
+	base = actual + (padding << TB_SHIFT);
+
+	if (maximum > base)
+		padding = (maximum - actual) >> TB_SHIFT;
+out:
+#endif
+	return padding;
+}
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -103,7 +130,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+			kaslr_padding();
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.20.1


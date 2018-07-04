Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894ABC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE7A23EB0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE7A23EB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbeGDG2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:28:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933429AbeGDG2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:28:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w646OAxY106179
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 02:28:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0n98f5b9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:28:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 07:28:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 07:28:31 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w646SUBF27263128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 06:28:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD6852054;
        Wed,  4 Jul 2018 09:28:55 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CAF6C52052;
        Wed,  4 Jul 2018 09:28:53 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 04 Jul 2018 09:28:28 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Date:   Wed,  4 Jul 2018 09:28:16 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070406-0016-0000-0000-000001E32971
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070406-0017-0000-0000-000032378BED
Message-Id: <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In m68k the physical memory is described by [memory_start, memory_end] for
!MMU variant and by m68k_memory array of memory ranges for the MMU version.
This information is directly use to register the physical memory with
memblock.

The reserve_bootmem() calls are replaced with memblock_reserve() and the
bootmap bitmap allocation is simply dropped.

Since the MMU variant creates early mappings only for the small part of the
memory we force bottom-up allocations in memblock.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/m68k/Kconfig           |  3 +++
 arch/m68k/kernel/setup_mm.c | 14 ++++----------
 arch/m68k/kernel/setup_no.c | 20 ++++----------------
 arch/m68k/mm/init.c         |  1 -
 arch/m68k/mm/mcfmmu.c       | 13 +++++++------
 arch/m68k/mm/motorola.c     | 35 +++++++++++------------------------
 arch/m68k/sun3/config.c     |  4 ----
 7 files changed, 29 insertions(+), 61 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b..bd7f38a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -24,6 +24,9 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index f35e3eb..6512955 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
@@ -165,6 +166,8 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 					be32_to_cpu(m->addr);
 				m68k_memory[m68k_num_memory].size =
 					be32_to_cpu(m->size);
+				memblock_add(m68k_memory[m68k_num_memory].addr,
+					     m68k_memory[m68k_num_memory].size);
 				m68k_num_memory++;
 			} else
 				pr_warn("%s: too many memory chunks\n",
@@ -224,10 +227,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
 
 void __init setup_arch(char **cmdline_p)
 {
-#ifndef CONFIG_SUN3
-	int i;
-#endif
-
 	/* The bootinfo is located right after the kernel */
 	if (!CPU_IS_COLDFIRE)
 		m68k_parse_bootinfo((const struct bi_record *)_end);
@@ -356,14 +355,9 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 #ifndef CONFIG_SUN3
-	for (i = 1; i < m68k_num_memory; i++)
-		free_bootmem_node(NODE_DATA(i), m68k_memory[i].addr,
-				  m68k_memory[i].size);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (m68k_ramdisk.size) {
-		reserve_bootmem_node(__virt_to_node(phys_to_virt(m68k_ramdisk.addr)),
-				     m68k_ramdisk.addr, m68k_ramdisk.size,
-				     BOOTMEM_DEFAULT);
+		memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
 		initrd_start = (unsigned long)phys_to_virt(m68k_ramdisk.addr);
 		initrd_end = initrd_start + m68k_ramdisk.size;
 		pr_info("initrd: %08lx - %08lx\n", initrd_start, initrd_end);
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index a98af10..3e8d87a 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
@@ -86,8 +87,6 @@ void (*mach_power_off)(void);
 
 void __init setup_arch(char **cmdline_p)
 {
-	int bootmap_size;
-
 	memory_start = PAGE_ALIGN(_ramstart);
 	memory_end = _ramend;
 
@@ -142,6 +141,8 @@ void __init setup_arch(char **cmdline_p)
 	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
 		 __bss_stop, memory_start, memory_start, memory_end);
 
+	memblock_add(memory_start, memory_end - memory_start);
+
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
@@ -158,23 +159,10 @@ void __init setup_arch(char **cmdline_p)
 	min_low_pfn = PFN_DOWN(memory_start);
 	max_pfn = max_low_pfn = PFN_DOWN(memory_end);
 
-	bootmap_size = init_bootmem_node(
-			NODE_DATA(0),
-			min_low_pfn,		/* map goes here */
-			PFN_DOWN(PAGE_OFFSET),
-			max_pfn);
-	/*
-	 * Free the usable memory, we have to make sure we do not free
-	 * the bootmem bitmap so we then reserve it after freeing it :-)
-	 */
-	free_bootmem(memory_start, memory_end - memory_start);
-	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
-
 #if defined(CONFIG_UBOOT) && defined(CONFIG_BLK_DEV_INITRD)
 	if ((initrd_start > 0) && (initrd_start < initrd_end) &&
 			(initrd_end < memory_end))
-		reserve_bootmem(initrd_start, initrd_end - initrd_start,
-				 BOOTMEM_DEFAULT);
+		memblock_reserve(initrd_start, initrd_end - initrd_start);
 #endif /* if defined(CONFIG_BLK_DEV_INITRD) */
 
 	/*
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 8827b7f..38e2b27 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -71,7 +71,6 @@ void __init m68k_setup_node(int node)
 		pg_data_table[i] = pg_data_map + node;
 	}
 #endif
-	pg_data_map[node].bdata = bootmem_node_data + node;
 	node_set_online(node);
 }
 
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 2925d79..70dde04 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -153,31 +154,31 @@ int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension_word)
 
 void __init cf_bootmem_alloc(void)
 {
-	unsigned long start_pfn;
 	unsigned long memstart;
 
 	/* _rambase and _ramend will be naturally page aligned */
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
+	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
 
 	/* page numbers */
 	memstart = PAGE_ALIGN(_ramstart);
 	min_low_pfn = PFN_DOWN(_rambase);
-	start_pfn = PFN_DOWN(memstart);
 	max_pfn = max_low_pfn = PFN_DOWN(_ramend);
 	high_memory = (void *)_ramend;
 
+	/* Reserve kernel text/data/bss */
+	memblock_reserve(memstart, memstart - _rambase);
+
 	m68k_virt_to_node_shift = fls(_ramend - 1) - 6;
 	module_fixup(NULL, __start_fixup, __stop_fixup);
 
-	/* setup bootmem data */
+	/* setup node data */
 	m68k_setup_node(0);
-	memstart += init_bootmem_node(NODE_DATA(0), start_pfn,
-		min_low_pfn, max_low_pfn);
-	free_bootmem_node(NODE_DATA(0), memstart, _ramend - memstart);
 }
 
 /*
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index e490ecc..4e17ecb 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/gfp.h>
 
 #include <asm/setup.h>
@@ -208,7 +209,7 @@ void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned long min_addr, max_addr;
-	unsigned long addr, size, end;
+	unsigned long addr;
 	int i;
 
 #ifdef DEBUG
@@ -253,34 +254,20 @@ void __init paging_init(void)
 	min_low_pfn = availmem >> PAGE_SHIFT;
 	max_pfn = max_low_pfn = max_addr >> PAGE_SHIFT;
 
-	for (i = 0; i < m68k_num_memory; i++) {
-		addr = m68k_memory[i].addr;
-		end = addr + m68k_memory[i].size;
-		m68k_setup_node(i);
-		availmem = PAGE_ALIGN(availmem);
-		availmem += init_bootmem_node(NODE_DATA(i),
-					      availmem >> PAGE_SHIFT,
-					      addr >> PAGE_SHIFT,
-					      end >> PAGE_SHIFT);
-	}
+	/* Reserve kernel text/data/bss and the memory allocated in head.S */
+	memblock_reserve(m68k_memory[0].addr, availmem - m68k_memory[0].addr);
 
 	/*
 	 * Map the physical memory available into the kernel virtual
-	 * address space. First initialize the bootmem allocator with
-	 * the memory we already mapped, so map_node() has something
-	 * to allocate.
+	 * address space. Make sure memblock will not try to allocate
+	 * pages beyond the memory we already mapped in head.S
 	 */
-	addr = m68k_memory[0].addr;
-	size = m68k_memory[0].size;
-	free_bootmem_node(NODE_DATA(0), availmem,
-			  min(m68k_init_mapped_size, size) - (availmem - addr));
-	map_node(0);
-	if (size > m68k_init_mapped_size)
-		free_bootmem_node(NODE_DATA(0), addr + m68k_init_mapped_size,
-				  size - m68k_init_mapped_size);
-
-	for (i = 1; i < m68k_num_memory; i++)
+	memblock_set_bottom_up(true);
+
+	for (i = 0; i < m68k_num_memory; i++) {
+		m68k_setup_node(i);
 		map_node(i);
+	}
 
 	flush_tlb_all();
 
diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 1d28d38..79a2bb8 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -123,10 +123,6 @@ static void __init sun3_bootmem_alloc(unsigned long memory_start,
 	availmem = memory_start;
 
 	m68k_setup_node(0);
-	availmem += init_bootmem(start_page, num_pages);
-	availmem = (availmem + (PAGE_SIZE-1)) & PAGE_MASK;
-
-	free_bootmem(__pa(availmem), memory_end - (availmem));
 }
 
 
-- 
2.7.4


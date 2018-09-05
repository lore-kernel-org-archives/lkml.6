Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D420B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D420B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeIEUcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:32:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727694AbeIEUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:32:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85FtVs1022463
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:01:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maj548mkd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:01:12 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:01:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:01:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G12Yt40632326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:01:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44ADB4C05A;
        Wed,  5 Sep 2018 19:00:57 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 352FA4C046;
        Wed,  5 Sep 2018 19:00:55 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:55 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:00:59 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 27/29] mm: remove nobootmem
Date:   Wed,  5 Sep 2018 18:59:42 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-0012-0000-0000-000002A43AEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0013-0000-0000-000020D85E07
Message-Id: <1536163184-26356-28-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a few remaining functions from nobootmem.c to memblock.c and remove
nobootmem

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/Makefile    |   1 -
 mm/memblock.c  | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/nobootmem.c | 128 ---------------------------------------------------------
 3 files changed, 104 insertions(+), 129 deletions(-)
 delete mode 100644 mm/nobootmem.c

diff --git a/mm/Makefile b/mm/Makefile
index 0a3e72e..fb96c45 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -42,7 +42,6 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   debug.o $(mmu-y)
 
 obj-y += init-mm.o
-obj-y += nobootmem.o
 obj-y += memblock.o
 
 ifdef CONFIG_MMU
diff --git a/mm/memblock.c b/mm/memblock.c
index 55d7d50..3f76d40 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -82,6 +82,16 @@
  * initialization compltes.
  */
 
+#ifndef CONFIG_NEED_MULTIPLE_NODES
+struct pglist_data __refdata contig_page_data;
+EXPORT_SYMBOL(contig_page_data);
+#endif
+
+unsigned long max_low_pfn;
+unsigned long min_low_pfn;
+unsigned long max_pfn;
+unsigned long long max_possible_pfn;
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -1959,6 +1969,100 @@ static int __init early_memblock(char *p)
 }
 early_param("memblock", early_memblock);
 
+static void __init __free_pages_memory(unsigned long start, unsigned long end)
+{
+	int order;
+
+	while (start < end) {
+		order = min(MAX_ORDER - 1UL, __ffs(start));
+
+		while (start + (1UL << order) > end)
+			order--;
+
+		memblock_free_pages(pfn_to_page(start), start, order);
+
+		start += (1UL << order);
+	}
+}
+
+static unsigned long __init __free_memory_core(phys_addr_t start,
+				 phys_addr_t end)
+{
+	unsigned long start_pfn = PFN_UP(start);
+	unsigned long end_pfn = min_t(unsigned long,
+				      PFN_DOWN(end), max_low_pfn);
+
+	if (start_pfn >= end_pfn)
+		return 0;
+
+	__free_pages_memory(start_pfn, end_pfn);
+
+	return end_pfn - start_pfn;
+}
+
+static unsigned long __init free_low_memory_core_early(void)
+{
+	unsigned long count = 0;
+	phys_addr_t start, end;
+	u64 i;
+
+	memblock_clear_hotplug(0, -1);
+
+	for_each_reserved_mem_region(i, &start, &end)
+		reserve_bootmem_region(start, end);
+
+	/*
+	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
+	 *  because in some case like Node0 doesn't have RAM installed
+	 *  low ram will be on Node1
+	 */
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
+				NULL)
+		count += __free_memory_core(start, end);
+
+	return count;
+}
+
+static int reset_managed_pages_done __initdata;
+
+void reset_node_managed_pages(pg_data_t *pgdat)
+{
+	struct zone *z;
+
+	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
+		z->managed_pages = 0;
+}
+
+void __init reset_all_zones_managed_pages(void)
+{
+	struct pglist_data *pgdat;
+
+	if (reset_managed_pages_done)
+		return;
+
+	for_each_online_pgdat(pgdat)
+		reset_node_managed_pages(pgdat);
+
+	reset_managed_pages_done = 1;
+}
+
+/**
+ * memblock_free_all - release free pages to the buddy allocator
+ *
+ * Return: the number of pages actually released.
+ */
+unsigned long __init memblock_free_all(void)
+{
+	unsigned long pages;
+
+	reset_all_zones_managed_pages();
+
+	pages = free_low_memory_core_early();
+	totalram_pages += pages;
+
+	return pages;
+}
+
 #if defined(CONFIG_DEBUG_FS) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
 
 static int memblock_debug_show(struct seq_file *m, void *private)
diff --git a/mm/nobootmem.c b/mm/nobootmem.c
deleted file mode 100644
index 9608bc5..0000000
--- a/mm/nobootmem.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  bootmem - A boot-time physical memory allocator and configurator
- *
- *  Copyright (C) 1999 Ingo Molnar
- *                1999 Kanoj Sarcar, SGI
- *                2008 Johannes Weiner
- *
- * Access to this subsystem has to be serialized externally (which is true
- * for the boot process anyway).
- */
-#include <linux/init.h>
-#include <linux/pfn.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/kmemleak.h>
-#include <linux/range.h>
-#include <linux/memblock.h>
-#include <linux/bootmem.h>
-
-#include <asm/bug.h>
-#include <asm/io.h>
-
-#include "internal.h"
-
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-struct pglist_data __refdata contig_page_data;
-EXPORT_SYMBOL(contig_page_data);
-#endif
-
-unsigned long max_low_pfn;
-unsigned long min_low_pfn;
-unsigned long max_pfn;
-unsigned long long max_possible_pfn;
-
-static void __init __free_pages_memory(unsigned long start, unsigned long end)
-{
-	int order;
-
-	while (start < end) {
-		order = min(MAX_ORDER - 1UL, __ffs(start));
-
-		while (start + (1UL << order) > end)
-			order--;
-
-		memblock_free_pages(pfn_to_page(start), start, order);
-
-		start += (1UL << order);
-	}
-}
-
-static unsigned long __init __free_memory_core(phys_addr_t start,
-				 phys_addr_t end)
-{
-	unsigned long start_pfn = PFN_UP(start);
-	unsigned long end_pfn = min_t(unsigned long,
-				      PFN_DOWN(end), max_low_pfn);
-
-	if (start_pfn >= end_pfn)
-		return 0;
-
-	__free_pages_memory(start_pfn, end_pfn);
-
-	return end_pfn - start_pfn;
-}
-
-static unsigned long __init free_low_memory_core_early(void)
-{
-	unsigned long count = 0;
-	phys_addr_t start, end;
-	u64 i;
-
-	memblock_clear_hotplug(0, -1);
-
-	for_each_reserved_mem_region(i, &start, &end)
-		reserve_bootmem_region(start, end);
-
-	/*
-	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
-	 *  because in some case like Node0 doesn't have RAM installed
-	 *  low ram will be on Node1
-	 */
-	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
-				NULL)
-		count += __free_memory_core(start, end);
-
-	return count;
-}
-
-static int reset_managed_pages_done __initdata;
-
-void reset_node_managed_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		z->managed_pages = 0;
-}
-
-void __init reset_all_zones_managed_pages(void)
-{
-	struct pglist_data *pgdat;
-
-	if (reset_managed_pages_done)
-		return;
-
-	for_each_online_pgdat(pgdat)
-		reset_node_managed_pages(pgdat);
-
-	reset_managed_pages_done = 1;
-}
-
-/**
- * memblock_free_all - release free pages to the buddy allocator
- *
- * Return: the number of pages actually released.
- */
-unsigned long __init memblock_free_all(void)
-{
-	unsigned long pages;
-
-	reset_all_zones_managed_pages();
-
-	pages = free_low_memory_core_early();
-	totalram_pages += pages;
-
-	return pages;
-}
-- 
2.7.4


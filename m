Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D13ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064D9208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064D9208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbeGPIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389038AbeGPIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G7dF9H101998
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:43:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8gg6wats-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:43:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 08:43:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 08:43:23 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G7hMgV32571544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 07:43:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5F7142047;
        Mon, 16 Jul 2018 10:43:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AEDB4204F;
        Mon, 16 Jul 2018 10:43:40 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.99])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Jul 2018 10:43:40 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 16 Jul 2018 10:43:20 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] hexagon: switch to NO_BOOTMEM
Date:   Mon, 16 Jul 2018 10:43:18 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18071607-0016-0000-0000-000001E735D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071607-0017-0000-0000-0000323BDD74
Message-Id: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds registration of the system memory with memblock, eliminates
bootmem initialization and converts early memory reservations from bootmem
to memblock.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---

Build tested only.

 arch/hexagon/Kconfig   |  3 +++
 arch/hexagon/mm/init.c | 20 ++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb20..66fb2d5 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,9 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 1495d45..8d265bf 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <asm/atomic.h>
 #include <linux/highmem.h>
 #include <asm/tlb.h>
@@ -176,7 +177,6 @@ size_t hexagon_coherent_pool_size = (size_t) (DMA_RESERVE << 22);
 
 void __init setup_arch_memory(void)
 {
-	int bootmap_size;
 	/*  XXX Todo: this probably should be cleaned up  */
 	u32 *segtable = (u32 *) &swapper_pg_dir[0];
 	u32 *segtable_end;
@@ -195,18 +195,22 @@ void __init setup_arch_memory(void)
 	bootmem_lastpg = PFN_DOWN((bootmem_lastpg << PAGE_SHIFT) &
 		~((BIG_KERNEL_PAGE_SIZE) - 1));
 
+	memblock_add(PHYS_OFFSET,
+		     (bootmem_lastpg - ARCH_PFN_OFFSET) << PAGE_SHIFT);
+
+	/* Reserve kernel text/data/bss */
+	memblock_reserve(PHYS_OFFSET,
+			 (bootmem_startpg - PHYS_OFFSET) << PAGE_SHIFT);
 	/*
 	 * Reserve the top DMA_RESERVE bytes of RAM for DMA (uncached)
 	 * memory allocation
 	 */
-
 	max_low_pfn = bootmem_lastpg - PFN_DOWN(DMA_RESERVED_BYTES);
 	min_low_pfn = ARCH_PFN_OFFSET;
-	bootmap_size =  init_bootmem_node(NODE_DATA(0), bootmem_startpg, min_low_pfn, max_low_pfn);
+	memblock_reserve(PFN_PHYS(max_low_pfn), DMA_RESERVED_BYTES);
 
 	printk(KERN_INFO "bootmem_startpg:  0x%08lx\n", bootmem_startpg);
 	printk(KERN_INFO "bootmem_lastpg:  0x%08lx\n", bootmem_lastpg);
-	printk(KERN_INFO "bootmap_size:  %d\n", bootmap_size);
 	printk(KERN_INFO "min_low_pfn:  0x%08lx\n", min_low_pfn);
 	printk(KERN_INFO "max_low_pfn:  0x%08lx\n", max_low_pfn);
 
@@ -257,14 +261,6 @@ void __init setup_arch_memory(void)
 #endif
 
 	/*
-	 * Free all the memory that wasn't taken up by the bootmap, the DMA
-	 * reserve, or kernel itself.
-	 */
-	free_bootmem(PFN_PHYS(bootmem_startpg) + bootmap_size,
-		     PFN_PHYS(bootmem_lastpg - bootmem_startpg) - bootmap_size -
-		     DMA_RESERVED_BYTES);
-
-	/*
 	 *  The bootmem allocator seemingly just lives to feed memory
 	 *  to the paging system
 	 */
-- 
2.7.4


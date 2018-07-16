Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEEEECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518C208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7518C208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeGPI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:26:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbeGPI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:26:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G7xYs0052114
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:00:39 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k8qacre26-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:00:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 09:00:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 09:00:32 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G80Wcs42008810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 08:00:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0782E4205F;
        Mon, 16 Jul 2018 11:00:51 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9094842057;
        Mon, 16 Jul 2018 11:00:49 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.99])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Jul 2018 11:00:49 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 16 Jul 2018 11:00:29 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     Michal Hocko <mhocko@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] unicore32: switch to NO_BOOTMEM
Date:   Mon, 16 Jul 2018 11:00:24 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18071608-0020-0000-0000-000002A6F0C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071608-0021-0000-0000-000020F34F0D
Message-Id: <1531728024-13259-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=52 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unicore32 already supports memblock and uses it for some early memory
reservations, e.g initrd and the page tables.

At some point unicore32 allocates the bootmem bitmap from the memblock and
then hands over the memory reservations from memblock to bootmem.

This patch removes the bootmem initialization and leaves memblock as the
only boot time memory manager for unicore32.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---

I couldn't get unicore32 toolchain as the only link I was able to find [1]
gives me timeout, so the best I could do to check the changes was

	gcc <lots of flags> -c arch/unicore32/mm/init.c

[1] http://mprc.pku.edu.cn/~guanxuetao/linux/uc4-1.0.5-hard.tgz

 arch/unicore32/Kconfig   |  1 +
 arch/unicore32/mm/init.c | 54 +-----------------------------------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 03f991e..cff4b9d 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -5,6 +5,7 @@ config UNICORE32
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select HAVE_MEMBLOCK
+	select NO_BOOTMEM
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index f4950fb..44ccc15 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -84,58 +84,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	}
 }
 
-static void __init uc32_bootmem_init(unsigned long start_pfn,
-	unsigned long end_pfn)
-{
-	struct memblock_region *reg;
-	unsigned int boot_pages;
-	phys_addr_t bitmap;
-	pg_data_t *pgdat;
-
-	/*
-	 * Allocate the bootmem bitmap page.  This must be in a region
-	 * of memory which has already been mapped.
-	 */
-	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	bitmap = memblock_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
-				__pfn_to_phys(end_pfn));
-
-	/*
-	 * Initialise the bootmem allocator, handing the
-	 * memory banks over to bootmem.
-	 */
-	node_set_online(0);
-	pgdat = NODE_DATA(0);
-	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
-
-	/* Free the lowmem regions from memblock into bootmem. */
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		free_bootmem(__pfn_to_phys(start), (end - start) << PAGE_SHIFT);
-	}
-
-	/* Reserve the lowmem memblock reserved regions in bootmem. */
-	for_each_memblock(reserved, reg) {
-		unsigned long start = memblock_region_reserved_base_pfn(reg);
-		unsigned long end = memblock_region_reserved_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		reserve_bootmem(__pfn_to_phys(start),
-			(end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
-	}
-}
-
 static void __init uc32_bootmem_free(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
@@ -232,7 +180,7 @@ void __init bootmem_init(void)
 
 	find_limits(&min, &max_low, &max_high);
 
-	uc32_bootmem_init(min, max_low);
+	node_set_online(0);
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
-- 
2.7.4


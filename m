Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2112BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE062075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfBLPQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:16:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728700AbfBLPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:16:26 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CF9Ci4131283
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:16:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qm0hd0cs8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:16:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 12 Feb 2019 15:16:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Feb 2019 15:16:17 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1CFGGs59175332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 15:16:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F389A405B;
        Tue, 12 Feb 2019 15:16:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCA7A4062;
        Tue, 12 Feb 2019 15:16:14 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.59.139])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Feb 2019 15:16:14 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 12 Feb 2019 17:16:13 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2] parisc: use memblock_alloc() instead of custom get_memblock()
Date:   Tue, 12 Feb 2019 17:16:12 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19021215-0016-0000-0000-000002559364
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021215-0017-0000-0000-000032AFB5C7
Message-Id: <1549984572-10867-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_memblock() function implements custom bottom-up memblock allocator.
Setting 'memblock_bottom_up = true' before any memblock allocation is done
allows replacing get_memblock() calls with memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
v2: fix allocation alignment

 arch/parisc/mm/init.c | 52 +++++++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 059187a..d0b1662 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -79,36 +79,6 @@ static struct resource sysram_resources[MAX_PHYSMEM_RANGES] __read_mostly;
 physmem_range_t pmem_ranges[MAX_PHYSMEM_RANGES] __read_mostly;
 int npmem_ranges __read_mostly;
 
-/*
- * get_memblock() allocates pages via memblock.
- * We can't use memblock_find_in_range(0, KERNEL_INITIAL_SIZE) here since it
- * doesn't allocate from bottom to top which is needed because we only created
- * the initial mapping up to KERNEL_INITIAL_SIZE in the assembly bootup code.
- */
-static void * __init get_memblock(unsigned long size)
-{
-	static phys_addr_t search_addr __initdata;
-	phys_addr_t phys;
-
-	if (!search_addr)
-		search_addr = PAGE_ALIGN(__pa((unsigned long) &_end));
-	search_addr = ALIGN(search_addr, size);
-	while (!memblock_is_region_memory(search_addr, size) ||
-		memblock_is_region_reserved(search_addr, size)) {
-		search_addr += size;
-	}
-	phys = search_addr;
-
-	if (phys)
-		memblock_reserve(phys, size);
-	else
-		panic("get_memblock() failed.\n");
-
-	memset(__va(phys), 0, size);
-
-	return __va(phys);
-}
-
 #ifdef CONFIG_64BIT
 #define MAX_MEM         (~0UL)
 #else /* !CONFIG_64BIT */
@@ -321,6 +291,13 @@ static void __init setup_bootmem(void)
 			max_pfn = start_pfn + npages;
 	}
 
+	/*
+	 * We can't use memblock top-down allocations because we only
+	 * created the initial mapping up to KERNEL_INITIAL_SIZE in
+	 * the assembly bootup code.
+	 */
+	memblock_set_bottom_up(true);
+
 	/* IOMMU is always used to access "high mem" on those boxes
 	 * that can support enough mem that a PCI device couldn't
 	 * directly DMA to any physical addresses.
@@ -442,7 +419,10 @@ static void __init map_pages(unsigned long start_vaddr,
 		 */
 
 		if (!pmd) {
-			pmd = (pmd_t *) get_memblock(PAGE_SIZE << PMD_ORDER);
+			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
+					     PAGE_SIZE << PMD_ORDER);
+			if (!pmd)
+				panic("pmd allocation failed.\n");
 			pmd = (pmd_t *) __pa(pmd);
 		}
 
@@ -461,7 +441,10 @@ static void __init map_pages(unsigned long start_vaddr,
 
 			pg_table = (pte_t *)pmd_address(*pmd);
 			if (!pg_table) {
-				pg_table = (pte_t *) get_memblock(PAGE_SIZE);
+				pg_table = memblock_alloc(PAGE_SIZE,
+							  PAGE_SIZE);
+				if (!pg_table)
+					panic("page table allocation failed\n");
 				pg_table = (pte_t *) __pa(pg_table);
 			}
 
@@ -700,7 +683,10 @@ static void __init pagetable_init(void)
 	}
 #endif
 
-	empty_zero_page = get_memblock(PAGE_SIZE);
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!empty_zero_page)
+		panic("zero page allocation failed.\n");
+
 }
 
 static void __init gateway_init(void)
-- 
2.7.4


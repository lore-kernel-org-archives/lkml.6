Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079EFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D22075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25D22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIEUbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:31:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbeIEUbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:31:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85Fx1XC023406
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:00:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2magkt5346-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:00:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:00:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:00:38 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G0bOA41025678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:00:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 299F9A4051;
        Wed,  5 Sep 2018 19:00:30 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108FCA4059;
        Wed,  5 Sep 2018 19:00:28 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:27 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:00:34 +0300
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
Subject: [RFC PATCH 18/29] memblock: replace alloc_bootmem_low_pages with memblock_alloc_low
Date:   Wed,  5 Sep 2018 18:59:33 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-0016-0000-0000-00000200C390
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0017-0000-0000-000032576839
Message-Id: <1536163184-26356-19-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is done using the following semantic patch:

@@
expression e;
@@
- alloc_bootmem_low_pages(e)
+ memblock_alloc_low(e, PAGE_SIZE)

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/arc/mm/highmem.c                |  2 +-
 arch/m68k/atari/stram.c              |  3 ++-
 arch/m68k/mm/motorola.c              |  5 +++--
 arch/mips/cavium-octeon/dma-octeon.c |  2 +-
 arch/mips/mm/init.c                  |  3 ++-
 arch/um/kernel/mem.c                 | 10 ++++++----
 arch/xtensa/mm/mmu.c                 |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 77ff64a..f582dc8 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -123,7 +123,7 @@ static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 	pud_k = pud_offset(pgd_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
-	pte_k = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 	pmd_populate_kernel(&init_mm, pmd_k, pte_k);
 	return pte_k;
 }
diff --git a/arch/m68k/atari/stram.c b/arch/m68k/atari/stram.c
index c83d664..1089d67 100644
--- a/arch/m68k/atari/stram.c
+++ b/arch/m68k/atari/stram.c
@@ -95,7 +95,8 @@ void __init atari_stram_reserve_pages(void *start_mem)
 {
 	if (kernel_in_stram) {
 		pr_debug("atari_stram pool: kernel in ST-RAM, using alloc_bootmem!\n");
-		stram_pool.start = (resource_size_t)alloc_bootmem_low_pages(pool_size);
+		stram_pool.start = (resource_size_t)memblock_alloc_low(pool_size,
+								       PAGE_SIZE);
 		stram_pool.end = stram_pool.start + pool_size - 1;
 		request_resource(&iomem_resource, &stram_pool);
 		stram_virt_offset = 0;
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 4e17ecb..8bcf57e 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -55,7 +55,7 @@ static pte_t * __init kernel_page_table(void)
 {
 	pte_t *ptablep;
 
-	ptablep = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+	ptablep = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 
 	clear_page(ptablep);
 	__flush_page_to_ram(ptablep);
@@ -95,7 +95,8 @@ static pmd_t * __init kernel_ptr_table(void)
 
 	last_pgtable += PTRS_PER_PMD;
 	if (((unsigned long)last_pgtable & ~PAGE_MASK) == 0) {
-		last_pgtable = (pmd_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+		last_pgtable = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
+							   PAGE_SIZE);
 
 		clear_page(last_pgtable);
 		__flush_page_to_ram(last_pgtable);
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 236833b..c44c1a6 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -244,7 +244,7 @@ void __init plat_swiotlb_setup(void)
 	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
 	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
 
-	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
+	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
 
 	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
 		panic("Cannot allocate SWIOTLB buffer");
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 400676c..a010fba7 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -244,7 +244,8 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 			pmd = (pmd_t *)pud;
 			for (; (k < PTRS_PER_PMD) && (vaddr < end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
-					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
+									   PAGE_SIZE);
 					set_pmd(pmd, __pmd((unsigned long)pte));
 					BUG_ON(pte != pte_offset_kernel(pmd, 0));
 				}
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 3c0e470..185f6bb 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init mem_init(void)
 static void __init one_page_table_init(pmd_t *pmd)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		pte_t *pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
+							  PAGE_SIZE);
 		set_pmd(pmd, __pmd(_KERNPG_TABLE +
 					   (unsigned long) __pa(pte)));
 		if (pte != pte_offset_kernel(pmd, 0))
@@ -75,7 +76,7 @@ static void __init one_page_table_init(pmd_t *pmd)
 static void __init one_md_table_init(pud_t *pud)
 {
 #ifdef CONFIG_3_LEVEL_PGTABLES
-	pmd_t *pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
 	if (pmd_table != pmd_offset(pud, 0))
 		BUG();
@@ -124,7 +125,7 @@ static void __init fixaddr_user_init( void)
 		return;
 
 	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
-	v = (unsigned long) alloc_bootmem_low_pages(size);
+	v = (unsigned long) memblock_alloc_low(size, PAGE_SIZE);
 	memcpy((void *) v , (void *) FIXADDR_USER_START, size);
 	p = __pa(v);
 	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
@@ -143,7 +144,8 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES], vaddr;
 	int i;
 
-	empty_zero_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
+	empty_zero_page = (unsigned long *) memblock_alloc_low(PAGE_SIZE,
+							       PAGE_SIZE);
 	for (i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 9d1ecfc..f33a1ff 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -31,7 +31,7 @@ static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 	pr_debug("%s: vaddr: 0x%08lx, n_pages: %ld\n",
 		 __func__, vaddr, n_pages);
 
-	pte = alloc_bootmem_low_pages(n_pages * sizeof(pte_t));
+	pte = memblock_alloc_low(n_pages * sizeof(pte_t), PAGE_SIZE);
 
 	for (i = 0; i < n_pages; ++i)
 		pte_clear(NULL, 0, pte + i);
-- 
2.7.4


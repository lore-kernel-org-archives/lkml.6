Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3EFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA82075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CA82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIEUbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:31:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728090AbeIEUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:31:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85FuNDH149092
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:00:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2magyumdqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:00:47 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:00:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:00:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G0e8841418756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:00:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C347D11C064;
        Wed,  5 Sep 2018 19:00:32 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA80811C06E;
        Wed,  5 Sep 2018 19:00:30 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:30 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:00:37 +0300
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
Subject: [RFC PATCH 19/29] memblock: replace alloc_bootmem_pages with memblock_alloc
Date:   Wed,  5 Sep 2018 18:59:34 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-0028-0000-0000-000002F4BF53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0029-0000-0000-000023AE4010
Message-Id: <1536163184-26356-20-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is done using the following semantic patch:

@@
expression e;
@@
- alloc_bootmem_pages(e)
+ memblock_alloc(e, PAGE_SIZE)

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/c6x/mm/init.c             | 3 ++-
 arch/h8300/mm/init.c           | 2 +-
 arch/m68k/mm/init.c            | 2 +-
 arch/m68k/mm/mcfmmu.c          | 4 ++--
 arch/m68k/mm/motorola.c        | 2 +-
 arch/m68k/mm/sun3mmu.c         | 4 ++--
 arch/sh/mm/init.c              | 4 ++--
 arch/x86/kernel/apic/io_apic.c | 3 ++-
 arch/x86/mm/init_64.c          | 2 +-
 drivers/xen/swiotlb-xen.c      | 3 ++-
 10 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 4cc72b0..dc369ad 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -38,7 +38,8 @@ void __init paging_init(void)
 	struct pglist_data *pgdat = NODE_DATA(0);
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
-	empty_zero_page      = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page      = (unsigned long) memblock_alloc(PAGE_SIZE,
+							      PAGE_SIZE);
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 015287a..5d31ac9 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -67,7 +67,7 @@ void __init paging_init(void)
 	 * Initialize the bad page table and bad page to point
 	 * to a couple of allocated pages.
 	 */
-	empty_zero_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 38e2b27..977363e 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -93,7 +93,7 @@ void __init paging_init(void)
 
 	high_memory = (void *) end_mem;
 
-	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	/*
 	 * Set up SFC/DFC registers (user data space).
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index f5453d9..38a1d92 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -44,7 +44,7 @@ void __init paging_init(void)
 	enum zone_type zone;
 	int i;
 
-	empty_zero_page = (void *) alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	memset((void *) empty_zero_page, 0, PAGE_SIZE);
 
 	pg_dir = swapper_pg_dir;
@@ -52,7 +52,7 @@ void __init paging_init(void)
 
 	size = num_pages * sizeof(pte_t);
 	size = (size + PAGE_SIZE) & ~(PAGE_SIZE-1);
-	next_pgtable = (unsigned long) alloc_bootmem_pages(size);
+	next_pgtable = (unsigned long) memblock_alloc(size, PAGE_SIZE);
 
 	bootmem_end = (next_pgtable + size + PAGE_SIZE) & PAGE_MASK;
 	pg_dir += PAGE_OFFSET >> PGDIR_SHIFT;
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 8bcf57e..2113eec 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -276,7 +276,7 @@ void __init paging_init(void)
 	 * initialize the bad page table and bad page to point
 	 * to a couple of allocated pages
 	 */
-	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	/*
 	 * Set up SFC/DFC registers
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index 4a99799..19c05ab 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -45,7 +45,7 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned long size;
 
-	empty_zero_page = alloc_bootmem_pages(PAGE_SIZE);
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	address = PAGE_OFFSET;
 	pg_dir = swapper_pg_dir;
@@ -55,7 +55,7 @@ void __init paging_init(void)
 	size = num_pages * sizeof(pte_t);
 	size = (size + PAGE_SIZE) & ~(PAGE_SIZE-1);
 
-	next_pgtable = (unsigned long)alloc_bootmem_pages(size);
+	next_pgtable = (unsigned long)memblock_alloc(size, PAGE_SIZE);
 	bootmem_end = (next_pgtable + size + PAGE_SIZE) & PAGE_MASK;
 
 	/* Map whole memory from PAGE_OFFSET (0x0E000000) */
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 7713c08..c884b76 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -128,7 +128,7 @@ static pmd_t * __init one_md_table_init(pud_t *pud)
 	if (pud_none(*pud)) {
 		pmd_t *pmd;
 
-		pmd = alloc_bootmem_pages(PAGE_SIZE);
+		pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		pud_populate(&init_mm, pud, pmd);
 		BUG_ON(pmd != pmd_offset(pud, 0));
 	}
@@ -141,7 +141,7 @@ static pte_t * __init one_page_table_init(pmd_t *pmd)
 	if (pmd_none(*pmd)) {
 		pte_t *pte;
 
-		pte = alloc_bootmem_pages(PAGE_SIZE);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		pmd_populate_kernel(&init_mm, pmd, pte);
 		BUG_ON(pte != pte_offset_kernel(pmd, 0));
 	}
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ff0d14c..e25118f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2621,7 +2621,8 @@ void __init io_apic_init_mappings(void)
 #ifdef CONFIG_X86_32
 fake_ioapic_page:
 #endif
-			ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+			ioapic_phys = (unsigned long)memblock_alloc(PAGE_SIZE,
+								    PAGE_SIZE);
 			ioapic_phys = __pa(ioapic_phys);
 		}
 		set_fixmap_nocache(idx, ioapic_phys);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dd519f3..f39b512 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -197,7 +197,7 @@ static __ref void *spp_getpage(void)
 	if (after_bootmem)
 		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
 	else
-		ptr = alloc_bootmem_pages(PAGE_SIZE);
+		ptr = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	if (!ptr || ((unsigned long)ptr & ~PAGE_MASK)) {
 		panic("set_pte_phys: cannot allocate page data %s\n",
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a6f9ba8..8d849b4 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -217,7 +217,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	 * Get IO TLB memory from any location.
 	 */
 	if (early)
-		xen_io_tlb_start = alloc_bootmem_pages(PAGE_ALIGN(bytes));
+		xen_io_tlb_start = memblock_alloc(PAGE_ALIGN(bytes),
+						  PAGE_SIZE);
 	else {
 #define SLABS_PER_PAGE (1 << (PAGE_SHIFT - IO_TLB_SHIFT))
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
-- 
2.7.4


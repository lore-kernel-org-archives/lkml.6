Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4170A20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4170A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeIEUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728251AbeIEUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:32:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85FwwOx023191
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:01:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2magkt545c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:01:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:01:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:01:06 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85G15TM44498964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:01:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D9AA4055;
        Wed,  5 Sep 2018 19:00:57 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7597A4040;
        Wed,  5 Sep 2018 19:00:55 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Sep 2018 19:00:55 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 05 Sep 2018 19:01:02 +0300
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
Subject: [RFC PATCH 28/29] memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
Date:   Wed,  5 Sep 2018 18:59:43 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18090516-4275-0000-0000-000002B5BD27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-4276-0000-0000-000037BED7CF
Message-Id: <1536163184-26356-29-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop BOOTMEM_ALLOC_ACCESSIBLE and BOOTMEM_ALLOC_ANYWHERE in favor of
identical MEMBLOCK definitions.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/ia64/mm/discontig.c       | 2 +-
 arch/powerpc/kernel/setup_64.c | 2 +-
 arch/sparc/kernel/smp_64.c     | 2 +-
 arch/x86/kernel/setup_percpu.c | 2 +-
 arch/x86/mm/kasan_init_64.c    | 4 ++--
 mm/hugetlb.c                   | 3 ++-
 mm/kasan/kasan_init.c          | 2 +-
 mm/memblock.c                  | 8 ++++----
 mm/page_ext.c                  | 2 +-
 mm/sparse-vmemmap.c            | 3 ++-
 mm/sparse.c                    | 5 +++--
 11 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 918dda9..70609f8 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -453,7 +453,7 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
 
 	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
 				     __pa(MAX_DMA_ADDRESS),
-				     BOOTMEM_ALLOC_ACCESSIBLE,
+				     MEMBLOCK_ALLOC_ACCESSIBLE,
 				     bestnode);
 
 	return ptr;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e564b27..b3e70cc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -758,7 +758,7 @@ void __init emergency_stack_init(void)
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
 	return memblock_alloc_try_nid(size, align, __pa(MAX_DMA_ADDRESS),
-				      BOOTMEM_ALLOC_ACCESSIBLE,
+				      MEMBLOCK_ALLOC_ACCESSIBLE,
 				      early_cpu_to_node(cpu));
 
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a087a6a..6cc80d0 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1595,7 +1595,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 			 cpu, size, __pa(ptr));
 	} else {
 		ptr = memblock_alloc_try_nid(size, align, goal,
-					     BOOTMEM_ALLOC_ACCESSIBLE, node);
+					     MEMBLOCK_ALLOC_ACCESSIBLE, node);
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at "
 			 "%016lx\n", cpu, size, node, __pa(ptr));
 	}
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index a006f1b..483412f 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -114,7 +114,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 			 cpu, size, __pa(ptr));
 	} else {
 		ptr = memblock_alloc_try_nid_nopanic(size, align, goal,
-						     BOOTMEM_ALLOC_ACCESSIBLE,
+						     MEMBLOCK_ALLOC_ACCESSIBLE,
 						     node);
 
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 77b857c..8f87499 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -29,10 +29,10 @@ static __init void *early_alloc(size_t size, int nid, bool panic)
 {
 	if (panic)
 		return memblock_alloc_try_nid(size, size,
-			__pa(MAX_DMA_ADDRESS), BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	else
 		return memblock_alloc_try_nid_nopanic(size, size,
-			__pa(MAX_DMA_ADDRESS), BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 }
 
 static void __init kasan_populate_pmd(pmd_t *pmd, unsigned long addr,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3f5419c..ee0b140 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -16,6 +16,7 @@
 #include <linux/cpuset.h>
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/mmdebug.h>
@@ -2102,7 +2103,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 
 		addr = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
-				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
+				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
 		if (addr) {
 			/*
 			 * Use the beginning of the huge page to store the
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 24d734b..785a970 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -84,7 +84,7 @@ static inline bool kasan_zero_page_entry(pte_t pte)
 static __init void *early_alloc(size_t size, int node)
 {
 	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
-					BOOTMEM_ALLOC_ACCESSIBLE, node);
+					MEMBLOCK_ALLOC_ACCESSIBLE, node);
 }
 
 static void __ref zero_pte_populate(pmd_t *pmd, unsigned long addr,
diff --git a/mm/memblock.c b/mm/memblock.c
index 3f76d40..6061914 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1417,7 +1417,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
  * hold the requested memory.
  *
  * The allocation is performed from memory region limited by
- * memblock.current_limit if @max_addr == %BOOTMEM_ALLOC_ACCESSIBLE.
+ * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
  *
  * The memory block is aligned on %SMP_CACHE_BYTES if @align == 0.
  *
@@ -1504,7 +1504,7 @@ static void * __init memblock_alloc_internal(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
@@ -1542,7 +1542,7 @@ void * __init memblock_alloc_try_nid_raw(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
@@ -1577,7 +1577,7 @@ void * __init memblock_alloc_try_nid_nopanic(
  * @min_addr: the lower bound of the memory region from where the allocation
  *	  is preferred (phys address)
  * @max_addr: the upper bound of the memory region from where the allocation
- *	      is preferred (phys address), or %BOOTMEM_ALLOC_ACCESSIBLE to
+ *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
diff --git a/mm/page_ext.c b/mm/page_ext.c
index e77c0f0..5323c2a 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -163,7 +163,7 @@ static int __init alloc_node_page_ext(int nid)
 
 	base = memblock_alloc_try_nid_nopanic(
 			table_size, PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-			BOOTMEM_ALLOC_ACCESSIBLE, nid);
+			MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	if (!base)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 91c2c3d..7408cab 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
@@ -43,7 +44,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 				unsigned long goal)
 {
 	return memblock_alloc_try_nid_raw(size, align, goal,
-					       BOOTMEM_ALLOC_ACCESSIBLE, node);
+					       MEMBLOCK_ALLOC_ACCESSIBLE, node);
 }
 
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
diff --git a/mm/sparse.c b/mm/sparse.c
index 509828f..0dcc306 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
@@ -393,7 +394,7 @@ struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 
 	map = memblock_alloc_try_nid(size,
 					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-					  BOOTMEM_ALLOC_ACCESSIBLE, nid);
+					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	return map;
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
@@ -407,7 +408,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf =
 		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
-						BOOTMEM_ALLOC_ACCESSIBLE, nid);
+						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
-- 
2.7.4


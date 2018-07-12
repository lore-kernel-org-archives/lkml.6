Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529FECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A745D208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tDjRGUDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A745D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeGLUti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:49:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbeGLUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:49:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CKSjZm153147;
        Thu, 12 Jul 2018 20:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=8ZM/0mqwgQb8eUTqPwNgeSXK/SVnZi3XeKmISpY0rnY=;
 b=tDjRGUDLtjzLo70QYsPHo7sg7fTuqCYus3DS61pEIeiZ3HSQfLFgYPzaLh9CLaadxN7b
 1ILaSscX1LiyMB3E4G24KJWQKMnWgoI4BQAB/ahc12vMMJtRh/kQR4C5ar9SlKvMpGTi
 44KX45hAFj65sY8hDL3RNJRjHzmfcEn9HY4VWi9RJz0XJ1AU4j7PMzqs++rUW6xKUFDC
 eGyy+8gydR/PZYYpx5PwJKmGUf2Aht+nKxXoM5iHRVuz+xi98uuxjkHnG3inyVuTeB4g
 ViEeNJDSfmMAihTXPDGu7CwdJ1iorcJP/s3HNqmn79rlaZp7nxDVNfGs1h+KmTG3Spwg Dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p76dd75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CKbqii030653
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:53 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6CKbq7a004352;
        Thu, 12 Jul 2018 20:37:52 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 13:37:52 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com,
        abdhalee@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v5 5/5] mm/sparse: delete old sprase_init and enable new one
Date:   Thu, 12 Jul 2018 16:37:30 -0400
Message-Id: <20180712203730.8703-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712203730.8703-1-pasha.tatashin@oracle.com>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename new_sparse_init() to sparse_init() which enables it. Delete old
sparse_init() and all the code that became obsolete with.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/mm.h  |   6 --
 mm/Kconfig          |   4 -
 mm/sparse-vmemmap.c |  21 -----
 mm/sparse.c         | 217 +-------------------------------------------
 4 files changed, 1 insertion(+), 247 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 99d8c50adef6..726e71475144 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2649,12 +2649,6 @@ extern int randomize_va_space;
 const char * arch_vma_name(struct vm_area_struct *vma);
 void print_vma_addr(char *prefix, unsigned long rip);
 
-void sparse_mem_maps_populate_node(struct page **map_map,
-				   unsigned long pnum_begin,
-				   unsigned long pnum_end,
-				   unsigned long map_count,
-				   int nodeid);
-
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap);
diff --git a/mm/Kconfig b/mm/Kconfig
index 28fcf54946ea..b78e7cd4e9fe 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -115,10 +115,6 @@ config SPARSEMEM_EXTREME
 config SPARSEMEM_VMEMMAP_ENABLE
 	bool
 
-config SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-	def_bool y
-	depends on SPARSEMEM && X86_64
-
 config SPARSEMEM_VMEMMAP
 	bool "Sparse Memory virtual memmap"
 	depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index cd15f3d252c3..8301293331a2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -261,24 +261,3 @@ struct page * __meminit sparse_mem_map_populate(unsigned long pnum, int nid,
 
 	return map;
 }
-
-void __init sparse_mem_maps_populate_node(struct page **map_map,
-					  unsigned long pnum_begin,
-					  unsigned long pnum_end,
-					  unsigned long map_count, int nodeid)
-{
-	unsigned long pnum;
-	int nr_consumed_maps = 0;
-
-	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-		if (!present_section_nr(pnum))
-			continue;
-
-		map_map[nr_consumed_maps] =
-				sparse_mem_map_populate(pnum, nodeid, NULL);
-		if (map_map[nr_consumed_maps++])
-			continue;
-		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
-		       __func__);
-	}
-}
diff --git a/mm/sparse.c b/mm/sparse.c
index 4087b94afddf..3335a1c7e9be 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -205,12 +205,6 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
-/*
- * Record how many memory sections are marked as present
- * during system bootup.
- */
-static int __initdata nr_present_sections;
-
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
 {
@@ -240,7 +234,6 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
 			section_mark_present(ms);
-			nr_present_sections++;
 		}
 	}
 }
@@ -377,34 +370,6 @@ static void __init check_usemap_section_nr(int nid, unsigned long *usemap)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-static void __init sparse_early_usemaps_alloc_node(void *data,
-				 unsigned long pnum_begin,
-				 unsigned long pnum_end,
-				 unsigned long usemap_count, int nodeid)
-{
-	void *usemap;
-	unsigned long pnum;
-	unsigned long **usemap_map = (unsigned long **)data;
-	int size = usemap_size();
-	int nr_consumed_maps = 0;
-
-	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nodeid),
-							  size * usemap_count);
-	if (!usemap) {
-		pr_warn("%s: allocation failed\n", __func__);
-		return;
-	}
-
-	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-		if (!present_section_nr(pnum))
-			continue;
-		usemap_map[nr_consumed_maps] = usemap;
-		usemap += size;
-		check_usemap_section_nr(nodeid, usemap_map[nr_consumed_maps]);
-		nr_consumed_maps++;
-	}
-}
-
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 static unsigned long __init section_map_size(void)
 
@@ -489,190 +454,10 @@ void * __meminit sparse_buffer_alloc(unsigned long size)
 	return ptr;
 }
 
-#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-static void __init sparse_early_mem_maps_alloc_node(void *data,
-				 unsigned long pnum_begin,
-				 unsigned long pnum_end,
-				 unsigned long map_count, int nodeid)
-{
-	struct page **map_map = (struct page **)data;
-
-	sparse_buffer_init(section_map_size() * map_count, nodeid);
-	sparse_mem_maps_populate_node(map_map, pnum_begin, pnum_end,
-					 map_count, nodeid);
-	sparse_buffer_fini();
-}
-#else
-static struct page __init *sparse_early_mem_map_alloc(unsigned long pnum)
-{
-	struct page *map;
-	struct mem_section *ms = __nr_to_section(pnum);
-	int nid = sparse_early_nid(ms);
-
-	map = sparse_mem_map_populate(pnum, nid, NULL);
-	if (map)
-		return map;
-
-	pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
-	       __func__);
-	return NULL;
-}
-#endif
-
 void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
-/**
- *  alloc_usemap_and_memmap - memory alloction for pageblock flags and vmemmap
- *  @map: usemap_map for pageblock flags or mmap_map for vmemmap
- *  @unit_size: size of map unit
- */
-static void __init alloc_usemap_and_memmap(void (*alloc_func)
-					(void *, unsigned long, unsigned long,
-					unsigned long, int), void *data,
-					int data_unit_size)
-{
-	unsigned long pnum;
-	unsigned long map_count;
-	int nodeid_begin = 0;
-	unsigned long pnum_begin = 0;
-
-	for_each_present_section_nr(0, pnum) {
-		struct mem_section *ms;
-
-		ms = __nr_to_section(pnum);
-		nodeid_begin = sparse_early_nid(ms);
-		pnum_begin = pnum;
-		break;
-	}
-	map_count = 1;
-	for_each_present_section_nr(pnum_begin + 1, pnum) {
-		struct mem_section *ms;
-		int nodeid;
-
-		ms = __nr_to_section(pnum);
-		nodeid = sparse_early_nid(ms);
-		if (nodeid == nodeid_begin) {
-			map_count++;
-			continue;
-		}
-		/* ok, we need to take cake of from pnum_begin to pnum - 1*/
-		alloc_func(data, pnum_begin, pnum,
-						map_count, nodeid_begin);
-		/* new start, update count etc*/
-		nodeid_begin = nodeid;
-		pnum_begin = pnum;
-		data += map_count * data_unit_size;
-		map_count = 1;
-	}
-	/* ok, last chunk */
-	alloc_func(data, pnum_begin, __highest_present_section_nr+1,
-						map_count, nodeid_begin);
-}
-
-/*
- * Allocate the accumulated non-linear sections, allocate a mem_map
- * for each and record the physical to section mapping.
- */
-void __init sparse_init(void)
-{
-	unsigned long pnum;
-	struct page *map;
-	unsigned long *usemap;
-	unsigned long **usemap_map;
-	int size;
-	int nr_consumed_maps = 0;
-#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-	int size2;
-	struct page **map_map;
-#endif
-
-	/* see include/linux/mmzone.h 'struct mem_section' definition */
-	BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
-
-	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
-	set_pageblock_order();
-
-	/*
-	 * map is using big page (aka 2M in x86 64 bit)
-	 * usemap is less one page (aka 24 bytes)
-	 * so alloc 2M (with 2M align) and 24 bytes in turn will
-	 * make next 2M slip to one more 2M later.
-	 * then in big system, the memory will have a lot of holes...
-	 * here try to allocate 2M pages continuously.
-	 *
-	 * powerpc need to call sparse_init_one_section right after each
-	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
-	 */
-	size = sizeof(unsigned long *) * nr_present_sections;
-	usemap_map = memblock_virt_alloc(size, 0);
-	if (!usemap_map)
-		panic("can not allocate usemap_map\n");
-	alloc_usemap_and_memmap(sparse_early_usemaps_alloc_node,
-				(void *)usemap_map,
-				sizeof(usemap_map[0]));
-
-#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-	size2 = sizeof(struct page *) * nr_present_sections;
-	map_map = memblock_virt_alloc(size2, 0);
-	if (!map_map)
-		panic("can not allocate map_map\n");
-	alloc_usemap_and_memmap(sparse_early_mem_maps_alloc_node,
-				(void *)map_map,
-				sizeof(map_map[0]));
-#endif
-
-	/*
-	 * The number of present sections stored in nr_present_sections
-	 * are kept the same since mem sections are marked as present in
-	 * memory_present(). In this for loop, we need check which sections
-	 * failed to allocate memmap or usemap, then clear its
-	 * ->section_mem_map accordingly. During this process, we need
-	 * increase 'nr_consumed_maps' whether its allocation of memmap
-	 * or usemap failed or not, so that after we handle the i-th
-	 * memory section, can get memmap and usemap of (i+1)-th section
-	 * correctly.
-	 */
-	for_each_present_section_nr(0, pnum) {
-		struct mem_section *ms;
-
-		if (nr_consumed_maps >= nr_present_sections) {
-			pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
-			break;
-		}
-		ms = __nr_to_section(pnum);
-		usemap = usemap_map[nr_consumed_maps];
-		if (!usemap) {
-			ms->section_mem_map = 0;
-			nr_consumed_maps++;
-			continue;
-		}
-
-#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-		map = map_map[nr_consumed_maps];
-#else
-		map = sparse_early_mem_map_alloc(pnum);
-#endif
-		if (!map) {
-			ms->section_mem_map = 0;
-			nr_consumed_maps++;
-			continue;
-		}
-
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
-								usemap);
-		nr_consumed_maps++;
-	}
-
-	vmemmap_populate_print_last();
-
-#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-	memblock_free_early(__pa(map_map), size2);
-#endif
-	memblock_free_early(__pa(usemap_map), size);
-}
-
 /*
  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
  * And number of present sections in this node is map_count.
@@ -726,7 +511,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
  */
-void __init new_sparse_init(void)
+void __init sparse_init(void)
 {
 	unsigned long pnum_begin = first_present_section_nr();
 	int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
-- 
2.18.0


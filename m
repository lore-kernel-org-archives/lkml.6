Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE10C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B72692A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752B72692A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964908AbeF0Bbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:31:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934710AbeF0Bbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:31:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB0E48A703;
        Wed, 27 Jun 2018 01:31:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04F89111764C;
        Wed, 27 Jun 2018 01:31:39 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, pagupta@redhat.com
Cc:     linux-mm@kvack.org, kirill.shutemov@linux.intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 4/4] mm/sparse: Optimize memmap allocation during sparse_init()
Date:   Wed, 27 Jun 2018 09:31:16 +0800
Message-Id: <20180627013116.12411-5-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-1-bhe@redhat.com>
References: <20180627013116.12411-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 01:31:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 27 Jun 2018 01:31:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sparse_init(), two temporary pointer arrays, usemap_map and map_map
are allocated with the size of NR_MEM_SECTIONS. They are used to store
each memory section's usemap and mem map if marked as present. With
the help of these two arrays, continuous memory chunk is allocated for
usemap and memmap for memory sections on one node. This avoids too many
memory fragmentations. Like below diagram, '1' indicates the present
memory section, '0' means absent one. The number 'n' could be much
smaller than NR_MEM_SECTIONS on most of systems.

|1|1|1|1|0|0|0|0|1|1|0|0|...|1|0||1|0|...|1||0|1|...|0|
-------------------------------------------------------
 0 1 2 3         4 5         i   i+1     n-1   n

If fail to populate the page tables to map one section's memmap, its
->section_mem_map will be cleared finally to indicate that it's not present.
After use, these two arrays will be released at the end of sparse_init().

In 4-level paging mode, each array costs 4M which can be ignorable. While
in 5-level paging, they costs 256M each, 512M altogether. Kdump kernel
Usually only reserves very few memory, e.g 256M. So, even thouth they are
temporarily allocated, still not acceptable.

In fact, there's no need to allocate them with the size of NR_MEM_SECTIONS.
Since the ->section_mem_map clearing has been deferred to the last, the
number of present memory sections are kept the same during sparse_init()
until we finally clear out the memory section's ->section_mem_map if its
usemap or memmap is not correctly handled. Thus in the middle whenever
for_each_present_section_nr() loop is taken, the i-th present memory
section is always the same one.

Here only allocate usemap_map and map_map with the size of
'nr_present_sections'. For the i-th present memory section, install its
usemap and memmap to usemap_map[i] and mam_map[i] during allocation. Then
in the last for_each_present_section_nr() loop which clears the failed
memory section's ->section_mem_map, fetch usemap and memmap from
usemap_map[] and map_map[] array and set them into mem_section[]
accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse-vmemmap.c |  5 +++--
 mm/sparse.c         | 43 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 640e68f8324b..a98ec2fb6915 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -281,6 +281,7 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 	unsigned long pnum;
 	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
 	void *vmemmap_buf_start;
+	int nr_consumed_maps = 0;
 
 	size = ALIGN(size, PMD_SIZE);
 	vmemmap_buf_start = __earlyonly_bootmem_alloc(nodeid, size * map_count,
@@ -297,8 +298,8 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		if (!present_section_nr(pnum))
 			continue;
 
-		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
-		if (map_map[pnum])
+		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
+		if (map_map[nr_consumed_maps++])
 			continue;
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
diff --git a/mm/sparse.c b/mm/sparse.c
index b2848cc6e32a..2eb8ee72e44d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -386,6 +386,7 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
 	unsigned long pnum;
 	unsigned long **usemap_map = (unsigned long **)data;
 	int size = usemap_size();
+	int nr_consumed_maps = 0;
 
 	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nodeid),
 							  size * usemap_count);
@@ -397,9 +398,10 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
-		usemap_map[pnum] = usemap;
+		usemap_map[nr_consumed_maps] = usemap;
 		usemap += size;
-		check_usemap_section_nr(nodeid, usemap_map[pnum]);
+		check_usemap_section_nr(nodeid, usemap_map[nr_consumed_maps]);
+		nr_consumed_maps++;
 	}
 }
 
@@ -424,29 +426,33 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 	void *map;
 	unsigned long pnum;
 	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
+	int nr_consumed_maps;
 
 	size = PAGE_ALIGN(size);
 	map = memblock_virt_alloc_try_nid_raw(size * map_count,
 					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
 					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
 	if (map) {
+		nr_consumed_maps = 0;
 		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 			if (!present_section_nr(pnum))
 				continue;
-			map_map[pnum] = map;
+			map_map[nr_consumed_maps] = map;
 			map += size;
+			nr_consumed_maps++;
 		}
 		return;
 	}
 
 	/* fallback */
+	nr_consumed_maps = 0;
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 		struct mem_section *ms;
 
 		if (!present_section_nr(pnum))
 			continue;
-		map_map[pnum] = sparse_mem_map_populate(pnum, nodeid, NULL);
-		if (map_map[pnum])
+		map_map[nr_consumed_maps] = sparse_mem_map_populate(pnum, nodeid, NULL);
+		if (map_map[nr_consumed_maps++])
 			continue;
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
@@ -526,6 +532,7 @@ static void __init alloc_usemap_and_memmap(void (*alloc_func)
 		/* new start, update count etc*/
 		nodeid_begin = nodeid;
 		pnum_begin = pnum;
+		data += map_count * data_unit_size;
 		map_count = 1;
 	}
 	/* ok, last chunk */
@@ -544,6 +551,7 @@ void __init sparse_init(void)
 	unsigned long *usemap;
 	unsigned long **usemap_map;
 	int size;
+	int nr_consumed_maps = 0;
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
 	int size2;
 	struct page **map_map;
@@ -566,7 +574,7 @@ void __init sparse_init(void)
 	 * powerpc need to call sparse_init_one_section right after each
 	 * sparse_early_mem_map_alloc, so allocate usemap_map at first.
 	 */
-	size = sizeof(unsigned long *) * NR_MEM_SECTIONS;
+	size = sizeof(unsigned long *) * nr_present_sections;
 	usemap_map = memblock_virt_alloc(size, 0);
 	if (!usemap_map)
 		panic("can not allocate usemap_map\n");
@@ -575,7 +583,7 @@ void __init sparse_init(void)
 				sizeof(usemap_map[0]));
 
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-	size2 = sizeof(struct page *) * NR_MEM_SECTIONS;
+	size2 = sizeof(struct page *) * nr_present_sections;
 	map_map = memblock_virt_alloc(size2, 0);
 	if (!map_map)
 		panic("can not allocate map_map\n");
@@ -584,27 +592,44 @@ void __init sparse_init(void)
 				sizeof(map_map[0]));
 #endif
 
+	/* The numner of present sections stored in nr_present_sections
+	 * are kept the same since mem sections are marked as present in
+	 * memory_present(). In this for loop, we need check which sections
+	 * failed to allocate memmap or usemap, then clear its
+	 * ->section_mem_map accordingly. During this process, we need
+	 * increase 'nr_consumed_maps' whether its allocation of memmap
+	 * or usemap failed or not, so that after we handle the i-th
+	 * memory section, can get memmap and usemap of (i+1)-th section
+	 * correctly. */
 	for_each_present_section_nr(0, pnum) {
 		struct mem_section *ms;
+
+		if (nr_consumed_maps >= nr_present_sections) {
+			pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
+			break;
+		}
 		ms = __nr_to_section(pnum);
-		usemap = usemap_map[pnum];
+		usemap = usemap_map[nr_consumed_maps];
 		if (!usemap) {
 			ms->section_mem_map = 0;
+			nr_consumed_maps++;
 			continue;
 		}
 
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
-		map = map_map[pnum];
+		map = map_map[nr_consumed_maps];
 #else
 		map = sparse_early_mem_map_alloc(pnum);
 #endif
 		if (!map) {
 			ms->section_mem_map = 0;
+			nr_consumed_maps++;
 			continue;
 		}
 
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
 								usemap);
+		nr_consumed_maps++;
 	}
 
 	vmemmap_populate_print_last();
-- 
2.13.6


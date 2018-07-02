Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75035C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2601E25598
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vNBdmWki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2601E25598
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeGBCE5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:04:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeGBCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:04:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6224RXd076789;
        Mon, 2 Jul 2018 02:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=eCMv7WXR610Sa5Czsc68BEnwropWZTFoCWClHm/pG3s=;
 b=vNBdmWkixzH1lxrSoS32Hg3eSdqYvGV9x4y5+HhEBXKZhgjKrfNInB+Zss+8aY5ppVDI
 ghA3kPQ3vJ3vgiU1LMHsHwGIJHggnnEyX8EroXNs5tcXoH8Dxux5jqC0id0ogY05PYWl
 zy8dcfRAh2uVt6NtDM+sgUfEpR+UHFpV4lNK+FbJ2bXrMxeJCQXa+btmS3d7zsl/UnG4
 XFzP3eEnwOLeabXAKuS/5iqSaVspPg4VNI4tEM39/+Y/AoqJMtlQgoBOWobZqg9lQAiq
 vm/K9pAZM9+kTCLI+j155SHffddL0kwWkb1bqf66W5pIGVeIjtfQp7BNeQKwZMnTTopm dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gptgx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 02:04:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6224P0n008524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 02:04:25 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6224OcD004407;
        Mon, 2 Jul 2018 02:04:24 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 19:04:23 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com
Subject: [PATCH v3 1/2] mm/sparse: add sparse_init_nid()
Date:   Sun,  1 Jul 2018 22:04:16 -0400
Message-Id: <20180702020417.21281-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702020417.21281-1-pasha.tatashin@oracle.com>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse_init() requires to temporary allocate two large buffers:
usemap_map and map_map. Baoquan He has identified that these buffers are so
large that Linux is not bootable on small memory machines, such as a kdump
boot. The buffers are especially large when CONFIG_X86_5LEVEL is set, as
they are scaled to the maximum physical memory size.

Baoquan provided a fix, which reduces these sizes of these buffers, but it
is much better to get rid of them entirely.

Add a new way to initialize sparse memory: sparse_init_nid(), which only
operates within one memory node, and thus allocates memory either in large
contiguous block or allocates section by section. This eliminates the need
for use of temporary buffers.

For simplified bisecting and review, the new interface is going to be
enabled as well as old code removed in the next patch.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h  |  8 ++++
 mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++
 mm/sparse.c         | 91 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..85530fdfb1f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2651,6 +2651,14 @@ void sparse_mem_maps_populate_node(struct page **map_map,
 				   unsigned long pnum_end,
 				   unsigned long map_count,
 				   int nodeid);
+struct page * sparse_populate_node(unsigned long pnum_begin,
+				   unsigned long pnum_end,
+				   unsigned long map_count,
+				   int nid);
+struct page * sparse_populate_node_section(struct page *map_base,
+				   unsigned long map_index,
+				   unsigned long pnum,
+				   int nid);
 
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index e1a54ba411ec..b3e325962306 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -311,3 +311,52 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		vmemmap_buf_end = NULL;
 	}
 }
+
+struct page * __init sparse_populate_node(unsigned long pnum_begin,
+					  unsigned long pnum_end,
+					  unsigned long map_count,
+					  int nid)
+{
+	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
+	unsigned long pnum, map_index = 0;
+	void *vmemmap_buf_start;
+
+	size = ALIGN(size, PMD_SIZE) * map_count;
+	vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
+						      PMD_SIZE,
+						      __pa(MAX_DMA_ADDRESS));
+	if (vmemmap_buf_start) {
+		vmemmap_buf = vmemmap_buf_start;
+		vmemmap_buf_end = vmemmap_buf_start + size;
+	}
+
+	for (pnum = pnum_begin; map_index < map_count; pnum++) {
+		if (!present_section_nr(pnum))
+			continue;
+		if (!sparse_mem_map_populate(pnum, nid, NULL))
+			break;
+		map_index++;
+		BUG_ON(pnum >= pnum_end);
+	}
+
+	if (vmemmap_buf_start) {
+		/* need to free left buf */
+		memblock_free_early(__pa(vmemmap_buf),
+				    vmemmap_buf_end - vmemmap_buf);
+		vmemmap_buf = NULL;
+		vmemmap_buf_end = NULL;
+	}
+	return pfn_to_page(section_nr_to_pfn(pnum_begin));
+}
+
+/*
+ * Return map for pnum section. sparse_populate_node() has populated memory map
+ * in this node, we simply do pnum to struct page conversion.
+ */
+struct page * __init sparse_populate_node_section(struct page *map_base,
+						  unsigned long map_index,
+						  unsigned long pnum,
+						  int nid)
+{
+	return pfn_to_page(section_nr_to_pfn(pnum));
+}
diff --git a/mm/sparse.c b/mm/sparse.c
index d18e2697a781..c18d92b8ab9b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -456,6 +456,43 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		       __func__);
 	}
 }
+
+static unsigned long section_map_size(void)
+{
+	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
+}
+
+/*
+ * Try to allocate all struct pages for this node, if this fails, we will
+ * be allocating one section at a time in sparse_populate_node_section().
+ */
+struct page * __init sparse_populate_node(unsigned long pnum_begin,
+					  unsigned long pnum_end,
+					  unsigned long map_count,
+					  int nid)
+{
+	return memblock_virt_alloc_try_nid_raw(section_map_size() * map_count,
+					       PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
+					       BOOTMEM_ALLOC_ACCESSIBLE, nid);
+}
+
+/*
+ * Return map for pnum section. map_base is not NULL if we could allocate map
+ * for this node together. Otherwise we allocate one section at a time.
+ * map_index is the index of pnum in this node counting only present sections.
+ */
+struct page * __init sparse_populate_node_section(struct page *map_base,
+						  unsigned long map_index,
+						  unsigned long pnum,
+						  int nid)
+{
+	if (map_base) {
+		unsigned long offset = section_map_size() * map_index;
+
+		return (struct page *)((char *)map_base + offset);
+	}
+	return sparse_mem_map_populate(pnum, nid, NULL);
+}
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
 static void __init sparse_early_mem_maps_alloc_node(void *data,
@@ -520,6 +557,60 @@ static void __init alloc_usemap_and_memmap(void (*alloc_func)
 						map_count, nodeid_begin);
 }
 
+/*
+ * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
+ * And number of present sections in this node is map_count.
+ */
+void __init sparse_init_nid(int nid, unsigned long pnum_begin,
+				   unsigned long pnum_end,
+				   unsigned long map_count)
+{
+	unsigned long pnum, usemap_longs, *usemap, map_index;
+	struct page *map, *map_base;
+
+	usemap_longs = BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS);
+	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
+							  usemap_size() *
+							  map_count);
+	if (!usemap) {
+		pr_err("%s: usemap allocation failed", __func__);
+		goto failed;
+	}
+	map_base = sparse_populate_node(pnum_begin, pnum_end,
+					map_count, nid);
+	map_index = 0;
+	for_each_present_section_nr(pnum_begin, pnum) {
+		if (pnum >= pnum_end)
+			break;
+
+		BUG_ON(map_index == map_count);
+		map = sparse_populate_node_section(map_base, map_index,
+						   pnum, nid);
+		if (!map) {
+			pr_err("%s: memory map backing failed. Some memory will not be available.",
+			       __func__);
+			pnum_begin = pnum;
+			goto failed;
+		}
+		check_usemap_section_nr(nid, usemap);
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
+					usemap);
+		map_index++;
+		usemap += usemap_longs;
+	}
+	return;
+failed:
+	/* We failed to allocate, mark all the following pnums as not present */
+	for_each_present_section_nr(pnum_begin, pnum) {
+		struct mem_section *ms;
+
+		if (pnum >= pnum_end)
+			break;
+		ms = __nr_to_section(pnum);
+		ms->section_mem_map = 0;
+	}
+}
+
 /*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
-- 
2.18.0


Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9506ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8X1f/50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPSN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:13:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:13:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GHiK1w163779;
        Mon, 16 Jul 2018 17:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7P8Zix/+42Y1xfp5QebVrva2IapRlzBeiLbJtzwMCjY=;
 b=Q8X1f/50D7H5uIBSSIVdDOqUbO6dT3Pl6txI8+3Sl3p6TWzqD9Gh68dz/C1GANbt74wO
 NNYJ3ctw7FwBQNvRwZv1ZoBawzZww6lPE6bfbWt/F0ReKUpmTDd5tTChEh0j+83gYzen
 OLm+htMmF3Mk2gKuB75WoXu4JpjDlC4x142rhLJchtvo6jKY48OyVhT+f25pTf8TePiZ
 IZhVBOVjo2grE/xz/EHKxdh1AXEcOW/J02uFdrH6jvRJJOd+xJg4EkC8N3pDQW83UaiT
 j1/8IEx2B18Q9s1smhKB7EaPUgYn7oTT/N0F86rwFBHq/gyMM5VKp2jRx9lh8oFKYkD7 Gg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k7a3jnh0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHivQG026489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GHithc010286;
        Mon, 16 Jul 2018 17:44:55 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:44:55 -0700
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
Subject: [PATCH v6 1/5] mm/sparse: abstract sparse buffer allocations
Date:   Mon, 16 Jul 2018 13:44:43 -0400
Message-Id: <20180716174447.14529-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716174447.14529-1-pasha.tatashin@oracle.com>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When struct pages are allocated for sparse-vmemmap VA layout, we first try
to allocate one large buffer, and than if that fails allocate struct pages
for each section as we go.

The code that allocates buffer is uses global variables and is spread
across several call sites.

Cleanup the code by introducing three functions to handle the global
buffer:

sparse_buffer_init()	initialize the buffer
sparse_buffer_fini()	free the remaining part of the buffer
sparse_buffer_alloc()	alloc from the buffer, and if buffer is empty
return NULL

Define these functions in sparse.c instead of sparse-vmemmap.c because
later we will use them for non-vmemmap sparse allocations as well.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/mm.h  |  4 ++++
 mm/sparse-vmemmap.c | 40 ++++++----------------------------------
 mm/sparse.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 577e578eb640..a83d3e0e66d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2655,6 +2655,10 @@ void sparse_mem_maps_populate_node(struct page **map_map,
 				   unsigned long map_count,
 				   int nodeid);
 
+unsigned long __init section_map_size(void);
+void sparse_buffer_init(unsigned long size, int nid);
+void sparse_buffer_fini(void);
+void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 95e2c7638a5c..b05c7663c640 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -43,12 +43,9 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 				unsigned long goal)
 {
 	return memblock_virt_alloc_try_nid_raw(size, align, goal,
-					    BOOTMEM_ALLOC_ACCESSIBLE, node);
+					       BOOTMEM_ALLOC_ACCESSIBLE, node);
 }
 
-static void *vmemmap_buf;
-static void *vmemmap_buf_end;
-
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 {
 	/* If the main allocator is up use that, fallback to bootmem. */
@@ -76,18 +73,10 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 /* need to make sure size is all the same during early stage */
 void * __meminit vmemmap_alloc_block_buf(unsigned long size, int node)
 {
-	void *ptr;
-
-	if (!vmemmap_buf)
-		return vmemmap_alloc_block(size, node);
-
-	/* take the from buf */
-	ptr = (void *)ALIGN((unsigned long)vmemmap_buf, size);
-	if (ptr + size > vmemmap_buf_end)
-		return vmemmap_alloc_block(size, node);
-
-	vmemmap_buf = ptr + size;
+	void *ptr = sparse_buffer_alloc(size);
 
+	if (!ptr)
+		ptr = vmemmap_alloc_block(size, node);
 	return ptr;
 }
 
@@ -279,19 +268,9 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 					  unsigned long map_count, int nodeid)
 {
 	unsigned long pnum;
-	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
-	void *vmemmap_buf_start;
 	int nr_consumed_maps = 0;
 
-	size = ALIGN(size, PMD_SIZE);
-	vmemmap_buf_start = __earlyonly_bootmem_alloc(nodeid, size * map_count,
-			 PMD_SIZE, __pa(MAX_DMA_ADDRESS));
-
-	if (vmemmap_buf_start) {
-		vmemmap_buf = vmemmap_buf_start;
-		vmemmap_buf_end = vmemmap_buf_start + size * map_count;
-	}
-
+	sparse_buffer_init(section_map_size() * map_count, nodeid);
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
@@ -303,12 +282,5 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
 	}
-
-	if (vmemmap_buf_start) {
-		/* need to free left buf */
-		memblock_free_early(__pa(vmemmap_buf),
-				    vmemmap_buf_end - vmemmap_buf);
-		vmemmap_buf = NULL;
-		vmemmap_buf_end = NULL;
-	}
+	sparse_buffer_fini();
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 2ea8b3dbd0df..9a0a5f598469 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -400,7 +400,14 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
 	}
 }
 
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+unsigned long __init section_map_size(void)
+
+{
+	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
+}
+
+#else
 struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap)
 {
@@ -457,6 +464,42 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
+static void *sparsemap_buf __meminitdata;
+static void *sparsemap_buf_end __meminitdata;
+
+void __init sparse_buffer_init(unsigned long size, int nid)
+{
+	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
+	sparsemap_buf =
+		memblock_virt_alloc_try_nid_raw(size, PAGE_SIZE,
+						__pa(MAX_DMA_ADDRESS),
+						BOOTMEM_ALLOC_ACCESSIBLE, nid);
+	sparsemap_buf_end = sparsemap_buf + size;
+}
+
+void __init sparse_buffer_fini(void)
+{
+	unsigned long size = sparsemap_buf_end - sparsemap_buf;
+
+	if (sparsemap_buf && size > 0)
+		memblock_free_early(__pa(sparsemap_buf), size);
+	sparsemap_buf = NULL;
+}
+
+void * __meminit sparse_buffer_alloc(unsigned long size)
+{
+	void *ptr = NULL;
+
+	if (sparsemap_buf) {
+		ptr = PTR_ALIGN(sparsemap_buf, size);
+		if (ptr + size > sparsemap_buf_end)
+			ptr = NULL;
+		else
+			sparsemap_buf = ptr + size;
+	}
+	return ptr;
+}
+
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
 static void __init sparse_early_mem_maps_alloc_node(void *data,
 				 unsigned long pnum_begin,
-- 
2.18.0


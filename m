Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2BECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6F2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZH6Xoi/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF6F2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeGLUtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:49:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGLUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:49:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CKSudA152046;
        Thu, 12 Jul 2018 20:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Q2cZNYC745nuFn5fyPmxQMIBBemPYgtVKqIT1J+lGs4=;
 b=ZH6Xoi/HnGijYlL6UAsW3jlnYitZcXQZjm42LdPxHc+Re2Z0BJR7vOPakOLaAFLyASdC
 NqZaYQvOe6NUBHItmSMGr/7LgC+1MKDzZUVxTvDrgpozTjx2RehvrFQBtS+X7eB9LK4f
 QNt5yl9ATrfE4Lly9FEiejx8OYDLv4vGBY5OLuhVu2WOycm9IqCUpekqWX5oxyZ1ieOW
 QrmuL/iW6vph4exf1GpAgmsQuiLZPRvZH44W183TOkEbK0ZTg1n/MdEDhQuKRszUdCee
 /rS1xoS6uXalTmRIaoCgiWiGj+nXNJ7zOn+DerBDRIVjdVU3zkrK+VHq0bqyHqvTeAG+ 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k2p7vnaf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CKbkZJ030392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 20:37:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CKbjQb030770;
        Thu, 12 Jul 2018 20:37:45 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 13:37:45 -0700
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
Subject: [PATCH v5 2/5] mm/sparse: use the new sparse buffer functions in non-vmemmap
Date:   Thu, 12 Jul 2018 16:37:27 -0400
Message-Id: <20180712203730.8703-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712203730.8703-1-pasha.tatashin@oracle.com>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

non-vmemmap sparse also allocated large contiguous chunk of memory, and if
fails falls back to smaller allocations. Use the same functions to allocate
buffer as the vmemmap-sparse

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index ac57bae476f4..976854a3af8b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -408,13 +408,20 @@ unsigned long __init section_map_size(void)
 }
 
 #else
+unsigned long __init section_map_size(void)
+{
+	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
+}
+
 struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap)
 {
-	struct page *map;
-	unsigned long size;
+	unsigned long size = section_map_size();
+	struct page *map = sparse_buffer_alloc(size);
+
+	if (map)
+		return map;
 
-	size = PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 	map = memblock_virt_alloc_try_nid(size,
 					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
 					  BOOTMEM_ALLOC_ACCESSIBLE, nid);
@@ -425,42 +432,22 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 					  unsigned long pnum_end,
 					  unsigned long map_count, int nodeid)
 {
-	void *map;
 	unsigned long pnum;
-	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
-	int nr_consumed_maps;
-
-	size = PAGE_ALIGN(size);
-	map = memblock_virt_alloc_try_nid_raw(size * map_count,
-					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
-					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
-	if (map) {
-		nr_consumed_maps = 0;
-		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-			if (!present_section_nr(pnum))
-				continue;
-			map_map[nr_consumed_maps] = map;
-			map += size;
-			nr_consumed_maps++;
-		}
-		return;
-	}
+	unsigned long size = section_map_size();
+	int nr_consumed_maps = 0;
 
-	/* fallback */
-	nr_consumed_maps = 0;
+	sparse_buffer_init(size * map_count, nodeid);
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
-		struct mem_section *ms;
-
 		if (!present_section_nr(pnum))
 			continue;
 		map_map[nr_consumed_maps] =
 				sparse_mem_map_populate(pnum, nodeid, NULL);
 		if (map_map[nr_consumed_maps++])
 			continue;
-		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
 	}
+	sparse_buffer_fini();
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
-- 
2.18.0


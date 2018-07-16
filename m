Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E459ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C72E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFUGJQ6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C72E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGPSOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:14:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59278 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:14:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GHi8Im163733;
        Mon, 16 Jul 2018 17:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=fsHN3cRqNwz0z/QFyBgyDamE+zttx1UR+T0B3voIMew=;
 b=jFUGJQ6Jfnp0RMT3ry6S14XBk7FO02491Lh9YN7xPoI5jj2HvN2k3YMVvTKDlv5qSLlf
 hsAZnj2DeV9bHldsstCfMOY0qJpZXE6z43ePtrcTqRRMO097HFQpT3RPH7a8YF00yGJO
 +WmRx7LeBKel2QPMMt4EYIpEnHOD67xTrE3EW5npykFqcJe5mF/iE8UsuKn6/qnqSEHM
 y0JUUMpcWj1QaXLrKsT1+BQGAuNwhvqIcCPzGEdzPEbm4XSkJNUXSTfWIKFbp0ykhodq
 ZFhjIxav1Kp4vywdN9Q3wodqqZpjnTsX13IwvAfsUtYOhgT1zJcWRzaYSJwSO1F8X9Py WQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k7a3jnh0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHixeW001747
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:44:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHiwxG011063;
        Mon, 16 Jul 2018 17:44:58 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:44:57 -0700
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
Subject: [PATCH v6 2/5] mm/sparse: use the new sparse buffer functions in non-vmemmap
Date:   Mon, 16 Jul 2018 13:44:44 -0400
Message-Id: <20180716174447.14529-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716174447.14529-1-pasha.tatashin@oracle.com>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

non-vmemmap sparse also allocated large contiguous chunk of memory, and if
fails falls back to smaller allocations.  Use the same functions to
allocate buffer as the vmemmap-sparse

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 9a0a5f598469..db4867b62fff 100644
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


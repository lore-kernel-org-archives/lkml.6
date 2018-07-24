Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6CEC67790
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sY3stGZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A299E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGYBFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:05:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbeGYBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:05:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6ONrqAj101316;
        Tue, 24 Jul 2018 23:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=I2FasBF0aIFRoHs4rlBGSdoIJv5z2OYszEDfER7UDpk=;
 b=sY3stGZJgwoP+W3pJRbD/NC+RoBKNS5IrCOjVIrYY/R5O9A+0tF43xoXv7tQ153cgchf
 P1Yz+SzQWVKpmFCDnGBxsCN/snGW4/rCkzNkJ1NT6JKbFOLFV8/+Gj7NBKr+QuFZVqrL
 kEVymq6LRn+jEOvo1Du0v9FJ4y2fEZ5Qd10uD5TJy/bFZNNO8t3DW6Xz3gaOmYWVfF2r
 bBO8Zvjyy4SZ0S1KgnVPEXXahKR22R3BAfTWcfufYETss6r8OQi2fTPRvnNQieVyji5/
 vo+EreX3NGb3atY0LEHZkFYOxgaeWspsFToJSGPTIKqb+BLXlXjbaQizhpO8XiaBmJ1P sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kbv8t394f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jul 2018 23:55:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6ONtZvV003816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jul 2018 23:55:35 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6ONtVaQ019125;
        Tue, 24 Jul 2018 23:55:31 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 16:55:31 -0700
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
Subject: [PATCH 3/3] mm: move mirrored memory specific code outside of memmap_init_zone
Date:   Tue, 24 Jul 2018 19:55:20 -0400
Message-Id: <20180724235520.10200-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724235520.10200-1-pasha.tatashin@oracle.com>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807240248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init_zone, is getting complex, because it is called from different
contexts: hotplug, and during boot, and also because it must handle some
architecture quirks. One of them is mirroed memory.

Move the code that decides whether to skip mirrored memory outside of
memmap_init_zone, into a separate function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 70 ++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 86c678cec6bd..d7dce4ccefd5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5454,6 +5454,29 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 #endif
 }
 
+/* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped init */
+static inline bool overlap_memmap_init(unsigned long zone, unsigned long *pfn)
+{
+#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
+	static struct memblock_region *r;
+
+	if (mirrored_kernelcore && zone == ZONE_MOVABLE) {
+		if (!r || *pfn >= memblock_region_memory_end_pfn(r)) {
+			for_each_memblock(memory, r) {
+				if (*pfn < memblock_region_memory_end_pfn(r))
+					break;
+			}
+		}
+		if (*pfn >= memblock_region_memory_base_pfn(r) &&
+		    memblock_is_mirror(r)) {
+			*pfn = memblock_region_memory_end_pfn(r);
+			return true;
+		}
+	}
+#endif
+	return false;
+}
+
 /*
  * Initially all pages are reserved - free ones are freed
  * up by free_all_bootmem() once the early boot process is
@@ -5463,12 +5486,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn, enum memmap_context context,
 		struct vmem_altmap *altmap)
 {
-	unsigned long end_pfn = start_pfn + size;
-	unsigned long pfn;
+	unsigned long pfn, end_pfn = start_pfn + size;
 	struct page *page;
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-	struct memblock_region *r = NULL, *tmp;
-#endif
 
 	if (highest_memmap_pfn < end_pfn - 1)
 		highest_memmap_pfn = end_pfn - 1;
@@ -5485,39 +5504,17 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * There can be holes in boot-time mem_map[]s handed to this
 		 * function.  They do not exist on hotplugged memory.
 		 */
-		if (context != MEMMAP_EARLY)
-			goto not_early;
-
-		if (!early_pfn_valid(pfn))
-			continue;
-		if (!early_pfn_in_nid(pfn, nid))
-			continue;
-
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-		/*
-		 * Check given memblock attribute by firmware which can affect
-		 * kernel memory layout.  If zone==ZONE_MOVABLE but memory is
-		 * mirrored, it's an overlapped memmap init. skip it.
-		 */
-		if (mirrored_kernelcore && zone == ZONE_MOVABLE) {
-			if (!r || pfn >= memblock_region_memory_end_pfn(r)) {
-				for_each_memblock(memory, tmp)
-					if (pfn < memblock_region_memory_end_pfn(tmp))
-						break;
-				r = tmp;
-			}
-			if (pfn >= memblock_region_memory_base_pfn(r) &&
-			    memblock_is_mirror(r)) {
-				/* already initialized as NORMAL */
-				pfn = memblock_region_memory_end_pfn(r);
+		if (context == MEMMAP_EARLY) {
+			if (!early_pfn_valid(pfn))
 				continue;
-			}
+			if (!early_pfn_in_nid(pfn, nid))
+				continue;
+			if (overlap_memmap_init(zone, &pfn))
+				continue;
+			if (defer_init(nid, pfn, end_pfn))
+				break;
 		}
-#endif
-		if (defer_init(nid, pfn, end_pfn))
-			break;
 
-not_early:
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMMAP_HOTPLUG)
@@ -5534,9 +5531,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * can be created for invalid pages (for alignment)
 		 * check here not to call set_pageblock_migratetype() against
 		 * pfn out of zone.
-		 *
-		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
-		 * because this is done early in sparse_add_one_section
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-- 
2.18.0


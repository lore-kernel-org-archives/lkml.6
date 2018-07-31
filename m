Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8F208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOZCncX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F8F208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGaQ0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:26:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57178 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbeGaQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:26:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VE92NC040893;
        Tue, 31 Jul 2018 14:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ilI93KBqqQ4Hq2i+/xbQFizG6+gWf+PyMpVJ7bUe/2A=;
 b=OOZCncX8Nu4FWRwODEm1AZwfKuDdODCdtYGqEYQSC8fmF3fMbhwdkRN/bHon5JhFyNV/
 vX9XszA99EEwbsNDUvNYXCdJTR+3mg25WQNX1ke1nMLM7FE8w4tEXVX+rxc1EIwSDkxf
 cBRbAOaB5gtNqz80MvbtCu8vLsGCFQCS4M4f4UP5oz83iftNoGvmIdOhMTnjOYCe5wIf
 PCnVhZVt3/OHrPr+NhNT6DDo+FeGpWsL3TzKPgM8RfhTbYGffPF0SOW7CL1IJCMsln8j
 BFSsuSczX0RPSo0Da8iS9N3cu/tNKZIsTeAvaUoGhCJv8XZhGGEA1X45AzksCQo8T4+B LA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kgh4q19p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 14:45:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEjmhS002332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 14:45:48 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6VEjlej015314;
        Tue, 31 Jul 2018 14:45:48 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 07:45:47 -0700
Date:   Tue, 31 Jul 2018 10:45:45 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
Message-ID: <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731144157.GA1499@techadventures.net>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-31 16:41:57, Oscar Salvador wrote:
> On Tue, Jul 31, 2018 at 08:49:11AM -0400, Pavel Tatashin wrote:
> > Hi Oscar,
> > 
> > Have you looked into replacing __paginginit via __meminit ? What is
> > the reason to keep both?
> Hi Pavel,
> 
> Actually, thinking a bit more about this, it might make sense to remove
> __paginginit altogether and keep only __meminit.
> Looking at the original commit, I think that it was put as a way to abstract it.
> 
> After the patchset [1] has been applied, only two functions marked as __paginginit
> remain, so it will be less hassle to replace that with __meminit.
> 
> I will send a v2 tomorrow to be applied on top of [1].
> 
> [1] https://patchwork.kernel.org/patch/10548861/
> 
> Thanks
> -- 
> Oscar Salvador
> SUSE L3
> 

Here the patch would look like this:

From e640b32dbd329bba5a785cc60050d5d7e1ca18ce Mon Sep 17 00:00:00 2001
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 31 Jul 2018 10:37:44 -0400
Subject: [PATCH] mm: remove __paginginit

__paginginit is the same thing as __meminit except for platforms without
sparsemem, there it is defined as __init.

Remove __paginginit and use __meminit. Use __ref in one single function
that merges __meminit and __init sections: setup_usemap().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/internal.h   | 12 ------------
 mm/page_alloc.c | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 33c22754d282..87256ae1bef8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -389,18 +389,6 @@ static inline struct page *mem_map_next(struct page *iter,
 	return iter + 1;
 }
 
-/*
- * FLATMEM and DISCONTIGMEM configurations use alloc_bootmem_node,
- * so all functions starting at paging_init should be marked __init
- * in those cases. SPARSEMEM, however, allows for memory hotplug,
- * and alloc_bootmem_node is not used.
- */
-#ifdef CONFIG_SPARSEMEM
-#define __paginginit __meminit
-#else
-#define __paginginit __init
-#endif
-
 /* Memory initialisation debug and verification */
 enum mminit_level {
 	MMINIT_WARNING,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 02e4b84038f8..92abe3eb151d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6122,7 +6122,7 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
 	return usemapsize / 8;
 }
 
-static void __init setup_usemap(struct pglist_data *pgdat,
+static void __ref setup_usemap(struct pglist_data *pgdat,
 				struct zone *zone,
 				unsigned long zone_start_pfn,
 				unsigned long zonesize)
@@ -6142,7 +6142,7 @@ static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __paginginit set_pageblock_order(void)
+void __meminit set_pageblock_order(void)
 {
 	unsigned int order;
 
@@ -6170,14 +6170,14 @@ void __paginginit set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __paginginit set_pageblock_order(void)
+void __meminit set_pageblock_order(void)
 {
 }
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
-						   unsigned long present_pages)
+static unsigned long __meminit calc_memmap_size(unsigned long spanned_pages,
+						unsigned long present_pages)
 {
 	unsigned long pages = spanned_pages;
 
@@ -6204,7 +6204,7 @@ static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
  *
  * NOTE: pgdat should get zeroed by caller.
  */
-static void __paginginit free_area_init_core(struct pglist_data *pgdat)
+static void __meminit free_area_init_core(struct pglist_data *pgdat)
 {
 	enum zone_type j;
 	int nid = pgdat->node_id;
@@ -6344,8 +6344,9 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
-void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
-		unsigned long node_start_pfn, unsigned long *zholes_size)
+void __meminit free_area_init_node(int nid, unsigned long *zones_size,
+				   unsigned long node_start_pfn,
+				   unsigned long *zholes_size)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long start_pfn = 0;
@@ -6390,7 +6391,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
  * may be accessed (for example page_to_pfn() on some configuration accesses
  * flags). We must explicitly zero those struct pages.
  */
-void __paginginit zero_resv_unavail(void)
+void __meminit zero_resv_unavail(void)
 {
 	phys_addr_t start, end;
 	unsigned long pfn;
-- 
2.18.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeA3J2T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:28:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbeA3J2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:28:17 -0500
Date: Tue, 30 Jan 2018 10:28:15 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pasha.tatashin@oracle.com
Subject: Re: Memory hotplug not increasing the total RAM
Message-ID: <20180130092815.GR21609@dhcp22.suse.cz>
References: <20180130083006.GB1245@in.ibm.com>
 <20180130091600.GA26445@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130091600.GA26445@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 10:16:00, Michal Hocko wrote:
> On Tue 30-01-18 14:00:06, Bharata B Rao wrote:
> > Hi,
> > 
> > With the latest upstream, I see that memory hotplug is not working
> > as expected. The hotplugged memory isn't seen to increase the total
> > RAM pages. This has been observed with both x86 and Power guests.
> > 
> > 1. Memory hotplug code intially marks pages as PageReserved via
> > __add_section().
> > 2. Later the struct page gets cleared in __init_single_page().
> > 3. Next online_pages_range() increments totalram_pages only when
> >    PageReserved is set.
> 
> You are right. I have completely forgot about this late struct page
> initialization during onlining. memory hotplug really doesn't want
> zeroying. Let me think about a fix.

Could you test with the following please? Not an act of beauty but
we are initializing memmap in sparse_add_one_section for memory
hotplug. I hate how this is different from the initialization case
but there is quite a long route to unify those two... So a quick
fix should be as follows.
---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6129f989223a..97a1d7e96110 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1178,9 +1178,10 @@ static void free_one_page(struct zone *zone,
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid)
+				unsigned long zone, int nid, bool zero)
 {
-	mm_zero_struct_page(page);
+	if (zero)
+		mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
@@ -1195,9 +1196,9 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 }
 
 static void __meminit __init_single_pfn(unsigned long pfn, unsigned long zone,
-					int nid)
+					int nid, bool zero)
 {
-	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid);
+	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid, zero);
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1218,7 +1219,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_pfn(pfn, zid, nid);
+	__init_single_pfn(pfn, zid, nid, true);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1535,7 +1536,7 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid);
+		__init_single_page(page, pfn, zid, nid, true);
 		nr_pages++;
 	}
 	return (nr_pages);
@@ -5404,11 +5405,13 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (!(pfn & (pageblock_nr_pages - 1))) {
 			struct page *page = pfn_to_page(pfn);
 
-			__init_single_page(page, pfn, zone, nid);
+			__init_single_page(page, pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		} else {
-			__init_single_pfn(pfn, zone, nid);
+			__init_single_pfn(pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 		}
 	}
 }
-- 
Michal Hocko
SUSE Labs

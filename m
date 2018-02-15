Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755603AbeBOUOL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:14:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165492AbeBOUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:14:10 -0500
Date: Thu, 15 Feb 2018 12:14:05 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
Message-ID: <20180215201405.GA22948@bombadil.infradead.org>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <20180214095911.GB28460@dhcp22.suse.cz>
 <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com>
 <20180215144525.GG7275@dhcp22.suse.cz>
 <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 09:49:00AM -0600, Christopher Lameter wrote:
> On Thu, 15 Feb 2018, Matthew Wilcox wrote:
> 
> > What if ... on startup, slab allocated a MAX_ORDER page for itself.
> > It would then satisfy its own page allocation requests from this giant
> > page.  If we start to run low on memory in the rest of the system, slab
> > can be induced to return some of it via its shrinker.  If slab runs low
> > on memory, it tries to allocate another MAX_ORDER page for itself.
> 
> The inducing of releasing memory back is not there but you can run SLUB
> with MAX_ORDER allocations by passing "slab_min_order=9" or so on bootup.

Maybe we should try this patch in order to automatically scale the slub
page size with the amount of memory in the machine?

diff --git a/mm/internal.h b/mm/internal.h
index e6bd35182dae..7059a8389194 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -167,6 +167,7 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
+extern unsigned long __meminitdata nr_kernel_pages;
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef9c259db041..3c51bb22403f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -264,7 +264,7 @@ int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 int watermark_scale_factor = 10;
 
-static unsigned long __meminitdata nr_kernel_pages;
+unsigned long __meminitdata nr_kernel_pages;
 static unsigned long __meminitdata nr_all_pages;
 static unsigned long __meminitdata dma_reserve;
 
diff --git a/mm/slub.c b/mm/slub.c
index e381728a3751..abca4a6e9b6c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4194,6 +4194,23 @@ void __init kmem_cache_init(void)
 
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
+	if (slub_min_order == 0) {
+		unsigned long numentries = nr_kernel_pages;
+
+		/*
+		 * Above 4GB, we start to care more about fragmenting large
+		 * pages than about using the minimum amount of memory.
+		 * Scale the slub page size at half the rate that we scale
+		 * the memory size; at 4GB we double the page size to 8k,
+		 * 16GB to 16k, 64GB to 32k, 256GB to 64k.
+		 */
+		while (numentries > (4UL << 30)) {
+			if (slub_min_order >= slub_max_order)
+				break;
+			slub_min_order++;
+			numentries /= 4;
+		}
+	}
 
 	kmem_cache_node = &boot_kmem_cache_node;
 	kmem_cache = &boot_kmem_cache;

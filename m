Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934907AbeBMJxl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:53:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934505AbeBMJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:53:37 -0500
Date: Tue, 13 Feb 2018 11:53:25 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 2/3] mm: add find_alloc_contig_pages() interface
References: <20180212222056.9735-1-mike.kravetz@oracle.com>
 <20180212222056.9735-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212222056.9735-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18021309-0040-0000-0000-0000040F306D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021309-0041-0000-0000-00002612F258
Message-Id: <20180213095325.GB2196@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130120
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:20:55PM -0800, Mike Kravetz wrote:
> find_alloc_contig_pages() is a new interface that attempts to locate
> and allocate a contiguous range of pages.  It is provided as a more
> convenient interface to the existing alloc_contig_range() interface
> which is used by CMA, memory hotplug and gigantic huge pages.
> 
> When attempting to allocate a range of pages, migration is employed
> if possible.  There is no guarantee that the routine will succeed.
> So, the user must be prepared for failure and have a fall back plan.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/gfp.h | 12 ++++++++
>  mm/page_alloc.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1a4582b44d32..456979022956 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -573,6 +573,18 @@ static inline bool pm_suspended_storage(void)
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
>  extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
> +extern struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +						int nid, nodemask_t *nodemask);
> +extern void free_contig_pages(struct page *page, unsigned nr_pages);
> +#else
> +static inline page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +						int nid, nodemask_t *nodemask)
> +{
> +	return NULL;
> +}
> +static void free_contig_pages(struct page *page, unsigned nr_pages)
> +{
> +}
>  #endif
> 
>  #ifdef CONFIG_CMA
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 064458f317bf..0a5a547acdbf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
> +#include <linux/mmzone.h>
> 
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -1873,9 +1874,13 @@ static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  {
>  	return __rmqueue_smallest(zone, order, MIGRATE_CMA);
>  }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_CMA || (migratetype) == MIGRATE_MOVABLE)
>  #else
>  static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  					unsigned int order) { return NULL; }
> +#define contig_alloc_migratetype_ok(migratetype) \
> +	((migratetype) == MIGRATE_MOVABLE)
>  #endif
> 
>  /*
> @@ -7633,6 +7638,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
> 
> +	if (!contig_alloc_migratetype_ok(migratetype))
> +		return -EINVAL;
> +
>  	/*
>  	 * What we do here is we mark all pageblocks in range as
>  	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> @@ -7723,8 +7731,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> 
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, false)) {
> -		pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> -			__func__, outer_start, end);
> +		if (!(migratetype == MIGRATE_MOVABLE)) /* only print for CMA */
> +			pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> +				__func__, outer_start, end);
>  		ret = -EBUSY;
>  		goto done;
>  	}
> @@ -7760,6 +7769,82 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
>  	}
>  	WARN(count != 0, "%d pages are still in use!\n", count);
>  }
> +
> +static bool contig_pfn_range_valid(struct zone *z, unsigned long start_pfn,
> +					unsigned long nr_pages)
> +{
> +	unsigned long i, end_pfn = start_pfn + nr_pages;
> +	struct page *page;
> +
> +	for (i = start_pfn; i < end_pfn; i++) {
> +		if (!pfn_valid(i))
> +			return false;
> +
> +		page = pfn_to_page(i);
> +
> +		if (page_zone(page) != z)
> +			return false;
> +
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * find_alloc_contig_pages() -- attempt to find and allocate a contiguous
> + *				range of pages
> + * @order:	number of pages
> + * @gfp:	gfp mask used to limit search as well as during compaction
> + * @nid:	target node
> + * @nodemask:	mask of other possible nodes
> + *
> + * Returns pointer to 'order' pages on success, or NULL if not successful.

Please s/Returns/Return:/ and move the return value description to the end
of the comment block.

> + *
> + * Pages can be freed with a call to free_contig_pages(), or by manually
> + * calling __free_page() for each page allocated.
> + */
> +struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp,
> +					int nid, nodemask_t *nodemask)
> +{
> +	unsigned long pfn, nr_pages, flags;
> +	struct page *ret_page = NULL;
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +	struct zone *zone;
> +	int rc;
> +
> +	nr_pages = 1 << order;
> +	zonelist = node_zonelist(nid, gfp);
> +	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp),
> +					nodemask) {
> +		spin_lock_irqsave(&zone->lock, flags);
> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> +		while (zone_spans_pfn(zone, pfn + nr_pages - 1)) {
> +			if (contig_pfn_range_valid(zone, pfn, nr_pages)) {
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +
> +				rc = alloc_contig_range(pfn, pfn + nr_pages,
> +							MIGRATE_MOVABLE, gfp);
> +				if (!rc) {
> +					ret_page = pfn_to_page(pfn);
> +					return ret_page;
> +				}
> +				spin_lock_irqsave(&zone->lock, flags);
> +			}
> +			pfn += nr_pages;
> +		}
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	}
> +
> +	return ret_page;
> +}
> +EXPORT_SYMBOL_GPL(find_alloc_contig_pages);
> +
> +void free_contig_pages(struct page *page, unsigned nr_pages)
> +{
> +	free_contig_range(page_to_pfn(page), nr_pages);
> +}
> +EXPORT_SYMBOL_GPL(free_contig_pages);
>  #endif
> 
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -- 
> 2.13.6
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 

-- 
Sincerely yours,
Mike.

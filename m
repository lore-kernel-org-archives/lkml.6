Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756780AbeBPAlB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:41:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeBPAk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:40:59 -0500
Subject: Re: [RFC PATCH 1/3] mm: make start_isolate_page_range() fail if
 already isolated
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>
References: <20180212222056.9735-1-mike.kravetz@oracle.com>
 <20180212222056.9735-2-mike.kravetz@oracle.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <eea67841-0656-6a60-af92-46a2e1a53350@oracle.com>
Date: Thu, 15 Feb 2018 16:40:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212222056.9735-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160007
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 02:20 PM, Mike Kravetz wrote:
> start_isolate_page_range() is used to set the migrate type of a
> page block to MIGRATE_ISOLATE while attempting to start a
> migration operation.  It is assumed that only one thread is
> attempting such an operation, and due to the limited number of
> callers this is generally the case.  However, there are no
> guarantees and it is 'possible' for two threads to operate on
> the same range.

I confirmed my suspicions that this is possible today.

As a test, I created a large CMA area at boot time.   I wrote some
code to exercise large allocations and frees via cma_alloc()/cma_release().
At the same time, I just allocated and freed'ed gigantic pages via the
sysfs interface.

After a little bit of running, 'free memory' on the system went to
zero.  After 'stopping' the tests, I observed that most zone normal
page blocks were marked as MIGRATE_ISOLATE.  Hence 'not available'.

As mentioned in the commit message, I doubt we will see this is
normal operations.  But, my testing confirms that it is possible.
Therefore, we should consider a patch like this or some other form
of mitigation even of we don't move forward with adding the new
interface.

-- 
Mike Kravetz

> 
> Since start_isolate_page_range() is called at the beginning of
> such operations, have it return -EBUSY if MIGRATE_ISOLATE is
> already set.
> 
> This will allow start_isolate_page_range to serve as a
> synchronization mechanism and will allow for more general use
> of callers making use of these interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/page_alloc.c     |  8 ++++----
>  mm/page_isolation.c | 10 +++++++++-
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 76c9688b6a0a..064458f317bf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7605,11 +7605,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   * @gfp_mask:	GFP mask to use during compaction
>   *
>   * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
> - * aligned, however it's the caller's responsibility to guarantee that
> - * we are the only thread that changes migrate type of pageblocks the
> - * pages fall in.
> + * aligned.  The PFN range must belong to a single zone.
>   *
> - * The PFN range must belong to a single zone.
> + * The first thing this routine does is attempt to MIGRATE_ISOLATE all
> + * pageblocks in the range.  Once isolated, the pageblocks should not
> + * be modified by others.
>   *
>   * Returns zero on success or negative error code.  On success all
>   * pages which PFN is in [start, end) are allocated for the caller and
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 165ed8117bd1..e815879d525f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -28,6 +28,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype,
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  
> +	/*
> +	 * We assume we are the only ones trying to isolate this block.
> +	 * If MIGRATE_ISOLATE already set, return -EBUSY
> +	 */
> +	if (is_migrate_isolate_page(page))
> +		goto out;
> +
>  	pfn = page_to_pfn(page);
>  	arg.start_pfn = pfn;
>  	arg.nr_pages = pageblock_nr_pages;
> @@ -166,7 +173,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * future will not be allocated again.
>   *
>   * start_pfn/end_pfn must be aligned to pageblock_order.
> - * Returns 0 on success and -EBUSY if any part of range cannot be isolated.
> + * Returns 0 on success and -EBUSY if any part of range cannot be isolated
> + * or any part of the range is already set to MIGRATE_ISOLATE.
>   */
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			     unsigned migratetype, bool skip_hwpoisoned_pages)
> 

Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94238C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589262083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589262083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeGZJ1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:27:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:55030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728816AbeGZJ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA557ACDB;
        Thu, 26 Jul 2018 08:12:01 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:12:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        pasha.tatashin@oracle.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 4/5] mm/page_alloc: Move initialization of node and
 zones to an own function
Message-ID: <20180726081200.GY28386@dhcp22.suse.cz>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-5-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725220144.11531-5-osalvador@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 00:01:43, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Currently, whenever a new node is created/re-used from the memhotplug path,
> we call free_area_init_node()->free_area_init_core().
> But there is some code that we do not really need to run when we are coming
> from such path.
> 
> free_area_init_core() performs the following actions:
> 
> 1) Initializes pgdat internals, such as spinlock, waitqueues and more.
> 2) Account # nr_all_pages and nr_kernel_pages. These values are used later on
>    when creating hash tables.
> 3) Account number of managed_pages per zone, substracting dma_reserved and memmap pages.
> 4) Initializes some fields of the zone structure data
> 5) Calls init_currently_empty_zone to initialize all the freelists
> 6) Calls memmap_init to initialize all pages belonging to certain zone
> 
> When called from memhotplug path, free_area_init_core() only performs actions #1 and #4.
> 
> Action #2 is pointless as the zones do not have any pages since either the node was freed,
> or we are re-using it, eitherway all zones belonging to this node should have 0 pages.
> For the same reason, action #3 results always in manages_pages being 0.
> 
> Action #5 and #6 are performed later on when onlining the pages:
>  online_pages()->move_pfn_range_to_zone()->init_currently_empty_zone()
>  online_pages()->move_pfn_range_to_zone()->memmap_init_zone()
> 
> This patch moves the node/zone initializtion to their own function, so it allows us
> to create a small version of free_area_init_core(next patch), where we only perform:
> 
> 1) Initialization of pgdat internals, such as spinlock, waitqueues and more
> 4) Initialization of some fields of the zone structure data
> 
> This patch only introduces these two functions.

OK, this looks definitely better. I will have to check that all the
required state is initialized properly. Considering the above
explanation I would simply fold the follow up patch into this one. It is
not so large it would get hard to review and you would make it clear why
the work is done.

> +/*
> + * Set up the zone data structures:
> + *   - mark all pages reserved
> + *   - mark all memory queues empty
> + *   - clear the memory bitmaps
> + *
> + * NOTE: pgdat should get zeroed by caller.
> + * NOTE: this function is only called during early init.
> + */
> +static void __paginginit free_area_init_core(struct pglist_data *pgdat)

now that this function is called only from the early init code we can
make it s@__paginginit@__init@ AFAICS.

> +{
> +	enum zone_type j;
> +	int nid = pgdat->node_id;
>  
> +	pgdat_init_internals(pgdat);
>  	pgdat->per_cpu_nodestats = &boot_nodestats;
>  
>  	for (j = 0; j < MAX_NR_ZONES; j++) {
> @@ -6310,13 +6326,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
>  		 * when the bootmem allocator frees pages into the buddy system.
>  		 * And all highmem pages will be managed by the buddy system.
>  		 */
> -		zone->managed_pages = freesize;
> -		zone_set_nid(zone, nid);
> -		zone->name = zone_names[j];
> -		zone->zone_pgdat = pgdat;
> -		spin_lock_init(&zone->lock);
> -		zone_seqlock_init(zone);
> -		zone_pcp_init(zone);
> +		zone_init_internals(zone, j, nid, freesize);
>  
>  		if (!size)
>  			continue;
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs

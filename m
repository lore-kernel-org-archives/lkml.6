Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeFDT2c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:28:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:28:31 -0400
Date: Mon, 4 Jun 2018 21:28:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/19] mm/migrate: Use xchg instead of spinlock
Message-ID: <20180604192821.GB12217@hirez.programming.kicks-ass.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:22PM +0530, Srikar Dronamraju wrote:
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8c0af0f..1c55956 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1874,11 +1874,9 @@ static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
>  	 * all the time is being spent migrating!
>  	 */
>  	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
> -		spin_lock(&pgdat->numabalancing_migrate_lock);
> -		pgdat->numabalancing_migrate_nr_pages = 0;
> -		pgdat->numabalancing_migrate_next_window = jiffies +
> -			msecs_to_jiffies(migrate_interval_millisecs);
> -		spin_unlock(&pgdat->numabalancing_migrate_lock);
> +		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
> +			pgdat->numabalancing_migrate_next_window = jiffies +
> +				msecs_to_jiffies(migrate_interval_millisecs);

Note that both are in fact wrong. That wants to be something like:

	pgdat->numabalancing_migrate_next_window += interval;

Otherwise you stretch every interval by 'jiffies - numabalancing_migrate_next_window'.

Also, that all wants READ_ONCE/WRITE_ONCE, irrespective of the
spinlock/xchg.

I suppose the problem here is that PPC has a very nasty test-and-set
spinlock with fwd progress issues while xchg maps to a fairly simple
ll/sc that (hopefully) has some hardware fairness.

And pgdata being a rather course data structure (per node?) there could
be a lot of CPUs stomping on this here thing.

So simpler not really, but better for PPC.

>  	}
>  	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
>  		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4526643..464a25c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6208,7 +6208,6 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
>  
>  	pgdat_resize_init(pgdat);
>  #ifdef CONFIG_NUMA_BALANCING
> -	spin_lock_init(&pgdat->numabalancing_migrate_lock);
>  	pgdat->numabalancing_migrate_nr_pages = 0;
>  	pgdat->active_node_migrate = 0;
>  	pgdat->numabalancing_migrate_next_window = jiffies;
> -- 
> 1.8.3.1
> 

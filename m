Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbeBOJS2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:18:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:34655 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755126AbeBOJSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:18:24 -0500
Date: Thu, 15 Feb 2018 10:18:19 +0100
From: Jan Kara <jack@suse.cz>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>, Jan Kara <jack@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: Fix races between address_space dereference and free
 in page_evicatable
Message-ID: <20180215091819.wnrbszbbbzrjlybc@quack2.suse.cz>
References: <20180212081227.1940-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212081227.1940-1-ying.huang@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-02-18 16:12:27, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> When page_mapping() is called and the mapping is dereferenced in
> page_evicatable() through shrink_active_list(), it is possible for the
> inode to be truncated and the embedded address space to be freed at
> the same time.  This may lead to the following race.
> 
> CPU1                                                CPU2
> 
> truncate(inode)                                     shrink_active_list()
>   ...                                                 page_evictable(page)
>   truncate_inode_page(mapping, page);
>     delete_from_page_cache(page)
>       spin_lock_irqsave(&mapping->tree_lock, flags);
>         __delete_from_page_cache(page, NULL)
>           page_cache_tree_delete(..)
>             ...                                         mapping = page_mapping(page);
>             page->mapping = NULL;
>             ...
>       spin_unlock_irqrestore(&mapping->tree_lock, flags);
>       page_cache_free_page(mapping, page)
>         put_page(page)
>           if (put_page_testzero(page)) -> false
> - inode now has no pages and can be freed including embedded address_space
> 
>                                                         mapping_unevictable(mapping)
> 							  test_bit(AS_UNEVICTABLE, &mapping->flags);
> - we've dereferenced mapping which is potentially already free.
> 
> Similar race exists between swap cache freeing and page_evicatable() too.
> 
> The address_space in inode and swap cache will be freed after a RCU
> grace period.  So the races are fixed via enclosing the page_mapping()
> and address_space usage in rcu_read_lock/unlock().  Some comments are
> added in code to make it clear what is protected by the RCU read lock.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>

The race looks real (although very unlikely) and the patch looks good to me.
You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/vmscan.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d1c1e00b08bb..10a0f32a3f90 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3886,7 +3886,13 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>   */
>  int page_evictable(struct page *page)
>  {
> -	return !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
> +	int ret;
> +
> +	/* Prevent address_space of inode and swap cache from being freed */
> +	rcu_read_lock();
> +	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  #ifdef CONFIG_SHMEM
> -- 
> 2.15.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

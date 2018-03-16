Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeCPMhl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:37:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeCPMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:37:40 -0400
Date: Fri, 16 Mar 2018 13:37:37 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -mm] mm: Fix race between swapoff and mincore
Message-ID: <20180316123737.GJ23100@dhcp22.suse.cz>
References: <20180313012036.1597-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313012036.1597-1-ying.huang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-03-18 09:20:36, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> >From commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB
> trunks") on, after swapoff, the address_space associated with the swap
> device will be freed.  So swap_address_space() users which touch the
> address_space need some kind of mechanism to prevent the address_space
> from being freed during accessing.
> 
> When mincore process unmapped range for swapped shmem pages, it
> doesn't hold the lock to prevent swap device from being swapoff.  So
> the following race is possible,
> 
> CPU1					CPU2
> do_mincore()				swapoff()
>   walk_page_range()
>     mincore_unmapped_range()
>       __mincore_unmapped_range
>         mincore_page
> 	  as = swap_address_space()
>           ...				  exit_swap_address_space()
>           ...				    kvfree(spaces)
> 	  find_get_page(as)
> 
> The address space may be accessed after being freed.
> 
> To fix the race, get_swap_device()/put_swap_device() is used to
> enclose find_get_page() to check whether the swap entry is valid and
> prevent the swap device from being swapoff during accessing.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Fixes: 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB  trunks")

> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mincore.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mincore.c b/mm/mincore.c
> index fc37afe226e6..a66f2052c7b1 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -68,8 +68,16 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t pgoff)
>  		 */
>  		if (radix_tree_exceptional_entry(page)) {
>  			swp_entry_t swp = radix_to_swp_entry(page);
> -			page = find_get_page(swap_address_space(swp),
> -					     swp_offset(swp));
> +			struct swap_info_struct *si;
> +
> +			/* Prevent swap device to being swapoff under us */
> +			si = get_swap_device(swp);
> +			if (si) {
> +				page = find_get_page(swap_address_space(swp),
> +						     swp_offset(swp));
> +				put_swap_device(si);
> +			} else
> +				page = NULL;
>  		}
>  	} else
>  		page = find_get_page(mapping, pgoff);
> -- 
> 2.15.1
> 

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbeCOSaf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:30:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41957 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751966AbeCOSae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:30:34 -0400
Date: Thu, 15 Mar 2018 19:30:31 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Wheeler <linux-mm@lists.ewheeler.net>
Subject: Re: [PATCH] mm/thp: Do not wait for lock_page() in
 deferred_split_scan()
Message-ID: <20180315183031.GS23100@dhcp22.suse.cz>
References: <20180315150747.31945-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315150747.31945-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-03-18 18:07:47, Kirill A. Shutemov wrote:
> deferred_split_scan() gets called from reclaim path. Waiting for page
> lock may lead to deadlock there.
> 
> Replace lock_page() with trylock_page() and skip the page if we failed
> to lock it. We will get to the page on the next scan.
> 

Fixes: 9a982250f773 ("thp: introduce deferred_split_huge_page()")
and maybe even Cc: stable as this can lead to deadlocks AFAICS.

Btw. other THP shrinker does suffer from the same problem and a deadlock
has been reported[1]. Thanks for Tetsuo to point that out [2].

[1] http://lkml.kernel.org/r/alpine.LRH.2.11.1801242349220.30642@mail.ewheeler.net
[2] http://lkml.kernel.org/r/04bbbd39-a1c0-b84b-28a2-0a3876be1054@i-love.sakura.ne.jp

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Anyway feel free to add 
Acked-by: Michal Hocko <mhocko@suse.com>
to this patch but a deeper audit is due I suspect

> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 87ab9b8f56b5..529cf36b7edb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2783,11 +2783,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  
>  	list_for_each_safe(pos, next, &list) {
>  		page = list_entry((void *)pos, struct page, mapping);
> -		lock_page(page);
> +		if (!trylock_page(page))
> +			goto next;
>  		/* split_huge_page() removes page from list on success */
>  		if (!split_huge_page(page))
>  			split++;
>  		unlock_page(page);
> +next:
>  		put_page(page);
>  	}
>  
> -- 
> 2.16.1

-- 
Michal Hocko
SUSE Labs

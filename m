Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeBZVsV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:48:21 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38010 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeBZVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:48:17 -0500
X-Google-Smtp-Source: AG47ELvOhW4VwzKMX0AebcJI8/2p+j3EZTMtsJpVCR/blLCxh2hPPmOJqmMQI7Fyn4b0Qkj0OOfBWw==
Date: Mon, 26 Feb 2018 13:48:14 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Aaron Lu <aaron.lu@intel.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/3] mm/free_pcppages_bulk: update pcp->count inside
In-Reply-To: <20180226135346.7208-2-aaron.lu@intel.com>
Message-ID: <alpine.DEB.2.20.1802261345550.135844@chino.kir.corp.google.com>
References: <20180226135346.7208-1-aaron.lu@intel.com> <20180226135346.7208-2-aaron.lu@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Aaron Lu wrote:

> Matthew Wilcox found that all callers of free_pcppages_bulk() currently
> update pcp->count immediately after so it's natural to do it inside
> free_pcppages_bulk().
> 
> No functionality or performance change is expected from this patch.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  mm/page_alloc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cb416723538f..3154859cccd6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1117,6 +1117,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int batch_free = 0;
>  	bool isolated_pageblocks;
>  
> +	pcp->count -= count;
>  	spin_lock(&zone->lock);
>  	isolated_pageblocks = has_isolate_pageblock(zone);
>  

Why modify pcp->count before the pages have actually been freed?

I doubt that it matters too much, but at least /proc/zoneinfo uses 
zone->lock.  I think it should be done after the lock is dropped.

Otherwise, looks good.

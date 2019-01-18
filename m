Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF632086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfARNvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:51:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:43102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727134AbfARNvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:51:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0816EAE26;
        Fri, 18 Jan 2019 13:51:01 +0000 (UTC)
Subject: Re: [PATCH 25/25] mm, compaction: Do not direct compact remote memory
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-26-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <84a7b23a-1cb7-b888-4245-6b1e829f472b@suse.cz>
Date:   Fri, 18 Jan 2019 14:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-26-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:50 PM, Mel Gorman wrote:
> Remote compaction is expensive and possibly counter-productive. Locality
> is expected to often have better performance characteristics than remote
> high-order pages. For small allocations, it's expected that locality is
> generally required or fallbacks are possible. For larger allocations such
> as THP, they are forbidden at the time of writing but if __GFP_THISNODE
> is ever removed, then it would still be preferable to fallback to small
> local base pages over remote THP in the general case. kcompactd is still
> woken via kswapd so compaction happens eventually.
> 
> While this patch potentially has both positive and negative effects,
> it is best to avoid the possibility of remote compaction given the cost
> relative to any potential benefit.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Generally agree with the intent, but what if there's e.g. high-order (but not
costly) kernel allocation on behalf of user process on cpu belonging to a
movable node, where the only non-movable node is node 0. It will have to keep
reclaiming until a large enough page is formed, or wait for kcompactd?
So maybe do this only for costly orders?

Also I think compaction_zonelist_suitable() should be also updated, or we might
be promising the reclaim-compact loop e.g. that we will compact after enough
reclaim, but then we won't.

> ---
>  mm/compaction.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ae70be023b21..cc17f0c01811 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2348,6 +2348,16 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
>  			continue;
>  		}
>  
> +		/*
> +		 * Do not compact remote memory. It's expensive and high-order
> +		 * small allocations are expected to prefer or require local
> +		 * memory. Similarly, larger requests such as THP can fallback
> +		 * to base pages in preference to remote huge pages if
> +		 * __GFP_THISNODE is not specified
> +		 */
> +		if (zone_to_nid(zone) != zone_to_nid(ac->preferred_zoneref->zone))
> +			continue;
> +
>  		status = compact_zone_order(zone, order, gfp_mask, prio,
>  				alloc_flags, ac_classzone_idx(ac), capture);
>  		rc = max(status, rc);
> 


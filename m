Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FFE20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfARMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:33:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfARMdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:33:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2F94AD2C;
        Fri, 18 Jan 2019 12:33:51 +0000 (UTC)
Subject: Re: [PATCH 22/25] mm, compaction: Sample pageblocks for free pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-23-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <4e4529b5-c723-45cd-bdc9-068121d59859@suse.cz>
Date:   Fri, 18 Jan 2019 11:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-23-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:50 PM, Mel Gorman wrote:
> Once fast searching finishes, there is a possibility that the linear
> scanner is scanning full blocks found by the fast scanner earlier. This
> patch uses an adaptive stride to sample pageblocks for free pages. The
> more consecutive full pageblocks encountered, the larger the stride until
> a pageblock with free pages is found. The scanners might meet slightly
> sooner but it is an acceptable risk given that the search of the free
> lists may still encounter the pages and adjust the cached PFN of the free
> scanner accordingly.
> 
> In terms of latency and success rates, the impact is not obvious but the
> free scan rate is reduced by 87% on a 1-socket machine and 92% on a
> 2-socket machine. It's also the first time in the series where the number
> of pages scanned by the migration scanner is greater than the free scanner
> due to the increased search efficiency.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

OK, I admit this is quite counterintuitive to me. I would have expected
this change to result in meeting scanners much more sooner, while
missing many free pages (especially when starting with stride 32 for
async compaction). I would have expected that pageblocks that we already
depleted are marked for skipping, while freeing pages by reclaim
scatters them randomly in the remaining ones, and this will then miss
many. But you have benchmarking data so I won't object :)

> ---
>  mm/compaction.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 652e249168b1..cc532e81a7b7 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -441,6 +441,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  				unsigned long *start_pfn,
>  				unsigned long end_pfn,
>  				struct list_head *freelist,
> +				unsigned int stride,
>  				bool strict)
>  {
>  	int nr_scanned = 0, total_isolated = 0;
> @@ -450,10 +451,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  	unsigned long blockpfn = *start_pfn;
>  	unsigned int order;
>  
> +	/* Strict mode is for isolation, speed is secondary */
> +	if (strict)
> +		stride = 1;

Why not just call this from strict context with stride 1, instead of
passing 0 and then changing it to 1.

> +
>  	cursor = pfn_to_page(blockpfn);
>  
>  	/* Isolate free pages. */
> -	for (; blockpfn < end_pfn; blockpfn++, cursor++) {
> +	for (; blockpfn < end_pfn; blockpfn += stride, cursor += stride) {
>  		int isolated;
>  		struct page *page = cursor;
>  
> @@ -624,7 +629,7 @@ isolate_freepages_range(struct compact_control *cc,
>  			break;
>  
>  		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
> -						block_end_pfn, &freelist, true);
> +					block_end_pfn, &freelist, 0, true);
>  
>  		/*
>  		 * In strict mode, isolate_freepages_block() returns 0 if
> @@ -1139,7 +1144,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
>  
>  	/* Scan before */
>  	if (start_pfn != pfn) {
> -		isolate_freepages_block(cc, &start_pfn, pfn, &cc->freepages, false);
> +		isolate_freepages_block(cc, &start_pfn, pfn, &cc->freepages, 1, false);
>  		if (cc->nr_freepages >= cc->nr_migratepages)
>  			return;
>  	}
> @@ -1147,7 +1152,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn, unsigned long
>  	/* Scan after */
>  	start_pfn = pfn + nr_isolated;
>  	if (start_pfn != end_pfn)
> -		isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, false);
> +		isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>  
>  	/* Skip this pageblock in the future as it's full or nearly full */
>  	if (cc->nr_freepages < cc->nr_migratepages)
> @@ -1333,7 +1338,9 @@ static void isolate_freepages(struct compact_control *cc)
>  	unsigned long isolate_start_pfn; /* exact pfn we start at */
>  	unsigned long block_end_pfn;	/* end of current pageblock */
>  	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
> +	unsigned long nr_isolated;
>  	struct list_head *freelist = &cc->freepages;
> +	unsigned int stride;
>  
>  	/* Try a small search of the free lists for a candidate */
>  	isolate_start_pfn = fast_isolate_freepages(cc);
> @@ -1356,6 +1363,7 @@ static void isolate_freepages(struct compact_control *cc)
>  	block_end_pfn = min(block_start_pfn + pageblock_nr_pages,
>  						zone_end_pfn(zone));
>  	low_pfn = pageblock_end_pfn(cc->migrate_pfn);
> +	stride = cc->mode == MIGRATE_ASYNC ? COMPACT_CLUSTER_MAX : 1;
>  
>  	/*
>  	 * Isolate free pages until enough are available to migrate the
> @@ -1387,8 +1395,8 @@ static void isolate_freepages(struct compact_control *cc)
>  			continue;
>  
>  		/* Found a block suitable for isolating free pages from. */
> -		isolate_freepages_block(cc, &isolate_start_pfn, block_end_pfn,
> -					freelist, false);
> +		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
> +					block_end_pfn, freelist, stride, false);
>  
>  		/* Update the skip hint if the full pageblock was scanned */
>  		if (isolate_start_pfn == block_end_pfn)
> @@ -1412,6 +1420,13 @@ static void isolate_freepages(struct compact_control *cc)
>  			 */
>  			break;
>  		}
> +
> +		/* Adjust stride depending on isolation */
> +		if (nr_isolated) {
> +			stride = 1;
> +			continue;
> +		}

If we hit a free page with a large stride, wouldn't it make sense to
reset it to 1 immediately in the same pageblock, and possibly also start
over from its beginning, if the assumption is that free pages appear
close together?

> +		stride = min_t(unsigned int, COMPACT_CLUSTER_MAX, stride << 1);
>  	}
>  
>  	/*
> 


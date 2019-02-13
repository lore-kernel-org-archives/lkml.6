Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B32BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62F222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfBMNmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:42:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731945AbfBMNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:42:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F33BAAEBC;
        Wed, 13 Feb 2019 13:42:36 +0000 (UTC)
Subject: Re: [PATCH] mm, page_alloc: Fix a division by zero error when
 boosting watermarks
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
References: <20190213131923.GQ9565@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <295be99c-d09a-5572-fa49-2673a62c295b@suse.cz>
Date:   Wed, 13 Feb 2019 14:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213131923.GQ9565@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 2:19 PM, Mel Gorman wrote:
> Yury Norov reported that an arm64 KVM instance could not boot since after
> v5.0-rc1 and could addressed by reverting the patches
> 
> 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> 
> The problem is that a division by zero error is possible if boosting occurs
> either very early in boot or if the high watermark is very small. This
> patch checks for the conditions and avoids boosting in those cases.

Hmm is it really a division by zero? The following line sets max_boost to
pageblock_nr_pages if it's zero. And where would the division happen anyway?

So I wonder what's going on, your patch should AFAICS only take effect when
zone->_watermark[WMARK_HIGH] is 0 or 1 to begin with, otherwise max_boost is at
least 2?

Also upon closer look, I think that (prior to the patch), boost_watermark()
could be reduced (thanks to the max+min capping) to

zone->watermark_boost = pageblock_nr_pages

?

> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Reported-and-tested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..ae7e4ba5b9f5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2170,6 +2170,11 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> +
> +	/* high watermark be be uninitialised or very small */
> +	if (!max_boost)
> +		return;
> +
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
>  	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> 


Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfAONSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:18:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729046AbfAONSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:18:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9CBDAD90;
        Tue, 15 Jan 2019 13:18:03 +0000 (UTC)
Subject: Re: [PATCH 10/25] mm, compaction: Ignore the fragmentation avoidance
 boost for isolation and compaction
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-11-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <99d75a89-ef07-683a-761d-f800c53cc910@suse.cz>
Date:   Tue, 15 Jan 2019 14:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-11-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:49 PM, Mel Gorman wrote:
> When pageblocks get fragmented, watermarks are artifically boosted to
> reclaim pages to avoid further fragmentation events. However, compaction
> is often either fragmentation-neutral or moving movable pages away from
> unmovable/reclaimable pages. As the true watermarks are preserved, allow
> compaction to ignore the boost factor.
> 
> The expected impact is very slight as the main benefit is that compaction
> is slightly more likely to succeed when the system has been fragmented
> very recently. On both 1-socket and 2-socket machines for THP-intensive
> allocation during fragmentation the success rate was increased by less
> than 1% which is marginal. However, detailed tracing indicated that
> failure of migration due to a premature ENOMEM triggered by watermark
> checks were eliminated.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 57ba9d1da519..05c9a81d54ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2958,7 +2958,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
>  		 * watermark, because we already know our high-order page
>  		 * exists.
>  		 */
> -		watermark = min_wmark_pages(zone) + (1UL << order);
> +		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
>  		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
>  			return 0;
>  
> 


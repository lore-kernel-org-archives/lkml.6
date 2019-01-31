Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF8F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfAaQLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:11:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:55710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbfAaQLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:11:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D640B01C;
        Thu, 31 Jan 2019 16:11:04 +0000 (UTC)
Subject: Re: [PATCH 22/22] mm, compaction: Capture a page under direct
 compaction
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-23-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <2124d934-0678-6a4b-9991-7450b1e4e39a@suse.cz>
Date:   Thu, 31 Jan 2019 17:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-23-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
> Compaction is inherently race-prone as a suitable page freed during
> compaction can be allocated by any parallel task. This patch uses a
> capture_control structure to isolate a page immediately when it is freed
> by a direct compactor in the slow path of the page allocator. The intent
> is to avoid redundant scanning.
> 
>                                      5.0.0-rc1              5.0.0-rc1
>                                selective-v3r17          capture-v3r19
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2582.11 (   0.00%)     2563.68 (   0.71%)
> Amean     fault-both-5      4500.26 (   0.00%)     4233.52 (   5.93%)
> Amean     fault-both-7      5819.53 (   0.00%)     6333.65 (  -8.83%)
> Amean     fault-both-12     9321.18 (   0.00%)     9759.38 (  -4.70%)
> Amean     fault-both-18     9782.76 (   0.00%)    10338.76 (  -5.68%)
> Amean     fault-both-24    15272.81 (   0.00%)    13379.55 *  12.40%*
> Amean     fault-both-30    15121.34 (   0.00%)    16158.25 (  -6.86%)
> Amean     fault-both-32    18466.67 (   0.00%)    18971.21 (  -2.73%)
> 
> Latency is only moderately affected but the devil is in the details.
> A closer examination indicates that base page fault latency is reduced
> but latency of huge pages is increased as it takes creater care to
> succeed. Part of the "problem" is that allocation success rates are close
> to 100% even when under pressure and compaction gets harder
> 
>                                 5.0.0-rc1              5.0.0-rc1
>                           selective-v3r17          capture-v3r19
> Percentage huge-3        96.70 (   0.00%)       98.23 (   1.58%)
> Percentage huge-5        96.99 (   0.00%)       95.30 (  -1.75%)
> Percentage huge-7        94.19 (   0.00%)       97.24 (   3.24%)
> Percentage huge-12       94.95 (   0.00%)       97.35 (   2.53%)
> Percentage huge-18       96.74 (   0.00%)       97.30 (   0.58%)
> Percentage huge-24       97.07 (   0.00%)       97.55 (   0.50%)
> Percentage huge-30       95.69 (   0.00%)       98.50 (   2.95%)
> Percentage huge-32       96.70 (   0.00%)       99.27 (   2.65%)
> 
> And scan rates are reduced as expected by 6% for the migration scanner
> and 29% for the free scanner indicating that there is less redundant work.
> 
> Compaction migrate scanned    20815362    19573286
> Compaction free scanned       16352612    11510663
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

...

> @@ -819,6 +870,7 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long uninitialized_var(buddy_pfn);
>  	struct page *buddy;
>  	unsigned int max_order;
> +	struct capture_control *capc = task_capc(zone);
>  
>  	max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
>  
> @@ -834,6 +886,12 @@ static inline void __free_one_page(struct page *page,
>  
>  continue_merging:
>  	while (order < max_order - 1) {
> +		if (compaction_capture(capc, page, order, migratetype)) {
> +			if (likely(!is_migrate_isolate(migratetype)))

compaction_capture() won't act on isolated migratetype, so this check is
unnecessary?

> +				__mod_zone_freepage_state(zone, -(1 << order),
> +								migratetype);
> +			return;
> +		}
>  		buddy_pfn = __find_buddy_pfn(pfn, order);
>  		buddy = page + (buddy_pfn - pfn);
>  

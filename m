Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B775C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168562086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168562086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeK0UUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:20:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbeK0UUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:20:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1227AF8D;
        Tue, 27 Nov 2018 09:23:21 +0000 (UTC)
Subject: Re: [PATCH 4/5] mm: Reclaim small amounts of memory when an external
 fragmentation event occurs
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20181123114528.28802-1-mgorman@techsingularity.net>
 <20181123114528.28802-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <0e042569-eb95-623f-242c-9cf9c87c5223@suse.cz>
Date:   Tue, 27 Nov 2018 10:23:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123114528.28802-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 12:45 PM, Mel Gorman wrote:
> An external fragmentation event was previously described as
> 
>     When the page allocator fragments memory, it records the event using
>     the mm_page_alloc_extfrag event. If the fallback_order is smaller
>     than a pageblock order (order-9 on 64-bit x86) then it's considered
>     an event that will cause external fragmentation issues in the future.
> 
> The kernel reduces the probability of such events by increasing the
> watermark sizes by calling set_recommended_min_free_kbytes early in the
> lifetime of the system. This works reasonably well in general but if there
> are enough sparsely populated pageblocks then the problem can still occur
> as enough memory is free overall and kswapd stays asleep.
> 
> This patch introduces a watermark_boost_factor sysctl that allows a zone
> watermark to be temporarily boosted when an external fragmentation causing
> events occurs. The boosting will stall allocations that would decrease
> free memory below the boosted low watermark and kswapd is woken if the
> calling context allows to reclaim an amount of memory relative to the
> size of the high watermark and the watermark_boost_factor until the boost
> is cleared. When kswapd finishes, it wakes kcompactd at the pageblock
> order to clean some of the pageblocks that may have been affected by
> the fragmentation event. kswapd avoids any writeback, slab shrinkage and
> swap from reclaim context during this operation to avoid excessive system
> disruption in the name of fragmentation avoidance. Care is taken so that
> kswapd will do normal reclaim work if the system is really low on memory.
> 
> This was evaluated using the same workloads as "mm, page_alloc: Spread
> allocations across zones before introducing fragmentation".
> 
> 1-socket Skylake machine
> config-global-dhp__workload_thpfioscale XFS (no special madvise)
> 4 fio threads, 1 THP allocating thread
> --------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:   804694
> 4.20-rc3+patch:                      408912 (49% reduction)
> 4.20-rc3+patch1-4:                    18421 (98% reduction)
> 
>                                    4.20.0-rc3             4.20.0-rc3
>                                  lowzone-v5r8             boost-v5r8
> Amean     fault-base-1      653.58 (   0.00%)      652.71 (   0.13%)
> Amean     fault-huge-1        0.00 (   0.00%)      178.93 * -99.00%*
> 
>                               4.20.0-rc3             4.20.0-rc3
>                             lowzone-v5r8             boost-v5r8
> Percentage huge-1        0.00 (   0.00%)        5.12 ( 100.00%)
> 
> Note that external fragmentation causing events are massively reduced
> by this path whether in comparison to the previous kernel or the vanilla
> kernel. The fault latency for huge pages appears to be increased but that
> is only because THP allocations were successful with the patch applied.
> 
> 1-socket Skylake machine
> global-dhp__workload_thpfioscale-madvhugepage-xfs (MADV_HUGEPAGE)
> -----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:  291392
> 4.20-rc3+patch:                     191187 (34% reduction)
> 4.20-rc3+patch1-4:                   13464 (95% reduction)
> 
> thpfioscale Fault Latencies
>                                    4.20.0-rc3             4.20.0-rc3
>                                  lowzone-v5r8             boost-v5r8
> Min       fault-base-1      912.00 (   0.00%)      905.00 (   0.77%)
> Min       fault-huge-1      127.00 (   0.00%)      135.00 (  -6.30%)
> Amean     fault-base-1     1467.55 (   0.00%)     1481.67 (  -0.96%)
> Amean     fault-huge-1     1127.11 (   0.00%)     1063.88 *   5.61%*
> 
>                               4.20.0-rc3             4.20.0-rc3
>                             lowzone-v5r8             boost-v5r8
> Percentage huge-1       77.64 (   0.00%)       83.46 (   7.49%)
> 
> As before, massive reduction in external fragmentation events, some jitter
> on latencies and an increase in THP allocation success rates.
> 
> 2-socket Haswell machine
> config-global-dhp__workload_thpfioscale XFS (no special madvise)
> 4 fio threads, 5 THP allocating threads
> ----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:  215698
> 4.20-rc3+patch:                     200210 (7% reduction)
> 4.20-rc3+patch1-4:                   14263 (93% reduction)
> 
>                                    4.20.0-rc3             4.20.0-rc3
>                                  lowzone-v5r8             boost-v5r8
> Amean     fault-base-5     1346.45 (   0.00%)     1306.87 (   2.94%)
> Amean     fault-huge-5     3418.60 (   0.00%)     1348.94 (  60.54%)
> 
>                               4.20.0-rc3             4.20.0-rc3
>                             lowzone-v5r8             boost-v5r8
> Percentage huge-5        0.78 (   0.00%)        7.91 ( 910.64%)
> 
> There is a 93% reduction in fragmentation causing events, there
> is a big reduction in the huge page fault latency and allocation
> success rate is higher.
> 
> 2-socket Haswell machine
> global-dhp__workload_thpfioscale-madvhugepage-xfs (MADV_HUGEPAGE)
> -----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9: 166352
> 4.20-rc3+patch:                    147463 (11% reduction)
> 4.20-rc3+patch1-4:                  11095 (93% reduction)
> 
> thpfioscale Fault Latencies
>                                    4.20.0-rc3             4.20.0-rc3
>                                  lowzone-v5r8             boost-v5r8
> Amean     fault-base-5     6217.43 (   0.00%)     7419.67 * -19.34%*
> Amean     fault-huge-5     3163.33 (   0.00%)     3263.80 (  -3.18%)
> 
>                               4.20.0-rc3             4.20.0-rc3
>                             lowzone-v5r8             boost-v5r8
> Percentage huge-5       95.14 (   0.00%)       87.98 (  -7.53%)
> 
> There is a large reduction in fragmentation events with some jitter around
> the latencies and success rates. As before, the high THP allocation
> success rate does mean the system is under a lot of pressure. However,
> as the fragmentation events are reduced, it would be expected that the
> long-term allocation success rate would be higher.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

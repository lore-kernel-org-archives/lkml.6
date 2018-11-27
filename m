Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC60C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D220989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK1AS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:18:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbeK1AS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:18:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9F9AAF60;
        Tue, 27 Nov 2018 13:20:30 +0000 (UTC)
Subject: Re: [PATCH 5/5] mm: Stall movable allocations until kswapd progresses
 during serious external fragmentation event
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20181123114528.28802-1-mgorman@techsingularity.net>
 <20181123114528.28802-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <e0867205-e5f1-b007-5dc7-bb4655f6e5c1@suse.cz>
Date:   Tue, 27 Nov 2018 14:20:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123114528.28802-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 12:45 PM, Mel Gorman wrote:
> An event that potentially causes external fragmentation problems has
> already been described but there are degrees of severity.  A "serious"
> event is defined as one that steals a contiguous range of pages of an order
> lower than fragment_stall_order (PAGE_ALLOC_COSTLY_ORDER by default). If a
> movable allocation request that is allowed to sleep needs to steal a small
> block then it schedules until kswapd makes progress or a timeout passes.
> The watermarks are also boosted slightly faster so that kswapd makes
> greater effort to reclaim enough pages to avoid the fragmentation event.
> 
> This stall is not guaranteed to avoid serious fragmentation events.
> If memory pressure is high enough, the pages freed by kswapd may be
> reallocated or the free pages may not be in pageblocks that contain
> only movable pages. Furthermore an allocation request that cannot stall
> (e.g. atomic allocations) or unmovable/reclaimable allocations will still
> proceed without stalling. The reason is that movable allocations can be
> migrated and stalling for kswapd to make progress means that compaction
> has targets. Unmovable/reclaimable allocations on the other hand do not
> benefit from stalling as their pages cannot move.
> 
> The worst-case scenario for stalling is a combination of both high memory
> pressure where kswapd is having trouble keeping free pages over the
> pfmemalloc_reserve and movable allocations are fragmenting memory. In this
> case, an allocation request may sleep for longer. There are both vmstats
> to identify stalls are happening and a tracepoint to quantify what the
> stall durations are. Note that the granularity of the stall detection is
> a jiffy so the delay accounting is not precise.
> 
> 1-socket Skylake machine
> config-global-dhp__workload_thpfioscale XFS (no special madvise)
> 4 fio threads, 1 THP allocating thread
> --------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:   804694
> 4.20-rc3+patch:                      408912 (49% reduction)
> 4.20-rc3+patch1-4:                    18421 (98% reduction)
> 4.20-rc3+patch1-5:                    16788 (98% reduction)
> 
>                                    4.20.0-rc3             4.20.0-rc3
>                                    boost-v5r8             stall-v5r8
> Amean     fault-base-1      652.71 (   0.00%)      651.40 (   0.20%)
> Amean     fault-huge-1      178.93 (   0.00%)      174.49 *   2.48%*
> 
> thpfioscale Percentage Faults Huge
>                               4.20.0-rc3             4.20.0-rc3
>                               boost-v5r8             stall-v5r8
> Percentage huge-1        5.12 (   0.00%)        5.56 (   8.77%)
> 
> Fragmentation events are further reduced. Note that in previous versions,
> it was reduced to negligible levels but the logic has been corrected
> to avoid exceessive reclaim and slab shrinkage in the meantime to avoid
> IO regressions that may not be tolerable.
> 
> The latencies and allocation success rates are roughly similar.  Over the
> course of 16 minutes, there were 2 stalls due to fragmentation avoidance
> for 8 microseconds.
> 
> 1-socket Skylake machine
> global-dhp__workload_thpfioscale-madvhugepage-xfs (MADV_HUGEPAGE)
> -----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:  291392
> 4.20-rc3+patch:                     191187 (34% reduction)
> 4.20-rc3+patch1-4:                   13464 (95% reduction)
> 4.20-rc3+patch1-5:                   15089 (99.7% reduction)
> 
>                                    4.20.0-rc3             4.20.0-rc3
>                                    boost-v5r8             stall-v5r8
> Amean     fault-base-1     1481.67 (   0.00%)        0.00 * 100.00%*
> Amean     fault-huge-1     1063.88 (   0.00%)      540.81 *  49.17%*
> 
>                               4.20.0-rc3             4.20.0-rc3
>                               boost-v5r8             stall-v5r8
> Percentage huge-1       83.46 (   0.00%)      100.00 (  19.82%)
> 
> The fragmentation events were increased which is bad, but this is offset
> by the fact that THP allocation rates had a lower latency and a perfect
> allocation success rate. There were 102 stalls over the course of 16
> minutes for a total stall time of roughly 0.4 seconds.
> 
> 2-socket Haswell machine
> config-global-dhp__workload_thpfioscale XFS (no special madvise)
> 4 fio threads, 5 THP allocating threads
> ----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9:  215698
> 4.20-rc3+patch:                     200210 (7% reduction)
> 4.20-rc3+patch1-4:                   14263 (93% reduction)
> 4.20-rc3+patch1-5:                   11702 (95% reduction)
> 
>                                    4.20.0-rc3             4.20.0-rc3
>                                    boost-v5r8             stall-v5r8
> Amean     fault-base-5     1306.87 (   0.00%)     1340.96 (  -2.61%)
> Amean     fault-huge-5     1348.94 (   0.00%)     2089.44 ( -54.89%)
> 
>                               4.20.0-rc3             4.20.0-rc3
>                               boost-v5r8             stall-v5r8
> Percentage huge-5        7.91 (   0.00%)        2.43 ( -69.26%)
> 
> There is a slight reduction in fragmentation events but it's slight
> enough that it may be due to luck. Unfortunately, both the latencies
> and success rates were lower. However, this is highly likely to be due
> to luck given that there were just 12 stalls for 76 microseconds. Direct
> reclaim was also eliminated but that is likely a co-incidence.
> 
> 2-socket Haswell machine
> global-dhp__workload_thpfioscale-madvhugepage-xfs (MADV_HUGEPAGE)
> -----------------------------------------------------------------
> 
> 4.20-rc3 extfrag events < order 9: 166352
> 4.20-rc3+patch:                    147463 (11% reduction)
> 4.20-rc3+patch1-4:                  11095 (93% reduction)
> 4.20-rc3+patch1-5:                  10677 (94% reduction)
> 
> thpfioscale Fault Latencies
>                                    4.20.0-rc3             4.20.0-rc3
>                                    boost-v5r8             stall-v5r8
> Amean     fault-base-5     7419.67 (   0.00%)     6853.97 (   7.62%)
> Amean     fault-huge-5     3263.80 (   0.00%)     1799.26 *  44.87%*
> 
>                               4.20.0-rc3             4.20.0-rc3
>                               boost-v5r8             stall-v5r8
> Percentage huge-5       87.98 (   0.00%)       98.97 (  12.49%)
> 
> The fragmentation events are slightly reduced with the latencies and
> allocation success rates much improved.  There were 462 stalls over the
> course of 68 minutes with a total stall time of roughly 1.9 seconds.
> 
> This patch has a marginal rate on fragmentation rates as it's rare for
> the stall logic to actually trigger but the small stalls can be enough for
> kswapd to catch up. How much that helps is variable but probably worthwhile
> for long-term allocation success rates. It is possible to eliminate
> fragmentation events entirely with tuning due to this patch although that
> would require careful evaluation to determine if it's worthwhile.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

The gains here are relatively smaller and noisier than for the previous
patches. Also I'm afraid that once antifrag loses against the ultimate
adversary workload (see the "Caching/buffers become useless after some
time" thread), then this might result in adding stalls to a workload
that has no other options but to allocate movable pages from partially
filled unmovable blocks, because that's simply the majority of
pageblocks in the system, and the stalls can't help the situation. If
that proves to be true, we could revert, but then there's the new
user-visible tunable... and that all makes it harder for me to decide
about this patch :) If only we could find out early while this is in
linux-mm/linux-next...


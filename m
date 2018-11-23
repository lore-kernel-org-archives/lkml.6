Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBC4C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E048A20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E048A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503879AbeKWW33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:29:29 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:42828 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388614AbeKWW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:29:27 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 34C42B88A0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:45:29 +0000 (GMT)
Received: (qmail 12233 invoked from network); 23 Nov 2018 11:45:29 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPA; 23 Nov 2018 11:45:29 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/5] Fragmentation avoidance improvements v5
Date:   Fri, 23 Nov 2018 11:45:23 +0000
Message-Id: <20181123114528.28802-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some big changes due to both Vlastimil's review feedback on v4 and
some oddities spotted while answering his review.  In some respects, the
series is slightly less effective but the approach is more consistent and
logical overall. The overhead is also lower from the first patch and stalls
are less harmful in the last patch so overall I think it has much improved.

Changelog since v4
o Clarified changelogs in response to review
o Add a compile-time check on where Normal and DMA32 is		(vbabka)
o Restart zone iteration properly in get_page_from_freelist	(vbabka)
o Reduce overhead in the page allocation fast path		(mel)
o Do not over-boost due to a fragmentation event		(vbabka)
o Correct documentation of sysctl				(mel)
o Really do not wake kswapd if the calling context forbids it	(vbabka,mel)
o Do not shrink slab if boosting watermarks as premature
  reclaim of slab can lead to regressions in IO benchmarks	(mel)
o Take zone lock when boosting watermarks if necessary		(vbabka)

Changelog since v3
o Rebase to 4.20-rc3
o Remove a stupid warning from the last patch

Changelog since v2
o Drop patch 5 as it was borderline
o Decrease timeout when stalling on fragmentation events

Changelog since v1
o Rebase to v4.20-rc1 for the THP __GFP_THISNODE patch in particular
o Add tracepoint to record fragmentation stall durations
o Add vmstat event to record that a fragmentation stall occurred
o Stalls now alter watermark boosting
o Stalls occur only when the allocation is about to fail

It has been noted before that fragmentation avoidance (aka
anti-fragmentation) is not perfect. Given sufficient time or an adverse
workload, memory gets fragmented and the long-term success of high-order
allocations degrades. This series defines an adverse workload, a definition
of external fragmentation events (including serious) ones and a series
that reduces the level of those fragmentation events.

The details of the workload and the consequences are described in more
detail in the changelogs. However, from patch 1, this is a high-level
summary of the adverse workload. The exact details are found in the
mmtests implementation.

The broad details of the workload are as follows;

1. Create an XFS filesystem (not specified in the configuration but done
   as part of the testing for this patch)
2. Start 4 fio threads that write a number of 64K files inefficiently.
   Inefficiently means that files are created on first access and not
   created in advance (fio parameterr create_on_open=1) and fallocate
   is not used (fallocate=none). With multiple IO issuers this creates
   a mix of slab and page cache allocations over time. The total size
   of the files is 150% physical memory so that the slabs and page cache
   pages get mixed
3. Warm up a number of fio read-only threads accessing the same files
   created in step 2. This part runs for the same length of time it
   took to create the files. It'll fault back in old data and further
   interleave slab and page cache allocations. As it's now low on
   memory due to step 2, fragmentation occurs as pageblocks get
   stolen.
4. While step 3 is still running, start a process that tries to allocate
   75% of memory as huge pages with a number of threads. The number of
   threads is based on a (NR_CPUS_SOCKET - NR_FIO_THREADS)/4 to avoid THP
   threads contending with fio, any other threads or forcing cross-NUMA
   scheduling. Note that the test has not been used on a machine with less
   than 8 cores. The benchmark records whether huge pages were allocated
   and what the fault latency was in microseconds
5. Measure the number of events potentially causing external fragmentation,
   the fault latency and the huge page allocation success rate.
6. Cleanup

Overall the series reduces external fragmentation causing events by over 94%
on 1 and 2 socket machines, which in turn impacts high-order allocation
success rates over the long term. There are differences in latencies and
high-order allocation success rates. Latencies are a mixed bag as they
are vulnerable to exact system state and whether allocations succeeded
so they are treated as a secondary metric.

Patch 1 uses lower zones if they are populated and have free memory
	instead of fragmenting a higher zone. It's special cased to
	handle a Normal->DMA32 fallback with the reasons explained
	in the changelog.

Patch 2-4 boosts watermarks temporarily when an external fragmentation
	event occurs. kswapd wakes to reclaim a small amount of old memory
	and then wakes kcompactd on completion to recover the system
	slightly. This introduces some overhead in the slowpath. The level
	of boosting can be tuned or disabled depending on the tolerance
	for fragmentation vs allocation latency.

Patch 5 stalls some movable allocation requests to let kswapd from patch 4
	make some progress. The duration of the stalls is very low but it
	is possible to tune the system to avoid fragmentation events if
	larger stalls can be tolerated.

The bulk of the improvement in fragmentation avoidance is from patches
1-4 but patch 5 can deal with a rare corner case and provides the option
of tuning a system for THP allocation success rates in exchange for
some stalls to control fragmentation.

 Documentation/sysctl/vm.txt   |  44 +++++++
 include/linux/mm.h            |   2 +
 include/linux/mmzone.h        |  14 ++-
 include/linux/vm_event_item.h |   1 +
 include/trace/events/kmem.h   |  21 ++++
 kernel/sysctl.c               |  18 +++
 mm/compaction.c               |   2 +-
 mm/internal.h                 |  15 ++-
 mm/page_alloc.c               | 263 ++++++++++++++++++++++++++++++++++++++----
 mm/vmscan.c                   | 136 ++++++++++++++++++++--
 mm/vmstat.c                   |   1 +
 11 files changed, 473 insertions(+), 44 deletions(-)

-- 
2.16.4


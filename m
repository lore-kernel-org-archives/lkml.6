Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC712C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69279208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeLNXDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:03:39 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:49513 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728620AbeLNXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:03:14 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id D9A031C1E4D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:03:10 +0000 (GMT)
Received: (qmail 31145 invoked from network); 14 Dec 2018 23:03:10 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPA; 14 Dec 2018 23:03:10 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 00/14] Increase success rates and reduce latency of compaction v1
Date:   Fri, 14 Dec 2018 23:02:56 +0000
Message-Id: <20181214230310.572-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very preliminary RFC. I'm posting this early as the
__GFP_THISNODE discussion continues and has started looking at the
compaction implementation and it'd be worth looking at this series
fdirst. The cc list is based on that dicussion just to make them aware
it exists. A v2 will have a significantly trimmed cc.

This series reduces scan rates and success rates of compaction, primarily
by using the free lists to shorten scans and better controlling of skip
information and whether multiple scanners can target the same block. There
still is much room for improvement but we probably should get these out
of the way first as they are pre-requisites for anything smarter.

Test data is still incomplete but I'm not expecting major differences on
2-socket vs 1-socket given the type of series. That might be wrong.

Primarily I'm using thpscale to measure the impact of the series. The
benchmark creates a large file, maps it, faults it, punches holes in the
mapping so that the virtual address space is fragmented and then tries
to allocate THP. It re-executes for different numbers of threads. From a
fragmentation perspective, the workload is relatively benign but it does
stress compaction.

The overall impact on latencies for a 1-socket machine is

                                    4.20.0-rc6             4.20.0-rc6
                                mmotm-20181210           capture-v1r8
Amean     fault-both-3      3842.11 (   0.00%)     2898.64 *  24.56%*
Amean     fault-both-5      5201.92 (   0.00%)     4296.58 (  17.40%)
Amean     fault-both-7      7086.15 (   0.00%)     6203.55 (  12.46%)
Amean     fault-both-12    11383.58 (   0.00%)     9309.13 *  18.22%*
Amean     fault-both-18    16616.53 (   0.00%)     6245.27 *  62.42%*
Amean     fault-both-24    18617.05 (   0.00%)    15083.42 *  18.98%*
Amean     fault-both-30    24372.88 (   0.00%)    11498.60 *  52.82%*
Amean     fault-both-32    22621.58 (   0.00%)     9684.82 *  57.19%*

24-62% reduction in fault latency (be it base or huge page)

The allocation success rates which are using MADV_HUGEPAGE are as follows;

                               4.20.0-rc6             4.20.0-rc6
                           mmotm-20181210           capture-v1r8
Percentage huge-3        85.74 (   0.00%)       98.12 (  14.44%)
Percentage huge-5        89.16 (   0.00%)       98.83 (  10.85%)
Percentage huge-7        85.98 (   0.00%)       97.99 (  13.97%)
Percentage huge-12       84.19 (   0.00%)       99.00 (  17.59%)
Percentage huge-18       81.20 (   0.00%)       98.92 (  21.83%)
Percentage huge-24       82.60 (   0.00%)       99.08 (  19.95%)
Percentage huge-30       82.87 (   0.00%)       99.22 (  19.74%)
Percentage huge-32       81.98 (   0.00%)       98.97 (  20.72%)

So, it's showing that the series is not far short of  allocating 100% of the
requested pages as huge pages. Finally the overall scan rates are as follows

Compaction migrate scanned   677936161     4756927
Compaction free scanned      352045485   256525622
Kcompactd migrate scanned       751732      751080
Kcompactd free scanned       113784579    93099786

These are still pretty crazy scan rates but direct compaction migration
scanning is reduced by 99% and the free scanner is reduced by 27% so it's
a step in the right direction.

 include/linux/compaction.h |   3 +-
 include/linux/gfp.h        |   7 +-
 include/linux/sched.h      |   4 +
 kernel/sched/core.c        |   3 +
 mm/compaction.c            | 638 ++++++++++++++++++++++++++++++++++++++-------
 mm/internal.h              |  21 +-
 mm/migrate.c               |   2 +-
 mm/page_alloc.c            |  70 ++++-
 8 files changed, 637 insertions(+), 111 deletions(-)

-- 
2.16.4


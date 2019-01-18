Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CAC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCCC2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfARRvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:51:51 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:45468 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbfARRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:51:51 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 2B2331C3568
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:51:47 +0000 (GMT)
Received: (qmail 30217 invoked from network); 18 Jan 2019 17:51:47 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPA; 18 Jan 2019 17:51:47 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 00/22] Increase success rates and reduce latency of compaction v3
Date:   Fri, 18 Jan 2019 17:51:14 +0000
Message-Id: <20190118175136.31341-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a drop-in replacement for the series currently in Andrews tree that
incorporates static checking and compile warning fixes (Dan, YueHaibing)
and extensive review feedback from Vlastimil. Big thanks to Vlastimil as
the review was extremely detailed and a number of issues were caught. Not
all the patches have been acked but I think an update is still worthwhile.

Andrew, please drop the series you have and replace it with the following
on the off-chance we get bug reports that are fixed already. Doing this
with -fix patches would be relatively painful for little gain.

Changelog since v2
o Fix static checker warnings						(dan)
o Fix unused variable warnings						(yue)
o Drop patch about PageReserved as there is some abuse of the flag outside
  of the mm core.							(vbabka)
o Drop patch using the bulk free helper as it may be vulnerable to races
  with compaction and gup						(vbabka)
o Drop patch about remote compaction. It's unnecessary at this time and
  unclear what the semantics should even be				(vbabka)
o Changelog fixes and clarifications					(vbabka)
o Free list management and search
  Confined mostly to "mm, compaction: Use free lists to quickly locate
  a migration source" which is arguably the most heavily modified patch
  in this revision							(vbabka, mel)
o Some minor churn, modifications, flow changes that fallout from
  addressing the review feedback					(mel)
o Minor pageblock skip changes, mostly fixing up which patch makes the
  changes so the patches are incremental				(mel)

This series reduces scan rates and success rates of compaction, primarily
by using the free lists to shorten scans, better controlling of skip
information and whether multiple scanners can target the same block and
capturing pageblocks before being stolen by parallel requests. The series
is based on mmotm from January 9th, 2019 with the previous compaction
series reverted.

I'm mostly using thpscale to measure the impact of the series. The
benchmark creates a large file, maps it, faults it, punches holes in the
mapping so that the virtual address space is fragmented and then tries
to allocate THP. It re-executes for different numbers of threads. From a
fragmentation perspective, the workload is relatively benign but it does
stress compaction.

The overall impact on latencies for a 1-socket machine is

				      baseline		      patches
Amean     fault-both-3      3832.09 (   0.00%)     2748.56 *  28.28%*
Amean     fault-both-5      4933.06 (   0.00%)     4255.52 (  13.73%)
Amean     fault-both-7      7017.75 (   0.00%)     6586.93 (   6.14%)
Amean     fault-both-12    11610.51 (   0.00%)     9162.34 *  21.09%*
Amean     fault-both-18    17055.85 (   0.00%)    11530.06 *  32.40%*
Amean     fault-both-24    19306.27 (   0.00%)    17956.13 (   6.99%)
Amean     fault-both-30    22516.49 (   0.00%)    15686.47 *  30.33%*
Amean     fault-both-32    23442.93 (   0.00%)    16564.83 *  29.34%*

The allocation success rates are much improved

			 	 baseline		 patches
Percentage huge-3        85.99 (   0.00%)       97.96 (  13.92%)
Percentage huge-5        88.27 (   0.00%)       96.87 (   9.74%)
Percentage huge-7        85.87 (   0.00%)       94.53 (  10.09%)
Percentage huge-12       82.38 (   0.00%)       98.44 (  19.49%)
Percentage huge-18       83.29 (   0.00%)       99.14 (  19.04%)
Percentage huge-24       81.41 (   0.00%)       97.35 (  19.57%)
Percentage huge-30       80.98 (   0.00%)       98.05 (  21.08%)
Percentage huge-32       80.53 (   0.00%)       97.06 (  20.53%)

That's a nearly perfect allocation success rate.

The biggest impact is on the scan rates

Compaction migrate scanned    55893379    19341254
Compaction free scanned      474739990    11903963

The number of pages scanned for migration was reduced by 65% and the
free scanner was reduced by 97.5%. So much less work in exchange
for lower latency and better success rates.

The series was also evaluated using a workload that heavily fragments
memory but the benefits there are also significant, albeit not presented.

It was commented that we should be rethinking scanning entirely and to
a large extent I agree. However, to achieve that you need a lot of this
series in place first so it's best to make the linear scanners as best
as possible before ripping them out.

 include/linux/compaction.h |    3 +-
 include/linux/mmzone.h     |    2 +
 include/linux/sched.h      |    4 +
 kernel/sched/core.c        |    3 +
 mm/compaction.c            | 1000 ++++++++++++++++++++++++++++++++++----------
 mm/internal.h              |   23 +-
 mm/migrate.c               |    2 +-
 mm/page_alloc.c            |   76 +++-
 8 files changed, 888 insertions(+), 225 deletions(-)

-- 
2.16.4


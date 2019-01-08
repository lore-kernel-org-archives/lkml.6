Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9A6C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F5D2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfAHJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:12:22 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:54127 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfAHJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:12:21 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 69F1B1C2263
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jan 2019 09:12:19 +0000 (GMT)
Received: (qmail 26721 invoked from network); 8 Jan 2019 09:12:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jan 2019 09:12:19 -0000
Date:   Tue, 8 Jan 2019 09:12:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/25] Increase success rates and reduce latency of
 compaction v2
Message-ID: <20190108091217.GL31517@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190107154354.b0805ca15767fc7ea9e37545@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190107154354.b0805ca15767fc7ea9e37545@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:43:54PM -0800, Andrew Morton wrote:
> On Fri,  4 Jan 2019 12:49:46 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > This series reduces scan rates and success rates of compaction, primarily
> > by using the free lists to shorten scans, better controlling of skip
> > information and whether multiple scanners can target the same block and
> > capturing pageblocks before being stolen by parallel requests. The series
> > is based on the 4.21/5.0 merge window after Andrew's tree had been merged.
> > It's known to rebase cleanly.
> > 
> > ...
> >
> >  include/linux/compaction.h |    3 +-
> >  include/linux/gfp.h        |    7 +-
> >  include/linux/mmzone.h     |    2 +
> >  include/linux/sched.h      |    4 +
> >  kernel/sched/core.c        |    3 +
> >  mm/compaction.c            | 1031 ++++++++++++++++++++++++++++++++++----------
> >  mm/internal.h              |   23 +-
> >  mm/migrate.c               |    2 +-
> >  mm/page_alloc.c            |   70 ++-
> >  9 files changed, 908 insertions(+), 237 deletions(-)
> 
> Boy that's a lot of material. 

It's unfortunate I know. It just turned out that there is a lot that had
to change to make the most important patches in the series work without
obvious side-effects.

> I just tossed it in there unread for
> now.  Do you have any suggestions as to how we can move ahead with
> getting this appropriately reviewed and tested?
> 

The main workloads that should see a difference are those that use
MADV_HUGEPAGE or change /sys/kernel/mm/transparent_hugepage/defrag. I'm
expecting MADV_HUGEPAGE is more common in practice. By default, there
should be little change as direct compaction is not used heavily for THP.
Although SLUB workloads might see a difference given a long enough uptime,
it will be relatively difficult to detect.

As this was partially motivated by the __GFP_THISNODE discussion, I
would like to hear from David if this series makes an impact, if any,
when starting Google workloads on a fragmented system.

Similarly, I would be interested in hearing if Andrea's KVM startup times
see any benefit. I'm expecting less here as I expect that workload is
still bound by reclaim thrashing the local node in reclaim. Still, a
confirmation would be nice and if there is any benefit then it's a plus
even if the workload gets reclaimed excessively.

Local tests didn't show up anything interesting *other* than what is
already in the changelogs as those workloads are specifically targetting
those paths. Intel LKP has not reported any regressions (functional or
performance) despite being on git.kernel.org for a few weeks. However,
as they are using default configurations, this is not much of a surprise.

Review is harder. Vlastimil would normally be the best fit as he has
worked on compaction but for him or for anyone else, I'm expecting they're
dealing with a backlog after the holidays.  I know I still have to get
to Vlastimil's recent series on THP allocations so I'm guilty of the same
crime with respect to review.

-- 
Mel Gorman
SUSE Labs

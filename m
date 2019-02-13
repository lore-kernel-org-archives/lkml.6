Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E94C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8E62086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404450AbfBMRsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:48:02 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:58698 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728914AbfBMRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:48:02 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 470C31C268C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:47:58 +0000 (GMT)
Received: (qmail 25213 invoked from network); 13 Feb 2019 17:47:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2019 17:47:58 -0000
Date:   Wed, 13 Feb 2019 17:47:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Subject: Re: [PATCH v0 1/2] perf: Add an option to ask for high order
 allocations for AUX buffers
Message-ID: <20190213174756.GU9565@techsingularity.net>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
 <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
 <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:07:55PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 01:47:15PM +0200, Alexander Shishkin wrote:
> > Currently, the AUX buffer allocator will use high-order allocations
> > for PMUs that don't support hardware scatter-gather chaining to ensure
> > large contiguous blocks of pages, and always use an array of single
> > pages otherwise.
> > 
> > There is, however, a tangible performance benefit in using larger chunks
> > of contiguous memory even in the latter case, that comes from not having
> > to fetch the next page's address at every page boundary. In particular,
> > a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
> > penalty with a single multi-page output region in snapshot mode (no PMI)
> > than with multiple single-page output regions, from ~6% down to ~4%. For
> > the snapshot mode it does make a difference as it is intended to run over
> > long periods of time.
> > 
> > Following the above justification, add an attribute bit to ask for a
> > high-order AUX allocation. To prevent an unprivileged user from using up
> > the higher orders of the page allocator, require CAP_SYS_ADMIN for this
> > option.
> 
> Why do we need a knob for that? Last time I checked unpriv users could
> fragment the page allocator just fine. What is there to protect?
> 

It's "protected" in that we try to avoid long-lived unmovable allocations
causing problems but it's internal to the page allocator. The exception
is ZONE_MOVABLE and CMA which has some protection or static pools like
hugetlbfs with tunables and APIs that can strict access if desired.

> Also, since we return all pages upon buffer free, the page allocator
> should in fact re-construct the high order stuff.
> 

It does. At worse, other unmovable allocations may be allocated elsewhere
in the meantime but that's normal activity. It can be replicated in any
number of innocent ways by a normal user. It's even the basis of a test
case that forces fragmentation, measures THP allocation success rate and
stresses compaction.

> So a buffer alloc + free, using high order pages, should be an effective
> nop on high order availability.
> 

Shouldn't even be necessary. With the possible exception of hugetlbfs,
the userspace is not forced to take special action to keep the page
allocator happy.

If there is a tangiable performance benefit from using contiguous regions
then I would suggest optimistically allocating them with appropriate
GFP flags to avoid large latencies at startup time and fall back if
necessary. Don't stick it behind capabilities or restrict it to privileged
users. Only hugetlbfs provides restricted access and exposes an
interface to userspace for applications and even that can be
unprivileged.

-- 
Mel Gorman
SUSE Labs

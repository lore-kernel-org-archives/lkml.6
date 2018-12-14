Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68707206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeLNXLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:11:52 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:44284 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbeLNXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:11:52 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id C9E881C20AB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 23:11:48 +0000 (GMT)
Received: (qmail 1398 invoked from network); 14 Dec 2018 23:11:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Dec 2018 23:11:48 -0000
Date:   Fri, 14 Dec 2018 23:11:47 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181214231147.GF29005@techsingularity.net>
References: <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
 <20181210044916.GC24097@redhat.com>
 <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
 <0bbf4202-6187-28fb-37b7-da6885b89cce@suse.cz>
 <alpine.DEB.2.21.1812141244450.186427@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812141244450.186427@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 01:04:11PM -0800, David Rientjes wrote:
> On Wed, 12 Dec 2018, Vlastimil Babka wrote:
> 
> > > Regarding the role of direct reclaim in the allocator, I think we need 
> > > work on the feedback from compaction to determine whether it's worthwhile.  
> > > That's difficult because of the point I continue to bring up: 
> > > isolate_freepages() is not necessarily always able to access this freed 
> > > memory.
> > 
> > That's one of the *many* reasons why having free base pages doesn't
> > guarantee compaction success. We can and will improve on that. But I
> > don't think it would be e.g. practical to check the pfns of free pages
> > wrt compaction scanner positions and decide based on that.
> 
> Yeah, agreed.  Rather than proposing that memory is only reclaimed if its 
> known that it can be accessible to isolate_freepages(), I'm wondering 
> about the implementation of the freeing scanner entirely.
> 
> In other words, I think there is a lot of potential stranding that occurs 
> for both scanners that could otherwise result in completely free 
> pageblocks.  If there a single movable page present near the end of the 
> zone in an otherwise fully free pageblock, surely we can do better than 
> the current implementation that would never consider this very easy to 
> compact memory.
> 

While it's somewhat premature, I posted a series before I had a full set
of results because it uses free lists to reduce searches and reduces
inference between multiple scanners. Preliminary results indicated it
boosted allocation success rates by 20%ish, reduced migration scanning
by 99% and free scanning by 27%.

> The same problem occurs for the migration scanner where we can iterate 
> over a ton of free memory that is never considered a suitable migration 
> target.  The implementation that attempts to migrate all memory toward the 
> end of the zone penalizes the freeing scanner when it is reset: we just 
> iterate over a ton of used pages.
> 

Yes, partially addressed in series. It can be improved significantly but it
hit a boundary condition near the points where compaction scanners meet. I
dropped the patch in question as it needs more thought on how to deal
with the boundary condition without remigrating the blocks close to it.
Besides, at 14 patches, it would probably be best to get that reviewed
and finalised before building upon it further so review would be welcome.

> Has anybody tried a migration scanner that isn't linearly based, rather 
> finding the highest-order free page of the same migratetype, iterating the 
> pages of its pageblock, and using this to determine whether the actual 
> migration will be worthwhile or not?  I could imagine pageblock_skip being 
> repurposed for this as the heuristic.
> 

Yes, but it has downsides. Redoing the same work on pageblocks, tracking
state and tracking the exit conditions are tricky. I think it's best to
squeeze the most out of the linear scanning first and the series is the
first step in that.

> It would be interesting to know if anybody has tried using the per-zone 
> free_area's to determine migration targets and set a bit if it should be 
> considered a migration source or a migration target.  If all pages for a 
> pageblock are not on free_areas, they are fully used.
> 

Series has patches which implement something similar to this idea.

-- 
Mel Gorman
SUSE Labs

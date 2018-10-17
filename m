Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D17214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D17214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJQQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:55:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbeJQQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:55:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAA89AEFF;
        Wed, 17 Oct 2018 09:00:20 +0000 (UTC)
Date:   Wed, 17 Oct 2018 10:00:15 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181017090015.GI6931@suse.de>
References: <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
 <20181016074606.GH6931@suse.de>
 <20181016153715.b40478ff2eebe8d6cf1aead5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181016153715.b40478ff2eebe8d6cf1aead5@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:37:15PM -0700, Andrew Morton wrote:
> On Tue, 16 Oct 2018 08:46:06 +0100 Mel Gorman <mgorman@suse.de> wrote:
> > I consider this to be an unfortunate outcome. On the one hand, we have a
> > problem that three people can trivially reproduce with known test cases
> > and a patch shown to resolve the problem. Two of those three people work
> > on distributions that are exposed to a large number of users. On the
> > other, we have a problem that requires the system to be in a specific
> > state and an unknown workload that suffers badly from the remote access
> > penalties with a patch that has review concerns and has not been proven
> > to resolve the trivial cases. In the case of distributions, the first
> > patch addresses concerns with a common workload where on the other hand
> > we have an internal workload of a single company that is affected --
> > which indirectly affects many users admittedly but only one entity directly.
> > 
> > At the absolute minimum, a test case for the "system fragmentation incurs
> > access penalties for a workload" scenario that could both replicate the
> > fragmentation and demonstrate the problem should have been available before
> > the patch was rejected.  With the test case, there would be a chance that
> > others could analyse the problem and prototype some fixes. The test case
> > was requested in the thread and never produced so even if someone were to
> > prototype fixes, it would be dependant on a third party to test and produce
> > data which is a time-consuming loop. Instead, we are more or less in limbo.
> > 
> 
> OK, thanks.
> 
> But we're OK holding off for a few weeks, yes?  If we do that
> we'll still make it into 4.19.1.  Am reluctant to merge this while
> discussion, testing and possibly more development are ongoing.
> 

Without a test case that reproduces the Google case, we are a bit stuck.
Previous experience indicates that just fragmenting memory is not enough
to give a reliable case as unless the unmovable/reclaimable pages are
"sticky", the normal reclaim can handle it. Similarly, the access
pattern of the target workload is important as it would need to be
something larger than L3 cache to constantly hit the access penalty. We
do not know what the exact characteristics of the Google workload are
but we know that a fix for three cases is not equivalent for the Google
case.

The discussion has circled around wish-list items such as better
fragmentation control, node-aware compaction, improved compact deferred
logic and lower latencies with little in the way of actual specifics
of implementation or patches. Improving fragmentation control would
benefit from a workload that actually fragments so the extfrag events
can be monitored as well as maybe a dump of pageblocks with mixed pages.

On node-aware compaction, that was not implemented initially simply
because HighMem was common and that needs to be treated as a corner case
-- we cannot safely migrate pages from zone normal to highmem. That one
is relatively trivial to measure as it's a functional issue.

However, backing off compaction properly to maximise allocation success
rates while minimising allocation latency and access latency needs a live
workload that is representative. Trivial cases like the java workloads,
nas or usemem won't do as they either exhibit special locality or are
streaming readers/writers. Memcache might work but the driver in that
case is critical to ensure the access penalties are incurred. Again,
a modern example is missing.

As for why this took so long to discover, it is highly likely that it's
due to VM's being sized such as they typically fit in a NUMA node so
it would have avoided the worst case scenarios. Furthermore, a machine
dedicated to VM's has fewer concerns with respect to slab allocations
and unmovable allocations fragmenting memory long-term. Finally, the
worst case scenarios are encountered when there is a mix of different
workloads of variable duration which may be common in a Google-like setup
with different jobs being dispatched across a large network but less so
in other setups where a service tends to be persistent. We already know
that some of the worst performance problems take years to discover.

-- 
Mel Gorman
SUSE Labs

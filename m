Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DEDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3357020989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3357020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeLEXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:36:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeLEXgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D3B3307CDC2;
        Wed,  5 Dec 2018 23:36:36 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2764A5D967;
        Wed,  5 Dec 2018 23:36:33 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:36:32 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181205233632.GE11899@redhat.com>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 05 Dec 2018 23:36:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:03:10PM -0800, Linus Torvalds wrote:
> On Wed, Dec 5, 2018 at 12:40 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > So ultimately we decided that the saner behavior that gives the least
> > risk of regression for the short term, until we can do something
> > better, was the one that is already applied upstream.
> 
> You're ignoring the fact that people *did* report things regressed.

I don't ignore regressions.. after all the only reason I touched this
code is that I have been asked to fix a regression that made the
upstream kernel unusable in some enterprise workloads with very large
processes. Enterprise releases don't happen every year so it's normal
we noticed only last January a 3 years old regression. The fact it's
an old regression doesn't make it any less relevant. It took until
August until I had the time to track down this specific
regression which artificially delayed this by another 8 months.

With regard to David's specific regression I didn't ignore it either,
I just prioritize on which regression has to be fixed with the most
urgency and David's regression is less severe than the one we're
fixing here. I posted below the numbers for the regression that is
more urgent to fix.

Now suppose (like I think is likely) David may be better off setting
__GFP_THISNODE across the board including for 4k pages not just for
THP. I don't think anybody would be ok if we set __GFP_THISNODE by on
4k pages too unless it's done under a very specific new MPOL. It'll
probably work even better for him probably (the cache will be pushed
into remote nodes by 4k allocations too, and even more of the app data
and executable will be in the local NUMA node). But that's unusable
for anything except his specialized workload that tends to fit in a
single node and can accept to pay an incredible slowdown if it ever
spills over (as long as the process is not getting OOM killed he's ok
because it's such an uncommon occurrence for him that he can pay an
extreme cost just to avoid OOM killing). It's totally fine to optimize
such things with an opt-in like a new MPOL that makes those
assumptions about process size, but it's that's an unacceptable
assumption to impose on all workloads, because it breaks the VM bad
for all workload that can't fit in a single NUMA node.

> That's the part I find unacceptable. You're saying "we picked
> something that minimized regressions".
> 
> No it didn't. The regression is present and real, and is on a real
> load, not a benchmark.
> 
> So that argument is clearly bogus.

Note that "this give the least risk of regression" I never meant the
risk is zero. Obviously we know it's higher than zero. Otherwise David
would have no regression in the first place.

So I stand by my argument that this is what "gives the least risk of
regression" if you're given any workload you know nothing about that
uses MADV_HUGEPAGE and it's benefiting from it and you don't know
beforehand if it can fit or not fit in a single NUMA node.

If you knew for sure it can fit in a single NUMA node, __GFP_THISNODE
would be better, obviously, but the same applies to 4k pages
too... and we're not setting __GFP_THISNODE on 4k allocations under
MPOL_DEFAULT.

So I'm all for fixing David's workload but here we're trying to
generalize an ad-hoc NUMA optimization that isn't necessarily only
applicable to THP order allocations either, like it's a generic good
thing when it isn't.

__GFP_COMPACT_ONLY gave an hope it could give some middle ground but
it shows awful compaction results, it basically destroys compaction
effectiveness and we know why (COMPACT_SKIPPED must call reclaim or
compaction can't succeed because there's not enough free memory in the
node). If somebody used MADV_HUGEPAGE compaction should still work and
not fail like that. Compaction would fail to be effective even in the
local node where __GFP_THISNODE didn't fail. Worst of all it'd fail
even on non-NUMA systems (that would be easy to fix though by making
the HPAGE_PMD_ORDER check conditional to NUMA being enabled at
runtime).

Like said earlier still better to apply __GFP_COMPACT_ONLY or David's
patch than to return to v4.18 though.

===
From: Andrea Arcangeli <aarcange@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Alex Williamson <alex.williamson@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/1] mm: thp: fix transparent_hugepage/defrag = madvise || always
Date: Sun, 19 Aug 2018 23:26:40 -0400

qemu uses MADV_HUGEPAGE which allows direct compaction (i.e.
__GFP_DIRECT_RECLAIM is set).

The problem is that direct compaction combined with the NUMA
__GFP_THISNODE logic in mempolicy.c is telling reclaim to swap very
hard the local node, instead of failing the allocation if there's no
THP available in the local node.

Such logic was ok until __GFP_THISNODE was added to the THP allocation
path even with MPOL_DEFAULT.

The idea behind the __GFP_THISNODE addition, is that it is better to
provide local memory in PAGE_SIZE units than to use remote NUMA THP
backed memory. That largely depends on the remote latency though, on
threadrippers for example the overhead is relatively low in my
experience.

The combination of __GFP_THISNODE and __GFP_DIRECT_RECLAIM results in
extremely slow qemu startup with vfio, if the VM is larger than the
size of one host NUMA node. This is because it will try very hard to
unsuccessfully swapout get_user_pages pinned pages as result of the
__GFP_THISNODE being set, instead of falling back to PAGE_SIZE
allocations and instead of trying to allocate THP on other nodes (it
would be even worse without vfio type1 GUP pins of course, except it'd
be swapping heavily instead).

It's very easy to reproduce this by setting
transparent_hugepage/defrag to "always", even with a simple memhog.

1) This can be fixed by retaining the __GFP_THISNODE logic also for
   __GFP_DIRECT_RELCAIM by allowing only one compaction run. Not even
   COMPACT_SKIPPED (i.e. compaction failing because not enough free
   memory in the zone) should be allowed to invoke reclaim.

2) An alternative is not use __GFP_THISNODE if __GFP_DIRECT_RELCAIM
   has been set by the caller (i.e. MADV_HUGEPAGE or
   defrag="always"). That would keep the NUMA locality restriction
   only when __GFP_DIRECT_RECLAIM is not set by the caller. So THP
   will be provided from remote nodes if available before falling back
   to PAGE_SIZE units in the local node, but an app using defrag =
   always (or madvise with MADV_HUGEPAGE) supposedly prefers that.

These are the results of 1) (higher GB/s is better).

Finished: 30 GB mapped, 10.188535s elapsed, 2.94GB/s
Finished: 34 GB mapped, 12.274777s elapsed, 2.77GB/s
Finished: 38 GB mapped, 13.847840s elapsed, 2.74GB/s
Finished: 42 GB mapped, 14.288587s elapsed, 2.94GB/s

Finished: 30 GB mapped, 8.907367s elapsed, 3.37GB/s
Finished: 34 GB mapped, 10.724797s elapsed, 3.17GB/s
Finished: 38 GB mapped, 14.272882s elapsed, 2.66GB/s
Finished: 42 GB mapped, 13.929525s elapsed, 3.02GB/s

These are the results of 2) (higher GB/s is better).

Finished: 30 GB mapped, 10.163159s elapsed, 2.95GB/s
Finished: 34 GB mapped, 11.806526s elapsed, 2.88GB/s
Finished: 38 GB mapped, 10.369081s elapsed, 3.66GB/s
Finished: 42 GB mapped, 12.357719s elapsed, 3.40GB/s

Finished: 30 GB mapped, 8.251396s elapsed, 3.64GB/s
Finished: 34 GB mapped, 12.093030s elapsed, 2.81GB/s
Finished: 38 GB mapped, 11.824903s elapsed, 3.21GB/s
Finished: 42 GB mapped, 15.950661s elapsed, 2.63GB/s

This is current upstream (higher GB/s is better).

Finished: 30 GB mapped, 8.821632s elapsed, 3.40GB/s
Finished: 34 GB mapped, 341.979543s elapsed, 0.10GB/s
Finished: 38 GB mapped, 761.933231s elapsed, 0.05GB/s
Finished: 42 GB mapped, 1188.409235s elapsed, 0.04GB/s

vfio is a good test because by pinning all memory it avoids the
swapping and reclaim only wastes CPU, a memhog based test would
created swapout storms and supposedly show a bigger stddev.

What is better between 1) and 2) depends on the hardware and on the
software. Virtualization EPT/NTP gets a bigger boost from THP as well
than host applications.

This commit implements 2).

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/mempolicy.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d6512ef28cde..fb7f9581a835 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2047,8 +2047,36 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 
 		if (!nmask || node_isset(hpage_node, *nmask)) {
 			mpol_cond_put(pol);
-			page = __alloc_pages_node(hpage_node,
-						gfp | __GFP_THISNODE, order);
+			/*
+			 * We cannot invoke reclaim if __GFP_THISNODE
+			 * is set. Invoking reclaim with
+			 * __GFP_THISNODE set, would cause THP
+			 * allocations to trigger heavy swapping
+			 * despite there may be tons of free memory
+			 * (including potentially plenty of THP
+			 * already available in the buddy) on all the
+			 * other NUMA nodes.
+			 *
+			 * At most we could invoke compaction when
+			 * __GFP_THISNODE is set (but we would need to
+			 * refrain from invoking reclaim even if
+			 * compaction returned COMPACT_SKIPPED because
+			 * there wasn't not enough memory to succeed
+			 * compaction). For now just avoid
+			 * __GFP_THISNODE instead of limiting the
+			 * allocation path to a strict and single
+			 * compaction invocation.
+			 *
+			 * Supposedly if direct reclaim was enabled by
+			 * the caller, the app prefers THP regardless
+			 * of the node it comes from so this would be
+			 * more desiderable behavior than only
+			 * providing THP originated from the local
+			 * node in such case.
+			 */
+			if (!(gfp & __GFP_DIRECT_RECLAIM))
+				gfp |= __GFP_THISNODE;
+			page = __alloc_pages_node(hpage_node, gfp, order);
 			goto out;
 		}
 	}

===




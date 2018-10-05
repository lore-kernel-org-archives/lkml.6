Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3911C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7552098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7552098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeJEOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:36:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeJEOg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:36:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5575DAE88;
        Fri,  5 Oct 2018 07:38:58 +0000 (UTC)
Date:   Fri, 5 Oct 2018 08:38:54 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stable tree <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181005073854.GB6931@suse.de>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:16:32PM -0700, David Rientjes wrote:
> On Tue, 25 Sep 2018, Michal Hocko wrote:
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index da858f794eb6..149b6f4cf023 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2046,8 +2046,36 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  		nmask = policy_nodemask(gfp, pol);
> >  		if (!nmask || node_isset(hpage_node, *nmask)) {
> >  			mpol_cond_put(pol);
> > -			page = __alloc_pages_node(hpage_node,
> > -						gfp | __GFP_THISNODE, order);
> > +			/*
> > +			 * We cannot invoke reclaim if __GFP_THISNODE
> > +			 * is set. Invoking reclaim with
> > +			 * __GFP_THISNODE set, would cause THP
> > +			 * allocations to trigger heavy swapping
> > +			 * despite there may be tons of free memory
> > +			 * (including potentially plenty of THP
> > +			 * already available in the buddy) on all the
> > +			 * other NUMA nodes.
> > +			 *
> > +			 * At most we could invoke compaction when
> > +			 * __GFP_THISNODE is set (but we would need to
> > +			 * refrain from invoking reclaim even if
> > +			 * compaction returned COMPACT_SKIPPED because
> > +			 * there wasn't not enough memory to succeed
> > +			 * compaction). For now just avoid
> > +			 * __GFP_THISNODE instead of limiting the
> > +			 * allocation path to a strict and single
> > +			 * compaction invocation.
> > +			 *
> > +			 * Supposedly if direct reclaim was enabled by
> > +			 * the caller, the app prefers THP regardless
> > +			 * of the node it comes from so this would be
> > +			 * more desiderable behavior than only
> > +			 * providing THP originated from the local
> > +			 * node in such case.
> > +			 */
> > +			if (!(gfp & __GFP_DIRECT_RECLAIM))
> > +				gfp |= __GFP_THISNODE;
> > +			page = __alloc_pages_node(hpage_node, gfp, order);
> >  			goto out;
> >  		}
> >  	}
> 
> This causes, on average, a 13.9% access latency regression on Haswell, and 
> the regression would likely be more severe on Naples and Rome.
> 

That assumes that fragmentation prevents easy allocation which may very
well be the case. While it would be great that compaction or the page
allocator could be further improved to deal with fragmentation, it's
outside the scope of this patch.

> There exist libraries that allow the .text segment of processes to be 
> remapped to memory backed by transparent hugepages and use MADV_HUGEPAGE 
> to stress local compaction to defragment node local memory for hugepages 
> at startup. 

That is taking advantage of a co-incidence of the implementation.
MADV_HUGEPAGE is *advice* that huge pages be used, not what the locality
is. A hint for strong locality preferences should be separate advice
(madvise) or a separate memory policy. Doing that is outside the context
of this patch but nothing stops you introducing such a policy or madvise,
whichever you think would be best for the libraries to consume (I'm only
aware of libhugetlbfs but there might be others).

> The cost, including the statistics Mel gathered, is 
> acceptable for these processes: they are not concerned with startup cost, 
> they are concerned only with optimal access latency while they are 
> running.
> 

Then such applications at startup have the option of setting
zone_reclaim_mode during initialisation assuming a privileged helper
can be created. That would be somewhat heavy handed and a longer-term
solution would still be to create a proper memory policy of madvise flag
for those libraries.

> So while it may take longer to start the process because memory compaction 
> is attempting to allocate hugepages with __GFP_DIRECT_RECLAIM, in the 
> cases where compaction is successful, this is a very significant long-term 
> win.  In cases where compaction fails, falling back to local pages of the 
> native page size instead of remote thp is a win for the remaining time 
> this process wins: as stated, 13.9% faster for all memory accesses to the 
> process's text while it runs on Haswell.
> 

Again, I remind you that it only benefits applications that prefectly
fit into NUMA nodes. Not all applications are created with that level of
awareness and easily get thrashed if using MADV_HUGEPAGE and do not fit
into a NUMA node.

While it is unfortunate that there are specialised applications that
benefit from the current configuration, I bet there is heavier usage of
qemu affected by the bug this patch addresses than specialised
applications that both fit perfectly into NUMA nodes and are extremely
sensitive to access latencies. It's a question of causing the least harm
to the most users which is what this patch does.

If you need behaviour for more agressive reclaim or locality hints then
kindly introduce them and do not depend in MADV_HUGEPAGE accidentically
doubling up as hints about memory locality.

-- 
Mel Gorman
SUSE Labs

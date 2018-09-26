Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E0214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261E0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeIZUaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:30:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbeIZUaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:30:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BD36B095;
        Wed, 26 Sep 2018 14:17:10 +0000 (UTC)
Date:   Wed, 26 Sep 2018 16:17:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20180926141708.GX6278@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-09-18 16:30:39, Kirill A. Shutemov wrote:
> On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c3bc7e9c9a2a..c0bcede31930 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >   *	    available
> >   * never: never stall for any thp allocation
> >   */
> > -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> > +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
> >  {
> >  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> > +	gfp_t this_node = 0;
> > +
> > +#ifdef CONFIG_NUMA
> > +	struct mempolicy *pol;
> > +	/*
> > +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> > +	 * specified, to express a general desire to stay on the current
> > +	 * node for optimistic allocation attempts. If the defrag mode
> > +	 * and/or madvise hint requires the direct reclaim then we prefer
> > +	 * to fallback to other node rather than node reclaim because that
> > +	 * can lead to excessive reclaim even though there is free memory
> > +	 * on other nodes. We expect that NUMA preferences are specified
> > +	 * by memory policies.
> > +	 */
> > +	pol = get_vma_policy(vma, addr);
> > +	if (pol->mode != MPOL_BIND)
> > +		this_node = __GFP_THISNODE;
> > +	mpol_cond_put(pol);
> > +#endif
> 
> I'm not very good with NUMA policies. Could you explain in more details how
> the code above is equivalent to the code below?

MPOL_PREFERRED is handled by policy_node() before we call __alloc_pages_nodemask.
__GFP_THISNODE is applied only when we are not using
__GFP_DIRECT_RECLAIM which is handled in alloc_hugepage_direct_gfpmask
now.
Lastly MPOL_BIND wasn't handled explicitly but in the end the removed
late check would remove __GFP_THISNODE for it as well. So in the end we
are doing the same thing unless I miss something
 
> > @@ -2026,60 +2025,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  		goto out;
> >  	}
> >  
> > -	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
> > -		int hpage_node = node;
> > -
> > -		/*
> > -		 * For hugepage allocation and non-interleave policy which
> > -		 * allows the current node (or other explicitly preferred
> > -		 * node) we only try to allocate from the current/preferred
> > -		 * node and don't fall back to other nodes, as the cost of
> > -		 * remote accesses would likely offset THP benefits.
> > -		 *
> > -		 * If the policy is interleave, or does not allow the current
> > -		 * node in its nodemask, we allocate the standard way.
> > -		 */
> > -		if (pol->mode == MPOL_PREFERRED &&
> > -						!(pol->flags & MPOL_F_LOCAL))
> > -			hpage_node = pol->v.preferred_node;
> > -
> > -		nmask = policy_nodemask(gfp, pol);
> > -		if (!nmask || node_isset(hpage_node, *nmask)) {
> > -			mpol_cond_put(pol);
> > -			/*
> > -			 * We cannot invoke reclaim if __GFP_THISNODE
> > -			 * is set. Invoking reclaim with
> > -			 * __GFP_THISNODE set, would cause THP
> > -			 * allocations to trigger heavy swapping
> > -			 * despite there may be tons of free memory
> > -			 * (including potentially plenty of THP
> > -			 * already available in the buddy) on all the
> > -			 * other NUMA nodes.
> > -			 *
> > -			 * At most we could invoke compaction when
> > -			 * __GFP_THISNODE is set (but we would need to
> > -			 * refrain from invoking reclaim even if
> > -			 * compaction returned COMPACT_SKIPPED because
> > -			 * there wasn't not enough memory to succeed
> > -			 * compaction). For now just avoid
> > -			 * __GFP_THISNODE instead of limiting the
> > -			 * allocation path to a strict and single
> > -			 * compaction invocation.
> > -			 *
> > -			 * Supposedly if direct reclaim was enabled by
> > -			 * the caller, the app prefers THP regardless
> > -			 * of the node it comes from so this would be
> > -			 * more desiderable behavior than only
> > -			 * providing THP originated from the local
> > -			 * node in such case.
> > -			 */
> > -			if (!(gfp & __GFP_DIRECT_RECLAIM))
> > -				gfp |= __GFP_THISNODE;
> > -			page = __alloc_pages_node(hpage_node, gfp, order);
> > -			goto out;
> > -		}
> > -	}
> > -
> >  	nmask = policy_nodemask(gfp, pol);
> >  	preferred_nid = policy_node(gfp, pol, node);
> >  	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
> 
> -- 
>  Kirill A. Shutemov

-- 
Michal Hocko
SUSE Labs

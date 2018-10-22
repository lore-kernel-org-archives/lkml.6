Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC1C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3EA20644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3EA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeJVVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbeJVVtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:49:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA32FB004;
        Mon, 22 Oct 2018 13:30:58 +0000 (UTC)
Date:   Mon, 22 Oct 2018 15:30:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20181022133058.GE18839@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <20180926141708.GX6278@dhcp22.suse.cz>
 <20180926142227.GZ6278@dhcp22.suse.cz>
 <26cb01ff-a094-79f4-7ceb-291e5e053c58@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cb01ff-a094-79f4-7ceb-291e5e053c58@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 15:15:38, Vlastimil Babka wrote:
> On 9/26/18 4:22 PM, Michal Hocko wrote:
> > On Wed 26-09-18 16:17:08, Michal Hocko wrote:
> >> On Wed 26-09-18 16:30:39, Kirill A. Shutemov wrote:
> >>> On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index c3bc7e9c9a2a..c0bcede31930 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >>>>   *	    available
> >>>>   * never: never stall for any thp allocation
> >>>>   */
> >>>> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> >>>> +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
> >>>>  {
> >>>>  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> >>>> +	gfp_t this_node = 0;
> >>>> +
> >>>> +#ifdef CONFIG_NUMA
> >>>> +	struct mempolicy *pol;
> >>>> +	/*
> >>>> +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> >>>> +	 * specified, to express a general desire to stay on the current
> >>>> +	 * node for optimistic allocation attempts. If the defrag mode
> >>>> +	 * and/or madvise hint requires the direct reclaim then we prefer
> >>>> +	 * to fallback to other node rather than node reclaim because that
> >>>> +	 * can lead to excessive reclaim even though there is free memory
> >>>> +	 * on other nodes. We expect that NUMA preferences are specified
> >>>> +	 * by memory policies.
> >>>> +	 */
> >>>> +	pol = get_vma_policy(vma, addr);
> >>>> +	if (pol->mode != MPOL_BIND)
> >>>> +		this_node = __GFP_THISNODE;
> >>>> +	mpol_cond_put(pol);
> >>>> +#endif
> >>>
> >>> I'm not very good with NUMA policies. Could you explain in more details how
> >>> the code above is equivalent to the code below?
> >>
> >> MPOL_PREFERRED is handled by policy_node() before we call __alloc_pages_nodemask.
> >> __GFP_THISNODE is applied only when we are not using
> >> __GFP_DIRECT_RECLAIM which is handled in alloc_hugepage_direct_gfpmask
> >> now.
> >> Lastly MPOL_BIND wasn't handled explicitly but in the end the removed
> >> late check would remove __GFP_THISNODE for it as well. So in the end we
> >> are doing the same thing unless I miss something
> > 
> > Forgot to add. One notable exception would be that the previous code
> > would allow to hit
> > 	WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> > in policy_node if the requested node (e.g. cpu local one) was outside of
> > the mbind nodemask. This is not possible now. We haven't heard about any
> > such warning yet so it is unlikely that it happens though.
> 
> I don't think the previous code could hit the warning, as the hugepage
> path that would add __GFP_THISNODE didn't call policy_node() (containing
> the warning) at all. IIRC early of your patch did hit the warning
> though, which is why you added the MPOL_BIND policy check.

Are you sure? What prevents node_isset(node, policy_nodemask()) == F and
fallback to the !huge allocation path? alloc_pages_vma is usually called
with the local node and processes shouldn't run off their bounded num
mask but is that guaranteed? Moreover do_huge_pmd_wp_page_fallback uses
the former numa binding and that might be outside of the policy mask.

In any case, as I've said this is highly unlikely to hit which is
underlined by the lack of reports.

-- 
Michal Hocko
SUSE Labs

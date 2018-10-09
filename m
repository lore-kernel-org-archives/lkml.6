Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D53C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E47214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E47214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJITxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:35958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbeJITxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:53:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 993C1AE19;
        Tue,  9 Oct 2018 12:36:36 +0000 (UTC)
Date:   Tue, 9 Oct 2018 14:36:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-ID: <20181009123635.GO8528@dhcp22.suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-3-mhocko@kernel.org>
 <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
 <alpine.DEB.2.21.1810041317010.16935@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810041317010.16935@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-10-18 13:17:52, David Rientjes wrote:
> On Wed, 26 Sep 2018, Kirill A. Shutemov wrote:
> 
> > On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index c3bc7e9c9a2a..c0bcede31930 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> > >   *	    available
> > >   * never: never stall for any thp allocation
> > >   */
> > > -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> > > +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
> > >  {
> > >  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> > > +	gfp_t this_node = 0;
> > > +
> > > +#ifdef CONFIG_NUMA
> > > +	struct mempolicy *pol;
> > > +	/*
> > > +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> > > +	 * specified, to express a general desire to stay on the current
> > > +	 * node for optimistic allocation attempts. If the defrag mode
> > > +	 * and/or madvise hint requires the direct reclaim then we prefer
> > > +	 * to fallback to other node rather than node reclaim because that
> > > +	 * can lead to excessive reclaim even though there is free memory
> > > +	 * on other nodes. We expect that NUMA preferences are specified
> > > +	 * by memory policies.
> > > +	 */
> > > +	pol = get_vma_policy(vma, addr);
> > > +	if (pol->mode != MPOL_BIND)
> > > +		this_node = __GFP_THISNODE;
> > > +	mpol_cond_put(pol);
> > > +#endif
> > 
> > I'm not very good with NUMA policies. Could you explain in more details how
> > the code above is equivalent to the code below?
> > 
> 
> It breaks mbind() because new_page() is now using numa_node_id() to 
> allocate migration targets for instead of using the mempolicy.  I'm not 
> sure that this patch was tested for mbind().

I am sorry but I do not follow, could you be more specific please?
MPOL_BIND should never get __GFP_THISNODE. What am I missing?

-- 
Michal Hocko
SUSE Labs

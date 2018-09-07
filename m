Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA5AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1802077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1802077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeIGNnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:43:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIGNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:43:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57E50AF6A;
        Fri,  7 Sep 2018 09:03:13 +0000 (UTC)
Date:   Fri, 7 Sep 2018 11:03:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
Message-ID: <20180907090312.GF19621@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
 <20180906125356.GX14951@dhcp22.suse.cz>
 <50d355bf-17d0-ee01-ec35-7f04e79ca277@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d355bf-17d0-ee01-ec35-7f04e79ca277@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 19:00:43, Aneesh Kumar K.V wrote:
> On 09/06/2018 06:23 PM, Michal Hocko wrote:
> > On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
> > > Current code doesn't do page migration if the page allocated is a compound page.
> > > With HugeTLB migration support, we can end up allocating hugetlb pages from
> > > CMA region. Also THP pages can be allocated from CMA region. This patch updates
> > > the code to handle compound pages correctly.
> > > 
> > > This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
> > > with right count, instead of doing one get_user_pages per page. That avoids
> > > reading page table multiple times.
> > > 
> > > The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
> > > We use the same storage location to store pointers to struct page. We cannot
> > > update alll the code path use struct page *, because we access hpas in real mode
> > > and we can't do that struct page * to pfn conversion in real mode.
> > 
> > I am not fmailiar with this code so bear with me. I am completely
> > missing the purpose of this patch. The changelog doesn't really explain
> > that AFAICS. I can only guess that you do not want to establish long
> > pins on CMA pages, right? So whenever you are about to pin a page that
> > is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?
> 
> That is right.
> 
> > If that is the case then how do you handle pins which are already in
> > zone_movable? I do not see any specific check for those.
> 
> 
> > 
> > Btw. why is this a proper thing to do? Problems with longterm pins are
> > not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
> > well so there is a risk of OOMs if there are too many of them. We have
> > discussed approaches that would allow to force pin invalidation/revocation
> > at LSF/MM. Isn't that a more appropriate solution to the problem you are
> > seeing?
> > 
> 
> The CMA area is used on powerpc platforms to allocate guest specific page
> table (hash page table). If we don't have sufficient free pages we fail to
> allocate hash page table that result in failure to start guest.
> 
> Now with vfio, we end up pinning the entire guest RAM. There is a
> possibility that these guest RAM  pages got allocated from CMA region. We
> already do supporting migrating those pages out except for compound pages.
> What this patch does is to start supporting compound page migration that got
> allocated out of CMA region (ie, THP pages and hugetlb pages if platform
> supported hugetlb migration).

This definitely belongs to the changelog.

> Now to do that I added a helper get_user_pages_cma_migrate().
> 
> I agree that long term pinned pages do have other issues. The patchset is
> not solving that issue.

It would be great to note why a generic approach is not viable. I assume
the main reason is that those pins are pretty much permanent for the
guest lifetime so the situation has to be handled in advance. In other
words, more information please. 
-- 
Michal Hocko
SUSE Labs

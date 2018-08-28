Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0D42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0D42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeH1EYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:24:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeH1EYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E085740203F1;
        Tue, 28 Aug 2018 00:35:19 +0000 (UTC)
Received: from redhat.com (ovpn-120-184.rdu2.redhat.com [10.10.120.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55819202704E;
        Tue, 28 Aug 2018 00:35:19 +0000 (UTC)
Date:   Mon, 27 Aug 2018 20:35:17 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/7] mm/hmm: properly handle migration pmd
Message-ID: <20180828003517.GA4042@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-5-jglisse@redhat.com>
 <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 00:35:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 00:35:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:05:46PM -0400, Zi Yan wrote:
> Hi Jérôme,
> 
> On 24 Aug 2018, at 15:25, jglisse@redhat.com wrote:
> 
> > From: Jérôme Glisse <jglisse@redhat.com>
> >
> > Before this patch migration pmd entry (!pmd_present()) would have
> > been treated as a bad entry (pmd_bad() returns true on migration
> > pmd entry). The outcome was that device driver would believe that
> > the range covered by the pmd was bad and would either SIGBUS or
> > simply kill all the device's threads (each device driver decide
> > how to react when the device tries to access poisonnous or invalid
> > range of memory).
> >
> > This patch explicitly handle the case of migration pmd entry which
> > are non present pmd entry and either wait for the migration to
> > finish or report empty range (when device is just trying to pre-
> > fill a range of virtual address and thus do not want to wait or
> > trigger page fault).
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/hmm.c | 45 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index a16678d08127..659efc9aada6 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -577,22 +577,47 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >  {
> >  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> >  	struct hmm_range *range = hmm_vma_walk->range;
> > +	struct vm_area_struct *vma = walk->vma;
> >  	uint64_t *pfns = range->pfns;
> >  	unsigned long addr = start, i;
> >  	pte_t *ptep;
> > +	pmd_t pmd;
> >
> > -	i = (addr - range->start) >> PAGE_SHIFT;
> >
> >  again:
> > -	if (pmd_none(*pmdp))
> > +	pmd = READ_ONCE(*pmdp);
> > +	if (pmd_none(pmd))
> >  		return hmm_vma_walk_hole(start, end, walk);
> >
> > -	if (pmd_huge(*pmdp) && (range->vma->vm_flags & VM_HUGETLB))
> > +	if (pmd_huge(pmd) && (range->vma->vm_flags & VM_HUGETLB))
> >  		return hmm_pfns_bad(start, end, walk);
> >
> > -	if (pmd_devmap(*pmdp) || pmd_trans_huge(*pmdp)) {
> > -		pmd_t pmd;
> > +	if (!pmd_present(pmd)) {
> > +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> > +
> > +		if (is_migration_entry(entry)) {
> 
> I think you should check thp_migration_supported() here, since PMD migration is only enabled in x86_64 systems.
> Other architectures should treat PMD migration entries as bad.

You are right, Andrew do you want to repost or can you edit above if
to:

if (thp_migration_supported() && is_migration_entry(entry)) {

Cheers,
Jérôme

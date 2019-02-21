Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300922089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfBUA2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:28:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfBUA2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:28:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A0594E916;
        Thu, 21 Feb 2019 00:28:12 +0000 (UTC)
Received: from redhat.com (ovpn-120-249.rdu2.redhat.com [10.10.120.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2E61001DC8;
        Thu, 21 Feb 2019 00:28:11 +0000 (UTC)
Date:   Wed, 20 Feb 2019 19:28:09 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 03/10] mm/hmm: improve and rename hmm_vma_get_pfns() to
 hmm_range_snapshot()
Message-ID: <20190221002809.GC24489@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-4-jglisse@redhat.com>
 <cc2d909c-37c6-4239-7755-4383a8eca0df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc2d909c-37c6-4239-7755-4383a8eca0df@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 21 Feb 2019 00:28:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:25:07PM -0800, John Hubbard wrote:
> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > Rename for consistency between code, comments and documentation. Also
> > improves the comments on all the possible returns values. Improve the
> > function by returning the number of populated entries in pfns array.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >   include/linux/hmm.h |  4 ++--
> >   mm/hmm.c            | 23 ++++++++++-------------
> >   2 files changed, 12 insertions(+), 15 deletions(-)
> > 
> 
> Hi Jerome,
> 
> After applying the entire patchset, I still see a few hits of the old name,
> in Documentation:
> 
> $ git grep -n hmm_vma_get_pfns
> Documentation/vm/hmm.rst:192:  int hmm_vma_get_pfns(struct vm_area_struct *vma,
> Documentation/vm/hmm.rst:205:The first one (hmm_vma_get_pfns()) will only
> fetch present CPU page table
> Documentation/vm/hmm.rst:224:      ret = hmm_vma_get_pfns(vma, &range,
> start, end, pfns);
> include/linux/hmm.h:145: * HMM pfn value returned by hmm_vma_get_pfns() or
> hmm_vma_fault() will be:
> 
> 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index bd6e058597a6..ddf49c1b1f5e 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -365,11 +365,11 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
> >    * table invalidation serializes on it.
> >    *
> >    * YOU MUST CALL hmm_vma_range_done() ONCE AND ONLY ONCE EACH TIME YOU CALL
> > - * hmm_vma_get_pfns() WITHOUT ERROR !
> > + * hmm_range_snapshot() WITHOUT ERROR !
> >    *
> >    * IF YOU DO NOT FOLLOW THE ABOVE RULE THE SNAPSHOT CONTENT MIGHT BE INVALID !
> >    */
> > -int hmm_vma_get_pfns(struct hmm_range *range);
> > +long hmm_range_snapshot(struct hmm_range *range);
> >   bool hmm_vma_range_done(struct hmm_range *range);
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 74d69812d6be..0d9ecd3337e5 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -706,23 +706,19 @@ static void hmm_pfns_special(struct hmm_range *range)
> >   }
> >   /*
> > - * hmm_vma_get_pfns() - snapshot CPU page table for a range of virtual addresses
> > - * @range: range being snapshotted
> > + * hmm_range_snapshot() - snapshot CPU page table for a range
> > + * @range: range
> >    * Returns: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
> 
> Channeling Mike Rapoport, that should be @Return: instead of Returns: , but...
> 
> 
> > - *          vma permission, 0 success
> > + *          permission (for instance asking for write and range is read only),
> > + *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
> > + *          vma or it is illegal to access that range), number of valid pages
> > + *          in range->pfns[] (from range start address).
> 
> ...actually, that's a little hard to spot that we're returning number of
> valid pages. How about:
> 
>  * @Returns: number of valid pages in range->pfns[] (from range start
>  *           address). This may be zero. If the return value is negative,
>  *           then one of the following values may be returned:
>  *
>  *           -EINVAL  range->invalid is set, or range->start or range->end
>  *                    are not valid.
>  *           -EPERM   For example, asking for write, when the range is
>  *      	      read-only
>  *           -EAGAIN  Caller needs to retry
>  *           -EFAULT  Either no valid vma exists for this range, or it is
>  *                    illegal to access the range
> 
> (caution: my white space might be wrong with respect to tabs)

Will do a documentation patch to improve things and remove leftover.

Cheers,
Jérôme

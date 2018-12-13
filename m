Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C2C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEF720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLMDXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:23:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeLMDXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:23:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D43E307D840;
        Thu, 13 Dec 2018 03:23:00 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C6D75D70A;
        Thu, 13 Dec 2018 03:22:54 +0000 (UTC)
Date:   Thu, 13 Dec 2018 11:22:52 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     =?utf-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH v2] mm: thp: fix flags for pmd migration when split
Message-ID: <20181213032252.GB18268@xz-x1>
References: <20181211051254.16633-1-peterx@redhat.com>
 <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
 <20181212051540.GA8970@xz-x1>
 <CALYGNiOSrwH-JCEqsZCeCNwnyJBTy_WtpjVuq5hpo6MYX=db7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALYGNiOSrwH-JCEqsZCeCNwnyJBTy_WtpjVuq5hpo6MYX=db7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Dec 2018 03:23:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:51:38PM +0300, Konstantin Khlebnikov wrote:
> On Wed, Dec 12, 2018 at 8:15 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Dec 11, 2018 at 11:21:44AM +0300, Konstantin Khlebnikov wrote:
> > > On 11.12.2018 8:12, Peter Xu wrote:
> > > > When splitting a huge migrating PMD, we'll transfer all the existing
> > > > PMD bits and apply them again onto the small PTEs.  However we are
> > > > fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> > > > or pmd_yound() while actually they don't make sense at all when it's
> > > > a migration entry.  Fix them up by make it conditional.
> > > >
> > > > Note that if my understanding is correct about the problem then if
> > > > without the patch there is chance to lose some of the dirty bits in
> > > > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > > > of swap offset instead of bit 2) and it could potentially corrupt the
> > > > memory of an userspace program which depends on the dirty bit.
> > > >
> > > > CC: Andrea Arcangeli <aarcange@redhat.com>
> > > > CC: Andrew Morton <akpm@linux-foundation.org>
> > > > CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > CC: Matthew Wilcox <willy@infradead.org>
> > > > CC: Michal Hocko <mhocko@suse.com>
> > > > CC: Dave Jiang <dave.jiang@intel.com>
> > > > CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > > CC: Souptick Joarder <jrdr.linux@gmail.com>
> > > > CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > > CC: linux-mm@kvack.org
> > > > CC: linux-kernel@vger.kernel.org
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > v2:
> > > > - fix it up for young/write/dirty bits too [Konstantin]
> > > > ---
> > > >   mm/huge_memory.c | 15 ++++++++++-----
> > > >   1 file changed, 10 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index f2d19e4fe854..b00941b3d342 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2157,11 +2157,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> > > >             page = pmd_page(old_pmd);
> > > >     VM_BUG_ON_PAGE(!page_count(page), page);
> > > >     page_ref_add(page, HPAGE_PMD_NR - 1);
> > > > -   if (pmd_dirty(old_pmd))
> > > > -           SetPageDirty(page);
> > > > -   write = pmd_write(old_pmd);
> > > > -   young = pmd_young(old_pmd);
> > > > -   soft_dirty = pmd_soft_dirty(old_pmd);
> > > > +   if (unlikely(pmd_migration)) {
> > > > +           soft_dirty = pmd_swp_soft_dirty(old_pmd);
> > > > +           young = write = false;
> > > > +   } else {
> > > > +           if (pmd_dirty(old_pmd))
> > > > +                   SetPageDirty(page);
> > > > +           write = pmd_write(old_pmd);
> > > > +           young = pmd_young(old_pmd);
> > > > +           soft_dirty = pmd_soft_dirty(old_pmd);
> > > > +   }
> > >
> > > Write/read-only is encoded into migration entry.
> > > I suppose there should be something like this:
> > >
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2151,16 +2151,21 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> > >
> > >                 entry = pmd_to_swp_entry(old_pmd);
> > >                 page = pfn_to_page(swp_offset(entry));
> > > +               write = is_write_migration_entry(entry);
> > > +               young = false;
> > > +               soft_dirty = pmd_swp_soft_dirty(old_pmd);
> > >         } else
> > >  #endif
> > > +       {
> > >                 page = pmd_page(old_pmd);
> > > +               if (pmd_dirty(old_pmd))
> > > +                       SetPageDirty(page);
> > > +               write = pmd_write(old_pmd);
> > > +               young = pmd_young(old_pmd);
> > > +               soft_dirty = pmd_soft_dirty(old_pmd);
> > > +       }
> > >         VM_BUG_ON_PAGE(!page_count(page), page);
> > >         page_ref_add(page, HPAGE_PMD_NR - 1);
> > > -       if (pmd_dirty(old_pmd))
> > > -               SetPageDirty(page);
> > > -       write = pmd_write(old_pmd);
> > > -       young = pmd_young(old_pmd);
> > > -       soft_dirty = pmd_soft_dirty(old_pmd);
> > >
> > >         /*
> > >          * Withdraw the table only after we mark the pmd entry invalid.
> > >
> >
> > Oops yes, I missed the write bit.  Thanks for pointing it out.
> >
> > Should I repost with your authorship and your sign-off?
> 
> Feel free to use this piece for your own patch.
> 
> > Or even I'll
> > consider to directly drop the CONFIG_ARCH_ENABLE_THP_MIGRATION if with
> > that since I don't see much gain to keep it:
> 
> Yep, this ifdef could be removed.
> Without CONFIG_ARCH_ENABLE_THP_MIGRATION
> is_pmd_migration_entry() is constant 0 so compiler should eliminate "if" branch.

Thank you, Konstantin.  I'll post v3 with the macro dropped.

Regards,

-- 
Peter Xu

Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD6BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA5B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLLFPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:15:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLFPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:15:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 522CF307D857;
        Wed, 12 Dec 2018 05:15:48 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14F305FCA0;
        Wed, 12 Dec 2018 05:15:42 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:15:40 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: thp: fix flags for pmd migration when split
Message-ID: <20181212051540.GA8970@xz-x1>
References: <20181211051254.16633-1-peterx@redhat.com>
 <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 12 Dec 2018 05:15:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:21:44AM +0300, Konstantin Khlebnikov wrote:
> On 11.12.2018 8:12, Peter Xu wrote:
> > When splitting a huge migrating PMD, we'll transfer all the existing
> > PMD bits and apply them again onto the small PTEs.  However we are
> > fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> > or pmd_yound() while actually they don't make sense at all when it's
> > a migration entry.  Fix them up by make it conditional.
> > 
> > Note that if my understanding is correct about the problem then if
> > without the patch there is chance to lose some of the dirty bits in
> > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > of swap offset instead of bit 2) and it could potentially corrupt the
> > memory of an userspace program which depends on the dirty bit.
> > 
> > CC: Andrea Arcangeli <aarcange@redhat.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: Michal Hocko <mhocko@suse.com>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > CC: Souptick Joarder <jrdr.linux@gmail.com>
> > CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > CC: linux-mm@kvack.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2:
> > - fix it up for young/write/dirty bits too [Konstantin]
> > ---
> >   mm/huge_memory.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f2d19e4fe854..b00941b3d342 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2157,11 +2157,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >   		page = pmd_page(old_pmd);
> >   	VM_BUG_ON_PAGE(!page_count(page), page);
> >   	page_ref_add(page, HPAGE_PMD_NR - 1);
> > -	if (pmd_dirty(old_pmd))
> > -		SetPageDirty(page);
> > -	write = pmd_write(old_pmd);
> > -	young = pmd_young(old_pmd);
> > -	soft_dirty = pmd_soft_dirty(old_pmd);
> > +	if (unlikely(pmd_migration)) {
> > +		soft_dirty = pmd_swp_soft_dirty(old_pmd);
> > +		young = write = false;
> > +	} else {
> > +		if (pmd_dirty(old_pmd))
> > +			SetPageDirty(page);
> > +		write = pmd_write(old_pmd);
> > +		young = pmd_young(old_pmd);
> > +		soft_dirty = pmd_soft_dirty(old_pmd);
> > +	}
> 
> Write/read-only is encoded into migration entry.
> I suppose there should be something like this:
> 
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2151,16 +2151,21 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> 
>                 entry = pmd_to_swp_entry(old_pmd);
>                 page = pfn_to_page(swp_offset(entry));
> +               write = is_write_migration_entry(entry);
> +               young = false;
> +               soft_dirty = pmd_swp_soft_dirty(old_pmd);
>         } else
>  #endif
> +       {
>                 page = pmd_page(old_pmd);
> +               if (pmd_dirty(old_pmd))
> +                       SetPageDirty(page);
> +               write = pmd_write(old_pmd);
> +               young = pmd_young(old_pmd);
> +               soft_dirty = pmd_soft_dirty(old_pmd);
> +       }
>         VM_BUG_ON_PAGE(!page_count(page), page);
>         page_ref_add(page, HPAGE_PMD_NR - 1);
> -       if (pmd_dirty(old_pmd))
> -               SetPageDirty(page);
> -       write = pmd_write(old_pmd);
> -       young = pmd_young(old_pmd);
> -       soft_dirty = pmd_soft_dirty(old_pmd);
> 
>         /*
>          * Withdraw the table only after we mark the pmd entry invalid.
> 

Oops yes, I missed the write bit.  Thanks for pointing it out.

Should I repost with your authorship and your sign-off?  Or even I'll
consider to directly drop the CONFIG_ARCH_ENABLE_THP_MIGRATION if with
that since I don't see much gain to keep it:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f2d19e4fe854..aebade83cec9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2145,23 +2145,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,                                                                                          
         */
        old_pmd = pmdp_invalidate(vma, haddr, pmd);

-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
        pmd_migration = is_pmd_migration_entry(old_pmd);
-       if (pmd_migration) {
+       if (unlikely(pmd_migration)) {
                swp_entry_t entry;

                entry = pmd_to_swp_entry(old_pmd);
                page = pfn_to_page(swp_offset(entry));
-       } else
-#endif
+               write = is_write_migration_entry(entry);
+               young = false;
+               soft_dirty = pmd_swp_soft_dirty(old_pmd);
+       } else {
                page = pmd_page(old_pmd);
+               if (pmd_dirty(old_pmd))
+                       SetPageDirty(page);
+               write = pmd_write(old_pmd);
+               young = pmd_young(old_pmd);
+               soft_dirty = pmd_soft_dirty(old_pmd);
+       }
        VM_BUG_ON_PAGE(!page_count(page), page);
        page_ref_add(page, HPAGE_PMD_NR - 1);
-       if (pmd_dirty(old_pmd))
-               SetPageDirty(page);
-       write = pmd_write(old_pmd);
-       young = pmd_young(old_pmd);
-       soft_dirty = pmd_soft_dirty(old_pmd);

        /*
         * Withdraw the table only after we mark the pmd entry invalid.

Thanks,

-- 
Peter Xu

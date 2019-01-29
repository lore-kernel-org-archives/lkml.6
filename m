Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996C620856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfA2Tb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:31:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfA2Tb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:31:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 182872CD7E2;
        Tue, 29 Jan 2019 19:31:28 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F40600D7;
        Tue, 29 Jan 2019 19:31:26 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:31:24 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190129193123.GF3176@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-10-jglisse@redhat.com>
 <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 19:31:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:41:23AM -0800, Dan Williams wrote:
> On Tue, Jan 29, 2019 at 8:54 AM <jglisse@redhat.com> wrote:
> >
> > From: Jérôme Glisse <jglisse@redhat.com>
> >
> > This add support to mirror vma which is an mmap of a file which is on
> > a filesystem that using a DAX block device. There is no reason not to
> > support that case.
> >
> 
> The reason not to support it would be if it gets in the way of future
> DAX development. How does this interact with MAP_SYNC? I'm also
> concerned if this complicates DAX reflink support. In general I'd
> rather prioritize fixing the places where DAX is broken today before
> adding more cross-subsystem entanglements. The unit tests for
> filesystems (xfstests) are readily accessible. How would I go about
> regression testing DAX + HMM interactions?

HMM mirror CPU page table so anything you do to CPU page table will
be reflected to all HMM mirror user. So MAP_SYNC has no bearing here
whatsoever as all HMM mirror user must do cache coherent access to
range they mirror so from DAX point of view this is just _exactly_
the same as CPU access.

Note that you can not migrate DAX memory to GPU memory and thus for a
mmap of a file on a filesystem that use a DAX block device then you can
not do migration to device memory. Also at this time migration of file
back page is only supported for cache coherent device memory so for
instance on OpenCAPI platform.

Bottom line is you just have to worry about the CPU page table. What
ever you do there will be reflected properly. It does not add any
burden to people working on DAX. Unless you want to modify CPU page
table without calling mmu notifier but in that case you would not
only break HMM mirror user but other thing like KVM ...


For testing the issue is what do you want to test ? Do you want to test
that a device properly mirror some mmap of a file back by DAX ? ie
device driver which use HMM mirror keep working after changes made to
DAX.

Or do you want to run filesystem test suite using the GPU to access
mmap of the file (read or write) instead of the CPU ? In that case any
such test suite would need to be updated to be able to use something
like OpenCL for. At this time i do not see much need for that but maybe
this is something people would like to see.

Cheers,
Jérôme


> 
> > Note that unlike GUP code we do not take page reference hence when we
> > back-off we have nothing to undo.
> >
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  mm/hmm.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 112 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 8b87e1813313..1a444885404e 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -334,6 +334,7 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
> >
> >  struct hmm_vma_walk {
> >         struct hmm_range        *range;
> > +       struct dev_pagemap      *pgmap;
> >         unsigned long           last;
> >         bool                    fault;
> >         bool                    block;
> > @@ -508,6 +509,15 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
> >                                 range->flags[HMM_PFN_VALID];
> >  }
> >
> > +static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
> > +{
> > +       if (!pud_present(pud))
> > +               return 0;
> > +       return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
> > +                               range->flags[HMM_PFN_WRITE] :
> > +                               range->flags[HMM_PFN_VALID];
> > +}
> > +
> >  static int hmm_vma_handle_pmd(struct mm_walk *walk,
> >                               unsigned long addr,
> >                               unsigned long end,
> > @@ -529,8 +539,19 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
> >                 return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> >
> >         pfn = pmd_pfn(pmd) + pte_index(addr);
> > -       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
> > +       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> > +               if (pmd_devmap(pmd)) {
> > +                       hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
> > +                                             hmm_vma_walk->pgmap);
> > +                       if (unlikely(!hmm_vma_walk->pgmap))
> > +                               return -EBUSY;
> > +               }
> >                 pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
> > +       }
> > +       if (hmm_vma_walk->pgmap) {
> > +               put_dev_pagemap(hmm_vma_walk->pgmap);
> > +               hmm_vma_walk->pgmap = NULL;
> > +       }
> >         hmm_vma_walk->last = end;
> >         return 0;
> >  }
> > @@ -617,10 +638,24 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
> >         if (fault || write_fault)
> >                 goto fault;
> >
> > +       if (pte_devmap(pte)) {
> > +               hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
> > +                                             hmm_vma_walk->pgmap);
> > +               if (unlikely(!hmm_vma_walk->pgmap))
> > +                       return -EBUSY;
> > +       } else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
> > +               *pfn = range->values[HMM_PFN_SPECIAL];
> > +               return -EFAULT;
> > +       }
> > +
> >         *pfn = hmm_pfn_from_pfn(range, pte_pfn(pte)) | cpu_flags;
> >         return 0;
> >
> >  fault:
> > +       if (hmm_vma_walk->pgmap) {
> > +               put_dev_pagemap(hmm_vma_walk->pgmap);
> > +               hmm_vma_walk->pgmap = NULL;
> > +       }
> >         pte_unmap(ptep);
> >         /* Fault any virtual address we were asked to fault */
> >         return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> > @@ -708,12 +743,84 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >                         return r;
> >                 }
> >         }
> > +       if (hmm_vma_walk->pgmap) {
> > +               put_dev_pagemap(hmm_vma_walk->pgmap);
> > +               hmm_vma_walk->pgmap = NULL;
> > +       }
> >         pte_unmap(ptep - 1);
> >
> >         hmm_vma_walk->last = addr;
> >         return 0;
> >  }
> >
> > +static int hmm_vma_walk_pud(pud_t *pudp,
> > +                           unsigned long start,
> > +                           unsigned long end,
> > +                           struct mm_walk *walk)
> > +{
> > +       struct hmm_vma_walk *hmm_vma_walk = walk->private;
> > +       struct hmm_range *range = hmm_vma_walk->range;
> > +       struct vm_area_struct *vma = walk->vma;
> > +       unsigned long addr = start, next;
> > +       pmd_t *pmdp;
> > +       pud_t pud;
> > +       int ret;
> > +
> > +again:
> > +       pud = READ_ONCE(*pudp);
> > +       if (pud_none(pud))
> > +               return hmm_vma_walk_hole(start, end, walk);
> > +
> > +       if (pud_huge(pud) && pud_devmap(pud)) {
> > +               unsigned long i, npages, pfn;
> > +               uint64_t *pfns, cpu_flags;
> > +               bool fault, write_fault;
> > +
> > +               if (!pud_present(pud))
> > +                       return hmm_vma_walk_hole(start, end, walk);
> > +
> > +               i = (addr - range->start) >> PAGE_SHIFT;
> > +               npages = (end - addr) >> PAGE_SHIFT;
> > +               pfns = &range->pfns[i];
> > +
> > +               cpu_flags = pud_to_hmm_pfn_flags(range, pud);
> > +               hmm_range_need_fault(hmm_vma_walk, pfns, npages,
> > +                                    cpu_flags, &fault, &write_fault);
> > +               if (fault || write_fault)
> > +                       return hmm_vma_walk_hole_(addr, end, fault,
> > +                                               write_fault, walk);
> > +
> > +               pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> > +               for (i = 0; i < npages; ++i, ++pfn) {
> > +                       hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
> > +                                             hmm_vma_walk->pgmap);
> > +                       if (unlikely(!hmm_vma_walk->pgmap))
> > +                               return -EBUSY;
> > +                       pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
> > +               }
> > +               if (hmm_vma_walk->pgmap) {
> > +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> > +                       hmm_vma_walk->pgmap = NULL;
> > +               }
> > +               hmm_vma_walk->last = end;
> > +               return 0;
> > +       }
> > +
> > +       split_huge_pud(vma, pudp, addr);
> > +       if (pud_none(*pudp))
> > +               goto again;
> > +
> > +       pmdp = pmd_offset(pudp, addr);
> > +       do {
> > +               next = pmd_addr_end(addr, end);
> > +               ret = hmm_vma_walk_pmd(pmdp, addr, next, walk);
> > +               if (ret)
> > +                       return ret;
> > +       } while (pmdp++, addr = next, addr != end);
> > +
> > +       return 0;
> > +}
> > +
> >  static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
> >                                       unsigned long start, unsigned long end,
> >                                       struct mm_walk *walk)
> > @@ -786,14 +893,6 @@ static void hmm_pfns_clear(struct hmm_range *range,
> >                 *pfns = range->values[HMM_PFN_NONE];
> >  }
> >
> > -static void hmm_pfns_special(struct hmm_range *range)
> > -{
> > -       unsigned long addr = range->start, i = 0;
> > -
> > -       for (; addr < range->end; addr += PAGE_SIZE, i++)
> > -               range->pfns[i] = range->values[HMM_PFN_SPECIAL];
> > -}
> > -
> >  /*
> >   * hmm_range_register() - start tracking change to CPU page table over a range
> >   * @range: range
> > @@ -911,12 +1010,6 @@ long hmm_range_snapshot(struct hmm_range *range)
> >                 if (vma == NULL || (vma->vm_flags & device_vma))
> >                         return -EFAULT;
> >
> > -               /* FIXME support dax */
> > -               if (vma_is_dax(vma)) {
> > -                       hmm_pfns_special(range);
> > -                       return -EINVAL;
> > -               }
> > -
> >                 if (is_vm_hugetlb_page(vma)) {
> >                         struct hstate *h = hstate_vma(vma);
> >
> > @@ -940,6 +1033,7 @@ long hmm_range_snapshot(struct hmm_range *range)
> >                 }
> >
> >                 range->vma = vma;
> > +               hmm_vma_walk.pgmap = NULL;
> >                 hmm_vma_walk.last = start;
> >                 hmm_vma_walk.fault = false;
> >                 hmm_vma_walk.range = range;
> > @@ -951,6 +1045,7 @@ long hmm_range_snapshot(struct hmm_range *range)
> >                 mm_walk.pte_entry = NULL;
> >                 mm_walk.test_walk = NULL;
> >                 mm_walk.hugetlb_entry = NULL;
> > +               mm_walk.pud_entry = hmm_vma_walk_pud;
> >                 mm_walk.pmd_entry = hmm_vma_walk_pmd;
> >                 mm_walk.pte_hole = hmm_vma_walk_hole;
> >                 mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
> > @@ -1018,12 +1113,6 @@ long hmm_range_fault(struct hmm_range *range, bool block)
> >                 if (vma == NULL || (vma->vm_flags & device_vma))
> >                         return -EFAULT;
> >
> > -               /* FIXME support dax */
> > -               if (vma_is_dax(vma)) {
> > -                       hmm_pfns_special(range);
> > -                       return -EINVAL;
> > -               }
> > -
> >                 if (is_vm_hugetlb_page(vma)) {
> >                         struct hstate *h = hstate_vma(vma);
> >
> > @@ -1047,6 +1136,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
> >                 }
> >
> >                 range->vma = vma;
> > +               hmm_vma_walk.pgmap = NULL;
> >                 hmm_vma_walk.last = start;
> >                 hmm_vma_walk.fault = true;
> >                 hmm_vma_walk.block = block;
> > @@ -1059,6 +1149,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
> >                 mm_walk.pte_entry = NULL;
> >                 mm_walk.test_walk = NULL;
> >                 mm_walk.hugetlb_entry = NULL;
> > +               mm_walk.pud_entry = hmm_vma_walk_pud;
> >                 mm_walk.pmd_entry = hmm_vma_walk_pmd;
> >                 mm_walk.pte_hole = hmm_vma_walk_hole;
> >                 mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
> > --
> > 2.17.2
> >

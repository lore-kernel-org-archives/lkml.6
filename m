Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D45C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA01F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="C9iTEo72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfA2Slg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:41:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39438 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA2Slf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:41:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so17010100oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HL83ygIqpSTTKGQg55ygGuyvC6iG0KJllUYn+t+L7fo=;
        b=C9iTEo72hAQPj1VLygRAYbRemfwQw/wdjdXDB3e/eclhA3asML1sVcibMctJEo6uvM
         UzOOCIoV4igwfhs+BOKVOb0NxKQHX2mLoe8zTN3ipepSsA7CJPAms4TelPvV+lEjs7NS
         pusDqWXYQz/xLw4ddjbankm+UWcc6n3w2WKfNtD2q98fMZLd/SmA2TGcs+1zSKGaGNbB
         Jw5Wu0qyfVYCB6sDA9JS9NCp+tKRnBCdViSIy6ksZVgWPNi+MGPcLByDcG16oUtSJCp6
         GG09SsSyEVlXkjPiF7ZobCb6Pwh05ezDJtreAqFoLVpnb+I50qvxDtXBG+iI7KAoqZmr
         IxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HL83ygIqpSTTKGQg55ygGuyvC6iG0KJllUYn+t+L7fo=;
        b=PVtRL7XNRTpD87OABsODqXv+NC3yE4z3N8Yc8VECOSARGkQnweZ55zhD329IeYaM/U
         Q6TMStp+p+aSp7PXeasCisBrwGTCE4rd3mNDZe7biG+UBZn0NQ1cvXvU43mkARYZnJ9G
         ae6HeBSc5u3YlUqjfs0ya/PkhIKlfda78incRdV13p/jGFkSCwwGw0Cuos/dmFUI8tUb
         O3NHRQRKwI8mmT290+O1GZ2v9AIw8naxPujR4eJiNsByuE4amPBj0ikZz/TrbqDB6mJK
         52RANr6lhAVqAK3DNaHMkQdkLXCZstKbchHYZiJ0Fg63QXwU38Li0UZ5ymoy94aN7BHR
         KVdw==
X-Gm-Message-State: AJcUukcyDv8f7cVGPQX4QJh2HE4fpEj1wHfVdGgAL5jnkjWVnHnRjds6
        Qd15Vs67pDk6aiAINV+fEOFFrPZv6xOr9+ENx4jeEw==
X-Google-Smtp-Source: AHgI3IYljlwfixZbEW9k35QADvn426C06Y3dCzjYEAwUUk9JxY2Lr5SqZvdOmBetvdgd9kgxSjPcJbFa3Dw6Aldoo9c=
X-Received: by 2002:aca:d905:: with SMTP id q5mr10434566oig.0.1548787294934;
 Tue, 29 Jan 2019 10:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-10-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-10-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 10:41:23 -0800
Message-ID: <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 8:54 AM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> This add support to mirror vma which is an mmap of a file which is on
> a filesystem that using a DAX block device. There is no reason not to
> support that case.
>

The reason not to support it would be if it gets in the way of future
DAX development. How does this interact with MAP_SYNC? I'm also
concerned if this complicates DAX reflink support. In general I'd
rather prioritize fixing the places where DAX is broken today before
adding more cross-subsystem entanglements. The unit tests for
filesystems (xfstests) are readily accessible. How would I go about
regression testing DAX + HMM interactions?

> Note that unlike GUP code we do not take page reference hence when we
> back-off we have nothing to undo.
>
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hmm.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 112 insertions(+), 21 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 8b87e1813313..1a444885404e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -334,6 +334,7 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
>
>  struct hmm_vma_walk {
>         struct hmm_range        *range;
> +       struct dev_pagemap      *pgmap;
>         unsigned long           last;
>         bool                    fault;
>         bool                    block;
> @@ -508,6 +509,15 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct h=
mm_range *range, pmd_t pmd)
>                                 range->flags[HMM_PFN_VALID];
>  }
>
> +static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud=
_t pud)
> +{
> +       if (!pud_present(pud))
> +               return 0;
> +       return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
> +                               range->flags[HMM_PFN_WRITE] :
> +                               range->flags[HMM_PFN_VALID];
> +}
> +
>  static int hmm_vma_handle_pmd(struct mm_walk *walk,
>                               unsigned long addr,
>                               unsigned long end,
> @@ -529,8 +539,19 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>                 return hmm_vma_walk_hole_(addr, end, fault, write_fault, =
walk);
>
>         pfn =3D pmd_pfn(pmd) + pte_index(addr);
> -       for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++)
> +       for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++) {
> +               if (pmd_devmap(pmd)) {
> +                       hmm_vma_walk->pgmap =3D get_dev_pagemap(pfn,
> +                                             hmm_vma_walk->pgmap);
> +                       if (unlikely(!hmm_vma_walk->pgmap))
> +                               return -EBUSY;
> +               }
>                 pfns[i] =3D hmm_pfn_from_pfn(range, pfn) | cpu_flags;
> +       }
> +       if (hmm_vma_walk->pgmap) {
> +               put_dev_pagemap(hmm_vma_walk->pgmap);
> +               hmm_vma_walk->pgmap =3D NULL;
> +       }
>         hmm_vma_walk->last =3D end;
>         return 0;
>  }
> @@ -617,10 +638,24 @@ static int hmm_vma_handle_pte(struct mm_walk *walk,=
 unsigned long addr,
>         if (fault || write_fault)
>                 goto fault;
>
> +       if (pte_devmap(pte)) {
> +               hmm_vma_walk->pgmap =3D get_dev_pagemap(pte_pfn(pte),
> +                                             hmm_vma_walk->pgmap);
> +               if (unlikely(!hmm_vma_walk->pgmap))
> +                       return -EBUSY;
> +       } else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special=
(pte)) {
> +               *pfn =3D range->values[HMM_PFN_SPECIAL];
> +               return -EFAULT;
> +       }
> +
>         *pfn =3D hmm_pfn_from_pfn(range, pte_pfn(pte)) | cpu_flags;
>         return 0;
>
>  fault:
> +       if (hmm_vma_walk->pgmap) {
> +               put_dev_pagemap(hmm_vma_walk->pgmap);
> +               hmm_vma_walk->pgmap =3D NULL;
> +       }
>         pte_unmap(ptep);
>         /* Fault any virtual address we were asked to fault */
>         return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
> @@ -708,12 +743,84 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>                         return r;
>                 }
>         }
> +       if (hmm_vma_walk->pgmap) {
> +               put_dev_pagemap(hmm_vma_walk->pgmap);
> +               hmm_vma_walk->pgmap =3D NULL;
> +       }
>         pte_unmap(ptep - 1);
>
>         hmm_vma_walk->last =3D addr;
>         return 0;
>  }
>
> +static int hmm_vma_walk_pud(pud_t *pudp,
> +                           unsigned long start,
> +                           unsigned long end,
> +                           struct mm_walk *walk)
> +{
> +       struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +       struct hmm_range *range =3D hmm_vma_walk->range;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long addr =3D start, next;
> +       pmd_t *pmdp;
> +       pud_t pud;
> +       int ret;
> +
> +again:
> +       pud =3D READ_ONCE(*pudp);
> +       if (pud_none(pud))
> +               return hmm_vma_walk_hole(start, end, walk);
> +
> +       if (pud_huge(pud) && pud_devmap(pud)) {
> +               unsigned long i, npages, pfn;
> +               uint64_t *pfns, cpu_flags;
> +               bool fault, write_fault;
> +
> +               if (!pud_present(pud))
> +                       return hmm_vma_walk_hole(start, end, walk);
> +
> +               i =3D (addr - range->start) >> PAGE_SHIFT;
> +               npages =3D (end - addr) >> PAGE_SHIFT;
> +               pfns =3D &range->pfns[i];
> +
> +               cpu_flags =3D pud_to_hmm_pfn_flags(range, pud);
> +               hmm_range_need_fault(hmm_vma_walk, pfns, npages,
> +                                    cpu_flags, &fault, &write_fault);
> +               if (fault || write_fault)
> +                       return hmm_vma_walk_hole_(addr, end, fault,
> +                                               write_fault, walk);
> +
> +               pfn =3D pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT)=
;
> +               for (i =3D 0; i < npages; ++i, ++pfn) {
> +                       hmm_vma_walk->pgmap =3D get_dev_pagemap(pfn,
> +                                             hmm_vma_walk->pgmap);
> +                       if (unlikely(!hmm_vma_walk->pgmap))
> +                               return -EBUSY;
> +                       pfns[i] =3D hmm_pfn_from_pfn(range, pfn) | cpu_fl=
ags;
> +               }
> +               if (hmm_vma_walk->pgmap) {
> +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> +                       hmm_vma_walk->pgmap =3D NULL;
> +               }
> +               hmm_vma_walk->last =3D end;
> +               return 0;
> +       }
> +
> +       split_huge_pud(vma, pudp, addr);
> +       if (pud_none(*pudp))
> +               goto again;
> +
> +       pmdp =3D pmd_offset(pudp, addr);
> +       do {
> +               next =3D pmd_addr_end(addr, end);
> +               ret =3D hmm_vma_walk_pmd(pmdp, addr, next, walk);
> +               if (ret)
> +                       return ret;
> +       } while (pmdp++, addr =3D next, addr !=3D end);
> +
> +       return 0;
> +}
> +
>  static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
>                                       unsigned long start, unsigned long =
end,
>                                       struct mm_walk *walk)
> @@ -786,14 +893,6 @@ static void hmm_pfns_clear(struct hmm_range *range,
>                 *pfns =3D range->values[HMM_PFN_NONE];
>  }
>
> -static void hmm_pfns_special(struct hmm_range *range)
> -{
> -       unsigned long addr =3D range->start, i =3D 0;
> -
> -       for (; addr < range->end; addr +=3D PAGE_SIZE, i++)
> -               range->pfns[i] =3D range->values[HMM_PFN_SPECIAL];
> -}
> -
>  /*
>   * hmm_range_register() - start tracking change to CPU page table over a=
 range
>   * @range: range
> @@ -911,12 +1010,6 @@ long hmm_range_snapshot(struct hmm_range *range)
>                 if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
>                         return -EFAULT;
>
> -               /* FIXME support dax */
> -               if (vma_is_dax(vma)) {
> -                       hmm_pfns_special(range);
> -                       return -EINVAL;
> -               }
> -
>                 if (is_vm_hugetlb_page(vma)) {
>                         struct hstate *h =3D hstate_vma(vma);
>
> @@ -940,6 +1033,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>                 }
>
>                 range->vma =3D vma;
> +               hmm_vma_walk.pgmap =3D NULL;
>                 hmm_vma_walk.last =3D start;
>                 hmm_vma_walk.fault =3D false;
>                 hmm_vma_walk.range =3D range;
> @@ -951,6 +1045,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>                 mm_walk.pte_entry =3D NULL;
>                 mm_walk.test_walk =3D NULL;
>                 mm_walk.hugetlb_entry =3D NULL;
> +               mm_walk.pud_entry =3D hmm_vma_walk_pud;
>                 mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
>                 mm_walk.pte_hole =3D hmm_vma_walk_hole;
>                 mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
> @@ -1018,12 +1113,6 @@ long hmm_range_fault(struct hmm_range *range, bool=
 block)
>                 if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
>                         return -EFAULT;
>
> -               /* FIXME support dax */
> -               if (vma_is_dax(vma)) {
> -                       hmm_pfns_special(range);
> -                       return -EINVAL;
> -               }
> -
>                 if (is_vm_hugetlb_page(vma)) {
>                         struct hstate *h =3D hstate_vma(vma);
>
> @@ -1047,6 +1136,7 @@ long hmm_range_fault(struct hmm_range *range, bool =
block)
>                 }
>
>                 range->vma =3D vma;
> +               hmm_vma_walk.pgmap =3D NULL;
>                 hmm_vma_walk.last =3D start;
>                 hmm_vma_walk.fault =3D true;
>                 hmm_vma_walk.block =3D block;
> @@ -1059,6 +1149,7 @@ long hmm_range_fault(struct hmm_range *range, bool =
block)
>                 mm_walk.pte_entry =3D NULL;
>                 mm_walk.test_walk =3D NULL;
>                 mm_walk.hugetlb_entry =3D NULL;
> +               mm_walk.pud_entry =3D hmm_vma_walk_pud;
>                 mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
>                 mm_walk.pte_hole =3D hmm_vma_walk_hole;
>                 mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
> --
> 2.17.2
>

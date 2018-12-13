Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A682075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ceH7Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A682075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLMHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:55:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55428 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:55:33 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so2362737itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvXSIz7pyaoKhHJHa9iccA3pdu8W31AHnSaQXOtbK+Q=;
        b=f2ceH7Q637GgyJ4RBeAwWr8e337vD2vn85Ykx8tm7alj8YeidIjfuKKfrcEup0Dn+K
         Ser2zsslkV6taESeLTAyXws5SCX73n9RA7+S1qnjAOn9ccr2PCir/M/vmhiXRDrGDiEV
         Bqr+8iCSA2xLxI0v4muCK7KZ1/1VVRQWQxBRVPAFkom6T8oI1fHBpEKciQlmWRHdJBIX
         fsOliv3Na+WQUnqwbTVjC+DaoJX4TXe2CaIPTmDpw4FdS5yaRU1QNNVOUxiRukue7ilp
         mQSHjQMNfU/T2NR9p1SEYy1fPwVwz1S39MBwoDh8/nzBiF5u8oMfMnxptzWOJ70tWQV8
         QkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvXSIz7pyaoKhHJHa9iccA3pdu8W31AHnSaQXOtbK+Q=;
        b=badbcSWF20bR9u1oLJ5yiOZPrSb2H1jwxaHelLz2vZsDA6fz5IIl4FnYRH7KAwtHnB
         5fsed1o4WXbH5s0/0kRm5SRDwi2G3lgrS6LcAh0RVX3YEER4XXas9H1y8qtu4tVwOF2A
         tsiN2W6oG15kWSsKrbKOsEwH6iqhP+DZOmd4b8V3RI+WBtZiK+T7deZ4lVJWcyMwJmUc
         AeiO3ysyxZenPTBEvHMqC5QuzXjtRdkMrn/DvKgLXOUA4YhDB+0E8ga4jGw2wJNrN4m2
         zpoPYa9/echAaRc2BJorD04VcKObbs84osrP3U1o89licXKuH39/XE7JsNRvtAwFiNL7
         S9Ng==
X-Gm-Message-State: AA+aEWbr778+v9nmQQYzVJERfkBFOT38apYIfwo7FlvSq40u12OqBUOX
        1V3+DxaeMYne6Tgv2fkRMuABYkuACm/OKWvhNbI=
X-Google-Smtp-Source: AFSGD/XhLPSOnwvanKlnAILlliUhOPn2c+beM1UNNf+gwNg4w75KuCzaD/uHD53dG+hBfNGGBW1qgzKVgqnOsdlsTTs=
X-Received: by 2002:a02:8ca8:: with SMTP id f37mr23036116jak.80.1544687732284;
 Wed, 12 Dec 2018 23:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20181213051510.20306-1-peterx@redhat.com>
In-Reply-To: <20181213051510.20306-1-peterx@redhat.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Thu, 13 Dec 2018 10:55:21 +0300
Message-ID: <CALYGNiM-L6Hf7S0yyi0XZyt9u=fxLNBHoVV51XQWp4ggS1XH9Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: thp: fix flags for pmd migration when split
To:     peterx@redhat.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, zi.yan@cs.rutgers.edu,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 8:15 AM Peter Xu <peterx@redhat.com> wrote:
>
> When splitting a huge migrating PMD, we'll transfer all the existing
> PMD bits and apply them again onto the small PTEs.  However we are
> fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> or pmd_yound() while actually they don't make sense at all when it's
> a migration entry.  Fix them up.  Since at it, drop the ifdef together
> as not needed.
>
> Note that if my understanding is correct about the problem then if
> without the patch there is chance to lose some of the dirty bits in
> the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> of swap offset instead of bit 2) and it could potentially corrupt the
> memory of an userspace program which depends on the dirty bit.
>

Looks good to me

Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@suse.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> CC: Souptick Joarder <jrdr.linux@gmail.com>
> CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: Zi Yan <zi.yan@cs.rutgers.edu>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - fix it up for young/write/dirty bits too [Konstantin]
> v3:
> - fetch write correctly for migration entry; drop macro [Konstantin]
> ---
>  mm/huge_memory.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f2d19e4fe854..aebade83cec9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2145,23 +2145,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>          */
>         old_pmd = pmdp_invalidate(vma, haddr, pmd);
>
> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>         pmd_migration = is_pmd_migration_entry(old_pmd);
> -       if (pmd_migration) {
> +       if (unlikely(pmd_migration)) {
>                 swp_entry_t entry;
>
>                 entry = pmd_to_swp_entry(old_pmd);
>                 page = pfn_to_page(swp_offset(entry));
> -       } else
> -#endif
> +               write = is_write_migration_entry(entry);
> +               young = false;
> +               soft_dirty = pmd_swp_soft_dirty(old_pmd);
> +       } else {
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
> --
> 2.17.1
>

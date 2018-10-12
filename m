Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2788A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2788A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeJLXyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:54:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34712 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeJLXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:54:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so8016078qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=l4P5ftorzdZFf54e25/mg6dL3Vw3q1rXWX7kpWGKN/g=;
        b=fOTLandl4illqDgBMqUK7/R3EP+Dh/mvW0dn/JtO/QdkxtMHtz/fOjnug3nimBC7kV
         bgYG/FCL0JB2xhegGd9av55iWm0I4juG/bQo8ZOTQ9GTLQ1E7EQKexT6pO7eBNfN2SNa
         /g55LF4rHRuNyBiHhheBjdVS/JrLUivDeudnfVZk0/u5F+vralsEoZO1VboTyci9yC83
         T6hrJNlSLzE/fL2XvR78KztmMCTr2yRU+yXZ3VvfG62dTGzpBCrREWEeDcCh+6sT28o+
         tpUqc5G3NyoR0HIH9oHscoZcjnR98fnATj973KHHEB+3go99RwvT/LysxtY3LVyNfca7
         Ij/A==
X-Gm-Message-State: ABuFfoj7qbbg8NecM88lg+IAJmYSQcBBU84kgCvm0pseqaIlMuRcHPw2
        BB1C+p3yCPF2zP8Fz31ZidOuQA==
X-Google-Smtp-Source: ACcGV60ye7w/eqKzoBT3mNicw3JKgyykZ7MNfkda8WEXb/kTE0b0wQUZg/vQtcVlGir6xjZ85C8EjA==
X-Received: by 2002:a37:35c8:: with SMTP id c191-v6mr6651754qka.100.1539361257144;
        Fri, 12 Oct 2018 09:20:57 -0700 (PDT)
Received: from [172.16.126.1] (pool-108-5-250-108.nwrknj.fios.verizon.net. [108.5.250.108])
        by smtp.gmail.com with ESMTPSA id n67-v6sm1293680qkh.66.2018.10.12.09.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 09:20:55 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "David Nellans" <dnellans@nvidia.com>,
        "Ingo Molnar" <mingo@elte.hu>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Minchan Kim" <minchan@kernel.org>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>
Subject: Re: [PATCH] mm/thp: fix call to mmu_notifier in
 set_pmd_migration_entry()
Date:   Fri, 12 Oct 2018 12:20:54 -0400
X-Mailer: MailMate (1.12r5528)
Message-ID: <DB07F115-B404-4AB0-9D54-BC20C3A3F2B0@cs.rutgers.edu>
In-Reply-To: <20181012160953.5841-1-jglisse@redhat.com>
References: <20181012160953.5841-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_906B21A9-2CB1-46F5-85D0-2BB0F3A26498_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_906B21A9-2CB1-46F5-85D0-2BB0F3A26498_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12 Oct 2018, at 12:09, jglisse@redhat.com wrote:

> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> Inside set_pmd_migration_entry() we are holding page table locks and
> thus we can not sleep so we can not call invalidate_range_start/end()
>
> So remove call to mmu_notifier_invalidate_range_start/end() and add
> call to mmu_notifier_invalidate_range(). Note that we are already
> calling mmu_notifier_invalidate_range_start/end() inside the function
> calling set_pmd_migration_entry() (see try_to_unmap_one()).
>
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Reported-by: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Nellans <dnellans@nvidia.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  mm/huge_memory.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 533f9b00147d..93cb80fe12cb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2885,9 +2885,6 @@ void set_pmd_migration_entry(struct page_vma_mapp=
ed_walk *pvmw,
>  	if (!(pvmw->pmd && !pvmw->pte))
>  		return;
>
> -	mmu_notifier_invalidate_range_start(mm, address,
> -			address + HPAGE_PMD_SIZE);
> -
>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>  	pmdval =3D *pvmw->pmd;
>  	pmdp_invalidate(vma, address, pvmw->pmd);
> @@ -2898,11 +2895,9 @@ void set_pmd_migration_entry(struct page_vma_map=
ped_walk *pvmw,
>  	if (pmd_soft_dirty(pmdval))
>  		pmdswp =3D pmd_swp_mksoft_dirty(pmdswp);
>  	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
> +	mmu_notifier_invalidate_range(mm, address, address + HPAGE_PMD_SIZE);=

>  	page_remove_rmap(page, true);
>  	put_page(page);
> -
> -	mmu_notifier_invalidate_range_end(mm, address,
> -			address + HPAGE_PMD_SIZE);
>  }
>
>  void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct pa=
ge *new)
> -- =

> 2.17.2

Yes, these are the redundant calls to mmu_notifier_invalidate_range_start=
/end()
in set_pmd_migration_entry(). Thanks for the patch.

Fixes: 616b8371539a6 (mm: thp: enable thp migration in generic path)

Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_906B21A9-2CB1-46F5-85D0-2BB0F3A26498_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlvAyeYWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzLdvB/9sSW6PhPP3b8PepHGMrweMmbAq
IAHFaZPjvCVTv44YZ252VsCc7Qrbiy2zGyHZiGqSxSBAq/nUykKl5EbgJ/O1j0hT
L/akDOrb7YCCgogc0UJMGaqZxbtJuCr/YDj0TPG7+5CTpmSrdiojRoVl5U6yiKmF
lblWlIrITT8K2JjHQuPLmz6MlHWhVL4jhYNzxjMgNBPA+m/2rqcb8Kd9Sq+YhkjC
3npyQykfs7vg3BIbRXaaXvipvQP/yynLKkhC4AqkIjlzXSjHpuLQU34Dlu1GGjcs
DyZgn3FwFejiabqzwsnDlkq9XBExfQsfF+dTVk4MyvuowDgFHIRSbPF0/FwX
=fw1N
-----END PGP SIGNATURE-----

--=_MailMate_906B21A9-2CB1-46F5-85D0-2BB0F3A26498_=--

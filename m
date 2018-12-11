Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB23C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D4520870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D4520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeLKTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:07:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44499 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:07:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so17669910qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=9EVxJIr2/Lh1JCKeq35N20Qmv/nPYEK2TBJGMyTD2uo=;
        b=I6sYHwAH20kZ/DAVEyRjSMu9Q0WSKCePaEjKwolnYmkYA0eulEdPmqGSMwsT+DPIW1
         K0p9poC3XT1nNUi+bda/8afbW0U5+AIXBgh5+IVxDOnbqCL7k8232N+8TXxI4s4ScM1S
         oUz+00SoE8oLso/EASlmY6wInuMeOgCv68ZgF/MjhWCZ+Z6prDApol+6A4EquYUfOSEB
         1EPVbJjtTh/eCfARDm7PuH4oyXl5I7X6wP6YMK5N8ad9XIU6Vf0dzAP+aDebAOe4CTDU
         g9AJ3AY7YcyH59vzpomfxF1nrz9eGsaB4Yx+p6ZBaTJwsM+47i9TepbShZh3k6K/6sa8
         OiEQ==
X-Gm-Message-State: AA+aEWazV6ZDqlUzUXEQDewRbGckHxifP6m5/DA7oyw42FlZoQqbxG98
        hXfUEkKgFDjki+W3hswlffgxjA==
X-Google-Smtp-Source: AFSGD/U+xPMhNS3kACYbosb4sqdfMpCmxcUnQmxQiCqYDOW7+Ocmj+LBPdVOdAvK6j2XFuyezWN0BQ==
X-Received: by 2002:a0c:9c89:: with SMTP id i9mr16447420qvf.153.1544555274303;
        Tue, 11 Dec 2018 11:07:54 -0800 (PST)
Received: from [10.8.0.10] (pool-128-6-37-72.nat.rutgers.edu. [128.6.37.72])
        by smtp.gmail.com with ESMTPSA id o2sm11822232qko.97.2018.12.11.11.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:07:52 -0800 (PST)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Konstantin Khlebnikov" <khlebnikov@yandex-team.ru>,
        "Peter Xu" <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Souptick Joarder" <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: thp: fix flags for pmd migration when split
Date:   Tue, 11 Dec 2018 14:07:49 -0500
X-Mailer: MailMate (1.12.2r5570)
Message-ID: <2B8D97F1-6E87-4556-ADBF-102D3C386478@cs.rutgers.edu>
In-Reply-To: <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
References: <20181211051254.16633-1-peterx@redhat.com>
 <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_966F3666-67DE-420C-A1F0-C9DF558AF115_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_966F3666-67DE-420C-A1F0-C9DF558AF115_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Dec 2018, at 3:21, Konstantin Khlebnikov wrote:
>
> Write/read-only is encoded into migration entry.
> I suppose there should be something like this:
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2151,16 +2151,21 @@ static void __split_huge_pmd_locked(struct vm_a=
rea_struct *vma, pmd_t *pmd,
>
>                 entry =3D pmd_to_swp_entry(old_pmd);
>                 page =3D pfn_to_page(swp_offset(entry));
> +               write =3D is_write_migration_entry(entry);
> +               young =3D false;
> +               soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>         } else
>  #endif
> +       {
>                 page =3D pmd_page(old_pmd);
> +               if (pmd_dirty(old_pmd))
> +                       SetPageDirty(page);
> +               write =3D pmd_write(old_pmd);
> +               young =3D pmd_young(old_pmd);
> +               soft_dirty =3D pmd_soft_dirty(old_pmd);
> +       }
>         VM_BUG_ON_PAGE(!page_count(page), page);
>         page_ref_add(page, HPAGE_PMD_NR - 1);
> -       if (pmd_dirty(old_pmd))
> -               SetPageDirty(page);
> -       write =3D pmd_write(old_pmd);
> -       young =3D pmd_young(old_pmd);
> -       soft_dirty =3D pmd_soft_dirty(old_pmd);
>
>         /*
>          * Withdraw the table only after we mark the pmd entry invalid.=

>

This one should fix the issue. Thanks.

Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>
Fixes 84c3fc4e9c563 ("mm: thp: check pmd migration entry in common path")=


Do we need to cc: stable@vger.kernel.org # 4.14+ ?


--
Best Regards,
Yan Zi

--=_MailMate_966F3666-67DE-420C-A1F0-C9DF558AF115_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFKBAEBAgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlwQCwUWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzH95CACtq8kT1f0THn0zc/TqyPkJ0QQj
DFahFGDPc9r9blvsMOHKL+a5isU7Roe+E0G92FV7ylWvLzemN2Ec2rzNyxLHG8az
GtsVBW+J50Ke3cTprbRqbstQESMfsrSN6odygXQUD/WuPH9oWOAeFrObWAFahzfT
0n9sBv6I1EXUFC5hvb7LIzuKAo8Gly2+OjZiWbS+2lPOgmOTFEBzm9d1D8rZ82FA
Vp8b+2+5QFaDrBq8QnBli+oxH+gulTrWVbs9XNupkYBO02pi3iwUt4QyBCn5bfrJ
WTyjRZtb55gqWrmlTf53QL1msEyqLo2RTPbUsoctktaUpW1j/8vjffgjAzBe
=/u5Q
-----END PGP SIGNATURE-----

--=_MailMate_966F3666-67DE-420C-A1F0-C9DF558AF115_=--

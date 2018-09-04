Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A374820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A374820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeIDSZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:25:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38926 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDSZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:25:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so4025238qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=6d8oK52oDU3c4v/LizU2pC/wmIlrWoBqw7/YfyPTHLs=;
        b=ul7+H1JYJuPCEW3lkYDZVSbYRHSKajuL63Unys73NMMLgrWXbkqR+sp5c3FBjnC3QC
         wTZsqa535KtiQhMKvNUA56woUGOgA9OUXYB9K2szgM+0gpGfoxt24sQietwaG94zEGQn
         lY33POBW6eanevXqJMy4CRah5HMcpvf20+EPtCEsciZE9ouxOFPK7F9/XERXKpidcAZk
         Nu/msEKk9U6NpSEpGxdsANmJsxwva2SuBtyyEoiO+WDpzA/KCeR+EkOqDQhl1lpLTb09
         OacPOzw6+yXvplI0i//RWKxoMK14seCRYyL44GAsDp1DltCLDL6o2Be04bB3NPvPpvPg
         /25g==
X-Gm-Message-State: APzg51Bp65rcNwdmYcVRURHk5CYblKq8G25CmStbDANC+AjyEIjmMSqv
        0O5VF55H9qZ9HwGnkBf0wudrUQ==
X-Google-Smtp-Source: ANB0VdZYojNcAYtiAoXndRLQgxKSMS/OqZwdKHTex0VP68m71/+XloKJKBUnyRYjm0zFRA70f09jrQ==
X-Received: by 2002:aed:3b32:: with SMTP id p47-v6mr30490161qte.13.1536069628090;
        Tue, 04 Sep 2018 07:00:28 -0700 (PDT)
Received: from [172.25.138.20] (pool-128-6-37-67.nat.rutgers.edu. [128.6.37.67])
        by smtp.gmail.com with ESMTPSA id q18-v6sm12368210qtk.57.2018.09.04.07.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 07:00:26 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Peter Xu" <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Huang Ying" <ying.huang@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "=?utf-8?b?SsOpcsO0bWU=?= Glisse" <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Konstantin Khlebnikov" <khlebnikov@yandex-team.ru>,
        "Souptick Joarder" <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugepage: mark splitted page dirty when needed
Date:   Tue, 04 Sep 2018 10:00:28 -0400
X-Mailer: MailMate (2.0BETAr6116)
Message-ID: <D3B32B41-61D5-47B3-B1FC-77B0F71ADA47@cs.rutgers.edu>
In-Reply-To: <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
References: <20180904075510.22338-1-peterx@redhat.com>
 <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_00AD4CDF-164D-44D4-9FF2-9BB7F3A78B9B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_00AD4CDF-164D-44D4-9FF2-9BB7F3A78B9B_=
Content-Type: text/plain

On 4 Sep 2018, at 4:01, Kirill A. Shutemov wrote:

> On Tue, Sep 04, 2018 at 03:55:10PM +0800, Peter Xu wrote:
>> When splitting a huge page, we should set all small pages as dirty if
>> the original huge page has the dirty bit set before.  Otherwise we'll
>> lose the original dirty bit.
>
> We don't lose it. It got transfered to struct page flag:
>
> 	if (pmd_dirty(old_pmd))
> 		SetPageDirty(page);
>

Plus, when split_huge_page_to_list() splits a THP, its subroutine __split_huge_page()
propagates the dirty bit in the head page flag to all subpages in __split_huge_page_tail().

--
Best Regards
Yan Zi

--=_MailMate_00AD4CDF-164D-44D4-9FF2-9BB7F3A78B9B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJbjo/8AAoJEEGLLxGcTqbMOQwH/0Dqm8efQO5JjwZLEfJ72RER
Hi/IEMJNxCdcWacrHwUTlEcDc8Si36b83nU5ja0FZLMtT6erIFoprzPcY+0AeMkP
FIoDqREsQUd/1rZS5/w5xzWZP53tBKXGwJ3Du6r2OFv11+O+UdGPFBTgRMafg15h
dZ1UPQ+gZWV0jJ5/BDwHVkA7fLSKvOwlLKeIUOonaOZI/WkU7VA7jT3TAoaZPvYD
W9rf4JmEY0aZi69K5krMidhXTvn7o5GQ0f7bLrXWuxGDtlDCsZWGwrTpTTOSPomM
mJ8Nf85vsXdUwkM0VAtMcARJ4EffLfaN1OdNeXxh/7stS8x85jo81OWNEGSdXaU=
=I4oJ
-----END PGP SIGNATURE-----

--=_MailMate_00AD4CDF-164D-44D4-9FF2-9BB7F3A78B9B_=--

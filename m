Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E12520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeKJBPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:15:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36928 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeKJBPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:15:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so2192357qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=yacDC3JuCl38C2BFu988fyntgsFlryKh2rqAwtDxvYI=;
        b=Uci/dF3yMzavG882NkmITMRtpHyND27xW6bREzfjHewJlvM5RZGoep6WaIU0lpKd3M
         azpQ8Pgqzh0Kf2CJ01jzDhiyUv66gok/Mpmzb5RaL6v1uCPKj6vNP+Vc07lVX+eM6PST
         QOsxM47JCTs8jDEPRhkQo6seXcrEZx82EK9P/jz41/wb9TlFCrOhKFMytYyhV82IDcLt
         3HM+9YWegvZHolwD7Bx9GW7sw9Kn9VyvBHTPdclBr5TGpsw79Nac6k6AIweHOgKc4D+C
         00ZfYQMaK9xE/VeoMTVP5Q/47P5ctGV0VYPaF1L51SdNnTCOKO/OiZtaAC2Rg4cIAHgo
         4Q7Q==
X-Gm-Message-State: AGRZ1gJSJEURSVL/387L7b8Wd03lS5y0zDoL2tIH4a+Dimy0d/Drt6Qh
        u3du2qnuLVknObjOUuyU/G7yCg==
X-Google-Smtp-Source: AJdET5c8CYaSW5TuahPU6KOq9i+KjXF6qeQrjOCq70XIWOGa8Tu5EvCjLPipcJzmBJ+sSRWJeGd2cA==
X-Received: by 2002:ac8:520f:: with SMTP id r15mr8877032qtn.167.1541777650314;
        Fri, 09 Nov 2018 07:34:10 -0800 (PST)
Received: from [172.25.141.180] (pool-128-6-37-107.nat.rutgers.edu. [128.6.37.107])
        by smtp.gmail.com with ESMTPSA id q14-v6sm3598967qtl.65.2018.11.09.07.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 07:34:09 -0800 (PST)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Mel Gorman" <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Anthony Yznaga" <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        jglisse@redhat.com, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        minchan@kernel.org, peterz@infradead.org, rientjes@google.com,
        vbabka@suse.cz, willy@infradead.org, ying.huang@intel.com,
        nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Date:   Fri, 09 Nov 2018 10:34:07 -0500
X-Mailer: MailMate (1.12.1r5552)
Message-ID: <EEBCAF4D-138C-4CF7-B4B7-C55F1192A026@cs.rutgers.edu>
In-Reply-To: <20181109131128.GE23260@techsingularity.net>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109131128.GE23260@techsingularity.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_16C263ED-FC1F-46C8-ADD9-BAA932760252_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_16C263ED-FC1F-46C8-ADD9-BAA932760252_=
Content-Type: text/plain

On 9 Nov 2018, at 8:11, Mel Gorman wrote:

> On Fri, Nov 09, 2018 at 03:13:18PM +0300, Kirill A. Shutemov wrote:
>> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
>>> The basic idea as outlined by Mel Gorman in [2] is:
>>>
>>> 1) On first fault in a sufficiently sized range, allocate a huge page
>>>    sized and aligned block of base pages.  Map the base page
>>>    corresponding to the fault address and hold the rest of the pages in
>>>    reserve.
>>> 2) On subsequent faults in the range, map the pages from the reservation.
>>> 3) When enough pages have been mapped, promote the mapped pages and
>>>    remaining pages in the reservation to a huge page.
>>> 4) When there is memory pressure, release the unused pages from their
>>>    reservations.
>>
>> I haven't yet read the patch in details, but I'm skeptical about the
>> approach in general for few reasons:
>>
>> - PTE page table retracting to replace it with huge PMD entry requires
>>   down_write(mmap_sem). It makes the approach not practical for many
>>   multi-threaded workloads.
>>
>>   I don't see a way to avoid exclusive lock here. I will be glad to
>>   be proved otherwise.
>>
>
> That problem is somewhat fundamental to the mmap_sem itself and
> conceivably it could be alleviated by range-locking (if that gets
> completed). The other thing to bear in mind is the timing. If the
> promotion is in-place due to reservations, there isn't the allocation
> overhead and the hold times *should* be short.
>

Is it possible to convert all these PTEs to migration entries during
the promotion and replace them with a huge PMD entry afterwards?
AFAIK, migrating pages does not require holding a mmap_sem.
Basically, it will act like migrating 512 base pages to a THP without
actually doing the page copy.

--
Best Regards
Yan Zi

--=_MailMate_16C263ED-FC1F-46C8-ADD9-BAA932760252_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlvlqO8WHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzOsMCACj3xPbOIFF7BqEziJHcPZ1C6vI
vTSqfLtiihNb8cPqNbZa9tds6lYuGVW5dVopevbhcNbi5pQ39ZYKbPGFOTMCzcQ/
8k5wuMR8kJkA2RYrD8dN+3UrEChxEB0r35GH92X9kvwbS9Aqtp/G3ECqBBIInLq3
QeV+XpqQHydQvLhAN33dzxC7ounHlYTKaEEl5Ca6aD6/6A5YtYKEuGeNwZeP7aHk
jzts84ic+pNFXfodgp+pTLwwG37Kne/NB3QwuFmC5Oe5Y9lnjywYk9TlUjdZjVuk
98VW/c3EKRiIKkbabm61ZgtWdzCdpbEzj+GkvTIISluChzsg3WsrgywgBCXI
=9Ao+
-----END PGP SIGNATURE-----

--=_MailMate_16C263ED-FC1F-46C8-ADD9-BAA932760252_=--

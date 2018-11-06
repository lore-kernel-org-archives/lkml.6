Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D715C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173CF20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173CF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeKFMLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:11:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42616 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKFMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:11:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id u68so17575901qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 18:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=tWkkQcZrAQ+wJOwImR/zGkx9g74e2a16z7gakG/CuyQ=;
        b=iVnJDPcFM0C2fpS7voG+MQ8b0iw4LwGJbXcW31hAGjPcBXQMsgGoZGnhC4zFT0rn5Y
         IgmNJk5nK5NwYb01JQU91DfTAhPJ8fk34dKNecjOJzi+o0PJEgL86i9qXNMWiqbllx3I
         LYVlmVGDlH2UAy+XsFOhRQ1AQcwCswSPubkkHGKGg4/rZT6j8sg0Tjfxw/uxTcvMAYQU
         OEV7fm936W31GI0P+F4MM3onJwkExRFGpR5vY0rq0KJswgPEXyUxK9HQvhpj6gPs2BVb
         3OmU4gjyPs50rkdOGlkx+ltk79Z1qZ7KuXyOSzpI92+jc35yhrFHnfJwL2egerp2NjIo
         59lw==
X-Gm-Message-State: AGRZ1gLtwsb/bzFvVJ/aGR0k61MfEX60FoIxz+eknGCyCIcPdsmZk0Su
        dUcGSjfBgIPdT4hQdmcDIkzphA==
X-Google-Smtp-Source: AJdET5dGA8wmvZwTAPUG9xkmB6b6FqeOiK3au1T9fFBWBMZ+EM2ZG1cuexBdFnHvvgph2LkrxPJHgg==
X-Received: by 2002:a37:c304:: with SMTP id a4mr23335701qkj.269.1541472538820;
        Mon, 05 Nov 2018 18:48:58 -0800 (PST)
Received: from [192.168.1.153] (pool-173-54-33-167.nwrknj.fios.verizon.net. [173.54.33.167])
        by smtp.gmail.com with ESMTPSA id d78sm7210813qke.94.2018.11.05.18.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 18:48:57 -0800 (PST)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Daniel Jordan" <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Date:   Mon, 05 Nov 2018 21:48:56 -0500
X-Mailer: MailMate (1.12.1r5552)
Message-ID: <7E53DD63-4955-480D-8C0D-EB07E4FF011B@cs.rutgers.edu>
In-Reply-To: <20181106022024.ndn377ze6xljsxkb@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <FC2EB02D-3D05-4A13-A92E-4171B37B15BA@cs.rutgers.edu>
 <20181106022024.ndn377ze6xljsxkb@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_281B8E86-991E-4CD5-A12E-8C9D4D81AEF5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_281B8E86-991E-4CD5-A12E-8C9D4D81AEF5_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5 Nov 2018, at 21:20, Daniel Jordan wrote:

> Hi Zi,
>
> On Mon, Nov 05, 2018 at 01:49:14PM -0500, Zi Yan wrote:
>> On 5 Nov 2018, at 11:55, Daniel Jordan wrote:
>>
>> Do you think if it makes sense to use ktask for huge page migration (t=
he data
>> copy part)?
>
> It certainly could.
>
>> I did some experiments back in 2016[1], which showed that migrating on=
e 2MB page
>> with 8 threads could achieve 2.8x throughput of the existing single-th=
readed method.
>> The problem with my parallel page migration patchset at that time was =
that it
>> has no CPU-utilization awareness, which is solved by your patches now.=

>
> Did you run with fewer than 8 threads?  I'd want a bigger speedup than =
2.8x for
> 8, and a smaller thread count might improve thread utilization.

Yes. When migrating one 2MB THP with migrate_pages() system call on a two=
-socket server
with 2 E5-2650 v3 CPUs (10 cores per socket) across two sockets, here are=
 the page migration
throughput numbers:

             throughput       factor
1 thread      2.15 GB/s         1x
2 threads     3.05 GB/s         1.42x
4 threads     4.50 GB/s         2.09x
8 threads     5.98 GB/s         2.78x

>
> It would be nice to multithread at a higher granularity than 2M, too: a=
 range
> of THPs might also perform better than a single page.

Sure. But the kernel currently does not copy multiple pages altogether ev=
en if a range
of THPs is migrated. Page copy function is interleaved with page table op=
erations
for every single page.

I also did some study and modified the kernel to improve this, which I ca=
lled
concurrent page migration in https://lwn.net/Articles/714991/. It further=

improves page migration throughput.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_281B8E86-991E-4CD5-A12E-8C9D4D81AEF5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlvhARgWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzGuXB/0ZamMyImDvdSAnu6bnRamwxFic
UnxPMANlgt8DoHj33w6YPGNPvTLOpYT/23z3PC+p+GSE//6OBGlh92xBYALyynHf
MXdJ/VQPIC0HN8HrUyk5o9UzKDf4v6GJkJb29M0E2wA+XmOj8QOsQ0Hvxeyd7jA0
PAusVkLka9cnSJnACY7qqS7ybirJWeFcPFZx7hOH9U+I7kpwUQMBczv4Mx3ZWX5U
tOF2zTek/bglTVulJZwEm14d7iauZ4FqFQqMVobjSGnhvRvIDq4iJeAw4DaitBd4
e4KUl42KBLZ0Itat+o1uMmKfu4NQF2sXvmhhj+VSIvgs+3HlW//qixG+yDOS
=5hII
-----END PGP SIGNATURE-----

--=_MailMate_281B8E86-991E-4CD5-A12E-8C9D4D81AEF5_=--

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4E5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989292084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989292084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.rutgers.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeH1Tqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:46:54 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:37359 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeH1Tqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:46:54 -0400
Received: by mail-qt0-f169.google.com with SMTP id n6-v6so2258394qtl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ULrivplzvijngnfXc8kcf5S5EmJ5JQTWKEvugaMqklo=;
        b=LVaUFPty8X10T/eOxACYyoMYzKsTbJ9G8SqeHsYa+bvbC1ru8D73qgCQv+9B2ZlRJ5
         4XsUDqRubZCGLdGxGLgK2kB9j6zJ67sonoe+wdTBmpfM76nRPRtheFPd7Gc6bv9DPT0k
         +y1GhKUYcksFV+GKmBxJ8mUd5ViJbiWhxZTOwobTGWfizwGoZBNnja0paUum46fivPAg
         5gD+Jq9LBvRAx48IrNGqqZhK57YlxHQifpUdDl0rf+P9/bS82W/mZvdUT+2nq1QrYaV7
         IstPd89FRPefIXHgsUUmje8qLRgu8gTVQmB9jIpiLIr3R7fzbCfm6MJlaVQDyAmBqF6i
         gNLA==
X-Gm-Message-State: APzg51BYK1aSwBtPOyat/4doeCBcMgQgewtIuXah+qlBMFRLqQNnWrTc
        YBaokGQQtJripjfCZF2X1ziUkA==
X-Google-Smtp-Source: ANB0VdaQ4EWTj1exPgdrnMloKlRWghHviv79hUByPGLbOtNsIES4NjZz0DlFTK/3i8nksJTKP1RlXQ==
X-Received: by 2002:a0c:8b11:: with SMTP id q17-v6mr2206564qva.193.1535471675696;
        Tue, 28 Aug 2018 08:54:35 -0700 (PDT)
Received: from [172.31.148.180] (pool-128-6-36-211.nat.rutgers.edu. [128.6.36.211])
        by smtp.gmail.com with ESMTPSA id f53-v6sm844577qtk.40.2018.08.28.08.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:54:34 -0700 (PDT)
From:   "Zi Yan" <zi.yan@cs.rutgers.edu>
To:     "Michal Hocko" <mhocko@kernel.org>
Cc:     "Jerome Glisse" <jglisse@redhat.com>, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH 4/7] mm/hmm: properly handle migration pmd
Date:   Tue, 28 Aug 2018 11:54:33 -0400
X-Mailer: MailMate (1.11.3r5509)
Message-ID: <44C89854-FE83-492F-B6BB-CF54B77233CF@cs.rutgers.edu>
In-Reply-To: <20180828154555.GS10223@dhcp22.suse.cz>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-5-jglisse@redhat.com>
 <0560A126-680A-4BAE-8303-F1AB34BE4BA5@cs.rutgers.edu>
 <20180828152414.GQ10223@dhcp22.suse.cz> <20180828153658.GA4029@redhat.com>
 <20180828154206.GR10223@dhcp22.suse.cz>
 <20180828154555.GS10223@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_1C393E60-603F-4FB6-924E-D18DABFB8B6D_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_1C393E60-603F-4FB6-924E-D18DABFB8B6D_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On 28 Aug 2018, at 11:45, Michal Hocko wrote:

> On Tue 28-08-18 17:42:06, Michal Hocko wrote:
>> On Tue 28-08-18 11:36:59, Jerome Glisse wrote:
>>> On Tue, Aug 28, 2018 at 05:24:14PM +0200, Michal Hocko wrote:
>>>> On Fri 24-08-18 20:05:46, Zi Yan wrote:
>>>> [...]
>>>>>> +	if (!pmd_present(pmd)) {
>>>>>> +		swp_entry_t entry =3D pmd_to_swp_entry(pmd);
>>>>>> +
>>>>>> +		if (is_migration_entry(entry)) {
>>>>>
>>>>> I think you should check thp_migration_supported() here, since PMD =
migration is only enabled in x86_64 systems.
>>>>> Other architectures should treat PMD migration entries as bad.
>>>>
>>>> How can we have a migration pmd entry when the migration is not
>>>> supported?
>>>
>>> Not sure i follow here, migration can happen anywhere (assuming
>>> that something like compaction is active or numa or ...). So this
>>> code can face pmd migration entry on architecture that support
>>> it. What is missing here is thp_migration_supported() call to
>>> protect the is_migration_entry() to avoid false positive on arch
>>> which do not support thp migration.
>>
>> I mean that architectures which do not support THP migration shouldn't=

>> ever see any migration entry. So is_migration_entry should be always
>> false. Or do I miss something?
>
> And just to be clear. thp_migration_supported should be checked only
> when we actually _do_ the migration or evaluate migratability of the
> page. We definitely do want to sprinkle this check to all places where
> is_migration_entry is checked.

is_migration_entry() is a general check for swp_entry_t, so it can return=

true even if THP migration is not enabled. is_pmd_migration_entry() alway=
s
returns false when THP migration is not enabled.

So the code can be changed in two ways, either replacing is_migration_ent=
ry()
with is_pmd_migration_entry() or adding thp_migration_supported() check
like Jerome did.

Does this clarify your question?

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_1C393E60-603F-4FB6-924E-D18DABFB8B6D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQFKBAEBAgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAluFcDkWHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzFPqB/9X0AVYtyFl6ZEWgDJsRmWv5Kpb
fV8J8/qvQFyRcqFuGTCwSLg0aYCt6juJTd4nVoKvXdSKlzvD0gYgLC4y/qzrVrMq
H8/7OBX56gzUzkdvb36K67sYV40SI+vWZvpFt0+zNKYY24wdsMH6tInClmMjpqdW
T4uNwrjkRvsOZ/uvDYmnhNbSqAuY06YkgjVfpC2K4/lU9vq67OjodtlXg6KMYX2G
d8frSR81iRKedlirvVdGkjuqIgncmFLwxhFPAXfNWooU8Mn4BMD0zFnPS9dHUrik
PY1nSix9Xtb0S3+P9rEU/dYf08imf9EeCtMDuSykMlcteDwNQUsFx/rThqM5
=8vBu
-----END PGP SIGNATURE-----

--=_MailMate_1C393E60-603F-4FB6-924E-D18DABFB8B6D_=--

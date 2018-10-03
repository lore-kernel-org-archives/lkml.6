Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06051C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C69205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VuIgUyW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C69205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJCM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15215 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb4565a0000>; Tue, 02 Oct 2018 22:40:42 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Oct 2018 22:40:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Oct 2018 22:40:44 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 05:40:43 +0000
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com> <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
 <ed9cbf0a-acc9-1b26-a7fc-e8f89f577ce9@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e5ffa56e-ae51-6e2c-e6a9-efbdf9317ae0@nvidia.com>
Date:   Tue, 2 Oct 2018 22:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ed9cbf0a-acc9-1b26-a7fc-e8f89f577ce9@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538545242; bh=sbQDuTZBlzBbSLrvdK8h/ceTcjyAwuoMY+PheDn4qGw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VuIgUyW2FPp5DhvTbMLSsyPzBcEgk+eMWrV0A4WN3qdySWSOV2VjNEeZedvefXXXo
         fLW8UzRzuI4YyshZxiCp1TPJvUaXJaTU9jc91Cs0ceVsogpJkFyBL3V76vwzdhx72C
         hnhE4xYwig9Di5UteJynF9X2e5LXFvbJOxcipHVeBc0TlnKt318laN+cVOFFpjMVHY
         ZFEV9AlUqUDGg2bejwm0t/peY/Ze+oXdNomjsFj0Z5DduDzdOWoOjLOi6Ic8cSPBVf
         9B6j4rDAJV6qArjD5KcTogx8qTgSJmU+zH3uTW0vRiLA7wou1U9oEtj/vbxxEXtw8R
         3QOXv/KGvnveg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 7:35 AM, Dennis Dalessandro wrote:
> On 9/28/2018 11:12 PM, John Hubbard wrote:
>> On 9/28/18 8:39 AM, Jason Gunthorpe wrote:
>>> On Thu, Sep 27, 2018 at 10:39:47PM -0700, john.hubbard@gmail.com wrote:
>>>> From: John Hubbard <jhubbard@nvidia.com>
>> [...]
>>>>
>>>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/=
umem.c
>>>> index a41792dbae1f..9430d697cb9f 100644
>>>> +++ b/drivers/infiniband/core/umem.c
>>>> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev,=
 struct ib_umem *umem, int d
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D sg_pag=
e(sg);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PageDirty(=
page) && umem->writable && dirty)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 set_page_dirty_lock(page);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_page(page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_user_page(page);
>>>
>>> Would it make sense to have a release/put_user_pages_dirtied to absorb
>>> the set_page_dity pattern too? I notice in this patch there is some
>>> variety here, I wonder what is the right way?
>>>
>>> Also, I'm told this code here is a big performance bottleneck when the
>>> number of pages becomes very long (think >> GB of memory), so having a
>>> future path to use some kind of batching/threading sound great.
>>>
>>
>> Yes. And you asked for this the first time, too. Consistent! :) Sorry fo=
r
>> being slow to pick it up. It looks like there are several patterns, and
>> we have to support both set_page_dirty() and set_page_dirty_lock(). So
>> the best combination looks to be adding a few variations of
>> release_user_pages*(), but leaving put_user_page() alone, because it's
>> the "do it yourself" basic one. Scatter-gather will be stuck with that.
>>
>> Here's a differential patch with that, that shows a nice little cleanup =
in
>> a couple of IB places, and as you point out, it also provides the hooks =
for
>> performance upgrades (via batching) in the future.
>>
>> Does this API look about right?
>=20
> I'm on board with that and the changes to hfi1 and qib.
>=20
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Hi Dennis, thanks for the review!

I'll add those new routines in and send out a v2 soon, now that it appears,=
 from=20
the recent discussion, that this aspect of the approach is still viable.


thanks,
--=20
John Hubbard
NVIDIA

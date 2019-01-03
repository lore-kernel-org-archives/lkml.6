Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D9C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ABC20883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nPztcu9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfACDcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:32:10 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3020 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfACDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:32:09 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d822e0000>; Wed, 02 Jan 2019 19:31:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 19:32:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Jan 2019 19:32:09 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 03:32:08 +0000
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
To:     Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103015654.GB15619@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
Date:   Wed, 2 Jan 2019 19:32:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103015654.GB15619@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546486318; bh=23NzuESLX1gHN0Nzk+EsR1um0acr983rL396yItHNfI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nPztcu9il8NZDtfyeEOyH4zSOpluLu/Wj6wMjRgmg5AumTi9LkGUMgzlGWL1OmjJP
         WaE0Nl17kWvy16F2SA866kRcXxnURgonyLa8dse0PnhhoLedb0kXay7C+e0TJ2i1q+
         YIam9Xb3f3hGHRPEKT+uaBXzcFJajl6K3HsGGoMkmKp0+DQkgkFIV0n0gzW0iEasmF
         ZeWgwlXuy7GMDH+JxyPxPyiRrNn7IiNNfjuH3JxS3jzTRcPY8it6yPZDfwjC7fz6kA
         rjGroFNajnI6gh/uVqm26higWUdqCNQjeoTuDFzvfu1KjYVvqdxzMH43HCE6xbLBx6
         ArdVNwPHUpjvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 5:56 PM, Jerome Glisse wrote:
> On Wed, Jan 02, 2019 at 04:21:26PM -0800, Matthew Wilcox wrote:
>>
>> One of the paths in follow_pte_pmd() initialised the mmu_notifier_range
>> incorrectly.
>>
>> Signed-off-by: Matthew Wilcox <willy@infradead.org>
>> Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_rang=
e_start/end calls v2")
>> Tested-by: Dave Chinner <dchinner@redhat.com>
>=20
> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 2dd2f9ab57f4..21a650368be0 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4078,8 +4078,8 @@ static int __follow_pte_pmd(struct mm_struct *mm, =
unsigned long address,
>>  		goto out;
>> =20
>>  	if (range) {
>> -		range->start =3D address & PAGE_MASK;
>> -		range->end =3D range->start + PAGE_SIZE;
>> +		mmu_notifier_range_init(range, mm, address & PAGE_MASK,
>> +				     (address & PAGE_MASK) + PAGE_SIZE);
>>  		mmu_notifier_invalidate_range_start(range);
>>  	}
>>  	ptep =3D pte_offset_map_lock(mm, pmd, address, ptlp);
>=20

Looks correct to me, as well.

Having the range struct declared in separate places from the mmu_notifier_r=
ange_init()
calls is not great. But I'm not sure I see a way to make it significantly c=
leaner, given
that __follow_pte_pmd uses the range pointer as a way to decide to issue th=
e mmn calls.


thanks,
--=20
John Hubbard
NVIDIA

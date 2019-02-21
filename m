Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3544C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848E320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YllVBZsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBUAm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:42:59 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8061 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:42:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6df40f0000>; Wed, 20 Feb 2019 16:42:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 16:42:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 16:42:57 -0800
Received: from [10.2.169.124] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 00:42:56 +0000
Subject: Re: [PATCH 01/10] mm/hmm: use reference counting for HMM struct
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-2-jglisse@redhat.com>
 <1373673d-721e-a7a2-166f-244c16f236a3@nvidia.com>
 <20190220235933.GD11325@redhat.com>
 <dd448c6f-5ed7-ceb4-ca5e-c7650473a47c@nvidia.com>
 <20190221001557.GA24489@redhat.com>
 <58ab7c36-36dd-700a-6a66-8c9abbf4076a@nvidia.com>
 <20190221003716.GD24489@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1ccab0d3-7e90-8e39-074d-02ffbfc68480@nvidia.com>
Date:   Wed, 20 Feb 2019 16:42:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221003716.GD24489@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550709776; bh=zJjFztKuZcyHjRQdI0lnBbBKcCLEm7/jgvkf6lLt12o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YllVBZsEf42kejUVjFOuZvlb5cEgLEn85M+UZ5IXbtUwpmhqquuE7jXg4Ep+6Ga3Q
         cgBvFqdJt0+u+fjr1nHTECxaftPzm+rhY+OiINXtCV3f3X0ewglRsPrZe4ulQnPtlE
         YnJPJYyCvCEepAB9Z0qL4PQqlEHyZzZ9oj7TMC8aZZpDAyMZqRMbrxTz5UA77ynmmY
         AB4YW6HuF/q2t1sqauZC6JSJUUy7CTu2B/sgspaNSWTmc1ZSps1xvqlq7N2P6UYEDt
         m9ha/A3dZ+HmyEHyAMTBL2fhnmuA3e7kQf8WIPgU9uCxQiaCyUtsRhsTSHBM5ObB+6
         OhOjjDlSsXN+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 4:37 PM, Jerome Glisse wrote:
> On Wed, Feb 20, 2019 at 04:32:09PM -0800, John Hubbard wrote:
>> On 2/20/19 4:15 PM, Jerome Glisse wrote:
>>> On Wed, Feb 20, 2019 at 04:06:50PM -0800, John Hubbard wrote:
>>>> On 2/20/19 3:59 PM, Jerome Glisse wrote:
>>>>> On Wed, Feb 20, 2019 at 03:47:50PM -0800, John Hubbard wrote:
>>>>>> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
>>>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>>>>>
>>>>>>> Every time i read the code to check that the HMM structure does not
>>>>>>> vanish before it should thanks to the many lock protecting its remo=
val
>>>>>>> i get a headache. Switch to reference counting instead it is much
>>>>>>> easier to follow and harder to break. This also remove some code th=
at
>>>>>>> is no longer needed with refcounting.
>>>>>>
>>>>>> Hi Jerome,
>>>>>>
>>>>>> That is an excellent idea. Some review comments below:
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>>      static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>>>>>>>      			const struct mmu_notifier_range *range)
>>>>>>>      {
>>>>>>>      	struct hmm_update update;
>>>>>>> -	struct hmm *hmm =3D range->mm->hmm;
>>>>>>> +	struct hmm *hmm =3D hmm_get(range->mm);
>>>>>>> +	int ret;
>>>>>>>      	VM_BUG_ON(!hmm);
>>>>>>> +	/* Check if hmm_mm_destroy() was call. */
>>>>>>> +	if (hmm->mm =3D=3D NULL)
>>>>>>> +		return 0;
>>>>>>
>>>>>> Let's delete that NULL check. It can't provide true protection. If t=
here
>>>>>> is a way for that to race, we need to take another look at refcounti=
ng.
>>>>>
>>>>> I will do a patch to delete the NULL check so that it is easier for
>>>>> Andrew. No need to respin.
>>>>
>>>> (Did you miss my request to make hmm_get/hmm_put symmetric, though?)
>>>
>>> Went over my mail i do not see anything about symmetric, what do you
>>> mean ?
>>>
>>> Cheers,
>>> J=C3=A9r=C3=B4me
>>
>> I meant the comment that I accidentally deleted, before sending the emai=
l!
>> doh. Sorry about that. :) Here is the recreated comment:
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index a04e4b810610..b9f384ea15e9 100644
>>
>> --- a/mm/hmm.c
>>
>> +++ b/mm/hmm.c
>>
>> @@ -50,6 +50,7 @@
>>
>>   static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
>>
>>    */
>>   struct hmm {
>>   	struct mm_struct	*mm;
>> +	struct kref		kref;
>>   	spinlock_t		lock;
>>   	struct list_head	ranges;
>>   	struct list_head	mirrors;
>>
>> @@ -57,6 +58,16 @@
>>
>>   struct hmm {
>>
>>   	struct rw_semaphore	mirrors_sem;
>>   };
>>
>> +static inline struct hmm *hmm_get(struct mm_struct *mm)
>> +{
>> +	struct hmm *hmm =3D READ_ONCE(mm->hmm);
>> +
>> +	if (hmm && kref_get_unless_zero(&hmm->kref))
>> +		return hmm;
>> +
>> +	return NULL;
>> +}
>> +
>>
>> So for this, hmm_get() really ought to be symmetric with
>> hmm_put(), by taking a struct hmm*. And the null check is
>> not helping here, so let's just go with this smaller version:
>>
>> static inline struct hmm *hmm_get(struct hmm *hmm)
>> {
>> 	if (kref_get_unless_zero(&hmm->kref))
>> 		return hmm;
>>
>> 	return NULL;
>> }
>>
>> ...and change the few callers accordingly.
>>
>=20
> What about renaning hmm_get() to mm_get_hmm() instead ?
>=20

For a get/put pair of functions, it would be ideal to pass
the same argument type to each. It looks like we are passing
around hmm*, and hmm retains a reference count on hmm->mm,
so I think you have a choice of using either mm* or hmm* as
the argument. I'm not sure that one is better than the other
here, as the lifetimes appear to be linked pretty tightly.

Whichever one is used, I think it would be best to use it
in both the _get() and _put() calls.

thanks,
--=20
John Hubbard
NVIDIA

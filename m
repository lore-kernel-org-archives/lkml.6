Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31476C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F120F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Sd0fmcv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBUAHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:07:02 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12773 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBUAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:07:02 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6debad0000>; Wed, 20 Feb 2019 16:07:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 16:07:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 16:07:01 -0800
Received: from [10.2.169.124] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 00:07:01 +0000
Subject: Re: [PATCH 01/10] mm/hmm: use reference counting for HMM struct
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-2-jglisse@redhat.com>
 <1373673d-721e-a7a2-166f-244c16f236a3@nvidia.com>
 <20190220235933.GD11325@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <dd448c6f-5ed7-ceb4-ca5e-c7650473a47c@nvidia.com>
Date:   Wed, 20 Feb 2019 16:06:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220235933.GD11325@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550707630; bh=eHFy9PfcrCnSF/SWgKU6Hq+KR6rVxL7S4QtcBIPIFdc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Sd0fmcv8AHJsYYa0QYcFjRBBc11JP+WNMuzLD4aST0Vkq1RYC4/UKOhXVI08IiNL5
         k4mDB8X5wyFhRl4PVtO3czkeOVItapomv2sXbuWUXkvNJjPF2AAO6+AI086vPmHFXD
         +/w1wJGgxseQvk2Korr+EqxACfzbSKayM1HbN0n2pkwR9rsU91MpGOnNWUJ3W3VOtB
         oBykbtl9OsJ29t1Gnb4mEsM3v95uIUhb22sajJjq/FVcxBtXT26PgvyyASS3PXYJ9h
         ZOXzJClua/GwGKhsBqRJ+Tl/0BobuYQ2TcEI52vkXH9eFJlDWBF4zrk2VHpsJ+5vm4
         ORhYhmckWcCAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 3:59 PM, Jerome Glisse wrote:
> On Wed, Feb 20, 2019 at 03:47:50PM -0800, John Hubbard wrote:
>> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>
>>> Every time i read the code to check that the HMM structure does not
>>> vanish before it should thanks to the many lock protecting its removal
>>> i get a headache. Switch to reference counting instead it is much
>>> easier to follow and harder to break. This also remove some code that
>>> is no longer needed with refcounting.
>>
>> Hi Jerome,
>>
>> That is an excellent idea. Some review comments below:
>>
>> [snip]
>>
>>>    static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>>>    			const struct mmu_notifier_range *range)
>>>    {
>>>    	struct hmm_update update;
>>> -	struct hmm *hmm =3D range->mm->hmm;
>>> +	struct hmm *hmm =3D hmm_get(range->mm);
>>> +	int ret;
>>>    	VM_BUG_ON(!hmm);
>>> +	/* Check if hmm_mm_destroy() was call. */
>>> +	if (hmm->mm =3D=3D NULL)
>>> +		return 0;
>>
>> Let's delete that NULL check. It can't provide true protection. If there
>> is a way for that to race, we need to take another look at refcounting.
>=20
> I will do a patch to delete the NULL check so that it is easier for
> Andrew. No need to respin.

(Did you miss my request to make hmm_get/hmm_put symmetric, though?)

>=20
>> Is there a need for mmgrab()/mmdrop(), to keep the mm around while HMM
>> is using it?
>=20
> It is already the case. The hmm struct holds a reference on the mm struct
> and the mirror struct holds a reference on the hmm struct hence the mirro=
r
> struct holds a reference on the mm through the hmm struct.
>=20
>=20

OK, good. Yes, I guess the __mmu_notifier_register() call in hmm_register()
should get an mm_struct reference for us.

>=20
>>>    	/* FIXME support hugetlb fs */
>>>    	if (is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL) ||
>>>    			vma_is_dax(vma)) {
>>>    		hmm_pfns_special(range);
>>> +		hmm_put(hmm);
>>>    		return -EINVAL;
>>>    	}
>>> @@ -910,6 +958,7 @@ int hmm_vma_fault(struct hmm_range *range, bool blo=
ck)
>>>    		 * operations such has atomic access would not work.
>>>    		 */
>>>    		hmm_pfns_clear(range, range->pfns, range->start, range->end);
>>> +		hmm_put(hmm);
>>>    		return -EPERM;
>>>    	}
>>> @@ -945,7 +994,16 @@ int hmm_vma_fault(struct hmm_range *range, bool bl=
ock)
>>>    		hmm_pfns_clear(range, &range->pfns[i], hmm_vma_walk.last,
>>>    			       range->end);
>>>    		hmm_vma_range_done(range);
>>> +		hmm_put(hmm);
>>> +	} else {
>>> +		/*
>>> +		 * Transfer hmm reference to the range struct it will be drop
>>> +		 * inside the hmm_vma_range_done() function (which _must_ be
>>> +		 * call if this function return 0).
>>> +		 */
>>> +		range->hmm =3D hmm;
>>
>> Is that thread-safe? Is there anything preventing two or more threads fr=
om
>> changing range->hmm at the same time?
>=20
> The range is provided by the driver and the driver should not change
> the hmm field nor should it use the range struct in multiple threads.
> If the driver do stupid things there is nothing i can do. Note that
> this code is removed latter in the serie.
>=20
> Cheers,
> J=C3=A9r=C3=B4me
>=20

OK, I see. That sounds good.


thanks,
--=20
John Hubbard
NVIDIA


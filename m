Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10488C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D197A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F/hPjWEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBUAcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:32:21 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7914 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUAcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:32:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6df19a0000>; Wed, 20 Feb 2019 16:32:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 16:32:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 16:32:20 -0800
Received: from [10.2.169.124] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 00:32:20 +0000
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
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <58ab7c36-36dd-700a-6a66-8c9abbf4076a@nvidia.com>
Date:   Wed, 20 Feb 2019 16:32:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221001557.GA24489@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550709146; bh=AKUcMecDPS2lquqhV8jTYP7IySEpsg6I/IpRahqUuPs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F/hPjWEIiq0rtP83nPNcNfV8FCCM6rX4zsxgRjFcSEpGS2ULNyvbZQFmAL6opeuNR
         ufUCYvQyFKF47viLH5KO1NHkK0dj2nm98vG6S9FPNMoX6Coa9Hwvm/pJFuYgj54VQ3
         YeXtLqnWmginczAoEJaBVr16HrIG5DVqjnWerQrnurDvIYfVzCMa9ObjqNUjGZp2/X
         3tiz8HL9fHgHmGr9sJIqxQgHjks31tYennCS9woo1QDMygIXtzkdhmbFtOXo7PcHmT
         D/UbLLVOW9XaRMtl97qsVVmb5EYYDiKugdHGSJHsjSBetnKlQixNpgur0AF1tOIpOJ
         ABP7uFleOyODQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 4:15 PM, Jerome Glisse wrote:
> On Wed, Feb 20, 2019 at 04:06:50PM -0800, John Hubbard wrote:
>> On 2/20/19 3:59 PM, Jerome Glisse wrote:
>>> On Wed, Feb 20, 2019 at 03:47:50PM -0800, John Hubbard wrote:
>>>> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>>>
>>>>> Every time i read the code to check that the HMM structure does not
>>>>> vanish before it should thanks to the many lock protecting its remova=
l
>>>>> i get a headache. Switch to reference counting instead it is much
>>>>> easier to follow and harder to break. This also remove some code that
>>>>> is no longer needed with refcounting.
>>>>
>>>> Hi Jerome,
>>>>
>>>> That is an excellent idea. Some review comments below:
>>>>
>>>> [snip]
>>>>
>>>>>     static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>>>>>     			const struct mmu_notifier_range *range)
>>>>>     {
>>>>>     	struct hmm_update update;
>>>>> -	struct hmm *hmm =3D range->mm->hmm;
>>>>> +	struct hmm *hmm =3D hmm_get(range->mm);
>>>>> +	int ret;
>>>>>     	VM_BUG_ON(!hmm);
>>>>> +	/* Check if hmm_mm_destroy() was call. */
>>>>> +	if (hmm->mm =3D=3D NULL)
>>>>> +		return 0;
>>>>
>>>> Let's delete that NULL check. It can't provide true protection. If the=
re
>>>> is a way for that to race, we need to take another look at refcounting=
.
>>>
>>> I will do a patch to delete the NULL check so that it is easier for
>>> Andrew. No need to respin.
>>
>> (Did you miss my request to make hmm_get/hmm_put symmetric, though?)
>=20
> Went over my mail i do not see anything about symmetric, what do you
> mean ?
>=20
> Cheers,
> J=C3=A9r=C3=B4me

I meant the comment that I accidentally deleted, before sending the email!
doh. Sorry about that. :) Here is the recreated comment:

diff --git a/mm/hmm.c b/mm/hmm.c
index a04e4b810610..b9f384ea15e9 100644

--- a/mm/hmm.c

+++ b/mm/hmm.c

@@ -50,6 +50,7 @@

  static const struct mmu_notifier_ops hmm_mmu_notifier_ops;

   */
  struct hmm {
  	struct mm_struct	*mm;
+	struct kref		kref;
  	spinlock_t		lock;
  	struct list_head	ranges;
  	struct list_head	mirrors;

@@ -57,6 +58,16 @@

  struct hmm {

  	struct rw_semaphore	mirrors_sem;
  };

+static inline struct hmm *hmm_get(struct mm_struct *mm)
+{
+	struct hmm *hmm =3D READ_ONCE(mm->hmm);
+
+	if (hmm && kref_get_unless_zero(&hmm->kref))
+		return hmm;
+
+	return NULL;
+}
+

So for this, hmm_get() really ought to be symmetric with
hmm_put(), by taking a struct hmm*. And the null check is
not helping here, so let's just go with this smaller version:

static inline struct hmm *hmm_get(struct hmm *hmm)
{
	if (kref_get_unless_zero(&hmm->kref))
		return hmm;

	return NULL;
}

...and change the few callers accordingly.

thanks,
--=20
John Hubbard
NVIDIA


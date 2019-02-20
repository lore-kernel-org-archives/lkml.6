Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E33C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C6520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eeREBfQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBTWkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:40:33 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18678 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfBTWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:40:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6dd7650000>; Wed, 20 Feb 2019 14:40:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 14:40:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 14:40:31 -0800
Received: from [10.2.169.124] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 22:40:30 +0000
Subject: Re: [PATCH 10/10] mm/hmm: add helpers for driver to safely take the
 mmap_sem
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-11-jglisse@redhat.com>
 <16e62992-c937-6b05-ae37-a287294c0005@nvidia.com>
 <20190220221933.GB29398@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <41888fd2-6154-4f85-7949-7a59c434d047@nvidia.com>
Date:   Wed, 20 Feb 2019 14:40:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220221933.GB29398@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550702437; bh=3YmVsn1xjix5KcAoIKQqJBJt7OBuvYd0dgjyNItw0t0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eeREBfQx4+0jbaUJhdAhoJoIvh9Nufbr8sMxBdLSkwJdNk+Ks9zyMef+LAUWNxe6r
         2zNEUqxO4yy5q8/vke3L+xNRj6XwRQOMygozBpIm3P6oMaH0Kuk15c47J2AIjmKq2C
         jCuAGJrGnawuDBDz6E2+ea0lgGFum7T1Xe5l/1wNk43fJUwOCacNnVWS2OlZP8d2BI
         l785uPOCmKr8DqE8oAOo9SjVO8IvoVXnj7EBbCOOQ/U6xcEeNT57l+LkaeQkN7UG1p
         AIcqNfmVm+2Qom+LSOllG1JrSBn7nOOQ+SK45rFGR06w5v7kgUiVQszV0pz86UfEPR
         8aBaYo6ECp7Ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 2:19 PM, Jerome Glisse wrote:
> On Wed, Feb 20, 2019 at 01:59:13PM -0800, John Hubbard wrote:
>> On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>
>>> The device driver context which holds reference to mirror and thus to
>>> core hmm struct might outlive the mm against which it was created. To
>>> avoid every driver to check for that case provide an helper that check
>>> if mm is still alive and take the mmap_sem in read mode if so. If the
>>> mm have been destroy (mmu_notifier release call back did happen) then
>>> we return -EINVAL so that calling code knows that it is trying to do
>>> something against a mm that is no longer valid.
>>>
>>> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>    include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++-=
--
>>>    1 file changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>>> index b3850297352f..4a1454e3efba 100644
>>> --- a/include/linux/hmm.h
>>> +++ b/include/linux/hmm.h
>>> @@ -438,6 +438,50 @@ struct hmm_mirror {
>>>    int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct =
*mm);
>>>    void hmm_mirror_unregister(struct hmm_mirror *mirror);
>>> +/*
>>> + * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
>>> + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
>>> + * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
>>> + *
>>> + * The device driver context which holds reference to mirror and thus =
to core
>>> + * hmm struct might outlive the mm against which it was created. To av=
oid every
>>> + * driver to check for that case provide an helper that check if mm is=
 still
>>> + * alive and take the mmap_sem in read mode if so. If the mm have been=
 destroy
>>> + * (mmu_notifier release call back did happen) then we return -EINVAL =
so that
>>> + * calling code knows that it is trying to do something against a mm t=
hat is
>>> + * no longer valid.
>>> + */
>>
>> Hi Jerome,
>>
>> Are you thinking that, throughout the HMM API, there is a problem that
>> the mm may have gone away, and so driver code needs to be littered with
>> checks to ensure that mm is non-NULL? If so, why doesn't HMM take a
>> reference on mm->count?
>>
>> This solution here cannot work. I think you'd need refcounting in order
>> to avoid this kind of problem. Just doing a check will always be open to
>> races (see below).
>>
>>
>>> +static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)
>>> +{
>>> +	struct mm_struct *mm;
>>> +
>>> +	/* Sanity check ... */
>>> +	if (!mirror || !mirror->hmm)
>>> +		return -EINVAL;
>>> +	/*
>>> +	 * Before trying to take the mmap_sem make sure the mm is still
>>> +	 * alive as device driver context might outlive the mm lifetime.
>>> +	 *
>>> +	 * FIXME: should we also check for mm that outlive its owning
>>> +	 * task ?
>>> +	 */
>>> +	mm =3D READ_ONCE(mirror->hmm->mm);
>>> +	if (mirror->hmm->dead || !mm)
>>> +		return -EINVAL;
>>> +
>>
>> Nothing really prevents mirror->hmm->mm from changing to NULL right here=
.
>=20
> This is really just to catch driver mistake, if driver does not call
> hmm_mirror_unregister() then the !mm will never be true ie the
> mirror->hmm->mm can not go NULL until the last reference to hmm_mirror
> is gone.

In that case, then this again seems unnecessary, and in fact undesirable.
If the driver code has a bug, then let's let the backtrace from a NULL
dereference just happen, loud and clear.

This patch, at best, hides bugs. And it adds code that should simply be
unnecessary, so I don't like it. :)  Let's make it go away.

>=20
>>
>>> +	down_read(&mm->mmap_sem);
>>> +	return 0;
>>> +}
>>> +
>>
>> ...maybe better to just drop this patch from the series, until we see a
>> pattern of uses in the calling code.
>=20
> It use by nouveau now.

Maybe you'd have to remove that use case in a couple steps, depending on th=
e
order that patches are going in.


thanks,
--=20
John Hubbard
NVIDIA

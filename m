Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC020C09
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDC020C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeHWPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbeHWPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:22:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBoP1n121163
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:53:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1ur19m5u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:53:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Aug 2018 12:53:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:53:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBr7qj37683408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:53:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D46084C059;
        Thu, 23 Aug 2018 14:53:08 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F824C04A;
        Thu, 23 Aug 2018 14:53:08 +0100 (BST)
Received: from [9.152.224.110] (unknown [9.152.224.110])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 14:53:08 +0100 (BST)
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
To:     pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Thu, 23 Aug 2018 13:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J"
X-TM-AS-GCONF: 00
x-cbid: 18082311-0012-0000-0000-0000029DA96C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0013-0000-0000-000020D0F115
Message-Id: <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J
Content-Type: multipart/mixed; boundary="WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
In-Reply-To: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>

--WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 1:47 PM, Pierre Morel wrote:
> On 23/08/2018 13:33, Janosch Frank wrote:
>> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>>> On 23.08.2018 13:05, Janosch Frank wrote:
>>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>>> The comment preceding the shadow_crycb function is
>>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>>> guest.
>>>>
>>>> I beg to differ:
>>>>
>>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>>> 		return 0;
>>>
>>> FORMAT2 includes bit FORMAT1 (backwards compatible)
>>
>> Right, this check is very misleading because of the constant, we
>> effectively test against Format 0 and Format 2.
>>
>> Can we make this clearer by explicitly ANDing 0x01 or adding a comment=
?
>=20
> yes, done, I modified the comment in front of the function.

Which is not what I want, what I want is:

/* CRYCB_FORMAT2 includes the bit for CRYCB_FORMAT1, so we allow both
formats here */
if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
	return 0;

>=20
>>
>> Code makes sense:
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>=20
> Thanks,
>=20
> regards,
> Pierre
>=20
>>
>>>
>>>>
>>>>>
>>>>> When using FORMAT2 in the host we do not need to or with
>>>>> FORMAT1.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>   arch/s390/kvm/vsie.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>> index 38ea5da..e0e6fbf 100644
>>>>> --- a/arch/s390/kvm/vsie.c
>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vc=
pu, struct vsie_page *vsie_page)
>>>>>    * Create a shadow copy of the crycb block and setup key wrapping=
, if
>>>>>    * requested for guest 3 and enabled for guest 2.
>>>>>    *
>>>>> - * We only accept format-1 (no AP in g2), but convert it into form=
at-2
>>>>> + * We accept format-1 or format-2, but we treat it as a format-1 (=
no AP in g2),
>>>>> + * and we convert it into format-2 in the shadow CRYCB.
>>>>>    * There is nothing to do for format-0.
>>>>>    *
>>>>>    * Returns: - 0 if shadowed or nothing to do
>>>>> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, =
struct vsie_page *vsie_page)
>>>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>>>  =20
>>>>>   	scb_s->ecb3 |=3D ecb3_flags;
>>>>> -	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORM=
AT1 |
>>>>> -			CRYCB_FORMAT2;
>>>>> +	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORM=
AT2;
>>>>
>>>> That's purely cosmetic but valid.
>>>>
>>>>>  =20
>>>>>   	/* xor both blocks in one run */
>>>>>   	b1 =3D (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;=

>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>
>>
>>
>=20
>=20



--WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy--

--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfqAiAAoJEBcO/8Q8ZEV5dqMP/inmsp5Fw/ifYd22PYsX6ExS
1O/dToGFGBI/7d09hsmZi7+wWiTbNDR9sIeRFo1cXuwx15aX/XEmwPxmcRlG8xdq
J/MJinsjzGdzHvJ6lZPLQuG7So+pv2Rzf84eNjU/T2sua+OaAbt64j7KZZeW+PXP
DDz5L8Zi7BgQwBLPmsMUyUBfR8k/7wiN+bM3odgT4SQEYVW7EmZOFuzMCL8ZsGkB
WKfoUkuQVtI76I4k/tyLYHFvrya0mgely+ZnMGztEJbt9I7UHm6ztqDBdSSqIAmj
47R0QZjYQ2NMC2DIQpzCvR3TUzhwJV4pXwBlDME8okhiWpbOeeWMRLnHZF1BvOYH
hUmJI13oPQ7yXg8bCV/3wqYf3fp4ewFli7hgqrMf/9QDjtdJbeV0tpLyJScz9fAd
zAPBtJrVKLySw7J6fwK9+1nbwLBq2/gKPVsvXeuygHUjAzfYiH6tBg1byUNndRq7
x46j4EvcQB5G2hIrKykqqDfSnY+OuTzsm7Gu9OyyoQV/l3nVyCLj+fjRVbkLEIhY
y/NBC5jqnu66Kr81GXvstQ82g7JOeK+oexOkSZAPR+KJmUHYHi5jYR7puckoNbOq
DUGZlnKUbKSIT6AmSvs8+cWqM6qUCNZqwSg0C5qR+dFsZUAbyiVy8phynZSdmd1T
SDamcfcUaJ0lzVvIm5KR
=j6sh
-----END PGP SIGNATURE-----

--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J--


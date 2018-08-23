Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0840C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E5E2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E5E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbeHWMDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:03:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729381AbeHWMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:03:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N8TNgB003367
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:34:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1s22h95a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:34:57 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Aug 2018 09:34:55 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 09:34:52 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N8YpMu44105978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 08:34:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DA1252051;
        Thu, 23 Aug 2018 11:34:50 +0100 (BST)
Received: from [9.152.224.110] (unknown [9.152.224.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5755D52052;
        Thu, 23 Aug 2018 11:34:50 +0100 (BST)
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
To:     pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
 <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Thu, 23 Aug 2018 10:34:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qkLBoYML5S8TfzTK1q0ZMhdMbYWldEfBp"
X-TM-AS-GCONF: 00
x-cbid: 18082308-0020-0000-0000-000002BA985A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082308-0021-0000-0000-00002107F2E0
Message-Id: <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qkLBoYML5S8TfzTK1q0ZMhdMbYWldEfBp
Content-Type: multipart/mixed; boundary="Ft4YwRXyiRFxq10vQVyEn1XSDgibpsvvp";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
 <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
In-Reply-To: <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>

--Ft4YwRXyiRFxq10vQVyEn1XSDgibpsvvp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.2018 10:01, Pierre Morel wrote:
> On 23/08/2018 09:31, David Hildenbrand wrote:
>> On 23.08.2018 09:17, Pierre Morel wrote:
>>> On 22/08/2018 19:15, David Hildenbrand wrote:
>>>> On 22.08.2018 18:51, Pierre Morel wrote:
>>>>> When entering the SIE the CRYCB validation better
>>>>> be done independently of the instruction's
>>>>> availability.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>    arch/s390/kvm/vsie.c | 11 ++++++-----
>>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>> index 7ee4329..fca25aa 100644
>>>>> --- a/arch/s390/kvm/vsie.c
>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>> @@ -164,17 +164,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu=
, struct vsie_page *vsie_page)
>>>>>    	/* format-1 is supported with message-security-assist extension=
 3 */
>>>>>    	if (!test_kvm_facility(vcpu->kvm, 76))
>>>>>    		return 0;
>>>>> -	/* we may only allow it if enabled for guest 2 */
>>>>> -	ecb3_flags =3D scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>> -		     (ECB3_AES | ECB3_DEA);
>>>>> -	if (!ecb3_flags)
>>>>> -		return 0;
>>>>>   =20
>>>>>    	if ((crycb_addr & PAGE_MASK) !=3D ((crycb_addr + 128) & PAGE_MA=
SK))
>>>>>    		return set_validity_icpt(scb_s, 0x003CU);
>>>>>    	if (!crycb_addr)
>>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>>   =20
>>>>> +	/* we may only allow it if enabled for guest 2 */
>>>>> +	ecb3_flags =3D scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>> +		     (ECB3_AES | ECB3_DEA);
>>>>> +	if (!ecb3_flags)
>>>>> +		return 0;
>>>>> +
>>>>>    	/* copy only the wrapping keys */
>>>>>    	if (read_guest_real(vcpu, crycb_addr + 72,
>>>>>    			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>>>
>>>>
>>>> That makes sense, especially if ECB3_AES is used but effectively tur=
ned
>>>> off by us.
>>>>
>>>> What is the expected behavior if ECB3_AES | ECB3_DEA are not set by =
g2
>>>> for g3?
>>>>
>>>
>>> The use of functions PCKMO-Encrypt-DEA/AES induce a specification err=
or.
>>>
>>> However other MSA3 function will continue to be usable.
>>
>> No, I meant which checks should be performed here.
>=20
> The SIE should check the validity of the CRYCB.
>=20
> However since we do not copy the key masks we do not
> expect any access error on crycb_o
>=20
> So it is more a philosophical problem, should the
> hypervizor enforce an error here to act as the firmware?

No it's not philosophical, that's actually regulated in the SIE
documentation for the validity intercepts.

CRYCB is checked if (any of these is true): ECA.28, CRYCB Format is one,
APXA installed and CRYCB Format field is three.

ECB3 AES/DEA bits are handled like the matrix, i.e. they are ANDed over
the different levels.

If that's still not what David meant to ask, then I must apologize for
my caffeine deprived brain.

>=20
>=20
> regards,
> Pierre
>=20
>=20
>=20



--Ft4YwRXyiRFxq10vQVyEn1XSDgibpsvvp--

--qkLBoYML5S8TfzTK1q0ZMhdMbYWldEfBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfnGqAAoJEBcO/8Q8ZEV5RuUP/0DN/cRziGShfmH/zKolQOeK
f2kZkwyffbZbLHrrWHjC1cDqELLJX3Ggib5zlDArWyxaaZpu4VlOADHWw9b7EGAd
4tn/9kvBj6YYUA4040LOUhnDdJzSFVzlaX4wOz70aL1fF2ifKDHyOcdmXp5nCNtr
sPzCn0QKhyOodAmZWEqQzjhuad5+oYONyox7HXzHIsnkWEQ4VvMN3LEsi75HTICV
tccoHs+70YTMBfkycGBVlv5maD4S82cVM0hQ4U1wSx0n2bQC/bW1B9dTotBucyU0
1bPOCKlfTJJVkeW6XdVZhUrG9N36h6VGxe5iDHJyJV6xjgGffGAI6uCoK82hc7Do
djx9ixBro0TvQCUIHJ6GB3TCmyRdAVjyXyoPtsVCrlLC2SbF/oFi4Y+uu0g4V4BB
6l+PtxM63HJiiurPqmiqTVWPyAzzYFN434yCilnvEIYlz612Y6sNO38jA7iHD6vD
e6jnr3TCtn5KFl2rMR9D7a93TtUhsqK2+PCqo0nHBeD0WQ22uoL9+nbpH/Xvj6rC
EW7GxBJ13Pp8pFGGMSn2pYxZHSYF/DNACI8IvOOB5AQtNARSVk1PluFSB7ZNwN0E
Q/FJGCmkltoVvYtjodmicBAnveWXma6+J24oJulNd6ljqnky2Tx9e4Ro8dOFphx3
itYVCjWIRTmzmZXFjYtJ
=d7hL
-----END PGP SIGNATURE-----

--qkLBoYML5S8TfzTK1q0ZMhdMbYWldEfBp--


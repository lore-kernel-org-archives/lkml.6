Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800D2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfBDQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:17:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbfBDQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:17:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14GE3Wg063489
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 11:17:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qeq72dc7p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:17:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 4 Feb 2019 16:17:35 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 16:17:32 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14GHUfD8454530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 16:17:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFE3F42041;
        Mon,  4 Feb 2019 16:17:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48BB042045;
        Mon,  4 Feb 2019 16:17:30 +0000 (GMT)
Received: from [9.145.21.68] (unknown [9.145.21.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Feb 2019 16:17:30 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
To:     David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
 <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
 <ccdc89cd-5299-e674-3329-74e9131dd874@redhat.com>
 <3bb397e9-d679-1152-1b42-d633682b3272@linux.ibm.com>
 <4d3977bf-63ec-5732-b2fc-ea8654f444e3@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 4 Feb 2019 17:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4d3977bf-63ec-5732-b2fc-ea8654f444e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020416-0008-0000-0000-000002BAFEBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020416-0009-0000-0000-000022270DA4
Message-Id: <206f8cb5-2be8-9c54-eafb-1a050e71aebc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2019 16:15, David Hildenbrand wrote:
> On 01.02.19 14:37, Pierre Morel wrote:
>> On 01/02/2019 11:56, David Hildenbrand wrote:
>>> On 01.02.19 10:52, Pierre Morel wrote:
>>>> The case when the SIE for guest3 is not setup for using
>>>> encryption keys nor Adjunct processor but the guest2
>>>> does use these features was not properly handled.
>>>>
>>>> This leads SIE entry for guest3 to crash with validity intercept
>>>> because the guest2, not having the use of encryption keys nor
>>>> Adjunct Processor did not initialize the CRYCB designation.
>>>>
>>>> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
>>>> are set in guest3 a format 0 CRYCB is allowed for guest3
>>>> and the CRYCB designation in the SIE for guest3 is not checked
>>>> on SIE entry.
>>>>
>>>> Let's allow the CRYCD designation to be ignored when the
>>>> SIE for guest3 is not initialized for encryption key usage
>>>> nor AP.
>>>>
>>>> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>> ---
>>>>    arch/s390/kvm/vsie.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>> index a153257..a748f76 100644
>>>> --- a/arch/s390/kvm/vsie.c
>>>> +++ b/arch/s390/kvm/vsie.c
>>>> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>    	if (!apie_h && !key_msk)
>>>>    		return 0;
>>>>    
>>>> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
>>>> +		return 0;
>>>> +
>>>>    	if (!crycb_addr)
>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>    
>>>>
>>>
>>> The original patch said
>>>
>>> "We need to handle the validity checks for the crycb, no matter what the
>>>    settings for the keywrappings are. So lets move the keywrapping checks
>>>    after we have done the validy checks."
>>>
>>> Can you explain why keywrapping now is important? These patches seem to
>>> contradict.
>>>
>>
>> No it does not, having the flags set or not is part of the validity check.
>> but, I acted too fast.
>>
>> The problem seems to be even clearer:
>> key_msk is defined as
>>      int key_msk = test_kvm_facility(vcpu->kvm, 76);
>>
>> If it is defined, as it should for a mask, as
>> 	(scb_o->ecb3 & (ECB3_AES | ECB3_DEA))
>>
>> all is clear..., key_msk is not use but for this test, so I do not
>> understand why it is set as facility 76.
>>
>> so I think I better do:
>>
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index a153257..30843a8 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -289,7 +289,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu,
>> struct vsie_page *vsie_page)
>>           unsigned long *b1, *b2;
>>           u8 ecb3_flags;
>>           int apie_h;
>> -       int key_msk = test_kvm_facility(vcpu->kvm, 76);
>> +       int key_msk = scb_o->ecb3 & (ECB3_AES | ECB3_DEA);
>>           int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
>>           int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>>           int ret = 0;
>>
>>
>> So just define a mask a mask.
>> I verify the functionality and test on Monday  and if in between it
>> seems better to you so too I post the patch.
> 
> Without documentation at hand I cannot really judge what is the right
> approach. You have to read the architecture description very carefully
> and thimk about the different scenarios. I cannot help here.
> 
> test_kvm_facility(vcpu->kvm, 76) means "hardware knows key wrapping exists"
> 
> scb_o->ecb3 & (ECB3_AES | ECB3_DEA) means "key wrapping was actually
> enabled for AES or DEA"


Right.
We also must take care of the format.
So not sure my propositions are right.
And helas I have the documentation :)
So ... I have to read it again again.


Regards,
Pierre

> 
>>
>> Thanks,
>> Pierre
>>
> 
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany


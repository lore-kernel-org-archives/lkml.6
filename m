Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F708C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA13206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA13206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeHVMFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:05:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727985AbeHVMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:05:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7M8YWbG102783
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:41:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m13gqtatd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:41:40 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Aug 2018 09:41:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 09:41:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7M8fZk437552352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 08:41:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 331E1A405E;
        Wed, 22 Aug 2018 11:41:35 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEC98A4040;
        Wed, 22 Aug 2018 11:41:34 +0100 (BST)
Received: from [9.152.224.111] (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 11:41:34 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 22 Aug 2018 10:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082208-0008-0000-0000-000002651151
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082208-0009-0000-0000-000021CD52E3
Message-Id: <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 10:25, David Hildenbrand wrote:
> On 22.08.2018 10:08, Pierre Morel wrote:
>> Currently when shadowing the CRYCB on SIE entrance, the validation
>> tests the following:
>> - accept only FORMAT1 or FORMAT2
>> - test if MSAext facility (76) is installed
>> - accept the CRYCB if no keys are used
>> - verifies that the CRYCB format1 is inside a page
>> - verifies that the CRYCB origin is not 0
>>
>> This is not following the architecture.
> I have to trust you on that :)
>
>> On SIE entrance, the CRYCB must be validated before accepting
>> any of its entries.
>>
>> Let's do the validation in the right order and also verify
>> correctly the FORMAT2 CRYCB.
> With which facility was FORMAT2 introduced?
With APXA.
KVM initialization setup CRYCB format according to the presence
of APXA for FORMAT2 or FORMAT1

>
> Does MSA3 imply that FORMAT2 can be used? (even if AP is absent)

Not exactly.
If AP is absent FORMAT2 may be defined, independently of MSA3 but the SIE
silently ignore bit 30 i.e. using a FORMAT1 instead

>
> FORMAT2 is backwards compatible to FORMAT1,

For what MSA3 implies yes.

>
>> The testing of facility MSAext3 (76) is not useful as it is
>> already tested by kvm_crypto_init() to set FORMAT1.
> Indeed, having FORMAT1 in g1 implies that.
>
>> The testing of a null CRYCB origin must be done what ever
>> the format of the guest3 CRYCB is.
>>
>> The CRYCB must be contained inside a page, but the CRYCB size
>> depends on the CRYCB format.
>> Lets test what the guest2 initialized, we can not trust it to have
>> done things right.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 35 +++++++++++++++++++++++++----------
>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index a2b28cd..35c3907 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -158,28 +158,43 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	scb_s->crycbd = 0;
>>   	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>   		return 0;
>> -	/* format-1 is supported with message-security-assist extension 3 */
>> -	if (!test_kvm_facility(vcpu->kvm, 76))
>> -		return 0;
>> +	/*
>> +	 * If APIE is set or it the CRYCB Format is FORMAT1 or FORMAT2 with
>> +	 * APXA installed, the machine checks the validity of crycb origin.
>> +	 * KVM kvm_s390_crypto_init() makes sure that FORMAT2 is only used
>> +	 * if APXA is installed.
>> +	 * The guest2 hypervizor could have set APIE and Format2 so let's
>> +	 * test all these points.
>> +	 * We here have always a CRYCB FORMAT1 or FORMAT2 (FORMAT0 was
>> +	 * refused in previous test).
> Can you shorten that comment and leave out all stuff to be added next?
> (APIE, APXA ...). I guess this whole comment is to be left out of this
> patch.
OK
>
>> +	 */
>> +	if (!crycb_addr)
>> +		return set_validity_icpt(scb_s, 0x0039U);
>> +
>> +	if ((crycbd_o & 0x03) == CRYCB_FORMAT1)
> Can you instead of 0x03 define CRYCB_FORMAT_MASK
OK

>
>> +		if ((crycb_addr & PAGE_MASK) !=
>> +		   ((crycb_addr + 128) & PAGE_MASK))
> please add one space in front of the second line to properly indent
yes
>
>> +			return set_validity_icpt(scb_s, 0x003CU);
>> +
>> +	if ((crycbd_o & 0x03) == CRYCB_FORMAT2)
>> +		if ((crycb_addr & PAGE_MASK) !=
>> +		   ((crycb_addr + 256) & PAGE_MASK))
> dito
yes :)

>
>> +			return set_validity_icpt(scb_s, 0x003CU);
>> +
>>   	/* we may only allow it if enabled for guest 2 */
>>   	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>   		     (ECB3_AES | ECB3_DEA);
>>   	if (!ecb3_flags)
>>   		return 0;
>>   
>> -	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>> -		return set_validity_icpt(scb_s, 0x003CU);
>> -	else if (!crycb_addr)
>> -		return set_validity_icpt(scb_s, 0x0039U);
>> -
>>   	/* copy only the wrapping keys */
>>   	if (read_guest_real(vcpu, crycb_addr + 72,
>>   			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>   		return set_validity_icpt(scb_s, 0x0035U);
>>   
>>   	scb_s->ecb3 |= ecb3_flags;
>> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
>> -			CRYCB_FORMAT2;
>> +	/* Set the shadow CRYCB format to format 2 */
> I don't consider this comment helpful (CRYCB_FORMAT2 below is at least
> obvious to me) - CRYCB_FORMAT2 implies CRYCB_FORMAT1 (what the existing
> code did not consider)

OK, I still let the simplification below.

>
>> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
>>   
>>   	/* xor both blocks in one run */
>>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>>
> Thanks for looking into this.
>
Thanks for the comments

best regards,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany


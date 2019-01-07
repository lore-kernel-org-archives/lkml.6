Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1F32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfAGSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:17:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbfAGSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:17:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07IEVHA068948
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 13:17:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvbr38j2t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:17:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Mon, 7 Jan 2019 18:17:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 18:17:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07IHGCV58589370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 18:17:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E806952063;
        Mon,  7 Jan 2019 18:17:15 +0000 (GMT)
Received: from [9.152.96.120] (unknown [9.152.96.120])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6F62C52052;
        Mon,  7 Jan 2019 18:17:15 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 11/15] KVM: s390: restore IAM in get_ipm() when IPM is
 clean
To:     pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc:     Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kvm390-list@tuxmaker.boeblingen.de.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-12-mimu@linux.ibm.com>
 <08327d88-388e-2ffe-9bd0-b0de2e0a0ff3@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Mon, 7 Jan 2019 19:17:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <08327d88-388e-2ffe-9bd0-b0de2e0a0ff3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010718-0008-0000-0000-000002AC791F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010718-0009-0000-0000-00002218847C
Message-Id: <d1046c6b-5013-e79e-7af9-ad8c11903af4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.19 16:06, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The patch adds the parameter irq_flags and allows to
>> restore the Interruption Alert Mask (IAM) in the GISA
>> atomically while guaranteeing the IPM is clean.
>>
>> The function returns the IPM of the GISA. If the returned
>> value is 0x00 and the IRQ_FLAG_IAM was set, the IAM has
>> been restored.
>>
>> New irq flag:
>>    IRQ_FLAG_IAM: When set, the IAM is restored if no ISC bit
>>            is set in the IPM, i.e. no new airqs are
>>         pending. The test and restore operations
>>         are done atomically.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 34 +++++++++++++++++++++++++++++-----
>>   1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 1cc3ad2e6c7e..8307717e3caf 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -37,6 +37,7 @@
>>   #define IRQ_FLAG_LOCAL    0x8000 /* include local interruption 
>> pending mask */
>>   #define IRQ_FLAG_FLOATING 0x4000 /* include float interruption 
>> pending mask */
>>   #define IRQ_FLAG_GISA     0x2000 /* include GISA interruption 
>> pending mask */
>> +#define IRQ_FLAG_IAM      0x0080 /* when set try to restore IAM */
>>   #define IRQ_MASK_ALL      (IRQ_FLAG_LOCAL | IRQ_FLAG_FLOATING | 
>> IRQ_FLAG_GISA)
>>   #define IRQ_MASK_NO_GISA  (IRQ_MASK_ALL & ~IRQ_FLAG_GISA)
>> @@ -253,9 +254,32 @@ static inline void set_ipm_gisc(struct 
>> kvm_s390_gisa *gisa, u32 gisc)
>>       set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>   }
>> -static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
>> +static inline u8 get_ipm(struct kvm_s390_gisa *gisa, u16 irq_flags)
>>   {
>> -    return READ_ONCE(gisa->ipm);
>> +    u64 word, _word;
>> +    u8 ipm;
>> +
>> +    if (!(irq_flags & IRQ_FLAG_IAM))
>> +        return READ_ONCE(gisa->ipm);
>> +
>> +    do {
>> +        word = READ_ONCE(gisa->u64.word[0]);
>> +        ipm = word >> 24;
>> +        /* If the GISA is in the alert list, return the IPM. */
>> +        if ((u64)gisa != word >> 32)
>> +            return ipm;
>> +        /* If the IPM is dirty, return the IPM. */
>> +        if (ipm)
>> +            return ipm;
>> +        /*
>> +         * Try to restore the IAM or loop, if the IPM is dirty
>> +         * again or the GISA has been inserted into the alert list.
>> +         */
>> +        _word = (word & ~0xffUL) |
>> +            container_of(gisa, struct sie_page2, gisa)->kvm->arch.iam;
>> +    } while (cmpxchg(&gisa->u64.word[0], word, _word) != _word);
>> +
>> +    return 0;
>>   }
> 
> Personal opinion, but this function do more than just getting the IPM, 
> shouldn't it be reflected in the function name?

The main task of this function is to fetch the IPM. The additional
functionality is expressed in the flags.

A call like get_ipm_try_iam_restore(kvm, 0) would be more confusing.

> 
>>   static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>> @@ -277,7 +301,7 @@ static inline unsigned long pending_irqs(struct 
>> kvm_vcpu *vcpu, u16 irq_flags)
>>       if (irq_flags & IRQ_FLAG_FLOATING)
>>           pending_irqs |= vcpu->kvm->arch.float_int.pending_irqs;
>>       if (irq_flags & IRQ_FLAG_GISA)
>> -        pending_irqs |= get_ipm(vcpu->kvm->arch.gisa) <<
>> +        pending_irqs |= get_ipm(vcpu->kvm->arch.gisa, irq_flags) <<
>>               IRQ_PEND_IO_ISC_7;
>>       return pending_irqs;
>>   }
>> @@ -1574,7 +1598,7 @@ static int get_top_gisa_isc(struct kvm *kvm, u64 
>> isc_mask, u32 schid)
>>       if (!kvm->arch.gisa)
>>           goto out;
>> -    active_mask = (isc_mask & get_ipm(kvm->arch.gisa) << 24) << 32;
>> +    active_mask = (isc_mask & get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM) 
>> << 24) << 32;
> 
> why do we need to set the IAM here?

Yes, it should not be required, only when a vcpu goes into wait state.

> 
>>       while (active_mask) {
>>           isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
>>           if (tac_ipm_gisc(kvm->arch.gisa, isc))
>> @@ -2060,7 +2084,7 @@ static int get_all_floating_irqs(struct kvm 
>> *kvm, u8 __user *usrbuf, u64 len)
>>       max_irqs = len / sizeof(struct kvm_s390_irq);
>>       if (kvm->arch.gisa &&
>> -        get_ipm(kvm->arch.gisa)) {
>> +        get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM)) {
> 
> and here?

Yes, it should not be required, only when a vcpu goes into wait state.

> 
>>           for (i = 0; i <= MAX_ISC; i++) {
>>               if (n == max_irqs) {
>>                   /* signal userspace to try again */
>>
> 
> 


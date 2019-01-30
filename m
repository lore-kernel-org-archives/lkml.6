Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C0420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfA3Qlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:41:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732098AbfA3Qlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:41:45 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UGbn44005799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:41:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qbfm4g7yc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:41:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 30 Jan 2019 16:41:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 16:41:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UGfcS260293368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 16:41:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDFA42047;
        Wed, 30 Jan 2019 16:41:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A1C4203F;
        Wed, 30 Jan 2019 16:41:37 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 16:41:37 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v6 12/13] KVM: s390: add gib_alert_irq_handler()
To:     pmorel@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-13-mimu@linux.ibm.com>
 <20190129142642.3a94a5f1@oc2783563651>
 <3819a46e-b2cf-96e3-b3b8-6cdf35eeb616@linux.ibm.com>
 <7f33ff97-9503-9b32-b244-1e8104d0408e@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Wed, 30 Jan 2019 17:41:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7f33ff97-9503-9b32-b244-1e8104d0408e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19013016-0008-0000-0000-000002B80E71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013016-0009-0000-0000-000022245628
Message-Id: <24be66f9-2e12-7257-5c15-9f9dc259d67a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.01.19 17:24, Pierre Morel wrote:
> On 29/01/2019 16:29, Michael Mueller wrote:
>>
>>
>> On 29.01.19 14:26, Halil Pasic wrote:
>>> On Thu, 24 Jan 2019 13:59:38 +0100
>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>
>>>> The patch implements a handler for GIB alert interruptions
>>>> on the host. Its task is to alert guests that interrupts are
>>>> pending for them.
>>>>
>>>> A GIB alert interrupt statistic counter is added as well:
>>>>
>>>> $ cat /proc/interrupts
>>>>            CPU0       CPU1
>>>>    ...
>>>>    GAL:      23         37   [I/O] GIB Alert
>>>>    ...
>>>>
>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>> [..]
>>>> +/**
>>>> + * gisa_get_ipm_or_restore_iam - return IPM or restore GISA IAM
>>>> + *
>>>> + * @gi: gisa interrupt struct to work on
>>>> + *
>>>> + * Atomically restores the interruption alert mask if none of the
>>>> + * relevant ISCs are pending and return the IPM.
>>>
>>> The word 'relevant' probably reflects some previous state. It does not
>>> bother me too much.
>>
>> "relevant" refers to the ISCs handled by the GAL mechanism, i.e those
>> registered in the kvm->arch.gisa_int.alert.mask.
>>
>>>
>>> [..]
>>>
>>>> +static void __airqs_kick_single_vcpu(struct kvm *kvm, u8 
>>>> deliverable_mask)
>>>> +{
>>>> +    int vcpu_id, online_vcpus = atomic_read(&kvm->online_vcpus);
>>>> +    struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>>>> +    struct kvm_vcpu *vcpu;
>>>> +
>>>> +    for_each_set_bit(vcpu_id, kvm->arch.idle_mask, online_vcpus) {
>>>> +        vcpu = kvm_get_vcpu(kvm, vcpu_id);
>>>> +        if (psw_ioint_disabled(vcpu))
>>>> +            continue;
>>>> +        deliverable_mask &= (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
>>>> +        if (deliverable_mask) {
>>>> +            /* lately kicked but not yet running */
>>>
>>> How about /* was kicked but didn't run yet */?
>>
>> what is the difference here...
>>
>>>
>>>> +            if (test_and_set_bit(vcpu_id, gi->kicked_mask))
>>>> +                return;
>>>> +            kvm_s390_vcpu_wakeup(vcpu);
>>>> +            return;
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>
>>> [..]
>>>
>>>> +static void process_gib_alert_list(void)
>>>> +{
>>>> +    struct kvm_s390_gisa_interrupt *gi;
>>>> +    struct kvm_s390_gisa *gisa;
>>>> +    struct kvm *kvm;
>>>> +    u32 final, origin = 0UL;
>>>> +
>>>> +    do {
>>>> +        /*
>>>> +         * If the NONE_GISA_ADDR is still stored in the alert list
>>>> +         * origin, we will leave the outer loop. No further GISA has
>>>> +         * been added to the alert list by millicode while processing
>>>> +         * the current alert list.
>>>> +         */
>>>> +        final = (origin & NONE_GISA_ADDR);
>>>> +        /*
>>>> +         * Cut off the alert list and store the NONE_GISA_ADDR in the
>>>> +         * alert list origin to avoid further GAL interruptions.
>>>> +         * A new alert list can be build up by millicode in parallel
>>>> +         * for guests not in the yet cut-off alert list. When in the
>>>> +         * final loop, store the NULL_GISA_ADDR instead. This will re-
>>>> +         * enable GAL interruptions on the host again.
>>>> +         */
>>>> +        origin = xchg(&gib->alert_list_origin,
>>>> +                  (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>>>> +        /*
>>>> +         * Loop through the just cut-off alert list and start the
>>>> +         * gisa timers to kick idle vcpus to consume the pending
>>>> +         * interruptions asap.
>>>> +         */
>>>> +        while (origin & GISA_ADDR_MASK) {
>>>> +            gisa = (struct kvm_s390_gisa *)(u64)origin;
>>>> +            origin = gisa->next_alert;
>>>> +            gisa->next_alert = (u32)(u64)gisa;
>>>> +            kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>>>> +            gi = &kvm->arch.gisa_int;
>>>> +            if (hrtimer_active(&gi->timer))
>>>> +                hrtimer_cancel(&gi->timer);
>>>> +            hrtimer_start(&gi->timer, 0, HRTIMER_MODE_REL);
>>>> +        }
>>>> +    } while (!final);
>>>> +
>>>> +}
>>>> +
>>>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>>>   {
>>>>       struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>>>>       if (!gi->origin)
>>>>           return;
>>>> -    memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>>>> -    gi->origin->next_alert = (u32)(u64)gi->origin;
>>>> +    gisa_clear_ipm(gi->origin);
>>>
>>> This could be a separate patch. I would like little more explanation
>>> to this.
>>
>> I can break at out as I had before... ;)
>>
>>>
>>>>       VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
>>>>   }
>>>> @@ -2940,13 +3078,25 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>>>>       gi->origin = &kvm->arch.sie_page2->gisa;
>>>>       gi->alert.mask = 0;
>>>>       spin_lock_init(&gi->alert.ref_lock);
>>>> -    kvm_s390_gisa_clear(kvm);
>>>> +    gi->expires = 50 * 1000; /* 50 usec */
>>>
>>> I blindly trust your choice here ;)
>>
>> You know I will increase it to 1 ms together with the change that I
>> proposed. (gisa_get_ipm_or_restore_iam() in kvm_s390_handle_wait()).
> 
> With this.
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

Pierre,

please see my mail with the measurements that I have done. Up to that
I can't take your Reviewed-by. I will keep the 50 usec.

Michael

> 
> 
> 


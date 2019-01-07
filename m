Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CDBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BCE2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfAGRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:53:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727994AbfAGRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:53:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07Hnest076521
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 12:53:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pv8xh9sg0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 12:53:30 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Mon, 7 Jan 2019 17:53:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 17:53:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07HrOo149610770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 17:53:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EAF35205F;
        Mon,  7 Jan 2019 17:53:24 +0000 (GMT)
Received: from [9.152.96.120] (unknown [9.152.96.120])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C5DFF52050;
        Mon,  7 Jan 2019 17:53:23 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 12/15] KVM: s390: do not restore IAM immediately before
 SIE entry
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
 <20181219191756.57973-13-mimu@linux.ibm.com>
 <5b427ccb-b0b4-f411-a9fc-6b8f8a60b734@linux.ibm.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Mon, 7 Jan 2019 18:53:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5b427ccb-b0b4-f411-a9fc-6b8f8a60b734@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010717-0012-0000-0000-000002E37847
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010717-0013-0000-0000-0000211A82B6
Message-Id: <0c05a099-199e-426f-93af-b8614a3f800e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.19 16:00, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The IAM shall no be restored when deliverable interruptions are
>> delivered to vcpus by means of the PSW swap mechanism. That would
>> trigger the GIB alert millicode although we know that SIE will be
>> able to handle the pending interruption on entry.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 8307717e3caf..48a93f5e5333 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -328,11 +328,11 @@ static unsigned long disable_iscs(struct 
>> kvm_vcpu *vcpu,
>>       return active_mask;
>>   }
>> -static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>> +static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu, u16 
>> irq_flags)
>>   {
>>       unsigned long active_mask;
>> -    active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
>> +    active_mask = pending_irqs(vcpu, irq_flags);
>>       if (!active_mask)
>>           return 0;
>> @@ -1090,7 +1090,7 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu 
>> *vcpu)
>>   int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
>>   {
>> -    if (deliverable_irqs(vcpu))
>> +    if (deliverable_irqs(vcpu, IRQ_MASK_ALL | IRQ_FLAG_IAM))
> 
> Why do we need to restore IAM here?


please see kvm_s390_handle_wait()

It calls kvm_arch_vcpu_runnable() / kvm_s390_vcpu_has_irq()

That's the place where we want the IAM to be restored when
no ISC is pending in the IPM anymore.

> 
> 
> 


Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6907CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2568B21B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2568B21B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeHILOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729911AbeHILOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:14:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w798i5aF058817
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 04:50:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krhj5j5k9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:50:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 9 Aug 2018 09:50:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 09:50:37 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w798oaec23658726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 08:50:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2750C42042;
        Thu,  9 Aug 2018 11:50:44 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C8334204C;
        Thu,  9 Aug 2018 11:50:43 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 11:50:43 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v8 19/22] KVM: s390: Clear Crypto Control Block when using
 vSIE
To:     David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9a7353fa-143f-9048-936a-59f446411e0a@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 9 Aug 2018 10:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9a7353fa-143f-9048-936a-59f446411e0a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080908-0008-0000-0000-0000025F4AA8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080908-0009-0000-0000-000021C7597D
Message-Id: <8696bba1-af93-07a6-060b-e722165416b8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 10:10, David Hildenbrand wrote:
> On 08.08.2018 16:44, Tony Krowiak wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> When we clear the Crypto Control Block (CRYCB) used by a guest
>> level 2, the vSIE shadow CRYCB for guest level 3 must be updated
>> before the guest uses it.
>>
>> We achieve this by using the KVM_REQ_VSIE_RESTART synchronous
>> request for each vCPU belonging to the guest to force the reload
>> of the shadow CRYCB before rerunning the guest level 3.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c |    7 +++++++
>>   1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 0d03249..9203f0b 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1921,6 +1921,9 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>>   
>>   void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>>   {
>> +	int i;
>> +	struct kvm_vcpu *vcpu;
>> +
>>   	mutex_lock(&kvm->lock);
>>   	kvm_s390_vcpu_block_all(kvm);
>>   
>> @@ -1929,6 +1932,10 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>>   	memset(&kvm->arch.crypto.crycb->apcb1, 0,
>>   	       sizeof(kvm->arch.crypto.crycb->apcb1));
>>   
>> +	/* recreate the shadow crycb for each vcpu */
>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>> +		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
> We have kvm_s390_sync_request_broadcast(), which should boil down to a
> one-liner
right, thanks

>> +
>>   	kvm_s390_vcpu_unblock_all(kvm);
>>   	mutex_unlock(&kvm->lock);
>>   }
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany


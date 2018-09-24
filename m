Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF0AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3284A21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3284A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeIXWvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:51:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732367AbeIXWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:51:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OGe1P3010288
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:48:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mq2834jk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:48:46 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 24 Sep 2018 10:48:45 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 10:48:42 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OGmd1036045012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 09:48:39 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EEB1BE051;
        Mon, 24 Sep 2018 10:48:39 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EADDEBE04F;
        Mon, 24 Sep 2018 10:48:35 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.130.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 10:48:35 -0600 (MDT)
Subject: Re: [PATCH v10 02/26] KVM: s390: introduce and use
 KVM_REQ_VSIE_RESTART
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-3-git-send-email-akrowiak@linux.vnet.ibm.com>
 <cf81913a-ee0a-6507-9c31-b10f66148d41@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 24 Sep 2018 12:48:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <cf81913a-ee0a-6507-9c31-b10f66148d41@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092416-8235-0000-0000-00000E05DD56
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093033; UDB=6.00564900; IPR=6.00873070;
 MB=3.00023484; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 16:48:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092416-8236-0000-0000-000042C1A973
Message-Id: <dc90c8c6-3de7-8d98-c516-f9c92393af88@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 06:49 AM, Christian Borntraeger wrote:
> On 09/12/2018 09:42 PM, Tony Krowiak wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> When we change the crycb (or execution controls), we also have to make sure
>> that the vSIE shadow datastructures properly consider the changed
>> values before rerunning the vSIE. We can achieve that by simply using a
>> VCPU request now.
>>
>> This has to be a synchronous request (== handled before entering the
>> (v)SIE again).
>>
>> The request will make sure that the vSIE handler is left, and that the
>> request will be processed (NOP), therefore forcing a reload of all
>> vSIE data (including rebuilding the crycb) when re-entering the vSIE
>> interception handler the next time.
>>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> same here? First David then Tomy?

Will do.

> 
> otherwise
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> 
>> ---
>>   arch/s390/include/asm/kvm_host.h |    1 +
>>   arch/s390/kvm/kvm-s390.c         |    7 ++++++-
>>   2 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 29c940b..75d3962 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -44,6 +44,7 @@
>>   #define KVM_REQ_ICPT_OPEREXC	KVM_ARCH_REQ(2)
>>   #define KVM_REQ_START_MIGRATION KVM_ARCH_REQ(3)
>>   #define KVM_REQ_STOP_MIGRATION  KVM_ARCH_REQ(4)
>> +#define KVM_REQ_VSIE_RESTART	KVM_ARCH_REQ(5)
>>   
>>   #define SIGP_CTRL_C		0x80
>>   #define SIGP_CTRL_SCN_MASK	0x3f
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 0b5aff0..876fbb2 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -844,8 +844,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>>   
>>   	kvm_s390_vcpu_block_all(kvm);
>>   
>> -	kvm_for_each_vcpu(i, vcpu, kvm)
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>>   		kvm_s390_vcpu_crypto_setup(vcpu);
>> +		/* recreate the shadow crycb by leaving the VSIE handler */
>> +		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
>> +	}
>>   
>>   	kvm_s390_vcpu_unblock_all(kvm);
>>   }
>> @@ -3203,6 +3206,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>>   
>>   	/* nothing to do, just clear the request */
>>   	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>> +	/* we left the vsie handler, nothing to do, just clear the request */
>> +	kvm_clear_request(KVM_REQ_VSIE_RESTART, vcpu);
>>   
>>   	return 0;
>>   }
>>


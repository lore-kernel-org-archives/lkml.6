Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E93C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24E22432
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24E22432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeHJSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:43:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727462AbeHJSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:43:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AG9KXB019506
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:13:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ksc0w59y9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:13:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 10 Aug 2018 12:13:26 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 12:13:22 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AGDJVJ15794296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 16:13:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2C72AC064;
        Fri, 10 Aug 2018 12:13:46 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21D23AC060;
        Fri, 10 Aug 2018 12:13:45 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.80.230.146])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Aug 2018 12:13:44 -0400 (EDT)
Subject: Re: [PATCH v8 07/22] KVM: s390: refactor crypto initialization
To:     Janosch Frank <frankja@linux.ibm.com>,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 10 Aug 2018 12:13:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081016-0052-0000-0000-0000031CD315
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009518; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071700; UDB=6.00551951; IPR=6.00851491;
 MB=3.00022637; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-10 16:13:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081016-0053-0000-0000-00005DAE7428
Message-Id: <bccf66eb-9532-a512-18de-d76b33cdc1df@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 01:58 AM, Janosch Frank wrote:
> On 08.08.2018 16:44, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch refactors the code that initializes and sets up the
>> crypto configuration for a guest. The following changes are
>> implemented via this patch:
>>
>> 1. Prior to the introduction of AP device virtualization, it
>>     was not necessary to provide guest access to the CRYCB
>>     unless the MSA extension 3 (MSAX3) facility was installed
>>     on the host system. With the introduction of AP device
>>     virtualization, the CRYCB must be made accessible to the
>>     guest if the AP instructions are installed on the host
>>     and are to be provided to the guest.
>>
>> 2. Introduces a flag indicating AP instructions executed on
>>     the guest shall be interpreted by the firmware. It is
>>     initialized to indicate AP instructions are to be
>>     to be interpreted and is used to set the SIE bit for
>>     each vcpu during vcpu setup.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>
>> ---
>>   arch/s390/include/asm/kvm_host.h |    3 +
>>   arch/s390/include/uapi/asm/kvm.h |    1 +
>>   arch/s390/kvm/kvm-s390.c         |   86 ++++++++++++++++++++------------------
>>   3 files changed, 49 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index af39561..0c13f61 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
>>   #define ECA_AIV		0x00200000
>>   #define ECA_VX		0x00020000
>>   #define ECA_PROTEXCI	0x00002000
>> +#define ECA_APIE	0x00000008
>>   #define ECA_SII		0x00000001
>>   	__u32	eca;			/* 0x004c */
>>   #define ICPT_INST	0x04
>> @@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
>>   	__u8	reservede4[4];		/* 0x00e4 */
>>   	__u64	tecmc;			/* 0x00e8 */
>>   	__u8	reservedf0[12];		/* 0x00f0 */
>> +#define CRYCB_FORMAT_MASK 0x00000003
>>   #define CRYCB_FORMAT1 0x00000001
>>   #define CRYCB_FORMAT2 0x00000003
>>   	__u32	crycbd;			/* 0x00fc */
>> @@ -714,6 +716,7 @@ struct kvm_s390_crypto {
>>   	__u32 crycbd;
>>   	__u8 aes_kw;
>>   	__u8 dea_kw;
>> +	__u8 apie;
> In the last review I wanted a comment here to know what they do.

I'm not sure what the 'they' are that you reference here. I couldn't
find your review comment but I assume you are looking for a comment
explaining what the 'apie' field is used for. I am removing
the 'apie' field based on a review comment by David, so there is
no longer a need for a comment here, assuming that is what you
are referring to.

>
>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>   {
>> -	if (!test_kvm_facility(vcpu->kvm, 76))
>> +	/*
>> +	 * If neither the AP instructions nor the MSAX3 facility are installed
>> +	 * on the host, then there is no need for a CRYCB in SIE because the
>> +	 * they will not be installed on the guest either.
> the they

I'll fix this grammatical error.

>
>> +	 */
>> +	if (ap_instructions_available() && !test_facility(76))
>>   		return;
> I know you're not responsible for that one :) but 0 being the wanted
> value here is a bit counter-intuitive.

Based on another review comment by David, I've changed this to:

if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
     !test_kvm_facility(vcpu->kvm, 76))


>
>>   
>> -	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>> +	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>> +
>> +	vcpu->arch.sie_block->eca &= ~ECA_APIE;
> The scb is zero allocated, are the ECA and the ECB3s set somewhere
> in-between, or is that your way of making sure the controls are
> definitely gone for good?

It is a bit of defensive programming. There is a KVM_SET_DEVICE_ATTR
ioctl to set crypto attributes (KVM_S390_VM_CRYPTO) that ultimately
calls the kvm_s390_vm_set_crypto() function. You'll notice that at the
end of that function, there is a call to kvm_s390_vcpu_crypto_reset_all()
that calls the kvm_s390_vcpu_crypto_setup() for each vcpu, so it would
seem that there is the possiblility that there could be a need to
set ECB3 to a different value. At any rate, I see no good reason to
remove this.

>
>> +	if (vcpu->kvm->arch.crypto.apie &&
>> +	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>>   
>> -	if (vcpu->kvm->arch.crypto.aes_kw)
>> -		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>> -	if (vcpu->kvm->arch.crypto.dea_kw)
>> -		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>> +	/* If MSAX3 is installed on the guest, set up protected key support */
>> +	if (test_kvm_facility(vcpu->kvm, 76)) {
>> +		vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>>   
>> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>> +		if (vcpu->kvm->arch.crypto.aes_kw)
>> +			vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>> +		if (vcpu->kvm->arch.crypto.dea_kw)
>> +			vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>> +	}
>>   }
>>   
>>   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>
>


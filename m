Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDQQWu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:22:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755820AbeDQQWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:22:43 -0400
Subject: Re: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive
 execution
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, buendgen@de.ibm.com
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <15b60572-40d6-0f03-11f9-c50cb7eb00e8@linux.vnet.ibm.com>
 <cf928702-db64-93c7-9b89-bf1c66a33cfa@linux.vnet.ibm.com>
 <6cba35df-b0de-8000-bb39-c4cec8622c57@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 12:22:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <6cba35df-b0de-8000-bb39-c4cec8622c57@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041716-0024-0000-0000-000003494BFD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008871; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019285; UDB=6.00519987; IPR=6.00798526;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 16:22:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041716-0025-0000-0000-000047B2FEB2
Message-Id: <2b053349-071e-17ed-6ebd-a37bcfd2f330@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:13 PM, Pierre Morel wrote:
> On 17/04/2018 17:02, Tony Krowiak wrote:
>> On 04/16/2018 06:51 AM, Pierre Morel wrote:
>>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>>> The VFIO AP device model exploits interpretive execution of AP
>>>> instructions (APIE) to provide guests passthrough access to AP
>>>> devices. This patch introduces a new interface to enable and
>>>> disable APIE.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>>   arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++++++++
>>>>   arch/s390/include/asm/kvm_host.h |    1 +
>>>>   arch/s390/kvm/kvm-ap.c           |   20 ++++++++++++++++++++
>>>>   arch/s390/kvm/kvm-s390.c         |    9 +++++++++
>>>>   4 files changed, 46 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/kvm-ap.h 
>>>> b/arch/s390/include/asm/kvm-ap.h
>>>> index 736e93e..a6c092e 100644
>>>> --- a/arch/s390/include/asm/kvm-ap.h
>>>> +++ b/arch/s390/include/asm/kvm-ap.h
>>>> @@ -35,4 +35,20 @@
>>>>    */
>>>>   void kvm_ap_build_crycbd(struct kvm *kvm);
>>>>
>>>> +/**
>>>> + * kvm_ap_interpret_instructions
>>>> + *
>>>> + * Indicate whether AP instructions shall be interpreted. If they 
>>>> are not
>>>> + * interpreted, all AP instructions will be intercepted and routed 
>>>> back to
>>>> + * userspace.
>>>> + *
>>>> + * @kvm: the virtual machine attributes
>>>> + * @enable: indicates whether AP instructions are to be 
>>>> interpreted (true) or
>>>> + *        or not (false).
>>>> + *
>>>> + * Returns 0 if completed successfully; otherwise, returns 
>>>> -EOPNOTSUPP
>>>> + * indicating that AP instructions are not installed on the guest.
>>>> + */
>>>> +int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable);
>>>> +
>>>>   #endif /* _ASM_KVM_AP */
>>>> diff --git a/arch/s390/include/asm/kvm_host.h 
>>>> b/arch/s390/include/asm/kvm_host.h
>>>> index 3162783..5470685 100644
>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>> @@ -715,6 +715,7 @@ struct kvm_s390_crypto {
>>>>       __u32 crycbd;
>>>>       __u8 aes_kw;
>>>>       __u8 dea_kw;
>>>> +    __u8 apie;
>>>>   };
>>>>
>>>>   #define APCB0_MASK_SIZE 1
>>>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>>>> index 991bae4..55d11b5 100644
>>>> --- a/arch/s390/kvm/kvm-ap.c
>>>> +++ b/arch/s390/kvm/kvm-ap.c
>>>> @@ -58,3 +58,23 @@ void kvm_ap_build_crycbd(struct kvm *kvm)
>>>>       }
>>>>   }
>>>>   EXPORT_SYMBOL(kvm_ap_build_crycbd);
>>>> +
>>>> +int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable)
>>>> +{
>>>> +    int ret = 0;
>>>> +
>>>> +    mutex_lock(&kvm->lock);
>>>> +
>>>> +    if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP)) {
>>>
>>> Do we really need to test CPU_FEAT_AP?
>>
>> Yes we do.
>
> really? why?

The KVM_S390_VM_CPU_FEAT_AP will not be enabled by KVM if the AP
instructions are not installed on the host. I assume - but have
no way of verifying - that if the AP instructions are not installed
on the host, that interpretation would fail. Do you know what would
happen if AP instructions are interpreted when not installed on
the host?

>
>
>>
>>>
>>>
>>> I understand that KVM_S390_VM_CPU_FEAT_AP means AP instructions are 
>>> interpreted.
>>> shouldn't we add this information in the name?
>>> like KVM_S390_VM_CPU_FEAT_APIE
>>
>> KVM_S390_VM_CPU_FEAT_AP does NOT mean AP instructions are 
>> interpreted, it means
>> AP instructions are installed.
>
> Right same error I made all along this review.
> But AFAIK it means AP instructions are provided to the guest.
> Then should this function be called if the guest has no AP instructions ?
>
>
>>
>>>
>>>> +        ret = -EOPNOTSUPP;
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    kvm->arch.crypto.apie = enable;
>>>> +    kvm_s390_vcpu_crypto_reset_all(kvm);
>>>> +
>>>> +done:
>>>> +    mutex_unlock(&kvm->lock);
>>>> +    return ret;
>>>> +}
>>>> +EXPORT_SYMBOL(kvm_ap_interpret_instructions);
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 55cd897..1dc8566 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -1901,6 +1901,9 @@ static void kvm_s390_crypto_init(struct kvm 
>>>> *kvm)
>>>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>>>       kvm_ap_build_crycbd(kvm);
>>>>
>>>> +    /* Default setting indicating SIE shall interpret AP 
>>>> instructions */
>>>> +    kvm->arch.crypto.apie = 1;
>>>> +
>>>>       if (!test_kvm_facility(kvm, 76))
>>>>           return;
>>>>
>>>> @@ -2434,6 +2437,12 @@ static void 
>>>> kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>>>   {
>>>>       vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>>>
>>>> +    vcpu->arch.sie_block->eca &= ~ECA_APIE;
>>>> +    if (vcpu->kvm->arch.crypto.apie &&
>>>> +        test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>>>
>>> Do we call xxx_crypto_setup() if KVM does not support AP 
>>> interpretation?
>>
>> Yes, kvm_s390_vcpu_crypto_setup(vcpu) is called by 
>> kvm_arch_vcpu_setup(vcpu)
>> as well as from kvm_s390_vcpu_crypto_reset_all(kvm). Calling it has 
>> nothing
>> to do with whether AP interpretation is supported or not as it does much
>> more than that, including setting up of wrapping keys and the CRYCBD.
>
> Sorry, still the same error I made about CPU_FEAT_AP meaning AP 
> instructions in the guest
> and not AP interpretation available.
> Could apie be set if AP instruction are not supported?
>
>>
>>>
>>>> + vcpu->arch.sie_block->eca |= ECA_APIE;
>>>> +
>>>> +
>>>>       if (!test_kvm_facility(vcpu->kvm, 76))
>>>>           return;
>>>>
>>>
>>
>

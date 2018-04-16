Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDPLw7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:52:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753328AbeDPLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:52:58 -0400
Subject: Re: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive
 execution
To: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <15b60572-40d6-0f03-11f9-c50cb7eb00e8@linux.vnet.ibm.com>
 <15bb0c9b-e605-232b-4dd2-826b6ee0d045@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 13:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <15bb0c9b-e605-232b-4dd2-826b6ee0d045@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041611-0044-0000-0000-00000548BE1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041611-0045-0000-0000-00002888C54B
Message-Id: <c939ca13-db4c-94c2-5af6-b31a0d31f5ac@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2018 01:13 PM, Pierre Morel wrote:
> On 16/04/2018 12:51, Pierre Morel wrote:
>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>> The VFIO AP device model exploits interpretive execution of AP
>>> instructions (APIE) to provide guests passthrough access to AP
>>> devices. This patch introduces a new interface to enable and
>>> disable APIE.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++++++++
>>>   arch/s390/include/asm/kvm_host.h |    1 +
>>>   arch/s390/kvm/kvm-ap.c           |   20 ++++++++++++++++++++
>>>   arch/s390/kvm/kvm-s390.c         |    9 +++++++++
>>>   4 files changed, 46 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
>>> index 736e93e..a6c092e 100644
>>> --- a/arch/s390/include/asm/kvm-ap.h
>>> +++ b/arch/s390/include/asm/kvm-ap.h
>>> @@ -35,4 +35,20 @@
>>>    */
>>>   void kvm_ap_build_crycbd(struct kvm *kvm);
>>>
>>> +/**
>>> + * kvm_ap_interpret_instructions
>>> + *
>>> + * Indicate whether AP instructions shall be interpreted. If they are not
>>> + * interpreted, all AP instructions will be intercepted and routed back to
>>> + * userspace.
>>> + *
>>> + * @kvm: the virtual machine attributes
>>> + * @enable: indicates whether AP instructions are to be interpreted (true) or
>>> + *        or not (false).
>>> + *
>>> + * Returns 0 if completed successfully; otherwise, returns -EOPNOTSUPP
>>> + * indicating that AP instructions are not installed on the guest.
>>> + */
>>> +int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable);
>>> +
>>>   #endif /* _ASM_KVM_AP */
>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>> index 3162783..5470685 100644
>>> --- a/arch/s390/include/asm/kvm_host.h
>>> +++ b/arch/s390/include/asm/kvm_host.h
>>> @@ -715,6 +715,7 @@ struct kvm_s390_crypto {
>>>       __u32 crycbd;
>>>       __u8 aes_kw;
>>>       __u8 dea_kw;
>>> +    __u8 apie;
>>>   };
>>>
>>>   #define APCB0_MASK_SIZE 1
>>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>>> index 991bae4..55d11b5 100644
>>> --- a/arch/s390/kvm/kvm-ap.c
>>> +++ b/arch/s390/kvm/kvm-ap.c
>>> @@ -58,3 +58,23 @@ void kvm_ap_build_crycbd(struct kvm *kvm)
>>>       }
>>>   }
>>>   EXPORT_SYMBOL(kvm_ap_build_crycbd);
>>> +
>>> +int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable)
>>> +{
>>> +    int ret = 0;
>>> +
>>> +    mutex_lock(&kvm->lock);
>>> +
>>> +    if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP)) {
>>
>> Do we really need to test CPU_FEAT_AP?
>>
>> I understand that KVM_S390_VM_CPU_FEAT_AP means AP instructions are interpreted.
>> shouldn't we add this information in the name?
>> like KVM_S390_VM_CPU_FEAT_APIE
> 
> If I misunderstood and FEAT_AP really mean AP instructions available in the guest,
> same question:
> is this function called if AP instructions are not available in the guest?
> 

See patch #13. I guess the check above is anyway good as defensive
programming. This implementation should be sane regardless of
the answer to your question.

>>
>>> +        ret = -EOPNOTSUPP;
>>> +        goto done;
>>> +    }
>>> +
>>> +    kvm->arch.crypto.apie = enable;
>>> +    kvm_s390_vcpu_crypto_reset_all(kvm);
>>> +
>>> +done:
>>> +    mutex_unlock(&kvm->lock);
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL(kvm_ap_interpret_instructions);
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 55cd897..1dc8566 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -1901,6 +1901,9 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>>       kvm_ap_build_crycbd(kvm);
>>>
>>> +    /* Default setting indicating SIE shall interpret AP instructions */
>>> +    kvm->arch.crypto.apie = 1;
>>> +
>>>       if (!test_kvm_facility(kvm, 76))
>>>           return;
>>>
>>> @@ -2434,6 +2437,12 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>>   {
>>>       vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>>
>>> +    vcpu->arch.sie_block->eca &= ~ECA_APIE;
>>> +    if (vcpu->kvm->arch.crypto.apie &&
>>> +        test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>>
>> Do we call xxx_crypto_setup() if KVM does not support AP interpretation?
> 
> sorry, I should have written AP instructions here:
> is this function called if AP instructions are not available in the guest?
> 

Yes, this function can be called with AP instructions available to the guest.
Please have a look at patch 2 (kvm_s390_vm_set_crypto and the rest).

Also this function is called on initialization regardless of AP instructions.

>>
>>> +        vcpu->arch.sie_block->eca |= ECA_APIE;
>>> +
>>> +
>>>       if (!test_kvm_facility(vcpu->kvm, 76))
>>>           return;
>>>
>>
> 

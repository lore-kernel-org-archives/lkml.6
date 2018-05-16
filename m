Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeEPMSF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752186AbeEPMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:18:03 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 02/13] KVM: s390: refactor crypto initialization
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-3-git-send-email-akrowiak@linux.vnet.ibm.com>
 <67656726-4d9b-44e1-1e2b-ab11de83f513@linux.ibm.com>
 <6835f3b9-c660-fe7c-5583-8706cc1fa732@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 16 May 2018 14:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6835f3b9-c660-fe7c-5583-8706cc1fa732@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051612-0012-0000-0000-000005D729AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051612-0013-0000-0000-000019544E2D
Message-Id: <40b5c7d2-a855-f11b-3dbd-afdc8fae268d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160125
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2018 13:14, Tony Krowiak wrote:
> On 05/16/2018 04:51 AM, Pierre Morel wrote:
>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>> This patch refactors the code that initializes the crypto
>>> configuration for a guest. The crypto configuration is contained in
>>> a crypto control block (CRYCB) which is a satellite control block to
>>> our main hardware virtualization control block. The CRYCB is
>>> attached to the main virtualization control block via a CRYCB
>>> designation (CRYCBD) designation field containing the address of
>>> the CRYCB as well as its format.
>>>
>>> Prior to the introduction of AP device virtualization, there was
>>> no need to provide access to or specify the format of the CRYCB for
>>> a guest unless the MSA extension 3 (MSAX3) facility was installed
>>> on the host system. With the introduction of AP device virtualization,
>>> the CRYCB and its format must be made accessible to the guest
>>> regardless of the presence of the MSAX3 facility as long as the
>>> AP instructions are installed on the host.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   arch/s390/include/asm/kvm_host.h |    1 +
>>>   arch/s390/kvm/kvm-s390.c         |   64 
>>> ++++++++++++++++++++++++++-----------
>>>   2 files changed, 46 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/kvm_host.h 
>>> b/arch/s390/include/asm/kvm_host.h
>>> index 81cdb6b..5393c4d 100644
>>> --- a/arch/s390/include/asm/kvm_host.h
>>> +++ b/arch/s390/include/asm/kvm_host.h
>>> @@ -255,6 +255,7 @@ struct kvm_s390_sie_block {
>>>       __u8    reservede4[4];        /* 0x00e4 */
>>>       __u64    tecmc;            /* 0x00e8 */
>>>       __u8    reservedf0[12];        /* 0x00f0 */
>>> +#define CRYCB_FORMAT_MASK 0x00000003
>>>   #define CRYCB_FORMAT1 0x00000001
>>>   #define CRYCB_FORMAT2 0x00000003
>>>       __u32    crycbd;            /* 0x00fc */
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 1f50de7..99779a6 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -1875,14 +1875,35 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>>       return r;
>>>   }
>>>
>>> -static void kvm_s390_set_crycb_format(struct kvm *kvm)
>>> +/*
>>> + * The format of the crypto control block (CRYCB) is specified in 
>>> the 3 low
>>> + * order bits of the CRYCB designation (CRYCBD) field as follows:
>>> + * Format 0: Neither the message security assist extension 3 
>>> (MSAX3) nor the
>>> + *             AP extended addressing (APXA) facility are installed.
>>> + * Format 1: The APXA facility is not installed but the MSAX3 
>>> facility is.
>>> + * Format 2: Both the APXA and MSAX3 facilities are installed
>>> + */
>>> +static void kvm_s390_format_crycb(struct kvm *kvm)
>>>   {
>>> -    kvm->arch.crypto.crycbd = (__u32)(unsigned long) 
>>> kvm->arch.crypto.crycb;
>>> +    /* Clear the CRYCB format bits - i.e., set format 0 by default */
>>> +    kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK);
>>> +
>>> +    /* Check whether MSAX3 is installed */
>>> +    if (!test_kvm_facility(kvm, 76))
>>> +        return;
>>>
>>>       if (kvm_ap_apxa_installed())
>>>           kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
>>>       else
>>>           kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>>> + one lin
>>> +    /* Enable AES/DEA protected key functions by default */
>>> +    kvm->arch.crypto.aes_kw = 1;
>>> +    kvm->arch.crypto.dea_kw = 1;
>>> + get_random_bytes(kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>>> + sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>> + get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>>> + sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>   }
>>>
>>>   static u64 kvm_s390_get_initial_cpuid(void)
>>> @@ -1896,19 +1917,17 @@ static u64 kvm_s390_get_initial_cpuid(void)
>>>
>>>   static void kvm_s390_crypto_init(struct kvm *kvm)
>>>   {
>>> -    if (!test_kvm_facility(kvm, 76))
>>> +    /*
>>> +     * If neither the AP instructions nor the message security assist
>>> +     * extension 3 (MSAX3) are installed, there is no need to 
>>> initialize a
>>> +     * crypto control block (CRYCB) for the guest.
>>> +     */
>>> +    if (!kvm_ap_instructions_available() && !test_kvm_facility(kvm, 
>>> 76))
>>>           return;
>>>
>>>       kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>>> -    kvm_s390_set_crycb_format(kvm);
>>
>>
>> For my point of view the all patch can be reduced to putting this
>> call (kvm_s390_set_crycb_format(kvm);) before testing for facility 76.
>>
>> (and setting the format correctly in kvm_s390_set_crycb_format(kvm))
>
> I don't see what that buys us; it will just be reshuffling of the logic.
> The idea here is that all of the code related to formatting the CRYCB for
> use by the guest is contained in the kvm_s390_format_crycb(kvm) function.
> We don't need a CRYCB, however, if the AP instructions are not installed
> and the MSAX3 facility is not installed, so why even call
> kvm_s390_format_crycb(kvm) in that case?

It byes a lot of lines.
I mean that you do exactly the same by only using 3 lines inserted 
instead of 65 changes.
No logic change.

>
>>
>>
>>
>>> -
>>> -    /* Enable AES/DEA protected key functions by default */
>>> -    kvm->arch.crypto.aes_kw = 1;
>>> -    kvm->arch.crypto.dea_kw = 1;
>>> - get_random_bytes(kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>>> - sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>> - get_random_bytes(kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>>> - sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>> +    kvm->arch.crypto.crycbd = (__u32)(unsigned long) 
>>> kvm->arch.crypto.crycb;
>>> +    kvm_s390_format_crycb(kvm);
>>>   }
>>>
>>>   static void sca_dispose(struct kvm *kvm)
>>> @@ -2430,17 +2449,24 @@ void kvm_arch_vcpu_postcreate(struct 
>>> kvm_vcpu *vcpu)
>>>
>>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>>   {
>>> -    if (!test_kvm_facility(vcpu->kvm, 76))
>>> +    /*
>>> +     * If a crypto control block designation (CRYCBD) has not been
>>> +     * initialized
>>> +     */
>>> +    if (vcpu->kvm->arch.crypto.crycbd == 0)
>>>           return;
>>>
>>> -    vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>>> +    vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>>
>>> -    if (vcpu->kvm->arch.crypto.aes_kw)
>>> -        vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>> -    if (vcpu->kvm->arch.crypto.dea_kw)
>>> -        vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>>> +    /* If MSAX3 is installed, set up protected key support */
>>> +    if (test_kvm_facility(vcpu->kvm, 76)) {
>>> +        vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>>>
>>> -    vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>> +        if (vcpu->kvm->arch.crypto.aes_kw)
>>> +            vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>> +        if (vcpu->kvm->arch.crypto.dea_kw)
>>> +            vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>>> +    }
>>>   }
>>>
>>>   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

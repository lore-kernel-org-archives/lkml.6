Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeCOQZX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:25:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751981AbeCOQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:20 -0400
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
 <3afd28d7-57c6-cda6-a436-18da32ef0df3@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 17:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3afd28d7-57c6-cda6-a436-18da32ef0df3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031516-0040-0000-0000-000004415593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031516-0041-0000-0000-000020E460B1
Message-Id: <7088355d-c6a0-439a-8707-61ea37af3cfa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/15/2018 04:23 PM, Tony Krowiak wrote:
> On 03/14/2018 05:57 PM, Halil Pasic wrote:
>>
>> On 03/14/2018 07:25 PM, Tony Krowiak wrote:
>>> The VFIO AP device model exploits interpretive execution of AP
>>> instructions (APIE) to provide guests passthrough access to AP
>>> devices. This patch introduces a new device attribute in the
>>> KVM_S390_VM_CRYPTO device attribute group to set APIE from
>>> the VFIO AP device defined on the guest.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>> [..]
>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index a60c45b..bc46b67 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>               sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>           VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>           break;
>>> +    case KVM_S390_VM_CRYPTO_INTERPRET_AP:
>>> +        if (attr->addr) {
>>> +            if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>> Unlock mutex before returning?
> The mutex is unlocked prior to return at the end of the function.

Pierre already pointed out what I mean.

>>
>> Maybe flip conditions (don't allow manipulating apie if feature not there).
>> Clearing the anyways clear apie if feature not there ain't too bad, but
>> rejecting the operation appears nicer to me.
> I think what you're saying is something like this:
> 
>     if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>         return -EOPNOTSUPP;
> 
>     kvm->arch.crypto.apie = (attr->addr) ? 1 : 0;
> 
> I can make arguments for doing this either way, but since the attribute
> is will most likely only be set by an AP device in userspace, I suppose
> it makes sense to allow setting of the attribute if the AP feature is
> installed. It certainly makes sense for the dedicated implementation.

No strong opinion here.

>>
>>> +                return -EOPNOTSUPP;
>>> +            kvm->arch.crypto.apie = 1;
>>> +            VM_EVENT(kvm, 3, "%s",
>>> +                 "ENABLE: AP interpretive execution");
>>> +        } else {
>>> +            kvm->arch.crypto.apie = 0;
>>> +            VM_EVENT(kvm, 3, "%s",
>>> +                 "DISABLE: AP interpretive execution");
>>> +        }
>>> +        break;
>>>       default:
>>>           mutex_unlock(&kvm->lock);
>>>           return -ENXIO;
>> I wonder how the loop after this switch works for KVM_S390_VM_CRYPTO_INTERPRET_AP:
>>
>>          kvm_for_each_vcpu(i, vcpu, kvm) {
>>                  kvm_s390_vcpu_crypto_setup(vcpu);
>>                  exit_sie(vcpu);
>>          }
>>
>>  From not doing something like for KVM_S390_VM_CRYPTO_INTERPRET_AP
>>
>>          if (kvm->created_vcpus) {
>>                  mutex_unlock(&kvm->lock);
>>                  return -EBUSY;
>> and from the aforementioned loop I guess ECA.28 can be changed
>> for a running guest.
>>
>> If there are running vcpus when KVM_S390_VM_CRYPTO_INTERPRET_AP is
>> changed (set) these will be taken out of SIE by exit_sie().  Then for the
>> corresponding threads the control probably goes to QEMU (the emulator in
>> the userspace). And it puts that vcpu back into the SIE, and then that
>> cpu starts acting according to the new ECA.28 value.  While other vcpus
>> may still work with the old value of ECA.28.
> Assuming the scenario plays out as you described, why would the other vcpus
> be using the old ECA.28 value if the kvm_s390_vcpu_crypto_setup() function
> is executed for each of them to set the new value for ECA.28?

I'm puzzled I though I just described that. The threads implementing the
vcpus are, or at least may be concurrent to the thread doing the loop and
kvm_s390_vcpu_crypto_setup() for each vcpu.

Changing the ECA.28 for each vcpu in the configuration ain't likely to be
simultaneous (we do the kvm_s390_vcpu_crypto_setup() in the loop), but even
if it were simultaneous what would guarantee that the changes is observed
as one atomic change (that is: no mix is observed by the guest)?

(And please read the documentation.)

>>
>> I'm not saying what I describe above is necessarily something broken.
>> But I would like to have it explained, why is it OK -- provided I did not
>> make any errors in my reasoning (assumptions included).
>>
>> Can you help me understand this code?
> Unless I am missing something in the scenario you described, it seems that
> the reason the exit_sie(vcpu) function is called is to ensure that the vcpus
> that are already running acquire the new attribute values changed by this
> function when they are restored to SIE. Of course, my assumption is that
> the kvm_arch_vcpu_setup() function - which calls the kvm_s390_vcpu_crypto_setup()
> function - is invoked when the vcpu is restored to SIE.

I don't know what are you talking about kvm_s390_vcpu_crypto_setup(vcpu) is
invoked in the loop. That changes the State Description.

How is it guaranteed that no vCPU is going to work according to the
new ECA.28 value before *all* vCPUs are made out of SIE by exit_sie()?

Your answers sadly didn't contribute much to my understanding. hope
mine will be more successful in contributing to yours.

Regards,
Halil

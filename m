Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDQNsh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:48:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753824AbeDQNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:48:35 -0400
Subject: Re: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all vcpus
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180417133403.6fd7627a.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 09:47:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180417133403.6fd7627a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041713-0040-0000-0000-0000041CD423
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008870; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019233; UDB=6.00519956; IPR=6.00798475;
 MB=3.00020614; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 13:48:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041713-0041-0000-0000-00000822D887
Message-Id: <0a3d569e-4328-364f-6df7-17de4f28833a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170125
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 07:34 AM, Cornelia Huck wrote:
> On Sun, 15 Apr 2018 17:22:12 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> Introduces a new function to reset the crypto attributes for all
>> vcpus whether they are running or not. Each vcpu in KVM will
>> be removed from SIE prior to resetting the crypto attributes in its
>> SIE state description. After all vcpus have had their crypto attributes
>> reset the vcpus will be restored to SIE.
>>
>> This function will be used in a later patch to set the ECA.28
>> bit in the SIE state description to enable interpretive execution of
>> AP instructions. It will also be incorporated into the
>> kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
>> key wrapping attributes could potentially get out of synch for running
>> vcpus.
> So, this description leads me to think it would make sense to queue
> this patch (fixing the key wrapping) independently of this series,
> wouldn't it?
I considered that because I figured there might be objections, but
since separating them would create dependency issues I didn't see
any harm in including it here. I can remove this from the explanation
above and the code below and create a separate patch for the key
wrapping if you'd prefer.
>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c |   19 +++++++++++++------
>>   arch/s390/kvm/kvm-s390.h |   14 ++++++++++++++
>>   2 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 64c9862..d0c3518 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -791,11 +791,21 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>>   
>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>>   
>> -static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
> _reset_all() or _set_all()? Don't really care much, tbh.
Then why bring it up?:) I chose _reset_all because in both places from which
this is called, we are changing a crypto attribute value and are thus
resetting the crypto settings for all the vcpus.
>
>>   {
>> -	struct kvm_vcpu *vcpu;
>>   	int i;
>> +	struct kvm_vcpu *vcpu;
> I'd avoid swapping the order of the declarations.
This was unintentional, I can revert it.
>
>> +
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>> +		kvm_s390_vcpu_crypto_setup(vcpu);
>>   and
>> +	kvm_s390_vcpu_unblock_all(kvm);
>> +}
>> +
>> +static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>> +{
>>   	if (!test_kvm_facility(kvm, 76))
>>   		return -EINVAL;
>>   
>> @@ -832,10 +842,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>   		return -ENXIO;
>>   	}
>>   
>> -	kvm_for_each_vcpu(i, vcpu, kvm) {
>> -		kvm_s390_vcpu_crypto_setup(vcpu);
>> -		exit_sie(vcpu);
>> -	}
>> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>>   	mutex_unlock(&kvm->lock);
>>   	return 0;
>>   }
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index 1b5621f..76324b7 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -410,4 +410,18 @@ static inline int kvm_s390_use_sca_entries(void)
>>   }
>>   void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>>   				     struct mcck_volatile_info *mcck_info);
>> +
>> +/**
>> + * kvm_s390_vcpu_crypto_reset_all
>> + *
>> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
>> + * are running as each vcpu will be removed from SIE before resetting the crypto
>> + * attributes and restored to SIE afterward.
>> + *
>> + * Note: The kvm->lock mutex must be locked prior to calling this function and
>> + *	 unlocked after it returns.
> "Must be called with kvm->lock held"?
Yes. The kvm->lock must be held to set the crypto attributes that will be
copied to the vcpus via the kvm_s390_vcpu_crypto_reset_all() function,
so it made sense to hold the lock across the entire operation.

>
>> + *
>> + * @kvm: the KVM guest
>> + */
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>>   #endif
> Other than the nits above, looks good to me.
Great!
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937724AbeBUOch (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:32:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934465AbeBUOce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:32:34 -0500
Subject: Re: [PATCH v2 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
 <20180215231206.31016.78914.stgit@tlendack-t1.amdoffice.net>
 <00583b68-d599-b709-133a-3741c258df13@redhat.com>
 <7f6a78ae-abab-2a03-aebd-e43e6fe168b4@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94f6ed44-07ab-ff0f-2a6d-b3d8ff4ff4b1@redhat.com>
Date: Wed, 21 Feb 2018 15:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7f6a78ae-abab-2a03-aebd-e43e6fe168b4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2018 15:15, Tom Lendacky wrote:
> On 2/21/2018 5:41 AM, Paolo Bonzini wrote:
>> On 16/02/2018 00:12, Tom Lendacky wrote:
>>> +static u32 msr_based_features[] = {
>>> +};
>>> +
>>> +static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
>>> +
>>>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>>>  {
>>>  	if (efer & efer_reserved_bits)
>>> @@ -2785,6 +2794,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>  	case KVM_CAP_SET_BOOT_CPU_ID:
>>>   	case KVM_CAP_SPLIT_IRQCHIP:
>>>  	case KVM_CAP_IMMEDIATE_EXIT:
>>> +	case KVM_CAP_GET_MSR_FEATURES:
>>>  		r = 1;
>>>  		break;
>>>  	case KVM_CAP_ADJUST_CLOCK:
>>> @@ -4410,6 +4420,47 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>>  			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
>>>  		break;
>>>  	}
>>> +	case KVM_GET_MSR_INDEX_LIST: {
>>> +		struct kvm_msr_list __user *user_msr_list = argp;
>>> +		struct kvm_msr_list msr_list;
>>> +		unsigned int n;
>>> +
>>> +		r = -EFAULT;
>>> +		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
>>> +			goto out;
>>> +		n = msr_list.nmsrs;
>>> +		msr_list.nmsrs = num_msr_based_features;
>>> +		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
>>> +			goto out;
>>> +		r = -E2BIG;
>>> +		if (n < msr_list.nmsrs)
>>> +			goto out;
>>> +		r = -EFAULT;
>>> +		if (copy_to_user(user_msr_list->indices, &msr_based_features,
>>> +				 num_msr_based_features * sizeof(u32)))
>>> +			goto out;
>>> +		r = 0;
>>> +		break;
>>
>> I think it's better to have some logic in kvm_init_msr_list, to filter
>> the MSR list based on whatever MSRs the backend provides.
> 
> Ok, that's what I had originally and then you said to just return the full
> list and let KVM_GET_MSR return a 0 or 1 if it was supported. I can switch
> it back.

Hmm, I cannot find this remark (I would have been very confused, so I
tried to look for it).  I commented on removing kvm_valid_msr_feature,
but not kvm_init_msr_list.

>>
>>> +	}
>>> +	case KVM_GET_MSR: {
>>
>> It's not that the API isn't usable, KVM_GET_MSR is fine for what we need
>> here (it's not a fast path), but it's a bit confusing to have
>> KVM_GET_MSR and KVM_GET_MSRS.
>>
>> I see two possibilities:
>>
>> 1) reuse KVM_GET_MSRS as in the previous version.  It's okay to
>> cut-and-paste code from msr_io.
> 
> If I go back to trimming the list based on support, then KVM_GET_MSRS can
> be used.

No problem, renaming is enough---I should have made a better suggestion
in the previous review.

Paolo

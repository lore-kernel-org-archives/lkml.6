Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967122AbeBNKIi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:08:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966971AbeBNKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:08:36 -0500
Subject: Re: [RFC PATCH 2/2] KVM: SVM: Add MSR feature support for serializing
 LFENCE
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225856.22074.98252.stgit@tlendack-t1.amdoffice.net>
 <584e51cc-1a79-4e5d-45ef-1850bb6c155e@redhat.com>
 <ee66fc2c-ba57-29da-0a03-498bc45a40fb@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e3e64dc-00e4-adbd-2dd7-c44f8886ea52@redhat.com>
Date: Wed, 14 Feb 2018 11:08:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ee66fc2c-ba57-29da-0a03-498bc45a40fb@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 05:39, Tom Lendacky wrote:
> On 2/13/2018 10:22 AM, Paolo Bonzini wrote:
>> On 08/02/2018 23:58, Tom Lendacky wrote:
>>> Create an entry in the new MSR as a feature framework to allow a guest to
>>> recognize LFENCE as a serializing instruction on AMD processors.  The MSR
>>> can only be set by the host, any write by the guest will be ignored.  A
>>> read by the guest will return the value as set by the host.  In this way,
>>> the support to expose the feature to the guest is controlled by the
>>> hypervisor.
>>>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>  arch/x86/kvm/svm.c |   16 ++++++++++++++++
>>>  arch/x86/kvm/x86.c |    6 ++++++
>>>  2 files changed, 22 insertions(+)
>>>
>>> @@ -4047,6 +4052,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>>  	case MSR_VM_IGNNE:
>>>  		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
>>>  		break;
>>> +	case MSR_F10H_DECFG:
>>> +		/* Only the host can set this MSR, silently ignore */
>>> +		if (!msr->host_initiated)
>>> +			break;
>>
>> Just one thing I'm wondering, should we #GP if the guest attempts to
>> clear MSR_F10H_DECFG_LFENCE_SERIALIZE?
> 
> It would be more consistent with other entries to do "return 1" here
> instead.  The current kernel code that writes this bit is using
> msr_set_bit(), so a #GP is caught and handled.

That's also okay.  We don't know about Windows though...

Paolo

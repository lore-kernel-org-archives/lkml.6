Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032771AbeBNQlP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:41:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032470AbeBNQlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:41:13 -0500
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
 <1105042a-327b-9be9-c0be-5f07f7110852@redhat.com>
 <79f0ea64-6634-4b1c-7ac6-82f6798c680b@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f76fafc-ce4a-8460-261e-93480e694609@redhat.com>
Date: Wed, 14 Feb 2018 17:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <79f0ea64-6634-4b1c-7ac6-82f6798c680b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 05:42, Tom Lendacky wrote:
>>> +bool kvm_valid_msr_feature(u32 msr, u64 data)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < num_msr_based_features; i++) {
>>> +		struct kvm_msr_based_features *m = msr_based_features + i;
>>> +
>>> +		if (msr != m->msr)
>>> +			continue;
>>> +
>>> +		/* Make sure not trying to change unsupported bits */
>>> +		return (data & ~m->mask) ? false : true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +EXPORT_SYMBOL_GPL(kvm_valid_msr_feature);
>>> +
>>
>> This is probably unnecessary too (the allowed values are a bit more
>> complicated for, you just guessed it, VMX capability MSRs) and you can
>> just check bits other than LFENCE in svm_set_msr.
>
> The whole routine or just the bit checking?  I can see still needing the
> check to be sure the "feature" is present.

You can return the MSR unconditionally from KVM_GET_MSR_INDEX_LIST.
Then KVM_GET_MSR would return 0 or 1 depending on whether the feature is
present.

Paolo

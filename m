Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeAaRhO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:37:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753158AbeAaRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:37:13 -0500
Subject: Re: [PATCH v2 3/3] KVM: VMX: make MSR bitmaps per-VCPU
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
References: <1517043027-7655-1-git-send-email-pbonzini@redhat.com>
 <1517043027-7655-4-git-send-email-pbonzini@redhat.com>
 <20180130162357.GE22015@flask>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc794c7a-dec4-34dd-d7ac-6c0d49f138f1@redhat.com>
Date: Wed, 31 Jan 2018 12:37:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130162357.GE22015@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2018 11:23, Radim Krčmář wrote:
> 2018-01-27 09:50+0100, Paolo Bonzini:
>> Place the MSR bitmap in struct loaded_vmcs, and update it in place
>> every time the x2apic or APICv state can change.  This is rare and
>> the loop can handle 64 MSRs per iteration, in a similar fashion as
>> nested_vmx_prepare_msr_bitmap.
>>
>> This prepares for choosing, on a per-VM basis, whether to intercept
>> the SPEC_CTRL and PRED_CMD MSRs.
>>
>> Suggested-by: Jim Mattson <jmattson@google.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> @@ -10022,7 +10043,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
>>  	int msr;
>>  	struct page *page;
>>  	unsigned long *msr_bitmap_l1;
>> -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.msr_bitmap;
>> +	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
> 
> The physical address of the nested msr_bitmap is never loaded into vmcs.
> 
> The resolution you provided had extra hunk in prepare_vmcs02_full():
> 
> +	vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
> 
> I have queued that as:
> 
> +	if (cpu_has_vmx_msr_bitmap())
> +		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));

Hmm you're right, it should be in prepare_vmcs02() here (4.15-based),
and then moved to prepare_vmcs02_full() as part of the conflict resolution.

I'll send a v3.

Paolo

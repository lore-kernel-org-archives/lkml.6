Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D120FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D9D21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D9D21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeIZXcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeIZXcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55318308214B;
        Wed, 26 Sep 2018 17:18:35 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 992A2611A6;
        Wed, 26 Sep 2018 17:18:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] x86/kvm/mmu: introduce guest_mmu
In-Reply-To: <20180926140240.GC27433@linux.intel.com>
References: <20180925175844.20277-1-vkuznets@redhat.com> <20180925175844.20277-5-vkuznets@redhat.com> <20180926140240.GC27433@linux.intel.com>
Date:   Wed, 26 Sep 2018 19:18:32 +0200
Message-ID: <87wor8npnb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 26 Sep 2018 17:18:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Sep 25, 2018 at 07:58:39PM +0200, Vitaly Kuznetsov wrote:
>> When EPT is used for nested guest we need to re-init MMU as shadow
>> EPT MMU (nested_ept_init_mmu_context() does that). When we return back
>> from L2 to L1 kvm_mmu_reset_context() in nested_vmx_load_cr3() resets
>> MMU back to normal TDP mode. Add a special 'guest_mmu' so we can use
>> separate root caches; the improved hit rate is not very important for
>> single vCPU performance, but it avoids contention on the mmu_lock for
>> many vCPUs.
>> 
>> On the nested CPUID benchmark, with 16 vCPUs, an L2->L1->L2 vmexit
>> goes from 42k to 26k cycles.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> Changes since v1:
>> - drop now unneded local vmx variable in vmx_free_vcpu_nested
>>   [Sean Christopherson]
>> ---
>>  arch/x86/include/asm/kvm_host.h |  3 +++
>>  arch/x86/kvm/mmu.c              | 15 +++++++++++----
>>  arch/x86/kvm/vmx.c              | 27 ++++++++++++++++++---------
>>  3 files changed, 32 insertions(+), 13 deletions(-)
>
> ...
>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 2d55adab52de..93ff08136fc1 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -8468,8 +8468,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
>>   * Free whatever needs to be freed from vmx->nested when L1 goes down, or
>>   * just stops using VMX.
>>   */
>> -static void free_nested(struct vcpu_vmx *vmx)
>> +static void free_nested(struct kvm_vcpu *vcpu)
>>  {
>> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> +
>>  	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
>>  		return;
>>  
>> @@ -8502,6 +8504,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>>  		vmx->nested.pi_desc = NULL;
>>  	}
>>  
>> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
>> +
>>  	free_loaded_vmcs(&vmx->nested.vmcs02);
>>  }
>>  
>> @@ -8510,7 +8514,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
>>  {
>>  	if (!nested_vmx_check_permission(vcpu))
>>  		return 1;
>> -	free_nested(to_vmx(vcpu));
>> +	free_nested(vcpu);
>>  	nested_vmx_succeed(vcpu);
>>  	return kvm_skip_emulated_instruction(vcpu);
>>  }
>> @@ -8541,6 +8545,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>>  	if (vmptr == vmx->nested.current_vmptr)
>>  		nested_release_vmcs12(vmx);
>>  
>> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
>
> Shouldn't we only free guest_mmu if VMCLEAR is targeting
> current_vmptr?

Right you are, this was definitely overlooked, no need for
kvm_mmu_free_roots() when we VMCLEAR some-other-vmptr.

> Assuming that's the case, we could put the call to kvm_mmu_free_roots()
> in nested_release_vmcs12() instead of calling it from handle_vmclear()
> and handle_vmptrld().

Yep, will do in v3.

>
>> +
>>  	kvm_vcpu_write_guest(vcpu,
>>  			vmptr + offsetof(struct vmcs12, launch_state),
>>  			&zero, sizeof(zero));
>> @@ -8924,6 +8930,9 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>>  		}
>>  
>>  		nested_release_vmcs12(vmx);
>> +
>> +		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu,
>> +				   KVM_MMU_ROOTS_ALL);
>>  		/*
>>  		 * Load VMCS12 from guest memory since it is not already
>>  		 * cached.
>> @@ -10976,12 +10985,10 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>>   */
>>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>>  {
>> -       struct vcpu_vmx *vmx = to_vmx(vcpu);
>> -
>> -       vcpu_load(vcpu);
>> -       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
>> -       free_nested(vmx);
>> -       vcpu_put(vcpu);
>> +	vcpu_load(vcpu);
>> +	vmx_switch_vmcs(vcpu, &to_vmx(vcpu)->vmcs01);
>> +	free_nested(vcpu);
>> +	vcpu_put(vcpu);
>>  }
>>  
>>  static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
>> @@ -11331,6 +11338,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>>  	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
>>  		return 1;
>>  
>> +	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
>>  	kvm_init_shadow_ept_mmu(vcpu,
>>  			to_vmx(vcpu)->nested.msrs.ept_caps &
>>  			VMX_EPT_EXECUTE_ONLY_BIT,
>> @@ -11346,6 +11354,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>>  
>>  static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
>>  {
>> +	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>>  }
>>  
>> @@ -13421,7 +13430,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
>>  		to_vmx(vcpu)->nested.nested_run_pending = 0;
>>  		nested_vmx_vmexit(vcpu, -1, 0, 0);
>>  	}
>> -	free_nested(to_vmx(vcpu));
>> +	free_nested(vcpu);
>>  }
>>  
>>  /*
>> -- 
>> 2.17.1
>> 

-- 
Vitaly

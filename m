Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96553C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5968C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5968C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIZUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:15:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:17316 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbeIZUPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:15:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="93888618"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.55])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 07:02:39 -0700
Date:   Wed, 26 Sep 2018 07:02:40 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] x86/kvm/mmu: introduce guest_mmu
Message-ID: <20180926140240.GC27433@linux.intel.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
 <20180925175844.20277-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925175844.20277-5-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:58:39PM +0200, Vitaly Kuznetsov wrote:
> When EPT is used for nested guest we need to re-init MMU as shadow
> EPT MMU (nested_ept_init_mmu_context() does that). When we return back
> from L2 to L1 kvm_mmu_reset_context() in nested_vmx_load_cr3() resets
> MMU back to normal TDP mode. Add a special 'guest_mmu' so we can use
> separate root caches; the improved hit rate is not very important for
> single vCPU performance, but it avoids contention on the mmu_lock for
> many vCPUs.
> 
> On the nested CPUID benchmark, with 16 vCPUs, an L2->L1->L2 vmexit
> goes from 42k to 26k cycles.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> Changes since v1:
> - drop now unneded local vmx variable in vmx_free_vcpu_nested
>   [Sean Christopherson]
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/mmu.c              | 15 +++++++++++----
>  arch/x86/kvm/vmx.c              | 27 ++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 13 deletions(-)

...

> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 2d55adab52de..93ff08136fc1 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -8468,8 +8468,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
>   * Free whatever needs to be freed from vmx->nested when L1 goes down, or
>   * just stops using VMX.
>   */
> -static void free_nested(struct vcpu_vmx *vmx)
> +static void free_nested(struct kvm_vcpu *vcpu)
>  {
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
>  	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
>  		return;
>  
> @@ -8502,6 +8504,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>  		vmx->nested.pi_desc = NULL;
>  	}
>  
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
> +
>  	free_loaded_vmcs(&vmx->nested.vmcs02);
>  }
>  
> @@ -8510,7 +8514,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
>  {
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
> -	free_nested(to_vmx(vcpu));
> +	free_nested(vcpu);
>  	nested_vmx_succeed(vcpu);
>  	return kvm_skip_emulated_instruction(vcpu);
>  }
> @@ -8541,6 +8545,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  	if (vmptr == vmx->nested.current_vmptr)
>  		nested_release_vmcs12(vmx);
>  
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);

Shouldn't we only free guest_mmu if VMCLEAR is targeting current_vmptr?
Assuming that's the case, we could put the call to kvm_mmu_free_roots()
in nested_release_vmcs12() instead of calling it from handle_vmclear()
and handle_vmptrld().

> +
>  	kvm_vcpu_write_guest(vcpu,
>  			vmptr + offsetof(struct vmcs12, launch_state),
>  			&zero, sizeof(zero));
> @@ -8924,6 +8930,9 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  		}
>  
>  		nested_release_vmcs12(vmx);
> +
> +		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu,
> +				   KVM_MMU_ROOTS_ALL);
>  		/*
>  		 * Load VMCS12 from guest memory since it is not already
>  		 * cached.
> @@ -10976,12 +10985,10 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>   */
>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>  {
> -       struct vcpu_vmx *vmx = to_vmx(vcpu);
> -
> -       vcpu_load(vcpu);
> -       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> -       free_nested(vmx);
> -       vcpu_put(vcpu);
> +	vcpu_load(vcpu);
> +	vmx_switch_vmcs(vcpu, &to_vmx(vcpu)->vmcs01);
> +	free_nested(vcpu);
> +	vcpu_put(vcpu);
>  }
>  
>  static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
> @@ -11331,6 +11338,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>  	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
>  		return 1;
>  
> +	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
>  	kvm_init_shadow_ept_mmu(vcpu,
>  			to_vmx(vcpu)->nested.msrs.ept_caps &
>  			VMX_EPT_EXECUTE_ONLY_BIT,
> @@ -11346,6 +11354,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>  
>  static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
>  {
> +	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  }
>  
> @@ -13421,7 +13430,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
>  		to_vmx(vcpu)->nested.nested_run_pending = 0;
>  		nested_vmx_vmexit(vcpu, -1, 0, 0);
>  	}
> -	free_nested(to_vmx(vcpu));
> +	free_nested(vcpu);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

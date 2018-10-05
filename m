Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ADFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2563D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2563D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeJFCXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:23:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:45679 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbeJFCXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:23:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 12:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,345,1534834800"; 
   d="scan'208";a="238859253"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2018 12:22:43 -0700
Date:   Fri, 5 Oct 2018 12:22:43 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] x86/kvm/mmu: introduce guest_mmu
Message-ID: <20181005192243.GB13957@linux.intel.com>
References: <20181001142010.21132-1-vkuznets@redhat.com>
 <20181001142010.21132-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001142010.21132-5-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:20:05PM +0200, Vitaly Kuznetsov wrote:
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

One nit below, otherwise:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
> Changes since v2:
> - move kvm_mmu_free_roots() call to nested_release_vmcs12().
>   [Sean Christopherson]
> - in kvm_calc_shadow_ept_root_page_role() we need to inherit role
>   from root_mmu so fields like .smap_andnot_wp, .smep_andnot_wp, ...
>   remain correctly initialized [pointed out by Sean Christopherson]
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/mmu.c              | 18 +++++++++++++----
>  arch/x86/kvm/vmx.c              | 35 +++++++++++++++++++++------------
>  3 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 404c3438827b..a3829869353b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -539,6 +539,9 @@ struct kvm_vcpu_arch {
>  	/* Non-nested MMU for L1 */
>  	struct kvm_mmu root_mmu;
>  
> +	/* L1 MMU when running nested */
> +	struct kvm_mmu guest_mmu;
> +
>  	/*
>  	 * Paging state of an L2 guest (used for nested npt)
>  	 *
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 9cb2f9307e98..bb6584222848 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4818,6 +4818,9 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
>  {
>  	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;

@role is initialized by the new code below, this can be removed,
e.g. it's eventually removed by patch 7/9 when the two pieces of
the combined role are initialized independently.

> +	/* Role is inherited from root_mmu */
> +	role.word = vcpu->arch.root_mmu.base_role.word;
> +
>  	role.level = PT64_ROOT_4LEVEL;
>  	role.direct = false;
>  	role.ad_disabled = !accessed_dirty;
> @@ -4966,8 +4969,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
>  
>  void kvm_mmu_unload(struct kvm_vcpu *vcpu)
>  {
> -	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
> -	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
> +	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
> +	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
>  }
>  EXPORT_SYMBOL_GPL(kvm_mmu_unload);
>  
> @@ -5406,13 +5411,18 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>  
>  	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
> +
>  	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
>  	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
> -	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
> -
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
>  		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
>  
> +	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
> +	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
> +	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
> +		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
> +
> +	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
>  	return alloc_mmu_pages(vcpu);
>  }
>  
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 9a3aece131fb..73f04a8638d3 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -8442,8 +8442,10 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
>  	vmcs_write64(VMCS_LINK_POINTER, -1ull);
>  }
>  
> -static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
> +static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
>  {
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
>  	if (vmx->nested.current_vmptr == -1ull)
>  		return;
>  
> @@ -8457,10 +8459,12 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
>  	vmx->nested.posted_intr_nv = -1;
>  
>  	/* Flush VMCS12 to guest memory */
> -	kvm_vcpu_write_guest_page(&vmx->vcpu,
> +	kvm_vcpu_write_guest_page(vcpu,
>  				  vmx->nested.current_vmptr >> PAGE_SHIFT,
>  				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
>  
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
> +
>  	vmx->nested.current_vmptr = -1ull;
>  }
>  
> @@ -8468,8 +8472,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
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
> @@ -8502,6 +8508,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>  		vmx->nested.pi_desc = NULL;
>  	}
>  
> +	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
> +
>  	free_loaded_vmcs(&vmx->nested.vmcs02);
>  }
>  
> @@ -8510,7 +8518,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
>  {
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
> -	free_nested(to_vmx(vcpu));
> +	free_nested(vcpu);
>  	nested_vmx_succeed(vcpu);
>  	return kvm_skip_emulated_instruction(vcpu);
>  }
> @@ -8539,7 +8547,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  	}
>  
>  	if (vmptr == vmx->nested.current_vmptr)
> -		nested_release_vmcs12(vmx);
> +		nested_release_vmcs12(vcpu);
>  
>  	kvm_vcpu_write_guest(vcpu,
>  			vmptr + offsetof(struct vmcs12, launch_state),
> @@ -8923,7 +8931,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  			return kvm_skip_emulated_instruction(vcpu);
>  		}
>  
> -		nested_release_vmcs12(vmx);
> +		nested_release_vmcs12(vcpu);
> +
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
> @@ -11347,6 +11355,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>  
>  static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
>  {
> +	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  }
>  
> @@ -13422,7 +13431,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
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

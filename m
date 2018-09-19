Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14409C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07A62098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeISUrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:47:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:18567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731266AbeISUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:47:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 08:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="72095886"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.148])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2018 08:08:34 -0700
Message-ID: <1537369714.9937.24.camel@intel.com>
Subject: Re: [PATCH v1 RESEND 4/9] x86/kvm/mmu: introduce guest_mmu
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 08:08:34 -0700
In-Reply-To: <20180918160906.9241-5-vkuznets@redhat.com>
References: <20180918160906.9241-1-vkuznets@redhat.com>
         <20180918160906.9241-5-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 18:09 +0200, Vitaly Kuznetsov wrote:
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
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/mmu.c              | 15 +++++++++++----
>  arch/x86/kvm/vmx.c              | 27 +++++++++++++++++++--------
>  3 files changed, 33 insertions(+), 12 deletions(-)

...

> @@ -10926,12 +10935,12 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>   */
>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>  {
> -       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);

Might be worth dropping the local @vmx and calling to_vmx() inline
since it's now being used only for the call to vmx_switch_vmcs().

> 
> -       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> -       free_nested(vmx);
> -       vcpu_put(vcpu);
> +	vcpu_load(vcpu);
> +	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> +	free_nested(vcpu);
> +	vcpu_put(vcpu);
>  }
>
>  static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
> @@ -11281,6 +11290,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>  	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
>  		return 1;
>  
> +	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
>  	kvm_init_shadow_ept_mmu(vcpu,
>  			to_vmx(vcpu)->nested.msrs.ept_caps &
>  			VMX_EPT_EXECUTE_ONLY_BIT,
> @@ -11296,6 +11306,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
>  
>  static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
>  {
> +	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  }
>  
> @@ -13363,7 +13374,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
>  		to_vmx(vcpu)->nested.nested_run_pending = 0;
>  		nested_vmx_vmexit(vcpu, -1, 0, 0);
>  	}
> -	free_nested(to_vmx(vcpu));
> +	free_nested(vcpu);
>  }
>  
>  /*

Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07300C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF10B214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF10B214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIZV3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:29:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:27690 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZV3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:29:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 08:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="265910750"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.55])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2018 08:15:48 -0700
Date:   Wed, 26 Sep 2018 08:15:48 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] x86/kvm/mmu: check if tdp/shadow MMU
 reconfiguration is needed
Message-ID: <20180926151548.GJ27433@linux.intel.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
 <20180925175844.20277-9-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925175844.20277-9-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:58:43PM +0200, Vitaly Kuznetsov wrote:
> MMU reconfiguration in init_kvm_tdp_mmu()/kvm_init_shadow_mmu() can be
> avoided if the source data used to configure it didn't change; enhance
> kvm_mmu_scache with the required fields and consolidate common code in

Nit: kvm_mmu_scache no longer exists, probably say "source cache" instead?

> kvm_calc_mmu_role_common().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +
>  arch/x86/kvm/mmu.c              | 86 +++++++++++++++++++--------------
>  2 files changed, 52 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 87ddaa1579e7..609811066580 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -284,10 +284,12 @@ union kvm_mmu_extended_role {
>  	struct {
>  		unsigned int valid:1;
>  		unsigned int execonly:1;
> +		unsigned int cr0_pg:1;
>  		unsigned int cr4_pse:1;
>  		unsigned int cr4_pke:1;
>  		unsigned int cr4_smap:1;
>  		unsigned int cr4_smep:1;
> +		unsigned int cr4_la57:1;
>  	};
>  };
>  
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index d8611914544a..f676c14d5c62 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4709,34 +4709,40 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
>  }
>  
>  static union kvm_mmu_role
> -kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu)
> +kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu, bool mmu_init)
>  {
>  	union kvm_mmu_role role = {0};
>  
>  	role.base.access = ACC_ALL;
> +	role.base.nxe = !!is_nx(vcpu);
> +	role.base.cr4_pae = !!is_pae(vcpu);
>  	role.base.cr0_wp = is_write_protection(vcpu);
> +	role.base.smm = is_smm(vcpu);
> +	role.base.guest_mode = is_guest_mode(vcpu);
>  
> +	if (!mmu_init)
> +		return role;

Can you add a comment explaining why we don't fill in role.ext when
!mmu_init?  Or maybe just rename mmu_init to something like base_only?
From what I can tell it's false when we only care about the base role,
which just happens to be only in the non-init flow.

> +
> +	role.ext.cr0_pg = !!is_paging(vcpu);
>  	role.ext.cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
>  	role.ext.cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
>  	role.ext.cr4_pse = !!is_pse(vcpu);
>  	role.ext.cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
> +	role.ext.cr4_la57 = kvm_read_cr4_bits(vcpu, X86_CR4_LA57) != 0;
>  
>  	role.ext.valid = 1;
>  
>  	return role;
>  }
>  
> -static union kvm_mmu_page_role
> -kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
> +static union kvm_mmu_role
> +kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool mmu_init)
>  {
> -	union kvm_mmu_page_role role = {0};
> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, mmu_init);
>  
> -	role.guest_mode = is_guest_mode(vcpu);
> -	role.smm = is_smm(vcpu);
> -	role.ad_disabled = (shadow_accessed_mask == 0);
> -	role.level = kvm_x86_ops->get_tdp_level(vcpu);
> -	role.direct = true;
> -	role.access = ACC_ALL;
> +	role.base.ad_disabled = (shadow_accessed_mask == 0);
> +	role.base.level = kvm_x86_ops->get_tdp_level(vcpu);
> +	role.base.direct = true;
>  
>  	return role;
>  }
> @@ -4744,9 +4750,14 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
>  static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_tdp_mmu_root_page_role(vcpu, true);
>  
> -	context->mmu_role.base.word = mmu_base_role_mask.word &
> -				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
> +	new_role.base.word &= mmu_base_role_mask.word;
> +	if (new_role.as_u64 == context->mmu_role.as_u64)
> +		return;
> +
> +	context->mmu_role.as_u64 = new_role.as_u64;
>  	context->page_fault = tdp_page_fault;
>  	context->sync_page = nonpaging_sync_page;
>  	context->invlpg = nonpaging_invlpg;
> @@ -4786,29 +4797,23 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>  	reset_tdp_shadow_zero_bits_mask(vcpu, context);
>  }
>  
> -static union kvm_mmu_page_role
> -kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
> -{
> -	union kvm_mmu_page_role role = {0};
> -	bool smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
> -	bool smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
> -
> -	role.nxe = is_nx(vcpu);
> -	role.cr4_pae = !!is_pae(vcpu);
> -	role.cr0_wp  = is_write_protection(vcpu);
> -	role.smep_andnot_wp = smep && !is_write_protection(vcpu);
> -	role.smap_andnot_wp = smap && !is_write_protection(vcpu);
> -	role.guest_mode = is_guest_mode(vcpu);
> -	role.smm = is_smm(vcpu);
> -	role.direct = !is_paging(vcpu);
> -	role.access = ACC_ALL;
> +static union kvm_mmu_role
> +kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool mmu_init)
> +{
> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, mmu_init);
> +
> +	role.base.smep_andnot_wp = role.ext.cr4_smep &&
> +		!is_write_protection(vcpu);
> +	role.base.smap_andnot_wp = role.ext.cr4_smap &&
> +		!is_write_protection(vcpu);
> +	role.base.direct = !is_paging(vcpu);
>  
>  	if (!is_long_mode(vcpu))
> -		role.level = PT32E_ROOT_LEVEL;
> +		role.base.level = PT32E_ROOT_LEVEL;
>  	else if (is_la57_mode(vcpu))
> -		role.level = PT64_ROOT_5LEVEL;
> +		role.base.level = PT64_ROOT_5LEVEL;
>  	else
> -		role.level = PT64_ROOT_4LEVEL;
> +		role.base.level = PT64_ROOT_4LEVEL;
>  
>  	return role;
>  }
> @@ -4816,6 +4821,12 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
>  void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_shadow_mmu_root_page_role(vcpu, true);
> +
> +	new_role.base.word &= mmu_base_role_mask.word;
> +	if (new_role.as_u64 == context->mmu_role.as_u64)
> +		return;
>  
>  	if (!is_paging(vcpu))
>  		nonpaging_init_context(vcpu, context);
> @@ -4826,8 +4837,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>  	else
>  		paging32_init_context(vcpu, context);
>  
> -	context->mmu_role.base.word = mmu_base_role_mask.word &
> -				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
> +	context->mmu_role.as_u64 = new_role.as_u64;
>  	reset_shadow_zero_bits_mask(vcpu, context);
>  }
>  EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
> @@ -4836,7 +4846,7 @@ static union kvm_mmu_role
>  kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
>  				   bool execonly)
>  {
> -	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu);
> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, true);
>  
>  	role.base.level = PT64_ROOT_4LEVEL;
>  	role.base.direct = false;
> @@ -4961,10 +4971,14 @@ EXPORT_SYMBOL_GPL(kvm_init_mmu);
>  static union kvm_mmu_page_role
>  kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu)
>  {
> +	union kvm_mmu_role role;
> +
>  	if (tdp_enabled)
> -		return kvm_calc_tdp_mmu_root_page_role(vcpu);
> +		role = kvm_calc_tdp_mmu_root_page_role(vcpu, false);
>  	else
> -		return kvm_calc_shadow_mmu_root_page_role(vcpu);
> +		role = kvm_calc_shadow_mmu_root_page_role(vcpu, false);
> +
> +	return role.base;
>  }
>  
>  void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
> -- 
> 2.17.1
> 

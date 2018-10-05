Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A21C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E29221473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E29221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFCiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:38:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:6594 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeJFCiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:38:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 12:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,345,1534834800"; 
   d="scan'208";a="263237412"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2018 12:37:07 -0700
Date:   Fri, 5 Oct 2018 12:37:07 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] x86/kvm/mmu: check if tdp/shadow MMU
 reconfiguration is needed
Message-ID: <20181005193707.GD13957@linux.intel.com>
References: <20181001142010.21132-1-vkuznets@redhat.com>
 <20181001142010.21132-9-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001142010.21132-9-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:20:09PM +0200, Vitaly Kuznetsov wrote:
> MMU reconfiguration in init_kvm_tdp_mmu()/kvm_init_shadow_mmu() can be
> avoided if the source data used to configure it didn't change; enhance
> MMU extended role with the required fields and consolidate common code in
> kvm_calc_mmu_role_common().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Same comments about kvm_read_cr4_bits(), otherwise:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
> Changes since v2:
> - Rename 'mmu_init' parameter to 'base_only' [Sean Christopherson]
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +
>  arch/x86/kvm/mmu.c              | 95 +++++++++++++++++++++------------
>  2 files changed, 63 insertions(+), 34 deletions(-)
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
> index d303f722d671..10b39ff83943 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4712,27 +4712,46 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
>  {
>  	union kvm_mmu_extended_role ext = {0};
>  
> +	ext.cr0_pg = !!is_paging(vcpu);
>  	ext.cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
>  	ext.cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
>  	ext.cr4_pse = !!is_pse(vcpu);
>  	ext.cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
> +	ext.cr4_la57 = kvm_read_cr4_bits(vcpu, X86_CR4_LA57) != 0;

Can be !!kvm_read_cr4_bits() or maybe just kvm_read_cr4_bits().

>  
>  	ext.valid = 1;
>  
>  	return ext;
>  }
>  
> -static union kvm_mmu_page_role
> -kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
> +static union kvm_mmu_role kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu,
> +						   bool base_only)
> +{
> +	union kvm_mmu_role role = {0};
> +
> +	role.base.access = ACC_ALL;
> +	role.base.nxe = !!is_nx(vcpu);
> +	role.base.cr4_pae = !!is_pae(vcpu);
> +	role.base.cr0_wp = is_write_protection(vcpu);
> +	role.base.smm = is_smm(vcpu);
> +	role.base.guest_mode = is_guest_mode(vcpu);
> +
> +	if (base_only)
> +		return role;
> +
> +	role.ext = kvm_calc_mmu_role_ext(vcpu);
> +
> +	return role;
> +}
> +
> +static union kvm_mmu_role
> +kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
>  {
> -	union kvm_mmu_page_role role = {0};
> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
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
> @@ -4740,9 +4759,14 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
>  static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_tdp_mmu_root_page_role(vcpu, false);
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
> @@ -4782,29 +4806,23 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
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
> +kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
> +{
> +	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
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
> @@ -4812,6 +4830,12 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
>  void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
> +
> +	new_role.base.word &= mmu_base_role_mask.word;
> +	if (new_role.as_u64 == context->mmu_role.as_u64)
> +		return;
>  
>  	if (!is_paging(vcpu))
>  		nonpaging_init_context(vcpu, context);
> @@ -4822,8 +4846,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
>  	else
>  		paging32_init_context(vcpu, context);
>  
> -	context->mmu_role.base.word = mmu_base_role_mask.word &
> -				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
> +	context->mmu_role.as_u64 = new_role.as_u64;
>  	reset_shadow_zero_bits_mask(vcpu, context);
>  }
>  EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
> @@ -4961,10 +4984,14 @@ EXPORT_SYMBOL_GPL(kvm_init_mmu);
>  static union kvm_mmu_page_role
>  kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu)
>  {
> +	union kvm_mmu_role role;
> +
>  	if (tdp_enabled)
> -		return kvm_calc_tdp_mmu_root_page_role(vcpu);
> +		role = kvm_calc_tdp_mmu_root_page_role(vcpu, true);
>  	else
> -		return kvm_calc_shadow_mmu_root_page_role(vcpu);
> +		role = kvm_calc_shadow_mmu_root_page_role(vcpu, true);
> +
> +	return role.base;
>  }
>  
>  void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
> -- 
> 2.17.1
> 

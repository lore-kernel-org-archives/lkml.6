Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0496C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDC2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACDC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeIYQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:06:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeIYQG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:06:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9099CC05D3E4;
        Tue, 25 Sep 2018 09:59:41 +0000 (UTC)
Received: from [10.36.117.173] (ovpn-117-173.ams2.redhat.com [10.36.117.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAFAC5C3FA;
        Tue, 25 Sep 2018 09:59:36 +0000 (UTC)
Subject: Re: [PATCH v5 16/18] kvm: arm64: Set a limit on the IPA size
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-17-suzuki.poulose@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d915accb-966f-5c3d-f969-45512ebd8ca5@redhat.com>
Date:   Tue, 25 Sep 2018 11:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917104144.19188-17-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 25 Sep 2018 09:59:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
> So far we have restricted the IPA size of the VM to the default
> value (40bits). Now that we can manage the IPA size per VM and
> support dynamic stage2 page tables, we can allow VMs to have
> larger IPA. This patch introduces a the maximum IPA size
> supported on the host.
to be reworded
 This is decided by the following factors :
> 
>  1) Maximum PARange supported by the CPUs - This can be inferred
>     from the system wide safe value.
>  2) Maximum PA size supported by the host kernel (48 vs 52)
>  3) Number of levels in the host page table (as we base our
>     stage2 tables on the host table helpers).
> 
> Since the stage2 page table code is dependent on the stage1
> page table, we always ensure that :
> 
>   Number of Levels at Stage1 >= Number of Levels at Stage2
> 
> So we limit the IPA to make sure that the above condition
> is satisfied. This will affect the following combinations
> of VA_BITS and IPA for different page sizes.
> 
>   Host configuration | Unsupported IPA ranges
>   39bit VA, 4K       | [44, 48]
>   36bit VA, 16K      | [41, 48]
>   42bit VA, 64K      | [47, 52]
> 
> Supporting the above combinations need independent stage2
> page table manipulation code, which would need substantial
> changes. We could purse the solution independently and
> switch the page table code once we have it ready.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Restrict the IPA size to limit the number of page table
>    levels in stage2 to that of stage1 or less.
> ---
>  arch/arm/include/asm/kvm_mmu.h    |  2 ++
>  arch/arm64/include/asm/kvm_host.h |  2 ++
>  arch/arm64/kvm/reset.c            | 43 +++++++++++++++++++++++++++++++
>  virt/kvm/arm/arm.c                |  2 ++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 12ae5fbbcf01..5ad1a54f98dc 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -358,6 +358,8 @@ static inline int hyp_map_aux_data(void)
>  
>  #define kvm_phys_to_vttbr(addr)		(addr)
>  
> +static inline void kvm_set_ipa_limit(void) {}
> +
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif /* __ARM_KVM_MMU_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 5ecd457bce7d..f0474061851d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -513,6 +513,8 @@ static inline int kvm_arm_have_ssbd(void)
>  void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
>  
> +void kvm_set_ipa_limit(void);
> +
>  #define __KVM_HAVE_ARCH_VM_ALLOC
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 51ecf0f7c912..76972b19bdd7 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -34,6 +34,9 @@
>  #include <asm/kvm_coproc.h>
>  #include <asm/kvm_mmu.h>
>  
> +/* Maximum phys_shift supported for any VM on this host */
> +static u32 kvm_ipa_limit;
> +
>  /*
>   * ARMv8 Reset Values
>   */
> @@ -135,6 +138,46 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  	return kvm_timer_vcpu_reset(vcpu);
>  }
>  
> +void kvm_set_ipa_limit(void)
> +{
> +	unsigned int ipa_max, va_max, parange;
> +
> +	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
> +	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
> +
> +	/* Raise the limit to the default size for backward compatibility */
> +	if (ipa_max < KVM_PHYS_SHIFT) {
> +		WARN_ONCE(1,
> +			  "PARange is %d bits, unsupported configuration!",
> +			  ipa_max);
> +		ipa_max = KVM_PHYS_SHIFT;
I don't really get what does happen in this case. The CPU cannot handle
PA up to ipa_max so can the VM run properly? In case it is a
showstopper, kvm_set_ipa_limit should return an error, cascaded by
init_common_resources. Otherwise the warning message may be reworded.
> +	}
> +
> +	/* Clamp it to the PA size supported by the kernel */
> +	ipa_max = (ipa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : ipa_max;
> +	/*
> +	 * Since our stage2 table is dependent on the stage1 page table code,
> +	 * we must always honor the following condition:
> +	 *
> +	 *  Number of levels in Stage1 >= Number of levels in Stage2.
> +	 *
> +	 * So clamp the ipa limit further down to limit the number of levels.
> +	 * Since we can concatenate upto 16 tables at entry level, we could
> +	 * go upto 4bits above the maximum VA addressible with the current
addressable?
> +	 * number of levels.
> +	 */
> +	va_max = PGDIR_SHIFT + PAGE_SHIFT - 3;
> +	va_max += 4;
> +
> +	if (va_max < ipa_max) {
> +		kvm_info("Limiting IPA limit to %dbytes due to host VA bits limitation\n",> +			 va_max);
> +		ipa_max = va_max;
you have a trace for this limitation but none for the comparison against
PHYS_MASK_SHIFT.
> +	}
> +
> +	kvm_ipa_limit = ipa_max;
> +}
> +
>  /*
>   * Configure the VTCR_EL2 for this VM. The VTCR value is common
>   * across all the physical CPUs on the system. We use system wide
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 43e716bc3f08..631f9a3ad99a 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1413,6 +1413,8 @@ static int init_common_resources(void)
>  	kvm_vmid_bits = kvm_get_vmid_bits();
>  	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
>  
> +	kvm_set_ipa_limit();
As we have a kvm_info for the supported vmid_bits, may be good to output
the max IPA size supported by the host whatever the applied clamps?

Thanks

Eric
> +
>  	return 0;
>  }
>  
> 

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B42145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeIYQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbeIYQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:07:45 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1237836A5DA;
        Tue, 25 Sep 2018 10:00:58 +0000 (UTC)
Received: from [10.36.117.173] (ovpn-117-173.ams2.redhat.com [10.36.117.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4BB4308BE75;
        Tue, 25 Sep 2018 10:00:50 +0000 (UTC)
Subject: Re: [PATCH v5 17/18] kvm: arm64: Limit the minimum number of page
 table levels
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-18-suzuki.poulose@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <59231541-311f-e04b-3e6b-e073a8392316@redhat.com>
Date:   Tue, 25 Sep 2018 12:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917104144.19188-18-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 25 Sep 2018 10:00:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
> Since we are about to remove the lower limit on the IPA size,
> make sure that we do not go to 1 level page table (e.g, with
> 32bit IPA on 64K host with concatenation) to avoid splitting
> the host PMD huge pages at stage2.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/stage2_pgtable.h |  8 +++++++-
>  arch/arm64/kvm/reset.c                  | 12 +++++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index 352ec4158fdf..6a56fdff0823 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -72,8 +72,14 @@
>  /*
>   * The number of PTRS across all concatenated stage2 tables given by the
>   * number of bits resolved at the initial level.
> + * If we force more number of levels than necessary, we may have
more levels?
> + * stage2_pgdir_shift > IPA, in which case, stage2_pgd_ptrs will have
> + * one entry.
>   */
> -#define __s2_pgd_ptrs(ipa, lvls)	(1 << ((ipa) - pt_levels_pgdir_shift((lvls))))
> +#define pgd_ptrs_shift(ipa, pgdir_shift)	\
> +	((ipa) > (pgdir_shift) ? ((ipa) - (pgdir_shift)) : 0)
> +#define __s2_pgd_ptrs(ipa, lvls)		\
> +	(1 << (pgd_ptrs_shift((ipa), pt_levels_pgdir_shift(lvls))))
>  #define __s2_pgd_size(ipa, lvls)	(__s2_pgd_ptrs((ipa), (lvls)) * sizeof(pgd_t))
>  
>  #define stage2_pgd_ptrs(kvm)		__s2_pgd_ptrs(kvm_phys_shift(kvm), kvm_stage2_levels(kvm))
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 76972b19bdd7..0393bb974b23 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -190,10 +190,19 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>  {
>  	u64 vtcr = VTCR_EL2_FLAGS;
>  	u64 parange;
> +	u8 lvls;
>  
>  	if (type)
>  		return -EINVAL;
>  
> +	/*
> +	 * Use a minimum 2 level page table to prevent splitting
> +	 * host PMD huge pages at stage2.
> +	 */
> +	lvls = stage2_pgtable_levels(KVM_PHYS_SHIFT);
> +	if (lvls < 2)
> +		lvls = 2;
> +
>  	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
>  	if (parange > ID_AA64MMFR0_PARANGE_MAX)
>  		parange = ID_AA64MMFR0_PARANGE_MAX;
> @@ -210,7 +219,8 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>  	vtcr |= (kvm_get_vmid_bits() == 16) ?
>  		VTCR_EL2_VS_16BIT :
>  		VTCR_EL2_VS_8BIT;
> -	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(KVM_PHYS_SHIFT));
> +
nit: new line not requested

Thanks

Eric
> +	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
>  	vtcr |= VTCR_EL2_T0SZ(KVM_PHYS_SHIFT);
>  
>  	kvm->arch.vtcr = vtcr;
> 

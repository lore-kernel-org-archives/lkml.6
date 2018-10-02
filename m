Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2BBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8A20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF8A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJBPEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:04:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbeJBPEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 437E5307D84F;
        Tue,  2 Oct 2018 08:22:43 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A42D560469;
        Tue,  2 Oct 2018 08:22:40 +0000 (UTC)
Subject: Re: [PATCH v6 17/18] kvm: arm64: Limit the minimum number of page
 table levels
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, will.deacon@arm.com,
        dave.martin@arm.com, peter.maydell@linaro.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-18-suzuki.poulose@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <74b58f29-fff7-010f-077f-caceca17bfe0@redhat.com>
Date:   Tue, 2 Oct 2018 10:22:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926163258.20218-18-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 02 Oct 2018 08:22:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 9/26/18 6:32 PM, Suzuki K Poulose wrote:
> Since we are about to remove the lower limit on the IPA size,
> make sure that we do not go to 1 level page table (e.g, with
> 32bit IPA on 64K host with concatenation) to avoid splitting
> the host PMD huge pages at stage2.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> Change since v5:
>  - Cosmetic changes to the comment
>  - Remove unnecessary new line
> ---
>  arch/arm64/include/asm/stage2_pgtable.h |  7 ++++++-
>  arch/arm64/kvm/reset.c                  | 10 +++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index c62fe118a898..2cce769ba4c6 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -72,8 +72,13 @@
>  /*
>   * The number of PTRS across all concatenated stage2 tables given by the
>   * number of bits resolved at the initial level.
> + * If we force more levels than necessary, we may have (stage2_pgdir_shift > IPA),
> + * in which case, stage2_pgd_ptrs will have one entry.
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
> index 96b3f50101bc..f156e45760bc 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -190,6 +190,7 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>  {
>  	u64 vtcr = VTCR_EL2_FLAGS;
>  	u32 parange, phys_shift;
> +	u8 lvls;
>  
>  	if (type)
>  		return -EINVAL;
> @@ -203,7 +204,14 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>  	if (phys_shift > KVM_PHYS_SHIFT)
>  		phys_shift = KVM_PHYS_SHIFT;
>  	vtcr |= VTCR_EL2_T0SZ(phys_shift);
> -	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(phys_shift));
> +	/*
> +	 * Use a minimum 2 level page table to prevent splitting
> +	 * host PMD huge pages at stage2.
> +	 */
> +	lvls = stage2_pgtable_levels(phys_shift);
> +	if (lvls < 2)
> +		lvls = 2;
> +	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
>  
>  	/*
>  	 * Enable the Hardware Access Flag management, unconditionally
> 

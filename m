Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C01427FFA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C01427FFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936441AbeF2Ouy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:50:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932254AbeF2Oux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 518EB7A7E5;
        Fri, 29 Jun 2018 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-106.ams2.redhat.com [10.36.117.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 515BA1102E29;
        Fri, 29 Jun 2018 14:50:49 +0000 (UTC)
Subject: Re: [PATCH v3 04/20] kvm: arm64: Clean up VTCR_EL2 initialisation
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-5-git-send-email-suzuki.poulose@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7bf6d030-7d8c-8f6b-1206-7c0d388949d0@redhat.com>
Date:   Fri, 29 Jun 2018 16:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-5-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 14:50:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 29 Jun 2018 14:50:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> Use the new helper for converting the parange to the physical shift.
> Also, add the missing definitions for the VTCR_EL2 register fields
> and use them instead of hard coding numbers.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2
>  - Part 2 of the split from original patch.
>  - Also add missing VTCR field helpers and use them.
> ---
>  arch/arm64/include/asm/kvm_arm.h |  3 +++
>  arch/arm64/kvm/hyp/s2-setup.c    | 30 ++++++------------------------
>  2 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 6dd285e..3dffd38 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -106,6 +106,7 @@
>  #define VTCR_EL2_RES1		(1 << 31)
>  #define VTCR_EL2_HD		(1 << 22)
>  #define VTCR_EL2_HA		(1 << 21)
> +#define VTCR_EL2_PS_SHIFT	TCR_EL2_PS_SHIFT
>  #define VTCR_EL2_PS_MASK	TCR_EL2_PS_MASK
>  #define VTCR_EL2_TG0_MASK	TCR_TG0_MASK
>  #define VTCR_EL2_TG0_4K		TCR_TG0_4K
> @@ -126,6 +127,8 @@
>  #define VTCR_EL2_VS_8BIT	(0 << VTCR_EL2_VS_SHIFT)
>  #define VTCR_EL2_VS_16BIT	(1 << VTCR_EL2_VS_SHIFT)
>  
> +#define VTCR_EL2_T0SZ(x)	TCR_T0SZ(x)
> +
>  /*
>   * We configure the Stage-2 page tables to always restrict the IPA space to be
>   * 40 bits wide (T0SZ = 24).  Systems with a PARange smaller than 40 bits are
> diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
> index 603e1ee..81094f1 100644
> --- a/arch/arm64/kvm/hyp/s2-setup.c
> +++ b/arch/arm64/kvm/hyp/s2-setup.c
> @@ -19,11 +19,13 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_hyp.h>
> +#include <asm/cpufeature.h>
>  
>  u32 __hyp_text __init_stage2_translation(void)
>  {
>  	u64 val = VTCR_EL2_FLAGS;
>  	u64 parange;
> +	u32 phys_shift;
>  	u64 tmp;

Not related to this patch but the comment reporting that bit 19 of
VTCR_EL2 is RES0 is not fully valid anymore as it now corresponds to
VMID size in ARM ARM >= 8.1.
>  
>  	/*
> @@ -34,30 +36,10 @@ u32 __hyp_text __init_stage2_translation(void)
>  	parange = read_sysreg(id_aa64mmfr0_el1) & 7;
>  	if (parange > ID_AA64MMFR0_PARANGE_MAX)
>  		parange = ID_AA64MMFR0_PARANGE_MAX;
> -	val |= parange << 16;
> +	val |= parange << VTCR_EL2_PS_SHIFT;
>  
>  	/* Compute the actual PARange... */
> -	switch (parange) {
> -	case 0:
> -		parange = 32;
> -		break;
> -	case 1:
> -		parange = 36;
> -		break;
> -	case 2:
> -		parange = 40;
> -		break;
> -	case 3:
> -		parange = 42;
> -		break;
> -	case 4:
> -		parange = 44;
> -		break;
> -	case 5:
> -	default:
> -		parange = 48;
> -		break;
> -	}
> +	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
>  
>  	/*
>  	 * ... and clamp it to 40 bits, unless we have some braindead
> @@ -65,7 +47,7 @@ u32 __hyp_text __init_stage2_translation(void)
>  	 * return that value for the rest of the kernel to decide what
>  	 * to do.
>  	 */
> -	val |= 64 - (parange > 40 ? 40 : parange);
> +	val |= VTCR_EL2_T0SZ(phys_shift > 40 ? 40 : phys_shift);
>  
>  	/*
>  	 * Check the availability of Hardware Access Flag / Dirty Bit
> @@ -86,5 +68,5 @@ u32 __hyp_text __init_stage2_translation(void)
>  
>  	write_sysreg(val, vtcr_el2);
>  
> -	return parange;
> +	return phys_shift;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>  }
> 

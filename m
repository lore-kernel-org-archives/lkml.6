Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22625E06
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D22625E06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeGBNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:43:20 -0400
Received: from foss.arm.com ([217.140.101.70]:60804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeGBNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:43:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB6880D;
        Mon,  2 Jul 2018 06:43:18 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29303F5AD;
        Mon,  2 Jul 2018 06:43:15 -0700 (PDT)
Subject: Re: [PATCH v3 18/20] kvm: arm64: Add support for handling 52bit IPA
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Kristina Martsenko <kristina.martsenko@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-19-git-send-email-suzuki.poulose@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ea593baa-a7d8-6328-456c-1ca0476f7d75@arm.com>
Date:   Mon, 2 Jul 2018 14:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-19-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/18 12:15, Suzuki K Poulose wrote:
> Add support for handling the 52bit IPA. 52bit IPA
> support needs changes to the following :
> 
>  1) Page-table entries - We use kernel page table helpers for setting
>  up the stage2. Hence we don't explicit changes here
> 
>  2) VTTBR:BADDR - This is already supported with :
>    commit 529c4b05a3cb2f324aa ("arm64: handle 52-bit addresses in TTBR")
> 
>  3) VGIC support for 52bit: Supported with a patch in this series.
> 
> That leaves us with the handling for PAR and HPAR. This patch adds

HPFAR?

> support for handling the 52bit addresses in PAR and HPFAR,
> which are used while handling the permission faults in stage1.

Overall, this is a pretty confusing commit message. Can you just call it:

KVM/arm64: Add 52bit support for PAR to HPFAR conversion

and just describe that it now uses PHYS_MASK_SHIFT instead of a
hardcoded constant?

> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h | 7 +++++++
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 2e90942..cb6a2ee 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -301,6 +301,13 @@
>  
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~UL(0xf))
> +/*
> + * We have
> + *	PAR	[PA_Shift - 1	: 12] = PA	[PA_Shift - 1 : 12]
> + *	HPFAR	[PA_Shift - 9	: 4]  = FIPA	[PA_Shift - 1 : 12]
> + */
> +#define PAR_TO_HPFAR(par)		\
> +	(((par) & GENMASK_ULL(PHYS_MASK_SHIFT - 1, 12)) >> 8)
>  
>  #define kvm_arm_exception_type	\
>  	{0, "IRQ" }, 		\
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 355fb25..fb66320 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -260,7 +260,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  		return false; /* Translation failed, back to guest */
>  
>  	/* Convert PAR to HPFAR format */
> -	*hpfar = ((tmp >> 12) & ((1UL << 36) - 1)) << 4;
> +	*hpfar = PAR_TO_HPFAR(tmp);
>  	return true;
>  }
>  
> 

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

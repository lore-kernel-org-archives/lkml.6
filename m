Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C68C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94EF20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94EF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH1Ux7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:53:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH1Ux6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:53:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D780180D;
        Tue, 28 Aug 2018 10:01:24 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8FFB3F5BD;
        Tue, 28 Aug 2018 10:01:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3E9131AE311D; Tue, 28 Aug 2018 18:01:36 +0100 (BST)
Date:   Tue, 28 Aug 2018 18:01:36 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        catalin.marinas@arm.com, herbert@gondor.apana.org.au,
        ebiggers@google.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
Message-ID: <20180828170135.GC19825@arm.com>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827110245.14812-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:02:43PM +0200, Ard Biesheuvel wrote:
> Add a CRC32 feature bit and wire it up to the CPU id register so we
> will be able to use alternatives patching for CRC32 operations.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/cpucaps.h | 3 ++-
>  arch/arm64/kernel/cpufeature.c   | 9 +++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

With the minor caveat below...

> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index ae1f70450fb2..9932aca9704b 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -51,7 +51,8 @@
>  #define ARM64_SSBD				30
>  #define ARM64_MISMATCHED_CACHE_TYPE		31
>  #define ARM64_HAS_STAGE2_FWB			32
> +#define ARM64_HAS_CRC32				33
>  
> -#define ARM64_NCAPS				33
> +#define ARM64_NCAPS				34


... if this goes via crypto, you'll almost certainly get a (trivial)
conflict with arm64, since these numbers get bumped all the time.

Will

>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index e238b7932096..7626b80128f5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1222,6 +1222,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.cpu_enable = cpu_enable_hw_dbm,
>  	},
>  #endif
> +	{
> +		.desc = "CRC32 instructions",
> +		.capability = ARM64_HAS_CRC32,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64ISAR0_EL1,
> +		.field_pos = ID_AA64ISAR0_CRC32_SHIFT,
> +		.min_field_value = 1,
> +	},
>  	{},
>  };
>  
> -- 
> 2.18.0
> 

Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F79C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FD42098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FD42098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeJKX17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:27:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbeJKX16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:27:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 970231596;
        Thu, 11 Oct 2018 09:00:09 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F9EE3F766;
        Thu, 11 Oct 2018 09:00:06 -0700 (PDT)
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <56fbbada-902d-f802-0448-4692a56c7e72@arm.com>
Date:   Thu, 11 Oct 2018 17:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005084754.20950-8-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristina,

On 05/10/18 09:47, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> This patch adds basic support for pointer authentication, allowing
> userspace to make use of APIAKey. The kernel maintains an APIAKey value
> for each process (shared by all threads within), which is initialised to
> a random value at exec() time.
> 
> To describe that address authentication instructions are available, the
> ID_AA64ISAR0.{APA,API} fields are exposed to userspace. A new hwcap,
> APIA, is added to describe that the kernel manages APIAKey.
> 
> Instructions using other keys (APIBKey, APDAKey, APDBKey) are disabled,
> and will behave as NOPs. These may be made use of in future patches.
> 
> No support is added for the generic key (APGAKey), though this cannot be
> trapped or made to behave as a NOP. Its presence is not advertised with
> a hwcap.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [kristina: init keys in arch_bprm_mm_init; add AA64ISAR1.API HWCAP_CAP; use sysreg_clear_set]
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Tested-by: Adam Wallis <awallis@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0dd171c7d71e..3157685aa56a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1040,6 +1040,11 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
>   }
>   
>   #ifdef CONFIG_ARM64_PTR_AUTH
> +static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
> +{
> +	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ENIA);
> +}
> +
>   static bool has_address_auth(const struct arm64_cpu_capabilities *entry,
>   			     int __unused)
>   {
> @@ -1267,6 +1272,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.capability = ARM64_HAS_ADDRESS_AUTH,
>   		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>   		.matches = has_address_auth,
> +		.cpu_enable = cpu_enable_address_auth,
>   	},
>   #endif /* CONFIG_ARM64_PTR_AUTH */
>   	{},
> @@ -1314,6 +1320,10 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>   #ifdef CONFIG_ARM64_SVE
>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
>   #endif
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_APA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_APIA),
> +	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_API_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_APIA),

This is a bit problematic. If all the CPUs have just the IMPDEF
algorithm available, we could fail to match the first entry (APA) for a
late secondary CPU and thus thus fail the CPU from booting. I guess we 
need a custom entry which reuses the has_address_auth() as the matches().

Rest looks fine to me.

Suzuki

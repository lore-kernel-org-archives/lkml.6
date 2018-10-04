Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FAC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79BE2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79BE2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJDUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:02:15 -0400
Received: from foss.arm.com ([217.140.101.70]:36418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeJDUCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:02:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79D777A9;
        Thu,  4 Oct 2018 06:09:01 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CA9C3F5A0;
        Thu,  4 Oct 2018 06:09:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: cpufeature: Fix handling of CTR_EL0.IDC field
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, pelcan@codeaurora.org,
        shankerd@codeaurora.org
References: <20181004083315.31174-1-suzuki.poulose@arm.com>
 <20181004083315.31174-3-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6f077baa-573b-a98e-889c-f78198f1e22d@arm.com>
Date:   Thu, 4 Oct 2018 14:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004083315.31174-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/10/18 09:33, Suzuki K Poulose wrote:
> CTR_EL0.IDC reports the data cache clean requirements for instruction
> to data coherence. However, if the field is 0, we need to check the
> CLIDR_EL1 fields to detect the status of the feature. Currently we
> don't do this and generate a warning with tainting the kernel, when
> there is a mismatch in the field among the CPUs. Also the userspace
> doesn't have a reliable way to check the CLIDR_EL1 register to check
> the status.
> 
> This patch fixes the problem by checking the CLIDR_EL1 fields, when
> (CTR_EL0.IDC == 0) and updates the kernel's copy of the CTR_EL0 for
> the CPU with the actual status of the feature. This would allow the
> sanity check infrastructure to do the proper checking of the fields
> and also allow the CTR_EL0 emulation code to supply the real status
> of the feature.
> 
> Now, if a CPU has raw CTR_EL0.IDC == 0 and effective IDC == 1 (with
> overall system wide IDC == 1), we need to expose the real value to
> the user. So, we trap CTR_EL0 access on the CPU which reports incorrect
> CTR_EL0.IDC.
> 
> Fixes: commit 6ae4b6e057888 ("arm64: Add support for new control bits CTR_EL0.DIC and CTR_EL0.IDC")
> Cc: Shanker Donthineni <shankerd@codeaurora.org>
> Cc: Philip Elcan <pelcan@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>   static void
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ba16bb7762ca..d3caeabf09ed 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -861,18 +861,30 @@ static bool has_cache_idc(const struct arm64_cpu_capabilities *entry,
>   	if (scope == SCOPE_SYSTEM)
>   		ctr = arm64_ftr_reg_ctrel0.sys_val;
>   	else
> -		ctr = read_cpuid_cachetype();
> +		ctr = read_cpuid_effective_cachetype();
>   
>   	return ctr & BIT(CTR_IDC_SHIFT);
>   }
>   
> +static void cpu_emulate_effective_ctr(const struct arm64_cpu_capabilities *__unused)
> +{
> +	/*
> +	 * If the CPU exposes raw CTR_EL0.IDC = 0, while effectively
> +	 * CTR_EL0.IDC = 1 (from CLIDR values), we need to trap accesses
> +	 * to the CTR_EL0 on this CPU and emulate it with the real/safe
> +	 * value.
> +	 */
> +	if (!(read_cpuid_cachetype() & BIT(CTR_IDC_SHIFT)))
> +		sysreg_clear_set(sctlr_el1, SCTLR_EL1_UCT, 0);
> +}
> +


>   static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
>   			  int scope)
>   {
>   	u64 ctr;
>   
>   	if (scope == SCOPE_SYSTEM)
> -		ctr = arm64_ftr_reg_ctrel0.sys_val;
> +		ctr = read_cpuid_effective_cachetype();
>   	else
>   		ctr = read_cpuid_cachetype();

I have messed this hunk in resolving the conflict with a rebase.
This should be :

  	if (scope == SCOPE_SYSTEM)
  		ctr = arm64_ftr_reg_ctrel0.sys_val;
  	else
-		ctr = read_cpuid_cachetype();
+		ctr = read_cpuid_effective_cachetype();

I have fixed this locally for v2.

Suzuki

Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B19C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A982220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A982220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeK3DdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:33:22 -0500
Received: from foss.arm.com ([217.140.101.70]:38622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeK3DdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:33:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215C1A78;
        Thu, 29 Nov 2018 08:27:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305293F59C;
        Thu, 29 Nov 2018 08:27:25 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:27:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org
Subject: Re: [PATCH v6 02/24] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
Message-ID: <20181129162722.s2ee2mdteli7jdir@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:56:53AM +0000, Julien Thierry wrote:
> It is not supported to have some CPUs using GICv3 sysreg CPU interface
> while some others do not.
> 
> Once ICC_SRE_EL1.SRE is set on a CPU, the bit cannot be cleared. Since
> matching this feature require setting ICC_SRE_EL1.SRE, it cannot be
> turned off if found on a CPU.
> 
> Set the feature as STRICT_BOOT, if boot CPU has it, all other CPUs are
> required to have it.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Makes sense.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index af50064..03a9d96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1149,7 +1149,7 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>  	{
>  		.desc = "GIC system register CPU interface",
>  		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>  		.matches = has_useable_gicv3_cpuif,
>  		.sys_reg = SYS_ID_AA64PFR0_EL1,
>  		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

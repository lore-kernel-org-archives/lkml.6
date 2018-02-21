Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeBULSh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:18:37 -0500
Received: from foss.arm.com ([217.140.101.70]:53142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbeBULSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:18:35 -0500
Date: Wed, 21 Feb 2018 11:18:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: cpufeature: Trim feature reporting and include
 PAN emulation
Message-ID: <20180221111823.GB32331@e103592.cambridge.arm.com>
References: <20180220224624.GA28218@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220224624.GA28218@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:46:24PM -0800, Kees Cook wrote:
> The PAN emulation notification was only happening for non-boot CPUs
> if CPU capabilities had already been configured. This seems to be the
> wrong place, as it's system-wide and isn't attached to capabilities,
> so its reporting didn't normally happen. Instead, report it once from
> the boot CPU. Additionally removes the redundant "feature" word from the
> "CPU features:" line.
> 
> Before (redundant "feature", and missing PAN emulation report):
> 
>  SMP: Total of 4 processors activated.
>  CPU features: detected feature: 32-bit EL0 Support
>  CPU features: detected feature: Kernel page table isolation (KPTI)
>  CPU: All CPU(s) started at EL2
> 
> After:
> 
>  SMP: Total of 4 processors activated.
>  CPU features: detected: 32-bit EL0 Support
>  CPU features: detected: Kernel page table isolation (KPTI)
>  CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
>  CPU: All CPU(s) started at EL2
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 29b1f873e337..6c799ca58b53 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1333,9 +1333,6 @@ static void verify_local_cpu_capabilities(void)
>  
>  	if (system_supports_sve())
>  		verify_sve_features();
> -
> -	if (system_uses_ttbr0_pan())
> -		pr_info("Emulating Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
>  }
>  
>  void check_local_cpu_capabilities(void)
> @@ -1360,7 +1357,7 @@ void check_local_cpu_capabilities(void)
>  
>  static void __init setup_feature_capabilities(void)
>  {
> -	update_cpu_capabilities(arm64_features, "detected feature:");
> +	update_cpu_capabilities(arm64_features, "detected:");

Although I get what you're saying about redundant use of the word
"features", this feels like cosmetic churn that is unrelated to the
problem this patch is addressing.

It could be worth reviewing the CPU errata messages and other
miscellaneous printks together to make them less verbose and more
consistent all in one go, but that would be a separate patch...

>  	enable_cpu_capabilities(arm64_features);
>  }
>  
> @@ -1394,6 +1391,9 @@ void __init setup_cpu_features(void)
>  	if (system_supports_32bit_el0())
>  		setup_elf_hwcaps(compat_elf_hwcaps);
>  
> +	if (system_uses_ttbr0_pan())
> +		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
> +

Moving this seems sensible.  The other option would be to paste it into
update_cpu_capabilities(), but the message would still potentially get
printed multiple times, so that doesn't feel like the right approach.

[...]

Cheers
---Dave

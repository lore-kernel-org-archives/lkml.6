Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfAJJXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:23:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58474 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfAJJXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:23:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94F380D;
        Thu, 10 Jan 2019 01:23:53 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13D23F694;
        Thu, 10 Jan 2019 01:23:51 -0800 (PST)
Subject: Re: [PATCH v3 4/7] arm64: add sysfs vulnerability show for meltdown
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, mlangsdo@redhat.com, steven.price@arm.com,
        stefan.wahren@i2se.com
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-5-jeremy.linton@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <8c8b564a-1d65-bc18-73fb-58b349a47800@arm.com>
Date:   Thu, 10 Jan 2019 09:23:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109235544.2992426-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On 09/01/2019 23:55, Jeremy Linton wrote:
> Display the mitigation status if active, otherwise
> assume the cpu is safe unless it doesn't have CSV3
> and isn't in our whitelist.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ab784d7a0083..ef7bbc49ef78 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -944,8 +944,12 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>  	return has_cpuid_feature(entry, scope);
>  }
>  
> +/* default value is invalid until unmap_kernel_at_el0() runs */
> +static bool __meltdown_safe = true;
> +
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
> +extern uint arm64_requested_vuln_attrs;
>  
>  static bool is_cpu_meltdown_safe(void)
>  {
> @@ -972,6 +976,14 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  {
>  	char const *str = "command line option";
>  
> +	bool meltdown_safe = is_cpu_meltdown_safe() ||
> +		has_cpuid_feature(entry, scope);
> +
> +	if (!meltdown_safe)
> +		__meltdown_safe = false;
> +
> +	arm64_requested_vuln_attrs |= VULN_MELTDOWN;
> +
>  	/*
>  	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
>  	 * ThunderX leads to apparent I-cache corruption of kernel text, which
> @@ -993,11 +1005,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>  		return true;
>  
> -	if (is_cpu_meltdown_safe())
> -		return false;
> -
> -	/* Defer to CPU feature registers */
> -	return !has_cpuid_feature(entry, scope);
> +	return !meltdown_safe;
>  }
>  
>  static void
> @@ -2065,3 +2073,17 @@ static int __init enable_mrs_emulation(void)
>  }
>  
>  core_initcall(enable_mrs_emulation);
> +
> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	if (arm64_kernel_unmapped_at_el0())
> +		return sprintf(buf, "Mitigation: KPTI\n");
> +
> +	if (__meltdown_safe)
> +		return sprintf(buf, "Not affected\n");

An issue I see is that we don't even bother to check it that CPUs are
meltdown safe if CONFIG_UNMAP_KERNEL_AT_EL0 is not defined but here
we'll advertise that the system is meltdown safe.

I think that checking whether we know that CPUs are meltdown safe should
be separated from whether mitigation is applied.

Someone who knows thinks their CPUs are in the white list might want to
compile out code that does the kpti, but it would be good to give them a
proper diagnostic whether they were wrong or not.

Cheers,

-- 
Julien Thierry

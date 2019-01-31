Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3FD20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfAaRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:54:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfAaRyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:54:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73A53A78;
        Thu, 31 Jan 2019 09:54:24 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E3533F59C;
        Thu, 31 Jan 2019 09:54:21 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:54:18 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 07/12] arm64: add sysfs vulnerability show for
 meltdown
Message-ID: <20190131175418.24b7811c@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-8-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-8-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:06 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> Display the mitigation status if active, otherwise
> assume the cpu is safe unless it doesn't have CSV3
> and isn't in our whitelist.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c
> b/arch/arm64/kernel/cpufeature.c
> index a9e18b9cdc1e..624dfe0b5cdd 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -944,6 +944,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
> 	return has_cpuid_feature(entry, scope);
> }
>  
> +/* default value is invalid until unmap_kernel_at_el0() runs */

Shall we somehow enforce this? For instance by making __meltdown_safe
an enum, initialised to UNKNOWN?
Then bail out with a BUG_ON or WARN_ON in the sysfs code?

I just want to avoid to accidentally report "safe" when we actually
aren't.

> +static bool __meltdown_safe = true;
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */ 
>  static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> @@ -962,6 +964,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> 		{ /* sentinel */ }
>  	};
>  	char const *str = "command line option";
> +	bool meltdown_safe;
> +
> +	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
> +
> +	/* Defer to CPU feature registers */
> +	if (has_cpuid_feature(entry, scope))
> +		meltdown_safe = true;
> +
> +	if (!meltdown_safe)
> +		__meltdown_safe = false;
>  
>  	/*
>  	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
> @@ -984,12 +996,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> 		return kaslr_offset() > 0;
>  
> -	/* Don't force KPTI for CPUs that are not vulnerable */
> -	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> -		return false;
> -
> -	/* Defer to CPU feature registers */
> -	return !has_cpuid_feature(entry, scope);
> +	return !meltdown_safe;
>  }
>  
>  static void
> @@ -2055,3 +2062,17 @@ static int __init enable_mrs_emulation(void)
>  }
>  
>  core_initcall(enable_mrs_emulation);
> +
> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
> +		char *buf)

w/s issue.

Cheers,
Andre.

> +{
> +	if (arm64_kernel_unmapped_at_el0())
> +		return sprintf(buf, "Mitigation: KPTI\n");
> +
> +	if (__meltdown_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> +#endif


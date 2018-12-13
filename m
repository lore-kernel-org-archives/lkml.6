Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D1CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09D82075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09D82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeLMJXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:23:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbeLMJXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:23:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC5415AD;
        Thu, 13 Dec 2018 01:23:41 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085993F6A8;
        Thu, 13 Dec 2018 01:23:39 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
Date:   Thu, 13 Dec 2018 09:23:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On 06/12/2018 23:44, Jeremy Linton wrote:
> Add a simple state machine which will track whether
> all the online cores in a machine are vulnerable.
> 
> Once that is done we have a fairly authoritative view
> of the machine vulnerability, which allows us to make a
> judgment about machine safety if it hasn't been mitigated.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 242898395f68..bea9adfef7fa 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -905,6 +905,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>  	return has_cpuid_feature(entry, scope);
>  }
>  
> +static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN } __meltdown_safe = A64_MELT_UNSET;
> +

I'm wondering, do we really need that tri state?

Can't we consider that we are safe an move to unsafe/unkown if any cpu
during bring up is not in the safe list?

The only user of this is cpu_show_meltdown, but I don't imagine it'll
get called before unmap_kernel_at_el0() is called for the boot CPU which
should initialise that state.

Or is there another reason for having that UNSET state?

Thanks,

>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>  
> @@ -928,6 +930,15 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  {
>  	char const *str = "command line option";
>  
> +	bool meltdown_safe = is_cpu_meltdown_safe() ||
> +		has_cpuid_feature(entry, scope);
> +
> +	/* Only safe if all booted cores are known safe */
> +	if (meltdown_safe && __meltdown_safe == A64_MELT_UNSET)
> +		__meltdown_safe = A64_MELT_SAFE;
> +	else if (!meltdown_safe)
> +		__meltdown_safe = A64_MELT_UNKN;
> +
>  	/*
>  	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
>  	 * ThunderX leads to apparent I-cache corruption of kernel text, which
> @@ -949,11 +960,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
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
> @@ -1920,3 +1927,17 @@ static int __init enable_mrs_emulation(void)
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
> +	if (__meltdown_safe == A64_MELT_SAFE)
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Unknown\n");
> +}
> +#endif
> 

-- 
Julien Thierry

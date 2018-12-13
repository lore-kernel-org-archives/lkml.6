Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F99BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8E20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA8E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeLMJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:13:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbeLMJNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:13:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A351580D;
        Thu, 13 Dec 2018 01:13:39 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB563F6A8;
        Thu, 13 Dec 2018 01:13:37 -0800 (PST)
Subject: Re: [PATCH 1/6] arm64: kpti: move check for non-vulnerable CPUs to a
 function
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-2-jeremy.linton@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <1c6081ca-8335-759f-3f49-f8fa60b2fb90@arm.com>
Date:   Thu, 13 Dec 2018 09:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/12/2018 23:44, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Add is_meltdown_safe() which is a whitelist of known safe cores.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Moved location of function]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index aec5ecb85737..242898395f68 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -908,8 +908,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>  
> -static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> -				int scope)
> +static bool is_cpu_meltdown_safe(void)
>  {
>  	/* List of CPUs that are not vulnerable and don't need KPTI */
>  	static const struct midr_range kpti_safe_list[] = {
> @@ -917,6 +916,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
>  		{ /* sentinel */ }
>  	};
> +	/* Don't force KPTI for CPUs that are not vulnerable */

This is really a nit, but that comment would make more sense where
is_cpu_meltdown_safe() is called since unmap_kernel_at_el0 is the one
deciding whether to apply KPTI, is_cpu_meltdown_safe() just states
whether the core is safe of not.

Otherwise:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

Julien

> +	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> +				int scope)
> +{
>  	char const *str = "command line option";
>  
>  	/*
> @@ -940,8 +949,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>  		return true;
>  
> -	/* Don't force KPTI for CPUs that are not vulnerable */
> -	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> +	if (is_cpu_meltdown_safe())
>  		return false;
>  
>  	/* Defer to CPU feature registers */
> 

-- 
Julien Thierry

Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0390C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7171220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7171220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeILPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:33:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeILPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CBC7A9;
        Wed, 12 Sep 2018 03:29:45 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8693F614;
        Wed, 12 Sep 2018 03:29:43 -0700 (PDT)
Subject: Re: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
To:     Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3becf020-b230-beb8-b304-d8097377f234@arm.com>
Date:   Wed, 12 Sep 2018 11:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently alternatives are applied very late in the boot process (and
> a long time after we enable scheduling). Some alternative sequences,
> such as those that alter the way CPU context is stored, must be applied
> much earlier in the boot sequence.
> 
> Introduce apply_boot_alternatives() to allow some alternatives to be
> applied immediately after we detect the CPU features of the boot CPU.


> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index b5d6039..70c2604 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -145,7 +145,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
>  	} while (cur += d_size, cur < end);
>  }
>  
> -static void __apply_alternatives(void *alt_region, bool is_module)
> +static void __apply_alternatives(void *alt_region,  bool is_module,
> +				 unsigned long feature_mask)

Shouldn't feature_mask be a DECLARE_BITMAP() maybe-array like cpu_hwcaps?
This means it keeps working when NR_CAPS grows over 64, which might happen
sooner than we think for backported errata...


> @@ -155,6 +156,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
>  	for (alt = region->begin; alt < region->end; alt++) {
>  		int nr_inst;
>  
> +		if ((BIT(alt->cpufeature) & feature_mask) == 0)
> +			continue;
> +
>  		/* Use ARM64_CB_PATCH as an unconditional patch */
>  		if (alt->cpufeature < ARM64_CB_PATCH &&
>  		    !cpus_have_cap(alt->cpufeature))
> @@ -213,7 +217,7 @@ static int __apply_alternatives_multi_stop(void *unused)
>  		isb();
>  	} else {
>  		BUG_ON(alternatives_applied);
> -		__apply_alternatives(&region, false);
> +		__apply_alternatives(&region, false, ~boot_capabilities);

Ah, this is tricky. There is a bitmap_complement() for the DECLARE_BITMAP()
stuff, but we'd need a second array...

We could pass the scope around, but then __apply_alternatives() would need to
lookup the struct arm64_cpu_capabilities up every time. This is only a problem
as we have one cap-number-space for errata/features, but separate sparse lists.

(I think applying the alternatives one cap at a time is a bad idea as we would
need to walk the alternative region NR_CAPS times)


> @@ -227,6 +231,24 @@ void __init apply_alternatives_all(void)
>  	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
>  }
>  
> +/*
> + * This is called very early in the boot process (directly after we run
> + * a feature detect on the boot CPU). No need to worry about other CPUs
> + * here.
> + */
> +void __init apply_boot_alternatives(void)
> +{
> +	struct alt_region region = {
> +		.begin	= (struct alt_instr *)__alt_instructions,
> +		.end	= (struct alt_instr *)__alt_instructions_end,
> +	};
> +
> +	/* If called on non-boot cpu things could go wrong */
> +	WARN_ON(smp_processor_id() != 0);

Isn't the problem if there are multiple CPUs online?


> +	__apply_alternatives(&region, false, boot_capabilities);
> +}
> +
>  #ifdef CONFIG_MODULES
>  void apply_alternatives_module(void *start, size_t length)
>  {

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 3bc1c8b..0d1e41e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -52,6 +52,8 @@
>  DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>  EXPORT_SYMBOL(cpu_hwcaps);
>  
> +unsigned long boot_capabilities;
> +
>  /*
>   * Flag to indicate if we have computed the system wide
>   * capabilities based on the boot time active CPUs. This
> @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  		if (!cpus_have_cap(caps->capability) && caps->desc)
>  			pr_info("%s %s\n", info, caps->desc);
>  		cpus_set_cap(caps->capability);

Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
__apply_alternatives() looks at. If you had a call to __apply_alternatives after
update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
apply those alternatives...

(I don't think there is a problem re-applying the same alternative, but I
haven't checked).


> +
> +		if (caps->type & SCOPE_BOOT_CPU)
> +			__set_bit(caps->capability, &boot_capabilities);
>  	}
>  }


Thanks,

James

Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DCE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DCE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeILPcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:32:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57106 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbeILPcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66BA7A9;
        Wed, 12 Sep 2018 03:28:24 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42C883F614;
        Wed, 12 Sep 2018 03:28:22 -0700 (PDT)
Subject: Re: [PATCH v5 02/27] arm64: cpufeature: Use alternatives for VHE
 cpu_enable
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1d425320-aed3-b949-1ec5-f378248aac4d@arm.com>
Date:   Wed, 12 Sep 2018 11:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> The cpu_enable callback for VHE feature requires all alternatives to have
> been applied. This prevents applying VHE alternative separately from the
> rest.
> 
> Use an alternative depending on VHE feature to know whether VHE
> alternatives have already been applied.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1e433ac..3bc1c8b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1022,8 +1024,15 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
>  	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>  	 * do anything here.
>  	 */
> -	if (!alternatives_applied)
> -		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
> +	asm volatile(ALTERNATIVE(
> +		"mrs	%0, tpidr_el1\n"
> +		"msr	tpidr_el2, %0",
> +		"nop\n"
> +		"nop",
> +		ARM64_HAS_VIRT_HOST_EXTN)
> +		: "+r" (tmp)
> +		:
> +		: "memory");
>  }
>  #endif

Catalin's preference was to keep this all in C:
https://patchwork.kernel.org/patch/10007977/
, for which we need to know if 'the' alternative has been applied.

I suspect there may be more registers in this list if we have to switch to
another EL2 register using alternatives. (but I don't have an example).

Could we make 'alternatives_applied' a macro that takes the cap as an argument?


Thanks,

James

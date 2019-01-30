Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403321473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfA3NrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:47:03 -0500
Received: from foss.arm.com ([217.140.101.70]:54600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfA3NrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:47:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B0DEBD;
        Wed, 30 Jan 2019 05:47:02 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D1F3F59C;
        Wed, 30 Jan 2019 05:47:00 -0800 (PST)
Subject: Re: [PATCH v9 26/26] arm64: Enable the support of pseudo-NMIs
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-27-git-send-email-julien.thierry@arm.com>
 <86o981ueyj.wl-marc.zyngier@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <38589cbc-dbaf-b903-6c56-65e796063680@arm.com>
Date:   Wed, 30 Jan 2019 13:46:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <86o981ueyj.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2019 12:47, Marc Zyngier wrote:
> On Mon, 21 Jan 2019 15:33:45 +0000,
> Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Add a build option and a command line parameter to build and enable the
>> support of pseudo-NMIs.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>  arch/arm64/Kconfig                              | 14 ++++++++++++++
>>  arch/arm64/kernel/cpufeature.c                  | 11 ++++++++++-
>>  3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b799bcf..173e2cc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1197,6 +1197,12 @@
>>  			to discrete, to make X server driver able to add WB
>>  			entry later. This parameter enables that.
>>  
>> +	enable_pseudo_nmi [ARM64]
>> +			Enables support for pseudo-NMIs in the kernel. This
>> +			requires both the kernel to be built with
>> +			CONFIG_ARM64_PSEUDO_NMI and to be running on a
>> +			platform with GICv3.
>> +
>>  	enable_timer_pin_1 [X86]
>>  			Enable PIN 1 of APIC timer
>>  			Can be useful to work around chipset bugs
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a4168d3..8d84bfd 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1328,6 +1328,20 @@ config ARM64_MODULE_PLTS
>>  	bool
>>  	select HAVE_MOD_ARCH_SPECIFIC
>>  
>> +config ARM64_PSEUDO_NMI
>> +	bool "Support for NMI-like interrupts"
>> +	select CONFIG_ARM_GIC_V3
>> +	help
>> +	  Adds support for mimicking Non-Maskable Interrupts through the use of
>> +	  GIC interrupt priority. This support requires version 3 or later of
>> +	  Arm GIC.
>> +
>> +	  This high priority configuration for interrupts need to be
> 
> s/need/needs/
> 
>> +	  explicitly enabled through the new kernel parameter
> 
> It won't be new forever... ;-)
> 

Good point!

>> +	  "enable_pseudo_nmi".
> 
> I'm not overly keen on this name. We already have "irqchip.gicv3_nolpi",
> so why not adopt something similar. "irqchip.gicv3_pseudo_nmi", taking a
> boolean value?
> 

Sure, I'm fine with that.

>> +
>> +	  If unsure, say N
>> +
>>  config RELOCATABLE
>>  	bool
>>  	help
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index b530fb24..e66d778 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1207,10 +1207,19 @@ static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
>>  #endif /* CONFIG_ARM64_PTR_AUTH */
>>  
>>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>> +static bool enable_pseudo_nmi;
>> +
>> +static int __init early_enable_pseudo_nmi(char *p)
>> +{
>> +	enable_pseudo_nmi = true;
> 
> And if you're happy with the above, this becomes:
> 
> 	return strtobool(p, &enable_pseudo_nmi);
> 

Thanks,

-- 
Julien Thierry

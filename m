Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2811DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0222081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0222081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLDSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:11:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeLDSL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:11:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD4FA78;
        Tue,  4 Dec 2018 10:11:56 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DD13F59C;
        Tue,  4 Dec 2018 10:11:54 -0800 (PST)
Subject: Re: [PATCH v6 15/24] arm64: Switch to PMR masking when starting CPUs
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, joel@joelfernandes.org
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-16-git-send-email-julien.thierry@arm.com>
 <20181204175142.GD19210@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <ffb17cfd-d941-1df6-8b41-2f710948e9b2@arm.com>
Date:   Tue, 4 Dec 2018 18:11:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204175142.GD19210@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/18 17:51, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:06AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 8dc9dde..e495360 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/smp.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/irq.h>
>> +#include <linux/irqchip/arm-gic-v3.h>
>>  #include <linux/percpu.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/completion.h>
>> @@ -175,6 +176,25 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>  	return ret;
>>  }
>>  
>> +static void init_gic_priority_masking(void)
>> +{
>> +	u32 gic_sre = gic_read_sre();
>> +	u32 cpuflags;
>> +
>> +	if (WARN_ON(!(gic_sre & ICC_SRE_EL1_SRE)))
>> +		return;
>> +
>> +	WARN_ON(!irqs_disabled());
>> +
>> +	gic_write_pmr(GIC_PRIO_IRQOFF);
>> +
>> +	cpuflags = read_sysreg(daif);
>> +
>> +	/* We can only unmask PSR.I if we can take aborts */
>> +	if (!(cpuflags & PSR_A_BIT))
>> +		write_sysreg(cpuflags & ~PSR_I_BIT, daif);
> 
> I don't understand this. If you don't switch off PSR_I_BIT here, where
> does it happen? In which scenario do we actually have the A bit still
> set? At a quick look, smp_prepare_boot_cpu() would have the A bit
> cleared previously by setup_arch(). We have secondary_start_kernel()
> where you call init_gic_priority_masking() before local_daif_restore().
> 

So this is for secondary CPUs where PSR.A can be still set.

The thing is that the daifflags.h establishes the order for disabling
types of exceptions:
Debug > Abort > IRQ

The idea is that when introducing pseudo-NMIs this becomes:
Debug > Abort > pseudo-NMI > IRQ

Whenever aborts are disabled (maybe because we just took an abort) we
don't want to take an NMI.

> So what happens if you always turn off PSR_I_BIT here?
> 

So semantically it would be saying "we can take a pseudo-NMI here".
Realistically, I think it depends on the state of the GIC redistributor
for this CPU:
- If the re-distributor was initialized, nothing bad could happen as no
NMI could have been configured for this CPU yet.
- If the re-distributor initialization is done between the call to
init_gic_priority_mask() and the local_daif_restore() then probably bad
things could happen

I can try to figure out if it is safe to just clear PSR.I always, but I
also find it easier to always play by the rule "if PSR.A is set, PSR.I
is set".

Thanks,

-- 
Julien Thierry

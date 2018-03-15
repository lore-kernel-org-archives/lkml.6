Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeCOP7g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:59:36 -0400
Received: from foss.arm.com ([217.140.101.70]:42268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752600AbeCOP7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:59:35 -0400
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Allow LPIs to be disabled from the
 command line
To: shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
 <20180313172103.24281-4-marc.zyngier@arm.com>
 <f3fee732-2c07-e303-4ec2-2d79668b868e@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <0418813e-9837-32b0-d1df-2b5d52c83d8e@arm.com>
Date: Thu, 15 Mar 2018 15:59:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f3fee732-2c07-e303-4ec2-2d79668b868e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/18 14:58, Shanker Donthineni wrote:
> 
> Hi Marc,
> 
> On 03/13/2018 12:21 PM, Marc Zyngier wrote:
>> For most GICv3 implementations, enabling LPIs is a one way switch.
>> Once they're on, there is no turning back, which completely kills
>> kexec (pending tables will always be live, and we can't tell the
>> secondary kernel where they are).
>>
>> This is really annoying if you plan to use Linux as a bootloader,
>> as it pretty much guarantees that the secondary kernel won't be
>> able to use MSIs, and may even see some memory corruption. Bad.
>>
>> A workaround for this unfortunate situation is to allow the kernel
>> not to enable LPIs, even if the feature is present in the HW. This
>> would allow Linux-as-a-bootloader to leave LPIs alone, and let the
>> secondary kernel to do whatever it wants with them.
>>
>> Let's introduce a boolean "irqchip.gicv3_nolpi" command line option
>> that serves that purpose.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>>  drivers/irqchip/irq-gic-v3.c                    | 10 +++++++++-
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 1d1d53f85ddd..60130231db3b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1743,6 +1743,14 @@
>>  			of a GICv2 controller even if the memory range
>>  			exposed by the device tree is too small.
>>  
>> +	irqchip.gicv3_nolpi=
>> +			[ARM, ARM64]
>> +			Force the kernel to ignore the availability of
>> +			LPIs (and by consequence ITSs). Intended for system
>> +			that use the kernel as a bootloader, and thus want
>> +			to let secondary kernels in charge of setting up
>> +			LPIs.
>> +
>>  	irqfixup	[HW]
>>  			When an interrupt is not handled search all handlers
>>  			for it. Intended to get systems with badly broken
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 0ea02504115d..3e9eeb6cb294 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -613,9 +613,17 @@ static void gic_cpu_sys_reg_init(void)
>>  		pr_crit_once("RSS is required but GICD doesn't support it\n");
>>  }
>>  
>> +static bool gicv3_nolpi;
>> +
>> +static int __init gicv3_nolpi_cfg(char *buf)
>> +{
>> +	return strtobool(buf, &gicv3_nolpi);
>> +}
>> +early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
>> +
>>  static int gic_dist_supports_lpis(void)
>>  {
>> -	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
>> +	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
> 
> Thanks for this patch series especially for KDUMP case. It would be nice if we disable GIC-ITS and
> GICR-LPI functionality completely to avoid in flight LPIs which were triggered by first kernel.

For kdump, it doesn't really matter much. The kdump kernel lives in its
own memory space, and is unaffected by LPIs being triggered. You just
need to make sure that if you can't reset EnableLPIs, you still carry on
using wired interrupts. The ITS doesn't really matter, as long as the
redistributors have their EnableLPIs zeroed.

It really is for kexec that it matters a lot, because the secondary
kernel expects to find a sane environment, which it cannot have if LPIs
are still on.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

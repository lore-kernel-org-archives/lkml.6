Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCNNdV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:33:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCNNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:33:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CF3560218
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Vikram Sethi <vikrams@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>
References: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
 <86bmfrayts.wl-marc.zyngier@arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <cc2a59b5-e514-3336-67c7-7ae8fb80c5fe@codeaurora.org>
Date: Wed, 14 Mar 2018 08:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <86bmfrayts.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 03/14/2018 02:41 AM, Marc Zyngier wrote:
> Hi Shanker,
> 
> On Wed, 14 Mar 2018 00:50:01 +0000,
> Shanker Donthineni wrote:
>>
>> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
>> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
>> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
>> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
>> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c   | 30 +++++++++++++++++++++++-------
>>  include/linux/irqchip/arm-gic-v3.h |  1 +
>>  2 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 1d3056f..85cd158 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1875,15 +1875,31 @@ static void its_cpu_init_lpis(void)
>>  		gic_data_rdist()->pend_page = pend_page;
>>  	}
>>  
>> -	/* Disable LPIs */
>>  	val = readl_relaxed(rbase + GICR_CTLR);
>> -	val &= ~GICR_CTLR_ENABLE_LPIS;
>> -	writel_relaxed(val, rbase + GICR_CTLR);
>>  
>> -	/*
>> -	 * Make sure any change to the table is observable by the GIC.
>> -	 */
>> -	dsb(sy);
>> +	/* Make sure LPIs are disabled before programming PEND/PROP registers */
>> +	if (val & GICR_CTLR_ENABLE_LPIS) {
>> +		u32 count = 1000000; /* 1s! */
>> +
>> +		/* Disable LPIs */
>> +		val &= ~GICR_CTLR_ENABLE_LPIS;
>> +		writel_relaxed(val, rbase + GICR_CTLR);
>> +
>> +		/* Make sure any change to GICR_CTLR is observable by the GIC */
>> +		dsb(sy);
>> +
>> +		/* Wait for GICR_CTLR.RWP==0 or timeout */
>> +		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
>> +			if (!count) {
>> +				pr_err("CPU%d: Failed to disable LPIs\n",
>> +				       smp_processor_id());
>> +				return;
>> +			}
>> +			cpu_relax();
>> +			udelay(1);
>> +			count--;
>> +		};
>> +	}
> 
> I can see a couple of issues with this patch:
> 
> - Entering the kernel with GICR_CTLR.EnableLPIs set is a recipe for
>   memory corruption and is likely to lead to Bad Things(tm). A loud
>   warning would be in order, I believe.
> 

I agree with you entering kernel with GICR_CTLR.EnableLPI=1 causes many
issues. Unfortunately this is happening with KDUMP/KEXEC case. We don't
disable GICD, GICRs and ITSs before loading the 2nd kernel. 

> - If you're on a system that doesn't allow GICR_CTLR.Enable_LPIs to be
>   cleared, we end-up going down the polling path for nothing. It'd be
>   worth checking that the bit can be cleared the first place (and
>   shout again if it cannot).
> 

This tells the bug in hardware but not in software, as per per spec it
should be able to cleared by software. Any suggestions how software knows
GICR_CTLR.EnableLPI bit can be cleared from enabled state.

> - From a cosmetic PoV, please move this to a redist_disable_lpis()
>   function.
> 
Sure, I'll move.

> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

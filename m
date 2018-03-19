Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbeCSNz6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:55:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:55:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D94E60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH v2] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Vikram Sethi <vikrams@codeaurora.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1521124287-25009-1-git-send-email-shankerd@codeaurora.org>
 <20180317133445.772733ac@why.wild-wind.fr.eu.org>
 <dccddaa7-6331-961d-a77f-15dc15cd8850@codeaurora.org>
 <864llebp6q.wl-marc.zyngier@arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <827da852-8cef-a8b4-c303-9e13c727b488@codeaurora.org>
Date: Mon, 19 Mar 2018 08:55:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <864llebp6q.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 03/17/2018 12:13 PM, Marc Zyngier wrote:
> On Sat, 17 Mar 2018 16:11:06 +0000,
> Shanker Donthineni wrote:
>>
>> Hi Marc,
>>
>> On 03/17/2018 08:34 AM, Marc Zyngier wrote:
>>> On Thu, 15 Mar 2018 09:31:27 -0500
>>> Shanker Donthineni <shankerd@codeaurora.org> wrote:
>>>
>>>> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
>>>> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
>>>> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
>>>> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
>>>> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
>>>>
>>>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>>>> ---
>>>> Changes since v1:
>>>>   -Moved LPI disable code to a seperate function as Marc suggested.
>>>>   -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.
>>>>   
>>>>  drivers/irqchip/irq-gic-v3-its.c   | 66 ++++++++++++++++++++++++++++++--------
>>>>  include/linux/irqchip/arm-gic-v3.h |  1 +
>>>>  2 files changed, 53 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 1d3056f..cba71a7 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -33,6 +33,8 @@
>>>>  #include <linux/of_platform.h>
>>>>  #include <linux/percpu.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/time64.h>
>>>> +#include <linux/iopoll.h>
>>>>  
>>>>  #include <linux/irqchip.h>
>>>>  #include <linux/irqchip/arm-gic-v3.h>
>>>> @@ -1875,16 +1877,6 @@ static void its_cpu_init_lpis(void)
>>>>  		gic_data_rdist()->pend_page = pend_page;
>>>>  	}
>>>>  
>>>> -	/* Disable LPIs */
>>>> -	val = readl_relaxed(rbase + GICR_CTLR);
>>>> -	val &= ~GICR_CTLR_ENABLE_LPIS;
>>>> -	writel_relaxed(val, rbase + GICR_CTLR);
>>>> -
>>>> -	/*
>>>> -	 * Make sure any change to the table is observable by the GIC.
>>>> -	 */
>>>> -	dsb(sy);
>>>> -
>>>>  	/* set PROPBASE */
>>>>  	val = (page_to_phys(gic_rdists->prop_page) |
>>>>  	       GICR_PROPBASER_InnerShareable |
>>>> @@ -3288,13 +3280,59 @@ static bool gic_rdists_supports_plpis(void)
>>>>  	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
>>>>  }
>>>>  
>>>> +static int redist_disable_lpis(void)
>>>> +{
>>>> +	void __iomem *rbase = gic_data_rdist_rd_base();
>>>> +	u64 val;
>>>> +	int ret;
>>>> +
>>>> +	if (!gic_rdists_supports_plpis()) {
>>>> +		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>>>> +		return -ENXIO;
>>>> +	}
>>>> +
>>>> +	val = readl_relaxed(rbase + GICR_CTLR);
>>>> +	if (!(val & GICR_CTLR_ENABLE_LPIS))
>>>> +		return 0;
>>>> +
>>>> +	/* Disable LPIs */
>>>> +	val &= ~GICR_CTLR_ENABLE_LPIS;
>>>> +	writel_relaxed(val, rbase + GICR_CTLR);
>>>> +
>>>> +	/* Make sure any change to GICR_CTLR is observable by the GIC */
>>>> +	dsb(sy);
>>>> +
>>>> +	/* Wait for GICR_CTLR.GICR_CTLR_ENABLE_LPIS==0 or timeout */
>>>> +	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
>>>> +					 !(val & GICR_CTLR_ENABLE_LPIS), 1,
>>>> +					 USEC_PER_SEC);
>>>
>>> Why do you need to poll on EnableLPIs? It is supposed to be immediately
>>> written. It seems to me that the sequence should be:
>>>
>>
>> Agree we don't need to poll EnableLPIs here. I'll remove.
>>
>>> - Check EnableLPis
>>> - If set to 1, scream about bootloader being braindead
>>> - Write EnableLPIs to 0
>>> - Read back EnableLpis:
>>> - If still set 1, bail out, we're doomed. Scream about the HW being
>>>   braindead
>>> - Poll RWP
>>> - If timeout, bail out, the HW has locked up. Scream again.
>>>
>>> I think this should cover the whole thing. An alternative would be to
>>> place the poll between the write and read-back, but that doesn't change
>>> anything.
>>>
>>
>> I'll prefer your second approach. Please comment on the below change before
>> I post v3.
>>
>> static int redist_disable_lpis(void)
>> {
>>         void __iomem *rbase = gic_data_rdist_rd_base();
>>         u64 val;
>>         int ret;
>>
>>         if (!gic_rdists_supports_plpis()) {
>>                 pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>>                 return -ENXIO;
>>         }
>>
>>         if (!(readl(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS))
>>                 return 0;
>>
>>         pr_warn("CPU%d: Trying to disable LPIs\n", smp_processor_id());
> 
> I'd be much more clear:
> 
> 	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
> 		smp_processor_id());
> 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> 
>>         val &= ~GICR_CTLR_ENABLE_LPIS;
>>         writel_relaxed(val, rbase + GICR_CTLR);
>>
>>         /* Make sure any change to GICR_CTLR is observable by the GIC */
>>         dsb(sy);
>>
>>         /**
>>          * Software must observe RWP==0 after clearing GICR_CTLR.EnableLPIs
>>          * from 1 to 0 before programming GICR_PEND{PROP}BASER registers.
>>          * Bail out the driver probe() in case of timeout.
>>          */
>>         ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
>>                                                 !(val & GICR_CTLR_RWP), 1,
>>                                                 USEC_PER_SEC);
>>         if (ret) {
>>                 pr_err("CPU%d: EnableLPIs not observed\n", smp_processor_id());
> 
> Let's call a spade a spade: the redistributor hasn't reacted after a
> whole second, it has probably locked-up. Just say so, because your
> message doesn't mean much to me.
> 

Sure I'll change, and also readX_relaxed_poll_XXX() helper macros aren't usable during
GIC/ITS probe time, noticed kernel crashes when I tested KEXEC/KDUMP kernel on QDF2400.
I believe this's because of the timer subsystem "timer_init()" is initialized after
calling init_IRQ(). I've to go back to v1 change for handling timeout.

        while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
                if (!timeout) {
                        pr_err("CPU%d: Failed to observe RWP==0 after disabling LPIs\n",
                               smp_processor_id());
                        return -ETIMEDOUT;
                }
                udelay(1);
                timeout--;
                cpu_relax();
        }
 
>>                 return ret;
>>         }
>>  
>>         /**
>>          * After it has been written to 1, it is IMPLEMENTATION DEFINED whether
>>          * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to 0.
>>          * Bail out the driver probe() on systems where it's RES1.
>>          */
>>         if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
>>                 pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
>>                 return -EPERM;
> 
> EPERM? EBUSY was a better approximation...
> 
> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

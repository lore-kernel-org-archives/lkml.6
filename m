Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3269C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE705218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAXLCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:02:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbfAXLCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:02:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 078F9E4EAC34FFC8DB67;
        Thu, 24 Jan 2019 19:02:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 19:02:22 +0800
Subject: Re: [PATCH] irqchip/gic-v4: fix occasional VLPI drop
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1548233948-7450-1-git-send-email-guoheyi@huawei.com>
 <86munq8hvk.wl-marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, <yangyingliang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <efcc0903-d701-d667-610f-59c115578bab@huawei.com>
Date:   Thu, 24 Jan 2019 19:02:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86munq8hvk.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/24 18:33, Marc Zyngier wrote:
> On Wed, 23 Jan 2019 08:59:08 +0000,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> 1. In current implementation, every VLPI will temporarily be mapped to
>> the first CPU in system (normally CPU0) and then moved to the real
>> scheduled CPU later.
>>
>> 2. So there is a time window and a VLPI may be sent to CPU0 instead of
>> the real scheduled vCPU, in a multi-CPU virtual machine.
>>
>> 3. However, CPU0 may have not been scheduled as a virtual CPU after
>> system boots up, so the value of its GICR_VPROPBASER is unknown at
>> that moment.
>>
>> 4. If the INTID of VLPI is larger than 2^(GICR_VPROPBASER.IDbits+1),
>> while IDbits is also in unknown state, GIC will behave as if the VLPI
>> is out of range and simply drop it, which results in interrupt missing
>> in Guest.
>>
>> As no code will clear GICR_VPROPBASER at runtime, we can safely
>> initialize the IDbits field at boot time for each CPU to get rid of
>> this issue.
>>
>> We also clear Valid bit of GICR_VPENDBASER in case any ancient
>> programming gets left in and causes memory corrupting.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 3365d44..634c8a7 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2145,6 +2145,31 @@ static void its_cpu_init_lpis(void)
>>   	val |= GICR_CTLR_ENABLE_LPIS;
>>   	writel_relaxed(val, rbase + GICR_CTLR);
>>   
>> +	if (gic_rdists->has_vlpis) {
>> +		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>> +
>> +		/*
>> +		 * It's possible for CPU to receive VLPIs before it is
>> +		 * sheduled as a vPE, especially for the first CPU, and the
>> +		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
>> +		 * as out of range and dropped by GIC.
>> +		 * So we initialize IDbits to known value to avoid VLPI drop.
>> +		 */
>> +		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
>> +		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
>> +			smp_processor_id(), val);
>> +		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>> +
>> +		/*
>> +		 * Also clear Valid bit of GICR_VPENDBASER, in case some
>> +		 * ancient programming gets left in and has possibility of
>> +		 * corrupting memory.
>> +		 */
>> +		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
>> +		val &= ~GICR_VPENDBASER_Valid;
>> +		gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
> I'm afraid it is not enough to just write back with the valid bit
> clear. You need to make sure Dirty has been cleared before continuing,
> which is why I was asking you to reuse some bits of its_vpe_deschedule.
>
> Something like this:
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e992a40f..1808cb5f6a3e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2751,9 +2751,8 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>   	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
>   }
>   
> -static void its_vpe_deschedule(struct its_vpe *vpe)
> +static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
>   {
> -	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>   	u32 count = 1000000;	/* 1s! */
>   	bool clean;
>   	u64 val;
> @@ -2773,7 +2772,17 @@ static void its_vpe_deschedule(struct its_vpe *vpe)
>   		}
>   	} while (!clean && count);
>   
> -	if (unlikely(!clean && !count)) {
> +	return val;
> +}
> +
> +static void its_vpe_deschedule(struct its_vpe *vpe)
> +{
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
> +	u64 val;
> +
> +	val = its_clear_vpend_valid(vlpi_base);
> +
> +	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
>   		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
>   		vpe->idai = false;
>   		vpe->pending_last = true;
>
> And you can the rewrite the above GICR_VPENDBASER_Valid clearing as:
>
> 	val = its_clear_vpend_valid(vlpi_base);
> 	WARN_ON(val & GICR_VPENDBASER_Dirty);
>
> We'll at least get a warning if something goes wrong.
Got it. Will send a v2 ASAP :)

Thanks,

Heyi
>
> Thanks,
>
> 	M.
>



Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD99DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B2220855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfAVMoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:44:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728215AbfAVMoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:44:39 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F737E65A215CA40E838;
        Tue, 22 Jan 2019 20:44:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 22 Jan 2019
 20:44:29 +0800
Subject: Re: [RFC] irq-gic-v3-its: fix occasional VLPI drop
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1548071508-11846-1-git-send-email-guoheyi@huawei.com>
 <86fttl9fxh.wl-marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <b9392bee-7e54-749c-04d9-5e7fee3a6203@huawei.com>
Date:   Tue, 22 Jan 2019 20:44:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86fttl9fxh.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for your feedback. Please see my comments below.


On 2019/1/22 17:53, Marc Zyngier wrote:
> Hi Heyi,
>
> On Mon, 21 Jan 2019 11:51:48 +0000,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Every VLPI will temporarily be mapped to the first CPU in system
>> (normally CPU0) and then moved to the real scheduled CPU later. There
>> is a time window so a VLPI may be sent to CPU0 instead of the real
>> scheduled vCPU, in a multi-CPU virtual machine. However, CPU0 may have
>> not been scheduled as a virtual CPU after system boots up, so the
>> value of GICR_VPROPBASER still be the reset value. According to GIC
>> spec, the reset value of IDbits in GICR_VPROPBASER is architecturally
>> UNKNOWN, and the GIC will behave as if all virtual LPIs are out of
>> range if it is less than 0b1101. On our platform the GICR will simply
>> drop the incoming VLPI, which results in interrupt missing in Guest.
> OK, it took me some time to page this horror back in. So let's see if
> I can sum-up the issue correctly:
Sorry for not explaining the whole thing clearly...

>
> - When a VM gets created, all the vPEs are mapped to CPU0's
>    redistributor.
Not exactly on VM geting created, but when the passthru PCI device driver in Guest tries to enable MSI interrupts. The specific code is in its_map_vm().
>
> - If a device starts emitting VLPIs targeting a vPE that has not run
>    yet, these VLPIs are forwarded to CPU0's redistributor.
>
> - If CPU0 has itself never run any vPE, its GICR_PROPBASER is not
>    initialised, meaning that the IDbits field may contain a value that
>    makes the redistributor drop the interrupt on the floor.
Yes.
>
> Is that a correct assessment of the issue you're seeing? If so, I
> think you have a very good point here, and this looks like a hole in
> the driver.
>
> Comments below:
>
>> As no code will clear GICR_VPROPBASER at runtime, we can safely
>> initialize the IDbits field at boot time for each CPU to get rid of
>> this issue.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index db20e99..6116215 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2144,6 +2144,20 @@ static void its_cpu_init_lpis(void)
>>   	val |= GICR_CTLR_ENABLE_LPIS;
>>   	writel_relaxed(val, rbase + GICR_CTLR);
>>   
>> +	/*
>> +	 * Temporary workaround for vlpi drop on Hi1620.
> Why is this specific to this implementation? Isn't this an issue that
> affects every GICv4 implementations?
This was an internal patch and I forgot to modify the comment before sending out, either not 100% sure that it is the common behavior of GICv4 to drop VLPI if IDbits is not correctly configured.
I can change it in V2.

>
>> +	 * IDbits must be set before any VLPI is sent to this CPU, or else the
>> +	 * VLPI will be considered as out of range and dropped.
>> +	 */
>> +	if (gic_rdists->has_vlpis) {
>> +		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>> +
>> +		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
>> +		pr_info("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
>> +			smp_processor_id(), val);
> I don't think this pr_info is useful to a normal user, as it is only
> debug information. I'm actually minded to demote a bunch of the GICv3
> prints to pr_debug.
OK.
>> +		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>> +	}
>> +
> I think we need to clear GICR_VPENDBASER.Valid too (you can probably
> reuse part of its_vpe_deschedule for that), so that we don't get into
> a bizarre situation where CPU0's redistributor has some ancient
> programming left in, and could start corrupting memory.
I can do that for safety. But is it possible of corrupting memory? Even if GICR_VPENDBASER.Valid==1, I don't think it is possible that GICR_VPENDBASER.Physical_Address equals to VPT_addr, so kernel should consider vPE is not sheculed on CPU0 and only memory pointed by VPT_addr will be modified. Please let me know if I'm wrong :)
>
>>   	/* Make sure the GIC has seen the above */
>>   	dsb(sy);
>>   out:
>> -- 
>> 1.8.3.1
>>
> Can you please respin this quickly with the above changes?
Sure.

Thanks,
Heyi
>
> Thanks,
>
> 	M.
>



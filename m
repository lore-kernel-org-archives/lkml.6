Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20833C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58DD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58DD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJRLkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:40:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbeJRLkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:40:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5A28FC860299D;
        Thu, 18 Oct 2018 11:41:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 18 Oct 2018
 11:41:33 +0800
Subject: Re: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating
 SPIs
To:     Marc Zyngier <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
 <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
 <a8ea3f08-8d60-13bf-edcc-03298a9cfb0d@arm.com>
CC:     <tglx@linutronix.de>, <guohanjun@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5BC800EB.5070201@huawei.com>
Date:   Thu, 18 Oct 2018 11:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <a8ea3f08-8d60-13bf-edcc-03298a9cfb0d@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc

On 2018/10/18 0:30, Marc Zyngier wrote:
> On 16/10/18 10:15, Yang Yingliang wrote:
>> Now with
>> 5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
>> we can support MBIGEN to generate message based SPIs by writing GICD_SETSPIR.
>>
>> The first 64-pins of each MBIGEN chip is used to generate SPIs, and each
>> MBIGEN chip has several MBIGEN nodes, every node has 128 pins for generating
>> LPIs. The total pins are: 64(SPIs) + 128 * node_nr(LPIs). So we can translate
>> the pin index in a unified way in mbigen_domain_translate().
>>
>> Also Add TYPE and VEC registers that used by generating SPIs, the driver can
>> access them when MBIGEN is used to generate SPIs.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/irqchip/irq-mbigen.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index f05998f..37c1932 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -48,6 +48,7 @@
>>   #define MBIGEN_NODE_OFFSET		0x1000
>>   
>>   /* offset of vector register in mbigen node */
>> +#define REG_MBIGEN_SPI_VEC_OFFSET	0x500
>>   #define REG_MBIGEN_LPI_VEC_OFFSET	0x200
>>   
>>   /**
>> @@ -62,6 +63,7 @@
>>    * This register is used to configure interrupt
>>    * trigger type
>>    */
>> +#define REG_MBIGEN_SPI_TYPE_OFFSET	0x400
>>   #define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
>>   
>>   /**
>> @@ -79,6 +81,9 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>>   {
>>   	unsigned int nid, pin;
>>   
>> +	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP)
>> +		return (hwirq * 4 + REG_MBIGEN_SPI_VEC_OFFSET);
>> +
>>   	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
>>   	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>>   	pin = hwirq % IRQS_PER_MBIGEN_NODE;
>> @@ -92,6 +97,13 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
>>   {
>>   	unsigned int nid, irq_ofst, ofst;
>>   
>> +	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
>> +		*mask = 1 << (hwirq % 32);
>> +		ofst = hwirq / 32 * 4;
>> +		*addr = ofst + REG_MBIGEN_SPI_TYPE_OFFSET;
>> +		return;
>> +	}
>> +
>>   	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
>>   	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>>   	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
>> @@ -162,6 +174,12 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>>   	u32 val;
>>   
>>   	base += get_mbigen_vec_reg(d->hwirq);
>> +
>> +	if (d->hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
>> +		writel_relaxed(msg->data, base);
>> +		return;
>> +	}
> How is the GICD_SETSPI_NSR base address programmed if you're ignoring
> the address stored in the message?
Now, this base address is encoded in MBIGEN register by default.

In case this address isn't set to register in later SoCs, I think the
MBIGEN driver set this base address would be better. I will add
relative codes to handle both GICD_SETSPI_NSR and ITS Translate
address.

>
> How do you deal with level interrupts, as you don't seem to use the
> level MSI framework either?
The MBIGEN driver need to clear active state in irq_eoi hook, when it
dealing with level SPIs.

>
>> +
>>   	val = readl_relaxed(base);
>>   
>>   	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
>> @@ -182,8 +200,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
>>   		if (fwspec->param_count != 2)
>>   			return -EINVAL;
>>   
>> -		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
>> -			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
>> +		if (fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM)
>>   			return -EINVAL;
>>   		else
>>   			*hwirq = fwspec->param[0];
>>
> Now, the biggest question of them all: how does it work with ACPI? Last
> time I checked, there was no DT support for platforms using the MBIGEN.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hip07.dtsi
This DT describes how platform devices using the MBIGEN.

>
> My gut feeling is that it would be so much better if the SPIs generated
> by the MBIGEN were configured in firmware, and the devices behind it
> would just describe the corresponding SPI...
We need use this framework to clear active state in MBIGEN register, so 
configuring
in firmware is not enough...

Regards,
Yang
>
> Thanks,
>
> 	M.



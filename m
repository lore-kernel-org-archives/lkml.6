Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4FBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1179D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937774AbeFSMSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:18:37 -0400
Received: from foss.arm.com ([217.140.101.70]:48696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937580AbeFSMSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2BB1529;
        Tue, 19 Jun 2018 05:18:35 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B06333F557;
        Tue, 19 Jun 2018 05:18:33 -0700 (PDT)
Subject: Re: [PATCH 2/6] irqchip/ls-scfg-msi: Fix MSI affinity handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20180619115546.12196-1-marc.zyngier@arm.com>
 <20180619115546.12196-3-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1806191357350.1684@nanos.tec.linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3a7c0811-ac8f-dc1f-a184-f9197b3201bd@arm.com>
Date:   Tue, 19 Jun 2018 13:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806191357350.1684@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 13:00, Thomas Gleixner wrote:
> On Tue, 19 Jun 2018, Marc Zyngier wrote:
> 
>> The ls-scfs-msi driver is not dealing with the effective affinity
>> as it should. Let's fix that, and make it clear that the effective
>> affinity is restricted to a single CPU.
>>
>> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/irqchip/irq-ls-scfg-msi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
>> index 1ec3bfe56693..2811cc53e425 100644
>> --- a/drivers/irqchip/irq-ls-scfg-msi.c
>> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
>> @@ -121,7 +121,8 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
>>  		return -EINVAL;
>>  	}
>>  
>> -	cpumask_copy(irq_data->common->affinity, mask);
>> +	cpumask_copy(irq_data->common->affinity, cpumask_of(cpu));
> 
> That's wrong. The driver should not fiddle with the affinity mask at all
> and just store the effective mask.

Ah, very good point. The ls_scfg_msi_compose_msg callback is also pretty
dodgy in that respect...

> 
>> +	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
>>  
>>  	return IRQ_SET_MASK_OK;
> 
> If yuo look at the call site, then you'll notice that it will do:
> 
>         case IRQ_SET_MASK_OK:
>         case IRQ_SET_MASK_OK_DONE:
>                 cpumask_copy(desc->irq_common_data.affinity, mask);
> 
> So the cpumask_copy() can just go away.

Thanks for noticing that. I've fixed it up as follow:

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 2811cc53e425..c671b3212010 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -93,8 +93,12 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
 	msg->data = data->hwirq;
 
-	if (msi_affinity_flag)
-		msg->data |= cpumask_first(data->common->affinity);
+	if (msi_affinity_flag) {
+		const struct cpumask *mask;
+
+		mask = irq_data_get_effective_affinity_mask(data);
+		msg->data |= cpumask_first(mask);
+	}
 
 	iommu_dma_map_msi_msg(data->irq, msg);
 }
@@ -121,7 +125,6 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
 		return -EINVAL;
 	}
 
-	cpumask_copy(irq_data->common->affinity, cpumask_of(cpu));
 	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

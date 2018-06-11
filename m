Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b0rIJplbHlskIgAAmS7hNA
	; Mon, 11 Jun 2018 11:24:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0414960792; Mon, 11 Jun 2018 11:24:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2183F601C3;
	Mon, 11 Jun 2018 11:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2183F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeFKLYY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:24:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50837 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932804AbeFKLYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:24:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6535629807F53;
        Mon, 11 Jun 2018 19:24:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Mon, 11 Jun 2018
 19:24:14 +0800
Subject: Re: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
To: Marc Zyngier <marc.zyngier@arm.com>, <julien.thierry@arm.com>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
 <0ebd8eef-1a86-3c7e-cd3b-f9580c497b5c@arm.com>
CC: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5B1E5BBE.9010907@huawei.com>
Date: Mon, 11 Jun 2018 19:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <0ebd8eef-1a86-3c7e-cd3b-f9580c497b5c@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc

On 2018/6/11 17:31, Marc Zyngier wrote:
> On 06/06/18 03:40, Yang Yingliang wrote:
>> When the kernel booted with maxcpus=x, 'x' is smaller
>> than actual cpu numbers, the TAs of offline cpus won't
>> be set to its->collection.
>>
>> If LPI is bind to offline cpu, sync cmd will use zero TA,
>> it leads to ITS queue timeout.  Fix this by choosing a
>> online cpu, if there is no online cpu in cpu_mask.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5416f2b..d8b9539 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2309,7 +2309,9 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>>   		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>>   
>>   	/* Bind the LPI to the first possible CPU */
>> -	cpu = cpumask_first(cpu_mask);
>> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>> +	if (cpu >= nr_cpu_ids)
>> +		cpu = cpumask_first(cpu_online_mask);
> I've thought about this one a bit more, and apart from breaking TX1
> in a very bad way, I think it is actually correct. It is just that
> the commit message doesn't make much sense.
>
> The way I understand it is:
> - this is a NUMA system, with at least one node not online
> - the SRAT table indicates that this ITS is local to an offline node
Yes, your comment is more proper and correct. Mine describes how the BUG 
happens.
I will send a v3 later with proper comment.

Thanks,
Yang
>
> In that case, we need to pick an online CPU, and any will do (again,
> ignoring the silly Cavium erratum). Explained like this, the above
> hunk is sensible, and just needs to handle the TX1 quirk. Something like:
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5416f2b2ac21..21b7b5151177 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2309,7 +2309,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>   		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>   
>   	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first(cpu_mask);
> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	if (cpu >= nr_cpu_idx) {
> +		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
> +			return -EINVAL;
> +
> +		cpu = cpumask_first(cpu_online_mask);
> +	}
>   	its_dev->event_map.col_map[event] = cpu;
>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>   
>
>>   	its_dev->event_map.col_map[event] = cpu;
>>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   
>> @@ -2466,7 +2468,10 @@ static int its_vpe_set_affinity(struct irq_data *d,
>>   				bool force)
>>   {
>>   	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> -	int cpu = cpumask_first(mask_val);
>> +	int cpu = cpumask_first_and(mask_val, cpu_online_mask);
>> +
>> +	if (cpu >= nr_cpu_ids)
>> +		cpu = cpumask_first(cpu_online_mask);
>>   
>>   	/*
>>   	 * Changing affinity is mega expensive, so let's be as lazy as
>>
> This hunk, on the other hand, is completely useless. Look how this is
> called from vgic_v4_flush_hwstate():
>
> 	err = irq_set_affinity(irq, cpumask_of(smp_processor_id()));
>
> The mask is always that of the CPU we run on, and we're in a non-premptible
> section. So no way we can be targeting an offline CPU.
>
> If you quickly respin this patch with a decent commit log, I'll take it.
>
> Thanks,
>
> 	M.

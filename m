Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeFFBnb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 21:43:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57179 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751977AbeFFBna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 21:43:30 -0400
Subject: Re: [PATCH] irqchip/gic-v3-its: fix ITS queue timeout
To: Julien Thierry <julien.thierry@arm.com>, <marc.zyngier@arm.com>
References: <1528180225-16144-1-git-send-email-yangyingliang@huawei.com>
 <834fde1b-5ae0-afc6-283f-2a470757e54a@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5B173C27.30401@huawei.com>
Date: Wed, 6 Jun 2018 09:43:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <834fde1b-5ae0-afc6-283f-2a470757e54a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien

On 2018/6/5 18:16, Julien Thierry wrote:
> Hi Yang,
>
> On 05/06/18 07:30, Yang Yingliang wrote:
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
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 5416f2b..edd92a9 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2309,7 +2309,9 @@ static int its_irq_domain_activate(struct 
>> irq_domain *domain,
>>           cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>>         /* Bind the LPI to the first possible CPU */
>> -    cpu = cpumask_first(cpu_mask);
>> +    cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
>> +    if (!cpu_online(cpu))
>
> Testing for cpu being online here feels a bit redundant.
>
> Since cpu is online if the cpumask_first_and returns a valid cpu, I 
> think you could replace this test with:
>
>     if (cpu >= nr_cpu_ids)
Yes, I used wrong check here, according to comment of cpumask_first_and, 
this func will returns >= nr_cpu_ids if no cpus set in both.

I'll send v2 later.
>
>> +        cpu = cpumask_first(cpu_online_mask);
>>       its_dev->event_map.col_map[event] = cpu;
>>       irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>   @@ -2466,7 +2468,10 @@ static int its_vpe_set_affinity(struct 
>> irq_data *d,
>>                   bool force)
>>   {
>>       struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> -    int cpu = cpumask_first(mask_val);
>> +    int cpu = cpumask_first_and(mask_val, cpu_online_mask);
>> +
>> +    if (!cpu_online(cpu))
>
> Same thing here.
>
>> +        cpu = cpumask_first(cpu_online_mask);
>>         /*
>>        * Changing affinity is mega expensive, so let's be as lazy as
>>
>
> Cheers,
>

Thanks,
Yang

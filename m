Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935696AbeCABzF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:55:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932134AbeCABzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:55:04 -0500
Subject: Re: [PATCH] irqchip/gic-v3-its: handle rd_idx wrapping in
 its_wait_for_range_completion()
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1518320521-12536-1-git-send-email-yangyingliang@huawei.com>
 <866073z7pr.wl-marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5A975D2F.1010302@huawei.com>
Date: Thu, 1 Mar 2018 09:53:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <866073z7pr.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/2/12 2:45, Marc Zyngier wrote:
Hi, Marc

Sorry for replying so late.
> On Sun, 11 Feb 2018 03:42:01 +0000,
> Yang Yingliang wrote:
>
> Hi Yang,
>
>> In direct case, rd_idx will wrap if other cpus post commands
>> that make rd_idx increase. When rd_idx wrapped, the driver prints
>> timeout messages but in fact the command is finished. To handle
>> this case by adding last_rd_id to check rd_idx whether wrapped.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Please always Cc LKML on irqchip related patches.
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 84 ++++++++++++++++++++++------------------
>>   1 file changed, 46 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 06f025f..d7176d1 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -713,7 +713,8 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
>>   
>>   static int its_wait_for_range_completion(struct its_node *its,
>>   					 struct its_cmd_block *from,
>> -					 struct its_cmd_block *to)
>> +					 struct its_cmd_block *to,
>> +					 u64 last_rd_idx)
>>   {
>>   	u64 rd_idx, from_idx, to_idx;
>>   	u32 count = 1000000;	/* 1s! */
>> @@ -724,9 +725,14 @@ static int its_wait_for_range_completion(struct its_node *its,
>>   	while (1) {
>>   		rd_idx = readl_relaxed(its->base + GITS_CREADR);
>>   
>> -		/* Direct case */
>> -		if (from_idx < to_idx && rd_idx >= to_idx)
>> -			break;
>> +
>> +		/*
>> +		 * Direct case. In this case, rd_idx may wrapped,
>> +		 * because other cpus may post commands that make
>> +		 * rd_idx increase.
>> +		 */
>> +		if (from_idx < to_idx && (rd_idx >= to_idx || rd_idx < last_rd_idx))
>> +				break;
>>   
>>   		/* Wrapped case */
>>   		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
>> @@ -746,40 +752,42 @@ static int its_wait_for_range_completion(struct its_node *its,
> [...]
>
>> +	last_rd_idx = readl_relaxed(its->base + GITS_CREADR);			\
> What is this last_rd_idx exactly? It is just some random sampling of
> the read pointer after we've posted our commands. It can still be in
> any position. And if the reader as wrapped because other CPUs are
> feeding more commands to the queue, it could just as well overtake
> last_rd_idx, making your new condition just as false. Yes, this is
> unlikely, but still.
>
> If you're going to harden the command queue wrapping, I'd suggest you
> implement a generation mechanism so that we can easily work out if
> we've seen the queue wrapping or not. THis would lift any kind of
> ambiguity once and for all.
I get a lot of timeout messages, when I am doing set affinity stress 
testing which
will post many its commands. I will try another way to handle the 
wrapped case.

Regards,
Yang
>
> Thanks,
>
> 	M.
>

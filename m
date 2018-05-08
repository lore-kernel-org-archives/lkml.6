Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeEHB4g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:56:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36081 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753737AbeEHB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:56:32 -0400
X-Google-Smtp-Source: AB8JxZqoXrLVe8iVhkTezpcPcWaepCkU6G2hQbb+jmnnV0LB7VjvqMcXTkXt7CZ1anhlzcAMkACxQw==
Subject: Re: [PATCH] net: 8390: Fix possible data races in __ei_get_stats
To: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        fthain@telegraphics.com.au, joe@perches.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180507140809.28847-1-baijiaju1990@gmail.com>
 <e48345b4-fe9f-d267-777b-6a51baba0307@gmail.com>
 <d4de4f6c-c697-fde5-9d31-d8792621bfb5@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c336fdb9-4865-4729-d34b-84dd0bfc9af5@gmail.com>
Date: Mon, 7 May 2018 18:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d4de4f6c-c697-fde5-9d31-d8792621bfb5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2018 05:51 PM, Jia-Ju Bai wrote:
> 
> 
> On 2018/5/7 22:15, Eric Dumazet wrote:
>>
>> On 05/07/2018 07:08 AM, Jia-Ju Bai wrote:
>>> The write operations to "dev->stats" are protected by
>>> the spinlock on line 862-864, but the read operations to
>>> this data on line 858 and 867 are not protected by the spinlock.
>>> Thus, there may exist data races for "dev->stats".
>>>
>>> To fix the data races, the read operations to "dev->stats" are
>>> protected by the spinlock, and a local variable is used for return.
>>>
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/net/ethernet/8390/lib8390.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/8390/lib8390.c b/drivers/net/ethernet/8390/lib8390.c
>>> index c9c55c9eab9f..198952247d30 100644
>>> --- a/drivers/net/ethernet/8390/lib8390.c
>>> +++ b/drivers/net/ethernet/8390/lib8390.c
>>> @@ -852,19 +852,25 @@ static struct net_device_stats *__ei_get_stats(struct net_device *dev)
>>>       unsigned long ioaddr = dev->base_addr;
>>>       struct ei_device *ei_local = netdev_priv(dev);
>>>       unsigned long flags;
>>> +    struct net_device_stats *stats;
>>> +
>>> +    spin_lock_irqsave(&ei_local->page_lock, flags);
>>>         /* If the card is stopped, just return the present stats. */
>>> -    if (!netif_running(dev))
>>> -        return &dev->stats;
>>> +    if (!netif_running(dev)) {
>>> +        stats = &dev->stats;
>>> +        spin_unlock_irqrestore(&ei_local->page_lock, flags);
>>> +        return stats;
>>> +    }
>>>   -    spin_lock_irqsave(&ei_local->page_lock, flags);
>>>       /* Read the counter registers, assuming we are in page 0. */
>>>       dev->stats.rx_frame_errors  += ei_inb_p(ioaddr + EN0_COUNTER0);
>>>       dev->stats.rx_crc_errors    += ei_inb_p(ioaddr + EN0_COUNTER1);
>>>       dev->stats.rx_missed_errors += ei_inb_p(ioaddr + EN0_COUNTER2);
>>> +    stats = &dev->stats;
>>>       spin_unlock_irqrestore(&ei_local->page_lock, flags);
>>>   -    return &dev->stats;
>>> +    return stats;
>>>   }
>>>     /*
>>>
>> dev->stats is not a pointer, it is an array embedded in the
>> struct net_device
>>
>> So this patch is not needed, since dev->stats can not change.
> 
> Thanks for your reply :)
> 
> I do not understand that why "dev->stats can not change".
> Its data is indeed changed by the code:
>      dev->stats.rx_frame_errors  += ei_inb_p(ioaddr + EN0_COUNTER0);
>      dev->stats.rx_crc_errors    += ei_inb_p(ioaddr + EN0_COUNTER1);
>      dev->stats.rx_missed_errors += ei_inb_p(ioaddr + EN0_COUNTER2);

So ?

> 
> So I think a data race may occur when returning "dev->stats" without lock protection.

&dev->stats is a stable value.

It wont change over the lifetime of net_device object.

Adding a barrier before or after getting &dev->stats is useless, confusing and really not needed.



> 
> By the way, I find this possible data race is similar to the previous commit 7b31b4deda76 for the tg3 driver.

Very different things really.

This does a copy of the whole stats, not the pointer :

*stats = tp->net_stats_prev;


I guess you are confusing simple C semantics about returning the address of a structure,
instead of returning a whole structure.

If __ei_get_stats(struct net_device *dev) prototype was :

struct net_device_stats __ei_get_stats(struct net_device *dev) 

instead of :

struct net_device_stats *__ei_get_stats(struct net_device *dev) 

Then sure, your patch might been needed.

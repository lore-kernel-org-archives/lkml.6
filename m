Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3254E2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3254E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbeHPNQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:16:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729663AbeHPNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:16:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B83C2A62DED6E;
        Thu, 16 Aug 2018 18:18:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 16 Aug 2018
 18:18:45 +0800
Message-ID: <5B754F84.3070502@huawei.com>
Date:   Thu, 16 Aug 2018 18:18:44 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm/mach-at91/pm: Do not double put the device node
References: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com> <20180814125954.GM943@piout.net> <59e252e6-6027-9f52-9ee8-8d0bd32659d2@microchip.com>
In-Reply-To: <59e252e6-6027-9f52-9ee8-8d0bd32659d2@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/16 17:32, Claudiu Beznea wrote:
> Hi Alexandre,
>
> On 14.08.2018 15:59, Alexandre Belloni wrote:
>> On 14/08/2018 09:54:56+0800, zhong jiang wrote:
>>> Device node iterators put the previous value of the index variable,
>>> so an explicit put causes a double put.
>>>
>> While for_each_matching_node_and_match will get and put the node
>> properly, there is also a call to of_find_device_by_node that will get a
>> reference to the node.
>>
> Looking through of_find_device_by_node() it seems that a put_device() on the
> struct device member of the returned struct platform_device has to be called
> instead of of_node_put().
>
> of_find_device_by_node() calls bus_find_device():
>
> dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match); 
>
> the match function, of_dev_node_match(), is just as follows:
>
> static int of_dev_node_match(struct device *dev, void *data)                    
> {                                                                               
>         return dev->of_node == data;                                            
> }                                                                               
>
> but bus_find_device() takes a reference to the struct device returned in case it
> founds a match, via get_device():
>
> struct device *bus_find_device(struct bus_type *bus,                            
>                                struct device *start, void *data,                
>                                int (*match)(struct device *dev,
> 			       void*data))    
> {                                                                               
>         struct klist_iter i;                                                    
>         struct device *dev;                                                     
>                                                                                 
>         if (!bus || !bus->p)                                                    
>                 return NULL;                                                    
>                                                                                 
>         klist_iter_init_node(&bus->p->klist_devices, &i,                        
>                              (start ? &start->p->knode_bus : NULL));            
>         while ((dev = next_device(&i)))                                         
>                 if (match(dev, data) && get_device(dev))                        
>                         break;                                                  
>         klist_iter_exit(&i);                                                    
>         return dev;                                                             
> }                                                                               
>
> So, I think a put_device(&pdev->dev) has to be called in at91_pm_config_ws()
> instead of of_node_put(np). My bad!
Yes, you're right. Thanks, Claudiu. I will repost in v2.

Sincerely,
zhong jiang
> Thank you,
> Claudiu Beznea
>
>>> I detect the issue with the help of Coccinelle.
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  arch/arm/mach-at91/pm.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>> index 32fae4d..a5ec35f 100644
>>> --- a/arch/arm/mach-at91/pm.c
>>> +++ b/arch/arm/mach-at91/pm.c
>>> @@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>>>  
>>>  			/* Check if enabled on SHDWC. */
>>>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
>>> -				goto put_node;
>>> +				continue;
>>>  
>>>  			mode |= wsi->pmc_fsmr_bit;
>>>  			if (wsi->set_polarity)
>>>  				polarity |= wsi->pmc_fsmr_bit;
>>>  		}
>>> -
>>> -put_node:
>>> -		of_node_put(np);
>>>  	}
>>>  
>>>  	if (mode) {
>>> -- 
>>> 1.7.12.4
>>>
> .
>



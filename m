Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB972148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB972148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbeHPMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:30:18 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4419 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeHPMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:30:18 -0400
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="15384163"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Aug 2018 02:33:00 -0700
Received: from [10.145.4.54] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Thu, 16 Aug 2018
 02:32:59 -0700
Subject: Re: [PATCH] arm/mach-at91/pm: Do not double put the device node
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        zhong jiang <zhongjiang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@armlinux.org.uk>
References: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
 <20180814125954.GM943@piout.net>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <59e252e6-6027-9f52-9ee8-8d0bd32659d2@microchip.com>
Date:   Thu, 16 Aug 2018 12:32:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814125954.GM943@piout.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 14.08.2018 15:59, Alexandre Belloni wrote:
> On 14/08/2018 09:54:56+0800, zhong jiang wrote:
>> Device node iterators put the previous value of the index variable,
>> so an explicit put causes a double put.
>>
> 
> While for_each_matching_node_and_match will get and put the node
> properly, there is also a call to of_find_device_by_node that will get a
> reference to the node.
> 

Looking through of_find_device_by_node() it seems that a put_device() on the
struct device member of the returned struct platform_device has to be called
instead of of_node_put().

of_find_device_by_node() calls bus_find_device():

dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match); 

the match function, of_dev_node_match(), is just as follows:

static int of_dev_node_match(struct device *dev, void *data)                    
{                                                                               
        return dev->of_node == data;                                            
}                                                                               

but bus_find_device() takes a reference to the struct device returned in case it
founds a match, via get_device():

struct device *bus_find_device(struct bus_type *bus,                            
                               struct device *start, void *data,                
                               int (*match)(struct device *dev,
			       void*data))    
{                                                                               
        struct klist_iter i;                                                    
        struct device *dev;                                                     
                                                                                
        if (!bus || !bus->p)                                                    
                return NULL;                                                    
                                                                                
        klist_iter_init_node(&bus->p->klist_devices, &i,                        
                             (start ? &start->p->knode_bus : NULL));            
        while ((dev = next_device(&i)))                                         
                if (match(dev, data) && get_device(dev))                        
                        break;                                                  
        klist_iter_exit(&i);                                                    
        return dev;                                                             
}                                                                               

So, I think a put_device(&pdev->dev) has to be called in at91_pm_config_ws()
instead of of_node_put(np). My bad!

Thank you,
Claudiu Beznea

>> I detect the issue with the help of Coccinelle.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm/mach-at91/pm.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>> index 32fae4d..a5ec35f 100644
>> --- a/arch/arm/mach-at91/pm.c
>> +++ b/arch/arm/mach-at91/pm.c
>> @@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>>  
>>  			/* Check if enabled on SHDWC. */
>>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
>> -				goto put_node;
>> +				continue;
>>  
>>  			mode |= wsi->pmc_fsmr_bit;
>>  			if (wsi->set_polarity)
>>  				polarity |= wsi->pmc_fsmr_bit;
>>  		}
>> -
>> -put_node:
>> -		of_node_put(np);
>>  	}
>>  
>>  	if (mode) {
>> -- 
>> 1.7.12.4
>>
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECM7I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:59:08 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:20107 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeECM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:59:05 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="13747120"
Subject: Re: [RFC PATCH 3/5] net: macb: Add pm runtime support
To: Harini Katakam <harinik@xilinx.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-4-git-send-email-harinikatakamlinux@gmail.com>
 <48b8ea24-52be-c314-f674-1a6cae4d95f4@microchip.com>
 <CAFcVECKWz6bGZpg7UF=4hObUjca12Oq5NbE0SBL+v=1grJP8YA@mail.gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <87bd6e9f-be18-b267-a01d-c4efc2adc55d@microchip.com>
Date: Thu, 3 May 2018 15:59:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFcVECKWz6bGZpg7UF=4hObUjca12Oq5NbE0SBL+v=1grJP8YA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.05.2018 14:13, Harini Katakam wrote:
> Hi Claudiu,
> 
> On Thu, May 3, 2018 at 3:39 PM, Claudiu Beznea
> <Claudiu.Beznea@microchip.com> wrote:
>>
>>
>> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>>> From: Harini Katakam <harinik@xilinx.com>
> <snip>
>> I would use a "goto" instruction, e.g.:
>>                 value = -ETIMEDOUT;
>>                 goto out;
>>
> 
> Will do
> 
>>
>> Below, in macb_open() you have a return err; case:
>>         err = macb_alloc_consistent(bp);
>>         if (err) {
>>                 netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
>>                            err);
>>                 return err;
>>         }
>>
>> You have to undo pm_runtime_get_sync() with pm_runtime_put_sync() or something
>> similar to decrement dev->power.usage_count.
> 
> Will do
> 
> <snip>
>>> @@ -4104,11 +4145,16 @@ static int macb_remove(struct platform_device *pdev)
>>>               mdiobus_free(bp->mii_bus);
>>>
>>>               unregister_netdev(dev);
>>> -             clk_disable_unprepare(bp->tx_clk);
>>> -             clk_disable_unprepare(bp->hclk);
>>> -             clk_disable_unprepare(bp->pclk);
>>> -             clk_disable_unprepare(bp->rx_clk);
>>> -             clk_disable_unprepare(bp->tsu_clk);
>>> +             pm_runtime_disable(&pdev->dev);
>>> +             pm_runtime_dont_use_autosuspend(&pdev->dev);
>>> +             if (!pm_runtime_suspended(&pdev->dev)) {
>>> +                     clk_disable_unprepare(bp->tx_clk);
>>> +                     clk_disable_unprepare(bp->hclk);
>>> +                     clk_disable_unprepare(bp->pclk);
>>> +                     clk_disable_unprepare(bp->rx_clk);
>>> +                     clk_disable_unprepare(bp->tsu_clk);
>>> +                     pm_runtime_set_suspended(&pdev->dev);
>>
>> This is driver remove function. Shouldn't clocks be removed?
> 
> clk_disable_unprepare IS being done here.
> The check for !pm_runtime_suspended is just to make sure the
> clocks are not already removed (in runtime_suspend).

Could this happen? Looking over code, starting with 
platform_driver_unregister() it looks to me that the runtime resume
is called just before driver remove is called.

platform_driver_unregister() ->
driver_unregister() ->
bus_remove_driver() ->
driver_detach() ->
device_release_driver_internal() ->
__device_release_driver()
{
	// ...
        pm_runtime_get_sync(dev);		// runtime resume                                       
        pm_runtime_clean_up_links(dev);                                 
 
	// ...

	pm_runtime_put_sync(dev);                                       
                                                                                
        if (dev->bus && dev->bus->remove)                               
        	dev->bus->remove(dev);                                  
        else if (drv->remove)                                           
                drv->remove(dev);                                       

	// ...
}

Thank you,
Claudiu

> 
> Regards,
> Harini
> 

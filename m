Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ECEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3CA208E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r7DQ6yWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3CA208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbeHGJPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:15:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47296 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbeHGJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:15:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7771gSn094804;
        Tue, 7 Aug 2018 02:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533625302;
        bh=F/CxWgRru+2wOhdgeE/DXO/BsoXXzxFi9F0NdacViTg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=r7DQ6yWGgnOluNcOGYFFcaxdoxeiAAb0UvL8AiCQG/8rO3Ghp07tHgQx4+bpUUDwT
         7Mg00ZmvLsJc6jLfWBXUNzQx/p/4vkUEUcX66aThaO4VCK2EfhBOJ5BSSj8Qcs7TGE
         xu+19crAKCNyXaX8UL/in72AiN3JqLjJtAeOH+Rg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7771gET007547;
        Tue, 7 Aug 2018 02:01:42 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 7 Aug
 2018 02:01:42 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 7 Aug 2018 02:01:42 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7771blq020429;
        Tue, 7 Aug 2018 02:01:37 -0500
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
To:     Huang Shijie <sjhuang@iluvatar.ai>,
        Alexandre Bailon <abailon@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave.jiang@intel.com>,
        <radhey.shyam.pandey@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <jmkrzyszt@gmail.com>, <gomonovych@gmail.com>,
        <keescook@chromium.org>, <horms+renesas@verge.net.au>,
        <geert+renesas@glider.be>, <shawnguo@kernel.org>,
        <baoyou.xie@linaro.org>, <michal.simek@xilinx.com>,
        <baohua@kernel.org>, <ludovic.desroches@microchip.com>,
        <linus.walleij@linaro.org>, <david.brown@linaro.org>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
 <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
 <20180806032847.GA4452@hsj-Precision-5520>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0f35be3f-24c0-f7e4-66c8-e9b7e5c01590@ti.com>
Date:   Tue, 7 Aug 2018 10:01:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180806032847.GA4452@hsj-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-08-06 06:28, Huang Shijie wrote:
> On Fri, Aug 03, 2018 at 10:55:25AM +0300, Peter Ujfalusi wrote:
>>
>>
>> On 2018-08-03 10:19, Huang Shijie wrote:
>>> Use dmaenginem_async_device_register to simplify the code:
>>>    remove dma_async_device_unregister
>>>
>>> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
>>> ---
>>>  drivers/dma/ti/cppi41.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
>>> index 1497da367710..d2998a19ed2e 100644
>>> --- a/drivers/dma/ti/cppi41.c
>>> +++ b/drivers/dma/ti/cppi41.c
>>> @@ -1096,21 +1096,19 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>>>  		goto err_chans;
>>>  	cdd->irq = irq;
>>>  
>>> -	ret = dma_async_device_register(&cdd->ddev);
>>> +	ret = dmaenginem_async_device_register(&cdd->ddev);
>>>  	if (ret)
>>>  		goto err_chans;
>>>  
>>>  	ret = of_dma_controller_register(dev->of_node,
>>>  			cppi41_dma_xlate, &cpp41_dma_info);
>>>  	if (ret)
>>> -		goto err_of;
>>> +		goto err_chans;
>>>  
>>>  	pm_runtime_mark_last_busy(dev);
>>>  	pm_runtime_put_autosuspend(dev);
>>>  
>>>  	return 0;
>>> -err_of:
>>> -	dma_async_device_unregister(&cdd->ddev);
>>>  err_chans:
>>>  	deinit_cppi41(dev, cdd);
>>>  err_init_cppi:
>>> @@ -1132,7 +1130,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>>>  		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
>>>  			__func__, error);
>>>  	of_dma_controller_free(pdev->dev.of_node);
>>> -	dma_async_device_unregister(&cdd->ddev);
>>
>> If I read the code right then this is not safe.
> I read the code again, and find it is okay.
> 
>> We would have deinitalized cppi41 driver which is not functional, but we
>> will still have the dma device registered and if a channel is requested
>> we will have kernel crash.
> We cannot succeed to request a channel when the drv->remove() is called.
> 
> Please see __device_release_driver:
>   ---------------------------------------------------------------------
> 		if (dev->bus && dev->bus->remove)
> 			dev->bus->remove(dev);
> 		else if (drv->remove)
> 			drv->remove(dev);
> 
> 		device_links_driver_cleanup(dev);
> 		dma_deconfigure(dev);
> 
> 		devres_release_all(dev);    ============> Devres release
>   ---------------------------------------------------------------------
> 
> For the DMA engine driver, there is only one case which will calls drv->remove():
>         Use the rmmod(or modprobe -r).
> 
> We do not use the device_link_add API for DMA engines.
> And we not manually call the device_release_driver() for DMA engines.
> 
> But when we use the rmmod, the module state will be MODULE_STATE_GOING.
> In the find_candidate(), dma_chan_get() will fail.
> And we cannot get a channel.
> 
> Please correct me if I am wrong :)

You are perfectly right.

It might be only me, but I like to keep the resource teardown in a
reverse order of their creation. If everything is devm then it is granted.

In case of cppi4 it looks safe after reading in to the DMAengine core,
module core and platform core code.

But does the removed three lines worth over the clarity of how the
module removal is proceeding?

Alexandre and Tony put lots of effort to the cppi4 driver, I let them
decide.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757468AbeD0Gxw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:53:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:42786 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757381AbeD0Gxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:53:51 -0400
Subject: Re: [PATCH v2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
To: Vinod Koul <vinod.koul@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com
References: <20180426174000.12008-1-mdf@kernel.org>
 <20180427051115.GX6014@localhost>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <748ffc14-de12-c11e-eb12-65c599fe5f4e@metafoo.de>
Date: Fri, 27 Apr 2018 08:53:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427051115.GX6014@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 07:11 AM, Vinod Koul wrote:
> On Thu, Apr 26, 2018 at 10:40:00AM -0700, Moritz Fischer wrote:
>> Request IRQ with IRQF_SHARED flag. This works since the interrupt
>> handler already checks if there is an actual IRQ pending and returns
>> IRQ_NONE otherwise.
> 
> hmmm what are we trying to fix here? Is your device on a shared line or not?

IRQF_SHARED does not mean that the IRQ is on a shared line. It means that
the driver can handle it if the IRQ is on a shared line. Since the driver
can handle it setting the flag is a good idea since this enables usecases
where the line is shared.

> 
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>> Changes from v1:
>> - Added Lars' Acked-by
>> - Dropped patch [1/2] and changed accordingly
>> ---
>>  drivers/dma/dma-axi-dmac.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
>> index 2419fe524daa..15b2453d2647 100644
>> --- a/drivers/dma/dma-axi-dmac.c
>> +++ b/drivers/dma/dma-axi-dmac.c
>> @@ -687,7 +687,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto err_unregister_device;
>>  
>> -	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, 0,
>> +	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
>>  		dev_name(&pdev->dev), dmac);
>>  	if (ret)
>>  		goto err_unregister_of;
>> -- 
>> 2.17.0
>>
> 

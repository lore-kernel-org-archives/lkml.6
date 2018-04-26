Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756775AbeDZQ0f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:26:35 -0400
Received: from www381.your-server.de ([78.46.137.84]:44478 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeDZQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:26:31 -0400
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Use devm_request_irq()
To: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com
References: <20180426161239.15234-1-mdf@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <36dd1547-38a3-0658-b25f-fbb41d6fe265@metafoo.de>
Date: Thu, 26 Apr 2018 18:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426161239.15234-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 06:12 PM, Moritz Fischer wrote:
> Use devm_request_irq() instead of request_irq() to request the IRQ.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi Lars,
> 
> was there a specific reason not to use devm_request_irq() ?

Yes, it is wrong :)

This reorders the sequence in the remove() function. We really need to free
the IRQ at the point in the sequence where it is at the moment. We need to
call tasklet_kill() after the free_irq() function has been called, otherwise
the tasklet can be re-scheduled and we might end up with a use after free.

But also if we disable the clock to the core before the IRQ is freed we
might end up trying to access the register map while the clock is off and
then never get a response and block the AXI bus.

This is all very very unlikely to ever happen, but still I'd like to have
correct code.

> 
> Cheers,
> 
> Moritz
> 
> ---
>  drivers/dma/dma-axi-dmac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 2419fe524daa..75ccedaa96d2 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -687,8 +687,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_device;
>  
> -	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, 0,
> -		dev_name(&pdev->dev), dmac);
> +	ret = devm_request_irq(&pdev->dev, dmac->irq,
> +			       axi_dmac_interrupt_handler, 0,
> +			       dev_name(&pdev->dev), dmac);
>  	if (ret)
>  		goto err_unregister_of;
>  
> @@ -711,7 +712,6 @@ static int axi_dmac_remove(struct platform_device *pdev)
>  	struct axi_dmac *dmac = platform_get_drvdata(pdev);
>  
>  	of_dma_controller_free(pdev->dev.of_node);
> -	free_irq(dmac->irq, dmac);
>  	tasklet_kill(&dmac->chan.vchan.task);
>  	dma_async_device_unregister(&dmac->dma_dev);
>  	clk_disable_unprepare(dmac->clk);
> 

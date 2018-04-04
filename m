Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDDMpN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:45:13 -0400
Received: from www381.your-server.de ([78.46.137.84]:36798 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDDMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:45:10 -0400
Subject: Re: [PATCH 1/1] dmaengine:jz4740:fix memory leak
To: Xidong Wang <wangxidong_97@163.com>, Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1522812118-25763-1-git-send-email-wangxidong_97@163.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <04a5860c-f4d4-48fe-f1c0-d84ebad79df7@metafoo.de>
Date: Wed, 4 Apr 2018 14:45:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522812118-25763-1-git-send-email-wangxidong_97@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 05:21 AM, Xidong Wang wrote:
> In function jz4740_dma_probe(), the memory allocated by
> clk_get() is not released on the error path that ret, which holds
> the return value of dma_async_device_register(), is not NULL.
> This will result in a memory leak bug.
> 
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>

Maybe use devm_clk_get() since the same clk_put() call is missing in the
remove callback.

> ---
>  drivers/dma/dma-jz4740.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
> index afd5e10..082c158 100644
> --- a/drivers/dma/dma-jz4740.c
> +++ b/drivers/dma/dma-jz4740.c
> @@ -570,6 +570,7 @@ static int jz4740_dma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(dd);
>  err_clk:
>  	clk_disable_unprepare(dmadev->clk);
> +	clk_put(dmadev->clk);
>  	return ret;
>  }
>  
> 

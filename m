Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeDDF4i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:56:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:26257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDF4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:56:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="40538103"
Date: Wed, 4 Apr 2018 11:30:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Xidong Wang <wangxidong_97@163.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dmaengine:jz4740:fix memory leak
Message-ID: <20180404060056.GG15443@localhost>
References: <1522812118-25763-1-git-send-email-wangxidong_97@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522812118-25763-1-git-send-email-wangxidong_97@163.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 11:21:58AM +0800, Xidong Wang wrote:
> In function jz4740_dma_probe(), the memory allocated by
> clk_get() is not released on the error path that ret, which holds
> the return value of dma_async_device_register(), is not NULL.
> This will result in a memory leak bug.

I dont think we cna cal it mem leak, it seems your ref counting of clock
resource is imbalance as you dont free up which eventually would lead to mem
leak. Also dabove description needs a bit of cleanup please

> 
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>
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
> -- 
> 2.7.4
> 
> 

-- 
~Vinod

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F382172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mCVUqD62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F382172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeHCJuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:50:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36418 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHCJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:50:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w737tMPN084470;
        Fri, 3 Aug 2018 02:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533282922;
        bh=TtmRGzYiYl89s1qnvC2204ZWt8WRN2Pzv/dACAC6nwU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mCVUqD62pmw71/zUm12CFOEfqoRkvHUdFdhexqL0ssrFFLoM63HRSFzBNNrHjLfAN
         BsbceucmcFObrful/mtdGuxex10NPpyhK5t9i9CPUbiMY4XEMpI3KocVpBd7wZHoy2
         053VjYgg6yYJNHbyFAMAMuTLv1Ux1NwkhtvgMM8c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737tMLN005133;
        Fri, 3 Aug 2018 02:55:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 02:55:22 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 02:55:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737tHhr000650;
        Fri, 3 Aug 2018 02:55:18 -0500
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
To:     Huang Shijie <sjhuang@iluvatar.ai>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dave.jiang@intel.com>, <radhey.shyam.pandey@xilinx.com>,
        <appana.durga.rao@xilinx.com>, <jmkrzyszt@gmail.com>,
        <gomonovych@gmail.com>, <keescook@chromium.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <shawnguo@kernel.org>, <baoyou.xie@linaro.org>,
        <michal.simek@xilinx.com>, <baohua@kernel.org>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <david.brown@linaro.org>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
Date:   Fri, 3 Aug 2018 10:55:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-10-sjhuang@iluvatar.ai>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-08-03 10:19, Huang Shijie wrote:
> Use dmaenginem_async_device_register to simplify the code:
>    remove dma_async_device_unregister
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  drivers/dma/ti/cppi41.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> index 1497da367710..d2998a19ed2e 100644
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -1096,21 +1096,19 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>  		goto err_chans;
>  	cdd->irq = irq;
>  
> -	ret = dma_async_device_register(&cdd->ddev);
> +	ret = dmaenginem_async_device_register(&cdd->ddev);
>  	if (ret)
>  		goto err_chans;
>  
>  	ret = of_dma_controller_register(dev->of_node,
>  			cppi41_dma_xlate, &cpp41_dma_info);
>  	if (ret)
> -		goto err_of;
> +		goto err_chans;
>  
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
> -err_of:
> -	dma_async_device_unregister(&cdd->ddev);
>  err_chans:
>  	deinit_cppi41(dev, cdd);
>  err_init_cppi:
> @@ -1132,7 +1130,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
>  			__func__, error);
>  	of_dma_controller_free(pdev->dev.of_node);
> -	dma_async_device_unregister(&cdd->ddev);

If I read the code right then this is not safe.
We would have deinitalized cppi41 driver which is not functional, but we
will still have the dma device registered and if a channel is requested
we will have kernel crash.

It falls in the same case as omap-dma, edma.

>  
>  	devm_free_irq(&pdev->dev, cdd->irq, cdd);
>  	deinit_cppi41(&pdev->dev, cdd);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

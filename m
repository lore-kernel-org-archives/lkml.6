Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950492172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rV/wxjnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950492172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbeHCJpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:45:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58504 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeHCJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:45:30 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w737oDuf013563;
        Fri, 3 Aug 2018 02:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533282613;
        bh=nhm9Zsxi9ckPK0xorZB31CSf9CT6W/VouZeylRePeTY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rV/wxjnJI93NNtJA7EISdrLRGeeGGEeuGDmBSTKdMRIkbrY6o2PXlxKj7QHO9FYaK
         OsrzYCjTf855ftp+wJnnCtAs4UWBWnubRN7FTu6e2n+9Sn6XhxemEEV/GkVjptyoi6
         LtfZrpEcXkyA0kU+tS+utZ7A3kc8zlgvXvTr1mFc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737oD8t028845;
        Fri, 3 Aug 2018 02:50:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 02:50:10 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 02:50:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737o66P014971;
        Fri, 3 Aug 2018 02:50:06 -0500
Subject: Re: [PATCH 08/46] dmaengine: edma: use
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
 <20180803072016.21544-9-sjhuang@iluvatar.ai>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c47c117b-dfc7-12e7-7769-15dcf6716d32@ti.com>
Date:   Fri, 3 Aug 2018 10:50:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-9-sjhuang@iluvatar.ai>
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
>  drivers/dma/ti/edma.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ceabdea40ae0..28ba1e722c47 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2388,18 +2388,17 @@ static int edma_probe(struct platform_device *pdev)
>  	ecc->dma_slave.filter.mapcnt = info->slavecnt;
>  	ecc->dma_slave.filter.fn = edma_filter_fn;
>  
> -	ret = dma_async_device_register(&ecc->dma_slave);
> +	ret = dmaenginem_async_device_register(&ecc->dma_slave);
>  	if (ret) {
>  		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
>  		goto err_reg1;
>  	}
>  
>  	if (ecc->dma_memcpy) {
> -		ret = dma_async_device_register(ecc->dma_memcpy);
> +		ret = dmaenginem_async_device_register(ecc->dma_memcpy);
>  		if (ret) {
>  			dev_err(dev, "memcpy ddev registration failed (%d)\n",
>  				ret);
> -			dma_async_device_unregister(&ecc->dma_slave);
>  			goto err_reg1;
>  		}
>  	}
> @@ -2439,9 +2438,6 @@ static int edma_remove(struct platform_device *pdev)
>  
>  	if (dev->of_node)
>  		of_dma_controller_free(dev->of_node);
> -	dma_async_device_unregister(&ecc->dma_slave);
> -	if (ecc->dma_memcpy)
> -		dma_async_device_unregister(ecc->dma_memcpy);

I'm afraid this is not safe either, we need to free the dummy_slot
_after_ the dma device is unregistered.

>  	edma_free_slot(ecc, ecc->dummy_slot);
>  
>  	return 0;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

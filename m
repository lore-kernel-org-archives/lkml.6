Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8AA2172E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HY/IKGyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AA2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeHCJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:42:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52856 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeHCJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:42:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w737lThg000960;
        Fri, 3 Aug 2018 02:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533282449;
        bh=dJDBtCF8izwdGhh9L9LLu1La1YJTEb0pZy9PTIVDLyY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HY/IKGywv0uJP1te+mRV+A6BM1z6OeMp4vVvAxOd8hQBG6HYfk85AksewhXakLwUK
         tec8grsOFJXxr1lOkPVy3kuiy5xgaYlrDiQaopxK+hwvQMsvGURLmBLbH0eAmCpBHv
         u1aEeXpTLf6rde7ba1uFuQq8Khv+m5GQLKSZIGPg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737lSbu018348;
        Fri, 3 Aug 2018 02:47:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 02:47:28 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 02:47:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w737lN3u027567;
        Fri, 3 Aug 2018 02:47:24 -0500
Subject: Re: [PATCH 07/46] dmaengine: omap-dma: use
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
 <20180803072016.21544-8-sjhuang@iluvatar.ai>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <646b3c1a-cf42-43ba-1f20-6c1375c78517@ti.com>
Date:   Fri, 3 Aug 2018 10:47:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-8-sjhuang@iluvatar.ai>
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
>  drivers/dma/ti/omap-dma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a4a931ddf6f6..085748c6eb67 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1566,7 +1566,7 @@ static int omap_dma_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	rc = dma_async_device_register(&od->ddev);
> +	rc = dmaenginem_async_device_register(&od->ddev);

Why it is dmaenginem_async_device_register() and not aligned other
resource managed functions (devm_* dmam_*), like
devm_dma_async_device_register()

and in dmaenginem_async_device_register() what is the 'm' in dmaenginem ?
DMAengine Managed?

>  	if (rc) {
>  		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
>  			rc);
> @@ -1584,7 +1584,6 @@ static int omap_dma_probe(struct platform_device *pdev)
>  				of_dma_simple_xlate, &omap_dma_info);
>  		if (rc) {
>  			pr_warn("OMAP-DMA: failed to register DMA controller\n");
> -			dma_async_device_unregister(&od->ddev);
>  			omap_dma_free(od);
>  		}
>  	}
> @@ -1606,8 +1605,6 @@ static int omap_dma_remove(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 1);
>  	devm_free_irq(&pdev->dev, irq, od);
>  
> -	dma_async_device_unregister(&od->ddev);
> -

I think this is a bad idea in general.
We need to unregister the dma-device before we clean up and free resources.

>  	if (!od->legacy) {
>  		/* Disable all interrupts */
>  		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
> 

I'm sorry to say, but it is a NACK from me.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

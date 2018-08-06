Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB729C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8545A219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="gJS+YqWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8545A219CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeHFFgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:36:03 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:5265 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeHFFgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:36:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id BC1CD1071E33E;
        Mon,  6 Aug 2018 11:32:30 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id s3qeorhY9623; Mon,  6 Aug 2018 11:32:30 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id EDCD710C742AA;
        Mon,  6 Aug 2018 11:32:29 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai EDCD710C742AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533526350;
        bh=oasZ1O0zqr4bqmIUCkLzqR6RgN8dO1/xgBGfEgsO/sk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=gJS+YqWtIeFPdydF70IoW2OGoulrtDBgbIEL5jM55MHVA8NapkwA8rfvaZMIeXxKt
         HfUvjDISsUtHUjnaSjZIKrw9reHJY+8B3OjmM2ou+u2A0iK+WNWcpo2xENvgDoXL+M
         SIKZF9VDtuFHDsew/3vXLiou3bTXJadwFRlhlJ64=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M7D-clwsZ2fD; Mon,  6 Aug 2018 11:32:29 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [192.168.128.73])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 6A93C1071E33E;
        Mon,  6 Aug 2018 11:32:29 +0800 (CST)
Date:   Mon, 6 Aug 2018 11:28:47 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        radhey.shyam.pandey@xilinx.com, appana.durga.rao@xilinx.com,
        jmkrzyszt@gmail.com, gomonovych@gmail.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
Message-ID: <20180806032847.GA4452@hsj-Precision-5520>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
 <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:55:25AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 2018-08-03 10:19, Huang Shijie wrote:
> > Use dmaenginem_async_device_register to simplify the code:
> >    remove dma_async_device_unregister
> > 
> > Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> > ---
> >  drivers/dma/ti/cppi41.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> > index 1497da367710..d2998a19ed2e 100644
> > --- a/drivers/dma/ti/cppi41.c
> > +++ b/drivers/dma/ti/cppi41.c
> > @@ -1096,21 +1096,19 @@ static int cppi41_dma_probe(struct platform_device *pdev)
> >  		goto err_chans;
> >  	cdd->irq = irq;
> >  
> > -	ret = dma_async_device_register(&cdd->ddev);
> > +	ret = dmaenginem_async_device_register(&cdd->ddev);
> >  	if (ret)
> >  		goto err_chans;
> >  
> >  	ret = of_dma_controller_register(dev->of_node,
> >  			cppi41_dma_xlate, &cpp41_dma_info);
> >  	if (ret)
> > -		goto err_of;
> > +		goto err_chans;
> >  
> >  	pm_runtime_mark_last_busy(dev);
> >  	pm_runtime_put_autosuspend(dev);
> >  
> >  	return 0;
> > -err_of:
> > -	dma_async_device_unregister(&cdd->ddev);
> >  err_chans:
> >  	deinit_cppi41(dev, cdd);
> >  err_init_cppi:
> > @@ -1132,7 +1130,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
> >  			__func__, error);
> >  	of_dma_controller_free(pdev->dev.of_node);
> > -	dma_async_device_unregister(&cdd->ddev);
> 
> If I read the code right then this is not safe.
I read the code again, and find it is okay.

> We would have deinitalized cppi41 driver which is not functional, but we
> will still have the dma device registered and if a channel is requested
> we will have kernel crash.
We cannot succeed to request a channel when the drv->remove() is called.

Please see __device_release_driver:
  ---------------------------------------------------------------------
		if (dev->bus && dev->bus->remove)
			dev->bus->remove(dev);
		else if (drv->remove)
			drv->remove(dev);

		device_links_driver_cleanup(dev);
		dma_deconfigure(dev);

		devres_release_all(dev);    ============> Devres release
  ---------------------------------------------------------------------

For the DMA engine driver, there is only one case which will calls drv->remove():
        Use the rmmod(or modprobe -r).

We do not use the device_link_add API for DMA engines.
And we not manually call the device_release_driver() for DMA engines.

But when we use the rmmod, the module state will be MODULE_STATE_GOING.
In the find_candidate(), dma_chan_get() will fail.
And we cannot get a channel.

Please correct me if I am wrong :)

Thanks
Huang Shijie

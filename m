Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5661C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924E2172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="gbRb3VK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6924E2172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeHCJtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:49:52 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:37851 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeHCJtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:49:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 166AE1399B2DC;
        Fri,  3 Aug 2018 15:58:22 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KFSesKwdLxQQ; Fri,  3 Aug 2018 15:58:21 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 4D5C11399B2E1;
        Fri,  3 Aug 2018 15:58:21 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 4D5C11399B2E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533283101;
        bh=fufAXkl0jww+2jbN/j77Q1uL+s3wxxi3yw08A+4VMdU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=gbRb3VK3diksLOxuQpxlEabOggXIg5oYcJbb2LdgWMBP8Xt0VznlQd1uI2WcF4cil
         wzw3Z7QQll82klTotbZ5mlG2nX1DI/u6+VcZw/T7DetJB4ppaen8G5tndpcW+ft20f
         OGyfgrhNiqg9svpl51ARZLIU7vTwL9rwHQzEnMyk=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id amD6Uk562EiN; Fri,  3 Aug 2018 15:58:21 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 01A4D1399B2DC;
        Fri,  3 Aug 2018 15:58:18 +0800 (CST)
Date:   Fri, 3 Aug 2018 15:54:35 +0800
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
Subject: Re: [PATCH 08/46] dmaengine: edma: use
 dmaenginem_async_device_register to simplify the code
Message-ID: <20180803075434.GB29473@hsj-Precision-5520>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-9-sjhuang@iluvatar.ai>
 <c47c117b-dfc7-12e7-7769-15dcf6716d32@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47c117b-dfc7-12e7-7769-15dcf6716d32@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:50:13AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 2018-08-03 10:19, Huang Shijie wrote:
> > Use dmaenginem_async_device_register to simplify the code:
> >    remove dma_async_device_unregister
> > 
> > Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> > ---
> >  drivers/dma/ti/edma.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > index ceabdea40ae0..28ba1e722c47 100644
> > --- a/drivers/dma/ti/edma.c
> > +++ b/drivers/dma/ti/edma.c
> > @@ -2388,18 +2388,17 @@ static int edma_probe(struct platform_device *pdev)
> >  	ecc->dma_slave.filter.mapcnt = info->slavecnt;
> >  	ecc->dma_slave.filter.fn = edma_filter_fn;
> >  
> > -	ret = dma_async_device_register(&ecc->dma_slave);
> > +	ret = dmaenginem_async_device_register(&ecc->dma_slave);
> >  	if (ret) {
> >  		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
> >  		goto err_reg1;
> >  	}
> >  
> >  	if (ecc->dma_memcpy) {
> > -		ret = dma_async_device_register(ecc->dma_memcpy);
> > +		ret = dmaenginem_async_device_register(ecc->dma_memcpy);
> >  		if (ret) {
> >  			dev_err(dev, "memcpy ddev registration failed (%d)\n",
> >  				ret);
> > -			dma_async_device_unregister(&ecc->dma_slave);
> >  			goto err_reg1;
> >  		}
> >  	}
> > @@ -2439,9 +2438,6 @@ static int edma_remove(struct platform_device *pdev)
> >  
> >  	if (dev->of_node)
> >  		of_dma_controller_free(dev->of_node);
> > -	dma_async_device_unregister(&ecc->dma_slave);
> > -	if (ecc->dma_memcpy)
> > -		dma_async_device_unregister(ecc->dma_memcpy);
> 
> I'm afraid this is not safe either, we need to free the dummy_slot
> _after_ the dma device is unregistered.
> 
Thanks for pointing this.

I will drop this patch ...

Thanks
Huang Shijie

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30372172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="WNUswWaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30372172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHCJsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:48:05 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:32588 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeHCJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:48:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id DA44F1399B2D0;
        Fri,  3 Aug 2018 15:56:34 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 17Azqr7g-vie; Fri,  3 Aug 2018 15:56:34 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 209581399B2D7;
        Fri,  3 Aug 2018 15:56:34 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 209581399B2D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533282994;
        bh=ZKUA63PGbfMuTi1qOyJ5C5nCWV2L+BPxsWRsJ9CXug0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=WNUswWaAoHaHHQqH/uUEee8uaxDxitrHD+g15JlnfVvNsHby6c64cgRYbiwBNvuj1
         iX7E+eHxKrnYCpBaNKGEXcpYi58HuWvLIw1JvrqtKjUDC6BQFb9/008DLwNi4SqX+8
         zJ1B5VV3w+0EWl1XSOhD9FPMHc9oc2hYSHVxfa4o=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9_KEcyo7wyln; Fri,  3 Aug 2018 15:56:34 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 9961D1399B2D0;
        Fri,  3 Aug 2018 15:56:33 +0800 (CST)
Date:   Fri, 3 Aug 2018 15:52:51 +0800
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
Subject: Re: [PATCH 07/46] dmaengine: omap-dma: use
 dmaenginem_async_device_register to simplify the code
Message-ID: <20180803075250.GA29473@hsj-Precision-5520>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-8-sjhuang@iluvatar.ai>
 <646b3c1a-cf42-43ba-1f20-6c1375c78517@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646b3c1a-cf42-43ba-1f20-6c1375c78517@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:47:30AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 2018-08-03 10:19, Huang Shijie wrote:
> > Use dmaenginem_async_device_register to simplify the code:
> >    remove dma_async_device_unregister
> > 
> > Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> > ---
> >  drivers/dma/ti/omap-dma.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> > index a4a931ddf6f6..085748c6eb67 100644
> > --- a/drivers/dma/ti/omap-dma.c
> > +++ b/drivers/dma/ti/omap-dma.c
> > @@ -1566,7 +1566,7 @@ static int omap_dma_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > -	rc = dma_async_device_register(&od->ddev);
> > +	rc = dmaenginem_async_device_register(&od->ddev);
> 
> Why it is dmaenginem_async_device_register() and not aligned other
> resource managed functions (devm_* dmam_*), like
> devm_dma_async_device_register()
Vinod prefer the this dmaenginem_async_device_register..	
> 
> and in dmaenginem_async_device_register() what is the 'm' in dmaenginem ?
> DMAengine Managed?
Yes.
> 
> >  	if (rc) {
> >  		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
> >  			rc);
> > @@ -1584,7 +1584,6 @@ static int omap_dma_probe(struct platform_device *pdev)
> >  				of_dma_simple_xlate, &omap_dma_info);
> >  		if (rc) {
> >  			pr_warn("OMAP-DMA: failed to register DMA controller\n");
> > -			dma_async_device_unregister(&od->ddev);
> >  			omap_dma_free(od);
> >  		}
> >  	}
> > @@ -1606,8 +1605,6 @@ static int omap_dma_remove(struct platform_device *pdev)
> >  	irq = platform_get_irq(pdev, 1);
> >  	devm_free_irq(&pdev->dev, irq, od);
> >  
> > -	dma_async_device_unregister(&od->ddev);
> > -
> 
> I think this is a bad idea in general.
> We need to unregister the dma-device before we clean up and free resources.
okay, thanks for pointing here.
We can drop this patch now...

> 
> >  	if (!od->legacy) {
> >  		/* Disable all interrupts */
> >  		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
> > 
> 
> I'm sorry to say, but it is a NACK from me.
No problem.

Thanks
Huang Shijie

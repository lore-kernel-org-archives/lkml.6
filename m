Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFEEC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3EF21C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P186TWqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3EF21C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeHIE6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeHIE6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:58:49 -0400
Received: from localhost (unknown [122.167.122.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0613021C2E;
        Thu,  9 Aug 2018 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533782179;
        bh=nNuRjwguRoxVUdPSPDLjD7SCKchOGkCZAvSHHLtkCvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P186TWqBSumii+rV96tMfH/Hq9bawlPeg4/9nXB/Fl+v3x93TmAqae5SINzvL6t+i
         9JZH9ireLpEr3SnqUx9IxZMy5B8iAKX6Ek6MrYAR/SbDC2HWKoEgTyqFwdIazAyF6I
         tLW3wKElowfvXyaPnmO531usTkSRvGr2zc+MysnM=
Date:   Thu, 9 Aug 2018 08:06:11 +0530
From:   Vinod <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Huang Shijie <sjhuang@iluvatar.ai>, dmaengine@vger.kernel.org,
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
Message-ID: <20180809023611.GP2395@vkoul-mobl>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-8-sjhuang@iluvatar.ai>
 <646b3c1a-cf42-43ba-1f20-6c1375c78517@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646b3c1a-cf42-43ba-1f20-6c1375c78517@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-08-18, 10:47, Peter Ujfalusi wrote:
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
> 
> and in dmaenginem_async_device_register() what is the 'm' in dmaenginem ?
> DMAengine Managed?

yup, as you rightly said we could have done devm_dmaengine... or like
few others do dmaenginem_

Yes it makes a little odd API but am trying to move away from dma_ to
dmaengine_ for everything new..

-- 
~Vinod

Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884CF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884CF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbeGWLy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:54:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGWLy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:54:59 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fhYTm-0002BQ-Hy; Mon, 23 Jul 2018 12:54:14 +0200
Message-ID: <1532343252.3163.99.camel@pengutronix.de>
Subject: Re: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, s.hauer@pengutronix.de,
        linux@armlinux.org.uk
Cc:     dmaengine@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 12:54:12 +0200
In-Reply-To: <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
         <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 24.07.2018, 01:46 +0800 schrieb Robin Gong:
> If multi-bds used in one transfer, all bds should be consisten
> memory.To easily follow it, enlarge the dma pool size into 20 bds,
> and it will report error if the number of bds is over than 20. For
> dmatest, the max count for single transfer is NUM_BD *
> SDMA_BD_MAX_CNT = 20 * 65535 = ~1.28MB.

Both the commit message and the comment need a lot more care to
actually tell what this commit is trying to achieve. Currently I don't
follow at all. What does "consisten" mean? Do you mean BDs should be
contiguous in memory?

What do you gain by over-allocating each BD by a factor of 20?

Regards,
Lucas

> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index b4ec2d2..5973489 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -298,6 +298,15 @@ struct sdma_context_data {
> >  	u32  scratch7;
>  } __attribute__ ((packed));
>  
> +/*
> + * All bds in one transfer should be consitent on SDMA. To easily follow it,just
> + * set the dma pool size as the enough bds. For example, in dmatest case, the
> + * max 20 bds means the max for single transfer is NUM_BD * SDMA_BD_MAX_CNT = 20
> + * * 65535 = ~1.28MB. 20 bds supposed to be enough basically.If it's still not
> + * enough in some specific cases, enlarge it here.Warning message would also
> + * appear if the bd numbers is over than 20.
> + */
> +#define NUM_BD 20
>  
>  struct sdma_engine;
>  
> @@ -1273,7 +1282,7 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
> >  		goto disable_clk_ahb;
>  
> >  	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
> > -				sizeof(struct sdma_buffer_descriptor),
> > +				NUM_BD * sizeof(struct sdma_buffer_descriptor),
> >  				32, 0);
>  
> >  	return 0;
> @@ -1314,6 +1323,12 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  {
> >  	struct sdma_desc *desc;
>  
> > +	if (bds > NUM_BD) {
> > +		dev_err(sdmac->sdma->dev, "%d bds exceed the max %d\n",
> > +			bds, NUM_BD);
> > +		goto err_out;
> > +	}
> +
> >  	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
> >  	if (!desc)
> >  		goto err_out;

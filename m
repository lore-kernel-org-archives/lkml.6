Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02311C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67152085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547981675;
	bh=YKlpKIB0/oY4FSN+nkVKyT6Fh0aGcZimjlQ4v5EeFr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QfXB9SRo+WT0T+8zIyQtdx1NF+LyLXZphSpKaJfhSjQkO2uEvReRwikt4ZN+lckCG
	 wA1SiGqhhQYzNqSnep/NfByOtDWBklt7aOKUXvvm1QE3gx5lK4xYlvQDoeiQJHyVfz
	 WbLBrRqtNPlmLNBjFKXDeB3+kdmtc7ECtkcx7m68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfATKye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 05:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfATKyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 05:54:33 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607C02084C;
        Sun, 20 Jan 2019 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547981673;
        bh=YKlpKIB0/oY4FSN+nkVKyT6Fh0aGcZimjlQ4v5EeFr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtU41so6/uQ3kbIP1UEcXfjIxmxpk3wP2xxy/ejOn+Q/35oybemBKIDA0m3jcD0+O
         wvb0lHfYQ3e3FAwTlNPTA5o8iOTjxE/8ck5qoAgEK2xDZNlSbOYR00ynNIxHUG76i2
         wfUgF7DQlpgPY5jrq3uN4B/9CEKSAlawsxLJ2rzI=
Date:   Sun, 20 Jan 2019 16:22:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Leonid Iziumtsev <leonid.iziumtsev@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, m.grzeschik@pengutronix.de
Subject: Re: [PATCH] dmaengine: imx-dma: fix wrong callback invoke
Message-ID: <20190120105257.GP4635@vkoul-mobl>
References: <20190115171523.702-1-leonid.iziumtsev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115171523.702-1-leonid.iziumtsev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-19, 17:15, Leonid Iziumtsev wrote:
> Once the "ld_queue" list is not empty, next descriptor will migrate
> into "ld_active" list. The "desc" variable will be overwritten
> during that transition. And later the dmaengine_desc_get_callback_invoke()
> will use it as an argument. As result we invoke wrong callback.
> 
> That behaviour was in place since:
> commit fcaaba6c7136 ("dmaengine: imx-dma: fix callback path in tasklet").
> But after commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job")
> things got worse, since possible delay between tasklet_schedule()
> from DMA irq handler and actual tasklet function execution got bigger.
> And that gave more time for new DMA request to be submitted and
> to be put into "ld_queue" list.
> 
> It has been noticed that DMA issue is causing problems for "mxc-mmc"
> driver. While stressing the system with heavy network traffic and
> writing/reading to/from sd card simultaneously the timeout may happen:
> 
> 10013000.sdhci: mxcmci_watchdog: read time out (status = 0x30004900)
> 
> That often lead to file system corruption.

This looks reasonable to me and I think should go to stable as well.
Fabio can we get some testing done on this patch

> 
> Signed-off-by: Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
> ---
>  drivers/dma/imx-dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index c2fff3f6c9ca..4a09af3cd546 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -618,7 +618,7 @@ static void imxdma_tasklet(unsigned long data)
>  {
>  	struct imxdma_channel *imxdmac = (void *)data;
>  	struct imxdma_engine *imxdma = imxdmac->imxdma;
> -	struct imxdma_desc *desc;
> +	struct imxdma_desc *desc, *next_desc;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&imxdma->lock, flags);
> @@ -648,10 +648,10 @@ static void imxdma_tasklet(unsigned long data)
>  	list_move_tail(imxdmac->ld_active.next, &imxdmac->ld_free);
>  
>  	if (!list_empty(&imxdmac->ld_queue)) {
> -		desc = list_first_entry(&imxdmac->ld_queue, struct imxdma_desc,
> -					node);
> +		next_desc = list_first_entry(&imxdmac->ld_queue,
> +					     struct imxdma_desc, node);
>  		list_move_tail(imxdmac->ld_queue.next, &imxdmac->ld_active);
> -		if (imxdma_xfer_desc(desc) < 0)
> +		if (imxdma_xfer_desc(next_desc) < 0)
>  			dev_warn(imxdma->dev, "%s: channel: %d couldn't xfer desc\n",
>  				 __func__, imxdmac->channel);
>  	}
> -- 
> 2.11.0

-- 
~Vinod

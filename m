Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C2926F97
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2MhAvmj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C2926F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeF1GCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeF1GCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:02:48 -0400
Received: from localhost (unknown [106.201.104.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB9E26F95;
        Thu, 28 Jun 2018 06:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530165767;
        bh=JH/trfOmwWXtbtnGwza9EiSUWVKgrqTyh5G+0L0DqIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MhAvmj6szf8nYWh768dvCh1JVCbaBgn7z98lQpeIQidcURztObMCj+PUfXIj0pPI
         yW19a85EhCFiHY909jy8sdpeqMmseQYo9ETP00fBio0z/5GPcGc5vr865kCO7NkmXP
         E05MEkh8S9cqYPX0zRxnEcVN/exvli8vF/ucZDTY=
Date:   Thu, 28 Jun 2018 11:32:39 +0530
From:   Vinod <vkoul@kernel.org>
To:     Guodong Xu <guodong.xu@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] k3dma: add support to reserved minimum channels
Message-ID: <20180628060239.GO22377@vkoul-mobl>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
 <20180622032416.20133-3-guodong.xu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622032416.20133-3-guodong.xu@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-18, 11:24, Guodong Xu wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> On k3 series of SoC, DMA controller reserves some channels for
> other on-chip coprocessors. By adding support to dma_min_chan, kernel
> will not be able to use these reserved channels.
> 
> One example is on Hi3660 platform, channel 0 is reserved to lpm3.
> 
> Please also refer to Documentation/devicetree/bindings/dma/k3dma.txt

and if some other platform has channel X marked for co-processor, maybe
a last channel or something in middle, how will this work then?

I am thinking this should be a mask, rather than min.

> 
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  drivers/dma/k3dma.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index fa31cccbe04f..13cec12742e3 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -113,6 +113,7 @@ struct k3_dma_dev {
>  	struct dma_pool		*pool;
>  	u32			dma_channels;
>  	u32			dma_requests;
> +	u32			dma_min_chan;
>  	unsigned int		irq;
>  };
>  
> @@ -309,7 +310,7 @@ static void k3_dma_tasklet(unsigned long arg)
>  
>  	/* check new channel request in d->chan_pending */
>  	spin_lock_irq(&d->lock);
> -	for (pch = 0; pch < d->dma_channels; pch++) {
> +	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
>  		p = &d->phy[pch];
>  
>  		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
> @@ -326,7 +327,7 @@ static void k3_dma_tasklet(unsigned long arg)
>  	}
>  	spin_unlock_irq(&d->lock);
>  
> -	for (pch = 0; pch < d->dma_channels; pch++) {
> +	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
>  		if (pch_alloc & (1 << pch)) {
>  			p = &d->phy[pch];
>  			c = p->vchan;
> @@ -825,6 +826,8 @@ static int k3_dma_probe(struct platform_device *op)
>  				"dma-channels", &d->dma_channels);
>  		of_property_read_u32((&op->dev)->of_node,
>  				"dma-requests", &d->dma_requests);
> +		of_property_read_u32((&op->dev)->of_node,
> +				"dma-min-chan", &d->dma_min_chan);
>  	}
>  
>  	d->clk = devm_clk_get(&op->dev, NULL);
> @@ -848,12 +851,12 @@ static int k3_dma_probe(struct platform_device *op)
>  		return -ENOMEM;
>  
>  	/* init phy channel */
> -	d->phy = devm_kcalloc(&op->dev,
> -		d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL);
> +	d->phy = devm_kcalloc(&op->dev, (d->dma_channels - d->dma_min_chan),
> +			sizeof(struct k3_dma_phy), GFP_KERNEL);
>  	if (d->phy == NULL)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < d->dma_channels; i++) {
> +	for (i = d->dma_min_chan; i < d->dma_channels; i++) {
>  		struct k3_dma_phy *p = &d->phy[i];
>  
>  		p->idx = i;
> -- 
> 2.17.1

-- 
~Vinod

Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99310217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549270886;
	bh=izFIddDoXDGMU7kauIY6yn+LMMFOAj1hw5hqaw6Bol0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sIk2qhEj8I63cOedrL+/tNPspWN6e9bi3/WJXvP3zsxW/r8tkci+zQQpzaM291Uxy
	 yBpvkAeCs+LioLG36vax3mx/KURtwJcrt8dbGZLzC1yt8BS0oEGDr9zax/9+p99Ewv
	 /42PR0Dbb9ZSZMoVcXLfWkJU+PBiEJMvDjcpQ7ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfBDJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:01:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfBDJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:01:24 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFA0214DA;
        Mon,  4 Feb 2019 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549270883;
        bh=izFIddDoXDGMU7kauIY6yn+LMMFOAj1hw5hqaw6Bol0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzO9GFDexdqdd8MJaSylw7+NY36fhAZK8nCWeRcmPrpBc3HfEgyBOBilEF6p9RX8/
         bslRnkrDfhsKuJfTCglXlMk5F2Q55eGLiNIqCnCqrNnQ4RAIgJcYy6ANhVEKugmUzz
         Yyx/GDrwYJMhoUl4ZUFGNql5iKVlI7npnearbvOk=
Date:   Mon, 4 Feb 2019 14:29:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 5/8 v5] dma: k3dma: Add support for dma-channel-mask
Message-ID: <20190204085953.GL4296@vkoul-mobl>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
 <1548361463-28372-6-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548361463-28372-6-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-01-19, 12:24, John Stultz wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> Add dma-channel-mask as a property for k3dma, it defines
> available dma channels which a non-secure mode driver can use.
> 
> One sample usage of this is in Hi3660 SoC. DMA channel 0 is
> reserved to lpm3, which is a coprocessor for power management. So
> as a result, any request in kernel (which runs on main processor
> and in non-secure mode) should start from at least channel 1.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> [jstultz: Reworked to use a channel mask]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Rename to hisi-dma-avail-chan
> v4: Rename to dma-channel-mask
> v5: Use BIT(i) instead of (1<<i)
> ---
>  drivers/dma/k3dma.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index e415c85..294ec64 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -111,6 +111,7 @@ struct k3_dma_dev {
>  	struct dma_pool		*pool;
>  	u32			dma_channels;
>  	u32			dma_requests;
> +	u32			dma_channel_mask;
>  	unsigned int		irq;
>  };
>  
> @@ -319,6 +320,9 @@ static void k3_dma_tasklet(unsigned long arg)
>  	/* check new channel request in d->chan_pending */
>  	spin_lock_irq(&d->lock);
>  	for (pch = 0; pch < d->dma_channels; pch++) {
> +		if (!(d->dma_channel_mask & (1<<pch)))

spaces around <<

> +			continue;
> +
>  		p = &d->phy[pch];
>  
>  		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
> @@ -336,6 +340,9 @@ static void k3_dma_tasklet(unsigned long arg)
>  	spin_unlock_irq(&d->lock);
>  
>  	for (pch = 0; pch < d->dma_channels; pch++) {
> +		if (!(d->dma_channel_mask & (1<<pch)))

and here :(

> +			continue;
> +
>  		if (pch_alloc & (1 << pch)) {
>  			p = &d->phy[pch];
>  			c = p->vchan;
> @@ -856,6 +863,13 @@ static int k3_dma_probe(struct platform_device *op)
>  				"dma-channels", &d->dma_channels);
>  		of_property_read_u32((&op->dev)->of_node,
>  				"dma-requests", &d->dma_requests);
> +		ret = of_property_read_u32((&op->dev)->of_node,
> +				"dma-channel-mask", &d->dma_channel_mask);
> +		if (ret) {
> +			dev_warn(&op->dev,
> +				 "dma-channel-mask doesn't exist, considering all as available.\n");
> +			d->dma_channel_mask = (u32)~0UL;
> +		}
>  	}
>  
>  	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
> @@ -887,8 +901,12 @@ static int k3_dma_probe(struct platform_device *op)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < d->dma_channels; i++) {
> -		struct k3_dma_phy *p = &d->phy[i];
> +		struct k3_dma_phy *p;
> +
> +		if (!(d->dma_channel_mask & BIT(i)))
> +			continue;
>  
> +		p = &d->phy[i];
>  		p->idx = i;
>  		p->base = d->base + i * 0x40;
>  	}
> -- 
> 2.7.4

-- 
~Vinod

Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D3220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O659Sua1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfAQROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:14:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44734 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfAQROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:14:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5116067pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MeVXI0LQKAJ1UD0O5QDms1RNmdhs7MNItAdyoVuHKX8=;
        b=O659Sua11tAAcPobWFRGXNSMb5tMIjosMHfF1/l6y1UgqRGc3I16IkaNFrWo4BQ6IZ
         t9vl7zTiKyhJ+oazEG3YAAtqkvZEXWzxsv9URzOkdMre7fG/yiq5DuHRrchU2vePOxEK
         yheGc/8vxA+ueEmGqHJ2qrIN4PEiJtjW99fEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MeVXI0LQKAJ1UD0O5QDms1RNmdhs7MNItAdyoVuHKX8=;
        b=EeooBsufHPBmOxB2kqVUZuAMQSpa00MOfdJhKi9qXHQ95CJcsEi5UMQFV7HYHlLZuA
         jkwV2fw2d/aRi3UwEtmt+0ZzrFaIt2l4ttTySx2hK+UA6Aoe9Y2tbcrpQ9zPgIK21DHy
         +cFd0C6AqO6LJaaDhU1CuSBcLAOKAFOOumpXGGcr99ldcKxBlSvYubTkGQPJsx7Iq51I
         w6Zp1a98WBPAcsIIL3AzDOJn0YKTW0tk8wk9uQ4PxLgNZG15aSApb0MT0z52op98EwvK
         8tfqTfSY6RNME3mayIMmy7jO8QV0jrhvxVLiWKpjGToNIGzJDvUKzXJbL4+3W28wBr5O
         ZE3w==
X-Gm-Message-State: AJcUukdoaeuj2Hwt1Q8cENmEitFexm88sCbZ3y8vUK3gjER3Ta5nQ47b
        gOXxAYK0UgBG7lT6sjvouRfP
X-Google-Smtp-Source: ALg8bN7TbWVq2JFd+EDJ/Iq8TVTuceSN9dsXJse4qiSMZcqf0CjmgmihJcwx+fG2+a4+hf46IIksrA==
X-Received: by 2002:a62:7504:: with SMTP id q4mr15442026pfc.180.1547745278368;
        Thu, 17 Jan 2019 09:14:38 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7344:aef4:e89a:577b:dc0a:3144])
        by smtp.gmail.com with ESMTPSA id o8sm4947606pfa.42.2019.01.17.09.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 09:14:37 -0800 (PST)
Date:   Thu, 17 Jan 2019 22:44:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Guodong Xu <guodong.xu@linaro.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 5/8 v4] dma: k3dma: Add support for dma-channel-mask
Message-ID: <20190117171430.GK5283@Mani-XPS-13-9360>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-6-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547658629-25378-6-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:10:26AM -0800, John Stultz wrote:
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
> ---
>  drivers/dma/k3dma.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index b2060bf..ed19b1f 100644
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
> @@ -318,6 +319,9 @@ static void k3_dma_tasklet(unsigned long arg)
>  	/* check new channel request in d->chan_pending */
>  	spin_lock_irq(&d->lock);
>  	for (pch = 0; pch < d->dma_channels; pch++) {
> +		if (!(d->dma_channel_mask & (1<<pch)))
> +			continue;
> +

As per my comment in bindings patch, the code here gets the assumption
that we are skipping the channels which are not masked. Either the
property should be named as "dma-avail-chan" or "dma_channel_mask" should
have the bit mask of channels which needs to be masked. Then the code will
be,

/* Skip the channels which are masked */
if ((d->dma_channel_mask) & BIT(pch))
	continue;

PS: Use BIT() macro where applicable.

Thanks,
Mani

>  		p = &d->phy[pch];
>  
>  		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
> @@ -335,6 +339,9 @@ static void k3_dma_tasklet(unsigned long arg)
>  	spin_unlock_irq(&d->lock);
>  
>  	for (pch = 0; pch < d->dma_channels; pch++) {
> +		if (!(d->dma_channel_mask & (1<<pch)))
> +			continue;
> +
>  		if (pch_alloc & (1 << pch)) {
>  			p = &d->phy[pch];
>  			c = p->vchan;
> @@ -855,6 +862,13 @@ static int k3_dma_probe(struct platform_device *op)
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
> @@ -886,8 +900,12 @@ static int k3_dma_probe(struct platform_device *op)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < d->dma_channels; i++) {
> -		struct k3_dma_phy *p = &d->phy[i];
> +		struct k3_dma_phy *p;
> +
> +		if (!(d->dma_channel_mask & (1<<i)))
> +			continue;
>  
> +		p = &d->phy[i];
>  		p->idx = i;
>  		p->base = d->base + i * 0x40;
>  	}
> -- 
> 2.7.4
> 

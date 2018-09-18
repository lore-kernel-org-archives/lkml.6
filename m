Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F252150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tud0K7Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F252150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeIRVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbeIRVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:54:23 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819A52150B;
        Tue, 18 Sep 2018 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537287665;
        bh=yOng9FEcz1WWqTE/jqE7taJmULEXhXYr1TsF18QSnbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tud0K7ErDQu3NE/DhVrdXoBMFds2Y/hNMKTxx5LKxUgznkngBKGrvyCO2yt8jxzwZ
         +0NkXW+Ntf5CglIQiYbBbXu+Nq0h02DjxEeb5F04vOrKyuMKU5/sC5YnIZDpkwB7fi
         2RQsCl8cDVTnSXCbP3GhEAacsEX8pd1gqmOtGocY=
Date:   Tue, 18 Sep 2018 09:21:05 -0700
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
Message-ID: <20180918162105.GC2613@vkoul-mobl>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-2-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907062502.8241-2-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-18, 08:24, Andrea Merello wrote:
> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
> 
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW if DRE (Data Realignment Engine)
> is not enabled.
> 
> This patch eventually adjusts the transfer size in order to make sure
> all operations start from an aligned address.
> 
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
>         - don't introduce copy_mask field, rather rely on already-esistent
>           copy_align field. Suggested by Radhey Shyam Pandey
>         - reword title
> Changes in v3:
> 	- fix bug introduced in v2: wrong copy size when DRE is enabled
> 	- use implementation suggested by Radhey Shyam Pandey
> Changes in v4:
> 	- rework on the top of 1/6
> Changes in v5:
> 	- fix typo in commit title
> 	- add hint about "DRE" meaning in commit message
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a3aaa0e34cc7..aaa6de8a70e4 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
>  
>  /**
>   * xilinx_dma_calc_copysize - Calculate the amount of data to copy
> + * @chan: Driver specific DMA channel
>   * @size: Total data that needs to be copied
>   * @done: Amount of data that has been already copied
>   *
>   * Return: Amount of data that has to be copied
>   */
> -static int xilinx_dma_calc_copysize(int size, int done)
> +static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> +				    int size, int done)

align to preceeding line opening brace please

>  {
> -	return min_t(size_t, size - done,
> +	size_t copy = min_t(size_t, size - done,
>  		     XILINX_DMA_MAX_TRANS_LEN);

so we can do this way in patch 1:

        size t copy;

        copy =  min_t(size_t, size - done,
                      XILINX_DMA_MAX_TRANS_LEN);

        return copy;

and then add these here, feels like we are redoing change introduced in
patch 1..


> +	if ((copy + done < size) &&
> +	    chan->xdev->common.copy_align) {
> +		/*
> +		 * If this is not the last descriptor, make sure
> +		 * the next one will be properly aligned
> +		 */
> +		copy = rounddown(copy,
> +				 (1 << chan->xdev->common.copy_align));
> +	}
> +	return copy;
>  }
>  
>  /**
> @@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
>  			 * Calculate the maximum number of bytes to transfer,
>  			 * making sure it is less than the hw limit
>  			 */
> -			copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
> +			copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),

why not keep chan in patch 1 and add only handling in patch 2, seems
less churn to me..

-- 
~Vinod

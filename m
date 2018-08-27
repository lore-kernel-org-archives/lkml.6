Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5A0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4452172F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xj9aL/pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4452172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeH0JPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbeH0JPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:15:16 -0400
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330B42152E;
        Mon, 27 Aug 2018 05:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535347811;
        bh=A5MSYtBuzdy5qorL7ybXvkoW57RvgWAcA2ptwNQHq6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xj9aL/pYZM51340wY4NzKjAq00fSwbMVt4UZaNmptwx8ns/CtD6zS33dWvvXbH2ki
         CL5bAatcyL3g01E8tmKYZDJGK2jc1rkSjXoK7ixN1LWr18PKgTFcnnPB6hkygJFb6Y
         02b8Oz4l/jHCY9rh/vz0FB5g0N0sP82xxL7y7p10=
Date:   Mon, 27 Aug 2018 11:00:02 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
Message-ID: <20180827053002.GT2388@vkoul-mobl>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802141012.19970-2-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-18, 16:10, Andrea Merello wrote:

s/cylic/cyclic in patch title

> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
> 
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW if DRE is not enabled.

DRE?

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

please align with opening brace

>  {
> -	return min_t(size_t, size - done,
> +	size_t copy = min_t(size_t, size - done,
>  		     XILINX_DMA_MAX_TRANS_LEN);
> +
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
>  							sg_used);
>  			hw = &segment->hw;
>  
> @@ -1909,7 +1922,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
>  			 * Calculate the maximum number of bytes to transfer,
>  			 * making sure it is less than the hw limit
>  			 */
> -			copy = xilinx_dma_calc_copysize(period_len, sg_used);
> +			copy = xilinx_dma_calc_copysize(chan,
> +							period_len, sg_used);
>  			hw = &segment->hw;
>  			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>  					  period_len * i);
> -- 
> 2.17.1

-- 
~Vinod

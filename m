Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88646C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8C227B8B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXxSoFi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8C227B8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933536AbeF2H0F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbeF2H0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:26:01 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7274C27B86;
        Fri, 29 Jun 2018 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530257161;
        bh=RAf8I497MuNAjK5S3SsLUPHxaD3rEQiXacHukyS5g0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXxSoFi4R7lbSCokQQV/IFyrFaFYIWNkZiYHe4pIUQVpwHUQAfHqBIOziEXnyQ9PG
         IUPy/IfEUmokh4qLVuog2MPZefmrLj5vgD0fuW6rFhi9dOe/fZUaIFk2SPkXiH2w58
         1H8/WvtJz2GK7PR9nH62b9A2asqT5a8r+KpYClEA=
Date:   Fri, 29 Jun 2018 12:55:52 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
Message-ID: <20180629072552.GY22377@vkoul-mobl>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 11:27, Andrea Merello wrote:
> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
> 
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW if DRE is not enabled.
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
> 	  use implementation suggested by Radhey Shyam Pandey
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 27b523530c4a..113d9bf1b6a1 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1793,6 +1793,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
>  			 */
>  			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
>  				     XILINX_DMA_MAX_TRANS_LEN);
> +
> +			if ((copy + sg_used < sg_dma_len(sg)) &&
> +			    chan->xdev->common.copy_align) {
> +				/*
> +				 * If this is not the last descriptor, make sure
> +				 * the next one will be properly aligned
> +				 */
> +				copy = rounddown(copy,
> +					(1 << chan->xdev->common.copy_align));
> +			}
>  			hw = &segment->hw;
>  
>  			/* Fill in the descriptor */
> @@ -1898,6 +1908,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
>  			 */
>  			copy = min_t(size_t, period_len - sg_used,
>  				     XILINX_DMA_MAX_TRANS_LEN);
> +
> +			if ((copy + sg_used < period_len) &&
> +			    chan->xdev->common.copy_align) {
> +				/*
> +				 * If this is not the last descriptor, make sure
> +				 * the next one will be properly aligned
> +				 */
> +				copy = rounddown(copy,
> +					(1 << chan->xdev->common.copy_align));
> +			}

same code pasted twice, can we have a routine for this... perhaps more
code can be made common too

-- 
~Vinod

Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAD0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC45217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wUbqwA2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC45217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeHUTQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbeHUTQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:16:44 -0400
Received: from localhost (unknown [171.76.73.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2772177F;
        Tue, 21 Aug 2018 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534866962;
        bh=+XnoWS+i/7DP30kSw9g3zPN7sG9GhKytbJYlMGyMwwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUbqwA2yo2k5YWt4DEYXYiNPTWJOs9sZ9jHZxroOTTXv9TJvpVQF1L4L9UZp3/dBs
         DBaOvZpwwAkOh4nK+rUL5NZn5nXL84EzZRVWDk3Tt239OUzmipCioilcsry3OUzHOu
         loZtT7drHDVnz8v9Uo7q7QQ9yAvl4iRL/UdD55sc=
Date:   Tue, 21 Aug 2018 21:25:53 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Message-ID: <20180821155553.GI2388@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> In AXI CDMA simple mode also pass MSB bits of source and destination
> address to xilinx_write function. This fixes simple CDMA operation
> mode using 64-bit addressing.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a37871e..2e15d86 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
>  
>  		hw = &segment->hw;
>  
> -		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
> -		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
> +		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, (dma_addr_t)
> +			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));

so this is:
        (dma_addr_t)((u64)hw->src_addr_msb << 32 | hw->src_addr)

what is src_addr data type? I think its u32. It would be better to
update xilinx_write() to take u64 and not dma_addr_t.


> +		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, (dma_addr_t)
> +			     ((u64)hw->dest_addr_msb << 32 | hw->dest_addr));
>  
>  		/* Start the transfer */
>  		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod

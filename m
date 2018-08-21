Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639182075C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilXzcre6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639182075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHUTLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbeHUTLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:11:13 -0400
Received: from localhost (unknown [171.76.73.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3C0206B5;
        Tue, 21 Aug 2018 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534866633;
        bh=EOjNToxZqkZbpAwR9vbX1g61jKzwy/dQY+LS/orSBV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilXzcre6XGBK4oiFozVNDw7Ywoz78Yiz0Nvempxyf7rCUv3J9NAMWyW49D4g1laj3
         kpoPLHNDu6etPePRtHrGG1GBXrOJ1ryvIfqOe5NMK/pMCWoZyr6bW2LetueQe4MQrR
         eCyNGSCe6BOFIBOOSpdkhiHKIgARSTuO2MYbonJM=
Date:   Tue, 21 Aug 2018 21:20:24 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Message-ID: <20180821155024.GH2388@vkoul-mobl>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532688639-32230-3-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-18, 16:20, Radhey Shyam Pandey wrote:
> In axidma start_transfer, prefer checking channel states before
> other params i.e pending_list.

and what that preference be?

> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 06d1632..a37871e 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
>  	if (chan->err)
>  		return;
>  
> -	if (list_empty(&chan->pending_list))
> +	if (!chan->idle)
>  		return;
>  
> -	if (!chan->idle)
> +	if (list_empty(&chan->pending_list))
>  		return;
>  
>  	head_desc = list_first_entry(&chan->pending_list,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod

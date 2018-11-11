Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939CA208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1wcMipUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939CA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKKUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKUSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:18:06 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B8E20871;
        Sun, 11 Nov 2018 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541932196;
        bh=NBqqCwMWjMquFKMMuJ+1hlXoR/ikR5TgaQ3cKo6yowg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wcMipUy/EmrIMSiRuTWeGn/A1J2Ss5lzcFC3h9gPNR042c7OkB2AjndfHbLxLrGG
         eLBYyINsuTFr9pN/7QAiANttTkzGT0EmWPAhidX4Lo/Wn1Fj0KTVESp+kJ+HNhcg2+
         NTc5ZB0G/MOM93JBwbihlD2x6xgM1a2gM3v2x+sI=
Date:   Sun, 11 Nov 2018 15:59:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Message-ID: <20181111102947.GG12092@vkoul-mobl>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-18, 11:17, Radhey Shyam Pandey wrote:
> In axidma start_transfer, prefer checking channel states before
> other params i.e pending_list. No functional change.

There needs to be proper reason rather than a preference, can you
explain why

> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes for v2:
> Modified the commit message to mark it as non-functional change.
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

-- 
~Vinod

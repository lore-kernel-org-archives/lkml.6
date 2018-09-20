Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A783C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D391520685
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5QlHTEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D391520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeITGTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeITGTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:19:23 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345B520685;
        Thu, 20 Sep 2018 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537403932;
        bh=/nYVZ62iNxnjeaeqCuitPqYkJGDcuBatV+MlH+Ci7sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5QlHTEajVsVmlVvopedu1bAk8JXPcPKUJh6JIHC8bIoPv9wGvmj3a8OdtCufDcFs
         4LqJwhpBI0tONhyqWRDG1WBQZukDYQoxPOyVfN8GGhROXwv/Bto4DdPWckjvyb93gi
         0XSPTKfRtgDljCAofePYaC0eGPUfmV1F5g4InT4I=
Date:   Wed, 19 Sep 2018 17:38:51 -0700
From:   Vinod <vkoul@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 4.9 30/34] dmaengine: hsu: Support
 dmaengine_terminate_sync()
Message-ID: <20180920003851.GA2350@vkoul-mobl>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
 <20180915013422.180023-30-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915013422.180023-30-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-18, 01:34, Sasha Levin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [ Upstream commit 2abc66cd499aa16876e45c6438788902f7d1ce22 ]
> 
> It appears that the driver misses the support of dmaengine_terminate_sync().
> Since many of callers expects this behaviour implement the new
> device_synchronize() callback to allow proper synchronization when stopping
> a channel.

This adds missing support for an optional call, but I am not aware of
any reports of breakage due to missing this patch. Do you want to carry
this for stable?

> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/dma/hsu/hsu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
> index 29d04ca71d52..202ffa9f7611 100644
> --- a/drivers/dma/hsu/hsu.c
> +++ b/drivers/dma/hsu/hsu.c
> @@ -413,6 +413,13 @@ static void hsu_dma_free_chan_resources(struct dma_chan *chan)
>  	vchan_free_chan_resources(to_virt_chan(chan));
>  }
>  
> +static void hsu_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct hsu_dma_chan *hsuc = to_hsu_dma_chan(chan);
> +
> +	vchan_synchronize(&hsuc->vchan);
> +}
> +
>  int hsu_dma_probe(struct hsu_dma_chip *chip)
>  {
>  	struct hsu_dma *hsu;
> @@ -459,6 +466,7 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
>  	hsu->dma.device_pause = hsu_dma_pause;
>  	hsu->dma.device_resume = hsu_dma_resume;
>  	hsu->dma.device_terminate_all = hsu_dma_terminate_all;
> +	hsu->dma.device_synchronize = hsu_dma_synchronize;
>  
>  	hsu->dma.src_addr_widths = HSU_DMA_BUSWIDTHS;
>  	hsu->dma.dst_addr_widths = HSU_DMA_BUSWIDTHS;
> -- 
> 2.17.1

-- 
~Vinod

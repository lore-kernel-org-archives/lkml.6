Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A807C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053A320685
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEOmDNPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053A320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeITGUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeITGUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:20:32 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529B920685;
        Thu, 20 Sep 2018 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537404001;
        bh=YVDjMTortd8ZJT9/VgUxteXE6UxOERKlOPYXKtMRkYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEOmDNPp6k9EPa+sy058iw/q4G4O3ZVnMxt9AGEM4q3yrYvSoyujHPumx93hXZoS9
         /b17eEdzNohD7Xg3J0bCmDuBWLTVY1wJMjepp8ctvaSXMZSaqxOf6Hx4JiBr1MIGgB
         BKnBF8knxKCCdLOorpjsvuTUT/CS80CqtE3B764E=
Date:   Wed, 19 Sep 2018 17:40:01 -0700
From:   Vinod <vkoul@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 4.9 31/34] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Message-ID: <20180920004001.GB2350@vkoul-mobl>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
 <20180915013422.180023-31-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915013422.180023-31-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-09-18, 01:34, Sasha Levin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [ Upstream commit bbacb8e78a3b29ebdbb6af7d54fcf25d3f1c248f ]
> 
> It appears that the driver misses the support of dmaengine_terminate_sync().
> Since many of callers expects this behaviour implement the new
> device_synchronize() callback to allow proper synchronization when stopping
> a channel.

Same for this patch as well. Adding optional call should not be stable
material

> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/dma/idma64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
> index 1953e57505f4..2ee93cf98f00 100644
> --- a/drivers/dma/idma64.c
> +++ b/drivers/dma/idma64.c
> @@ -496,6 +496,13 @@ static int idma64_terminate_all(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static void idma64_synchronize(struct dma_chan *chan)
> +{
> +	struct idma64_chan *idma64c = to_idma64_chan(chan);
> +
> +	vchan_synchronize(&idma64c->vchan);
> +}
> +
>  static int idma64_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct idma64_chan *idma64c = to_idma64_chan(chan);
> @@ -583,6 +590,7 @@ static int idma64_probe(struct idma64_chip *chip)
>  	idma64->dma.device_pause = idma64_pause;
>  	idma64->dma.device_resume = idma64_resume;
>  	idma64->dma.device_terminate_all = idma64_terminate_all;
> +	idma64->dma.device_synchronize = idma64_synchronize;
>  
>  	idma64->dma.src_addr_widths = IDMA64_BUSWIDTHS;
>  	idma64->dma.dst_addr_widths = IDMA64_BUSWIDTHS;
> -- 
> 2.17.1

-- 
~Vinod

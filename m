Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F21C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E85524BF0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJscNRgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E85524BF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeFWMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeFWMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:30:48 -0400
Received: from localhost (unknown [122.178.210.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9B324BEA;
        Sat, 23 Jun 2018 12:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529757048;
        bh=9aqOlUUN+N1JLn+FRzdn1bu+EJCRCNPq4raGuCInXe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJscNRgKkbDElqdY95HJIaBGCNv9C2LnkQgcdeu8bKJEMAviWrauN7r+ss6yok5GV
         T2mreZ3YHHGrxZNcOZm8OqpcHwpD9ayFgGbD7xd0ttLOzgspcrIkJpAL6AjtHGrXDR
         8MR1KNpwziLxVrG7Un95zK4Pgwc7vCOUtoBY0S6o=
Date:   Sat, 23 Jun 2018 18:00:39 +0530
From:   Vinod <vkoul@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 16/26] dmaengine: Convert to new IDA API
Message-ID: <20180623123039.GX27187@vkoul-mobl>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621212835.5636-17-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-18, 14:28, Matthew Wilcox wrote:
> Simpler and shorter code.

I couldn't find ida_alloc/ida_free in 4.18-rc1 so I assume this will go
thru tree adding this so:

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/dma/dmaengine.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 08ba8473a284..1e9bdadfc312 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -161,9 +161,7 @@ static void chan_dev_release(struct device *dev)
>  
>  	chan_dev = container_of(dev, typeof(*chan_dev), device);
>  	if (atomic_dec_and_test(chan_dev->idr_ref)) {
> -		mutex_lock(&dma_list_mutex);
> -		ida_remove(&dma_ida, chan_dev->dev_id);
> -		mutex_unlock(&dma_list_mutex);
> +		ida_free(&dma_ida, chan_dev->dev_id);
>  		kfree(chan_dev->idr_ref);
>  	}
>  	kfree(chan_dev);
> @@ -896,16 +894,10 @@ static bool device_has_all_tx_types(struct dma_device *device)
>  
>  static int get_dma_id(struct dma_device *device)
>  {
> -	int rc;
> -
> -	do {
> -		if (!ida_pre_get(&dma_ida, GFP_KERNEL))
> -			return -ENOMEM;
> -		mutex_lock(&dma_list_mutex);
> -		rc = ida_get_new(&dma_ida, &device->dev_id);
> -		mutex_unlock(&dma_list_mutex);
> -	} while (rc == -EAGAIN);
> +	int rc = ida_alloc(&dma_ida, GFP_KERNEL);
>  
> +	if (rc >= 0)
> +		device->dev_id = rc;
>  	return rc;
>  }
>  
> @@ -1090,9 +1082,7 @@ int dma_async_device_register(struct dma_device *device)
>  err_out:
>  	/* if we never registered a channel just release the idr */
>  	if (atomic_read(idr_ref) == 0) {
> -		mutex_lock(&dma_list_mutex);
> -		ida_remove(&dma_ida, device->dev_id);
> -		mutex_unlock(&dma_list_mutex);
> +		ida_free(&dma_ida, device->dev_id);
>  		kfree(idr_ref);
>  		return rc;
>  	}
> -- 
> 2.17.1

-- 
~Vinod

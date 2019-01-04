Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC37BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28020874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546613570;
	bh=oxnPiKqNrGpgXVuQ/xVm7GV2F9pdvUbv6H5DBd+XypA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7yNe7Js/hsoXqZfjfDSeTVIghnGmLYOVUWZ42tWT+GHoIxQtHW6gbdvv+T/gf2jY
	 06n0LJWWV8EDyuHqHBbojDNXGXe9mOeWLiejA498QFVwHDuoAEZUdFQjydaiXsD7iC
	 Lt9vJGd7BZAWZm5M/YcARHrXISgj5LIAuN6xCCY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfADOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADOwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:52:49 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCA120874;
        Fri,  4 Jan 2019 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546613568;
        bh=oxnPiKqNrGpgXVuQ/xVm7GV2F9pdvUbv6H5DBd+XypA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2VCzf+6Igjar4jGUuYHm515CUEqQSszV7ZtPXHAuAFIvvPOkfIrTLmwb31ltGPdbz
         FkalKEIGtSPQ1qMoSpT3mKM0EPL/QBRfkU6BQ0ybRQ7cLDVVNqKZ/OvKPiLtz2tl2Y
         lT3ZxGYTSV7kvWWEbmXfDalnYhkU2p/phYXoatXE=
Date:   Fri, 4 Jan 2019 20:21:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH] dmaengine: fix dmaengine_desc_callback_valid() doesn't
 check for callback_result
Message-ID: <20190104145110.GF13372@vkoul-mobl.Dlink>
References: <20181116135628.19388-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116135628.19388-1-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-18, 14:56, Andrea Merello wrote:
> There are two flavors of DMA completion callbacks: callback() and
> callback_result(); the latter takes an additional parameter that carries
> result information.
> 
> Most dmaengine helper functions that work with callbacks take care of both
> flavors i.e. dmaengine_desc_get_callback_invoke() first checks for
> callback_result() to be not NULL, and eventually it calls this one;
> otherwise it goes on checking for callback().
> 
> It seems however that dmaengine_desc_callback_valid() does not care about
> callback_result(), and it returns false in case callback() is NULL but
> callback_result() is not; unless there is a (hidden to me) reason for doing
> so then I'd say this is wrong.
> 
> I've hit this by using a DMA controller driver (xilinx_dma) that doesn't
> trigger any callback invocation unless dmaengine_desc_callback_valid()
> returns true, while I had only callback_result() implemented in my client
> driver (which AFAICT is always fine since dmaengine documentation says that
> callback() will be deprecated).
> 
> This patch fixes this by making dmaengine_desc_callback_valid() to return
> true in the said scenario.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/dma/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 501c0b063f85..0ba2c1f3c55d 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -168,7 +168,7 @@ dmaengine_desc_get_callback_invoke(struct dma_async_tx_descriptor *tx,
>  static inline bool
>  dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>  {
> -	return (cb->callback) ? true : false;
> +	return (cb->callback || cb->callback_result);

So I do not think this one should take care of callback_result, it is
supposed to check if the callback is valid or not.. Nothing more.

Ofcourse usage of this maybe incorrect which should be fixed. We do have
dmaengine_desc_callback_invoke() which propagates the callback_result to
user

-- 
~Vinod

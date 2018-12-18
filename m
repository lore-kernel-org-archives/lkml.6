Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626692184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545131514;
	bh=xU+tvzQlXqSCsQ2lxQTIc4gTZWJ+tfh7mNnYBB0EEPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zr25y2mk0gI3FmM3RcKOSQHGEbeiWMbaB8x/P7RQ2FHS3iGl8h9A0WbXG8aYHaKen
	 pTv6n7qSHFFOi/5DrKmduyAoJI8hmh2ERtmgfd7g2zZkSKRc3xMIq3PPBYL0FyKgHg
	 x0+wVSy8zvOR88WCxs1dzVnc0PdO+ZcRzqNLIM+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLRLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbeLRLLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:11:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894652184C;
        Tue, 18 Dec 2018 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545131512;
        bh=xU+tvzQlXqSCsQ2lxQTIc4gTZWJ+tfh7mNnYBB0EEPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwLW9/TR+UsczpbCs2Lfubp5yymukaxGjlRByNvSvMQvt18+e9tmoeBhpejRQObuJ
         wC+vFoCl+Tofs0HkilJc1cEaMUcY79aBhZlXytis4nLt9oQGJAp/Ko7aNYxsER3IAQ
         Vc1tGda53CvWhfLb1SNq9ZV7RSa5QAMLZLC+E00U=
Date:   Tue, 18 Dec 2018 12:11:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8a66597: Fix a possible concurrency use-after-free bug
 in r8a66597_endpoint_disable()
Message-ID: <20181218111149.GA979@kroah.com>
References: <20181218100020.26250-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218100020.26250-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:00:20PM +0800, Jia-Ju Bai wrote:
> The function r8a66597_endpoint_disable() and r8a66597_urb_enqueue() may
> be concurrently executed.
> The two functions both access a possible shared variable "hep->hcpriv".
> 
> This shared variable is freed by r8a66597_endpoint_disable() via the
> call path:
> r8a66597_endpoint_disable
>   kfree(hep->hcpriv) (line 1995 in Linux-4.19)
> 
> This variable is read by r8a66597_urb_enqueue() via the call path:
> r8a66597_urb_enqueue
>   spin_lock_irqsave(&r8a66597->lock);
>   init_pipe_info
>     enable_r8a66597_pipe
>       pipe = hep->hcpriv (line 802 in Linux-4.19)
> 
> The read operation is protected by a spinlock, but the free operation
> is not protected by this spinlock, thus a concurrency use-after-free bug
> may occur.
> 
> To fix this bug, the spin-lock and spin-unlock function calls in
> r8a66597_endpoint_disable() are moved to protect the free operation.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/usb/host/r8a66597-hcd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
> index 984892dd72f5..1495ce14ad22 100644
> --- a/drivers/usb/host/r8a66597-hcd.c
> +++ b/drivers/usb/host/r8a66597-hcd.c
> @@ -1991,13 +1991,14 @@ static void r8a66597_endpoint_disable(struct usb_hcd *hcd,
>  		return;
>  	pipenum = pipe->info.pipenum;
>  
> +	spin_lock_irqsave(&r8a66597->lock, flags);

Don't you also need the __aquires/__releases markings on this function
in order to properly annotate it, like the rest of the driver has?

Otherwise this seems to look good to me.

thanks,

greg k-h

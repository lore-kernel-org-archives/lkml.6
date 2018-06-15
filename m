Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 803EEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3300520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyPg5KzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3300520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeFOLPv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965626AbeFOLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:15:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213E220896;
        Fri, 15 Jun 2018 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529061349;
        bh=iO6Irxy+rg6mbpYVqCRZphfkidJ8SB5KGXfW3ozZ53c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyPg5KzZK+j0Ntz6m7LvJhIGtbJHIbLVA0E7/7sC8i1zvzwdf0uskaO/VkGEGTfP7
         heuYQgvkWF8PTXQJkPhr6pSKbu3I/GVfJCE7Un+aHhKyMRDYHhHK723LawYtfjZuYa
         Pg4I9LMiu9OBsL6bLb08IrjiARxrDhxtNwWU/NFc=
Date:   Fri, 15 Jun 2018 13:15:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: rtl8192u: add error handling for usb_alloc_urb
Message-ID: <20180615111525.GA27391@kroah.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 04:31:11PM +0800, Zhouyang Jia wrote:
> When usb_alloc_urb fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling usb_alloc_urb.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 7a0dbc0..3f09615 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1666,6 +1666,9 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>  		void *oldaddr, *newaddr;
>  
>  		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!priv->rx_urb[16])
> +			return -ENOMEM;
> +

You just leaked memory :(

Well, this whole function leaks memory on the error paths, like here:

>  		priv->oldaddr = kmalloc(16, GFP_KERNEL);
>  		if (!priv->oldaddr)
>  			return -ENOMEM;

So can you fix this all up at the same time?

thanks,

greg k-h

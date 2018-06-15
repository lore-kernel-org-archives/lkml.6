Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9649C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800DB208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+E1oAQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800DB208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966284AbeFOQdt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966002AbeFOQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:33:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E95208DD;
        Fri, 15 Jun 2018 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529080424;
        bh=N6xGEAGYdbla8PO3b/ClP4PjWf1gpuvNP/GuC+1J9k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+E1oAQypF6r8GD4Jfmk/Eb4cF5immFBzuJ/NXOWg404X9rjewV5hlThEJigdk9q4
         3UYU+4q1o6SHbV5Nciuv9m7xTkwyTt0B++CA7MbiGbf9BePhVh8ArGs5qNsodzWIuW
         bnoB95fnuQPizY2ME7t3zYKOalkQDu9oK7I9CMCw=
Date:   Fri, 15 Jun 2018 18:33:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] staging: rtl8192u: add error handling for
 usb_alloc_urb
Message-ID: <20180615163322.GB11493@kroah.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
 <1529079930-58587-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529079930-58587-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 12:25:23AM +0800, Zhouyang Jia wrote:
> When usb_alloc_urb fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling usb_alloc_urb.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Fix memory leak.
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 7a0dbc0..6afab4e 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1648,13 +1648,17 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>  #ifndef JACKSON_NEW_RX
>  	for (i = 0; i < (MAX_RX_URB + 1); i++) {
>  		priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
> -		if (!priv->rx_urb[i])
> +		if (!priv->rx_urb[i]) {
> +			kfree(priv->rx_urb);
>  			return -ENOMEM;
> +		}

{sigh}

No, you are still leaking memory on all of these changes that you just
made :(

greg k-h

Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861B6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D18B21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JWW11Ifg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D18B21A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeHGA6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:58:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47046 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbeHGA6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:58:49 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2BCD57;
        Tue,  7 Aug 2018 00:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533595652;
        bh=mzO5FIO7/qrqNNjtv2QENZOGvTEdfX+zDab3opXH/FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWW11IfgkN0/L3IGFtytnodp7/yDky08IWvvPASmBEYvoZ+yCAkpJm+2yY4lC+dA0
         Vp7KlQl/mtpIGc8xqRlN+whn1Qp5SiHD/jniFxAGELE7045N0rM2pY/mOOTSDkHcL8
         LGWArMAqFIHVZhqXirnj6uagQiP3/ZBCyUTTG0DA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: uvc_debugfs: remove unnecessary NULL check before debugfs_remove_recursive
Date:   Tue, 07 Aug 2018 01:48:15 +0300
Message-ID: <1774555.GGbckhaAKE@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20171112081859.GA19079@embeddedor.com>
References: <20171112081859.GA19079@embeddedor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Thank you for the patch.

On Sunday, 12 November 2017 10:18:59 EEST Gustavo A. R. Silva wrote:
> NULL check before freeing functions like debugfs_remove_recursive
> is not needed.

"functions like debugfs_remove_recursive" seems a bit vague to me. I'd prefer 
being more precise here, and say that "debugfs_remove_recursive() accepts a 
NULL parameter and returns immediately, there's no need for a NULL check in 
the caller.".

> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/media/usb/uvc/uvc_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_debugfs.c
> b/drivers/media/usb/uvc/uvc_debugfs.c index 368f8f8..6995aeb 100644
> --- a/drivers/media/usb/uvc/uvc_debugfs.c
> +++ b/drivers/media/usb/uvc/uvc_debugfs.c
> @@ -128,6 +128,5 @@ void uvc_debugfs_init(void)
> 
>  void uvc_debugfs_cleanup(void)
>  {
> -	if (uvc_debugfs_root_dir != NULL)
> -		debugfs_remove_recursive(uvc_debugfs_root_dir);
> +	debugfs_remove_recursive(uvc_debugfs_root_dir);
>  }

There's another occurrence in uvc_debugfs_cleanup_stream(). I'll address it as 
well in this patch. With that change and the commit message update,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

-- 
Regards,

Laurent Pinchart




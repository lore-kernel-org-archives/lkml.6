Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1089FC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACDA20823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547885838;
	bh=a1Cjs9QXsQ97+0qrEt48189BBYdc3YG46UaRW7LJSbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7f1AVkQZSVz1zKiA7mwLW/+p4UQdwg8kBmjwnHXWtj0yZvu4SNp8gOLGukeilsBf
	 6hQTgdRdF/8xaAXJwgyCrFEFrnsDL5x+mblAaxhFmXpisKLxIQm+X88WIbhuhxwDlj
	 dSDd44Im/JLwS3A+TOjKb3hFjR21BXHahyPr34Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfASIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:17:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfASIRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:17:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C60D20823;
        Sat, 19 Jan 2019 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547885831;
        bh=a1Cjs9QXsQ97+0qrEt48189BBYdc3YG46UaRW7LJSbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrzF8CJ5IXGkvTOJkmzelt/FfmijsZ5fG3G0RS8lvjCvjdukZClQiH8nECMy+TZFE
         ET0gL9JLJlqvNAlf/x3SszWIG3uU8RveSBtVdJK4vfwfu/BVqFR3GZx1f31haX/FoO
         OweUB4OkbNjryZn3LOYAkBQw2p46vhVYuhQk2eAA=
Date:   Sat, 19 Jan 2019 09:17:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Fix vep_free_request() null pointer checks on
 input args
Message-ID: <20190119081708.GA8204@kroah.com>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118212931.18482-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:29:30PM -0700, Shuah Khan wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Fix vep_free_request() to return when usb_ep and usb_request are null
> instead of calling WARN_ON.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/usb/usbip/vudc_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
> index 1634d8698e15..bfc8218e3fb6 100644
> --- a/drivers/usb/usbip/vudc_dev.c
> +++ b/drivers/usb/usbip/vudc_dev.c
> @@ -297,7 +297,7 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct vrequest *req;
>  
> -	if (WARN_ON(!_ep || !_req))
> +	if (!_ep || !_req)

It's impossible for _ep to be NULL in this callback (see
usb_ep_free_request() for where this is called from to prove that), so I
don't think you need to check that.  It's almost impossible for _req to
be NULL, so you might as well leave that check in.

thanks,

greg k-h

Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F721736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550581914;
	bh=lXVCmN2ztOk0HPljGU2O44JNJFzh1vDkU80EQs1kgOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IupmGBLFjor+6ykREIJwd/ThMD+j2AC314YgNh+iy5ml0ojue6IbFeU93TTZW5ejW
	 B4tWboryk/b8TryFtt3hbDu2iiy6Pm3u2P4vHzlG3jUn1hXoJjnURWoALtYEXhriJ9
	 2jT+Lwf6A+ELH9g2xHQe2Oom1aak6ZQfydAg328Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfBSNLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBSNLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:11:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C592147A;
        Tue, 19 Feb 2019 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550581912;
        bh=lXVCmN2ztOk0HPljGU2O44JNJFzh1vDkU80EQs1kgOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aS2wv6vW60Az/2YgCXFcxD7tohMDhV7lKXN3/hR3c3hwiLHQafJxTMhvvCIPpxNkk
         IN/efaKiqSpnow8UJwCA0fYgdBym8h5fcziGYEyjXc3H4MCSykYrKKScBXoSGklSim
         qkN1pt6JMfPmgpSYaojyGSx/DnqYo/eQFkwBuuSM=
Date:   Tue, 19 Feb 2019 14:11:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: skip interfaces disabled in devicetree
Message-ID: <20190219131149.GA20719@kroah.com>
References: <20190216170452.10884-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216170452.10884-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 05:04:52PM +0000, Mans Rullgard wrote:
> If an interface has an associated devicetree node with status disabled,
> do not register the device.  This is useful for boards with a built-in
> multifunction USB device where some functions are broken or otherwise
> undesired.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/usb/core/message.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index bfa5eda0cc26..6b45d4835e41 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2007,6 +2007,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  	for (i = 0; i < nintf; ++i) {
>  		struct usb_interface *intf = cp->interface[i];
>  
> +		if (intf->dev.of_node &&
> +		    !of_device_is_available(intf->dev.of_node))
> +			continue;

Shouldn't you at least print some message out saying you are skipping
this?  Odds are this is going to cause regressions in devices that were
not expecting this, right?  So pointing them at why their devices now no
longer work would be good :)

thanks,

greg k-h

Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04042173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04042173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kiener-muenchen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbeI1PJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:09:50 -0400
Received: from mr08.mx01.tldhost.de ([84.19.26.246]:36444 "EHLO
        mr08.mx01.tldhost.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1PJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:09:50 -0400
X-Greylist: delayed 2344 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 11:09:49 EDT
Received: from mx01.tldhost.de (localhost [127.0.0.1])
        by mx01.tldhost.de (Postfix) with ESMTP id 3B129120FD6;
        Fri, 28 Sep 2018 10:08:12 +0200 (CEST)
Received: by mx01.tldhost.de (Postfix, from userid 1001)
        id 29DD4120FB8; Fri, 28 Sep 2018 10:08:12 +0200 (CEST)
Received: from server12.tldhost.de (server12.tldhost.de [84.19.26.112])
        by mx01.tldhost.de (Postfix) with ESMTPS id 20C73120FAA;
        Fri, 28 Sep 2018 10:08:10 +0200 (CEST)
Received: from fw-emea.rohde-schwarz.com (fw-emea.rohde-schwarz.com
 [80.246.32.33]) by webmail.kiener-muenchen.de (Horde Framework) with HTTP;
 Fri, 28 Sep 2018 08:08:10 +0000
Date:   Fri, 28 Sep 2018 08:08:10 +0000
Message-ID: <20180928080810.Horde.QIGMZmp54QWS1jzs1zoa7_a@webmail.kiener-muenchen.de>
From:   guido@kiener-muenchen.de
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Bayless <steve_bayless@keysight.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usbtmc: check size before allocating buffer and
 remove duplicated allocation
In-Reply-To: <20180927222332.13360-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-PPP-Message-ID: <20180928080810.29685.50607@server12.tldhost.de>
X-PPP-Vhost: kiener-muenchen.de
X-POWERED-BY: TLDHost.de - AV:CLEAN SPAM:OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zitat von Colin King <colin.king@canonical.com>:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the allocation of a buffer is performed before a sanity check on
> the required buffer size and if the buffer size is too large the error exit
> return leaks the allocated buffer.  Fix this by checking the size before
> allocating.
>
> Also, the same buffer is allocated again inside an if statement, causing
> the first allocation to be leaked.  Fix this by removing this second
> redundant allocation.
>
> Detected by CoverityScan, CID#1473697 ("Resource leak")
>
> Fixes: 658f24f4523e ("usb: usbtmc: Add ioctl for generic requests on  
> control")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/class/usbtmc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 0fcb81a1399b..c01edff190d2 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -1895,18 +1895,14 @@ static int usbtmc_ioctl_request(struct  
> usbtmc_device_data *data,
>  	if (res)
>  		return -EFAULT;
>
> +	if (request.req.wLength > USBTMC_BUFSIZE)
> +		return -EMSGSIZE;
> +
>  	buffer = kmalloc(request.req.wLength, GFP_KERNEL);
>  	if (!buffer)
>  		return -ENOMEM;
>
> -	if (request.req.wLength > USBTMC_BUFSIZE)
> -		return -EMSGSIZE;
> -
>  	if (request.req.wLength) {
> -		buffer = kmalloc(request.req.wLength, GFP_KERNEL);
> -		if (!buffer)
> -			return -ENOMEM;
> -
>  		if ((request.req.bRequestType & USB_DIR_IN) == 0) {
>  			/* Send control data to device */
>  			res = copy_from_user(buffer, request.data,
> --
> 2.17.1

Good to know that there are some tools finding this memory leak.
I have already sent a patch series here:
https://patchwork.kernel.org/cover/10612963/
This includes a similar patch to your proposal:
https://patchwork.kernel.org/patch/10612965/

Thank you!

Regards,

Guido



Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF601C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930FC223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930FC223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeKMASI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:18:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbeKMASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:18:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2909885A07;
        Mon, 12 Nov 2018 14:24:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C1B25D6AA;
        Mon, 12 Nov 2018 14:24:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wACEObYL005700;
        Mon, 12 Nov 2018 09:24:37 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wACEOZCt005696;
        Mon, 12 Nov 2018 09:24:35 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 12 Nov 2018 09:24:35 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
cc:     Bernie Thompson <bernie@plugable.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] udlfb: fix NULL pointer dereference in
 dlfb_usb_probe()
In-Reply-To: <1541795110-3179-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <alpine.LRH.2.02.1811120923520.3272@file01.intranet.prod.int.rdu2.redhat.com>
References: <1541795110-3179-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 12 Nov 2018 14:24:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Nov 2018, Alexey Khoroshilov wrote:

> If memory allocation for dlfb fails, error handling code
> unconditionally dereference NULL pointer.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 68a958a915ca ("udlfb: handle unplug properly")

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/video/fbdev/udlfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index 070026a7e55a..9643fe7c8349 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1590,7 +1590,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
>  	int i;
>  	const struct device_attribute *attr;
>  	struct dlfb_data *dlfb;
> -	struct fb_info *info;
> +	struct fb_info *info = NULL;
>  	int retval = -ENOMEM;
>  	struct usb_device *usbdev = interface_to_usbdev(intf);
>  
> @@ -1701,8 +1701,8 @@ static int dlfb_usb_probe(struct usb_interface *intf,
>  	return 0;
>  
>  error:
> -	if (dlfb->info) {
> -		dlfb_ops_destroy(dlfb->info);
> +	if (info) {
> +		dlfb_ops_destroy(info);
>  	} else if (dlfb) {
>  		usb_put_dev(dlfb->udev);
>  		kfree(dlfb);
> -- 
> 2.7.4
> 

Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB741C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2DB21748
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2DB21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeHMB0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:26:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38673 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727774AbeHMB0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:26:05 -0400
Received: (qmail 23350 invoked by uid 500); 12 Aug 2018 18:46:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2018 18:46:34 -0400
Date:   Sun, 12 Aug 2018 18:46:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Tom Todd <thomas.m.a.todd@gmail.com>
cc:     gregkh@linuxfoundation.org, <joe@perches.com>,
        <dan.carpenter@oracle.com>, <arvind.yadav.cs@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: core: devio: Restructured proc_ioctl for
 readability
In-Reply-To: <20180812222653.3341-1-thomas.m.a.todd@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1808121838570.23021-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2018, Tom Todd wrote:

> On, Sun, 12 Aug 2018 11:34:59 -0700 Joe Perches wrote:
> >On Sun, 2018-08-12 at 19:06 +0100, Tom Todd wrote:
> >> Fixed a code styling issue
> >while it's OK to fix style only issues, it's much better
> >to reorganize the code for reader clarity.
> 
> Ok, thank you, I've taken your suggestions and created the a new version
> 
> Restructured method proc_ioctl for readability and fixed code style
> errors.
> 
> Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>

"Style fixes" that introduce bugs are quite annoying...

> ---
>  drivers/usb/core/devio.c | 67 ++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 476dcc5f2da3..740e60e086e2 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -2117,46 +2117,52 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
>  	/* alloc buffer */
>  	size = _IOC_SIZE(ctl->ioctl_code);
>  	if (size > 0) {
> -		buf = kmalloc(size, GFP_KERNEL);
> -		if (buf == NULL)
> -			return -ENOMEM;
> -		if ((_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE)) {
> -			if (copy_from_user(buf, ctl->data, size)) {
> -				kfree(buf);
> +		if (_IOC_DIR(ctl->ioctl_code) & _IOC_WRITE) {
> +			buf = memdup_user(ctl->data, size);
> +			if (!buf)
>  				return -EFAULT;
> -			}
>  		} else {
> -			memset(buf, 0, size);
> +			buf = kmalloc(size, GFP_KERNEL);
> +			if (!buf)
> +				return -ENOMEM;

Where do the contents of buf get set to 0 now?

>  		}
>  	}
>  
>  	if (!connected(ps)) {
> -		kfree(buf);
> -		return -ENODEV;
> +		retval = -ENODEV;
> +		goto exit;
>  	}
>  
> -	if (ps->dev->state != USB_STATE_CONFIGURED)
> +	if (ps->dev->state != USB_STATE_CONFIGURED) {
>  		retval = -EHOSTUNREACH;
> -	else if (!(intf = usb_ifnum_to_if(ps->dev, ctl->ifno)))
> +		goto exit;
> +	}
> +
> +	intf = usb_ifnum_to_if(ps->dev, ctl->ifno);
> +	if (!intf) {
>  		retval = -EINVAL;
> -	else switch (ctl->ioctl_code) {
> +		goto exit;
> +	}
>  
> +	switch (ctl->ioctl_code) {
>  	/* disconnect kernel driver from interface */
>  	case USBDEVFS_DISCONNECT:
> -		if (intf->dev.driver) {
> -			driver = to_usb_driver(intf->dev.driver);
> -			dev_dbg(&intf->dev, "disconnect by usbfs\n");
> -			usb_driver_release_interface(driver, intf);
> -		} else
> +		if (!intf->dev.driver) {
>  			retval = -ENODATA;
> +			goto exit;
> +		}
> +		driver = to_usb_driver(intf->dev.driver);
> +		dev_dbg(&intf->dev, "disconnect by usbfs\n");
> +		usb_driver_release_interface(driver, intf);
>  		break;
>  
>  	/* let kernel drivers try to (re)bind to the interface */
>  	case USBDEVFS_CONNECT:
> -		if (!intf->dev.driver)
> -			retval = device_attach(&intf->dev);
> -		else
> +		if (!intf->dev.driver) {

Now !intf->dev.driver generates an error instead of working?

>  			retval = -EBUSY;
> +			goto exit;
> +		}
> +		retval = device_attach(&intf->dev);
>  		break;
>  
>  	/* talk directly to the interface's driver */
> @@ -2165,20 +2171,21 @@ static int proc_ioctl(struct usb_dev_state *ps, struct usbdevfs_ioctl *ctl)
>  			driver = to_usb_driver(intf->dev.driver);
>  		if (driver == NULL || driver->unlocked_ioctl == NULL) {
>  			retval = -ENOTTY;
> -		} else {
> -			retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
> -			if (retval == -ENOIOCTLCMD)
> -				retval = -ENOTTY;
> +			goto exit;
>  		}
> +		retval = driver->unlocked_ioctl(intf, ctl->ioctl_code, buf);
> +		if (retval == -ENOIOCTLCMD) {
> +			retval = -ENOTTY;
> +			goto exit;
> +		}
> +		break;
>  	}
>  
>  	/* cleanup and return */
> -	if (retval >= 0
> -			&& (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0
> -			&& size > 0
> -			&& copy_to_user(ctl->data, buf, size) != 0)
> +	if (retval >= 0 && (_IOC_DIR(ctl->ioctl_code) & _IOC_READ) != 0 &&
> +		size > 0 && copy_to_user(ctl->data, buf, size) != 0)
>  		retval = -EFAULT;

Isn't the style in this file to indent continuation lines by two tab
stops?

> -
> +exit:
>  	kfree(buf);
>  	return retval;
>  }

Alan Stern


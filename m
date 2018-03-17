Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeCQSKw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:10:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39574 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbeCQSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:10:47 -0400
X-Google-Smtp-Source: AG47ELvMW1SoG9wy7vLwhJk/ar0wkBq1pAReW1vBTl2fWpjmIkucEIGoqzuYPrKAtJSkvlQV7kceCA==
Date: Sat, 17 Mar 2018 11:10:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/6] input: synaptics_usb: fix deadlock in
 autosuspend
Message-ID: <20180317181044.GB188654@dtor-ws>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
 <20180228133803.30040-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228133803.30040-2-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:37:58PM +0100, Marcus Folkesson wrote:
> usb_autopm_get_interface() that is called in synusb_open() does an
> autoresume if the device is suspended.
> 
> input_dev->mutex used in synusb_resume() is in this case already
> taken by the input subsystem and will cause a deadlock.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics_usb.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index cb7d15d826d0..2c66913cf5a2 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -82,6 +82,9 @@ struct synusb {
>  	struct urb *urb;
>  	unsigned char *data;
>  
> +	/* serialize access to open/suspend */
> +	struct mutex pm_mutex;
> +
>  	/* input device related data structures */
>  	struct input_dev *input;
>  	char name[128];
> @@ -252,6 +255,7 @@ static int synusb_open(struct input_dev *dev)
>  		return retval;
>  	}
>  
> +	mutex_lock(&synusb->pm_mutex);
>  	retval = usb_submit_urb(synusb->urb, GFP_KERNEL);
>  	if (retval) {
>  		dev_err(&synusb->intf->dev,
> @@ -264,6 +268,7 @@ static int synusb_open(struct input_dev *dev)
>  	synusb->intf->needs_remote_wakeup = 1;
>  
>  out:
> +	mutex_unlock(&synusb->pm_mutex);
>  	usb_autopm_put_interface(synusb->intf);
>  	return retval;
>  }
> @@ -275,8 +280,10 @@ static void synusb_close(struct input_dev *dev)
>  
>  	autopm_error = usb_autopm_get_interface(synusb->intf);
>  
> +	mutex_lock(&synusb->pm_mutex);
>  	usb_kill_urb(synusb->urb);
>  	synusb->intf->needs_remote_wakeup = 0;
> +	mutex_unlock(&synusb->pm_mutex);
>  
>  	if (!autopm_error)
>  		usb_autopm_put_interface(synusb->intf);
> @@ -315,6 +322,7 @@ static int synusb_probe(struct usb_interface *intf,
>  	synusb->udev = udev;
>  	synusb->intf = intf;
>  	synusb->input = input_dev;
> +	mutex_init(&synusb->pm_mutex);
>  
>  	synusb->flags = id->driver_info;
>  	if (synusb->flags & SYNUSB_COMBO) {
> @@ -466,11 +474,10 @@ static void synusb_disconnect(struct usb_interface *intf)
>  static int synusb_suspend(struct usb_interface *intf, pm_message_t message)
>  {
>  	struct synusb *synusb = usb_get_intfdata(intf);
> -	struct input_dev *input_dev = synusb->input;
>  
> -	mutex_lock(&input_dev->mutex);
> +	mutex_lock(&synusb->pm_mutex);
>  	usb_kill_urb(synusb->urb);
> -	mutex_unlock(&input_dev->mutex);
> +	mutex_unlock(&synusb->pm_mutex);
>  
>  	return 0;
>  }
> @@ -481,14 +488,14 @@ static int synusb_resume(struct usb_interface *intf)
>  	struct input_dev *input_dev = synusb->input;
>  	int retval = 0;
>  
> -	mutex_lock(&input_dev->mutex);
> +	mutex_lock(&synusb->pm_mutex);
>  
>  	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
>  	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
>  		retval = -EIO;
>  	}
>  
> -	mutex_unlock(&input_dev->mutex);
> +	mutex_unlock(&synusb->pm_mutex);
>  
>  	return retval;
>  }
> @@ -496,9 +503,8 @@ static int synusb_resume(struct usb_interface *intf)
>  static int synusb_pre_reset(struct usb_interface *intf)
>  {
>  	struct synusb *synusb = usb_get_intfdata(intf);
> -	struct input_dev *input_dev = synusb->input;
>  
> -	mutex_lock(&input_dev->mutex);
> +	mutex_lock(&synusb->pm_mutex);
>  	usb_kill_urb(synusb->urb);
>  
>  	return 0;
> @@ -515,7 +521,7 @@ static int synusb_post_reset(struct usb_interface *intf)
>  		retval = -EIO;
>  	}
>  
> -	mutex_unlock(&input_dev->mutex);
> +	mutex_unlock(&synusb->pm_mutex);
>  
>  	return retval;
>  }
> -- 
> 2.16.2
> 

-- 
Dmitry

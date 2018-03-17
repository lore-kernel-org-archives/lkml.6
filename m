Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeCQSLG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:11:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46886 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbeCQSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:11:02 -0400
X-Google-Smtp-Source: AG47ELva+Gy4etlBKasTG57moV4D7S2ni5s39KOUTJNSniMpSf+pLnOBQ8jJblsmP6FEpabgKbatAA==
Date: Sat, 17 Mar 2018 11:10:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 3/6] input: pagasus_notetaker: fix deadlock in
 autosuspend
Message-ID: <20180317181059.GD188654@dtor-ws>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
 <20180228133803.30040-4-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228133803.30040-4-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:38:00PM +0100, Marcus Folkesson wrote:
> usb_autopm_get_interface() that is called in pegasus_open() does an
> autoresume if the device is suspended.
> 
> input_dev->mutex used in pegasus_resume() is in this case already
> taken by the input subsystem and will cause a deadlock.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/pegasus_notetaker.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 47de5a81172f..9ab1ed5e20e7 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -41,6 +41,7 @@
>  #include <linux/usb/input.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> +#include <linux/mutex.h>
>  
>  /* USB HID defines */
>  #define USB_REQ_GET_REPORT		0x01
> @@ -76,6 +77,10 @@ struct pegasus {
>  	struct usb_device *usbdev;
>  	struct usb_interface *intf;
>  	struct urb *irq;
> +
> +	/* serialize access to open/suspend */
> +	struct mutex pm_mutex;
> +
>  	char name[128];
>  	char phys[64];
>  	struct work_struct init;
> @@ -216,6 +221,7 @@ static int pegasus_open(struct input_dev *dev)
>  	if (error)
>  		return error;
>  
> +	mutex_lock(&pegasus->pm_mutex);
>  	pegasus->irq->dev = pegasus->usbdev;
>  	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
>  		error = -EIO;
> @@ -226,12 +232,14 @@ static int pegasus_open(struct input_dev *dev)
>  	if (error)
>  		goto err_kill_urb;
>  
> +	mutex_unlock(&pegasus->pm_mutex);
>  	return 0;
>  
>  err_kill_urb:
>  	usb_kill_urb(pegasus->irq);
>  	cancel_work_sync(&pegasus->init);
>  err_autopm_put:
> +	mutex_unlock(&pegasus->pm_mutex);
>  	usb_autopm_put_interface(pegasus->intf);
>  	return error;
>  }
> @@ -240,8 +248,11 @@ static void pegasus_close(struct input_dev *dev)
>  {
>  	struct pegasus *pegasus = input_get_drvdata(dev);
>  
> +	mutex_lock(&pegasus->pm_mutex);
>  	usb_kill_urb(pegasus->irq);
>  	cancel_work_sync(&pegasus->init);
> +	mutex_unlock(&pegasus->pm_mutex);
> +
>  	usb_autopm_put_interface(pegasus->intf);
>  }
>  
> @@ -274,6 +285,8 @@ static int pegasus_probe(struct usb_interface *intf,
>  		goto err_free_mem;
>  	}
>  
> +	mutex_init(&pegasus->pm_mutex);
> +
>  	pegasus->usbdev = dev;
>  	pegasus->dev = input_dev;
>  	pegasus->intf = intf;
> @@ -388,10 +401,10 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
>  {
>  	struct pegasus *pegasus = usb_get_intfdata(intf);
>  
> -	mutex_lock(&pegasus->dev->mutex);
> +	mutex_lock(&pegasus->pm_mutex);
>  	usb_kill_urb(pegasus->irq);
>  	cancel_work_sync(&pegasus->init);
> -	mutex_unlock(&pegasus->dev->mutex);
> +	mutex_unlock(&pegasus->pm_mutex);
>  
>  	return 0;
>  }
> @@ -401,10 +414,10 @@ static int pegasus_resume(struct usb_interface *intf)
>  	struct pegasus *pegasus = usb_get_intfdata(intf);
>  	int retval = 0;
>  
> -	mutex_lock(&pegasus->dev->mutex);
> +	mutex_lock(&pegasus->pm_mutex);
>  	if (pegasus->dev->users && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
>  		retval = -EIO;
> -	mutex_unlock(&pegasus->dev->mutex);
> +	mutex_unlock(&pegasus->pm_mutex);
>  
>  	return retval;
>  }
> @@ -414,14 +427,14 @@ static int pegasus_reset_resume(struct usb_interface *intf)
>  	struct pegasus *pegasus = usb_get_intfdata(intf);
>  	int retval = 0;
>  
> -	mutex_lock(&pegasus->dev->mutex);
> +	mutex_lock(&pegasus->pm_mutex);
>  	if (pegasus->dev->users) {
>  		retval = pegasus_set_mode(pegasus, PEN_MODE_XY,
>  					  NOTETAKER_LED_MOUSE);
>  		if (!retval && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
>  			retval = -EIO;
>  	}
> -	mutex_unlock(&pegasus->dev->mutex);
> +	mutex_unlock(&pegasus->pm_mutex);
>  
>  	return retval;
>  }
> -- 
> 2.16.2
> 

-- 
Dmitry

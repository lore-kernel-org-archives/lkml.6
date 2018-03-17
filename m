Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeCQSLC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:11:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39581 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbeCQSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:10:54 -0400
X-Google-Smtp-Source: AG47ELvyI365BxLmklfHYohjk+d1TJSB6IhRK5KnY8XWQGhzZr3tDHw9iCKZ0ikh4qPhV/62Zpt3MQ==
Date: Sat, 17 Mar 2018 11:10:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 2/6] input: synaptics_usb: do not rely on
 input_dev->users
Message-ID: <20180317181051.GC188654@dtor-ws>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
 <20180228133803.30040-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228133803.30040-3-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:37:59PM +0100, Marcus Folkesson wrote:
> If the device is unused and suspended, a call to open will cause the
> device to autoresume through the call to usb_autopm_get_interface().
> 
> input_dev->users is already incremented by the input subsystem,
> therefore this expression will always be evaluated to true:
> 
> 	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
> 	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
> 		retval = -EIO;
> 	}
> 
> The same URB will then be fail when resubmitted in synusb_open().
> 
> Introduce synusb->is_open to keep track of the state instead.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics_usb.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
> index 2c66913cf5a2..e2b726751220 100644
> --- a/drivers/input/mouse/synaptics_usb.c
> +++ b/drivers/input/mouse/synaptics_usb.c
> @@ -84,6 +84,7 @@ struct synusb {
>  
>  	/* serialize access to open/suspend */
>  	struct mutex pm_mutex;
> +	bool is_open;
>  
>  	/* input device related data structures */
>  	struct input_dev *input;
> @@ -266,6 +267,7 @@ static int synusb_open(struct input_dev *dev)
>  	}
>  
>  	synusb->intf->needs_remote_wakeup = 1;
> +	synusb->is_open = 1;
>  
>  out:
>  	mutex_unlock(&synusb->pm_mutex);
> @@ -283,6 +285,7 @@ static void synusb_close(struct input_dev *dev)
>  	mutex_lock(&synusb->pm_mutex);
>  	usb_kill_urb(synusb->urb);
>  	synusb->intf->needs_remote_wakeup = 0;
> +	synusb->is_open = 0;
>  	mutex_unlock(&synusb->pm_mutex);
>  
>  	if (!autopm_error)
> @@ -485,12 +488,11 @@ static int synusb_suspend(struct usb_interface *intf, pm_message_t message)
>  static int synusb_resume(struct usb_interface *intf)
>  {
>  	struct synusb *synusb = usb_get_intfdata(intf);
> -	struct input_dev *input_dev = synusb->input;
>  	int retval = 0;
>  
>  	mutex_lock(&synusb->pm_mutex);
>  
> -	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
> +	if ((synusb->is_open || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
>  	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
>  		retval = -EIO;
>  	}
> @@ -513,10 +515,9 @@ static int synusb_pre_reset(struct usb_interface *intf)
>  static int synusb_post_reset(struct usb_interface *intf)
>  {
>  	struct synusb *synusb = usb_get_intfdata(intf);
> -	struct input_dev *input_dev = synusb->input;
>  	int retval = 0;
>  
> -	if ((input_dev->users || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
> +	if ((synusb->is_open || (synusb->flags & SYNUSB_IO_ALWAYS)) &&
>  	    usb_submit_urb(synusb->urb, GFP_NOIO) < 0) {
>  		retval = -EIO;
>  	}
> -- 
> 2.16.2
> 

-- 
Dmitry

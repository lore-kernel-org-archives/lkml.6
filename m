Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeCQSL1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:11:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45958 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbeCQSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:11:22 -0400
X-Google-Smtp-Source: AG47ELs0pUEii2c96WR2EvXhg5z7ga5LPhTEltgEzsU5Z0p2mNalRfXx5m8Kc2ntpTEJ9a/GNbKnQA==
Date: Sat, 17 Mar 2018 11:11:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 6/6] input: usbtouchscreen: do not rely on
 input_dev->users
Message-ID: <20180317181119.GG188654@dtor-ws>
References: <20180228133803.30040-1-marcus.folkesson@gmail.com>
 <20180228133803.30040-7-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228133803.30040-7-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:38:03PM +0100, Marcus Folkesson wrote:
> If the device is unused and suspended, a call to open will cause the
> device to autoresume through the call to usb_autopm_get_interface().
> 
> input_dev->users is already incremented by the input subsystem,
> therefore this expression will always be evaluated to true:
> 
> 	if (input->users || usbtouch->type->irq_always)
> 		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
> 
> The same URB will then be fail when resubmitted in usbtouch_open().
> 
> Introduce usbtouch->is_open to keep track of the state instead.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/usbtouchscreen.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index e964658203d8..0356ad792e40 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -114,6 +114,7 @@ struct usbtouch_usb {
>  	struct input_dev *input;
>  	struct usbtouch_device_info *type;
>  	struct mutex pm_mutex;  /* serialize access to open/suspend */
> +	bool is_open;
>  	char name[128];
>  	char phys[64];
>  	void *priv;
> @@ -1466,6 +1467,7 @@ static int usbtouch_open(struct input_dev *input)
>  	}
>  
>  	usbtouch->interface->needs_remote_wakeup = 1;
> +	usbtouch->is_open = 1;
>  out_put:
>  	mutex_unlock(&usbtouch->pm_mutex);
>  	usb_autopm_put_interface(usbtouch->interface);
> @@ -1481,6 +1483,7 @@ static void usbtouch_close(struct input_dev *input)
>  	mutex_lock(&usbtouch->pm_mutex);
>  	if (!usbtouch->type->irq_always)
>  		usb_kill_urb(usbtouch->irq);
> +	usbtouch->is_open = 0;
>  	mutex_lock(&usbtouch->pm_mutex);
>  
>  	r = usb_autopm_get_interface(usbtouch->interface);
> @@ -1502,11 +1505,10 @@ static int usbtouch_suspend
>  static int usbtouch_resume(struct usb_interface *intf)
>  {
>  	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
> -	struct input_dev *input = usbtouch->input;
>  	int result = 0;
>  
>  	mutex_lock(&usbtouch->pm_mutex);
> -	if (input->users || usbtouch->type->irq_always)
> +	if (usbtouch->is_open || usbtouch->type->irq_always)
>  		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
>  	mutex_unlock(&usbtouch->pm_mutex);
>  
> @@ -1516,7 +1518,6 @@ static int usbtouch_resume(struct usb_interface *intf)
>  static int usbtouch_reset_resume(struct usb_interface *intf)
>  {
>  	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
> -	struct input_dev *input = usbtouch->input;
>  	int err = 0;
>  
>  	/* reinit the device */
> @@ -1532,7 +1533,7 @@ static int usbtouch_reset_resume(struct usb_interface *intf)
>  
>  	/* restart IO if needed */
>  	mutex_lock(&usbtouch->pm_mutex);
> -	if (input->users)
> +	if (usbtouch->is_open)
>  		err = usb_submit_urb(usbtouch->irq, GFP_NOIO);
>  	mutex_unlock(&usbtouch->pm_mutex);
>  
> -- 
> 2.16.2
> 

-- 
Dmitry

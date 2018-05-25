Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935875AbeEYGa2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeEYGa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:30:27 -0400
Date: Fri, 25 May 2018 08:30:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Eugene Korenevsky <ekorenevsky@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: Re: [PATCH] usb: hub: Per-port setting to use old enumeration scheme
Message-ID: <20180525063009.GB11968@kroah.com>
References: <20180523021656.122455-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523021656.122455-1-drinkcat@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:16:56AM +0800, Nicolas Boichat wrote:
> The "old" enumeration scheme is considerably faster (it takes
> ~294ms instead of ~439ms to get the descriptor).
> 
> It is currently only possible to use the old scheme globally
> (/sys/module/usbcore/parameters/old_scheme_first), which is not
> desirable as the new scheme was introduced to increase compatibility
> with more devices.
> 
> However, in our case, we care about time-to-active for a specific
> USB device (which we make the firmware for), on a specific port
> (that is pogo-pin based: not a standard USB port). This new
> sysfs option makes it possible to use the old scheme on a single
> port only.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> There are other "quirks" that we could add to reduce further
> enumeration time (e.g. reduce USB debounce time, reduce TRSTRCY
> to 10ms instead of 50ms as used currently), but the logic is quite
> similar, so it'd be good to have this reviewed first.
> 
>  drivers/usb/core/hub.c  | 13 +++++++++----
>  drivers/usb/core/hub.h  |  1 +
>  drivers/usb/core/port.c | 23 +++++++++++++++++++++++
>  include/linux/usb.h     |  7 +++++++
>  4 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c2d993d3816f0..f900f66a62856 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2636,7 +2636,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
>  #define SET_ADDRESS_TRIES	2
>  #define GET_DESCRIPTOR_TRIES	2
>  #define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
> -#define USE_NEW_SCHEME(i)	((i) / 2 == (int)old_scheme_first)
> +#define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)scheme)
>  
>  #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
>  #define HUB_SHORT_RESET_TIME	10
> @@ -2651,12 +2651,16 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
>   * enumeration failures, so disable this enumeration scheme for USB3
>   * devices.
>   */
> -static bool use_new_scheme(struct usb_device *udev, int retry)
> +static bool use_new_scheme(struct usb_device *udev, int retry,
> +			   struct usb_port *port_dev)
>  {
> +	int old_scheme_first_port =
> +		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
> +
>  	if (udev->speed >= USB_SPEED_SUPER)
>  		return false;
>  
> -	return USE_NEW_SCHEME(retry);
> +	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
>  }
>  
>  /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> @@ -4392,6 +4396,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  {
>  	struct usb_device	*hdev = hub->hdev;
>  	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
> +	struct usb_port		*port_dev = hub->ports[port1 - 1];
>  	int			retries, operations, retval, i;
>  	unsigned		delay = HUB_SHORT_RESET_TIME;
>  	enum usb_device_speed	oldspeed = udev->speed;
> @@ -4513,7 +4518,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
>  		bool did_new_scheme = false;
>  
> -		if (use_new_scheme(udev, retry_counter)) {
> +		if (use_new_scheme(udev, retry_counter, port_dev)) {
>  			struct usb_device_descriptor *buf;
>  			int r = 0;
>  
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 4dc769ee9c740..4accfb63f7dcb 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -98,6 +98,7 @@ struct usb_port {
>  	struct mutex status_lock;
>  	u32 over_current_count;
>  	u8 portnum;
> +	u32 quirks;
>  	unsigned int is_superspeed:1;
>  	unsigned int usb3_lpm_u1_permit:1;
>  	unsigned int usb3_lpm_u2_permit:1;
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 6979bde87d310..4a21431953953 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -50,6 +50,28 @@ static ssize_t over_current_count_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(over_current_count);
>  
> +static ssize_t quirks_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	return sprintf(buf, "%08x\n", port_dev->quirks);
> +}
> +
> +static ssize_t quirks_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +	u32 value;
> +
> +	if (kstrtou32(buf, 16, &value))
> +		return -EINVAL;
> +
> +	port_dev->quirks = value;
> +	return count;
> +}
> +static DEVICE_ATTR_RW(quirks);
> +
>  static ssize_t usb3_lpm_permit_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
> @@ -118,6 +140,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
>  
>  static struct attribute *port_dev_attrs[] = {
>  	&dev_attr_connect_type.attr,
> +	&dev_attr_quirks.attr,
>  	&dev_attr_over_current_count.attr,
>  	NULL,
>  };

Oops, you add a new sysfs file, but do not document it anywhere.  It
needs to go into Documentation/ABI/ along with the other files,
otherwise no one knows how to use it.

Please fix that up and resend.

thanks,

greg k-h

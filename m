Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeE2Hr5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755179AbeE2Hru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:47:50 -0400
Date: Tue, 29 May 2018 09:47:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: martin_liu <liumartin@google.com>
Cc: stern@rowland.harvard.edu, heikki.krogerus@linux.intel.com,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jenhaochen@google.com
Subject: Re: [RFC PATCH v2] driver core: hold dev's parent lock when needed
Message-ID: <20180529074730.GA23486@kroah.com>
References: <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org>
 <20180529070719.164626-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529070719.164626-1-liumartin@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:07:20PM +0800, martin_liu wrote:
> SOC have internal I/O buses that can't be proved for devices. The
> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under it desribed in DT
> (device tree).
> 
> In commit 'bf74ad5bc417 introduce ("[PATCH] Hold the device's
> parent's lock during probe and remove")' to solve USB subsystem
> lock sequence since usb device's characteristic. Thus "soc"
> needs to be locked whenever a device and driver's probing
> happen under "soc" bus. During this period, an async driver
> tries to probe a device which is under the "soc" bus would be
> blocked until previous driver finish the probing and release "soc"
> lock. And the next probing under the "soc" bus need to wait for
> async finish. Because of that, driver's async probe for init
> time improvement will be shadowed.
> 
> Since many devices don't have USB devices' characteristic, they
> actually don't need parent's lock. Thus, we introduce a lock flag
> in device struct and driver core would lock the parent lock base
> on the flag. For usbsystem, we set this flag when its device and
> driver is matched and to keep original lock behavior in driver
> core.
> 
> Async probe could have more benefit after this patch.
> 
> Signed-off-by: martin_liu <liumartin@google.com>

Nit, your name here is probably not what you sign legal documents with.
Please use your "real name" in this line, and in your From: email line
(hint, no '_').  This prevents me from accepting the patch at all.

> Suggested-by: Alan Stern <stern@rowland.harvard.edu>

Changes were suggested, I don't know if the whole idea was :)

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -992,6 +992,7 @@ struct device {
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> +	bool			need_parent_lock:1;

Shouldn't this be a bus type flag, and not a device-specific flag?  You
are only ever caring about this based on the type of bus the device is
on, the rule would not be different for different devices on the same
bus from what I can tell.

thanks,

greg k-h

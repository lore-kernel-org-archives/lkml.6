Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeCRPXy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:23:54 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:53128 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCRPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:23:53 -0400
Date: Sun, 18 Mar 2018 16:23:49 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Markus Grabner <grabner@icg.tugraz.at>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Chris Rorvick <chris@rorvick.com>, Andrej Krutak <dev@andree.sk>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: usb: line6: Replace mdelay with
 msleep in line6_read_data
Message-ID: <20180318152349.GA16414@lenoch>
References: <1521384693-23336-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521384693-23336-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 10:51:33PM +0800, Jia-Ju Bai wrote:
> line6_read_data() is never called in atomic context.
> 
> The call chains ending up at line6_read_data() are:
> [1] line6_read_data() <- line6_read_serial_number() -> pod_startup4()
> [2] line6_read_data() <- line6_read_serial_number() <- 
> 	podhd_startup_workqueue()
> [3] line6_read_data() <- podhd_dev_start() <- podhd_startup_workqueue()
> [4] line6_read_data() <- line6_read_serial_number() <- toneport_init()
> 	<- line6_probe()
> [5] line6_read_data() <- toneport_init() <- line6_probe()
> 
> pod_startup4() and podhd_startup_workqueue() are set in INIT_WORK().
> line6_probe() is called in toneport_probe(), pod_probe(), podhd_probe() 
> and variax_probe(), which are set as ".probe" in usb_driver structure.
> These functions are not called in atomic context.
> 
> Despite never getting called from atomic context, line6_read_data()
> calls mdelay for busy wait.
> That is not necessary and can be replaced with msleep to 
> avoid busy waiting.

Can we have usleep_range here? Please see Documentation/timers/timers-howto.txt
for rationale and range settings.

> This is found by a static analysis tool named DCNS written by myself.

Here I'm assuming you do not have hardware and do not know how it works,
therefore few more people from 'git log --follow sound/usb/line6/driver.c'
were added to Cc list. Hopefully they can clarify the right range value.

Thank you.

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  sound/usb/line6/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 0ff5a7d..af99e73 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -356,7 +356,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
>  
>  	/* Wait for data length. We'll get 0xff until length arrives. */
>  	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
> -		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
> +		msleep(LINE6_READ_WRITE_STATUS_DELAY);
>  
>  		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
>  				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

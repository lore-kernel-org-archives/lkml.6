Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032211AbeEZQrP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:47:15 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41140 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:47:14 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: David Fries <David@fries.net>
Cc: linux-kernel@vger.kernel.org,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] media: uvc_driver: fix USB Camera ref leak denial of service
Date: Sat, 26 May 2018 19:47:12 +0300
Message-ID: <7755956.sgLFZZjbUQ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180526163718.GE28969@spacedout.fries.net>
References: <20180526155046.GA3327@spacedout.fries.net> <3294600.sHRg43ppdH@avalon> <20180526163718.GE28969@spacedout.fries.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Saturday, 26 May 2018 19:37:18 EEST David Fries wrote:
> Laurent and Mauro,
> 
> I've reviewed Philipp Zabel's 49770 patch, it looks like they
> equivalent, but take a different path.  My version does the unref in
> uvc_unregister_video, Zabel's does the unref in each caller of
> uvc_unregister_video.  I think I would prefer it to be in fewer
> places.

While I agree that avoiding code duplication is a good idea, we also need to 
ensure that the unref call is the very last operation we perform, otherwise 
we'll risk a use-after-free. The uvc_unregister_video() function is called 
last so that's guaranteed with your patch. However, by hiding the unref there 
from the callers, I wonder whether it couldn't result in issues in the future 
if someone decides to add code after the uvc_unregister_video() calls without 
noticing the unref issue.

> Any ideas on the sysfs group 'power' not found bug on removal while on
> use?

I haven't had time to investigate them yet, please feel free to give it a go 
without waiting for me :-)

> Thanks, it will be great to get this fixed.
> 
> On Sat, May 26, 2018 at 07:21:11PM +0300, Laurent Pinchart wrote:
> > Hi David,
> > 
> > Thank you for the patch.
> > 
> > On Saturday, 26 May 2018 18:50:46 EEST David Fries wrote:
> > > Commit 9d15cd958c17 ("media: uvcvideo: Convert from using an atomic
> > > variable to a reference count")
> > > didn't take into account that while the old counter was initialized to
> > > 0 (no stream open), kref_init starts with a reference of 1.  The
> > > reference count on unplug no longer reaches 0, uvc_delete isn't
> > > called, and evdev doesn't release /dev/input/event*.  Plug and unplug
> > > enough times and it runs out of device minors preventing any new input
> > > device and the use of newly plugged in USB video cameras until the
> > > system is rebooted.
> > > 
> > > Signed-off-by: David Fries <David@Fries.net>
> > > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > > Cc: stable@vger.kernel.org
> > 
> > Philipp Zabel has already posted a similar patch, see https://
> > patchwork.linuxtv.org/patch/49770/
> > 
> > Mauro,
> > 
> > This is a serious issue so I'd like to get the patch merged in v4.18, but
> > it could be argued that it's getting late for that, especially given that
> > the bug has been there since v4.14. Would you be OK merging this in v4.18
> > ? If so could you pick https://patchwork.linuxtv.org/patch/49770/ up, or
> > would you like me to send a pull request ?
> > 
> > > ---
> > > 
> > >  drivers/media/usb/uvc/uvc_driver.c | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c
> > > b/drivers/media/usb/uvc/uvc_driver.c index 2469b49..3cbdc87 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -1871,13 +1871,6 @@ static void uvc_unregister_video(struct
> > > uvc_device
> > > *dev) {
> > > 
> > >  	struct uvc_streaming *stream;
> > > 
> > > -	/* Unregistering all video devices might result in uvc_delete() 
being
> > > -	 * called from inside the loop if there's no open file handle. To
> > > avoid
> > > -	 * that, increment the refcount before iterating over the streams 
and
> > > -	 * decrement it when done.
> > > -	 */
> > > -	kref_get(&dev->ref);
> > > -
> > > 
> > >  	list_for_each_entry(stream, &dev->streams, list) {
> > >  	
> > >  		if (!video_is_registered(&stream->vdev))
> > >  		
> > >  			continue;
> > > 
> > > @@ -1888,6 +1881,10 @@ static void uvc_unregister_video(struct
> > > uvc_device
> > > *dev) uvc_debugfs_cleanup_stream(stream);
> > > 
> > >  	}
> > > 
> > > +	/* Release the reference implicit in kref_init from uvc_probe,
> > > +	 * the UVC device won't be deleted until the last file descriptor
> > > +	 * is also closed.
> > > +	 */
> > > 
> > >  	kref_put(&dev->ref, uvc_delete);
> > >  
> > >  }


-- 
Regards,

Laurent Pinchart

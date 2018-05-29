Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeE2Htj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:49:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56103 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeE2Hth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:49:37 -0400
X-Google-Smtp-Source: AB8JxZoAjvmnHwUU0FgnZXDnLFgmh9v311O6cIOw95symUAkEJ2oxar1/zjgMO5gsxcBL6ofMvvbZA==
Date: Tue, 29 May 2018 09:49:33 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH] drm: Fix possible race conditions while unplugging DRM
 device
Message-ID: <20180529074933.GY3438@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
References: <20180522141304.18646-1-andr2000@gmail.com>
 <20180529070200.GW3438@phenom.ffwll.local>
 <3427121e-ddd9-d2ba-b684-61338f0207ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3427121e-ddd9-d2ba-b684-61338f0207ce@gmail.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:09:57AM +0300, Oleksandr Andrushchenko wrote:
> On 05/29/2018 10:02 AM, Daniel Vetter wrote:
> > On Tue, May 22, 2018 at 05:13:04PM +0300, Oleksandr Andrushchenko wrote:
> > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > 
> > > When unplugging a hotpluggable DRM device we first unregister it
> > > with drm_dev_unregister and then set drm_device.unplugged flag which
> > > is used to mark device critical sections with drm_dev_enter()/
> > > drm_dev_exit() preventing access to device resources that are not
> > > available after the device is gone.
> > > But drm_dev_unregister may lead to hotplug uevent(s) fired to
> > > user-space on card and/or connector removal, thus making it possible
> > > for user-space to try accessing a disconnected device.
> > > 
> > > Fix this by first making sure device is properly marked as
> > > disconnected and only then unregister it.
> > > 
> > > Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")
> > > 
> > > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > Reported-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
> > > Cc: "Noralf Trønnes" <noralf@tronnes.org>
> > Nice catch.
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > I think you need to push this to drm-misc-next-fixes to make sure it's on
> > the 4.17 train.
> Sure, after I have r-b from Noralf

Noralf's occasionally occupied with other things and doesn't have time to
look at patches. I think it's ok to just push after a few more days, even
if he doesn't respond. Same holds for other people really.
-Daniel

> > -Daniel
> > 
> > > ---
> > >   drivers/gpu/drm/drm_drv.c | 14 +++++++-------
> > >   1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > index b553a6f2ff0e..7af748ed1c58 100644
> > > --- a/drivers/gpu/drm/drm_drv.c
> > > +++ b/drivers/gpu/drm/drm_drv.c
> > > @@ -369,13 +369,6 @@ EXPORT_SYMBOL(drm_dev_exit);
> > >    */
> > >   void drm_dev_unplug(struct drm_device *dev)
> > >   {
> > > -	drm_dev_unregister(dev);
> > > -
> > > -	mutex_lock(&drm_global_mutex);
> > > -	if (dev->open_count == 0)
> > > -		drm_dev_put(dev);
> > > -	mutex_unlock(&drm_global_mutex);
> > > -
> > >   	/*
> > >   	 * After synchronizing any critical read section is guaranteed to see
> > >   	 * the new value of ->unplugged, and any critical section which might
> > > @@ -384,6 +377,13 @@ void drm_dev_unplug(struct drm_device *dev)
> > >   	 */
> > >   	dev->unplugged = true;
> > >   	synchronize_srcu(&drm_unplug_srcu);
> > > +
> > > +	drm_dev_unregister(dev);
> > > +
> > > +	mutex_lock(&drm_global_mutex);
> > > +	if (dev->open_count == 0)
> > > +		drm_dev_put(dev);
> > > +	mutex_unlock(&drm_global_mutex);
> > >   }
> > >   EXPORT_SYMBOL(drm_dev_unplug);
> > > -- 
> > > 2.17.0
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

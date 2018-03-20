Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeCTNr1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:47:27 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35048 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeCTNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:47:21 -0400
X-Google-Smtp-Source: AG47ELvVLW6I2n6dE+0PDh33OFLdc/DIngxJ+7PzPVPfxduKqYTqPnaydEYuKOW6pZgNbLFGVKNlpw==
Date: Tue, 20 Mar 2018 14:47:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>, Juergen Gross <jgross@suse.com>,
        boris.ostrovsky@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [PATCH RESEND v2 1/2] drm/xen-front: Add support for Xen PV
 display frontend
Message-ID: <20180320134715.GT14155@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <1520958066-22875-1-git-send-email-andr2000@gmail.com>
 <1520958066-22875-2-git-send-email-andr2000@gmail.com>
 <20180316082330.GF25297@phenom.ffwll.local>
 <b466004a-821e-60b7-787b-526e10a67505@gmail.com>
 <20180319135141.GK14155@phenom.ffwll.local>
 <0808bf3b-7301-cc28-1cb5-40a4c8aad5cc@gmail.com>
 <CAKMK7uFrCt026VfjyKA1TS6XcP=s4S-RX0hxtLXL53OmdjgHfw@mail.gmail.com>
 <7c4e0f8f-9ec0-e38b-7b37-264241df4ba5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4e0f8f-9ec0-e38b-7b37-264241df4ba5@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 01:58:01PM +0200, Oleksandr Andrushchenko wrote:
> On 03/19/2018 05:28 PM, Daniel Vetter wrote:
> > There should be no difference between immediate removal and delayed
> > removal of the drm_device from the xenbus pov. The lifetimes of the
> > front-end (drm_device) and backend (the xen bus thing) are entirely
> > decoupled:
> Well, they are not decoupled for simplicity of handling,
> please see below
> > 
> > So for case 2 you only have 1 case:
> > 
> > - drm_dev_unplug
> > - tear down the entire xenbus backend completely
> > - all xenbus access will be caught with drm_dev_entre/exit (well right
> > now drm_dev_is_unplugged) checks, including any access to your private
> > drm_device data
> > - once drm_device->open_count == 0 the core will tear down the
> > drm_device instance and call your optional drm_driver->release
> > callback.
> > 
> > So past drm_dev_unplug the drm_device is in zombie state and the only
> > thing that will happen is a) it rejects all ioctls and anything else
> > userspace might ask it to do and b) gets releases once the last
> > userspace reference is gone.
> I have re-worked the driver with this in mind [1]
> So, I now use drm_dev_unplug and destroy the DRM device
> on drm_driver.release.
> In context of unplug work I also merged xen_drm_front_drv.c and
> xen_drm_front.c as these are too coupled together now.
> 
> Could you please take a look and tell me if this is what you mean?
> > 
> > If the backend comes up again, you create a _new_ drm_device instance
> > (while the other one is still in the process of eventually getting
> > released).
> We only have a single xenbus instance, so this way I'll need
> to handle list of such zombies. For that reason I prefer to
> wait until the DRM device is destroyed, telling the backend
> to hold on until then (via going into XenbusStateReconfiguring state).

Why exactly do you need to keep track of your drm_devices from the xenbus?
Once unplugged, there should be no connection with the "hw" for your
device, in neither direction. Maybe I need to look again, but this still
smells funny and not like something you should ever do.

> Another drawback of such approach is that I'll have different
> minors at run-time, e.g. card0, card1, etc.
> For software which has /dev/dri/card0 hardcoded it may be a problem.
> But this is minor, IMO

Fix userspace :-)

But yeah unlikely this is a problem, hotplugging is fairly old thing.

> > In short, your driver code should never have a need to look at
> > drm_device->open_count. I hope this explains it a bit better.
> > -Daniel
> > 
> Yes, you are correct: at [1] I am not touching drm_device->open_count
> anymore and everything just happens synchronously

> [1] https://github.com/andr2000/linux/commits/drm_tip_pv_drm_v3

Please just resend, makes it easier to comment inline.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

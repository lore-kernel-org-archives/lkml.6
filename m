Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeDXNEv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:04:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39534 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757616AbeDXNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:04:49 -0400
X-Google-Smtp-Source: AIpwx49Pf2DF27dEkjra6D7J6PQAlicObMwM454xosmgj90KFS0HdaihuSmmsu+0nq9eLvteNFfvJg==
Date: Tue, 24 Apr 2018 15:04:45 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Sean Paul <seanpaul@chromium.org>
Cc: Emil Lundmark <lndmrk@chromium.org>, Dave Airlie <airlied@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: udl: Destroy framebuffer only if it was initialized
Message-ID: <20180424130445.GD31310@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <seanpaul@chromium.org>,
        Emil Lundmark <lndmrk@chromium.org>,
        Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180420115001.161745-1-lndmrk@chromium.org>
 <20180420135532.GH73214@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420135532.GH73214@art_vandelay>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 09:55:32AM -0400, Sean Paul wrote:
> On Fri, Apr 20, 2018 at 01:50:01PM +0200, Emil Lundmark wrote:
> > This fixes a NULL pointer dereference that can happen if the UDL
> > driver is unloaded before the framebuffer is initialized. This can
> > happen e.g. if the USB device is unplugged right after it was plugged
> > in.
> > 
> 
> JFYI, in future, if someone makes a suggestion on how to fix a bug, it's good
> practice to add a Suggested-by tag to give credit.
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

I think a bit more detail in the commit message on why this is even
possible would be good. I think it can only happen when you only plug in
the udl, without anything connected.

In that case fbdev setup will be delayed until something shows up (so we
don't pin a too small fb for it, a feature requested by soc people). This
can easily be tested:
First:
- plug in udl device
- wait a minute or so (to make it clear it's not a race)
- unplug

And then:
- plug in an udl device, but with something connected.
- unplug right away.

I expect that in the first case you'll always blow up, but in the 2nd one
you'll never blow up (no matter how fast you unplug).

Cheers, Daniel



> 
> > Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
> > ---
> >  drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> > index 2ebdc6d5a76e..5754e37f741b 100644
> > --- a/drivers/gpu/drm/udl/udl_fb.c
> > +++ b/drivers/gpu/drm/udl/udl_fb.c
> > @@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
> >  {
> >  	drm_fb_helper_unregister_fbi(&ufbdev->helper);
> >  	drm_fb_helper_fini(&ufbdev->helper);
> > -	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> > -	drm_framebuffer_cleanup(&ufbdev->ufb.base);
> > -	drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> > +	if (ufbdev->ufb.obj) {
> > +		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> > +		drm_framebuffer_cleanup(&ufbdev->ufb.base);
> > +		drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> > +	}
> >  }
> >  
> >  int udl_fbdev_init(struct drm_device *dev)
> > -- 
> > 2.17.0.484.g0c8726318c-goog
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeDYW5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:57:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbeDYW5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:57:34 -0400
X-Google-Smtp-Source: AB8JxZpTHpyy4CW0sU4n1ZAdR+W1zaf58wbp4HfcW6Y2QwITc1ojIO4tapEI2Q4Cn7VElq7IWGCXPwze2qrM8pKeuXo=
MIME-Version: 1.0
In-Reply-To: <20180424130445.GD31310@phenom.ffwll.local>
References: <20180420115001.161745-1-lndmrk@chromium.org> <20180420135532.GH73214@art_vandelay>
 <20180424130445.GD31310@phenom.ffwll.local>
From: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <stephane.marchesin@gmail.com>
Date: Wed, 25 Apr 2018 15:56:53 -0700
Message-ID: <CACP_E+Jn4Nxq+u-isieVdrvC_r=CvvpoYKajWA-H1DgbTEaSeA@mail.gmail.com>
Subject: Re: [PATCH] drm: udl: Destroy framebuffer only if it was initialized
To: Sean Paul <seanpaul@chromium.org>, Emil Lundmark <lndmrk@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3PMvis4005619

On Tue, Apr 24, 2018 at 6:04 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Apr 20, 2018 at 09:55:32AM -0400, Sean Paul wrote:
>> On Fri, Apr 20, 2018 at 01:50:01PM +0200, Emil Lundmark wrote:
>> > This fixes a NULL pointer dereference that can happen if the UDL
>> > driver is unloaded before the framebuffer is initialized. This can
>> > happen e.g. if the USB device is unplugged right after it was plugged
>> > in.
>> >
>>
>> JFYI, in future, if someone makes a suggestion on how to fix a bug, it's good
>> practice to add a Suggested-by tag to give credit.
>>
>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
> I think a bit more detail in the commit message on why this is even
> possible would be good. I think it can only happen when you only plug in
> the udl, without anything connected.

Hehe, I was just reviewing this code internally, so I can answer that one :)

It happens when fbdev is disabled (which is the case for Chrome OS).
Even though intialization of the fbdev part is optional (it's done in
udlfb_create which is the callback for fb_probe()), the teardown isn't
optional (udl_driver_unload -> udl_fbdev_cleanup ->
udl_fbdev_destroy).

Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
always set during udl_fbdev_init.

Stéphane


>
> In that case fbdev setup will be delayed until something shows up (so we
> don't pin a too small fb for it, a feature requested by soc people). This
> can easily be tested:
> First:
> - plug in udl device
> - wait a minute or so (to make it clear it's not a race)
> - unplug
>
> And then:
> - plug in an udl device, but with something connected.
> - unplug right away.
>
> I expect that in the first case you'll always blow up, but in the 2nd one
> you'll never blow up (no matter how fast you unplug).
>
> Cheers, Daniel
>
>
>
>>
>> > Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
>> > ---
>> >  drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
>> >  1 file changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
>> > index 2ebdc6d5a76e..5754e37f741b 100644
>> > --- a/drivers/gpu/drm/udl/udl_fb.c
>> > +++ b/drivers/gpu/drm/udl/udl_fb.c
>> > @@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
>> >  {
>> >     drm_fb_helper_unregister_fbi(&ufbdev->helper);
>> >     drm_fb_helper_fini(&ufbdev->helper);
>> > -   drm_framebuffer_unregister_private(&ufbdev->ufb.base);
>> > -   drm_framebuffer_cleanup(&ufbdev->ufb.base);
>> > -   drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
>> > +   if (ufbdev->ufb.obj) {
>> > +           drm_framebuffer_unregister_private(&ufbdev->ufb.base);
>> > +           drm_framebuffer_cleanup(&ufbdev->ufb.base);
>> > +           drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
>> > +   }
>> >  }
>> >
>> >  int udl_fbdev_init(struct drm_device *dev)
>> > --
>> > 2.17.0.484.g0c8726318c-goog
>> >
>>
>> --
>> Sean Paul, Software Engineer, Google / Chromium OS
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

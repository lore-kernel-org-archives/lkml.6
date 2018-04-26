Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeDZJvF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:51:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39313 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeDZJuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:50:02 -0400
X-Google-Smtp-Source: AIpwx48dj+Q9w6wRzPt3ipmLdg6bEC1BQ513eGb8dizY4ZNrn9TWVKcKtdahy1AQZGUIe4K4niEChdPgOjclxONY0mM=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <CACP_E+Jn4Nxq+u-isieVdrvC_r=CvvpoYKajWA-H1DgbTEaSeA@mail.gmail.com>
References: <20180420115001.161745-1-lndmrk@chromium.org> <20180420135532.GH73214@art_vandelay>
 <20180424130445.GD31310@phenom.ffwll.local> <CACP_E+Jn4Nxq+u-isieVdrvC_r=CvvpoYKajWA-H1DgbTEaSeA@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 26 Apr 2018 11:50:01 +0200
X-Google-Sender-Auth: KyBi9PyD_QDkXfJca_M5a1Ks5hA
Message-ID: <CAKMK7uE_0FSfF694xKfhtRbdfkYP_DbT+KcBNM2LbG53tY1J2w@mail.gmail.com>
Subject: Re: [PATCH] drm: udl: Destroy framebuffer only if it was initialized
To: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <stephane.marchesin@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>, Emil Lundmark <lndmrk@chromium.org>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3Q9pDGp019355

On Thu, Apr 26, 2018 at 12:56 AM, Stéphane Marchesin
<stephane.marchesin@gmail.com> wrote:
> On Tue, Apr 24, 2018 at 6:04 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Fri, Apr 20, 2018 at 09:55:32AM -0400, Sean Paul wrote:
>>> On Fri, Apr 20, 2018 at 01:50:01PM +0200, Emil Lundmark wrote:
>>> > This fixes a NULL pointer dereference that can happen if the UDL
>>> > driver is unloaded before the framebuffer is initialized. This can
>>> > happen e.g. if the USB device is unplugged right after it was plugged
>>> > in.
>>> >
>>>
>>> JFYI, in future, if someone makes a suggestion on how to fix a bug, it's good
>>> practice to add a Suggested-by tag to give credit.
>>>
>>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>>
>> I think a bit more detail in the commit message on why this is even
>> possible would be good. I think it can only happen when you only plug in
>> the udl, without anything connected.
>
> Hehe, I was just reviewing this code internally, so I can answer that one :)
>
> It happens when fbdev is disabled (which is the case for Chrome OS).
> Even though intialization of the fbdev part is optional (it's done in
> udlfb_create which is the callback for fb_probe()), the teardown isn't
> optional (udl_driver_unload -> udl_fbdev_cleanup ->
> udl_fbdev_destroy).
>
> Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
> does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
> always set during udl_fbdev_init.

Ah right, that's another scenario where fbdev never gets fully
initialized, totally forgot about it :-)

It's a bit unfortunately that we don't have a simple fix for this,
i915 has a bunch of messy such checks too. Hopefully Noralf's work to
make fbdev emulation look more like a normal kms client (which just
happens to run within the kernel) will help here in the long run.
-Daniel


>
> Stéphane
>
>
>>
>> In that case fbdev setup will be delayed until something shows up (so we
>> don't pin a too small fb for it, a feature requested by soc people). This
>> can easily be tested:
>> First:
>> - plug in udl device
>> - wait a minute or so (to make it clear it's not a race)
>> - unplug
>>
>> And then:
>> - plug in an udl device, but with something connected.
>> - unplug right away.
>>
>> I expect that in the first case you'll always blow up, but in the 2nd one
>> you'll never blow up (no matter how fast you unplug).
>>
>> Cheers, Daniel
>>
>>
>>
>>>
>>> > Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
>>> > ---
>>> >  drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
>>> >  1 file changed, 5 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
>>> > index 2ebdc6d5a76e..5754e37f741b 100644
>>> > --- a/drivers/gpu/drm/udl/udl_fb.c
>>> > +++ b/drivers/gpu/drm/udl/udl_fb.c
>>> > @@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
>>> >  {
>>> >     drm_fb_helper_unregister_fbi(&ufbdev->helper);
>>> >     drm_fb_helper_fini(&ufbdev->helper);
>>> > -   drm_framebuffer_unregister_private(&ufbdev->ufb.base);
>>> > -   drm_framebuffer_cleanup(&ufbdev->ufb.base);
>>> > -   drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
>>> > +   if (ufbdev->ufb.obj) {
>>> > +           drm_framebuffer_unregister_private(&ufbdev->ufb.base);
>>> > +           drm_framebuffer_cleanup(&ufbdev->ufb.base);
>>> > +           drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
>>> > +   }
>>> >  }
>>> >
>>> >  int udl_fbdev_init(struct drm_device *dev)
>>> > --
>>> > 2.17.0.484.g0c8726318c-goog
>>> >
>>>
>>> --
>>> Sean Paul, Software Engineer, Google / Chromium OS
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

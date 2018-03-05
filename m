Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeCEIwx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:52:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56064 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeCEIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:52:47 -0500
X-Google-Smtp-Source: AG47ELuxZc8Vspcd5ARHkvqkeWUM28aRXmFFOiMximLnP8UxNrzJ7QvEdLGkHmW8Sqm/HPhE9iNzyA==
Date: Mon, 5 Mar 2018 09:52:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
Subject: Re: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with
 no active CRTC
Message-ID: <20180305085243.GE22212@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
References: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
 <20180219143002.GC22199@phenom.ffwll.local>
 <d676eef9-55b2-a7fd-be9b-4d53d59610a9@epam.com>
 <20180220111748.GJ22199@phenom.ffwll.local>
 <38f46c4f-3c0d-cf86-3d50-cf0f9313b205@gmail.com>
 <20180220124919.GS22199@phenom.ffwll.local>
 <94327c23-af1c-a348-5dd2-dfb963b71c96@gmail.com>
 <12b4be99-9003-d566-bda4-2982d5562307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12b4be99-9003-d566-bda4-2982d5562307@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 03:29:07PM +0200, Oleksandr Andrushchenko wrote:
> On 02/20/2018 02:53 PM, Oleksandr Andrushchenko wrote:
> > On 02/20/2018 02:49 PM, Daniel Vetter wrote:
> > > On Tue, Feb 20, 2018 at 02:36:05PM +0200, Oleksandr Andrushchenko wrote:
> > > > On 02/20/2018 01:17 PM, Daniel Vetter wrote:
> > > > > On Mon, Feb 19, 2018 at 04:58:43PM +0200, Oleksandr
> > > > > Andrushchenko wrote:
> > > > > > On 02/19/2018 04:30 PM, Daniel Vetter wrote:
> > > > > > > On Tue, Feb 13, 2018 at 10:44:16AM +0200, Oleksandr
> > > > > > > Andrushchenko wrote:
> > > > > > > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > > > > > 
> > > > > > > > It is possible that drm_simple_kms_plane_atomic_check called
> > > > > > > > with no CRTC set, e.g. when user-space
> > > > > > > > application sets CRTC_ID/FB_ID
> > > > > > > > to 0 before doing any actual drawing. This leads to NULL pointer
> > > > > > > > dereference because in this case new CRTC state is NULL and must be
> > > > > > > > checked before accessing.
> > > > > > > > 
> > > > > > > > Signed-off-by: Oleksandr Andrushchenko
> > > > > > > > <oleksandr_andrushchenko@epam.com>
> > > > > > > > ---
> > > > > > > >     drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
> > > > > > > >     1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git
> > > > > > > > a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > > > b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > > > index 9ca8a4a59b74..a05eca9cec8b 100644
> > > > > > > > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > > > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > > > @@ -121,8 +121,10 @@ static int
> > > > > > > > drm_simple_kms_plane_atomic_check(struct
> > > > > > > > drm_plane *plane,
> > > > > > > >         pipe = container_of(plane, struct
> > > > > > > > drm_simple_display_pipe, plane);
> > > > > > > >         crtc_state =
> > > > > > > > drm_atomic_get_new_crtc_state(plane_state->state,
> > > > > > > >                                &pipe->crtc);
> > > > > > > > -    if (!crtc_state->enable)
> > > > > > > > -        return 0; /* nothing to check when
> > > > > > > > disabling or disabled */
> > > > > > > > +
> > > > > > > > +    if (!crtc_state || !crtc_state->enable)
> > > > > > > > +        /* nothing to check when disabling or
> > > > > > > > disabled or no CRTC set */
> > > > > > > > +        return 0;
> > > > > > > >         if (crtc_state->enable)
> > > > > > > > drm_mode_get_hv_timing(&crtc_state->mode,
> > > > > > > Hm, this is a bit annoying, since the can_position =
> > > > > > > false parameter to
> > > > > > > drm_atomic_helper_check_plane_state is supposed to
> > > > > > > catch all this. Would
> > > > > > > moving all the checks after the call to that helper,
> > > > > > > and gating them on
> > > > > > > plane_state->visible also work?
> > > > > > Yes, it does work if this is what you mean:
> > > > > I wasn't sure, thanks for figuring this out!
> > > > > 
> > > > > > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > index a05eca9cec8b..c48858bb2823 100644
> > > > > > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > > > @@ -122,14 +122,6 @@ static int
> > > > > > drm_simple_kms_plane_atomic_check(struct
> > > > > > drm_plane *plane,
> > > > > >           crtc_state =
> > > > > > drm_atomic_get_new_crtc_state(plane_state->state,
> > > > > > &pipe->crtc);
> > > > > > 
> > > > > > -       if (!crtc_state || !crtc_state->enable)
> > > > > > -               /* nothing to check when disabling or
> > > > > > disabled or no CRTC
> > > > > > set */
> > > > > > -               return 0;
> > > > > > -
> > > > > > -       if (crtc_state->enable)
> > > > > > - drm_mode_get_hv_timing(&crtc_state->mode,
> > > > > > -                                      &clip.x2, &clip.y2);
> > > > > > -
> > > > > >           ret =
> > > > > > drm_atomic_helper_check_plane_state(plane_state,
> > > > > > crtc_state,
> > > > > > &clip,
> > > > > > DRM_PLANE_HELPER_NO_SCALING,
> > > > > > @@ -138,6 +130,13 @@ static int
> > > > > > drm_simple_kms_plane_atomic_check(struct
> > > > > > drm_plane *plane,
> > > > > >           if (ret)
> > > > > >                   return ret;
> > > > > > 
> > > > > > +       if (!plane_state->visible || !crtc_state->enable)
> > > > > > +               return 0; /* nothing to check when
> > > > > > disabling or disabled */
> > > > > if (!plane_state->visible) {
> > > > >     WARN_ON(crtc_state->enabled);
> > > > >     return 0;
> > > > > }
> > > > > 
> > > > > The helper call above should guarantee this.
> > > > Yes, but I still see cases when crtc_state is NULL, thus
> > > > making crtc_state->enable to fail
> > > Right, when the plane is completely off there's no CRTC state. Correct
> > > check should be
> > > 
> > >     WARN_ON(crtc_state && crtc_state->enabled);
> > ok, will update with this additional check
> huh, this indeed solves the NULL pointer dereference, but floods a lot
> with every page flip I have, e.g. !plane_state->visible == true
> and crtc_state is not NULL and crtc_state->enable == true,
> thus firing WARN_ON.
> Is this something wrong with my use-case/driver or it is still legal
> to have such a configuration and leave it without WARN_ON and just
> return 0?

1 week of vacation later I have to admit that this WARN_ON is completely
bogus :-)

Sorry for all the confusion, pls leave it out.
-Daniel

> > > 
> > > > > > +
> > > > > > +       if (plane_state->visible && crtc_state->enable)
> > > > > Similar here.
> > > > > 
> > > > > > + drm_mode_get_hv_timing(&crtc_state->mode,
> > > > > > +                                      &clip.x2, &clip.y2);
> > > > > > +
> > > > > >           if (!plane_state->visible)
> > > > > >                   return -EINVAL;
> > > > > This can now be removed, the plane helper takes care of checking for
> > > > > plane_state->visible != crtc_state->enable. Please also remove.
> > > > > 
> > > > > > > We'd need to add a guarantee to
> > > > > > > drm_atomic_helper_check_plane_state that
> > > > > > > it can cope with crtc_state == NULL, but I think that's a good idea
> > > > > > > anyway. Atm it shouldn't end up looking at the
> > > > > > > crtc_state pointer in that
> > > > > > > case.
> > > > > > It doesn't look at it at the moment
> > > > > > > Otherwise we'll just go with your fix, but it feels
> > > > > > > all a bit too fragile,
> > > > > > > hence why I want to explore more robust options a bit.
> > > > > > At list with the change above it passes my test which failed
> > > > > > before. Although I cannot confirm it works for others, but it
> > > > > > certainly does for me.
> > > > > > > -Daniel
> > > > > > Do you want me to send v1 with the code above?
> > > > > Yes please, with my above cleanup suggestions.
> > > > Please see the patch under test attached (I believe it is what
> > > > you mean,
> > > > with the only change that
> > > >      if (!plane_state->visible) {
> > > >          *if (crtc_state)*
> > > >              WARN_ON(crtc_state->enable);
> > > >          return 0;
> > > >      }
> > > > check is used).
> > > > 
> > > > Whith this patch + additional logs I have:
> > > > 
> > > > [   18.939204] [drm:drm_ioctl [drm]] pid=2105, dev=0xe200, auth=1,
> > > > DRM_IOCTL_MODE_ATOMIC
> > > > [...]
> > > > [   18.939681] [drm:drm_atomic_set_crtc_for_plane [drm]] Link
> > > > plane state
> > > > 00000000c302cbbf to [NOCRTC]
> > > > [   18.939822] [drm:drm_atomic_set_fb_for_plane [drm]] Set
> > > > [NOFB] for plane
> > > > state 00000000c302cbbf
> > > > [   18.939963] [drm:drm_atomic_print_state [drm]] checking
> > > > 000000000bc224e7
> > > > [   18.939988] vdispl vdispl.0: [drm] plane[29]: plane-0
> > > > [   18.940003] vdispl vdispl.0: [drm]   crtc=(null)
> > > > [   18.940018] vdispl vdispl.0: [drm]   fb=0
> > > > [   18.940032] vdispl vdispl.0: [drm]   crtc-pos=0x0+0+0
> > > > [   18.940048] vdispl vdispl.0: [drm]
> > > > src-pos=0.000000x0.000000+0.000000+0.000000
> > > > [   18.940067] vdispl vdispl.0: [drm]   rotation=1
> > > > [   18.940199] [drm:drm_atomic_check_only [drm]] checking
> > > > 000000000bc224e7
> > > > [   18.940226] ================================= plane_state->visible 0
> > > > crtc_state           (null)
> > > > [...]
> > > > [   18.978146] [drm:drm_atomic_set_crtc_for_plane [drm]] Link
> > > > plane state
> > > > 000000006bd50580 to [CRTC:30:crtc-0]
> > > > [   18.978292] [drm:drm_atomic_set_fb_for_plane [drm]] Set
> > > > [FB:35] for plane
> > > > state 000000006bd50580
> > > > [   18.978993] [drm:drm_atomic_set_mode_prop_for_crtc [drm]] Set
> > > > [MODE:1024x768] for CRTC state 00000000e5a28f6a
> > > > [   18.979425] [drm:drm_atomic_check_only [drm]] checking
> > > > 000000000bc224e7
> > > > [   18.979540] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > [CRTC:30:crtc-0] mode changed
> > > > [   18.979632] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > [CRTC:30:crtc-0] enable changed
> > > > [   18.979708] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > [CRTC:30:crtc-0] active changed
> > > > [   18.979792] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > Updating routing for [CONNECTOR:28:Virtual-1]
> > > > [   18.979877] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > [CONNECTOR:28:Virtual-1] using [ENCODER:31:None-31] on [CRTC:30:crtc-0]
> > > > [   18.979960] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]]
> > > > [CRTC:30:crtc-0] needs all connectors, enable: y, active: y
> > > > [   18.980139] [drm:drm_atomic_add_affected_connectors [drm]]
> > > > Adding all
> > > > current connectors for [CRTC:30:crtc-0] to 000000000bc224e7
> > > > [   18.980184] ================================= plane_state->visible 0
> > > > crtc_state 00000000e5a28f6a
> > > > [   18.980205] crtc_state->enable 1
> > > > 
> > > > *[   19.022608] WARNING: CPU: 1 PID: 2105 at
> > > > drivers/gpu/drm/drm_simple_kms_helper.c:137
> > > > drm_simple_kms_plane_atomic_check+0xdc/0xf8 [drm_kms_helper]*
> > > > 
> > > > [...]
> > > > 
> > > > [   19.113601] ================================= plane_state->visible 0
> > > > crtc_state 00000000e5a28f6a
> > > > [   19.113623] crtc_state->enable 1
> > > > [   19.113792] WARNING: CPU: 1 PID: 2105 at
> > > > drivers/gpu/drm/drm_simple_kms_helper.c:137
> > > > drm_simple_kms_plane_atomic_check+0xdc/0xf8 [drm_kms_helper]
> > > > 
> > > > [...]
> > > > 
> > > > And finally
> > > > 
> > > > [   19.340249] ================================= plane_state->visible 0
> > > > crtc_state 0000000036a1b1f5
> > > > [   19.340271] crtc_state->enable 0
> > > > 
> > > > So, it seems that crtc_state can still be NULL if
> > > > "!plane_state->visible"
> > > > making
> > > > NULL pointer dereference, so we need a check for that.
> > > > Yet, !plane_state->visible && crtc_state->enable makes WARN_ON to fire
> > > > always. So, probably we may want removing it.
> > > > > Thanks, Daniel
> > > > Thank you,
> > > > Oleksandr
> > > >  From dbcce708b237740158a2c16029c56a579324f269 Mon Sep 17 00:00:00 2001
> > > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > Date: Tue, 13 Feb 2018 10:32:20 +0200
> > > > Subject: [PATCH] drm/simple_kms_helper: Fix NULL pointer
> > > > dereference with no
> > > >   active CRTC
> > > > 
> > > > It is possible that drm_simple_kms_plane_atomic_check called
> > > > with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
> > > > to 0 before doing any actual drawing. This leads to NULL pointer
> > > > dereference because in this case new CRTC state is NULL and must be
> > > > checked before accessing.
> > > > 
> > > > Signed-off-by: Oleksandr Andrushchenko
> > > > <oleksandr_andrushchenko@epam.com>
> > > > ---
> > > >   drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++--------
> > > >   1 file changed, 7 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > index 9ca8a4a59b74..f54711ff9767 100644
> > > > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > > @@ -121,12 +121,6 @@ static int
> > > > drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
> > > >       pipe = container_of(plane, struct drm_simple_display_pipe,
> > > > plane);
> > > >       crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> > > >                              &pipe->crtc);
> > > > -    if (!crtc_state->enable)
> > > > -        return 0; /* nothing to check when disabling or disabled */
> > > > -
> > > > -    if (crtc_state->enable)
> > > > -        drm_mode_get_hv_timing(&crtc_state->mode,
> > > > -                       &clip.x2, &clip.y2);
> > > >         ret = drm_atomic_helper_check_plane_state(plane_state,
> > > > crtc_state,
> > > >                             &clip,
> > > > @@ -136,8 +130,13 @@ static int
> > > > drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
> > > >       if (ret)
> > > >           return ret;
> > > >   -    if (!plane_state->visible)
> > > > -        return -EINVAL;
> > > > +    if (!plane_state->visible) {
> > > > +        if (crtc_state)
> > > > +            WARN_ON(crtc_state->enable);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    drm_mode_get_hv_timing(&crtc_state->mode, &clip.x2, &clip.y2);
> > > lgtm. With or without the bikeshed to pull the crtc_state check into the
> > > WARN_ON.
> > > 
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Thank you
> > > 
> > > Please resubmit as a stand-alone patch, patchwork can't pull patches out
> > > of attachments :-/
> > oh, that was for demonstration purpose only, so we
> > are on the same page and see the patch we are discussing ;)
> > > -Daniel
> > > 
> > > >         if (!pipe->funcs || !pipe->funcs->check)
> > > >           return 0;
> > > > -- 
> > > > 2.7.4
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > 
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

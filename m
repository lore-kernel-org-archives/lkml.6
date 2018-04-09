Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeDIIi7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:38:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeDIIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:38:58 -0400
X-Google-Smtp-Source: AIpwx4+XDjUDEa3BNLKqtfIHIhtZZ5vuaREy5z2LQzdnz7cA4fIXho6Uzi7UHUT9rlqHszmIA/QbbQ==
Date: Mon, 9 Apr 2018 10:38:53 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Deepak Singh Rawat <drawat@vmware.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/3] drm: Add helper to validate damage during modeset_check
Message-ID: <20180409083853.GO31310@phenom.ffwll.local>
Mail-Followup-To: Deepak Singh Rawat <drawat@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-4-git-send-email-drawat@vmware.com>
 <20180405075929.GR3881@phenom.ffwll.local>
 <MWHPR05MB3117BE16BBCC51D394185510BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR05MB3117BE16BBCC51D394185510BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 11:55:29PM +0000, Deepak Singh Rawat wrote:
> > 
> > On Wed, Apr 04, 2018 at 04:49:08PM -0700, Deepak Rawat wrote:
> > > This patch adds a helper which should be called by driver which enable
> > > damage (by calling drm_plane_enable_damage_clips) from atomic_check
> > > hook. This helper for now set the damage to NULL for the planes on crtc
> > > which need full modeset.
> > >
> > > The driver also need to check for other crtc properties which can
> > > affect damage in atomic_check hook, like gamma, ctm, etc. Plane related
> > > properties which affect damage can be handled in damage iterator.
> > >
> > > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 47
> > +++++++++++++++++++++++++++++++++++++
> > >  include/drm/drm_atomic_helper.h     |  2 ++
> > >  2 files changed, 49 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > b/drivers/gpu/drm/drm_atomic_helper.c
> > > index 355b514..23f44ab 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -3987,3 +3987,50 @@ drm_atomic_helper_damage_iter_next(struct
> > drm_atomic_helper_damage_iter *iter,
> > >  	return true;
> > >  }
> > >  EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
> > > +
> > > +/**
> > > + * drm_atomic_helper_check_damage - validate state object for damage
> > changes
> > > + * @dev: DRM device
> > > + * @state: the driver state object
> > > + *
> > > + * Check the state object if damage is required or not. In case damage is
> > not
> > > + * required e.g. need modeset, the damage blob is set to NULL.
> > 
> > Why is that needed?
> > 
> > I can imagine that drivers unconditionally upload everything for a
> > modeset, and hence don't need special damage tracking. But for that it's
> > imo better to have a clear_damage() helper.
> 
> Don't we need a generic helper which all drivers can use to see if anything
> in drm_atomic_state will result in full update? My intention for calling that
> function from atomic_check hook was because state access can
> return -EDEADLK.
> 
> I think for now having drm_damage_helper_clear_damage helper and 
> calling it from atomic_check seems better option. In future once I have
> clear idea, a generic function can be done.

Yeah, if some of the future helpers need to e.g. allocate memory, then we
need to do any necessary prep steps from ->atomic_check.

But this isn't just prep, it clears stuff, so giving it a name that
indicates better what it does seems like a good idea to me. Just make it
clear that this should be called from ->atomic_check callbacks.

> > But even for modesets (e.g. resolution changes) I'd expect that virtual
> > drivers don't want to upload unecessary amounts of data. Manual upload
> > hw drivers probably need to upload everything, because the panel will have
> > forgotten all the old data once power cycled.
> 
> AFAIK current vmwgfx will do full upload for resolution change.
> 
> > 
> > And if you think this is really the right thing, then we need to rename
> > the function to tell what it does, e.g.
> > 
> > drm_damage_helper_clear_damage_on_modeset()
> > 
> > drm_damage_helper because I think we should stuff this all into
> > drm_damage_helper.c, see previous patch.
> > 
> > But I think a
> > 
> > drm_damage_helper_clear_damage(crtc_state)
> > 
> > which you can use in your crtc->atomic_check function like
> > 
> > crtc_atomic_check(state)
> > {
> > 	if (drm_atomic_crtc_needs_modeset(state))
> > 		drm_damage_helper_clear_damage(state);
> > }
> > 
> > is more flexible and useful for drivers. There might be other cases where
> > clearing damage is the right thing to do. Also, there's the question of
> > whether no damage clips == full damage or not, so maybe we should call
> > this helper full_damage() instead.
> 
> In my opinion if via proper documentation it is conveyed that no damage
> means full-update the clear_damage makes sense.

Documentation is the worst documentation. Function names, or just outright
implemented behaviour is much better (e.g. runtime checks). For full
damage if there's no clip rect I think the iterator should implement that
for us.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

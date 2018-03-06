Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbeCFH32 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:29:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34220 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:29:25 -0500
X-Google-Smtp-Source: AG47ELtt2PfEL5txE6C+uNFWZ1zmV1tZdWk+aOJvtB4G1FCNr1BG+n0acPfs3HK/l3TdmMVVsq711w==
Date: Tue, 6 Mar 2018 08:29:20 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/4] drm/atomic: integrate modeset lock with private
 objects
Message-ID: <20180306072920.GR22212@phenom.ffwll.local>
Mail-Followup-To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20180221143730.30285-1-robdclark@gmail.com>
 <20180221143730.30285-2-robdclark@gmail.com>
 <d159d04e-8e92-eb03-c65a-f625021b8f9f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d159d04e-8e92-eb03-c65a-f625021b8f9f@linux.intel.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 04:19:40PM +0100, Maarten Lankhorst wrote:
> Hey,
> 
> Op 21-02-18 om 15:37 schreef Rob Clark:
> > Follow the same pattern of locking as with other state objects.  This
> > avoids boilerplate in the driver.
> I'm afraid this will prohibit any uses of this on i915, since it still uses legacy lock_all().
> 
> Oh well, afaict nothing in i915 uses private objects, so I don't think it's harmful. :)

We do use private objects, as part of dp mst helpers. But I also thought
that the only users left of lock_all are in the debugfs code, where this
really doesn't matter all that much.

> Could you cc intel-gfx just in case?

Yeah, best to double-check with CI.

> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_atomic.c | 9 ++++++++-
> >  include/drm/drm_atomic.h     | 5 +++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index fc8c4da409ff..004e621ab307 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -1078,6 +1078,8 @@ drm_atomic_private_obj_init(struct drm_private_obj *obj,
> >  {
> >  	memset(obj, 0, sizeof(*obj));
> >  
> > +	drm_modeset_lock_init(&obj->lock);
> > +
> >  	obj->state = state;
> >  	obj->funcs = funcs;
> >  }
> > @@ -1093,6 +1095,7 @@ void
> >  drm_atomic_private_obj_fini(struct drm_private_obj *obj)
> >  {
> >  	obj->funcs->atomic_destroy_state(obj, obj->state);
> > +	drm_modeset_lock_fini(&obj->lock);
> >  }
> >  EXPORT_SYMBOL(drm_atomic_private_obj_fini);
> >  
> > @@ -1113,7 +1116,7 @@ struct drm_private_state *
> >  drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> >  				 struct drm_private_obj *obj)
> >  {
> > -	int index, num_objs, i;
> > +	int index, num_objs, i, ret;
> >  	size_t size;
> >  	struct __drm_private_objs_state *arr;
> >  	struct drm_private_state *obj_state;
> > @@ -1122,6 +1125,10 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> >  		if (obj == state->private_objs[i].ptr)
> >  			return state->private_objs[i].state;
> >  
> > +	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> >  	num_objs = state->num_private_objs + 1;
> >  	size = sizeof(*state->private_objs) * num_objs;
> >  	arr = krealloc(state->private_objs, size, GFP_KERNEL);
> > diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> > index 09076a625637..9ae53b73c9d2 100644
> > --- a/include/drm/drm_atomic.h
> > +++ b/include/drm/drm_atomic.h
> > @@ -218,6 +218,11 @@ struct drm_private_state_funcs {
> >   * &drm_modeset_lock is required to duplicate and update this object's state.
> >   */
> >  struct drm_private_obj {
> > +	/**
> > +	 * @lock: Modeset lock to protect the state object.
> > +	 */
> > +	struct drm_modeset_lock lock;
> > +
> >  	/**
> >  	 * @state: Current atomic state for this driver private object.
> >  	 */
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

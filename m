Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeCFKNh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:13:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53162 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCFKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:13:35 -0500
X-Google-Smtp-Source: AG47ELstWQ2iUCqLeBp2MsCa9ITTqKrJ/aAIr+Y6gKc/6VcA0vNVP3hK1bpIrGHHDb8YRXUDQ9/YxA==
Date: Tue, 6 Mar 2018 11:13:31 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/drm_ioctl.c: Test client capability value early when
 setting.
Message-ID: <20180306101331.GD22212@phenom.ffwll.local>
Mail-Followup-To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180228152741.22507-1-Liviu.Dudau@arm.com>
 <20180228154041.GK5453@intel.com>
 <20180228154444.GA20827@e110455-lin.cambridge.arm.com>
 <20180228155715.GL5453@intel.com>
 <20180228163430.GB20827@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228163430.GB20827@e110455-lin.cambridge.arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 04:34:30PM +0000, Liviu Dudau wrote:
> On Wed, Feb 28, 2018 at 05:57:15PM +0200, Ville Syrjälä wrote:
> > On Wed, Feb 28, 2018 at 03:44:44PM +0000, Liviu Dudau wrote:
> > > On Wed, Feb 28, 2018 at 05:40:41PM +0200, Ville Syrjälä wrote:
> > > > On Wed, Feb 28, 2018 at 03:27:41PM +0000, Liviu Dudau wrote:
> > > > > The drm_setclientcap() function implementing the DRM_IOCTL_SET_CLIENT_CAP
> > > > > ioctl expects that any capability set by the client will have a value of 1.
> > > > > Make the check early so that we don't have to test the value for each
> > > > > capability.
> > > > 
> > > > What if we want a a non-boolean capability at some point?
> > > 
> > > Well, I'm adding another boolean capability soon, so you will be going
> > > against the trend :)
> > 
> > Plenty of non-bools in driver specific counterparts I believe.
> 
> So, is that a NACK? 

Yeah I think this is overoptimizing for not repeating code.
-Daniel

> 
> 
> > 
> > > I guess you will have 2 options: revert the patch or add a condition to
> > > the test.
> > > 
> > > I don't have strong feelings, just felt like too much copying when
> > > adding another capability so I thought to do some "cleanup".
> > > 
> > > Best regards,
> > > Liviu
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_ioctl.c | 9 +++------
> > > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > > > > index af782911c505..02ffa0e8d77b 100644
> > > > > --- a/drivers/gpu/drm/drm_ioctl.c
> > > > > +++ b/drivers/gpu/drm/drm_ioctl.c
> > > > > @@ -306,22 +306,19 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
> > > > >  {
> > > > >  	struct drm_set_client_cap *req = data;
> > > > >  
> > > > > +	if (req->value > 1)
> > > > > +		return -EINVAL;
> > > > > +
> > > > >  	switch (req->capability) {
> > > > >  	case DRM_CLIENT_CAP_STEREO_3D:
> > > > > -		if (req->value > 1)
> > > > > -			return -EINVAL;
> > > > >  		file_priv->stereo_allowed = req->value;
> > > > >  		break;
> > > > >  	case DRM_CLIENT_CAP_UNIVERSAL_PLANES:
> > > > > -		if (req->value > 1)
> > > > > -			return -EINVAL;
> > > > >  		file_priv->universal_planes = req->value;
> > > > >  		break;
> > > > >  	case DRM_CLIENT_CAP_ATOMIC:
> > > > >  		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> > > > >  			return -EINVAL;
> > > > > -		if (req->value > 1)
> > > > > -			return -EINVAL;
> > > > >  		file_priv->atomic = req->value;
> > > > >  		file_priv->universal_planes = req->value;
> > > > >  		break;
> > > > > -- 
> > > > > 2.16.2
> > > > > 
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > 
> > > > -- 
> > > > Ville Syrjälä
> > > > Intel OTC
> > > 
> > > -- 
> > > ====================
> > > | I would like to |
> > > | fix the world,  |
> > > | but they're not |
> > > | giving me the   |
> > >  \ source code!  /
> > >   ---------------
> > >     ¯\_(ツ)_/¯
> > 
> > -- 
> > Ville Syrjälä
> > Intel OTC
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

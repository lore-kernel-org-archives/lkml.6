Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935810AbeEXHu0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:50:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36448 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935502AbeEXHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:50:24 -0400
X-Google-Smtp-Source: AB8JxZrE3pUDbhjQPtZH29Grdvrz6uYlBC8XrvSAfHv0dDOU3zHNQnQ9KJ0URycisR+LJZrtKvuwSg==
Date: Thu, 24 May 2018 09:50:20 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 3/3] drm: writeback: Add client capability for
 exposing writeback connectors
Message-ID: <20180524075020.GZ3438@phenom.ffwll.local>
Mail-Followup-To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180518151743.29937-1-Liviu.Dudau@arm.com>
 <20180518151743.29937-4-Liviu.Dudau@arm.com>
 <7d0201a9-8eed-f332-b6cb-241560cd05c4@linux.intel.com>
 <20180523122716.GF1582@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523122716.GF1582@e110455-lin.cambridge.arm.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 01:27:17PM +0100, Liviu Dudau wrote:
> On Wed, May 23, 2018 at 11:34:32AM +0200, Maarten Lankhorst wrote:
> > Op 18-05-18 om 17:17 schreef Liviu Dudau:
> > > Due to the fact that writeback connectors behave in a special way
> > > in DRM (they always report being disconnected) we might confuse some
> > > userspace. Add a client capability for writeback connectors that will
> > > filter them out for clients that don't understand the capability.
> > >
> > > Re-requested-by: Sean Paul <seanpaul@chromium.org>
> > > Cc: Brian Starkey <brian.starkey@arm.com>
> > > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > > ---
> > >  drivers/gpu/drm/drm_ioctl.c       | 7 +++++++
> > >  drivers/gpu/drm/drm_mode_config.c | 5 +++++
> > >  include/drm/drm_file.h            | 7 +++++++
> > >  include/uapi/drm/drm.h            | 9 +++++++++
> > >  4 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > > index af782911c505d..59951ff3e3630 100644
> > > --- a/drivers/gpu/drm/drm_ioctl.c
> > > +++ b/drivers/gpu/drm/drm_ioctl.c
> > > @@ -325,6 +325,13 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
> > >  		file_priv->atomic = req->value;
> > >  		file_priv->universal_planes = req->value;
> > >  		break;
> > > +	case DRM_CLIENT_CAP_WRITEBACK_CONNECTORS:
> > > +		if (!file_priv->atomic || !drm_core_check_feature(dev, DRIVER_ATOMIC))
> > > +			return -EINVAL;
> > Wondering how you can set the atomic cap without DRIVER_ATOMIC. :)
> 
> Caps can only be set one at a time. I was trying to cater for the cases
> where userspace can set the WRITEBACK_CONNECTORS client cap before or
> after setting the atomic cap.

The way we usually solve this is that if there's a dependency in caps, we
set them all. E.g. atomic above also sets universal planes. I recommend we
do the same for writeback.

> > That part could be dropped I think. We should probably WARN when trying to create a writeback connector without the DRIVER_ATOMIC cap set.
> 
> I could still keep the check for file_priv->atomic being set when
> accepting the DRM_CLIENT_CAP_WRITEBACK_CONNECTORS and would not need a
> warn.

Or this.
-Daniel

> 
> Best regards,
> Liviu
> 
> > > +		if (req->value > 1)
> > > +			return -EINVAL;
> > > +		file_priv->writeback_connectors = req->value;
> > > +		break;
> > >  	default:
> > >  		return -EINVAL;
> > >  	}
> > > diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> > > index e5c653357024d..21e353bd3948e 100644
> > > --- a/drivers/gpu/drm/drm_mode_config.c
> > > +++ b/drivers/gpu/drm/drm_mode_config.c
> > > @@ -145,6 +145,11 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
> > >  	count = 0;
> > >  	connector_id = u64_to_user_ptr(card_res->connector_id_ptr);
> > >  	drm_for_each_connector_iter(connector, &conn_iter) {
> > > +		/* only expose writeback connectors if userspace understands them */
> > > +		if (!file_priv->writeback_connectors &&
> > > +		    (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK))
> > > +			continue;
> > > +
> > >  		if (drm_lease_held(file_priv, connector->base.id)) {
> > >  			if (count < card_res->count_connectors &&
> > >  			    put_user(connector->base.id, connector_id + count)) {
> > > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > > index 5176c3797680c..2a09b3c8965c6 100644
> > > --- a/include/drm/drm_file.h
> > > +++ b/include/drm/drm_file.h
> > > @@ -181,6 +181,13 @@ struct drm_file {
> > >  	/** @atomic: True if client understands atomic properties. */
> > >  	unsigned atomic:1;
> > >  
> > > +	/**
> > > +	 * @writeback_connectors:
> > > +	 *
> > > +	 * True if client understands writeback connectors
> > > +	 */
> > > +	unsigned writeback_connectors:1;
> > > +
> > >  	/**
> > >  	 * @is_master:
> > >  	 *
> > > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > index 6fdff5945c8a0..59f27ea928b42 100644
> > > --- a/include/uapi/drm/drm.h
> > > +++ b/include/uapi/drm/drm.h
> > > @@ -680,6 +680,15 @@ struct drm_get_cap {
> > >   */
> > >  #define DRM_CLIENT_CAP_ATOMIC	3
> > >  
> > > +/**
> > > + * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
> > > + *
> > > + * If set to 1, the DRM core will expose special connectors to be used for
> > > + * writing back to memory the scene setup in the commit. Depends on client
> > > + * also supporting DRM_CLIENT_CAP_ATOMIC
> > > + */
> > > +#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	4
> > > +
> > >  /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
> > >  struct drm_set_client_cap {
> > >  	__u64 capability;
> > 
> > ~Maarten
> > 
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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

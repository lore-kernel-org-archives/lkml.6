Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeB1Pkr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:40:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:47952 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbeB1Pkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:40:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="34814127"
Date: Wed, 28 Feb 2018 17:40:41 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: DRI-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/drm_ioctl.c: Test client capability value early when
 setting.
Message-ID: <20180228154041.GK5453@intel.com>
References: <20180228152741.22507-1-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228152741.22507-1-Liviu.Dudau@arm.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 03:27:41PM +0000, Liviu Dudau wrote:
> The drm_setclientcap() function implementing the DRM_IOCTL_SET_CLIENT_CAP
> ioctl expects that any capability set by the client will have a value of 1.
> Make the check early so that we don't have to test the value for each
> capability.

What if we want a a non-boolean capability at some point?

> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/drm_ioctl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index af782911c505..02ffa0e8d77b 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -306,22 +306,19 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  {
>  	struct drm_set_client_cap *req = data;
>  
> +	if (req->value > 1)
> +		return -EINVAL;
> +
>  	switch (req->capability) {
>  	case DRM_CLIENT_CAP_STEREO_3D:
> -		if (req->value > 1)
> -			return -EINVAL;
>  		file_priv->stereo_allowed = req->value;
>  		break;
>  	case DRM_CLIENT_CAP_UNIVERSAL_PLANES:
> -		if (req->value > 1)
> -			return -EINVAL;
>  		file_priv->universal_planes = req->value;
>  		break;
>  	case DRM_CLIENT_CAP_ATOMIC:
>  		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
>  			return -EINVAL;
> -		if (req->value > 1)
> -			return -EINVAL;
>  		file_priv->atomic = req->value;
>  		file_priv->universal_planes = req->value;
>  		break;
> -- 
> 2.16.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel OTC

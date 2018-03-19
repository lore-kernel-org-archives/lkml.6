Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935451AbeCSQdl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:33:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:43291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933942AbeCSQdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:33:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="26995092"
Date: Mon, 19 Mar 2018 18:33:33 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: Trust format_mod_supported() when it OKs a
 plane modifier.
Message-ID: <20180319163333.GO5453@intel.com>
References: <20180316220435.31416-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316220435.31416-1-eric@anholt.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 03:04:33PM -0700, Eric Anholt wrote:
> For parameterized modifiers (Broadcom's SAND and UIF), we need to
> allow the parameter fields to be filled in, while exposing only the
> variant of the modifier with the parameter unfilled in the internal
> arrays and the format blob.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 23 ++++++++++++-----------
>  include/drm/drm_plane.h     |  5 ++++-
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 46fbd019a337..5bb501f1aae8 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -561,19 +561,20 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
>  	if (i == plane->format_count)
>  		return -EINVAL;
>  
> -	if (!plane->modifier_count)
> -		return 0;
> +	if (plane->funcs->format_mod_supported) {
> +		if (!plane->funcs->format_mod_supported(plane, format, modifier))
> +			return -EINVAL;
> +	} else {
> +		if (!plane->modifier_count)
> +			return 0;
>  
> -	for (i = 0; i < plane->modifier_count; i++) {
> -		if (modifier == plane->modifiers[i])
> -			break;
> +		for (i = 0; i < plane->modifier_count; i++) {
> +			if (modifier == plane->modifiers[i])
> +				break;
> +		}
> +		if (i == plane->modifier_count)
> +			return -EINVAL;
>  	}
> -	if (i == plane->modifier_count)
> -		return -EINVAL;
> -
> -	if (plane->funcs->format_mod_supported &&
> -	    !plane->funcs->format_mod_supported(plane, format, modifier))
> -		return -EINVAL;
>  
>  	return 0;
>  }
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index f7bf4a48b1c3..6b1b51645f75 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -420,7 +420,10 @@ struct drm_plane_funcs {
>  	 * This optional hook is used for the DRM to determine if the given
>  	 * format/modifier combination is valid for the plane. This allows the
>  	 * DRM to generate the correct format bitmask (which formats apply to
> -	 * which modifier).
> +	 * which modifier), and to valdiate modifiers at atomic_check time.
> +	 *
> +	 * If not present, then any modifier in the plane's modifier
> +	 * list is allowed with any of the plane's formats.

This certainly avoids the vfunc profileration that using the
modifiers list causes. So yeah I do like it from that angle.

It does promote .format_mod_supported() to a more prominent role. My
original idea for .format_mod_supported() was that it could be very
lightweight; just reject the exceptional cases and assume everything
else is fine. With the change of role I think the docs should make it
very clear that _any_ modifier can be passed to this function directly
from userspace. The driver must handle that gracefully and without
spewing any non-debug stuff to dmesg.

Also I definitely need to change i915. Currently we're using the
modifier list as the primary means by which we filter out unsupported
modifiers for planes, and .format_mod_support() just serves an
supporting role further removing any format+mod combination that isn't
valid. So I need to make .format_mod_supported() the lead actor here
and the modifier list just serves as a starting point which we filter
down to something we can report via the IN_FORMATS blobifier.

Hmm. And now the question becomes should we make .format_mod_supported()
take over the role of validating the pixel format as well from the
plane's format list? It would certainly be more in line with the
approach we're now going to take with modifiers.

-- 
Ville Syrjälä
Intel OTC

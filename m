Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeCSOOT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:14:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:33747 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933518AbeCSOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:14:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="26942444"
Date: Mon, 19 Mar 2018 16:14:07 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20180319141407.GM5453@intel.com>
References: <20180319122929.2ac3dfd8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319122929.2ac3dfd8@canb.auug.org.au>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:29:29PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-misc tree got a conflict in:
> 
>   drivers/gpu/drm/i915/intel_color.c
> 
> between commit:
> 
>   db61d160b3ed ("drm/i915: Remove the pointless 1:1 matrix copy")
> 
> from the drm tree and commit:
> 
>   d5517a39dce4 ("drm/i915: Remove the blob->data casts")
> 
> from the drm-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/gpu/drm/i915/intel_color.c
> index 89ab0f70aa22,768f1c26080e..000000000000
> --- a/drivers/gpu/drm/i915/intel_color.c
> +++ b/drivers/gpu/drm/i915/intel_color.c
> @@@ -140,28 -140,20 +140,27 @@@ static void ilk_load_csc_matrix(struct 
>   	int i, pipe = intel_crtc->pipe;
>   	uint16_t coeffs[9] = { 0, };
>   	struct intel_crtc_state *intel_crtc_state = to_intel_crtc_state(crtc_state);
>  +	bool limited_color_range = false;
>  +
>  +	/*
>  +	 * FIXME if there's a gamma LUT after the CSC, we should
>  +	 * do the range compression using the gamma LUT instead.
>  +	 */
>  +	if (INTEL_GEN(dev_priv) >= 8 || IS_HASWELL(dev_priv))
>  +		limited_color_range = intel_crtc_state->limited_color_range;
>   
>   	if (intel_crtc_state->ycbcr420) {
>  -		i9xx_load_ycbcr_conversion_matrix(intel_crtc);
>  +		ilk_load_ycbcr_conversion_matrix(intel_crtc);
>   		return;
>   	} else if (crtc_state->ctm) {
> - 		struct drm_color_ctm *ctm =
> - 			(struct drm_color_ctm *)crtc_state->ctm->data;
> + 		struct drm_color_ctm *ctm = crtc_state->ctm->data;
>  -		uint64_t input[9] = { 0, };
>  +		const u64 *input;
>  +		u64 temp[9];

Yep. Looks correct.

>   
>  -		if (intel_crtc_state->limited_color_range) {
>  -			ctm_mult_by_limited(input, ctm->matrix);
>  -		} else {
>  -			for (i = 0; i < ARRAY_SIZE(input); i++)
>  -				input[i] = ctm->matrix[i];
>  -		}
>  +		if (limited_color_range)
>  +			input = ctm_mult_by_limited(temp, ctm->matrix);
>  +		else
>  +			input = ctm->matrix;
>   
>   		/*
>   		 * Convert fixed point S31.32 input to format supported by the

-- 
Ville Syrjälä
Intel OTC

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC22089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEC22089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbeG0LMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:12:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:46358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731077AbeG0LMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:12:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 02:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="243799198"
Received: from eberhars-mobl1.ger.corp.intel.com (HELO [10.252.50.199]) ([10.252.50.199])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2018 02:51:28 -0700
Subject: Re: [PATCH] drm/kms/atomic: Used existing func for checking fb
 geometry
To:     Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
References: <CGME20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41@epcas5p3.samsung.com>
 <20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41~FLPg9mkWQ2043620436epcas5p3U@epcas5p3.samsung.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <0fe3bbc5-d10b-7c95-e77d-f4cd5ee6016b@linux.intel.com>
Date:   Fri, 27 Jul 2018 11:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727083812epcas5p39f97180e85def2b4b4c1b68af2e83b41~FLPg9mkWQ2043620436epcas5p3U@epcas5p3.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 27-07-18 om 10:38 schreef Satendra Singh Thakur:
> 1.In the func drm_atomic_plane_check, the fb geometry checking code
> can be replaced by func drm_framebuffer_check_src_coords, this will
> remove several redundant lines of code.
> 2. Currently, in the func drm_atomic_plane_check;
> there are 3 if statements in the beginning with total 5 conditions.
> these conditions are
> crtc is NULL but fb is non-NULL
> if (state->crtc && !state->fb)
> crtc is non-NULL but fb is NULL
> if (state->fb && !state->crtc)
> crtc is NULL (and fb is also NULL)
> if (!state->crtc)
>
> The same code can be re-written using 2 if statements and 4 conditions.
> first we check whether crtc and fb both are NULL
> if (!state->crtc && !state->fb)
> then we check either crtc or fb is NULL
> if (!state->crtc || !state->fb)
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 895741e..1cddab8 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -909,22 +909,16 @@ plane_switching_crtc(struct drm_atomic_state *state,
>  static int drm_atomic_plane_check(struct drm_plane *plane,
>  		struct drm_plane_state *state)
>  {
> -	unsigned int fb_width, fb_height;
>  	int ret;
>  
> -	/* either *both* CRTC and FB must be set, or neither */
> -	if (state->crtc && !state->fb) {
> -		DRM_DEBUG_ATOMIC("CRTC set but no FB\n");
> -		return -EINVAL;
> -	} else if (state->fb && !state->crtc) {
> -		DRM_DEBUG_ATOMIC("FB set but no CRTC\n");
> -		return -EINVAL;
> -	}
> -
>  	/* if disabled, we don't care about the rest of the state: */
> -	if (!state->crtc)
> +	if (!state->crtc && !state->fb)
>  		return 0;
> -
> +	/* both CRTC and FB must be set*/
> +	if (!state->crtc || !state->fb) {
> +		DRM_DEBUG_ATOMIC("Either no CRTC or no FB\n");
> +		return -EINVAL;
> +	}
>  	/* Check whether this plane is usable on this CRTC */
>  	if (!(plane->possible_crtcs & drm_crtc_mask(state->crtc))) {
>  		DRM_DEBUG_ATOMIC("Invalid crtc for plane\n");
This should be a separate patch?
> @@ -954,24 +948,11 @@ static int drm_atomic_plane_check(struct drm_plane *plane,
>  		return -ERANGE;
>  	}
>  
> -	fb_width = state->fb->width << 16;
> -	fb_height = state->fb->height << 16;
> -
>  	/* Make sure source coordinates are inside the fb. */
> -	if (state->src_w > fb_width ||
> -	    state->src_x > fb_width - state->src_w ||
> -	    state->src_h > fb_height ||
> -	    state->src_y > fb_height - state->src_h) {
> -		DRM_DEBUG_ATOMIC("Invalid source coordinates "
> -				 "%u.%06ux%u.%06u+%u.%06u+%u.%06u (fb %ux%u)\n",
> -				 state->src_w >> 16, ((state->src_w & 0xffff) * 15625) >> 10,
> -				 state->src_h >> 16, ((state->src_h & 0xffff) * 15625) >> 10,
> -				 state->src_x >> 16, ((state->src_x & 0xffff) * 15625) >> 10,
> -				 state->src_y >> 16, ((state->src_y & 0xffff) * 15625) >> 10,
> -				 state->fb->width, state->fb->height);
> +	ret = drm_framebuffer_check_src_coords(state->src_x, state->src_y,
> +		state->src_w, state->src_h, state->fb);
> +	if (ret)
>  		return -ENOSPC;
Change this to return ret, no need to swallow errors. :)
> -	}
> -
>  	if (plane_switching_crtc(state->state, plane, state)) {
>  		DRM_DEBUG_ATOMIC("[PLANE:%d:%s] switching CRTC directly\n",
>  				 plane->base.id, plane->name);



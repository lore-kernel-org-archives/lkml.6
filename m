Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECJZE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:25:04 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35827 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeECJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:25:02 -0400
X-Google-Smtp-Source: AB8JxZrMfMlHEHNutKVnIX13OaSE773F5wIBRzGUlRA6Ykl9tf8FajH8bAxpw/rlIonZofHHTcHWXQ==
Date: Thu, 3 May 2018 11:24:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>
Subject: Re: [PATCH] drm/atomic: Handling the case when setting old crtc for
 plane
Message-ID: <20180503092458.GH12521@phenom.ffwll.local>
Mail-Followup-To: Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hemanshu Srivastava <hemanshu.s@samsung.com>,
        Madhur Verma <madhur.verma@samsung.com>
References: <CGME20180503055008epcas5p2e98aff943c031a90a14df1a85e359d6c@epcas5p2.samsung.com>
 <1525326572-25854-1-git-send-email-satendra.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525326572-25854-1-git-send-email-satendra.t@samsung.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 11:19:32AM +0530, Satendra Singh Thakur wrote:
> In the func drm_atomic_set_crtc_for_plane, with the current code,
> if crtc of the plane_state and crtc passed as argument to the func
> are same, entire func will executed in vein.
> It will get state of crtc and clear and set the bits in plane_mask.
> All these steps are not required for same old crtc.
> Ideally, we should do nothing in this case, this patch handles the same,
> and causes the program to return without doing anything in such scenario.
> 
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7d25c42..5bd3365 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1421,7 +1421,9 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
>  {
>  	struct drm_plane *plane = plane_state->plane;
>  	struct drm_crtc_state *crtc_state;
> -
> +	/* Nothing to do for same crtc*/
> +	if (plane_state->crtc == crtc)
> +		return 0;

I didn't do this (both here and in the set_crtc_for_connector functions)
because the overhead is probably way down in the noise compared to the
overall atomic commit machinery. Do you really see this as a hotpath?
-Daniel

>  	if (plane_state->crtc) {
>  		crtc_state = drm_atomic_get_crtc_state(plane_state->state,
>  						       plane_state->crtc);
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

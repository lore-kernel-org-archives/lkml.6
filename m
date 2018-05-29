Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeE2GqV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:46:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50360 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2GqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:46:20 -0400
X-Google-Smtp-Source: AB8JxZrjBcBi9WbppK7sIUUXTSJg9rZG9ni3L57sJ7o7dlvQu+q6yZPtcE+E11R5wF3qm8KlMyzceg==
Date: Tue, 29 May 2018 08:46:16 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Emil Lundmark <lndmrk@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin
        <stephane.marchesin@gmail.com>
Subject: Re: [PATCH v2] drm: udl: Destroy framebuffer only if it was
 initialized
Message-ID: <20180529064616.GS3438@phenom.ffwll.local>
Mail-Followup-To: Emil Lundmark <lndmrk@chromium.org>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <stephane.marchesin@gmail.com>
References: <20180420115001.161745-1-lndmrk@chromium.org>
 <20180528142711.142466-1-lndmrk@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180528142711.142466-1-lndmrk@chromium.org>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 04:27:11PM +0200, Emil Lundmark wrote:
> This fixes a NULL pointer dereference that can happen if the UDL
> driver is unloaded before the framebuffer is initialized. This can
> happen e.g. if the USB device is unplugged right after it was plugged
> in.
> 
> As explained by Stéphane Marchesin:
> 
> It happens when fbdev is disabled (which is the case for Chrome OS).
> Even though intialization of the fbdev part is optional (it's done in
> udlfb_create which is the callback for fb_probe()), the teardown isn't
> optional (udl_driver_unload -> udl_fbdev_cleanup ->
> udl_fbdev_destroy).
> 
> Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
> does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
> always set during udl_fbdev_init.
> 
> Suggested-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Emil Lundmark <lndmrk@chromium.org>

You lost the r-b from Sean when resending, I'll leave that to Sean to
readd when he merges. Anyway, lgtm now with the more detailed explanation.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> Changes in v2:
> - Updated commit message with explanation from Stéphane Marchesin
> 
>  drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
> index 2ebdc6d5a76e..5754e37f741b 100644
> --- a/drivers/gpu/drm/udl/udl_fb.c
> +++ b/drivers/gpu/drm/udl/udl_fb.c
> @@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
>  {
>  	drm_fb_helper_unregister_fbi(&ufbdev->helper);
>  	drm_fb_helper_fini(&ufbdev->helper);
> -	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> -	drm_framebuffer_cleanup(&ufbdev->ufb.base);
> -	drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> +	if (ufbdev->ufb.obj) {
> +		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
> +		drm_framebuffer_cleanup(&ufbdev->ufb.base);
> +		drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
> +	}
>  }
>  
>  int udl_fbdev_init(struct drm_device *dev)
> -- 
> 2.17.0.921.gf22659ad46-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

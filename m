Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755010AbeDTNzf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:55:35 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41546 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeDTNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:55:34 -0400
X-Google-Smtp-Source: AIpwx4/2LXrBgYQJm5Pq/p4wZBGvGI2QLcqkqSiwbZLMq56/8A6JqRsjjGVq2vZAyCW2arWRbk1wvA==
Date: Fri, 20 Apr 2018 09:55:32 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Emil Lundmark <lndmrk@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: udl: Destroy framebuffer only if it was initialized
Message-ID: <20180420135532.GH73214@art_vandelay>
References: <20180420115001.161745-1-lndmrk@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420115001.161745-1-lndmrk@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:50:01PM +0200, Emil Lundmark wrote:
> This fixes a NULL pointer dereference that can happen if the UDL
> driver is unloaded before the framebuffer is initialized. This can
> happen e.g. if the USB device is unplugged right after it was plugged
> in.
> 

JFYI, in future, if someone makes a suggestion on how to fix a bug, it's good
practice to add a Suggested-by tag to give credit.

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
> ---
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
> 2.17.0.484.g0c8726318c-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

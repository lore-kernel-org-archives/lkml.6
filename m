Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeDEHUD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:20:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35305 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeDEHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:20:02 -0400
X-Google-Smtp-Source: AIpwx4+//vWbxd9nrLmyVt6NySK4BtmNIRi+8Kicz8KOhVPTLyrBZrVzKTQJbrev4tcOMohRvyj3QA==
Date: Thu, 5 Apr 2018 09:19:57 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Deepak Rawat <drawat@vmware.com>
Cc: dri-devel@lists.freedesktop.org, thellstrom@vmware.com,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] drm: page-flip with damage
Message-ID: <20180405071957.GO3881@phenom.ffwll.local>
Mail-Followup-To: Deepak Rawat <drawat@vmware.com>,
        dri-devel@lists.freedesktop.org, thellstrom@vmware.com,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522885748-67122-1-git-send-email-drawat@vmware.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 04:49:05PM -0700, Deepak Rawat wrote:
> Hi All,
> 
> This is extension to Lukasz Spintzyk earlier draft of damage interface for drm.
> Bascially a new plane property is added called "DAMAGE_CLIPS" which is simply
> an array of drm_rect (exported to userspace as drm_mode_rect). The clips
> represents damage in framebuffer coordinate of attached fb to the plane.
> 
> Helper iterator is added to traverse the damage rectangles and get the damage
> clips in framebuffer, plane or crtc coordinates as need by driver
> implementation. Finally a helper to reset damage in case need full update is
> required. Drivers interested in page-flip with damage should call this from
> atomic_check hook.
> 
> With the RFC for atomic implementation of dirtyfb ioctl I was thinking
> should we need to consider dirty_fb flags, especially
> DRM_MODE_FB_DIRTY_ANNOTATE_COPY to be passed with atomic
> DAMAGE_CLIPS property blob? I didn't considered that untill now. If no driver
> uses that in my opinion for simplicity this can be ignored?

Last time I've checked no driver nor userspace really used this. I'd drop
it for the new uapi like you've done.

> About overlaping of damage rectangles is also not finalized. This really
> depends on driver specific implementation and can be left open-ended?

Overlapping is userspace being stupid imo :-) I guess we should say that
drivers should at least not fall over overlapping rects, and if they can't
handle them, either coalesce into one big rect, or split them on their own
somehow.

> My knowledge is limited to vmwgfx so would like to hear about other driver use
> cases and this can be modified in keeping other drivers need.
> 
> Going forward driver implementation for vmwgfx and user-space implementation
> of kmscube/weston will be next step to test the changes.

I think an implementation for -modesetting and weston would be perfect.
Kmscube has very littel value for damage tracking purposes (it's not a
full compositor, just renders new frame each scene). And for kms I'm not a
fan of using vendor-specific drivers to demonstrate new generic uapi - way
too big chances you're making some vendor driver specific hardcoded
assumption that doesn't hold anywhere else. Also makes it harder for
others to test-implement your uapi in their drivers.
-Daniel

> 
> Thanks,
> Deepak
> 
> Deepak Rawat (2):
>   drm: Add helper iterator functions to iterate over plane damage.
>   drm: Add helper to validate damage during modeset_check
> 
> Lukasz Spintzyk (1):
>   drm: Add DAMAGE_CLIPS property to plane
> 
>  drivers/gpu/drm/drm_atomic.c        |  42 +++++++++
>  drivers/gpu/drm/drm_atomic_helper.c | 173 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c   |   5 ++
>  drivers/gpu/drm/drm_plane.c         |  12 +++
>  include/drm/drm_atomic_helper.h     |  41 +++++++++
>  include/drm/drm_mode_config.h       |  15 ++++
>  include/drm/drm_plane.h             |  16 ++++
>  include/uapi/drm/drm_mode.h         |  15 ++++
>  8 files changed, 319 insertions(+)
> 
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

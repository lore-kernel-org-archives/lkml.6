Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDXRpW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:45:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53044 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeDXRpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:45:19 -0400
X-Google-Smtp-Source: AB8JxZrA/1Hcq7IEiAXB0AZ3wmaq1qTJVyHDPGZoWcWFEJJuSxehpGh8yjikB2J025bm04D+rndjpw==
Date: Tue, 24 Apr 2018 19:45:14 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/1] drm: Add crtc_queue_syncobj and crtc_get_syncobj
 ioctls
Message-ID: <20180424174514.GB25142@phenom.ffwll.local>
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20180406235649.9494-1-keithp@keithp.com>
 <20180409091416.GT31310@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409091416.GT31310@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 11:14:17AM +0200, Daniel Vetter wrote:
> On Fri, Apr 06, 2018 at 04:56:48PM -0700, Keith Packard wrote:
> > (This is an RFC on whether this pair of ioctls seems reasonable. The
> > code compiles, but I haven't tested it as I'm away from home this
> > weekend.)
> > 
> > I'm rewriting my implementation of the Vulkan EXT_display_control
> > extension, which provides a way to signal a Vulkan fence at vblank
> > time. I had implemented it using events, but that isn't great as the
> > Vulkan API includes the ability to wait for any of a set of fences to
> > be signaled. As the other Vulkan fences are implemented using
> > dma_fences in the kernel, and (eventually) using syncobj up in user
> > space, it seems reasonable to use syncobjs for everything and hook
> > vblank to those.
> > 
> > In any case, I'm proposing two new syncobj/vblank ioctls (the names
> > aren't great; suggestions welcome, as usual):
> > 
> > DRM_IOCTL_CRTC_QUEUE_SYNCOBJ
> > 
> > 	Create a new syncobj that will be signaled at (or after) the
> > 	specified vblank sequence value. This uses the same parameters
> > 	to specify the target sequence as
> > 	DRM_IOCTL_CRTC_QUEUE_SEQUENCE.
> 
> My understanding of drm_syncobj is that you:
> 
> - Create a syncobj with the drm_syncobj_create ioctl.
> 
> - Pass it around to various driver callbacks who update the attached
>   dma_fence pointer using drm_syncobj_replace_fence().
> 
> Yes amdgpu does this a bit differently, but that seems to be the
> exception.
> 
> From that pov I'd massage the uapi to just extend
> drm_crtc_queue_sequence_ioctl with a new syncobj flag. Syncobj we can just
> add at the bottom of struct drm_crtc_queue_sequence (drm structs can be
> extended like that, it's part of the uapi). Or we reuse user_data, but
> that's a bit a hack.
> 
> We also don't need a new event type, vblank code simply singals
> event->fence, which we'll arrange to be the fence behind the syncobj.
> 
> > DRM_IOCTL_CRTC_GET_SYNCOBJ
> > 
> > 	Once the above syncobj has been signaled, this ioctl allows
> > 	the application to find out when that happened, returning both
> > 	the vblank sequence count and time (in ns).
> 
> The android syncpt stuff already had the concept of a fence timestamp, and
> we carried it over as part of struct dma_fence.timestamp. It's just not
> exposed yet as proper uapi. I think we should aim a bit more into that
> direction with something like the below sketch:
> 
> - Add a dma_fence_signal_ts, which allows us to set the timestamp from a
>   hw clock.
> 
> - Use that in the vblank code.
> 
> - Add new drm_syncobj ioctl to query the timestamp of the attached fence
>   (if it's signalled).
> 
> That would entirely avoid the special-case ioctl just for vblank syncobj
> here. Also, this might be useful in your implementation of
> VK_GOOGLE_display_timing, since the current query timestamp you're using
> won't take into account irq wakeup latency. Using fence->timestamp will
> still miss the irq->atomic worker wakupe latency, but should be a lot
> better already.

Ok, I'm going to retract my entire suggestion above for the GET ioctl. It
would neatly work for vk_google_display_timing, but the KHR version of
that extensions very much sounds like we want the kernel to report 2 (or
maybe even 3) different timestamps back. An ioctl is much easier to extend
than shoe-horning all that into the dma_fence/drm_syncobj abstraction.

One bikeshed maybe on top: Maybe call the ioctl CRTC_GET_TS_DATA, since
that's what you're getting, not the syncobj.

Sorry for flopping around on this, just learned this all in discussions
past week.
-Daniel

> 
> > I'd like to hear comments on whether this seems reasonable, or whether
> > I should go in some other direction.
> 
> Besides a few bikesheds to align better with other stuff going around I
> think this looks good.
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

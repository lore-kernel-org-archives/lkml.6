Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeDGACV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 20:02:21 -0400
Received: from home.keithp.com ([63.227.221.253]:56916 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbeDGACU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 20:02:20 -0400
From: Keith Packard <keithp@keithp.com>
To: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/1] drm: Add crtc_queue_syncobj and crtc_get_syncobj ioctls
Date: Fri,  6 Apr 2018 16:56:48 -0700
Message-Id: <20180406235649.9494-1-keithp@keithp.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is an RFC on whether this pair of ioctls seems reasonable. The
code compiles, but I haven't tested it as I'm away from home this
weekend.)

I'm rewriting my implementation of the Vulkan EXT_display_control
extension, which provides a way to signal a Vulkan fence at vblank
time. I had implemented it using events, but that isn't great as the
Vulkan API includes the ability to wait for any of a set of fences to
be signaled. As the other Vulkan fences are implemented using
dma_fences in the kernel, and (eventually) using syncobj up in user
space, it seems reasonable to use syncobjs for everything and hook
vblank to those.

In any case, I'm proposing two new syncobj/vblank ioctls (the names
aren't great; suggestions welcome, as usual):

DRM_IOCTL_CRTC_QUEUE_SYNCOBJ

	Create a new syncobj that will be signaled at (or after) the
	specified vblank sequence value. This uses the same parameters
	to specify the target sequence as
	DRM_IOCTL_CRTC_QUEUE_SEQUENCE.

DRM_IOCTL_CRTC_GET_SYNCOBJ

	Once the above syncobj has been signaled, this ioctl allows
	the application to find out when that happened, returning both
	the vblank sequence count and time (in ns).

I'd like to hear comments on whether this seems reasonable, or whether
I should go in some other direction.
